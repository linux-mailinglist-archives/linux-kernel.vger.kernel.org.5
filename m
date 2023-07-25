Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 961B4762025
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 19:30:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232004AbjGYR37 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 13:29:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjGYR36 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 13:29:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B4C319B4;
        Tue, 25 Jul 2023 10:29:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E4E68617EF;
        Tue, 25 Jul 2023 17:29:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3329C433C9;
        Tue, 25 Jul 2023 17:29:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690306196;
        bh=TfpCv+i5rtY7RVy/weOVjUhYO1z2fnvqOS/4UZwcLOc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nvfdk29umM+ZEQFb+vtQ/PP/yjDnfxIlwP1hHzZibxKdCjvBcghsA+YqrHL+FBnT8
         6H8ylJWIiODSP+nmo1M6OiNXfh066OUz0qfzPAWsM7HNk93wbOM5z85e92a4hNt7JF
         t0cYs5b7n91J4RJyJxnjUShggiMWSUYX0yQ7xxYU=
Date:   Tue, 25 Jul 2023 19:29:53 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Tony Lindgren <tony@atomide.com>
Cc:     Andy Shevchenko <andriy.shevchenko@intel.com>,
        Jiri Slaby <jirislaby@kernel.org>, Dhruva Gole <d-gole@ti.com>,
        Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        John Ogness <john.ogness@linutronix.de>,
        Johan Hovold <johan@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: Update TTY layer for lists and recently
 added files
Message-ID: <2023072530-wired-chaps-c1e3@gregkh>
References: <20230721072334.59272-1-tony@atomide.com>
 <ZLpboaXKVOOjeGJ+@smile.fi.intel.com>
 <20230724045327.GV5194@atomide.com>
 <2023072517-onward-payment-569d@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2023072517-onward-payment-569d@gregkh>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 25, 2023 at 07:28:46PM +0200, Greg Kroah-Hartman wrote:
> On Mon, Jul 24, 2023 at 07:53:27AM +0300, Tony Lindgren wrote:
> > * Andy Shevchenko <andriy.shevchenko@intel.com> [230721 10:19]:
> > > On Fri, Jul 21, 2023 at 10:23:32AM +0300, Tony Lindgren wrote:
> > > > Add mailing lists for linux-serial and lkml for the TTY layer. And let's
> > > > list the recently added files. This makes it easier for get_maintainer.pl
> > > > to include linux-serial for patches.
> > > 
> > > Shouldn't serial_* stuff go to the "SERIAL DRIVERS" section?
> > 
> > Not sure if there's some reason we have "TTY LAYER" with serial_core
> > files. If not, yeah let's move the serial files.
> 
> I'll take this patch, can you send a new one that removes the serial
> files from this entry as I don't think they are needed in here anymore.

Better yet, they should be merged probably.  Although I don't know if
Jiri wants to be responsible for serial stuff, that's his call...

thanks,

greg k-h

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEE417D5393
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 16:01:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343600AbjJXOBi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 10:01:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234097AbjJXOBh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 10:01:37 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94EEBE9;
        Tue, 24 Oct 2023 07:01:35 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E965C433C8;
        Tue, 24 Oct 2023 14:01:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698156095;
        bh=JaZucYdFog+3ymO/+M3SCTPKgRRUFH4pH2p6FHRD4QE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=2ARvkn9ke5f/tQRyUR6/C4gSLyeWWwbzqmlYkYw4UJ8rx7s47KMb7Al8lcz5mY4DC
         5NOxwiTk0/VTQHdVBSHM8hi3+4cXbMbJChwQdEWPLmtdVcDT2GMAjSnFPNWDDEcxVX
         omaanwAA69QQFx+P3QUuXBwvUEtUZzoaLjKq4KIg=
Date:   Tue, 24 Oct 2023 16:01:32 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Tony Lindgren <tony@atomide.com>
Cc:     Jiri Slaby <jirislaby@kernel.org>, Rob Herring <robh@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Dhruva Gole <d-gole@ti.com>,
        Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        John Ogness <john.ogness@linutronix.de>,
        Johan Hovold <johan@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        Maximilian Luz <luzmaximilian@gmail.com>
Subject: Re: [RFC PATCH 1/2] serial: core: Move tty and serdev to be children
 of serial core port device
Message-ID: <2023102442-statue-kept-febc@gregkh>
References: <20231024113624.54364-1-tony@atomide.com>
 <2023102401-playtime-moonrise-6f05@gregkh>
 <20231024122955.GL34982@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231024122955.GL34982@atomide.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 24, 2023 at 03:29:55PM +0300, Tony Lindgren wrote:
> * Greg Kroah-Hartman <gregkh@linuxfoundation.org> [231024 11:52]:
> > What does this change the sysfs tree to look like?
> 
> On x86 qemu for the ttys:
> 
> # find /sys -name tty
> /sys/class/tty
> /sys/class/tty/tty
> /sys/devices/pnp0/00:04/00:04:0/00:04:0.0/tty
> /sys/devices/platform/serial8250/serial8250:0/serial8250:0.3/tty
> /sys/devices/platform/serial8250/serial8250:0/serial8250:0.1/tty
> /sys/devices/platform/serial8250/serial8250:0/serial8250:0.2/tty
> /sys/devices/virtual/tty
> /sys/devices/virtual/tty/tty

A diff of before vs. after would make more sense for those of us who
don't have your same system configuration :)

thanks,

greg k-h

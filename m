Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01D5375BE18
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 08:00:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229744AbjGUGAI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 02:00:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbjGUGAG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 02:00:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41DDCE62;
        Thu, 20 Jul 2023 23:00:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B855261013;
        Fri, 21 Jul 2023 06:00:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41CF0C433C8;
        Fri, 21 Jul 2023 06:00:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689919202;
        bh=zu9FYK43ofiPCrMrbpw4Rr/H/foM7pthBpajMqQAoe8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZftGg7slPKtwO0TDo885FC8rgAIqGhp7dey9vASKtdNKchTRiNVzRsl3VdoV4D1jQ
         2Y429gDVZdkge4vhGNUsb9pu30NqE9qZWu0C+/eTXYRkaCkW/kPD21PPy9sCUb2bT/
         46OEvBC8yKo4v/Q7VwMcvkkvMXWx+975VebvOGnM=
Date:   Fri, 21 Jul 2023 08:00:00 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Tony Lindgren <tony@atomide.com>
Cc:     Jiri Slaby <jirislaby@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Dhruva Gole <d-gole@ti.com>,
        Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        John Ogness <john.ogness@linutronix.de>,
        Johan Hovold <johan@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] serial: core: Controller id cannot be negative
Message-ID: <2023072144-splurge-debate-e681@gregkh>
References: <20230720051021.14961-1-tony@atomide.com>
 <20230720051021.14961-2-tony@atomide.com>
 <2023072022-country-replace-68ca@gregkh>
 <20230721054326.GO5194@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230721054326.GO5194@atomide.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 21, 2023 at 08:43:26AM +0300, Tony Lindgren wrote:
> * Greg Kroah-Hartman <gregkh@linuxfoundation.org> [230720 19:33]:
> > On Thu, Jul 20, 2023 at 08:10:14AM +0300, Tony Lindgren wrote:
> > > The controller id cannot be negative.
> > > 
> > 
> > What does this mean for a changelog?
> 
> Just let's fix it while at it and adding port_id in the following patch.
> If you prefer I can squash the change into the fix adding port_id.

A separate patch like this is fine, just properly document it please :)

thanks,

greg k-h

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 276CC7D4F40
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 13:52:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231433AbjJXLwZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 07:52:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232461AbjJXLwY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 07:52:24 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7B09C1;
        Tue, 24 Oct 2023 04:52:22 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF3B5C433C8;
        Tue, 24 Oct 2023 11:52:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698148342;
        bh=1AtkwXmqxTgRaQsRN4z6we2958oGeHE/fEu9KMk8/js=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oUN1cBvSqnotcbu8SXs81255s5ZTlXR+hg/atviUc1DgWhqAK7W7iUB8EoeXnsL4r
         YpIOCB1NSztz7K/5oyZxztjT//+mIvDm8D6ViMBXrZW+6WAQw4i/zbmNyG5VRsRke1
         WK95D8mCK9Bl4/zxh/7mont4ItUsCsh4Hk5kMMu8=
Date:   Tue, 24 Oct 2023 13:52:19 +0200
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
Message-ID: <2023102401-playtime-moonrise-6f05@gregkh>
References: <20231024113624.54364-1-tony@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231024113624.54364-1-tony@atomide.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 24, 2023 at 02:36:18PM +0300, Tony Lindgren wrote:
> Let's move tty and serdev controller to be children of the serial core port
> device. This way the runtime PM usage count of a child device propagates
> to the serial hardware device.
> 
> The tty and serdev devices are associated with a specific serial port of
> a serial hardware controller device, and we now have serial core hierarchy
> of controllers and ports.
> 
> The tty device moves happily with just a change of the parent device.
> The serdev device init needs some changes to separate the serial hardware
> controller device from the parent device.
> 

What does this change the sysfs tree to look like?

No objection from me, just curious.

thanks,

greg k-h

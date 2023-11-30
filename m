Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F01197FEDFE
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 12:33:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345216AbjK3LdX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 06:33:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345224AbjK3LdA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 06:33:00 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29DD31716
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 03:32:59 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C525DC433C9;
        Thu, 30 Nov 2023 11:32:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701343978;
        bh=qTJ5CJoxngZ864cBMLPrwV2wlcGmJbDNuq1mr3WFzDI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RCkfYk3BAuIpqcud4Kmfw1Fx39QPJWDeDBsra1dQTnHY6brJEnvEYpA6/MZ8G6Nd2
         Sv2el6DGy5OpqqXy6SLuKb5C2wm3436zKFc63hJyce/JI8mYd2Xar50vEU1+5cgFBa
         ZpkN/J1G1wgUuo5Nyd+hMvnMwxRYCPS5JOltj34FONnRKPKPdDUjYR6jteNsS80HBA
         38xz5mScgMzM+TRUy1BOTeO5oG5Pc55LLRWs+btNGkyichuFl2A1tMi/mpA1EOX2na
         DZdkwT2/A+I4KD1c+FSnhh0kdspa78Q6CK20bk/Vr0jtn4XIX56xkY+jjIfm0ljLI6
         34IwxDWnEvM2w==
Date:   Thu, 30 Nov 2023 11:32:54 +0000
From:   Lee Jones <lee@kernel.org>
To:     Jisheng Zhang <jszhang@kernel.org>
Cc:     Pavel Machek <pavel@ucw.cz>, linux-leds@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] leds: Expand led_colors[] array
Message-ID: <20231130113254.GI1470173@google.com>
References: <20231030054757.3476-1-jszhang@kernel.org>
 <20231123105620.GG1184245@google.com>
 <ZWS80c/ZQvaGIM96@xhacker>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZWS80c/ZQvaGIM96@xhacker>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Nov 2023, Jisheng Zhang wrote:

> On Thu, Nov 23, 2023 at 10:56:20AM +0000, Lee Jones wrote:
> > On Mon, 30 Oct 2023, Jisheng Zhang wrote:
> > 
> > > commit 472d7b9e8141 ("dt-bindings: leds: Expand LED_COLOR_ID
> > > definitions") expands LED_COLOR_ID definitions for dt-binding. However,
> > > it doesn't expand the led_colors[] array in leds core, so if any of
> > > the newly expaned LED_COLOR_ID definitions is used, the sysfs will
> > > emit null in the led's name color part. Let's expand the led_colors[]
> > > array too.
> > > 
> > > Before the commit:
> > > /sys/class/leds # ls
> > > (null):indicator-0
> > > 
> > > After the commit:
> > > /sys/class/leds # ls
> > > orange:indicator-0
> > > 
> > > Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> > > ---
> > >  drivers/leds/led-core.c | 5 +++++
> > >  1 file changed, 5 insertions(+)
> > 
> > This already exists as:
> > 
> >   a067943129b4e leds: core: Add more colors from DT bindings to led_colors
> 
> well, my patch was sent earlier than this one... When I sent out the
> patch there's neither fix in mailist nor in your repo.

What makes you think that?

The applied patch was submitted 8th October.

https://lore.kernel.org/all/20231008144014.1180334-1-megi@xff.cz/

Yours was submitted 30th October, 3 weeks later.

https://lore.kernel.org/all/20231030054757.3476-1-jszhang@kernel.org/

-- 
Lee Jones [李琼斯]

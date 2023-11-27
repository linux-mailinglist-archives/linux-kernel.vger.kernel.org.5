Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81EA17FA5C8
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 17:11:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234406AbjK0QLd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 11:11:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234322AbjK0QLb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 11:11:31 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3314FBF
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 08:11:38 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD929C433C7;
        Mon, 27 Nov 2023 16:11:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701101497;
        bh=1eC3B85c/WTIXCxPORwzEkxtZ2OPGRmGdBSkCRXeP/M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=W4stbp0/23OAp1nKC52N6XJrhGA+YUTis67TYG+h5O946UkapWE4UYfWhZ1z/bD+0
         f6w864ZJ3xYwpf/2TvBd6tLimWISRUHD5EK3pX1CjO5aF3MXUf//qeMVkhQex5VxhN
         X/oai6B7w5sh7x4peTRRYwxbH6o+3uWWn+qmLyZuvBeQlv49FiCl5CSmzUCRMjejtQ
         eTma3mvnaMfaoGYrTsWMITtrK1q2gkCv3HnegRO9q6nek+J6AhTTUKcNg4ef1Gx8g+
         eeCXrLR3qK1DbGWYk35/Loa6zPZulwdb8WJFURUsVjd2b/Y0gT8DaV8RfwRKo1fyGj
         Uo0VJPx3l3e2A==
Date:   Mon, 27 Nov 2023 23:59:13 +0800
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Lee Jones <lee@kernel.org>
Cc:     Pavel Machek <pavel@ucw.cz>, linux-leds@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] leds: Expand led_colors[] array
Message-ID: <ZWS80c/ZQvaGIM96@xhacker>
References: <20231030054757.3476-1-jszhang@kernel.org>
 <20231123105620.GG1184245@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231123105620.GG1184245@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 23, 2023 at 10:56:20AM +0000, Lee Jones wrote:
> On Mon, 30 Oct 2023, Jisheng Zhang wrote:
> 
> > commit 472d7b9e8141 ("dt-bindings: leds: Expand LED_COLOR_ID
> > definitions") expands LED_COLOR_ID definitions for dt-binding. However,
> > it doesn't expand the led_colors[] array in leds core, so if any of
> > the newly expaned LED_COLOR_ID definitions is used, the sysfs will
> > emit null in the led's name color part. Let's expand the led_colors[]
> > array too.
> > 
> > Before the commit:
> > /sys/class/leds # ls
> > (null):indicator-0
> > 
> > After the commit:
> > /sys/class/leds # ls
> > orange:indicator-0
> > 
> > Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> > ---
> >  drivers/leds/led-core.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> 
> This already exists as:
> 
>   a067943129b4e leds: core: Add more colors from DT bindings to led_colors

well, my patch was sent earlier than this one... When I sent out the
patch there's neither fix in mailist nor in your repo.

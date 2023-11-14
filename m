Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D0707EB50E
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 17:42:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233739AbjKNQmk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 11:42:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229822AbjKNQmj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 11:42:39 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D0B6116;
        Tue, 14 Nov 2023 08:42:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=WCge2m1CuTOpBl3S/9gCrC4dvJqJV+FxfrGYoOBjQhI=; b=u/t/vJVf445xOegXlqC4jLpzMK
        JNycE1HC/v8VuxfHQVTGJCOT7WQz2SxRvVwM9T9LVY9cplPA7n37R+PLO3cMmHw1cVZD2A97XbqwI
        VvMY+CdABYJ5T7snAp02DkWOCYuSSklnQyyirDY1IdYy4cI5GZsAWigh/QesXnJoBjbUKThGXPfM2
        584230XSxPu5ese8HIxId3wZOFvTbkfkIN37y5pUJA1LcRwut6iL6wNfoMfdOgyBKCYZqovxRVYmd
        wfuQrDORDyVBPMAy/vm4RPjBQxdWDYuOJL1P5i8uzzQXFtRUxqSPV/4MeZc0CFds3tj5hbATN73XR
        IES81Olw==;
Received: from [50.53.46.231] (helo=[192.168.254.15])
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1r2wUj-00GRt0-22;
        Tue, 14 Nov 2023 16:42:34 +0000
Message-ID: <380a8838-d37a-494d-8150-78f49b46392d@infradead.org>
Date:   Tue, 14 Nov 2023 08:42:31 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] clocksource: timer-ti-dm: Fix make W=n kerneldoc warnings
Content-Language: en-US
To:     Tony Lindgren <tony@atomide.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        kernel test robot <lkp@intel.com>
References: <20231114072930.40615-1-tony@atomide.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20231114072930.40615-1-tony@atomide.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/13/23 23:29, Tony Lindgren wrote:
> Kernel test robot reports of kerneldoc related warnings that happen with
> make W=n for "parameter or member not described".
> 
> These were caused by changes to function parameter names with
> earlier commits where the kerneldoc parts were not updated.
> 
> Fixes: 49cd16bb573e ("clocksource/drivers/timer-ti-dm: Simplify register writes with dmtimer_write()")
> Fixes: a6e543f61531 ("clocksource/drivers/timer-ti-dm: Move struct omap_dm_timer fields to driver")
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202311040403.DzIiBuwU-lkp@intel.com/
> Closes: https://lore.kernel.org/oe-kbuild-all/202311040606.XL5OcR9O-lkp@intel.com/
> Signed-off-by: Tony Lindgren <tony@atomide.com>

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> ---
>  drivers/clocksource/timer-ti-dm.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/clocksource/timer-ti-dm.c b/drivers/clocksource/timer-ti-dm.c
> --- a/drivers/clocksource/timer-ti-dm.c
> +++ b/drivers/clocksource/timer-ti-dm.c
> @@ -183,7 +183,7 @@ static inline u32 dmtimer_read(struct dmtimer *timer, u32 reg)
>   * dmtimer_write - write timer registers in posted and non-posted mode
>   * @timer:      timer pointer over which write operation is to perform
>   * @reg:        lowest byte holds the register offset
> - * @value:      data to write into the register
> + * @val:        data to write into the register
>   *
>   * The posted mode bit is encoded in reg. Note that in posted mode, the write
>   * pending bit must be checked. Otherwise a write on a register which has a
> @@ -949,7 +949,7 @@ static int omap_dm_timer_set_int_enable(struct omap_dm_timer *cookie,
>  
>  /**
>   * omap_dm_timer_set_int_disable - disable timer interrupts
> - * @timer:	pointer to timer handle
> + * @cookie:	pointer to timer cookie
>   * @mask:	bit mask of interrupts to be disabled
>   *
>   * Disables the specified timer interrupts for a timer.

-- 
~Randy

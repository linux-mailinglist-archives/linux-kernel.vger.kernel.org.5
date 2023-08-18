Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D77617809B2
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 12:09:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359666AbjHRKJP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 06:09:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359665AbjHRKIk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 06:08:40 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C4CE35AC
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 03:08:06 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-3fe45481edfso7186525e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 03:08:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692353211; x=1692958011;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Lv+abx3QslGUToUb7vrRoug6JE3seu3NREsfOC/kEXo=;
        b=wxBr7P0QZmtmISzuXDXdgRfFhn+K3ceIA5ful2/bkKogmWFfEg4BN2B3yTOCJEU/uD
         ke4BAKo+cU0CHmiGV2FVxTcgSo1vCJDr8MCx1l7PVOMQ/AEPdOk/8gDWDp24jtam+PgJ
         kn05bDVjpzmNozWUSgVYqa1TA4CTX9B1xhLcxj2QrEbDtWS1qnCRWu2wT1K9p0liSKPO
         UuYV9tLh6BLckNIX20BSW3EXqkSVq7qUXgsewcT0eQePEcBf5kC/T1tZEs2ytTbIl1Iq
         im+Z438XNmcS/Rba7Krt7L4EFwE4s+Fdgg0WOPf//fN1krGnen1O2ktUwjpjLn/8StF7
         qLVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692353211; x=1692958011;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Lv+abx3QslGUToUb7vrRoug6JE3seu3NREsfOC/kEXo=;
        b=bTVVXeGaN6/TFM6tiXjsXJ7eLul2dMpmp8Y2dFZx2yMaRat75eI9h0T5SAka5gyk52
         uErt1ukLATELr/UlkGOhoG/ZcxP0GR2QbeMzP/2ITZUPm/okkFc5wOJcNcHAv/jOk90k
         ddN5hagCGRRUGaiNwgb81wOWfn76SsLdT0nIqsjm5BDShWmlRVxGEyenbc0lPLIOkJdb
         NxNpHHqIp1CF6XUDPOocX+yttns7BgmCupa1r8CT5i5xgGi6589ceIr2dfgj/CTVgSSG
         IkNCevDnLr1QiibfK2TwGtwNWOs89klcfptcn+Bpkh7IWoGGuVr/xcVrOWPnBt9Y+ykJ
         nIlg==
X-Gm-Message-State: AOJu0Yw1c7oGVNQX67llq5c+r13Yz3qPeIxVC67YcRV//wRccIj2/CYV
        tBqfX8xJmMLnKHdnFoELaPY3fKvGJSy3Z8QGF2M=
X-Google-Smtp-Source: AGHT+IFzWYJ6guNyIaVwmBfXsC7UfY0AV5H0XFxUUmTuqKkczLtSuqqAl+UGrkLoNy/+K3owMK1lWw==
X-Received: by 2002:adf:e50b:0:b0:317:57f0:fae with SMTP id j11-20020adfe50b000000b0031757f00faemr1627817wrm.63.1692353211029;
        Fri, 18 Aug 2023 03:06:51 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id k10-20020adfe8ca000000b003198d274208sm2250783wrn.86.2023.08.18.03.06.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Aug 2023 03:06:50 -0700 (PDT)
Message-ID: <48283a14-d2af-630c-40c0-d0316cd30d69@linaro.org>
Date:   Fri, 18 Aug 2023 12:06:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] clocksource/drivers/arm_arch_timer: Disable timer before
 programming CVAL
Content-Language: en-US
To:     =?UTF-8?B?V2FsdGVyIENoYW5nICjlvLXntq3lk7Ip?= 
        <Walter.Chang@mediatek.com>, "maz@kernel.org" <maz@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        wsd_upstream <wsd_upstream@mediatek.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        =?UTF-8?B?Q2h1bi1IdW5nIFd1ICjlt6vpp7/lro8p?= 
        <Chun-hung.Wu@mediatek.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        =?UTF-8?B?U3RhbmxleSBDaHUgKOacseWOn+mZnik=?= 
        <stanley.chu@mediatek.com>,
        =?UTF-8?B?RnJlZGR5IEhzaW4gKOi+m+aBkuixkCk=?= 
        <Freddy.Hsin@mediatek.com>
References: <20230717090735.19370-1-walter.chang@mediatek.com>
 <9c428d54c07f60e79c63119621bf03b797f79a37.camel@mediatek.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <9c428d54c07f60e79c63119621bf03b797f79a37.camel@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/08/2023 11:29, Walter Chang (張維哲) wrote:
> On Mon, 2023-07-17 at 17:07 +0800, walter.chang@mediatek.com wrote:
>> From: Walter Chang <walter.chang@mediatek.com>
>> 
>> Due to the fact that the use of `writeq_relaxed()` to program CVAL is
>> not guaranteed to be atomic, it is necessary to disable the timer
>> before
>> programming CVAL.
>> 
>> However, if the MMIO timer is already enabled and has not yet
>> expired,
>> there is a possibility of unexpected behavior occurring: when the CPU
>> enters the idle state during this period, and if the CPU's local
>> event
>> is earlier than the broadcast event, the following process occurs:
>> 
>> tick_broadcast_enter()
>>   tick_broadcast_oneshot_control(TICK_BROADCAST_ENTER)
>>     __tick_broadcast_oneshot_control()
>>       ___tick_broadcast_oneshot_control()
>>         tick_broadcast_set_event()
>>           clockevents_program_event()
>>             set_next_event_mem()
>> 
>> During this process, the MMIO timer remains enabled while programming
>> CVAL. To prevent such behavior, disable timer explicitly prior to
>> programming CVAL.
>> 
>> Fixes: 8b82c4f883a7 ("clocksource/drivers/arm_arch_timer: Move MMIO
>> timer programming over to CVAL")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Walter Chang <walter.chang@mediatek.com>
>> ---
>>  drivers/clocksource/arm_arch_timer.c | 7 +++++++
>>  1 file changed, 7 insertions(+)
>> 
>> diff --git a/drivers/clocksource/arm_arch_timer.c
>> b/drivers/clocksource/arm_arch_timer.c
>> index e733a2a1927a..7dd2c615bce2 100644
>> --- a/drivers/clocksource/arm_arch_timer.c
>> +++ b/drivers/clocksource/arm_arch_timer.c
>> @@ -792,6 +792,13 @@ static __always_inline void
>> set_next_event_mem(const int access, unsigned long e
>>  u64 cnt;
>>  
>>  ctrl = arch_timer_reg_read(access, ARCH_TIMER_REG_CTRL, clk);
>> +
>> +/* Timer must be disabled before programming CVAL */
>> +if (ctrl & ARCH_TIMER_CTRL_ENABLE) {
>> +ctrl &= ~ARCH_TIMER_CTRL_ENABLE;
>> +arch_timer_reg_write(access, ARCH_TIMER_REG_CTRL, ctrl,
>> clk);
>> +}
>> +
>>  ctrl |= ARCH_TIMER_CTRL_ENABLE;
>>  ctrl &= ~ARCH_TIMER_CTRL_IT_MASK;
>>  
> 
> Gentle ping for this patch.

Applied, thanks

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


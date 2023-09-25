Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FAF67ADAA5
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 16:53:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232430AbjIYOxV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 10:53:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232686AbjIYOxM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 10:53:12 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61934192
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 07:53:00 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2bb9a063f26so107906551fa.2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 07:53:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1695653578; x=1696258378; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=12lvvZVko7HwcFd7BVr7FRaCYZcG3/6yf/N02oFBsK8=;
        b=znnFwVGn+zck2eznawy53HuyrlhwhEcgK90aK6K8nOemWEjHO5lc1uOQYuVTiZaTwf
         shGOESxGUXmzoqCzqUkLzDn5KjK/kGSnjqkLWxL/rrgzkK7axQq9kJT62xROgrazZV8L
         Er9u6sq3F1fGoca3K4gY33FCwvRvS2VO3gsjnyOX90CiRsCfrQkRbHgXeXP6tzQFH7Ic
         x48he8NVvebbENIMVc2Bjkgu3WOkf/3YSW5jR4CaJkI4uxu0tsktnlNbIuqq8ZSO/8Ac
         22Xwd0Mlnot3pcqemqLyIbSQfGHee6RYyUB1DJbYhIDvseBqgQtMD+SX4pPm65govz9u
         /06g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695653578; x=1696258378;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=12lvvZVko7HwcFd7BVr7FRaCYZcG3/6yf/N02oFBsK8=;
        b=M1kitVELBoXkg/HVz+gKIatlACQYbVJ88umenxMh+XbpbhkixgvVVP939oFYXPHhHG
         QbVmzmirG1L7ZQkIxrNbPeoEE3BDiWfvXR+tqGesG/DzB5M6skseNabpeSqW8Sp1YEZ6
         A5IITwvWfpTWkwNPXYjIvWqTHGKeOkpz5eH7rjWU+e+1om6OWByYGqgO3/4jRaFntKM5
         dKoH1b82R695j0JHFtHMWbY9esB6Q1jN7CwWj0RsKv4rSMcgLRk9/0B3DYrwYH3yJ1I/
         MIdK/lXdijK0lMwZ9WMnAP2GMdW+l0GnIt4UU8m9tAjXPD0yTK9AX1UPuOHGdEcEOVGu
         ISbQ==
X-Gm-Message-State: AOJu0YyX/3duTI80rMbZpHciHZW08LNOIIl6xYvwu1OLRHrAfblKJ4Gy
        KGk2fyeZr2HMAdSGGeNhyIo1Lg==
X-Google-Smtp-Source: AGHT+IFDQpUk2VXmAw55MR/ZBzMc5xEwHe1FQv75sipuCMabU5D0JcaGYP7gRdWeBjtjiRNoVPTmdA==
X-Received: by 2002:a2e:984e:0:b0:2bc:eceb:6a4b with SMTP id e14-20020a2e984e000000b002bceceb6a4bmr5683898ljj.28.1695653578381;
        Mon, 25 Sep 2023 07:52:58 -0700 (PDT)
Received: from [192.168.1.172] ([93.5.22.158])
        by smtp.gmail.com with ESMTPSA id md1-20020a170906ae8100b009a1be9c29d7sm6455357ejb.179.2023.09.25.07.52.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Sep 2023 07:52:57 -0700 (PDT)
Message-ID: <a16e1b9e-06b7-0dce-124e-f13c672d779d@baylibre.com>
Date:   Mon, 25 Sep 2023 16:52:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v4 2/5] thermal/drivers/mediatek/lvts_thermal: Add suspend
 and resume
Content-Language: en-US
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        =?UTF-8?Q?Bernhard_Rosenkr=c3=a4nzer?= <bero@baylibre.com>,
        rafael@kernel.org, amitk@kernel.org, rui.zhang@intel.com,
        matthias.bgg@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, rdunlap@infradead.org,
        ye.xingchen@zte.com.cn, p.zabel@pengutronix.de
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        wenst@chromium.org, james.lo@mediatek.com,
        rex-bc.chen@mediatek.com, nfraprado@collabora.com,
        abailon@baylibre.com, khilman@baylibre.com
References: <20230530195132.2286163-1-bero@baylibre.com>
 <20230530195132.2286163-3-bero@baylibre.com>
 <371790cd-5a7c-8fa6-cc38-3a3680525092@collabora.com>
 <b544e079-c9de-23d3-80f7-cff89293eeb5@linaro.org>
From:   Alexandre Mergnat <amergnat@baylibre.com>
In-Reply-To: <b544e079-c9de-23d3-80f7-cff89293eeb5@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 23/08/2023 09:48, Daniel Lezcano wrote:
> On 31/05/2023 10:05, AngeloGioacchino Del Regno wrote:
> 
> [ ... ]
> 
>>>   static const struct lvts_ctrl_data mt8195_lvts_mcu_data_ctrl[] = {
>>>       {
>>>           .cal_offset = { 0x04, 0x07 },
>>> @@ -1268,6 +1300,8 @@ MODULE_DEVICE_TABLE(of, lvts_of_match);
>>>   static struct platform_driver lvts_driver = {
>>>       .probe = lvts_probe,
>>>       .remove = lvts_remove,
>>> +    .suspend = lvts_suspend,
>>
>> Should we do that in noirq handlers?
>> We're risking to miss a thermal interrupt.
> 
> I'm not sure missing a thermal interrupt is a problem in this context 
> but we may go in the irq routine with an undefined state sensor setup 
> (eg. the internal clock stopped in the suspend and then read the sensor 
> in the isr).
> 
> IMO, using suspend_noirq and resume_noirq may be required here.
> 
> Alexandre are you taking over the next iteration?
> 
> 

Hi Daniel,

Sorry I missed your message...
I don't think taking over the next iteration, Bernhard should continue. 
Let me check internally to be sure. As I understood, the next change 
should be heavy.

-- 
Regards,
Alexandre

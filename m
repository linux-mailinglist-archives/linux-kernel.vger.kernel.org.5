Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3946C75E123
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jul 2023 12:13:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229578AbjGWKND (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jul 2023 06:13:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbjGWKMz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jul 2023 06:12:55 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3630CE6
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jul 2023 03:12:52 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-3fbc244d384so26206145e9.0
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jul 2023 03:12:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690107170; x=1690711970;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BEgvBTwL2MyevdtU3fvRfq/aq6oqUR4xFaMQ6+/3+Dw=;
        b=MlxfssDoiZeCCc1hfQfLncVCxJNbaoto3CAfuLRXQ7TL4fsC1/4sHePjetyHdovpPF
         GPvXA9b47AxJlRGBA40U/cLr6SyCZIhtn8EWWU+TT9aurr4gz2EfBYMXaBg7njvMcspi
         67CLSfQz5x8kooisKa219yLA/WZkTAE0nOccu1Hd7lJtFGCeQqQWwwetO2LEXlg/zCMs
         Ljjzlt38LZyK7JZCCnh8cRiT6laSOrFfWJe8v1ZK78grDOqQOIrXTeFwO36LK8+UHlCU
         oXu/wrwMstyQrR1VHDd+c6BP5ic3hD/+NnRLYRHN1YKcHD4q3qrTvU8XavJm2WEf6cvI
         YbDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690107170; x=1690711970;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BEgvBTwL2MyevdtU3fvRfq/aq6oqUR4xFaMQ6+/3+Dw=;
        b=Zs/Fz9H/V00GvB8icBMd7UbtozX0Jbrok1RV4oEOftEPDaplfGZC2TL64ApUxKCVZf
         0TOAuoHreOkaWep0FF7OI7Ndnrx6tdVZJzC7meVQEBIpYVnDCRjIqaIlDwcTwYnvNU45
         BQPDy7M7NRBpbHFtid98WWcwvsa2NNBlUkdA5fddH1lZitRmgUg8FlE9stGWX0HTv9UJ
         wwyn/zSlayfLxG/wo+TrZJ3DJIeIwE9da5CrC8itsPZCxBpNBBcrUAHCBeX8hlBxi3yN
         SmYpY5Nc8ZWelf+6QVZnPCZ0LYVTMPULbh2+CBlGqoN1DsJYRheVljiJd9TD0d9oJGS3
         NP5w==
X-Gm-Message-State: ABy/qLZ32zyzpLYfY/3dSEjYSilxijsugzQGgY8CNYCVW5wPrzAC8GLE
        NWy3xDA1mQ5z0uwpzkOKBeRhVJfcMvSCENsodvE=
X-Google-Smtp-Source: APBJJlFclljmtLvrx3OH6OGPme7VeGnFSSo5I5l4mYQuISKyF2Zv98JlqeoiTbq6AdakcgbUjTmNNA==
X-Received: by 2002:a05:600c:2a54:b0:3fb:ff57:1750 with SMTP id x20-20020a05600c2a5400b003fbff571750mr4850793wme.32.1690107170636;
        Sun, 23 Jul 2023 03:12:50 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id 3-20020a05600c234300b003fbaa2903f4sm7366620wmq.19.2023.07.23.03.12.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 23 Jul 2023 03:12:50 -0700 (PDT)
Message-ID: <6d1c0915-1485-d9d6-9fff-0413fb16bd3f@linaro.org>
Date:   Sun, 23 Jul 2023 12:12:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH RESEND RESEND] thermal/of: support thermal zones w/o trips
 subnode
Content-Language: en-US
To:     Mark Brown <broonie@kernel.org>,
        Icenowy Zheng <zhengxingda@iscas.ac.cn>
Cc:     Amit Kucheria <amitk@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        Icenowy Zheng <uwu@icenowy.me>
References: <20230722122534.2279689-1-zhengxingda@iscas.ac.cn>
 <ZLw4CnzLI/QHPGWx@finisterre.sirena.org.uk>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <ZLw4CnzLI/QHPGWx@finisterre.sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Mark,

On 22/07/2023 22:11, Mark Brown wrote:
> On Sat, Jul 22, 2023 at 08:25:34PM +0800, Icenowy Zheng wrote:
>> From: Icenowy Zheng <uwu@icenowy.me>
>>
>> Although the current device tree binding of thermal zones require the
>> trips subnode, the binding in kernel v5.15 does not require it, and many
>> device trees shipped with the kernel, for example,
>> allwinner/sun50i-a64.dtsi and mediatek/mt8183-kukui.dtsi in ARM64, still
>> comply to the old binding and contain no trips subnode.
>>
>> Allow the code to successfully register thermal zones w/o trips subnode
>> for DT binding compatibility now.
>>
>> Furtherly, the inconsistency between DTs and bindings should be resolved
>> by either adding empty trips subnode or dropping the trips subnode
>> requirement.
> 
> This makes sense to me - it allows people to see the reported
> temperature even if there's no trips defined which seems more
> helpful than refusing to register.

The binding describes the trip points as required and that since the 
beginning.

What changed is now the code reflects the required property while before 
it was permissive, that was an oversight.

Just a reminder about the thermal framework goals:

   1. It protects the silicon (thus critical and hot trip points)

   2. It mitigates the temperature (thus cooling device bound to trip 
points)

   3. It notifies the userspace when a trip point is crossed

So if the thermal zone is described but without any of this goal above, 
it is pointless.

If the goal is to report the temperature only, then hwmon should be used 
instead.

If the goal is to mitigate by userspace, then the trip point *must* be 
used to prevent the userspace polling the temperature. With the trip 
point the sensor will be set to fire an interrupt at the given trip 
temperature.

IOW, trip points are not optional



-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


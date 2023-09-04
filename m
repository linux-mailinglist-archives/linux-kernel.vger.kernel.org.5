Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0D06791DB2
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 21:34:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231783AbjIDTeh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 15:34:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229967AbjIDTef (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 15:34:35 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8342199B
        for <linux-kernel@vger.kernel.org>; Mon,  4 Sep 2023 12:34:01 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-52a1ce529fdso2335360a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Sep 2023 12:34:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693856015; x=1694460815; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Fyqh9KieADPlDrhoiQmtiolrcxF+wgTTmnR9hQetGoE=;
        b=BfPI2IqshQ76ssuGqujUxP9PtoAuDtODvWamsES4AgUSRQpU5dDlaarhYwD0LkK8Jt
         IWvxzvmiR5MMFKz3O6mORaEOgTID6M/96cQaF/B4A1vuPMIuNVBSkQ4+PA8524gMs4IJ
         sSyD0m/hhaCt5zRrCHQVxPq9oRiZeLsx2llk1Y8XsSjlExSAKJFNX6yvDcUbDbDeR5qb
         R2T2uxhJvZVJVhulEAX1gxssLz0FFXPXkvbWOpaPcSgdk42eQFYY4NEJmag3chhGeFcm
         MrgWG0fk+YrlNwC54E00vv+vrQ8fJS9QWyIeHv6WqwoyZwmWdqaCHrjV3e+hG0LDnsKt
         d0dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693856015; x=1694460815;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Fyqh9KieADPlDrhoiQmtiolrcxF+wgTTmnR9hQetGoE=;
        b=hdRwy54V2HavSsaDjfBUxysx0hyukjRWSqguCxT82Bob+gwu4311dHJ5F/2NWr8Ayb
         1CHQoPgVAopB03A3MBg29uE9LL6MMpoCAHvZYFlQ63ntr3R2WaHYIpokgjNsemzCL8Jv
         yZIZE0UXaRcTMYxSsLE+EyeOt/wyDox45vTnSj67ODeWFnSyAhTeSBks/TgINg6ZZfMc
         UsvH+RS5bTqLT6ppKWQuGdS8HuPsN9s2EmwR3xvomNKL1xc8DXay8+c5nllW98vkR+9v
         XVf66qp5evathyTnAKgjoNG+ci3cVnvtk0vluKIOJXwclA+FPuFgJ2yO2w/2udz7TM6L
         tWzg==
X-Gm-Message-State: AOJu0YyD/oZdNC1d/f+jGXcSZG/5OkOrSXqGYYBqaXdkQqBmE1NstvYs
        mTb/82ePiQMxxDB2N6sEtrv8Vg==
X-Google-Smtp-Source: AGHT+IECh66OM0WQyvbaTq/MMccQJZK12gMVL5VRUK8NzO3Lt69so2ApRkT7/AI/iWf/W3rRE0Je4Q==
X-Received: by 2002:aa7:c391:0:b0:524:9564:4fee with SMTP id k17-20020aa7c391000000b0052495644feemr7852456edq.10.1693856015578;
        Mon, 04 Sep 2023 12:33:35 -0700 (PDT)
Received: from [192.168.0.22] (77-252-46-238.static.ip.netia.com.pl. [77.252.46.238])
        by smtp.gmail.com with ESMTPSA id w4-20020aa7da44000000b0052241b8fd0bsm6183170eds.29.2023.09.04.12.33.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Sep 2023 12:33:35 -0700 (PDT)
Message-ID: <a6c074ec-81d6-4fde-98c7-fc2750483514@linaro.org>
Date:   Mon, 4 Sep 2023 21:33:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH 5/6] arm64: dts: allwinner: h616: Add CPU Operating
 Performance Points table
Content-Language: en-US
To:     Martin Botka <martin.botka@somainline.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Yangtao Li <tiny.windzz@gmail.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-sunxi@lists.linux.dev,
        devicetree@vger.kernel.org,
        Andre Przywara <andre.przywara@arm.com>,
        Alan Ma <tech@biqu3d.com>,
        Luke Harrison <bttuniversity@biqu3d.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rogerio Goncalves <rogerlz@gmail.com>,
        Martin Botka <martin@biqu3d.com>
References: <20230904-cpufreq-h616-v1-0-b8842e525c43@somainline.org>
 <20230904-cpufreq-h616-v1-5-b8842e525c43@somainline.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230904-cpufreq-h616-v1-5-b8842e525c43@somainline.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/09/2023 17:57, Martin Botka wrote:
> Add an Operating Performance Points table for the CPU cores to
> enable Dynamic Voltage & Frequency Scaling on the H616.
> 

...

> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h616.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-h616.dtsi
> index 063db9634e5f..78e79c591dba 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-h616.dtsi
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-h616.dtsi
> @@ -143,6 +143,10 @@ sid: efuse@3006000 {
>  			ths_calibration: thermal-sensor-calibration@14 {
>  				reg = <0x14 0x8>;
>  			};
> +
> +			cpu_speed_grade: cpu_speed_grade@0 {

Underscores are no allowed in node names.

It does not look like you tested the DTS against bindings. Please run
`make dtbs_check W=1` (see
Documentation/devicetree/bindings/writing-schema.rst or
https://www.linaro.org/blog/tips-and-tricks-for-validating-devicetree-sources-with-the-devicetree-schema/
for instructions).

Best regards,
Krzysztof


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B98A7CC930
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 18:55:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231868AbjJQQzb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 12:55:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjJQQz3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 12:55:29 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38866A4
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 09:55:27 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id ffacd0b85a97d-3296b3f03e5so4989263f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 09:55:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697561725; x=1698166525; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ftpCJDEdsDB5dCJBNigeh4u2CwwsQDpIP22iPNCSJXg=;
        b=ITveUndRVn1zepCf7A018S6Tu6IUDRWisiCSKJ87Yqb3olj/BTZhyXk3N96gkbWvYw
         sLyNyeZxxZ7vB3MGodjNFOYj8q5sVHF0A3Q8+XzgWT5VCOw0bAKA3CL2+T2ncddoNFNJ
         47nvuYAA+lx6MrRisNcxBGpWFTNpqyzXqTySatz2L/+AAtwxO4rm6iI3n5UYTmJaoiEC
         Ee0OhMdKdh+HB+mpDES4ksely51qbrCWlaxc9xVMKkDPePdNxoaXDvA97its7Yl4+1eb
         ZTaod4xDE6E9vvkHx/rFOGkDAsDwTZvvLVLMxj5kYfAz/bZ0eXf96dxEooxQBbCea3vy
         vuLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697561725; x=1698166525;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ftpCJDEdsDB5dCJBNigeh4u2CwwsQDpIP22iPNCSJXg=;
        b=la3lqgAlMxY7TksLWk40fnhzDxfji7f0bNlUcEeseLl4XmmLijGlMfJGpAB1D4QMu5
         VVHxsqk5CUABocl3KEywhDndA7Tb+Q2AAExtO8TurbgDIGKSFIiKIlkhrDKPYom/V9D+
         4aAIsctfuV2JWVnIa9532AADGUj6gS8EH3i/BMZYZqqYyLoIbGGg6lj2AaNPJjhOs8mL
         On0t0cqsnchYNga8vHZmforT5AOdXf36lmORLYHW+jMswjLysB+kyUNars3wCdr5mkVL
         5lH0RMMLm4L1PHfAHbYG8KFoHvVi2XtvDlUNdLVqYXj+0SDaDdDiwMw03Oz3KOwiO6AS
         FHNg==
X-Gm-Message-State: AOJu0YytD0CbaUbG5i+JWMo2+CbWDbWkW5RuG2o5sCnJ9ykv01pN30qE
        RvP8GDLg0WHTpasi/AS4z1upvQ==
X-Google-Smtp-Source: AGHT+IHMl59Jk4YUuZjuQRK6HRmz5pn9wzYG6wEN+FOrtPk6CwGNwzicRSRoxuLJuwl2CmPJSImqHw==
X-Received: by 2002:a05:6000:8d:b0:32d:c69b:99b8 with SMTP id m13-20020a056000008d00b0032dc69b99b8mr1481237wrx.35.1697561725621;
        Tue, 17 Oct 2023 09:55:25 -0700 (PDT)
Received: from [172.30.204.57] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id t1-20020a5d6a41000000b0032d9efeccd8sm164668wrw.51.2023.10.17.09.55.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Oct 2023 09:55:25 -0700 (PDT)
Message-ID: <2f22ed28-47b1-4a92-aae5-b625ab4ad731@linaro.org>
Date:   Tue, 17 Oct 2023 18:55:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] arm64: dts: qcom: ipq6018: use CPUFreq NVMEM
To:     Robert Marko <robimarko@gmail.com>, agross@kernel.org,
        andersson@kernel.org, ilia.lin@kernel.org, rafael@kernel.org,
        viresh.kumar@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20231016175532.2081344-1-robimarko@gmail.com>
 <20231016175532.2081344-3-robimarko@gmail.com>
Content-Language: en-US
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20231016175532.2081344-3-robimarko@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/16/23 19:55, Robert Marko wrote:
> IPQ6018 comes in multiple SKU-s and some of them dont support all of the
> OPP-s that are current set, so lets utilize CPUFreq NVMEM to allow only
> supported OPP-s based on the SoC dynamically.
> 
> As an example, IPQ6018 is generaly rated at 1.8GHz but some silicon only
> goes up to 1.5GHz and is marked as such via an eFuse.
> 
> Signed-off-by: Robert Marko <robimarko@gmail.com>
> ---
>   arch/arm64/boot/dts/qcom/ipq6018.dtsi | 14 +++++++++++++-
>   1 file changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/ipq6018.dtsi b/arch/arm64/boot/dts/qcom/ipq6018.dtsi
> index 9aec89d5e095b..49f0e6aa4b5bb 100644
> --- a/arch/arm64/boot/dts/qcom/ipq6018.dtsi
> +++ b/arch/arm64/boot/dts/qcom/ipq6018.dtsi
> @@ -96,42 +96,49 @@ scm {
>   	};
>   
[...]

> +			cpu_speed_bin: cpu_speed_bin@135 {
underscore -> minus sign

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad

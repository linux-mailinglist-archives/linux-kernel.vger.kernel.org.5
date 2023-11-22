Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D81377F511B
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 21:06:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344228AbjKVUGQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 15:06:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232747AbjKVUGM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 15:06:12 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31A7F1B9
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 12:06:08 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-507a29c7eefso121008e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 12:06:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700683566; x=1701288366; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=p6ugU+Nev/JqzL/vcVugO/dwomn06Pl4VoY9cM5bR9s=;
        b=pxi6O8hOyVXtoNlp3q0rSdjy7beZAtTHlj4JvMYDaxLG0X5kr9rDseYr2rUsI3ttV/
         EQbymHY3dHSFB0eO15+91lvpBFmoXxyCpLCd37bcKWRmfUY3YR5jjDY9IfFpzxAE8xcZ
         zfdWTR+qQnIa+CMxLK4sNkBmy1BLaGFXK6VnZusQBG6z5vuztNLHgyPaSJU3fvN9VBe3
         csQbIX50ENzqKhGDjfnJv+SvXIkuxCu20ySxQ7gtAOajFSNydp6a1Jlf0b3V+9D8AMf+
         ueeu5j8CPoxiAzRupBRmBRaqXIhbt9l7A8Qs2Efcc/46ii5QmIxa/cxVrzp8YcuFh+GH
         mO/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700683566; x=1701288366;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=p6ugU+Nev/JqzL/vcVugO/dwomn06Pl4VoY9cM5bR9s=;
        b=OaBxsilEC4w3doAIBOTIpiLzKsS1abTHOTdhiv1ZLpnxEa/PCM7DCazTsrf6K83OpG
         Yun1SKCNSCV602l7B88FZ6USAUWHiFb5oagne7bgDvr7HKksNeLnnkaOURDyN7BoyjZB
         h9uKIeIapu5OCmBLPMftvHNjIso/+tookByHQ3astGvMKDlklhJcwqmDNu8IoEO0VXjP
         B8or8qR/0OTtGSlPEBqLkDZtPsRAvc1ko+swweJ2blLbb8e7E9eWXPBDSeHuWjm4kwqS
         wygPZt3BLkSHoOE7mmy3PTCBSJAsz719DtZMjabc4qihlSrJAlia+DCcwMFwS7prIqWZ
         b5bw==
X-Gm-Message-State: AOJu0Ywu20VyasksMrrseEjt3P1s0xOnmnrENrIB40Vq0Zfms5ja8r9A
        NLywqgr4eAkF+zV3YklIqX4Mog==
X-Google-Smtp-Source: AGHT+IEGcqysnGpkEQB27ESk8xR7FqeNzqxGJFqT1B45/tfrPc+TMWSEniSs+xmGmoGB6siKxOEO8A==
X-Received: by 2002:ac2:4c8c:0:b0:509:44bc:8596 with SMTP id d12-20020ac24c8c000000b0050944bc8596mr2538729lfl.58.1700683565986;
        Wed, 22 Nov 2023 12:06:05 -0800 (PST)
Received: from [172.30.204.74] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id z15-20020ac2418f000000b005079ff02b36sm1932808lfh.131.2023.11.22.12.06.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Nov 2023 12:06:05 -0800 (PST)
Message-ID: <86656263-689d-4979-a3e2-6026bba69d08@linaro.org>
Date:   Wed, 22 Nov 2023 21:06:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 7/8] arm64: dts: qcom: sm7125-xiaomi-common: Add UFS
 nodes
Content-Language: en-US
To:     David Wronek <davidwronek@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Joe Mason <buddyjojo06@outlook.com>, hexdump0815@googlemail.com
Cc:     cros-qcom-dts-watchers@chromium.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-scsi@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        phone-devel@vger.kernel.org
References: <20231117201720.298422-1-davidwronek@gmail.com>
 <20231117201720.298422-8-davidwronek@gmail.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20231117201720.298422-8-davidwronek@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/17/23 21:08, David Wronek wrote:
> Enable the UFS found on the SM7125 Xiaomi smartphones.
> 
> Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> Signed-off-by: David Wronek <davidwronek@gmail.com>
> ---
>   .../boot/dts/qcom/sm7125-xiaomi-common.dtsi      | 16 ++++++++++++++++
>   1 file changed, 16 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm7125-xiaomi-common.dtsi b/arch/arm64/boot/dts/qcom/sm7125-xiaomi-common.dtsi
> index e55cd83c19b8..22ad8a25217e 100644
> --- a/arch/arm64/boot/dts/qcom/sm7125-xiaomi-common.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm7125-xiaomi-common.dtsi
> @@ -398,6 +398,22 @@ sd-cd-pins {
>   	};
>   };
>   
> +&ufs_mem_hc {
> +	vcc-supply = <&vreg_l19a_3p0>;
> +	vcc-max-microamp = <600000>;
> +	vccq2-supply = <&vreg_l12a_1p8>;
> +	vccq2-max-microamp = <600000>;
> +	status = "okay";
> +};
> +
> +&ufs_mem_phy {
> +	vdda-phy-supply = <&vreg_l4a_0p88>;
> +	vdda-pll-supply = <&vreg_l3c_1p23>;
> +	vdda-phy-max-microamp = <62900>;
> +	vdda-pll-max-microamp = <18300>;
These regulators need regulator-allow-set-load and allowed-modes

Konrad

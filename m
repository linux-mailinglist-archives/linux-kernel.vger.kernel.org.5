Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 645A17B1EE1
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 15:46:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232360AbjI1Nqs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 09:46:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231871AbjI1Nqp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 09:46:45 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27E8B136
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 06:46:43 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-9a9d82d73f9so1629711666b.3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 06:46:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695908801; x=1696513601; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5prnC0xekZLUIdAIGR+O/njuKh1qKyD4Z08lsS5xD/Y=;
        b=ZiiaPkqrSuQEPPb2oZi9wOyqROug+N0NhukGAtovEMokxztICxbkV6YrQE0F58UrhQ
         fD5+bGSVwrE1AW9YCgUf7/yJ0MzZXtNeafsX79xtn7xbrOQxrD39q4edaLuwrMzxtyl1
         X7/z9v1iDDeVKNfGbYWlIa46912P5k+EHZjhEQFCWpL3JZCmHMP8EV1/TOO5SxIri3wP
         3eHfFwsXqUbvZ12SNWYkLFq0w8bt9T328wZ/Al+AXdnytJRM8LPvs9O2H8AnS1Y4NMgV
         XznRor0bvkNqQMwfqmXtugfOAn7rVJUpFI7Em5SwOqlruPDaZAjXAfeJL/S0UreXPyi8
         4f7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695908801; x=1696513601;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5prnC0xekZLUIdAIGR+O/njuKh1qKyD4Z08lsS5xD/Y=;
        b=r+f9XXqWCe1vm5ChmeaOyrglMW+LcOGekW57LmHBX165/THRXVY4x8vJkxW8ar/Hff
         niZwEV6pyQEaTp0wQsFMoq1+XlCjJSLwIb/CPXHesa5ijs7jpt8gTYqhkiHBEgbkV6D9
         3+KeoA0k8O6hFkdGtsVjpyH5wTzkLPpgegbti/oRfsGvrPWfmdvd8YyfZSUrBjLHCAl2
         D4edzDWuO/Tpxxj+GsqtB10LWHMSM7iwh8CDTHWnq4JEw+IDbu3TkpNyFLO5fFrrC9sT
         1gf8P5i1Vl46aiQJ/jts+A66X2a/RgToliVz+mnPjCktrxyeZaHdXsI4lW5m1DpU/8/J
         J1hw==
X-Gm-Message-State: AOJu0YyVbeLpYbVuPNRw08aVlgLoZifzOZkNhuydgHms7cwt+KX3v+3r
        SBw1dBqkAG9+toYyJP1wt7Ei9w==
X-Google-Smtp-Source: AGHT+IGIHJE5t2kSD7jVdHBJjmf6prRowOPg/0X5XcPyJ06xcH7rbLd5xgm3yq0GRA4ErAW4OY0ksA==
X-Received: by 2002:a17:906:2249:b0:9a3:faf:7aaa with SMTP id 9-20020a170906224900b009a30faf7aaamr1208832ejr.15.1695908801547;
        Thu, 28 Sep 2023 06:46:41 -0700 (PDT)
Received: from [192.168.33.189] (178235177217.dynamic-4-waw-k-1-1-0.vectranet.pl. [178.235.177.217])
        by smtp.gmail.com with ESMTPSA id j19-20020a170906051300b009937e7c4e54sm10959533eja.39.2023.09.28.06.46.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Sep 2023 06:46:41 -0700 (PDT)
Message-ID: <661bd908-a056-4d46-97a3-d3b12b14c050@linaro.org>
Date:   Thu, 28 Sep 2023 15:46:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] arm64: dts: qcom: qcm6490: Add qcm6490 dts file
Content-Language: en-US
To:     Komal Bajaj <quic_kbajaj@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Luca Weiss <luca.weiss@fairphone.com>
References: <20230928133312.11371-1-quic_kbajaj@quicinc.com>
 <20230928133312.11371-3-quic_kbajaj@quicinc.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <20230928133312.11371-3-quic_kbajaj@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28.09.2023 15:33, Komal Bajaj wrote:
> Add qcm6490 devicetree file for QCM6490 SoC and QCM6490 IDP
> platform. QCM6490 is derived from SC7280 meant for various
> form factor including IoT.
> 
> Supported features are, as of now:
> * Debug UART
> * eMMC
> * USB
> 
> Signed-off-by: Komal Bajaj <quic_kbajaj@quicinc.com>
> ---
[...]

> +/ {
> +	model = "Qualcomm Technologies, Inc. QCM6490 IDP platform";
Isomething Development Platform platform?

> +	compatible = "qcom,qcm6490-idp", "qcom,qcm6490";
> +
> +	aliases {
> +		serial0 = &uart5;
> +	};
> +
> +	chosen {
> +		stdout-path = "serial0:115200n8";
> +	};
> +
> +};
Stray newline above

> +
> +&apps_rsc {
> +	regulators-0 {
> +		compatible = "qcom,pm7325-rpmh-regulators";
> +		qcom,pmic-id = "b";
> +
> +		vreg_s1b_1p8: smps1 {
> +			regulator-min-microvolt = <1856000>;
> +			regulator-max-microvolt = <2040000>;
Hm, you didn't specify regulator-initial-mode on any vregs

[...]

> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/qcm6490.dtsi
> @@ -0,0 +1,137 @@
> +// SPDX-License-Identifier: BSD-3-Clause
> +/*
> + * Copyright (c) 2023 Qualcomm Innovation Center, Inc. All rights reserved.
> + */
> +
> +#include "sc7280.dtsi"
> +
> +/*
> + * Delete sc7280 lpass related nodes as qcm6490 intends to move away from
> + * bypass configuration
> + */
> +/delete-node/ &lpass_ag_noc;
> +/delete-node/ &lpass_aon;
> +/delete-node/ &lpass_audiocc;
> +/delete-node/ &lpass_core;
> +/delete-node/ &lpass_cpu;
> +/delete-node/ &lpass_hm;
> +/delete-node/ &lpass_rx_macro;
> +/delete-node/ &lpass_tx_macro;
> +/delete-node/ &lpass_va_macro;
> +/delete-node/ &lpass_tlmm;
> +/delete-node/ &lpasscc;
> +/delete-node/ &swr0;
> +/delete-node/ &swr1;
That's very unnecessary, most of these nodes are in use even
when routing audio through ADSP.

Ones that are not, are set to status = "reserved" and some
will need more work to function based on the configuration.

There was once a series from somebody at qc to introduce ADSP
audio on 7280, but it was full of hacks and NAKed


> +
> +/*
> + * Delete unused sc7280 memory nodes and define the memory regions
> + * required by qcm6490
> + */
That's specific to your board.

> +/delete-node/ &rmtfs_mem;
> +/delete-node/ &wlan_ce_mem;
> +
> +/{
> +	reserved-memory {
> +		secdata_apss_mem: secdata-apss@808ff000 {
> +			reg = <0x0 0x808ff000 0x0 0x1000>;
> +			no-map;
> +		};
This is identical to the entry in sc7280.dtsi.

> +
> +		cdsp_secure_heap_mem: cdsp-secure-heap@81800000 {
> +			reg = <0x0 0x81800000 0x0 0x1e00000>;
> +			no-map;
> +		};
> +
> +		camera_mem: camera@84300000 {
> +			reg = <0x0 0x84300000 0x0 0x500000>;
> +			no-map;
> +		};
> +
> +		adsp_mem: adsp@86100000 {
> +			reg = <0x0 0x86100000 0x0 0x2800000>;
> +			no-map;
> +		};
> +
> +		cdsp_mem: cdsp@88900000 {
> +			reg = <0x0 0x88900000 0x0 0x1e00000>;
> +			no-map;
> +		};
> +
> +		cvp_mem: cvp@8ac00000 {
> +			reg = <0x0 0x8ac00000 0x0 0x500000>;
> +			no-map;
> +		};
> +
> +		ipa_gsi_mem: ipa-gsi@8b110000 {
> +			reg = <0x0 0x8b110000 0x0 0xa000>;
> +			no-map;
> +		};
> +
> +		gpu_microcode_mem: gpu-microcode@8b11a000 {
> +			reg = <0x0 0x8b11a000 0x0 0x2000>;
> +			no-map;
> +		};
> +
> +		mpss_mem: mpss@8b800000 {
> +			reg = <0x0 0x8b800000 0x0 0xf600000>;
> +			no-map;
> +		};
> +
> +		wpss_mem: wpss@9ae00000 {
> +			reg = <0x0 0x9ae00000 0x0 0x1900000>;
> +			no-map;
> +		};
This entry is in both chrome-common and fairphone (meaning all boards
use it), perhaps this one could be moved to 7280.dtsi

> +
> +		tz_stat_mem: tz-stat@c0000000 {
> +			reg = <0x0 0xc0000000 0x0 0x100000>;
> +			no-map;
> +		};
> +
> +		tags_mem: tags@c0100000 {
> +			reg = <0x0 0xc0100000 0x0 0x1200000>;
> +			no-map;
> +		};
> +
> +		qtee_mem: qtee@c1300000 {
> +			reg = <0x0 0xc1300000 0x0 0x500000>;
> +			no-map;
> +		};
> +
> +		trusted_apps_mem: trusted_apps@c1800000 {
> +			reg = <0x0 0xc1800000 0x0 0x3900000>;
> +			no-map;
> +		};
> +	};
> +};
> +
> +&hyp_mem {
> +	reg = <0x0 0x80000000 0x0 0x600000>;
This is identical to the entry in sc7280.dtsi.

> +};
> +
> +&mpss_mem {
> +	reg = <0x0 0x8b800000 0x0 0xf600000>;
You're defining it here and overwriting it with an identical
value.

Looks like CrOS folks don't boot up the modem on non-LTE SKUs.
Weird. Normally it would host some more software..

> +};
> +
> +&remoteproc_mpss {
> +	memory-region = <&mpss_mem>;
This is identical to the entry in sc7280.dtsi.

> +};
> +
> +&video_mem {
> +	reg = <0x0 0x8a700000 0x0 0x500000>;
> +};
> +
> +&wifi {
> +	memory-region = <&wlan_fw_mem>;
No CE region?

> +};
> +
> +&wlan_fw_mem {
> +	reg = <0x0 0x80c00000 0x0 0xc00000>;
This is identical to the entry in sc7280.dtsi.


The memory map generally looks quite different to both chrome
and fairphone.. are you sure it's all correct?

Konrad

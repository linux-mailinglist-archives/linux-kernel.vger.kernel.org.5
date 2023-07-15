Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A288754934
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jul 2023 16:13:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229895AbjGOONX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jul 2023 10:13:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbjGOONW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jul 2023 10:13:22 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C2E91BFA
        for <linux-kernel@vger.kernel.org>; Sat, 15 Jul 2023 07:13:20 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-4fb73ba3b5dso4875757e87.1
        for <linux-kernel@vger.kernel.org>; Sat, 15 Jul 2023 07:13:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689430398; x=1692022398;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5pjJI9w8CFYJrlO278g5PFbKv5pKnn17lMTGBT+3ydM=;
        b=cJn5Gz01cO+cq0uBVhD8cZf87mpRtNHRLa84O3sHr2CyzmT62tYv1SEEstzuGV0AUx
         AJLfnGpA8LikdPUZ94WAgSgqiBZpTlUdU5w6Uto6C401wyW2UCHEN+24KtlaYE6zPsiv
         1BYP/BqKUTzPOsZ0YYqfWrRlXq6idmUF9iVkPHMVJZcn/ZHYuzsAMkeDQD6z/tdXyr/4
         CIayY8suMp3JlBf4vGwSj8zHNZUHVl0jXkf5DWPV8j6JgBrbBlVA91QbUq+4cQQYV8Oq
         hlf7g2vtSMQf3qX1/9rZyAatfHFueuOQY7VSB3NfgU7Dih/3H9hRfLbtYqCeLq6cv5h6
         Iatw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689430398; x=1692022398;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5pjJI9w8CFYJrlO278g5PFbKv5pKnn17lMTGBT+3ydM=;
        b=aqwjxvJQshBRFL/oe2WNcIUmglUew70wQM5nI+ocnIc4nbS67vSZJ3UnpLl/XkQ6qO
         e4P9shDZGBKblYYoRCi+F5iN0BxwCdH2yk4X2ulDKKt++myGu33/Mk5M4cJVN0kkf42J
         5u7PobJ2PjG4Fhkw2tx3Tm3nv4bHyqQAeuFqWvcTtffrIKGawYclq7FrA9KX+om70q6Q
         OJa56xm+w8M/jzQvRILGxjulrDvw4d9KNpVkd8x0PtZQ+yIwYipsy2rgYdAhCmItAM1e
         3a9Yw8Y18OiKUE/dB4SrB74FnXxPQfNZMs35ewAR+5cVvRZ4vnLVogTGq1vo6eOuJMzW
         czLQ==
X-Gm-Message-State: ABy/qLag945kk/6f5MfK979Wc/WaM+GrREzrN5Xw7pevRW+RCRUvDhcK
        5rWh+rQXQljECeAXD3MA9pteIA==
X-Google-Smtp-Source: APBJJlH0xNy2URzHQZxZqhffBIQMXcMWLWBBCQv1AQehwlwJCbmBo/SZSG2sdKsAziqgWPIw0tE9+w==
X-Received: by 2002:a05:6512:39d2:b0:4f6:3000:94a0 with SMTP id k18-20020a05651239d200b004f6300094a0mr6428959lfu.61.1689430398238;
        Sat, 15 Jul 2023 07:13:18 -0700 (PDT)
Received: from [192.168.1.101] (abxi167.neoplus.adsl.tpnet.pl. [83.9.2.167])
        by smtp.gmail.com with ESMTPSA id t19-20020ac243b3000000b004fbc0da55b4sm1905515lfl.112.2023.07.15.07.13.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 15 Jul 2023 07:13:17 -0700 (PDT)
Message-ID: <bb80d65e-b6e5-37ac-b4eb-01166af6f39c@linaro.org>
Date:   Sat, 15 Jul 2023 16:13:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 1/2] arm64: dts: qcom: qdu1000-idp: Update reserved
 memory region
Content-Language: en-US
To:     Komal Bajaj <quic_kbajaj@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230706125129.20969-1-quic_kbajaj@quicinc.com>
 <20230706125129.20969-2-quic_kbajaj@quicinc.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230706125129.20969-2-quic_kbajaj@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6.07.2023 14:51, Komal Bajaj wrote:
> Add missing reserved regions as described in QDU1000 memory map.
> 
> Signed-off-by: Komal Bajaj <quic_kbajaj@quicinc.com>
> ---
Are you sure you want to reserve 4352 MiB?

Konrad
>  arch/arm64/boot/dts/qcom/qdu1000-idp.dts | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/qdu1000-idp.dts b/arch/arm64/boot/dts/qcom/qdu1000-idp.dts
> index 1d22f87fd238..8446eb438a34 100644
> --- a/arch/arm64/boot/dts/qcom/qdu1000-idp.dts
> +++ b/arch/arm64/boot/dts/qcom/qdu1000-idp.dts
> @@ -448,6 +448,28 @@ &qupv3_id_0 {
>  	status = "okay";
>  };
> 
> +&reserved_memory {
> +	ecc_meta_data_mem: ecc-meta-data@e0000000 {
> +		reg = <0x0 0xe0000000 0x0 0x20000000>;
> +		no-map;
> +	};
> +
> +	harq_buffer_mem: harq-buffer@800000000 {
> +		reg = <0x8 0x0 0x0 0x80000000>;
> +		no-map;
> +	};
> +
> +	tenx_sp_buffer_mem: tenx-sp-buffer@880000000 {
> +		reg = <0x8 0x80000000 0x0 0x50000000>;
> +		no-map;
> +	};
> +
> +	fapi_buffer_mem: fapi-buffer@8d0000000 {
> +		reg = <0x8 0xd0000000 0x0 0x20000000>;
> +		no-map;
> +	};
> +};
> +
>  &sdhc {
>  	pinctrl-0 = <&sdc_on_state>;
>  	pinctrl-1 = <&sdc_off_state>;
> --
> 2.40.1
> 

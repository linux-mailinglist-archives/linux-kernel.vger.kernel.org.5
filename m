Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C38817DCB2A
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 11:53:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344001AbjJaKxO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 06:53:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343983AbjJaKxM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 06:53:12 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8271CC1
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 03:53:09 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id 38308e7fff4ca-2c523ac38fbso81018311fa.0
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 03:53:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698749588; x=1699354388; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PZEtEH4BVMdZ/99eBNfi6obYrRNvQ11tTN1yHiXWSCY=;
        b=tCQUs/CQGX7qkZl7sK+pzKlRD4ZGlwLE3kpQZXv1T3liztiwAalv159qhT9vkG7ziF
         +VgtWAUACeNLw8rEp40q49lhFPEAWKH0xpGC1RudYamHcyHsOwbraI7Mqdz3NfvQiB0J
         RJfmFo4tox+R6zAsH3nkrP3RsHdfB/ZyrRfWzk3QH6k2K5vltKNo9rNFfOM4KTARmpd+
         rxAisoiSLxSpJRhqiCER+hhQSUOPB6DgGfKjs4MBjizT9pWVsMRruQCK6hnkPz/xhnXu
         K8mQXI4vd36swduRJ2VbSoAnO7jqf2gKvmqoBKdl671uoa9InUX5WNLpzx5d0m8usIZG
         guFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698749588; x=1699354388;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PZEtEH4BVMdZ/99eBNfi6obYrRNvQ11tTN1yHiXWSCY=;
        b=EK6D6mV4T1VzH3oEp6/0KobSTcc0w2ZXP9UI/SRS/VzXG3yLyD8W5NzPNHYF37YzYr
         8JtekBikunjXeo1TLbarTiCX+4YZX2ogo7Rl5Ee9kW/LMteC+Xw53CJ1ljI0q4beL2+N
         eaxOMLOpOyl6H8iReR60iLd2BRYbZ5nnoPgvw4cX/SzPj3IVjJDY4mSOOBVx9ysztx9w
         2AvMcrmG6f9Xi9a7cr1rxshjTOT+c+7mG5s4NTcN/zTBvSwbwzYdYhskQrUJRpDQm4vw
         OIN6Si5iKM7DS3Agz+7EkhTzITkueRXipt1c8QJJYCg/HJQyAs5Nlds79k++R7LEcSVu
         zpCA==
X-Gm-Message-State: AOJu0Yy172iadysUHeRrYC5fF4100BvjYVnW0L9KIO2fDPnUM+JCovc6
        7zTadtaqp9f3RGPZJCQRkishYA==
X-Google-Smtp-Source: AGHT+IE/4NcbCWkfWopCUzcLV1PIteWoizdtaq9MoRTs0ZR3E0yz8Qs2V6DGhEbRFqBd4zpnlxZZHw==
X-Received: by 2002:a2e:2c11:0:b0:2c5:1e3f:7379 with SMTP id s17-20020a2e2c11000000b002c51e3f7379mr9581736ljs.48.1698749587617;
        Tue, 31 Oct 2023 03:53:07 -0700 (PDT)
Received: from [192.168.143.96] (178235177091.dynamic-4-waw-k-1-1-0.vectranet.pl. [178.235.177.91])
        by smtp.gmail.com with ESMTPSA id x12-20020a2ea98c000000b002c0055834b3sm160671ljq.4.2023.10.31.03.53.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Oct 2023 03:53:07 -0700 (PDT)
Message-ID: <d411e561-b0d0-48db-959e-3347006bce77@linaro.org>
Date:   Tue, 31 Oct 2023 11:53:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/5] media: qcom: camss: Add support for named
 power-domains
Content-Language: en-US
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        hverkuil-cisco@xs4all.nl, laurent.pinchart@ideasonboard.com,
        rfoss@kernel.org, todor.too@gmail.com, andersson@kernel.org,
        mchehab@kernel.org
Cc:     linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20231026155042.551731-1-bryan.odonoghue@linaro.org>
 <20231026155042.551731-6-bryan.odonoghue@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <20231026155042.551731-6-bryan.odonoghue@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26.10.2023 17:50, Bryan O'Donoghue wrote:
> Right now we use fixed indexes to assign power-domains, with a
> requirement for the TOP GDSC to come last in the list.
> 
> Adding support for named power-domains means the declaration in the dtsi
> can come in any order.
> 
> After this change we continue to support the old indexing - if a SoC
> resource declration or the in-use dtb doesn't declare power-domain names
> we fall back to the default legacy indexing.
> 
> From this point on though new SoC additions should contain named
> power-domains, eventually we will drop support for legacy indexing.
> 
> Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> ---
>  drivers/media/platform/qcom/camss/camss-vfe.c | 24 ++++++++++++++++-
>  drivers/media/platform/qcom/camss/camss.c     | 26 +++++++++++++++----
>  drivers/media/platform/qcom/camss/camss.h     |  2 ++
>  3 files changed, 46 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/media/platform/qcom/camss/camss-vfe.c b/drivers/media/platform/qcom/camss/camss-vfe.c
> index ebd5da6ad3f2f..cb48723efd8a0 100644
> --- a/drivers/media/platform/qcom/camss/camss-vfe.c
> +++ b/drivers/media/platform/qcom/camss/camss-vfe.c
> @@ -1381,7 +1381,29 @@ int msm_vfe_subdev_init(struct camss *camss, struct vfe_device *vfe,
>  	if (!res->line_num)
>  		return -EINVAL;
>  
> -	if (res->has_pd) {
> +	/* Power domain */
Unnecessary, I think

> +
> +	if (res->pd_name) {
No need to nullcheck, dev_pm_domain_attach_by_name seems to return
NULL when the name is NULL

[...]
> -	if (IS_ERR(camss->genpd)) {
> +	if (camss->res->pd_name) {
ditto
> +		camss->genpd = dev_pm_domain_attach_by_name(camss->dev,
> +							    camss->res->pd_name);
> +		if (IS_ERR(camss->genpd)) {
> +			ret = PTR_ERR(camss->genpd);
> +			goto fail_pm;
> +		}
> +	}
> +
Looks good otherwise, I think

Konrad

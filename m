Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6A44756DED
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 22:05:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229827AbjGQUE7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 16:04:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229908AbjGQUE5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 16:04:57 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11895D8
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 13:04:56 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-51e590a8ab5so6644164a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 13:04:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689624294; x=1692216294;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=I76Sas49+3M9ekKP/7ht8hPC9v5gon7krQLvrpuLnTI=;
        b=kD7qJO0Wnw3ipxc7bweaS63c++QVlzCsrQekZjmx28RC5UFVbFKnY0c/RROj2sVvNR
         53/FmNf7Cb7kMcnEYupN6pZ/Q4qFx/k6BXG4BOG/y4viI6ZgAwRbR2ityeeUl4RyhSAE
         pUv+hITUmkk91bXJV37Szmpd5Z6HY7mUvZ1Uk7zTKY6IpHWR5e9Jx9kexgcwKPSooywv
         osyFo5qIMeZ1QC5mbqrw8aEoCMV0X3Aus2fx++qGBs/RYmCNKfZ4AKsGt35Hcqm7gwLz
         xGnswyhZJ0vxtz5P6yGwt6y4KHxgtsNipgpZMrfFeTRkifM5Itr0oPxMZAKMx9VOBVGo
         DJqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689624294; x=1692216294;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I76Sas49+3M9ekKP/7ht8hPC9v5gon7krQLvrpuLnTI=;
        b=jl9uHDcpPfXqmRlxrf9H35ivkZm1VD27F0TbzyiPMAL1MyluCUIIgKFXueOu/h+mDT
         H2wfA7o54TVYchKE468GzMgmOULUlM3GrMi/5KLe7Uxhv77u4ofmlaPsdeaJKEkpYU/v
         VEuMF0ep0pEMNMse4peqZchRDw7EkfZmiTjBnnUiCzJVa0lpf+y+wPHKSx3+586BFHiF
         ErizjDCcoNHLPdb4y0Vat9mFvQeGchzTAiOQGx88fWuYV/DJkn911otrgyJhAIlL0Nhb
         5pZhEgxPBlTbmf/rmvqP4WGF6SmZMYt20kiIp9oM17QlOD/MNUzasx1dpAisBTAB+p7W
         EM4Q==
X-Gm-Message-State: ABy/qLZLnKpQX58Pevu84iDUF5XZtWECeMc9EdjY5h9im8FLdbozknD5
        R3B5sH/qQGO7gRH1hQFz6+VBrw==
X-Google-Smtp-Source: APBJJlHuA9Bvh2MuZ0h6VH93okT5lM95OFaGlwZCdxHMq0phGKHw+Qu4iLZsc4btdeov/x3+8WXB0w==
X-Received: by 2002:a05:6402:541:b0:516:81d3:2627 with SMTP id i1-20020a056402054100b0051681d32627mr15167008edx.0.1689624294498;
        Mon, 17 Jul 2023 13:04:54 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id i19-20020aa7dd13000000b0051de3c6c5e5sm63518edv.94.2023.07.17.13.04.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Jul 2023 13:04:53 -0700 (PDT)
Message-ID: <b236b46f-d6de-21f1-d535-680518a0b945@linaro.org>
Date:   Mon, 17 Jul 2023 22:04:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v4 3/6] mmc: sdhci-cadence: SD6 controller support
Content-Language: en-US
To:     Piyush Malgujar <pmalgujar@marvell.com>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, adrian.hunter@intel.com,
        ulf.hansson@linaro.org, p.zabel@pengutronix.de, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        yamada.masahiro@socionext.com, devicetree@vger.kernel.org
Cc:     jannadurai@marvell.com, cchavva@marvell.com,
        Dhananjay Kangude <dkangude@cadence.com>
References: <20230717125146.16791-1-pmalgujar@marvell.com>
 <20230717125146.16791-4-pmalgujar@marvell.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230717125146.16791-4-pmalgujar@marvell.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/07/2023 14:51, Piyush Malgujar wrote:
> From: Dhananjay Kangude <dkangude@cadence.com>
> 
> Add support for SD6 controller for Marvell CN10k SoCs and related ops
> along with support for HS400 and HS400ES emmc modes.
> Updated HS200 tuning values and support to read tune configuration
> from FDT and support to configure and read host side drive strength,
> slew from device tree.
> 

...

>  static void sdhci_cdns_hs400_enhanced_strobe(struct mmc_host *mmc,
>  					     struct mmc_ios *ios)
>  {
> @@ -518,8 +1752,11 @@ static int sdhci_cdns_probe(struct platform_device *pdev)
>  	struct sdhci_pltfm_host *pltfm_host;
>  	struct sdhci_cdns_priv *priv;
>  	struct clk *clk;
> +	bool sd6_ctrl;
>  	int ret;
>  	struct device *dev = &pdev->dev;
> +	sd6_ctrl = of_device_is_compatible(dev->of_node, "marvell,cdns-sd6hc");

Don't sprinkle compatibles in probe. You have match data for quirks and
flags.

> +
>  	static const u16 version = SDHCI_SPEC_400 << SDHCI_SPEC_VER_SHIFT;
>  

Best regards,
Krzysztof


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 081AF77778E
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 13:52:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235103AbjHJLwk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 07:52:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234630AbjHJLwj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 07:52:39 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0563136
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 04:52:37 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-3fe4b45a336so6963915e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 04:52:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nexus-software-ie.20221208.gappssmtp.com; s=20221208; t=1691668356; x=1692273156;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LzeCdbBciwn7kH7WZmbFrdgE1gfhiupvQ81rtSDk07c=;
        b=118qziD2W+rfwz0DpuQFBmynEfBXPsFJSqJJ4k6Lxr2K620u++rUm3BYhCybqgaT/B
         GWgi8pRP4OAKAKKD6DQ19lRlZfn3tRQ4O7o6eKMZaCxj17D/ZU30A6t0gn1pwh/ptlfh
         xKMOZXhSqnl8AF0mCuOIIJ2zcAuFI+RjR9eHfEkaMz+G5y8jZSuoxjzrNk3JG40QgfFd
         d56Ug28KkYd8IVXyyGl7u0bbPkuBgqMtR7tkNqoxXVVWQKJNUJc2yPsDFGNhfs57Xq/5
         Y8CRtwMOgBJlgeabA/WyT7uigmRWUe1l2rwJjbYLg9g+SjpCQ/JzGVY5JSIqF62ioHdg
         wCJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691668356; x=1692273156;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LzeCdbBciwn7kH7WZmbFrdgE1gfhiupvQ81rtSDk07c=;
        b=BdxVCDsOZ9J0QrU7LR7TCbYwBHqH6dZkJG85dJdrOOKKqxNjPUlIsNVpc3lJGQeKpa
         JkQCB1yZD4FDKgY+HYh8QeDnHZtY0D0+pHrKuzdiD5ln2xE8pmqtk/UKnIyaE5z0vaJC
         zk5Mw2KN+fijbH1BPjI5I7MgExNtZQDBcf0FK6+FZLbbwCV+0TDUj4KDSnwGLNA8ofPY
         USRqOx0Xg9tdeA32RpKf9gJY59pMleKmE1n8QM/bhCGcR1mGP8EUEeNVT1tb0Mgh5ybu
         avLUgf0Zr737n4A4niPIAwCygIyvXJrYer9kv2ovmJZioXoV1hjJDsKmZ/9FC9jvFSFU
         n/gA==
X-Gm-Message-State: AOJu0YzbqEwBkEZPtrR+2k7sC13kVroM/U/zU7cJMpaxs/p1oTSmwPPE
        kOlRGKbMROr8PodW3FaVRWZtB1cssRB6Txamqi8=
X-Google-Smtp-Source: AGHT+IFpMuAhv3k//+OE0f3WJUydfC1p15CKoDeiqUpsdDCYRM24s+94jA9tJ2Y94hDl1IjZzGG/gQ==
X-Received: by 2002:a05:600c:2210:b0:3fb:d1c1:9b79 with SMTP id z16-20020a05600c221000b003fbd1c19b79mr1598472wml.30.1691668356070;
        Thu, 10 Aug 2023 04:52:36 -0700 (PDT)
Received: from [192.168.0.162] (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id t18-20020adff612000000b00317b0155502sm1967652wrp.8.2023.08.10.04.52.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Aug 2023 04:52:35 -0700 (PDT)
Message-ID: <d7bf9370-ac5a-8d5a-f0f7-06b6a97092c8@nexus-software.ie>
Date:   Thu, 10 Aug 2023 12:52:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 4/6] soc: qcom: Add LLCC support for multi channel DDR
Content-Language: en-US
To:     Komal Bajaj <quic_kbajaj@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        srinivas.kandagatla@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230810061140.15608-1-quic_kbajaj@quicinc.com>
 <20230810061140.15608-5-quic_kbajaj@quicinc.com>
From:   Bryan O'Donoghue <pure.logic@nexus-software.ie>
In-Reply-To: <20230810061140.15608-5-quic_kbajaj@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/08/2023 07:11, Komal Bajaj wrote:
> Add LLCC support for multi channel DDR configuration
> based on a feature register.
> 
> Signed-off-by: Komal Bajaj <quic_kbajaj@quicinc.com>
> ---
>   drivers/soc/qcom/llcc-qcom.c | 27 +++++++++++++++++++++++++--
>   1 file changed, 25 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/soc/qcom/llcc-qcom.c b/drivers/soc/qcom/llcc-qcom.c
> index 76e8083d053d..4fad2cff5e1e 100644
> --- a/drivers/soc/qcom/llcc-qcom.c
> +++ b/drivers/soc/qcom/llcc-qcom.c
> @@ -12,6 +12,7 @@
>   #include <linux/kernel.h>
>   #include <linux/module.h>
>   #include <linux/mutex.h>
> +#include <linux/nvmem-consumer.h>
>   #include <linux/of.h>
>   #include <linux/of_device.h>
>   #include <linux/regmap.h>
> @@ -998,6 +999,24 @@ static int qcom_llcc_cfg_program(struct platform_device *pdev,
>   	return ret;
>   }
> 
> +static int qcom_llcc_get_cfg_index(struct platform_device *pdev, u8 *cfg_index, int num_config)
> +{
> +	int ret;
> +
> +	ret = nvmem_cell_read_u8(&pdev->dev, "multi-chan-ddr", cfg_index);
> +	if (ret == -ENOENT || ret == -EOPNOTSUPP) {
> +		if (num_config != DEF_NUM_CFG)
> +			return -EINVAL;
> +		*cfg_index = DEF_NUM_CFG - 1;
> +		return 0;
> +	}
> +
> +	if (!ret && *cfg_index >= num_config)
> +		ret = -EINVAL;
> +
> +	return ret;
> +}
> +
>   static int qcom_llcc_remove(struct platform_device *pdev)
>   {
>   	/* Set the global pointer to a error code to avoid referencing it */
> @@ -1034,6 +1053,7 @@ static int qcom_llcc_probe(struct platform_device *pdev)
>   	const struct qcom_llcc_config *cfg;
>   	const struct llcc_slice_config *llcc_cfg;
>   	u32 sz;
> +	u8 cfg_index;
>   	u32 version;
>   	struct regmap *regmap;
> 
> @@ -1051,11 +1071,14 @@ static int qcom_llcc_probe(struct platform_device *pdev)
>   	}
> 
>   	cfgs = of_device_get_match_data(&pdev->dev);
> -	if (!cfgs || cfgs->num_config != DEF_NUM_CFG) {
> +	if (!cfgs) {
>   		ret = -EINVAL;
>   		goto err;
>   	}
> -	cfg = &cfgs->llcc_config[DEF_NUM_CFG - 1];
> +	ret = qcom_llcc_get_cfg_index(pdev, &cfg_index, cfgs->num_config);
> +	if (ret)
> +		goto err;
> +	cfg = &cfgs->llcc_config[cfg_index];
> 
>   	ret = regmap_read(regmap, cfg->reg_offset[LLCC_COMMON_STATUS0], &num_banks);
>   	if (ret)
> --
> 2.41.0
> 

This patch doesn't apply to -next

deckard@sagittarius-a:~/Development/qualcomm/qlt-kernel$ git checkout -b 
llc-review-v0 linux-next/master
branch 'llc-review-v0' set up to track 'linux-next/master'.
Switched to a new branch 'llc-review-v0'
deckard@sagittarius-a:~/Development/qualcomm/qlt-kernel$ git am < 
../patches/linux/lllc-review/v0/\[PATCH\ 1_6\]\ dt-bindings\:\ cache\:\ 
qcom\,llcc\:\ Add\ LLCC\ compatible\ for\ QDU1000_QRU1000\ -\ Komal\ 
Bajaj\ \<quic_kbajaj@quicinc.com\>\ -\ 2023-08-10\ 0711.eml
Applying: dt-bindings: cache: qcom,llcc: Add LLCC compatible for 
QDU1000/QRU1000
deckard@sagittarius-a:~/Development/qualcomm/qlt-kernel$ git am < 
../patches/linux/lllc-review/v0/\[PATCH\ 2_6\]\ soc\:\ qcom\:\ llcc\:\ 
Refactor\ llcc\ driver\ to\ support\ multiple\ configuration\ -\ Komal\ 
Bajaj\ \<quic_kbajaj@quicinc.com\>\ -\ 2023-08-10\ 0711.eml
Applying: soc: qcom: llcc: Refactor llcc driver to support multiple 
configuration
deckard@sagittarius-a:~/Development/qualcomm/qlt-kernel$ git am < 
../patches/linux/lllc-review/v0/\[PATCH\ 3_6\]\ nvmem\:\ core\:\ Add\ 
stub\ for\ nvmem_cell_read_u8\ -\ Komal\ Bajaj\ 
\<quic_kbajaj@quicinc.com\>\ -\ 2023-08-10\ 0711.eml
Applying: nvmem: core: Add stub for nvmem_cell_read_u8
deckard@sagittarius-a:~/Development/qualcomm/qlt-kernel$ git am < 
../patches/linux/lllc-review/v0/\[PATCH\ 4_6\]\ soc\:\ qcom\:\ Add\ 
LLCC\ support\ for\ multi\ channel\ DDR\ -\ Komal\ Bajaj\ 
\<quic_kbajaj@quicinc.com\>\ -\ 2023-08-10\ 0711.eml
Applying: soc: qcom: Add LLCC support for multi channel DDR
error: patch failed: drivers/soc/qcom/llcc-qcom.c:12
error: drivers/soc/qcom/llcc-qcom.c: patch does not apply
Patch failed at 0001 soc: qcom: Add LLCC support for multi channel DDR
hint: Use 'git am --show-current-patch=diff' to see the failed patch

6f48f84d73ab5 (HEAD -> llc-review-v0) HEAD@{0}: am --abort
6f48f84d73ab5 (HEAD -> llc-review-v0) HEAD@{1}: am: nvmem: core: Add 
stub for nvmem_cell_read_u8
7e5adcab05af4 HEAD@{2}: am: soc: qcom: llcc: Refactor llcc driver to 
support multiple configuration
0990c31774948 HEAD@{3}: am: dt-bindings: cache: qcom,llcc: Add LLCC 
compatible for QDU1000/QRU1000
21ef7b1e17d03 (tag: next-20230809, linux-next/master) HEAD@{4}: 
checkout: moving from linux-next-23-08-07-db410c-rb3-camss-dts-v2 to 
llc-review-v0

---
bod

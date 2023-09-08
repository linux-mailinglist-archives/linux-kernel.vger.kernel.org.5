Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74E077983DC
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 10:17:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232156AbjIHIRG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 04:17:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbjIHIRC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 04:17:02 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54DBC1BE6
        for <linux-kernel@vger.kernel.org>; Fri,  8 Sep 2023 01:16:56 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-99c3c8adb27so220415666b.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Sep 2023 01:16:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694161015; x=1694765815; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hWnR3iTKLtNaSTGp3ycj3ykgtrH6ON5cNLA1Cxk2dCM=;
        b=JM0oPDHbH3FuSauK2OeBJGX6i6szIvQgPTXcaoPpck9PZR2EdmDIHe6/EtWbLTi2Fq
         BZNOq41ICVfifVmfW6eOQD7JQRXzIoqbMJaqWmJn/mmZMl+DEOJVu1ojZsimd6K1/uYX
         Wi3rpHiRfjTR+YQxNUR/qMJh8I8psuNftc0IEVI0FIiRVMgj2BpsOTlCB7slrijihIUg
         xclbmC34ZpjLrd0yfx3CaZTwUUHhJZDRorwhqJghG3j9cy1MMWudUyqpRjVY0jlg1JJ9
         oTSg+B1Dkzw5cDmzKkhQuxE8/ZdqvGkjuOApTAYpW7o21jfYPRFZIihR0x0oE0/TqObf
         XCnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694161015; x=1694765815;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hWnR3iTKLtNaSTGp3ycj3ykgtrH6ON5cNLA1Cxk2dCM=;
        b=npRdYq1YSaA6pfRccxuNfx5pRHKBYHgHeRT/5HvsrVrthKpnRSbmjjvF/HrZ8waJd2
         zQmf5AdS2qjIXf9H0mT6DkKH04lmI6YxuOWRj0wiRmooAFLnmnHFvHBjIzgPTHbdzmxt
         VSnAFs/LGtfFtqIYq8nmlyAsS/3lsG1bPYq6d9sE+ih2ZysAwMD+h6wGYP8xo0PIVYqI
         gxsyZg7e+iPz6slrwH3fXh53+AN4NvkatTSDl3WgixHsoO5xkVJovLsaiw64ejm635xI
         6VpdvdQyVVMaOcU1tuehs3mNX1Bb9UlLua2okEZizlopsotCOP1KcL6oe4v+GHenjNj5
         HidQ==
X-Gm-Message-State: AOJu0YyzXQjqU6ueehWTs9ZjzhDK+4JjDZnZNe1c8Kqauk8SvkwAHoDc
        EQuY2u7FMty4C68jJA0wWZOhgQ==
X-Google-Smtp-Source: AGHT+IHCW6sUCeMutdZ6gSGXFPFW8wjQS5S3jep7Zuf96HV7IXywECCKcudaC7jjdAublUt9FI5xQA==
X-Received: by 2002:a17:906:300f:b0:9a1:b43b:73a0 with SMTP id 15-20020a170906300f00b009a1b43b73a0mr1232187ejz.20.1694161014787;
        Fri, 08 Sep 2023 01:16:54 -0700 (PDT)
Received: from [192.168.37.45] (178235177197.dynamic-4-waw-k-1-1-0.vectranet.pl. [178.235.177.197])
        by smtp.gmail.com with ESMTPSA id r20-20020a170906c29400b0099d798a6bb5sm692461ejz.67.2023.09.08.01.16.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Sep 2023 01:16:54 -0700 (PDT)
Message-ID: <d78b19ef-0fb7-4fc3-bf01-58c10b4fd1cd@linaro.org>
Date:   Fri, 8 Sep 2023 10:16:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] interconnect: qcom: Add SM4450 interconnect provider
 driver
Content-Language: en-US
To:     Tengfei Fan <quic_tengfan@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, djakov@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        catalin.marinas@arm.com, will@kernel.org
Cc:     arnd@arndb.de, geert+renesas@glider.be, nfraprado@collabora.com,
        rafal@milecki.pl, peng.fan@nxp.com, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        quic_tsoni@quicinc.com, quic_shashim@quicinc.com,
        quic_kaushalk@quicinc.com, quic_tdas@quicinc.com,
        quic_tingweiz@quicinc.com, quic_aiquny@quicinc.com,
        kernel@quicinc.com
References: <20230908064427.26999-1-quic_tengfan@quicinc.com>
 <20230908064427.26999-3-quic_tengfan@quicinc.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 xsFNBF9ALYUBEADWAhxdTBWrwAgDQQzc1O/bJ5O7b6cXYxwbBd9xKP7MICh5YA0DcCjJSOum
 BB/OmIWU6X+LZW6P88ZmHe+KeyABLMP5s1tJNK1j4ntT7mECcWZDzafPWF4F6m4WJOG27kTJ
 HGWdmtO+RvadOVi6CoUDqALsmfS3MUG5Pj2Ne9+0jRg4hEnB92AyF9rW2G3qisFcwPgvatt7
 TXD5E38mLyOPOUyXNj9XpDbt1hNwKQfiidmPh5e7VNAWRnW1iCMMoKqzM1Anzq7e5Afyeifz
 zRcQPLaqrPjnKqZGL2BKQSZDh6NkI5ZLRhhHQf61fkWcUpTp1oDC6jWVfT7hwRVIQLrrNj9G
 MpPzrlN4YuAqKeIer1FMt8cq64ifgTzxHzXsMcUdclzq2LTk2RXaPl6Jg/IXWqUClJHbamSk
 t1bfif3SnmhA6TiNvEpDKPiT3IDs42THU6ygslrBxyROQPWLI9IL1y8S6RtEh8H+NZQWZNzm
 UQ3imZirlPjxZtvz1BtnnBWS06e7x/UEAguj7VHCuymVgpl2Za17d1jj81YN5Rp5L9GXxkV1
 aUEwONM3eCI3qcYm5JNc5X+JthZOWsbIPSC1Rhxz3JmWIwP1udr5E3oNRe9u2LIEq+wH/toH
 kpPDhTeMkvt4KfE5m5ercid9+ZXAqoaYLUL4HCEw+HW0DXcKDwARAQABzShLb25yYWQgRHli
 Y2lvIDxrb25yYWQuZHliY2lvQGxpbmFyby5vcmc+wsGOBBMBCAA4FiEEU24if9oCL2zdAAQV
 R4cBcg5dfFgFAmQ5bqwCGwMFCwkIBwIGFQoJCAsCBBYCAwECHgECF4AACgkQR4cBcg5dfFjO
 BQ//YQV6fkbqQCceYebGg6TiisWCy8LG77zV7DB0VMIWJv7Km7Sz0QQrHQVzhEr3trNenZrf
 yy+o2tQOF2biICzbLM8oyQPY8B///KJTWI2khoB8IJSJq3kNG68NjPg2vkP6CMltC/X3ohAo
 xL2UgwN5vj74QnlNneOjc0vGbtA7zURNhTz5P/YuTudCqcAbxJkbqZM4WymjQhe0XgwHLkiH
 5LHSZ31MRKp/+4Kqs4DTXMctc7vFhtUdmatAExDKw8oEz5NbskKbW+qHjW1XUcUIrxRr667V
 GWH6MkVceT9ZBrtLoSzMLYaQXvi3sSAup0qiJiBYszc/VOu3RbIpNLRcXN3KYuxdQAptacTE
 mA+5+4Y4DfC3rUSun+hWLDeac9z9jjHm5rE998OqZnOU9aztbd6zQG5VL6EKgsVXAZD4D3RP
 x1NaAjdA3MD06eyvbOWiA5NSzIcC8UIQvgx09xm7dThCuQYJR4Yxjd+9JPJHI6apzNZpDGvQ
 BBZzvwxV6L1CojUEpnilmMG1ZOTstktWpNzw3G2Gis0XihDUef0MWVsQYJAl0wfiv/0By+XK
 mm2zRR+l/dnzxnlbgJ5pO0imC2w0TVxLkAp0eo0LHw619finad2u6UPQAkZ4oj++iIGrJkt5
 Lkn2XgB+IW8ESflz6nDY3b5KQRF8Z6XLP0+IEdLOOARkOW7yEgorBgEEAZdVAQUBAQdAwmUx
 xrbSCx2ksDxz7rFFGX1KmTkdRtcgC6F3NfuNYkYDAQgHwsF2BBgBCAAgFiEEU24if9oCL2zd
 AAQVR4cBcg5dfFgFAmQ5bvICGwwACgkQR4cBcg5dfFju1Q//Xta1ShwL0MLSC1KL1lXGXeRM
 8arzfyiB5wJ9tb9U/nZvhhdfilEDLe0jKJY0RJErbdRHsalwQCrtq/1ewQpMpsRxXzAjgfRN
 jc4tgxRWmI+aVTzSRpywNahzZBT695hMz81cVZJoZzaV0KaMTlSnBkrviPz1nIGHYCHJxF9r
 cIu0GSIyUjZ/7xslxdvjpLth16H27JCWDzDqIQMtg61063gNyEyWgt1qRSaK14JIH/DoYRfn
 jfFQSC8bffFjat7BQGFz4ZpRavkMUFuDirn5Tf28oc5ebe2cIHp4/kajTx/7JOxWZ80U70mA
 cBgEeYSrYYnX+UJsSxpzLc/0sT1eRJDEhI4XIQM4ClIzpsCIN5HnVF76UQXh3a9zpwh3dk8i
 bhN/URmCOTH+LHNJYN/MxY8wuukq877DWB7k86pBs5IDLAXmW8v3gIDWyIcgYqb2v8QO2Mqx
 YMqL7UZxVLul4/JbllsQB8F/fNI8AfttmAQL9cwo6C8yDTXKdho920W4WUR9k8NT/OBqWSyk
 bGqMHex48FVZhexNPYOd58EY9/7mL5u0sJmo+jTeb4JBgIbFPJCFyng4HwbniWgQJZ1WqaUC
 nas9J77uICis2WH7N8Bs9jy0wQYezNzqS+FxoNXmDQg2jetX8en4bO2Di7Pmx0jXA4TOb9TM
 izWDgYvmBE8=
In-Reply-To: <20230908064427.26999-3-quic_tengfan@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8.09.2023 08:44, Tengfei Fan wrote:
> Add driver for the Qualcomm interconnect buses found in SM4450 based
> platforms. The topology consists of several NoCs that are controlled
> by a remote processor that collects the aggregated bandwidth for each
> master-slave pairs.
> 
> Signed-off-by: Tengfei Fan <quic_tengfan@quicinc.com>
> ---
[...]

> +++ b/drivers/interconnect/qcom/sm4450.c
> @@ -0,0 +1,1848 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) 2023, Qualcomm Innovation Center, Inc. All rights reserved.
> + *
Stray blank line
> + */
> +
> +#include <linux/device.h>
> +#include <linux/interconnect.h>
> +#include <linux/interconnect-provider.h>
> +#include <linux/io.h>
Is this necessary?

> +#include <linux/module.h>
> +#include <linux/of_device.h>
> +#include <linux/of_platform.h>
> +#include <linux/platform_device.h>
> +#include <dt-bindings/interconnect/qcom,sm4450.h>
> +
[...]

> +static struct qcom_icc_node * const mmss_noc_nodes[] = {
> +	[MASTER_CAMNOC_HF] = &qnm_camnoc_hf,
> +	[MASTER_CAMNOC_ICP] = &qnm_camnoc_icp,
> +	[MASTER_CAMNOC_SF] = &qnm_camnoc_sf,
> +	[MASTER_MDP] = &qnm_mdp,
> +	[MASTER_CNOC_MNOC_CFG] = &qnm_mnoc_cfg,
> +	[MASTER_VIDEO_P0_MMNOC] = &qnm_video0,
> +	[MASTER_VIDEO_PROC_MMNOC] = &qnm_video_cpu,
> +	[SLAVE_MNOC_HF_MEM_NOC] = &qns_mem_noc_hf,
> +	[SLAVE_MNOC_SF_MEM_NOC] = &qns_mem_noc_sf,
> +	[SLAVE_SERVICE_MNOC] = &srvc_mnoc,
> +	[MASTER_MDP_DISP] = &qnm_mdp_disp,
> +	[SLAVE_MNOC_HF_MEM_NOC_DISP] = &qns_mem_noc_hf_disp,
Please drop the _DISP paths, upstream will handle these with icc
tags.

[...]

> +
> +static const struct of_device_id qnoc_of_match[] = {
> +	{ .compatible = "qcom,sm4450-aggre1-noc",
> +	  .data = &sm4450_aggre1_noc},
Nit, but please:

- make these one line, like this:
{ .compatible = "qcom,sm4450-aggre1-noc", .data = &sm4450_aggre1_noc },

- add the missing space before '}'

Konrad

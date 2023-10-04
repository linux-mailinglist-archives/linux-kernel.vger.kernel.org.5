Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92D007B97F5
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 00:25:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233563AbjJDWY7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 18:24:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231764AbjJDWY5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 18:24:57 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D429BD;
        Wed,  4 Oct 2023 15:24:53 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-4066241289bso3103955e9.0;
        Wed, 04 Oct 2023 15:24:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696458292; x=1697063092; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qQFWBrOYAp5NpFTM1Af3NjiYPnsYpCJxVJwm3GdqXS8=;
        b=arx9x5YZmPzUKxF0NPhlNhQ/R/98sgg7M6EjBqNDhBhipLryyPdrGTU6efjm9G5Cjk
         MaH2TzrJOANaJzHRgsw1vYTYNjuR4RCLL5Ls/NqW2hTzTQrEU8YV/r/rgOGvyXBqGcQX
         WBbyrgymcp+XXuQ2aCzUURGvYdUDayeQ3D5RFXrJyId/ZcZuIjt+W6QH1SdBTygaO+Xi
         47QtsUuaRVrw8/erB8Kww+UkTc6612PzFGNlxDkA1Q5bIZfQ59YrNAyKhxceIA3Cv1KH
         esFsa3I5N7VnEOUt4o8a9GgT05L4uc6YGuNifgM4Nxp+G2F3fzwXviYFTYpIgG+NKO9r
         Ow1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696458292; x=1697063092;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qQFWBrOYAp5NpFTM1Af3NjiYPnsYpCJxVJwm3GdqXS8=;
        b=n6AFbjTS/19kCRS3g4e16bb0hIXJ+uyhEetrzPltWs1XM2KUJkmbTamIWtY40T2Hu5
         BtL8MVkwknvJh+Sh0eqst1k2Xw1xvi80olxK1uASd6d+plJVj8H50ynVoVAgNOthQ08S
         ljJPjQASEvYqLBseZtJRmlP1w6oRbjMQELYDAlImX8Qt8sad9fVQMktfbd9NFU6/A0Nz
         mDBOF979o47nx4l4CsCP//XlrigOtlMuwhsZ5tFX26bd1FG/vNSr+/H4geJqFimxnHJ+
         PuFUuKRSFm9XeBYopGYNFd6mXLFLTyB66t/LKRiRsG6Rr6g5cGvNhilTztPa4D4QlPdB
         RBlQ==
X-Gm-Message-State: AOJu0YwhbdMtIZ4UEHmAwvyXItINbG7ak/NcAhYxmzlwhsoEJWg+esvf
        i/u3VE6bPrlBMbx0iXLijzw=
X-Google-Smtp-Source: AGHT+IFj8WABqgRfznAEy8ch+9fSdyUe+RM+yFOTyygeOaRuTt+CHo+jso35MqPi7l/SxVDaccS2Yg==
X-Received: by 2002:a05:600c:3502:b0:406:44e6:c00d with SMTP id h2-20020a05600c350200b0040644e6c00dmr3679199wmq.2.1696458291677;
        Wed, 04 Oct 2023 15:24:51 -0700 (PDT)
Received: from ?IPV6:2a02:8071:b783:140:927c:82ba:d32d:99c1? ([2a02:8071:b783:140:927c:82ba:d32d:99c1])
        by smtp.gmail.com with ESMTPSA id bd5-20020a05600c1f0500b004030e8ff964sm2462044wmb.34.2023.10.04.15.24.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Oct 2023 15:24:51 -0700 (PDT)
Message-ID: <4ab66f17-4686-411f-b829-74eab3489568@gmail.com>
Date:   Thu, 5 Oct 2023 00:24:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 11/11] firmware: qcom: scm: enable SHM bridge
Content-Language: en-US
To:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        kernel@quicinc.com,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
References: <20230928092040.9420-1-brgl@bgdev.pl>
 <20230928092040.9420-12-brgl@bgdev.pl>
From:   Maximilian Luz <luzmaximilian@gmail.com>
In-Reply-To: <20230928092040.9420-12-brgl@bgdev.pl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/28/23 11:20, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> Extens the SCM memory allocator with using the SHM Bridge feature if
> available on the platform. This makes the trustzone only use dedicated
> buffers for SCM calls. We map the entire SCM genpool as a bridge.
> 
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

This patch breaks something in early boot on my Surface Pro X (sc8180x).
Unfortunately I can't provide many details at the moment because the
only thing I can see are RCU stalls, and the traces from them are quite
useless.

Without this patch, the rest of the series (with the fix you posted on
patch 6 applied) seems to work fine. Including both RFT qseecom patches.

I plan to have a closer look at this once I have some more time though.

Regards,
Max

> ---
>   drivers/firmware/qcom/qcom_scm-mem.c | 42 ++++++++++++++++++++++++++--
>   1 file changed, 39 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/firmware/qcom/qcom_scm-mem.c b/drivers/firmware/qcom/qcom_scm-mem.c
> index eafecbe23770..12b12b15f46f 100644
> --- a/drivers/firmware/qcom/qcom_scm-mem.c
> +++ b/drivers/firmware/qcom/qcom_scm-mem.c
> @@ -16,6 +16,8 @@
>   
>   #include "qcom_scm.h"
>   
> +#define QCOM_SHM_BRIDGE_NUM_VM_SHIFT 9
> +
>   static size_t qcom_scm_mem_pool_size = SZ_2M;
>   module_param_named(qcom_scm_mem_pool_size, qcom_scm_mem_pool_size,
>   		   ulong, 0400);
> @@ -108,8 +110,24 @@ phys_addr_t qcom_scm_mem_to_phys(void *vaddr)
>   	return chunk->paddr;
>   }
>   
> +static int qcom_scm_mem_shm_bridge_create(void)
> +{
> +	uint64_t pfn_and_ns_perm, ipfn_and_s_perm, size_and_flags, ns_perms;
> +
> +	ns_perms = (QCOM_SCM_PERM_WRITE | QCOM_SCM_PERM_READ);
> +	pfn_and_ns_perm = (u64)qcom_scm_mem.pbase | ns_perms;
> +	ipfn_and_s_perm = (u64)qcom_scm_mem.pbase | ns_perms;
> +	size_and_flags = qcom_scm_mem.size | (1 << QCOM_SHM_BRIDGE_NUM_VM_SHIFT);
> +
> +	return qcom_scm_create_shm_bridge(qcom_scm_mem.dev, pfn_and_ns_perm,
> +					  ipfn_and_s_perm, size_and_flags,
> +					  QCOM_SCM_VMID_HLOS);
> +}
> +
>   int qcom_scm_mem_enable(struct device *dev)
>   {
> +	int ret;
> +
>   	INIT_RADIX_TREE(&qcom_scm_mem.chunks, GFP_ATOMIC);
>   	spin_lock_init(&qcom_scm_mem.lock);
>   	qcom_scm_mem.dev = dev;
> @@ -128,7 +146,25 @@ int qcom_scm_mem_enable(struct device *dev)
>   
>   	gen_pool_set_algo(qcom_scm_mem.pool, gen_pool_best_fit, NULL);
>   
> -	return gen_pool_add_virt(qcom_scm_mem.pool,
> -				 (unsigned long)qcom_scm_mem.vbase,
> -				 qcom_scm_mem.pbase, qcom_scm_mem.size, -1);
> +	ret = gen_pool_add_virt(qcom_scm_mem.pool,
> +				(unsigned long)qcom_scm_mem.vbase,
> +				qcom_scm_mem.pbase, qcom_scm_mem.size, -1);
> +	if (ret)
> +		return ret;
> +
> +	ret = qcom_scm_enable_shm_bridge();
> +	if (ret) {
> +		if (ret == EOPNOTSUPP)
> +			dev_info(dev, "SHM Bridge not supported\n");
> +		else
> +			return ret;
> +	} else {
> +		ret = qcom_scm_mem_shm_bridge_create();
> +		if (ret)
> +			return ret;
> +
> +		dev_info(dev, "SHM Bridge enabled\n");
> +	}
> +
> +	return 0;
>   }

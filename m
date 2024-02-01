Return-Path: <linux-kernel+bounces-48478-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ECFC845C94
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 17:11:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BED031F21E2E
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 16:11:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10985626D4;
	Thu,  1 Feb 2024 16:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gf9N5JmE"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 563A6626B3
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 16:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706803889; cv=none; b=MEczCJxHDAnLEJ4caEF+ES+bEo9mZL5x6YHawxRxfrblqM7H1VdmKUDjyxy2LfKhNvakejxZJfmbPY3gJRO5LtY5KlpqNsiN64pXC+BnaNejdgq8EdggEH3g+vG2Vz67alGTKLMtX9iVLtf7EDyXhqG5YaZM/VguH7OX0dziTeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706803889; c=relaxed/simple;
	bh=apJLdzMZKNqZkxhr/A8+CNCpsUOL9GHK5UhU9ZsNJTk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lJYB/Z2V+uY4uPxWS6eaaRjdOv8svWUMNo4q2zVnvdt5Anew+mcA9OY/fOSW5tLGo1m/hk3JhyAE1swTFKumAxROXgTQkw9A2w50PYUf6zd/b5zJwhgqE6Um2Osr2/rHQ6rE9E4Oryyr8mjTHyxwEqRvbByzTCOrsu9G5zx7WZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gf9N5JmE; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a30e445602cso482838866b.0
        for <linux-kernel@vger.kernel.org>; Thu, 01 Feb 2024 08:11:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706803885; x=1707408685; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8pjHDOWqTPfZAnEZAI0E4Dw26mHdRawBX0HOJq1N4u8=;
        b=gf9N5JmE4Cg19vElele8rOlai+vTyHCI1HvQuAOq2r4ekDwPWxOyVBsskf/ud04Z9o
         wkrhmXBhFjPDyhAW0mXXh1GLEMXzJr6AgMaE1UWJH5jbH1W9Msn69cvC3BbQTiQZAJhJ
         rtpj+nZ3gYzFJXGoV9ltvJ2Hp2YeMu+Lv4jnolOgjQgpg8LlR/hwQFnGHWDmgPrCrpTT
         pxeSMSJzY4tsnSoSsWY1CuvnFmFy9AH29QNSAMKumvdfrM/Wj7YhY0Fbwk+GlLKDbeKI
         p1p3wLuZi8BSI3vTtE+xt8ic1xH69QMGFl/w6H4arFrLyTdPb+4TkOyWCxZro7LuxYbM
         GeCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706803885; x=1707408685;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8pjHDOWqTPfZAnEZAI0E4Dw26mHdRawBX0HOJq1N4u8=;
        b=I2SiGlpoQr/EWI/wckScRPLd/oYwx6fya/Mx0ruWT+NUwUgrrA7pHzdeO5LSmzarC3
         kKaUVteq7Qg2ASsHmLvrOKpFaqH53RwSmD/5Nmf6pn6eXMV6J2goImCrsGn9qtzwqxRg
         aeG2MiQu9qLeTAwdvTHUsTF29fRCz2jUr7IiFaB1u3kbCbcamGjTG4B4HnkcUgbTlFs3
         iD75IBgovUDYPwC6pXzj6ZgRBAq/iwrv6JpJp/4ZRP8FsV2OfyNK+T4WhBlMRw98SjPo
         gdQ00A7gVzqQLAj3G5nU0mZIHuIK3DXWI3e5WRL1IHBTqfoBXtDbBfzB2emJ2bjM/B1b
         I40A==
X-Gm-Message-State: AOJu0YwuNdLYdDIyGGcsThKBy5NM/0lPHm1K808Zz3b8LR8rjE75+fok
	fUcINhlfDNhuvhabIzFMcasMkm4Q7rOBQVQbfSpLS2Hgk7cI+nExP1hBvjf1anY=
X-Google-Smtp-Source: AGHT+IEuxOZ2oi/31tSTIMkkw25aN7dth0mVptYES/tdHDb9mAGvYyXsbecw2G/Xeve7QNqJa1stlg==
X-Received: by 2002:a17:906:bf47:b0:a36:c3e3:9161 with SMTP id ps7-20020a170906bf4700b00a36c3e39161mr1985471ejb.2.1706803885632;
        Thu, 01 Feb 2024 08:11:25 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCU/oxTWPCj5ijULfiynzTYVPiC/wr+Vzjr8rOv48rN16ZEY/9jMKGTf0kHr2muV7oKatpzSPKY5jUlC3zJoBGpF203jONzgtAZ1kjk1kwjLdSUT9/3HVfSOg/1AdJNvbLy5JrQe5ck3RxMLfZ29iEus+a42w3s+zwmQ4bYVuU4+TWLP343L120JeB9kB1arU5Sn7F4Y2jQsPXIyHF4wmcKchFwNj3AGSOXlpok9RbF7Pq7GINIifkNxamgEC3q3Llrocl0KyUKi84M6zaLjA8OCBEEuE7TMt6IsDMaIWvC16aiVhFsgNKwSQEiymKoi6yhn0NsCHM467dCtMSB5cCCEiOdrRPeT16RKZ9NEReEZF2JP53omadRzWjSeABfLyDht/4tbnYjh0jkfLHnk065+vGwYaQQdnrD6uY2UdJQ/OEPrs+qQBEJoQ278h9YKPMM6KYuUSS+P0/79uDwOESGASpyqV2s3yUayAAWhPdkHeuPSDp1FNPfd48gTgExO4dlWW+vVaE4SdaHoSCEqibNSZlUJPhiIe5K8Mf7yHR1Z+0xbuI6Y14akzpAWFVaFBWGRB6NzBdWK3imdrYXVfsqEGKfix4/wJw/bopl+admnZ8gc1fZ5dTrGFt2gkLYHDj6tDF8/ite+8YnEduzPFswC4qGYZgp2w8BpgeRDtblyOTdTptKb2O+/FQCQtGWp4H0AZBNRoeC8ylLr/qPGb7dQjcehNmOnc+Y8+GpciSDHQwxuB4uNZOKP7qaQ9bp2NNXImSGwdOL93ZbBL2fmF6hzPCc5eZ+ejLQ0FxFolVj0mqhAGaU=
Received: from [192.168.159.104] (178235179129.dynamic-4-waw-k-1-3-0.vectranet.pl. [178.235.179.129])
        by smtp.gmail.com with ESMTPSA id w15-20020a17090652cf00b00a2e81e4876dsm7299086ejn.44.2024.02.01.08.11.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Feb 2024 08:11:25 -0800 (PST)
Message-ID: <b06b3b13-3d61-4bf6-bc06-80ca1a189a4f@linaro.org>
Date: Thu, 1 Feb 2024 17:11:22 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 02/15] qcom_scm: scm call for deriving a software
 secret
Content-Language: en-US
To: Gaurav Kashyap <quic_gaurkash@quicinc.com>,
 linux-arm-msm@vger.kernel.org, linux-scsi@vger.kernel.org,
 andersson@kernel.org, ebiggers@google.com, neil.armstrong@linaro.org,
 srinivas.kandagatla@linaro.org, krzysztof.kozlowski+dt@linaro.org,
 conor+dt@kernel.org, robh+dt@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
 kernel@quicinc.com, linux-crypto@vger.kernel.org,
 devicetree@vger.kernel.org, quic_omprsing@quicinc.com,
 quic_nguyenb@quicinc.com, bartosz.golaszewski@linaro.org,
 ulf.hansson@linaro.org, jejb@linux.ibm.com, martin.petersen@oracle.com,
 mani@kernel.org, davem@davemloft.net, herbert@gondor.apana.org.au
References: <20240127232436.2632187-1-quic_gaurkash@quicinc.com>
 <20240127232436.2632187-3-quic_gaurkash@quicinc.com>
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <20240127232436.2632187-3-quic_gaurkash@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 28.01.2024 00:14, Gaurav Kashyap wrote:
> Inline storage encryption may require deriving a software
> secret from storage keys added to the kernel.
> 
> For non-wrapped keys, this can be directly done in the kernel as
> keys are in the clear.
> 
> However, hardware wrapped keys can only be unwrapped by the wrapping
> entity. In case of Qualcomm's wrapped key solution, this is done by
> the Hardware Key Manager (HWKM) from Trustzone.
> Hence, adding a new SCM call which in the end provides a hook
> to the software secret crypto profile API provided by the block
> layer.
> 
> Signed-off-by: Gaurav Kashyap <quic_gaurkash@quicinc.com>
> Tested-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>  drivers/firmware/qcom/qcom_scm.c       | 65 ++++++++++++++++++++++++++
>  drivers/firmware/qcom/qcom_scm.h       |  1 +
>  include/linux/firmware/qcom/qcom_scm.h |  2 +
>  3 files changed, 68 insertions(+)
> 
> diff --git a/drivers/firmware/qcom/qcom_scm.c b/drivers/firmware/qcom/qcom_scm.c
> index 7e17fd662bda..4882f8a36453 100644
> --- a/drivers/firmware/qcom/qcom_scm.c
> +++ b/drivers/firmware/qcom/qcom_scm.c
> @@ -1220,6 +1220,71 @@ int qcom_scm_ice_set_key(u32 index, const u8 *key, u32 key_size,
>  }
>  EXPORT_SYMBOL_GPL(qcom_scm_ice_set_key);
>  
> +/**
> + * qcom_scm_derive_sw_secret() - Derive software secret from wrapped key
> + * @wkey: the hardware wrapped key inaccessible to software
> + * @wkey_size: size of the wrapped key
> + * @sw_secret: the secret to be derived which is exactly the secret size
> + * @sw_secret_size: size of the sw_secret
> + *
> + * Derive a software secret from a hardware wrapped key for software crypto
> + * operations.
> + * For wrapped keys, the key needs to be unwrapped, in order to derive a
> + * software secret, which can be done in the hardware from a secure execution
> + * environment.
> + *
> + * For more information on sw secret, please refer to "Hardware-wrapped keys"
> + * section of Documentation/block/inline-encryption.rst.
> + *
> + * Return: 0 on success; -errno on failure.
> + */
> +int qcom_scm_derive_sw_secret(const u8 *wkey, size_t wkey_size,
> +			      u8 *sw_secret, size_t sw_secret_size)
> +{
> +	struct qcom_scm_desc desc = {
> +		.svc = QCOM_SCM_SVC_ES,
> +		.cmd =  QCOM_SCM_ES_DERIVE_SW_SECRET,
> +		.arginfo = QCOM_SCM_ARGS(4, QCOM_SCM_RW,
> +					 QCOM_SCM_VAL, QCOM_SCM_RW,
> +					 QCOM_SCM_VAL),
> +		.args[1] = wkey_size,
> +		.args[3] = sw_secret_size,
> +		.owner = ARM_SMCCC_OWNER_SIP,
> +	};
> +
> +	void *secret_buf;
> +	void *wkey_buf;
> +	int ret;
> +
> +	wkey_buf = qcom_tzmem_alloc(__scm->mempool, wkey_size, GFP_KERNEL);
> +	if (!wkey_buf)
> +		return -ENOMEM;
> +
> +	secret_buf = qcom_tzmem_alloc(__scm->mempool, sw_secret_size, GFP_KERNEL);
> +	if (!secret_buf) {
> +		ret = -ENOMEM;
> +		goto err_free_wrapped;
> +	}
> +
> +	memcpy(wkey_buf, wkey, wkey_size);
> +	desc.args[0] = qcom_tzmem_to_phys(wkey_buf);
> +	desc.args[2] = qcom_tzmem_to_phys(secret_buf);
> +
> +	ret = qcom_scm_call(__scm->dev, &desc, NULL);
> +	if (!ret)
> +		memcpy(sw_secret, secret_buf, sw_secret_size);
> +
> +	memzero_explicit(secret_buf, sw_secret_size);
> +	qcom_tzmem_free(secret_buf);
> +
> +err_free_wrapped:
> +	memzero_explicit(wkey_buf, wkey_size);
> +	qcom_tzmem_free(wkey_buf);
__free(qcom_tzmem) attribute instead?

Konrad



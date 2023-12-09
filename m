Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37BCB80B5D5
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Dec 2023 19:15:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229586AbjLISGN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Dec 2023 13:06:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjLISGM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Dec 2023 13:06:12 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15C24E5
        for <linux-kernel@vger.kernel.org>; Sat,  9 Dec 2023 10:06:17 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-54c9116d05fso4379930a12.3
        for <linux-kernel@vger.kernel.org>; Sat, 09 Dec 2023 10:06:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702145175; x=1702749975; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=S92a7fqULbrEMilkRlrKeNQnqm+Il9bmhuzzD2asOkg=;
        b=NizuPfqWMgVWF4VcEgAx40XFLOAEllWZse4VnaUNpUibeysy2Tnl54KESJiWyHZciP
         jEyc0QQTls+cBoKfrpLngh2ddcWCv96Yo4SYGcSbhCpVFQzh3d1bDeYakrELp+LWE31o
         GVn9EQP/1cXom56mSZ0mYcOPOak7K6Ms3+8ZDrLDCoG/44WVL9N2EkhTV/84bgQlAcUe
         GtyA/lAReRFyvAa1eVqMbML66q8+jHkr+Z0oFwvsXCtdA6j//gfm4IC5kmxIA7seI089
         8/daFBhQp5Nhq62rC7ip3H02ca3/eto/BsmG6pDdbplGH/4ZBxdfUCxayxwkVCEIREKd
         Cwyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702145175; x=1702749975;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S92a7fqULbrEMilkRlrKeNQnqm+Il9bmhuzzD2asOkg=;
        b=BHn42m3eg+4tP8vpcfQVbcTwLAGrrqAjHZGPZ7gOYMOlNPIHC/rNjQs1vnZKK2WRoo
         bs7ETuBKkBioWFJAwMwdzlXIohAEdm7ncAEbfO3MFd1XR6qT3W3h/xM8SmR20NYJUqei
         nKw4ufzjjouJilmVT26iS20IMea56WXBWkqDIlj70HtikStJSQyOw2UV2DhA4RfY61vR
         qmsm3ExvsT+QAcWNfjD+NN4HnXy5+9BqKzmN65bIKPGEcABr6TLXm/xcsw16NOJWdPn6
         xtujSxdiLrYvV7D48VE9hs8KkkTyqrzPgdZBdkmBF2NPvgjDd5d4cyM6SCKGBa39LxY7
         sOqg==
X-Gm-Message-State: AOJu0YzT+l8oS1sDazl7YdZRMh7Me8y5D0Fm9OupPwHx2kL8h2vtGmC0
        d6FE5VSDs8cN9GkMGRRurn1FPH7+oKjmWKcayt0=
X-Google-Smtp-Source: AGHT+IGL+RUzfiNlVYUbxi/RKdaYhCItlqf4dDEDP5kV2JQ/KdKdV2e0gKg2iTuBh4O/UcwbdVurpw==
X-Received: by 2002:a50:85c6:0:b0:54c:8890:6ff2 with SMTP id q6-20020a5085c6000000b0054c88906ff2mr670070edh.13.1702145175453;
        Sat, 09 Dec 2023 10:06:15 -0800 (PST)
Received: from [192.168.36.128] (178235179179.dynamic-4-waw-k-1-3-0.vectranet.pl. [178.235.179.179])
        by smtp.gmail.com with ESMTPSA id h28-20020a50cddc000000b0054c72a6a07csm1948184edj.84.2023.12.09.10.06.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 09 Dec 2023 10:06:15 -0800 (PST)
Message-ID: <76f18323-a59e-4724-96ec-6306e5dcd2dc@linaro.org>
Date:   Sat, 9 Dec 2023 19:06:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/3] remoteproc: qcom: pas: make region assign more
 generic
Content-Language: en-US
To:     Neil Armstrong <neil.armstrong@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mukesh Ojha <quic_mojha@quicinc.com>
References: <20231208-topic-sm8650-upstream-remoteproc-v4-0-a96c3e5f0913@linaro.org>
 <20231208-topic-sm8650-upstream-remoteproc-v4-2-a96c3e5f0913@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <20231208-topic-sm8650-upstream-remoteproc-v4-2-a96c3e5f0913@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8.12.2023 16:04, Neil Armstrong wrote:
> The current memory region assign only supports a single
> memory region.
> 
> But new platforms introduces more regions to make the
> memory requirements more flexible for various use cases.
> Those new platforms also shares the memory region between the
> DSP and HLOS.
> 
> To handle this, make the region assign more generic in order
> to support more than a single memory region and also permit
> setting the regions permissions as shared.
> 
> Reviewed-by: Mukesh Ojha <quic_mojha@quicinc.com>
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
[...]

> +	for (offset = 0; offset < adsp->region_assign_count; ++offset) {
> +		struct reserved_mem *rmem = NULL;
> +
> +		node = of_parse_phandle(adsp->dev->of_node, "memory-region",
> +					adsp->region_assign_idx + offset);
> +		if (node)
> +			rmem = of_reserved_mem_lookup(node);
> +		of_node_put(node);
Shouldn't this only be called when parse_phandle succeeds? (separate
patch with a fix + cc stable if so?)

> +		if (!rmem) {
> +			dev_err(adsp->dev, "unable to resolve shareable memory-region index %d\n",
> +				offset);
> +			return -EINVAL;
> +		}
>  
> -	perm.vmid = QCOM_SCM_VMID_MSS_MSA;
> -	perm.perm = QCOM_SCM_PERM_RW;
> +		if (adsp->region_assign_shared)  {
> +			perm[0].vmid = QCOM_SCM_VMID_HLOS;
> +			perm[0].perm = QCOM_SCM_PERM_RW;
> +			perm[1].vmid = adsp->region_assign_vmid;
> +			perm[1].perm = QCOM_SCM_PERM_RW;
> +			perm_size = 2;
> +		} else {
> +			perm[0].vmid = adsp->region_assign_vmid;
> +			perm[0].perm = QCOM_SCM_PERM_RW;
> +			perm_size = 1;
> +		}
>  
> -	adsp->region_assign_phys = rmem->base;
> -	adsp->region_assign_size = rmem->size;
> -	adsp->region_assign_perms = BIT(QCOM_SCM_VMID_HLOS);
> +		adsp->region_assign_phys[offset] = rmem->base;
> +		adsp->region_assign_size[offset] = rmem->size;
> +		adsp->region_assign_perms[offset] = BIT(QCOM_SCM_VMID_HLOS);
>  
> -	ret = qcom_scm_assign_mem(adsp->region_assign_phys,
> -				  adsp->region_assign_size,
> -				  &adsp->region_assign_perms,
I think this should be renamed to region_assign_owner(s)

> -				  &perm, 1);
> -	if (ret < 0) {
> -		dev_err(adsp->dev, "assign memory failed\n");
> -		return ret;
> +		ret = qcom_scm_assign_mem(adsp->region_assign_phys[offset],
> +					  adsp->region_assign_size[offset],
> +					  &adsp->region_assign_perms[offset],
> +					  perm, perm_size);
> +		if (ret < 0) {
> +			dev_err(adsp->dev, "assign memory %d failed\n", offset);
> +			return ret;
> +		}
>  	}
>  
>  	return 0;
> @@ -629,20 +653,23 @@ static int adsp_assign_memory_region(struct qcom_adsp *adsp)
>  static void adsp_unassign_memory_region(struct qcom_adsp *adsp)
>  {
>  	struct qcom_scm_vmperm perm;
> +	int offset;
>  	int ret;
>  
> -	if (!adsp->region_assign_idx)
> +	if (!adsp->region_assign_idx || adsp->region_assign_shared)
So when it's *shared*, we don't want to un-assign it?

Konrad

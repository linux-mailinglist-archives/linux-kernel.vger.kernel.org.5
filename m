Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D811180C54C
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 10:54:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234672AbjLKJyd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 04:54:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbjLKJyb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 04:54:31 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F9F4CB
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 01:54:37 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-a1e2f34467aso403148066b.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 01:54:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702288475; x=1702893275; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=p8MzHulTEQwH/VQnablYSXp/5FraUwl5sD73PXbZ4w8=;
        b=T6Yrzkh5hEGbDH0CzOy2S9CWb2s20XhCh3I30Wu1vFElaqcvXiXIR2vOG79qazljv7
         4FuNnrhSUKnT8Xj6hRjLwWWvOfDcppoa9VqGUzfYW7dHO5BAJB7wtWvbb1pvWawrAsN4
         BWRo+2sGpQOgXpR5Cg6ygiovHoFNqyxF5Ppmc7Ihc9wjUcbJ8W05oKTAcCU9kFHmkdFH
         sG2bDHBLEGYraNuUwJjLwjUExRq/5dXrr2SsdNLPgatqdsZ+EpFq8/+XsiiQOoi27wFg
         oR59IPNEPeaioZCslz9r5NfAm0r5pQmevUTY5ufYldJIRmZeQug17mEQEHCGgO29hUmJ
         3O1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702288475; x=1702893275;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=p8MzHulTEQwH/VQnablYSXp/5FraUwl5sD73PXbZ4w8=;
        b=lmadAqfzPYHRJnkCtpz9LbByGYGvT3QnpInv0sapJU91vNwZRUGLC4yENHpM5SMm90
         ugweYIN04fLNwcO4AVHcaziA0sPFo2xjJBnmg8cSXtKS7C7XEcmgRjWVzTQgF6gUMF8a
         NOFwxLVx5rBt0SqLw0qgCCZI4aYdniYfTJO3AfVlAYalRN/IFJa5O/ZU3w8uypWmEy95
         2a4yVZU3778VynH/REwnAsFLyky7fR8qSBd4+hAdu/p8V7a+/MqpE7INMSaLxdy3la3/
         RwbCrKLrZ3tdnPcUnNSsfBzFiU7iu9FGtjKgAu1mnuL7eyvLvsHePt79NL5x9citI8Xt
         xQgw==
X-Gm-Message-State: AOJu0YwnTfSUIU3PznTLvsDkvgdy15fc8eX2g6VchqspBn4ZuH55j4Hj
        eXEpgnpfTdtxY9FFmkxdluLGqg==
X-Google-Smtp-Source: AGHT+IHi4QlNj65ZQfumqsdLjNth9FBw+GFWxsZPakyfaKaeNeVo5RyqAs8bO0WKPGQi2cmGf3OPiw==
X-Received: by 2002:a17:906:7490:b0:a1f:99e1:8a67 with SMTP id e16-20020a170906749000b00a1f99e18a67mr954087ejl.2.1702288475189;
        Mon, 11 Dec 2023 01:54:35 -0800 (PST)
Received: from [192.168.36.128] (178235179179.dynamic-4-waw-k-1-3-0.vectranet.pl. [178.235.179.179])
        by smtp.gmail.com with ESMTPSA id tb16-20020a1709078b9000b00a1d06fb6800sm4507360ejc.36.2023.12.11.01.54.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Dec 2023 01:54:34 -0800 (PST)
Message-ID: <b4b0ed80-eed5-4045-8ceb-5b507c77e4e2@linaro.org>
Date:   Mon, 11 Dec 2023 10:54:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/3] remoteproc: qcom: pas: make region assign more
 generic
Content-Language: en-US
To:     neil.armstrong@linaro.org, Andy Gross <agross@kernel.org>,
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
 <76f18323-a59e-4724-96ec-6306e5dcd2dc@linaro.org>
 <374addd2-e336-4625-9e0c-45e5efe1eb47@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <374addd2-e336-4625-9e0c-45e5efe1eb47@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11.12.2023 10:37, Neil Armstrong wrote:
> On 09/12/2023 19:06, Konrad Dybcio wrote:
>> On 8.12.2023 16:04, Neil Armstrong wrote:
>>> The current memory region assign only supports a single
>>> memory region.
>>>
>>> But new platforms introduces more regions to make the
>>> memory requirements more flexible for various use cases.
>>> Those new platforms also shares the memory region between the
>>> DSP and HLOS.
>>>
>>> To handle this, make the region assign more generic in order
>>> to support more than a single memory region and also permit
>>> setting the regions permissions as shared.
>>>
>>> Reviewed-by: Mukesh Ojha <quic_mojha@quicinc.com>
>>> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
>>> ---
>> [...]
>>
>>> +    for (offset = 0; offset < adsp->region_assign_count; ++offset) {
>>> +        struct reserved_mem *rmem = NULL;
>>> +
>>> +        node = of_parse_phandle(adsp->dev->of_node, "memory-region",
>>> +                    adsp->region_assign_idx + offset);
>>> +        if (node)
>>> +            rmem = of_reserved_mem_lookup(node);
>>> +        of_node_put(node);
>> Shouldn't this only be called when parse_phandle succeeds? (separate
>> patch with a fix + cc stable if so?)
> 
> It's not a bug, it was added like that because of_node_put() already
> checks for a NULL pointer:
> https://elixir.bootlin.com/linux/v6.7-rc5/source/drivers/of/dynamic.c#L45
Ack

> 
>>
>>> +        if (!rmem) {
>>> +            dev_err(adsp->dev, "unable to resolve shareable memory-region index %d\n",
>>> +                offset);
>>> +            return -EINVAL;
>>> +        }
>>>   -    perm.vmid = QCOM_SCM_VMID_MSS_MSA;
>>> -    perm.perm = QCOM_SCM_PERM_RW;
>>> +        if (adsp->region_assign_shared)  {
>>> +            perm[0].vmid = QCOM_SCM_VMID_HLOS;
>>> +            perm[0].perm = QCOM_SCM_PERM_RW;
>>> +            perm[1].vmid = adsp->region_assign_vmid;
>>> +            perm[1].perm = QCOM_SCM_PERM_RW;
>>> +            perm_size = 2;
>>> +        } else {
>>> +            perm[0].vmid = adsp->region_assign_vmid;
>>> +            perm[0].perm = QCOM_SCM_PERM_RW;
>>> +            perm_size = 1;
>>> +        }
>>>   -    adsp->region_assign_phys = rmem->base;
>>> -    adsp->region_assign_size = rmem->size;
>>> -    adsp->region_assign_perms = BIT(QCOM_SCM_VMID_HLOS);
>>> +        adsp->region_assign_phys[offset] = rmem->base;
>>> +        adsp->region_assign_size[offset] = rmem->size;
>>> +        adsp->region_assign_perms[offset] = BIT(QCOM_SCM_VMID_HLOS);
>>>   -    ret = qcom_scm_assign_mem(adsp->region_assign_phys,
>>> -                  adsp->region_assign_size,
>>> -                  &adsp->region_assign_perms,
>> I think this should be renamed to region_assign_owner(s)
> 
> Why ? this bitfield is names "perms" everywhere qcom_scm_assign_mem is used
And IMO that's not correct - there's the qcom_scm_vmperm.perm field which
is oneOf r/w/x/rw/rwx and this one is filled with ORed BIT()-ed elements
allowed in qcom_scm_vmperm.vmid (QCOM_SCM_VMID_...)

Konrad

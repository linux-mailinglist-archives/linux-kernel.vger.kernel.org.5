Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70735788ED8
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 20:39:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231140AbjHYSjA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 14:39:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229720AbjHYSia (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 14:38:30 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70227210A
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 11:38:27 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-50087d47d4dso1882960e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 11:38:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692988706; x=1693593506;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pVFvfHEoczn3+8y84rjR34d6BsLX8NOa3XN+/aN6FDk=;
        b=XD+W6zc3h4/RiT09xm9X/IBwFX3Atmkv7WWhAA7fYGZgBwiQfboLxXs7ENSOx2hyLc
         xXjuJPD/tRGUydmk7P7BZ/cesz+LVndI1zIcouaE+EJvSJ3OSPH0hVCQfE0x8+Za0qeS
         TyAsi7gsZJPZhUykXgf43bt5CSHssuYgJHaf+9TGDMKc63RnBjSdYF40kdBdGzEyXlpZ
         NEmiAieS8um7/IdWcqgbbWjSadsIjrIT2oLuDTCC19qG9M4rF4Bg57KsIh0SJsL9dv9q
         4R80GW1jTbyFTSNgDlFWkOM3aGOjj2oc9kSSE+jLQb2Ci3+7R1/TAMNsUf9sxip47w0g
         n9Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692988706; x=1693593506;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pVFvfHEoczn3+8y84rjR34d6BsLX8NOa3XN+/aN6FDk=;
        b=XzvL3fjdiqN7wIBDbE6xqpfa7H2nN0KjXo0yKd9aI1sgatCd4umFsOl3jQTtkSvHVj
         W9K4I2cTm3I0ZVRk7LZZHiHjHizkc4EwIFu+3mxO1htgStMNUD+uZD7TN8vvqeGZoqBq
         8NyntoidXqRCyoSObGNAhPfiu9HHhSup8oAJlDppV38LsTUwsnSXSB/oeRAUJhaK6LvY
         cUoJixP/Z+Ir6yEYuh4wEPdEB3kFpJwCgxehoqDpWxxxQnzmbfg+HY+eQclvZRgjwRyL
         TihrD20zPfSyVm5rosVU4GHoa0Sge95tsUYykEWnYZYSaF7F6JrE8xzIR7k3OKw1c45Q
         zXfA==
X-Gm-Message-State: AOJu0Yx/JDLYVFnSnRZHp8A5hc9PBz+LvzW5gA+bfGIdPMJfTRoigZYw
        Gc0msUXraEZHw6HizKOTJvOCiA==
X-Google-Smtp-Source: AGHT+IF2hVCsDfiEKeBvplUJKMk1U4kClvGLKPvWrcdWem8MlJcg7lj0GCij46qeb1fWpCsxUymvDg==
X-Received: by 2002:ac2:4db9:0:b0:500:8723:e457 with SMTP id h25-20020ac24db9000000b005008723e457mr9276253lfe.30.1692988705754;
        Fri, 25 Aug 2023 11:38:25 -0700 (PDT)
Received: from [192.168.1.101] (abxh59.neoplus.adsl.tpnet.pl. [83.9.1.59])
        by smtp.gmail.com with ESMTPSA id u5-20020ac248a5000000b004fbd39b69adsm378647lfg.199.2023.08.25.11.38.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Aug 2023 11:38:25 -0700 (PDT)
Message-ID: <070e8d48-1a51-42b3-9ccf-7532412b4864@linaro.org>
Date:   Fri, 25 Aug 2023 20:38:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/33] iris: vidc: add helpers for memory management
Content-Language: en-US
To:     Dikshita Agarwal <quic_dikshita@quicinc.com>,
        Bjorn Andersson <quic_bjorande@quicinc.com>,
        Vikash Garodia <quic_vgarodia@quicinc.com>
Cc:     stanimir.k.varbanov@gmail.com, agross@kernel.org,
        andersson@kernel.org, mchehab@kernel.org, hans.verkuil@cisco.com,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
References: <1690550624-14642-1-git-send-email-quic_vgarodia@quicinc.com>
 <1690550624-14642-12-git-send-email-quic_vgarodia@quicinc.com>
 <20230728162817.GE1428172@hu-bjorande-lv.qualcomm.com>
 <9c6e098a-5d7f-4a1a-80d6-116a2c6b8867@linaro.org>
 <8efb0013-970d-ebe6-aedd-7b72f3366578@quicinc.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <8efb0013-970d-ebe6-aedd-7b72f3366578@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14.08.2023 21:06, Dikshita Agarwal wrote:
> 
> 
> On 7/28/2023 10:52 PM, Konrad Dybcio wrote:
>> On 28.07.2023 18:28, Bjorn Andersson wrote:
>>> On Fri, Jul 28, 2023 at 06:53:22PM +0530, Vikash Garodia wrote:
>>>> diff --git a/drivers/media/platform/qcom/iris/vidc/src/msm_vidc_memory.c b/drivers/media/platform/qcom/iris/vidc/src/msm_vidc_memory.c
>>> [..]
>>>> +static const struct msm_vidc_memory_ops msm_mem_ops = {
>>>> +	.dma_buf_get                    = msm_vidc_dma_buf_get,
>>>> +	.dma_buf_put                    = msm_vidc_dma_buf_put,
>>>> +	.dma_buf_put_completely         = msm_vidc_dma_buf_put_completely,
>>>> +	.dma_buf_attach                 = msm_vidc_dma_buf_attach,
>>>> +	.dma_buf_detach                 = msm_vidc_dma_buf_detach,
>>>> +	.dma_buf_map_attachment         = msm_vidc_dma_buf_map_attachment,
>>>> +	.dma_buf_unmap_attachment       = msm_vidc_dma_buf_unmap_attachment,
>>>> +	.memory_alloc_map               = msm_vidc_memory_alloc_map,
>>>> +	.memory_unmap_free              = msm_vidc_memory_unmap_free,
>>>> +	.buffer_region                  = msm_vidc_buffer_region,
>>>
>>> Will there ever be more than one implementation of the
>>> msm_vidc_memory_ops?
>>>
>>> Unless there's a really strong reason, just call the functions directly
>>> without the function pointers and call_mem_op(), this will be slightly
>>> faster, but more importantly it allows for much faster navigation of the
>>> code base.
>> Same for HFI ops
> Hi Konrad,
> There are no HFI ops in this driver, are you referring to anything else
> here, could you please point me to it?
Sorry, I had that in my brain cache after reading through the downstream
driver..

Konrad

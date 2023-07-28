Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28B8076732D
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 19:23:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232793AbjG1RXE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 13:23:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233155AbjG1RW7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 13:22:59 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 579F81FFF
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 10:22:58 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id 38308e7fff4ca-2b9a2033978so36663411fa.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 10:22:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690564976; x=1691169776;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IO0OFH0oUMMupA6OukcceVhS0L4SRH/Rh0UjiIiLnes=;
        b=oKD5+5IAOmXR3esQou5EBar56x+DVKWDv6xGRkDAl2V2EuPrZJoP/aI+szj2K3RhhJ
         FrD/A5qz80ZzcSN0tPI7C7UYdiONl1tjkKftTF2/B7MTALz5xqP4Qbd4shUBC1hyLDxA
         InsvA2UB6h/m8RBDjYStLTY7RIQlCuvxphTBUMf82x3o2ulB6auyGKhzyN8VUaDJk+we
         chBmEqtRWVtPIsko+dC/O92lGPVV94+UMYuRu1PxTFgw+Tl1bjkC2nE0/v3BnT23ZXtd
         Uf+HUwGpJY1jU3bAU6LBpJ53GmOMgFoqlw5+WgfvP+bRfbZqRbUucSLuDi++ZMuufss6
         NTIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690564976; x=1691169776;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IO0OFH0oUMMupA6OukcceVhS0L4SRH/Rh0UjiIiLnes=;
        b=gYM+KvtQH83IaGA5Yvmg3hQ8PbukoVRTwAyGSyYs2nmHog8sdXqNFSpg/Nd7p+bGDg
         xxWYBazlF3duLrI7Juyda3udOp8loeGqbAegN3faYukxhLQv85jdxBYtx/mdREc/alO3
         pWMvNN1Fgil1GqG45iWv9NU4uhKJR0RxjIDmVhOrx7LL2qunfG/5NAiwNnQXWL8gZTQN
         hqtZiifhSOcDeWgXs9QhdhN/TePbKgW/JAlB76bM5dU/Q+3UVU6H2afSSQ+o3bOmSRQQ
         de/ecByWFXPVqhvBOAfc99r9tHkWfGfGipFgKCcwsHYZBRQkXTn2SEKe6o+XP1LE0DNY
         28nA==
X-Gm-Message-State: ABy/qLYxYhDBXPdJiFhQBDz6DW/9G8XARWvBLa7iqXrnrGlhcKzotgvV
        KeYypFOElwkF8cja4ZOPPsL43Q==
X-Google-Smtp-Source: APBJJlEdL3g1snaMud3XPIopmMyn6HUS3QtiMvOqCpEYQIzAuXD/ripiZDnhzAs2UyvLAr4klpNUNA==
X-Received: by 2002:a2e:9356:0:b0:2b6:b98e:fe87 with SMTP id m22-20020a2e9356000000b002b6b98efe87mr2188280ljh.16.1690564976596;
        Fri, 28 Jul 2023 10:22:56 -0700 (PDT)
Received: from [192.168.1.101] (abyk53.neoplus.adsl.tpnet.pl. [83.9.30.53])
        by smtp.gmail.com with ESMTPSA id x11-20020a2e9dcb000000b002b69f44646bsm1048747ljj.17.2023.07.28.10.22.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Jul 2023 10:22:56 -0700 (PDT)
Message-ID: <9c6e098a-5d7f-4a1a-80d6-116a2c6b8867@linaro.org>
Date:   Fri, 28 Jul 2023 19:22:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/33] iris: vidc: add helpers for memory management
Content-Language: en-US
To:     Bjorn Andersson <quic_bjorande@quicinc.com>,
        Vikash Garodia <quic_vgarodia@quicinc.com>
Cc:     stanimir.k.varbanov@gmail.com, agross@kernel.org,
        andersson@kernel.org, mchehab@kernel.org, hans.verkuil@cisco.com,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, quic_dikshita@quicinc.com
References: <1690550624-14642-1-git-send-email-quic_vgarodia@quicinc.com>
 <1690550624-14642-12-git-send-email-quic_vgarodia@quicinc.com>
 <20230728162817.GE1428172@hu-bjorande-lv.qualcomm.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <20230728162817.GE1428172@hu-bjorande-lv.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28.07.2023 18:28, Bjorn Andersson wrote:
> On Fri, Jul 28, 2023 at 06:53:22PM +0530, Vikash Garodia wrote:
>> diff --git a/drivers/media/platform/qcom/iris/vidc/src/msm_vidc_memory.c b/drivers/media/platform/qcom/iris/vidc/src/msm_vidc_memory.c
> [..]
>> +static const struct msm_vidc_memory_ops msm_mem_ops = {
>> +	.dma_buf_get                    = msm_vidc_dma_buf_get,
>> +	.dma_buf_put                    = msm_vidc_dma_buf_put,
>> +	.dma_buf_put_completely         = msm_vidc_dma_buf_put_completely,
>> +	.dma_buf_attach                 = msm_vidc_dma_buf_attach,
>> +	.dma_buf_detach                 = msm_vidc_dma_buf_detach,
>> +	.dma_buf_map_attachment         = msm_vidc_dma_buf_map_attachment,
>> +	.dma_buf_unmap_attachment       = msm_vidc_dma_buf_unmap_attachment,
>> +	.memory_alloc_map               = msm_vidc_memory_alloc_map,
>> +	.memory_unmap_free              = msm_vidc_memory_unmap_free,
>> +	.buffer_region                  = msm_vidc_buffer_region,
> 
> Will there ever be more than one implementation of the
> msm_vidc_memory_ops?
> 
> Unless there's a really strong reason, just call the functions directly
> without the function pointers and call_mem_op(), this will be slightly
> faster, but more importantly it allows for much faster navigation of the
> code base.
Same for HFI ops

Konrad

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2ACAF765994
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 19:10:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230055AbjG0RKt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 13:10:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229866AbjG0RKr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 13:10:47 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAC1C2D70
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 10:10:44 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id 38308e7fff4ca-2b74209fb60so18545331fa.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 10:10:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690477843; x=1691082643;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YA4KY7APNBoaVIsE8pbZuVrmfLiy26uq1i7pnH5Zurc=;
        b=kU9RvC9MMM1jkXnKHDH9Y7YHb/jOhWaYDV+48W6Vp1QVRVT5IN1Nbx2J3fu7lxkgxk
         bXHpKj/a9cTgAWSocNtrGS2015UQWdKNmAnaaCM/GNB/VTIoO3JnopGz/neyutp/SNz0
         HttdyOVb9DnvYuA5Eq8kwtAIOnojFWbJJ7tp54kx35OUeLlv11MmbhtD/ZxW+/bGoC74
         L2We5/1bmS4V2nVaCDcX+5n/T2En8pyA5sIpVNhcrv0qSRr+NoAHPI4qSjvDhXR+32B4
         739OCJFYQ7fq8XXBViQNHYEI5IJZQUl2TUW+jXEWQ8Dbs1U5EDXB1ZDFrtoTOiNZlpN3
         qMcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690477843; x=1691082643;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YA4KY7APNBoaVIsE8pbZuVrmfLiy26uq1i7pnH5Zurc=;
        b=Cjv5GuuT6huaj1885j/silMSXR7Kzyd+EnwFA5pNF1SOvKStft7uMoINfmpyXnzhEQ
         nbMAcdBZShkmDha27ohIU9auuhk4A4/pQc4bpQTMeEsjW+2iEhsl5shRZzfj9PzwAq3z
         rbt1W40Q60gO0C1OZ4s0uXrDQNr8e4OcNAccvGKA1tAQQG7hhiU9kzZGLoZ2LE/g3qEy
         4+yL/7e50KTBLMTsHCT8Hm8lyfeKQARJqFeTORU/oJKSO2mpT+r5lahBvBpNBTREkSbD
         fHNx7P5iuciAR5nZ8iyqub4yLfRFjIR/p+IhBY9AoQFhmmzMiWoEUiGTpUdLOl9H8IGT
         kdzQ==
X-Gm-Message-State: ABy/qLZlR/cFfaVHHkQWxVBgOFtLu6kYROZE/X69i+I6k8fV/zc0REnv
        E5PHxdAtDA5EK2JFKyOumZfNYA==
X-Google-Smtp-Source: APBJJlFaJ8HKfLfLui9GCTpqO9VRb6s9gu3E4pmdbVXWA9rs8zr5ttu0hEFBNa46OOcBduEXOCgc4A==
X-Received: by 2002:a2e:3613:0:b0:2b6:dec9:2812 with SMTP id d19-20020a2e3613000000b002b6dec92812mr2191782lja.33.1690477842958;
        Thu, 27 Jul 2023 10:10:42 -0700 (PDT)
Received: from [192.168.1.101] (abxi99.neoplus.adsl.tpnet.pl. [83.9.2.99])
        by smtp.gmail.com with ESMTPSA id y4-20020a2eb004000000b002b944151da5sm441863ljk.81.2023.07.27.10.08.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Jul 2023 10:09:12 -0700 (PDT)
Message-ID: <df947545-23ef-2ee9-72cc-8e54bbe46be1@linaro.org>
Date:   Thu, 27 Jul 2023 19:08:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] venus: hfi: add checks to perform sanity on queue
 pointers
Content-Language: en-US
To:     Vikash Garodia <quic_vgarodia@quicinc.com>,
        stanimir.k.varbanov@gmail.com, bryan.odonoghue@linaro.org,
        agross@kernel.org, andersson@kernel.org, mchehab@kernel.org,
        hans.verkuil@cisco.com, tfiga@chromium.org
Cc:     linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <1690432469-14803-1-git-send-email-quic_vgarodia@quicinc.com>
 <1690432469-14803-2-git-send-email-quic_vgarodia@quicinc.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <1690432469-14803-2-git-send-email-quic_vgarodia@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27.07.2023 06:34, Vikash Garodia wrote:
> Read and write pointers are used to track the packet index in the memory
> shared between video driver and firmware. There is a possibility of OOB
> access if the read or write pointer goes beyond the queue memory size.
> Add checks for the read and write pointer to avoid OOB access.
> 
> Cc: stable@vger.kernel.org
> Fixes: d96d3f30c0f2 ("[media] media: venus: hfi: add Venus HFI files")
> Signed-off-by: Vikash Garodia <quic_vgarodia@quicinc.com>
> ---
>  drivers/media/platform/qcom/venus/hfi_venus.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/media/platform/qcom/venus/hfi_venus.c b/drivers/media/platform/qcom/venus/hfi_venus.c
> index f0b4638..dc228c4 100644
> --- a/drivers/media/platform/qcom/venus/hfi_venus.c
> +++ b/drivers/media/platform/qcom/venus/hfi_venus.c
> @@ -206,6 +206,10 @@ static int venus_write_queue(struct venus_hfi_device *hdev,
>  
>  	new_wr_idx = wr_idx + dwords;
>  	wr_ptr = (u32 *)(queue->qmem.kva + (wr_idx << 2));
> +
> +	if (wr_ptr < (u32 *)queue->qmem.kva || wr_ptr > (u32 *)(queue->qmem.kva + queue->qmem.size))
Shouldn't the cases on the right side of the OR operator include a
"- 1"?

Konrad

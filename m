Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 145647776DA
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 13:25:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234020AbjHJLZE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 07:25:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233892AbjHJLZD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 07:25:03 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB0F12684
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 04:25:02 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id ffacd0b85a97d-3178dd81ac4so726524f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 04:25:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691666701; x=1692271501;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YgZPoGo8LH6qyDp5ljGcAmzKnfrqRqiwjnWanmEDZhg=;
        b=X14rlqeMcQOp84Dddr/YJnsen7wMwNzbKp0gyAt1pPHT8isM4Qh2aHHlWH0/TBZJE+
         rvQmzd2F1wyu1rZy0BVHGl1qBh6Mbfj07ROKcb5CYG/aXA7LmHahT6w0Bq+HjOgHBK9Z
         DdkLj1yxuEefKEqk/BRXlFCIz31J2Xm9rqQ0hetNqkcpD11kAPft4J6rtHUzail6tiKt
         wCEvqcS3HkG6METqJV1EHCRIon0DigBe+xkM71dVw9JltiT8MYzRJ4b2zi+sEWtDB/dR
         yXL5Fq1Cwl89uAeLYSEsVbb1Vu7Fbem1S2qKFak+MaMCwCDyD7CCf7FJgk+rR8oFioIY
         wQoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691666701; x=1692271501;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YgZPoGo8LH6qyDp5ljGcAmzKnfrqRqiwjnWanmEDZhg=;
        b=jSUc8xSwiy5pMUe1XIg//b8dvW+Rj9JoBmMJyMiQSpxb6vEzij6VEW/fDPahKLNTZI
         JbGIcKylhm40wrm/rrhz2AGv0Fm7H9WPItErTS3JVEXL4h20A2Gho2bYi8kKUmOGO60S
         ZWl0+KVBj42/jn4bv+u7QPbFUXi26tva+9cWk9Zuee6VDDkiV3P8B6IUWLc+o5uFRmrR
         4zEhqB9K6H+gS5ardt0pVrw8bKGKE0nSdyOT1U0gZzdkTnf0UHdeh7ctFxRnc1l4bu4m
         od7Lx51VjSBjTy/sGTEd8vr5fRRXPUu7TDoRAZEKaYyRH/H9mqaooJYEKxNKzm6lW8Ik
         CxXw==
X-Gm-Message-State: AOJu0Yz+MZD0VZVhvlJHHQ+U2hmH70g7VC3xQ5T46y6AltJ/UwrdY7vn
        QJdFrlcR5Op4CuFmU9Imd3qnzg==
X-Google-Smtp-Source: AGHT+IGfZsiwHjt2cNBhpcThPXYSTnM54RIKj2hBnCzqRN17f566/wRRMFAOgnvnSoVKhs1KDjB4zg==
X-Received: by 2002:adf:e98a:0:b0:317:a423:40e1 with SMTP id h10-20020adfe98a000000b00317a42340e1mr1723864wrm.55.1691666701266;
        Thu, 10 Aug 2023 04:25:01 -0700 (PDT)
Received: from [192.168.0.162] (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id c8-20020a5d63c8000000b0031773e3cf46sm1906271wrw.61.2023.08.10.04.25.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Aug 2023 04:25:00 -0700 (PDT)
Message-ID: <922c02e5-3081-45d4-4635-150393970bf8@linaro.org>
Date:   Thu, 10 Aug 2023 12:24:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v2 1/4] venus: hfi: add checks to perform sanity on queue
 pointers
Content-Language: en-US
To:     Vikash Garodia <quic_vgarodia@quicinc.com>,
        stanimir.k.varbanov@gmail.com, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org, mchehab@kernel.org,
        hans.verkuil@cisco.com, tfiga@chromium.org
Cc:     linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <1691634304-2158-1-git-send-email-quic_vgarodia@quicinc.com>
 <1691634304-2158-2-git-send-email-quic_vgarodia@quicinc.com>
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <1691634304-2158-2-git-send-email-quic_vgarodia@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/08/2023 03:25, Vikash Garodia wrote:
> Read and write pointers are used to track the packet index in the memory
> shared between video driver and firmware. There is a possibility of OOB
> access if the read or write pointer goes beyond the queue memory size.
> Add checks for the read and write pointer to avoid OOB access.
> 
> Cc: stable@vger.kernel.org
> Fixes: d96d3f30c0f2 ("[media] media: venus: hfi: add Venus HFI files")
> Signed-off-by: Vikash Garodia <quic_vgarodia@quicinc.com>
> ---
>   drivers/media/platform/qcom/venus/hfi_venus.c | 10 ++++++++++
>   1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/media/platform/qcom/venus/hfi_venus.c b/drivers/media/platform/qcom/venus/hfi_venus.c
> index f0b4638..4ddabb1 100644
> --- a/drivers/media/platform/qcom/venus/hfi_venus.c
> +++ b/drivers/media/platform/qcom/venus/hfi_venus.c
> @@ -206,6 +206,11 @@ static int venus_write_queue(struct venus_hfi_device *hdev,
>   
>   	new_wr_idx = wr_idx + dwords;
>   	wr_ptr = (u32 *)(queue->qmem.kva + (wr_idx << 2));
> +
> +	if (wr_ptr < (u32 *)queue->qmem.kva ||
> +	    wr_ptr > (u32 *)(queue->qmem.kva + queue->qmem.size - sizeof(*wr_ptr)))
> +		return -EINVAL;
> +
>   	if (new_wr_idx < qsize) {
>   		memcpy(wr_ptr, packet, dwords << 2);
>   	} else {
> @@ -273,6 +278,11 @@ static int venus_read_queue(struct venus_hfi_device *hdev,
>   	}
>   
>   	rd_ptr = (u32 *)(queue->qmem.kva + (rd_idx << 2));
> +
> +	if (rd_ptr < (u32 *)queue->qmem.kva ||
> +	    rd_ptr > (u32 *)(queue->qmem.kva + queue->qmem.size - sizeof(*rd_ptr)))
> +		return -EINVAL;
> +
>   	dwords = *rd_ptr >> 2;
>   	if (!dwords)
>   		return -EINVAL;

What is the bit-shifting for ?

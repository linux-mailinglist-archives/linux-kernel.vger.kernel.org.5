Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9929E767417
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 19:59:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234278AbjG1R65 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 13:58:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232003AbjG1R6z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 13:58:55 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C72E03585
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 10:58:53 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id 38308e7fff4ca-2b9cf2b1309so12119941fa.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 10:58:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690567132; x=1691171932;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0PCtupfgsAglFpkiVX1w6ol0/6o9i9+s5VwspB80GYo=;
        b=XDZ7D0tDXdczOXhwYoFMDZtgXk7+4VRhpTP0+jiRWT470cNjw2UE8MoaNoY80DFI82
         ouqxU9cpTeRclXF2ZLoK05dDy95rlinO4d+QcZ2Fe3Naf2Ld25W7tRgFT24TleMPzpCV
         WV22cBb520HRReksmKrQXz0VYiM6GLiBAU6RGbEj9jLgulYWNjzSBWbzmiAI1ZSwtGOe
         pqmWnQBhd+7201bBvESyfvwniwJQ9BvswK092co/3s9A/AtANxsoilK8wmqm/qiIo73c
         W86bctkcWQSl03GiAuBWnJdKwebz3NAwM4AsxboUNMwVU/W9zJ0p8KpH29nos077+SAp
         qcSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690567132; x=1691171932;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0PCtupfgsAglFpkiVX1w6ol0/6o9i9+s5VwspB80GYo=;
        b=ZFr7aMOUlw5NXw/lGwE1P48dC0OgeoioxdmzeiElYj2xy99ICme/Z/sn04czX/QVjN
         MKoYRVeLI1z/wCI4sLvdDJetyE0GJzVlF04esM0ZYa3iUVjqkxXkyvagmDcWjcACLN6t
         tHwnmp40VjsNM2mAYyK6MuiZUdjF1DsUTxpmQTFkH4F+2hQJZP2qoPPhtOUYMek0GTK8
         WWPJIXaDq93R8Np8Lb5n83J5OrDFQ8DGMGAInESfuJK77Y+6h3842Gkzv2ll95xeVcPS
         K7Al2oDTe2i8Nbe7Z5Tn2J2wXNqA9gbzlpURG/DTq3bXlafqTAClLlw7/ewETI9lm92L
         vZbA==
X-Gm-Message-State: ABy/qLYA3IjGSnfxlo1BoBwugL3kuRFGRQgBbomMDaYWHb/tPjNmvFlf
        K2Q/JtZDQVQE92Vw9sET+wR63Q==
X-Google-Smtp-Source: APBJJlEFFhc7OMeaagWIzDaKbymNsMF85h7Q0x1dUfB5wcoaOwanCYTEGXrPfpMqvjxStJqUBLQFWw==
X-Received: by 2002:a2e:a27b:0:b0:2b9:aad7:9d89 with SMTP id k27-20020a2ea27b000000b002b9aad79d89mr2745154ljm.15.1690567131952;
        Fri, 28 Jul 2023 10:58:51 -0700 (PDT)
Received: from [192.168.1.101] (abyk53.neoplus.adsl.tpnet.pl. [83.9.30.53])
        by smtp.gmail.com with ESMTPSA id p28-20020a2ea41c000000b002b94327308asm1053770ljn.133.2023.07.28.10.58.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Jul 2023 10:58:51 -0700 (PDT)
Message-ID: <9eec378f-9e77-6c08-eb82-2387c77734f1@linaro.org>
Date:   Fri, 28 Jul 2023 19:58:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 20/33] iris: vidc: hfi: add helpers for handling shared
 queues
Content-Language: en-US
To:     Vikash Garodia <quic_vgarodia@quicinc.com>,
        stanimir.k.varbanov@gmail.com, agross@kernel.org,
        andersson@kernel.org, mchehab@kernel.org, hans.verkuil@cisco.com,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Cc:     quic_dikshita@quicinc.com
References: <1690550624-14642-1-git-send-email-quic_vgarodia@quicinc.com>
 <1690550624-14642-21-git-send-email-quic_vgarodia@quicinc.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <1690550624-14642-21-git-send-email-quic_vgarodia@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28.07.2023 15:23, Vikash Garodia wrote:
> This implements functions to allocate and update the shared memory
> used for sending commands to firmware and receiving messages from
> firmware.
> 
> Signed-off-by: Dikshita Agarwal <quic_dikshita@quicinc.com>
> Signed-off-by: Vikash Garodia <quic_vgarodia@quicinc.com>
> ---
>  .../platform/qcom/iris/vidc/inc/venus_hfi_queue.h  |  89 ++++
>  .../platform/qcom/iris/vidc/src/venus_hfi_queue.c  | 537 +++++++++++++++++++++
>  2 files changed, 626 insertions(+)
>  create mode 100644 drivers/media/platform/qcom/iris/vidc/inc/venus_hfi_queue.h
>  create mode 100644 drivers/media/platform/qcom/iris/vidc/src/venus_hfi_queue.c
> 
> diff --git a/drivers/media/platform/qcom/iris/vidc/inc/venus_hfi_queue.h b/drivers/media/platform/qcom/iris/vidc/inc/venus_hfi_queue.h
> new file mode 100644
> index 0000000..f533811
> --- /dev/null
> +++ b/drivers/media/platform/qcom/iris/vidc/inc/venus_hfi_queue.h
> @@ -0,0 +1,89 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright (c) 2020-2022, The Linux Foundation. All rights reserved.
> + * Copyright (c) 2023 Qualcomm Innovation Center, Inc. All rights reserved.
> + */
> +
> +#ifndef _VENUS_HFI_QUEUE_H_
> +#define _VENUS_HFI_QUEUE_H_
> +
> +#include <linux/types.h>
> +
> +#include "msm_vidc_internal.h"
> +
> +#define HFI_MASK_QHDR_TX_TYPE			0xff000000
> +#define HFI_MASK_QHDR_RX_TYPE			0x00ff0000
> +#define HFI_MASK_QHDR_PRI_TYPE			0x0000ff00
> +#define HFI_MASK_QHDR_Q_ID_TYPE			0x000000ff
> +#define HFI_Q_ID_HOST_TO_CTRL_CMD_Q		0
> +#define HFI_Q_ID_CTRL_TO_HOST_MSG_Q		1
> +#define HFI_Q_ID_CTRL_TO_HOST_DEBUG_Q		2
> +#define HFI_MASK_QHDR_STATUS			0x000000ff
GENMASK, BIT()..

Konrad

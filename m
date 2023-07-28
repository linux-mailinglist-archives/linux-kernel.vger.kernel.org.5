Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2E94767453
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 20:14:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235749AbjG1SOG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 14:14:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233673AbjG1SOE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 14:14:04 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60381268B
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 11:13:55 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2b962c226ceso36650991fa.3
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 11:13:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690568033; x=1691172833;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OB/bj30EnQnr6qTMECfih4Nn+rCyljk2OAQ0K7AzNWE=;
        b=sgkyoIIxxj+BiKxTUEpniRyHaGqsstpWOTmwkVKFUNAqtP4tLHT8ZRHBpUu8PKmTNa
         fvFhKwPbOw0bafwB1vOtaVPui1FeDZwTt4gT9trORHRUgq+ACJ0e7enxDL0CjC4EzfVt
         fWqQ1CISQyFxPZ8tORBha8debkONk4Nj9p/Hzh/ACPLTd+/87oAOCPiGjZhZQnRGcaQX
         hc2cXUD546s8ED0lYDuHnnkGiSDwznkW1VUudgeVkhCVNGyR7encM/+zEQapwokUyZyI
         1doqxWmH7PN1kxCPNA+DRYpjmpy4FNY+y5AhUpxbLWRIij3ADQAHOk/OQvW681v9P0R5
         zvMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690568033; x=1691172833;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OB/bj30EnQnr6qTMECfih4Nn+rCyljk2OAQ0K7AzNWE=;
        b=R+gx3585OmvP6Q7Ui/ry9cye69RhbEzBlfhPV/TMisgYb73Gwf32k6Oe/FVzVzrM51
         WaGu3OJrG4nI9+atrjGnzcn59TyxeOh10Jc+Ir60T2Wa7AJgWcZEmR2rYYJFHVak5ada
         DZObCztBxyP1vwz8G2YNuMZAYqHMPYd4VkkRWCuuV5e9WANC10vQvxmwDgywHUxWyQf1
         oQELO5P6jzee2Tuu7k+2QsA0XgD6T4MZwOGTKRLhCsmmvXnGKRgMAcntpIqcK+qEIJcE
         8eS55rKJkqsLHvnetq+NEf8lpfgax7lnL/hG1IMkOfBKpLL1vXpkbQolrkY46Kdaohrr
         wYzQ==
X-Gm-Message-State: ABy/qLbqnZu/Fumqg04meaCPQhrAvk3cFLPQErWQincZ+IQnfb+iFrpR
        U4jdn0JCuAwoloRLVwvohrHhBA==
X-Google-Smtp-Source: APBJJlHZ2xt/9kZ6i7sJ/WW42TO6ZL+VX/STN8Vn819QxWIcAcB46aAFopd7prKIGS3SHkjqImc6vg==
X-Received: by 2002:a05:6512:3b13:b0:4fe:c53:1824 with SMTP id f19-20020a0565123b1300b004fe0c531824mr3270765lfv.40.1690568033641;
        Fri, 28 Jul 2023 11:13:53 -0700 (PDT)
Received: from [192.168.1.101] (abyk53.neoplus.adsl.tpnet.pl. [83.9.30.53])
        by smtp.gmail.com with ESMTPSA id z5-20020ac24f85000000b004fb74dbbd98sm915772lfs.246.2023.07.28.11.13.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Jul 2023 11:13:53 -0700 (PDT)
Message-ID: <df9b1ee4-1462-f37a-1f08-0321a10fc4f9@linaro.org>
Date:   Fri, 28 Jul 2023 20:13:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 32/33] iris: variant: iris3: implement logic to compute
 clock frequency
Content-Language: en-US
To:     Vikash Garodia <quic_vgarodia@quicinc.com>,
        stanimir.k.varbanov@gmail.com, agross@kernel.org,
        andersson@kernel.org, mchehab@kernel.org, hans.verkuil@cisco.com,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Cc:     quic_dikshita@quicinc.com
References: <1690550624-14642-1-git-send-email-quic_vgarodia@quicinc.com>
 <1690550624-14642-33-git-send-email-quic_vgarodia@quicinc.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <1690550624-14642-33-git-send-email-quic_vgarodia@quicinc.com>
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

On 28.07.2023 15:23, Vikash Garodia wrote:
> From: Dikshita Agarwal <quic_dikshita@quicinc.com>
> 
> This implements the logic to computer the required clock frequency
> by encoder or decoder for a specific usecase. It considers the input
> as various parameters configured by client for that usecase.
> 
> Signed-off-by: Dikshita Agarwal <quic_dikshita@quicinc.com>
> Signed-off-by: Vikash Garodia <quic_vgarodia@quicinc.com>
> ---
>  .../iris/variant/iris3/src/msm_vidc_clock_iris3.c  | 627 +++++++++++++++++++++
>  1 file changed, 627 insertions(+)
>  create mode 100644 drivers/media/platform/qcom/iris/variant/iris3/src/msm_vidc_clock_iris3.c
> 
> diff --git a/drivers/media/platform/qcom/iris/variant/iris3/src/msm_vidc_clock_iris3.c b/drivers/media/platform/qcom/iris/variant/iris3/src/msm_vidc_clock_iris3.c
> new file mode 100644
> index 0000000..6665aef
> --- /dev/null
> +++ b/drivers/media/platform/qcom/iris/variant/iris3/src/msm_vidc_clock_iris3.c
> @@ -0,0 +1,627 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) 2023 Qualcomm Innovation Center, Inc. All rights reserved.
> + */
> +
> +#include "msm_vidc_debug.h"
> +
> +#define ENABLE_FINEBITRATE_SUBUHD60 0
> +#include "perf_static_model.h"
> +
> +/*
> + * Chipset Generation Technology: SW/FW overhead profiling
> + * need update with new numbers
> + */
> +static u32 frequency_table_iris3[2][6] = {
I think it's the third repetition of the same (ftbl + OPP)

> +	/* //make lowsvs_D1 as invalid; */
> +	{533, 444, 366, 338, 240, 0},
> +	{800, 666, 549, 507, 360, 0},
> +};
> +
> + /* Tensilica cycles */
> +#define DECODER_VPP_FW_OVERHEAD_IRIS3                                                  66234
> +
> +/* Tensilica cycles; this is measured in Lahaina 1stage with FW profiling */
Is it gonna differ for other SoCs? Especially that 8350 has IRIS2?

> +#define DECODER_VPPVSP1STAGE_FW_OVERHEAD_IRIS3                                         93000
> +
> +#define DECODER_VSP_FW_OVERHEAD_IRIS3 \
> +	(DECODER_VPPVSP1STAGE_FW_OVERHEAD_IRIS3 - DECODER_VPP_FW_OVERHEAD_IRIS3)
> +
> +/* Tensilica cycles; encoder has ARP register */
> +#define ENCODER_VPP_FW_OVERHEAD_IRIS3                                                  48405
> +
> +#define ENCODER_VPPVSP1STAGE_FW_OVERHEAD_IRIS3 \
> +	(ENCODER_VPP_FW_OVERHEAD_IRIS3 + DECODER_VSP_FW_OVERHEAD_IRIS3)
> +
> +#define DECODER_SW_OVERHEAD_IRIS3                                                      489583
> +#define ENCODER_SW_OVERHEAD_IRIS3                                                      489583
> +
> +/* Video IP Core Technology: pipefloor and pipe penlaty */
> +static u32 decoder_vpp_target_clk_per_mb_iris3 = 200;
Why is this a variable?

[...]

> +
> +/* 8KUHD60; UHD240; 1080p960  with B */
> +static u32 fp_pixel_count_bar0 = 3840 * 2160 * 240;
> +/* 8KUHD60; UHD240; 1080p960  without B */
> +static u32 fp_pixel_count_bar1 = 3840 * 2160 * 240;
Not sure what the 'B' is, but the entries are the same. And looks like
there's:

- no need for it to be a variable
- maybe you could make this a macro or just a simple multiplication

[...]

> +u32 get_bitrate_entry(u32 pixle_count)
pixle -> pixel, checkpatch should point out typos

[...]

> +static int calculate_vsp_min_freq(struct api_calculation_input codec_input,
> +				  struct api_calculation_freq_output *codec_output)
> +{
> +	/*
> +	 * VSP calculation
> +	 * different methodology from Lahaina
> +	 */
Not sure if that comment is useful to the reader.

[...]


> +
> +static u32 calculate_pipe_penalty(struct api_calculation_input codec_input)
> +{
> +	u32 pipe_penalty_codec = 0;
> +
> +	/* decoder */
> +	if (codec_input.decoder_or_encoder == CODEC_DECODER)
> +		pipe_penalty_codec = pipe_penalty_iris3[0][0];
> +	else
> +		pipe_penalty_codec = 101;
Add a define for this magic number?

Also, return the value instead of assigning it and doing the same


Konrad

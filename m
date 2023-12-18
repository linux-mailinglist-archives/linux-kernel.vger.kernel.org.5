Return-Path: <linux-kernel+bounces-4256-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 89A108179EF
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 19:46:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 252A71C23059
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 18:46:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E826F495DE;
	Mon, 18 Dec 2023 18:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="e8W5B4K9"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FA721DDC9
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 18:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-50e3845abdaso1938706e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 10:46:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702925167; x=1703529967; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PKuUeeYRiFZIeE9DKLxhDuMUgkn5IEn3SbKqv7Joz+8=;
        b=e8W5B4K9OfYJarxuY2t0dnN3fcmOrcyAQ/546bUNwrupBjph54daDlL79OzBNHm8LC
         NigFTm014+/42jdmzMuFfHTOgP1DODwxNc/8M8R5IG3aWGMGvE11GeR5NS/3OHwqDl8c
         iyWi0++TBycvMtKR0ozdt8mSyfU0p6e/tsMlhS6TONck5/8Khj3/gK1NTJ8PkNbcTS4j
         rFYMod0bzMIMbCCdX1eIBw55XxXpZpzeIHOIordne8JC9P8zbppChN8BrLlN3dJt2MR9
         xjQ/33rTPsbzlb5yZy8mVFLAJTKxXfn5UIr/hio9VLHaVk3uCGW0N0LR4mfVg4my5183
         QutQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702925167; x=1703529967;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PKuUeeYRiFZIeE9DKLxhDuMUgkn5IEn3SbKqv7Joz+8=;
        b=o4R4SmvAErWR6JdIVs9o3EFP2oKep5/zIDB53zpzlJrSxWJFhHs0we0n5YKyqttG+t
         xmg0/EuEK67gs9Q6Np5/EYu5SE1eXy5t5Jpo5wbisafOp20K/zHxqDZwdAX69U0lxYWJ
         vIuAW2z4tpOUtMHCuW+hlIGIcquUlQ+dIrh1bq0T94tSKUejInBeGF+aoEA0UnJcFAQG
         1UeMNPwQWwDL7yoxLRKTS/5Y54YC5RMEeL09RvpqFbrd5OM0WPz8PZCTaXd7id1eUjJO
         SaXCx7Kf+s/k4KQsAcJkmRYgVLMXCOILYy/0/2Pul1cxL3r0SbbYohGrkVD+zo0Go6UJ
         67Ag==
X-Gm-Message-State: AOJu0YwRatft0btI+gV3Ar2zyAp6mcAzqAVM9FMn0ySSR21aG52IClhz
	NstyH1QXLfPwbfJjsCTjmWNi2g==
X-Google-Smtp-Source: AGHT+IHN1Gm+widUIz/rI5/OQn2BgTwAUJHmk8WW0nae4w2ZvnCYStS80T4ivSFEhOTtPHOid0rofw==
X-Received: by 2002:ac2:538e:0:b0:50e:3601:cf29 with SMTP id g14-20020ac2538e000000b0050e3601cf29mr1423385lfh.71.1702925167539;
        Mon, 18 Dec 2023 10:46:07 -0800 (PST)
Received: from ?IPV6:2001:14ba:a0db:1f00::227? (dzdqv0yyyyyyyyyyyykxt-3.rev.dnainternet.fi. [2001:14ba:a0db:1f00::227])
        by smtp.gmail.com with ESMTPSA id f16-20020a0565123b1000b0050e3364b5aasm532294lfv.207.2023.12.18.10.46.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Dec 2023 10:46:07 -0800 (PST)
Message-ID: <62de5467-a979-4739-aee3-e00472ab192a@linaro.org>
Date: Mon, 18 Dec 2023 20:46:06 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 08/34] media: iris: introduce state machine for iris
 core
Content-Language: en-GB
To: Dikshita Agarwal <quic_dikshita@quicinc.com>,
 linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
 stanimir.k.varbanov@gmail.com, quic_vgarodia@quicinc.com, agross@kernel.org,
 andersson@kernel.org, konrad.dybcio@linaro.org, mchehab@kernel.org,
 bryan.odonoghue@linaro.org
Cc: linux-arm-msm@vger.kernel.org, quic_abhinavk@quicinc.com
References: <1702899149-21321-1-git-send-email-quic_dikshita@quicinc.com>
 <1702899149-21321-9-git-send-email-quic_dikshita@quicinc.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <1702899149-21321-9-git-send-email-quic_dikshita@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 18/12/2023 13:32, Dikshita Agarwal wrote:
> Introduces different states for core. State transitions
> are defined, based on which they would be allowed/rejected/ignored.
> 
> IRIS_CORE_DEINIT - default state.
> IRIS_CORE_INIT_WAIT -  wait state for video core to complete
> initialization.
> IRIS_CORE_INIT - core state with core initialized. FW loaded and
> HW brought out of reset, shared queues established between host
> driver and firmware.
> IRIS_CORE_ERROR - error state.
> 
>              |
>              v
>         -----------
>    +--->| DEINIT  |<---+
>    |    -----------    |
>    |         |         |
>    |         v         |
>    |    -----------    |
>    |    |INIT_WAIT|    |
>    |    -----------    |
>    |      /     \      |
>    |     /       \     |
>    |    /         \    |
>    |   v           v   v
>   -----------   ----------.
>   |  INIT   |-->|  ERROR |
>   -----------   ----------.
> 
> Signed-off-by: Dikshita Agarwal <quic_dikshita@quicinc.com>

Can we see users for this API please? Otherwise it's just a dead code.

> ---
>   drivers/media/platform/qcom/vcodec/iris/Makefile   |  3 +-
>   .../media/platform/qcom/vcodec/iris/iris_core.h    |  4 ++
>   .../media/platform/qcom/vcodec/iris/iris_state.c   | 64 ++++++++++++++++++++++
>   .../media/platform/qcom/vcodec/iris/iris_state.h   | 22 ++++++++
>   4 files changed, 92 insertions(+), 1 deletion(-)
>   create mode 100644 drivers/media/platform/qcom/vcodec/iris/iris_state.c
>   create mode 100644 drivers/media/platform/qcom/vcodec/iris/iris_state.h
> 
> diff --git a/drivers/media/platform/qcom/vcodec/iris/Makefile b/drivers/media/platform/qcom/vcodec/iris/Makefile
> index 0748819..12a74de 100644
> --- a/drivers/media/platform/qcom/vcodec/iris/Makefile
> +++ b/drivers/media/platform/qcom/vcodec/iris/Makefile
> @@ -1,4 +1,5 @@
>   iris-objs += iris_probe.o \
> -             resources.o
> +             resources.o \
> +             iris_state.o
>   
>   obj-$(CONFIG_VIDEO_QCOM_IRIS) += iris.o
> diff --git a/drivers/media/platform/qcom/vcodec/iris/iris_core.h b/drivers/media/platform/qcom/vcodec/iris/iris_core.h
> index c2bc95d..56a5b7d 100644
> --- a/drivers/media/platform/qcom/vcodec/iris/iris_core.h
> +++ b/drivers/media/platform/qcom/vcodec/iris/iris_core.h
> @@ -9,6 +9,8 @@
>   #include <linux/types.h>
>   #include <media/v4l2-device.h>
>   
> +#include "iris_state.h"
> +
>   /**
>    * struct iris_core - holds core parameters valid for all instances
>    *
> @@ -27,6 +29,7 @@
>    * @clk_count: count of iris clocks
>    * @reset_tbl: table of iris reset clocks
>    * @reset_count: count of iris reset clocks
> + * @state: current state of core
>    */
>   
>   struct iris_core {
> @@ -45,6 +48,7 @@ struct iris_core {
>   	u32					clk_count;
>   	struct reset_info			*reset_tbl;
>   	u32					reset_count;
> +	enum iris_core_state			state;
>   };
>   
>   #endif
> diff --git a/drivers/media/platform/qcom/vcodec/iris/iris_state.c b/drivers/media/platform/qcom/vcodec/iris/iris_state.c
> new file mode 100644
> index 0000000..22557af
> --- /dev/null
> +++ b/drivers/media/platform/qcom/vcodec/iris/iris_state.c
> @@ -0,0 +1,64 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) 2022-2023 Qualcomm Innovation Center, Inc. All rights reserved.
> + */
> +
> +#include "iris_core.h"
> +#include "iris_state.h"
> +
> +#define IRIS_STATE(name)[IRIS_CORE_##name] = "CORE_"#name

Inline this please.

> +
> +static const char * const core_state_names[] = {
> +	IRIS_STATE(DEINIT),
> +	IRIS_STATE(INIT_WAIT),
> +	IRIS_STATE(INIT),
> +	IRIS_STATE(ERROR),
> +};
> +
> +#undef IRIS_STATE
> +
> +bool core_in_valid_state(struct iris_core *core)

So, even in your driver you have global names? That's really ugh. Please 
fix them.

> +{
> +	return core->state == IRIS_CORE_INIT ||
> +		core->state == IRIS_CORE_INIT_WAIT;
> +}
> +
> +static const char *core_state_name(enum iris_core_state state)
> +{
> +	if ((unsigned int)state < ARRAY_SIZE(core_state_names))
> +		return core_state_names[state];
> +
> +	return "UNKNOWN_STATE";
> +}
> +
> +static bool iris_allow_core_state_change(struct iris_core *core,
> +					 enum iris_core_state req_state)
> +{
> +	if (core->state == IRIS_CORE_DEINIT)
> +		return req_state == IRIS_CORE_INIT_WAIT || req_state == IRIS_CORE_ERROR;
> +	else if (core->state == IRIS_CORE_INIT_WAIT)
> +		return req_state == IRIS_CORE_INIT || req_state == IRIS_CORE_ERROR;
> +	else if (core->state == IRIS_CORE_INIT)
> +		return req_state == IRIS_CORE_DEINIT || req_state == IRIS_CORE_ERROR;
> +	else if (core->state == IRIS_CORE_ERROR)
> +		return req_state == IRIS_CORE_DEINIT;
> +
> +	dev_warn(core->dev, "core state change %s -> %s is not allowed\n",
> +		 core_state_name(core->state), core_state_name(req_state));
> +
> +	return false;
> +}
> +
> +int iris_change_core_state(struct iris_core *core,
> +			   enum iris_core_state request_state)
> +{
> +	if (core->state == request_state)
> +		return 0;
> +
> +	if (!iris_allow_core_state_change(core, request_state))
> +		return -EINVAL;
> +
> +	core->state = request_state;
> +
> +	return 0;
> +}
> diff --git a/drivers/media/platform/qcom/vcodec/iris/iris_state.h b/drivers/media/platform/qcom/vcodec/iris/iris_state.h
> new file mode 100644
> index 0000000..ee20842
> --- /dev/null
> +++ b/drivers/media/platform/qcom/vcodec/iris/iris_state.h
> @@ -0,0 +1,22 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright (c) 2022-2023 Qualcomm Innovation Center, Inc. All rights reserved.
> + */
> +
> +#ifndef _IRIS_STATE_H_
> +#define _IRIS_STATE_H_
> +
> +struct iris_core;
> +
> +enum iris_core_state {
> +	IRIS_CORE_DEINIT,
> +	IRIS_CORE_INIT_WAIT,
> +	IRIS_CORE_INIT,
> +	IRIS_CORE_ERROR,
> +};
> +
> +bool core_in_valid_state(struct iris_core *core);
> +int iris_change_core_state(struct iris_core *core,
> +			   enum iris_core_state request_state);
> +
> +#endif

-- 
With best wishes
Dmitry



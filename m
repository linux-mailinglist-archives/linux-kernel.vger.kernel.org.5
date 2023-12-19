Return-Path: <linux-kernel+bounces-5121-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B5AE88186BF
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 12:57:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B96C11C23B64
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 11:57:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63DEC179AB;
	Tue, 19 Dec 2023 11:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AtH8+D6f"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDE83168A7
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 11:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-40d2e5e8d1dso787765e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 03:57:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702987025; x=1703591825; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=InY8UOvj5txIv4Zj2hCp6dQ7VrX7r6v7MZW0oG1vkrw=;
        b=AtH8+D6fyVCtJRiVugGrrbWd+o7Y9/d3AVZsOziu5Xqkd7xLuSbiuLCjqkuCB3WP4/
         z/5Mda5MgxPXD4uvt2XTULTybhY0RFfLpcNGUzw7EcHP3zX2TNSH9pdAB8a6TA3IDyur
         c3HeP5jj86nTrtTY5KtUM8wEIi300jiyxZ+/JVPBXzCHA/WeOVPV7PPlakT5I+3OLoiW
         i5BfEb4zauWBf5CSkNAsaj2BktY3SMLV6HbNgOEDPQjJWK0asknOPWclbmXHrzskFQex
         vnOBusMC7WrBbf+mjpegjA8MhsNjO5lv+eCj4FTfv+zcWB3wezXgjEy/5/ukSouwsZ2i
         ni7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702987025; x=1703591825;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=InY8UOvj5txIv4Zj2hCp6dQ7VrX7r6v7MZW0oG1vkrw=;
        b=LqVhcIpyMgdnEpE4HI7pIs4rWpidTxUT0Zm2UW5gCQpFQap1UxyPpUkp7b/MYS79gX
         Mhc6PsA5AuQyd4q/4M/y+hKGUYCa3DFnIguY9OpoZoJguJeS7APP5j3P5sIP+Gtl2Fzn
         Rz+7pA1DjPglA4Joh3qn6AcmxvhTjdPLEYeKTnxCrVA/fi4Sg8nAf179zR8n0tuQRS8P
         5g/QYxUHhEUciCoIgFumC8OKbSbTLtvciSo0iWLx7h64i4DpoyZiXwFIUDUOkw3mhk9v
         bDp0if5ojUVitU5G3hheVqSe2XRiy9HgCcCmPM2jaZsTsHcY8Q70XDpsw25F2fmuA31S
         IQdg==
X-Gm-Message-State: AOJu0YySiVfTUWSPPwoSjNt6XbL4++ERuInK+NsXW6wVdAnLVjvRQMIE
	QNxcLKO/30bNhxqtPTZFvRW5Tg==
X-Google-Smtp-Source: AGHT+IGe6hp5/8oreYybrMdfK4UE+ihBcFYn9PKNJYIV4a3hR0n0ztlraN5tAi04ThZS824gvVBPPA==
X-Received: by 2002:a05:600c:470d:b0:40c:55ce:658c with SMTP id v13-20020a05600c470d00b0040c55ce658cmr4601443wmo.188.1702987024957;
        Tue, 19 Dec 2023 03:57:04 -0800 (PST)
Received: from [192.168.100.86] ([37.228.218.3])
        by smtp.gmail.com with ESMTPSA id m34-20020a05600c3b2200b004042dbb8925sm2481927wms.38.2023.12.19.03.57.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Dec 2023 03:57:04 -0800 (PST)
Message-ID: <6b2ce264-3cc6-4c00-85c8-c885b2707787@linaro.org>
Date: Tue, 19 Dec 2023 11:57:03 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 14/34] media: iris: implement iris v4l2 file ops
Content-Language: en-US
To: Dikshita Agarwal <quic_dikshita@quicinc.com>,
 linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
 stanimir.k.varbanov@gmail.com, quic_vgarodia@quicinc.com, agross@kernel.org,
 andersson@kernel.org, konrad.dybcio@linaro.org, mchehab@kernel.org
Cc: linux-arm-msm@vger.kernel.org, quic_abhinavk@quicinc.com
References: <1702899149-21321-1-git-send-email-quic_dikshita@quicinc.com>
 <1702899149-21321-15-git-send-email-quic_dikshita@quicinc.com>
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <1702899149-21321-15-git-send-email-quic_dikshita@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 18/12/2023 11:32, Dikshita Agarwal wrote:
> From: Vikash Garodia <quic_vgarodia@quicinc.com>
> 
> Implements iris v4l2 file ops - open, close and poll.
> 
> Open:
> Configure the vb2 queue and v4l2 file handler. Initialize
> a video instance and add the instance to core instance list.
> Open a session in video firmware via HFI_CMD_OPEN.
> 
> Close:
> De-initialize the instance and remove it from core
> instance list. Close the session in firmware via HFI_CMD_CLOSE.
> 
> Signed-off-by: Vikash Garodia <quic_vgarodia@quicinc.com>
> Signed-off-by: Dikshita Agarwal <quic_dikshita@quicinc.com>
> ---
>   drivers/media/platform/qcom/vcodec/iris/Makefile   |   2 +
>   .../media/platform/qcom/vcodec/iris/hfi_defines.h  |   2 +
>   .../media/platform/qcom/vcodec/iris/iris_common.h  |  26 ++
>   .../media/platform/qcom/vcodec/iris/iris_core.c    |  42 ++-
>   .../media/platform/qcom/vcodec/iris/iris_core.h    |   8 +
>   .../media/platform/qcom/vcodec/iris/iris_helpers.c |  62 +++++
>   .../media/platform/qcom/vcodec/iris/iris_helpers.h |   2 +
>   drivers/media/platform/qcom/vcodec/iris/iris_hfi.c | 115 +++++++-
>   drivers/media/platform/qcom/vcodec/iris/iris_hfi.h |   3 +
>   .../platform/qcom/vcodec/iris/iris_hfi_packet.c    |  28 ++
>   .../platform/qcom/vcodec/iris/iris_hfi_packet.h    |   7 +
>   .../platform/qcom/vcodec/iris/iris_instance.h      |  48 ++++
>   .../media/platform/qcom/vcodec/iris/iris_probe.c   |  10 +
>   .../media/platform/qcom/vcodec/iris/iris_vdec.c    |  47 ++++
>   .../media/platform/qcom/vcodec/iris/iris_vdec.h    |  14 +
>   .../media/platform/qcom/vcodec/iris/iris_vidc.c    | 298 +++++++++++++++++++++
>   .../media/platform/qcom/vcodec/iris/iris_vidc.h    |  15 ++
>   17 files changed, 719 insertions(+), 10 deletions(-)
>   create mode 100644 drivers/media/platform/qcom/vcodec/iris/iris_common.h
>   create mode 100644 drivers/media/platform/qcom/vcodec/iris/iris_instance.h
>   create mode 100644 drivers/media/platform/qcom/vcodec/iris/iris_vdec.c
>   create mode 100644 drivers/media/platform/qcom/vcodec/iris/iris_vdec.h
>   create mode 100644 drivers/media/platform/qcom/vcodec/iris/iris_vidc.c
>   create mode 100644 drivers/media/platform/qcom/vcodec/iris/iris_vidc.h
> 
> diff --git a/drivers/media/platform/qcom/vcodec/iris/Makefile b/drivers/media/platform/qcom/vcodec/iris/Makefile
> index c50e3241..3c076d0 100644
> --- a/drivers/media/platform/qcom/vcodec/iris/Makefile
> +++ b/drivers/media/platform/qcom/vcodec/iris/Makefile
> @@ -3,6 +3,8 @@ iris-objs += ../hfi_queue.o ../firmware.o
>   iris-objs += iris_probe.o \
>                iris_state.o \
>                iris_core.o \
> +             iris_vidc.o \
> +             iris_vdec.o \
>                iris_state.o \
>                iris_helpers.o \
>                iris_hfi.o \
> diff --git a/drivers/media/platform/qcom/vcodec/iris/hfi_defines.h b/drivers/media/platform/qcom/vcodec/iris/hfi_defines.h
> index fb383b2..423ba1a 100644
> --- a/drivers/media/platform/qcom/vcodec/iris/hfi_defines.h
> +++ b/drivers/media/platform/qcom/vcodec/iris/hfi_defines.h
> @@ -9,6 +9,8 @@
>   #define HFI_VIDEO_ARCH_LX			0x1
>   
>   #define HFI_CMD_INIT				0x01000001
> +#define HFI_CMD_OPEN				0x01000003
> +#define HFI_CMD_CLOSE				0x01000004
>   
>   #define HFI_PROP_IMAGE_VERSION			0x03000001
>   
> diff --git a/drivers/media/platform/qcom/vcodec/iris/iris_common.h b/drivers/media/platform/qcom/vcodec/iris/iris_common.h
> new file mode 100644
> index 0000000..3e4dd71
> --- /dev/null
> +++ b/drivers/media/platform/qcom/vcodec/iris/iris_common.h
> @@ -0,0 +1,26 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright (c) 2022-2023 Qualcomm Innovation Center, Inc. All rights reserved.
> + */
> +#ifndef _IRIS_COMMON_H_
> +#define _IRIS_COMMON_H_
> +
> +#include <media/v4l2-device.h>
> +#include <media/v4l2-event.h>
> +#include <media/v4l2-ioctl.h>
> +#include <media/videobuf2-v4l2.h>
> +
> +#define INPUT_MPLANE V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE
> +#define OUTPUT_MPLANE V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE
> +#define DEFAULT_WIDTH 320
> +#define DEFAULT_HEIGHT 240
> +#define DEFAULT_BUF_SIZE 115200
> +
> +enum signal_session_response {
> +	SIGNAL_CMD_STOP_INPUT = 0,
> +	SIGNAL_CMD_STOP_OUTPUT,
> +	SIGNAL_CMD_CLOSE,
> +	MAX_SIGNAL,
> +};
> +
> +#endif
> diff --git a/drivers/media/platform/qcom/vcodec/iris/iris_core.c b/drivers/media/platform/qcom/vcodec/iris/iris_core.c
> index ba8960d..174fad9 100644
> --- a/drivers/media/platform/qcom/vcodec/iris/iris_core.c
> +++ b/drivers/media/platform/qcom/vcodec/iris/iris_core.c
> @@ -3,12 +3,14 @@
>    * Copyright (c) 2022-2023 Qualcomm Innovation Center, Inc. All rights reserved.
>    */
>   
> +#include <linux/delay.h>
> +
>   #include "iris_core.h"
>   #include "iris_helpers.h"
>   #include "iris_hfi.h"
>   #include "iris_state.h"
>   
> -static int iris_core_deinit_locked(struct iris_core *core)
> +int iris_core_deinit_locked(struct iris_core *core)
>   {
>   	int ret;
>   
> @@ -68,3 +70,41 @@ int iris_core_init(struct iris_core *core)
>   
>   	return ret;
>   }
> +
> +int iris_core_init_wait(struct iris_core *core)
> +{
> +	const int interval = 10;
> +	int max_tries, count = 0, ret = 0;
> +
> +	mutex_lock(&core->lock);
> +	if (!core_in_valid_state(core)) {
> +		ret = -EINVAL;
> +		goto unlock;
> +	}
> +
> +	if (core->state == IRIS_CORE_INIT)
> +		goto unlock;
> +
> +	max_tries = core->cap[HW_RESPONSE_TIMEOUT].value / interval;
> +	while (count < max_tries) {
> +		if (core->state != IRIS_CORE_INIT_WAIT)
> +			break;
> +		msleep(interval);
> +		count++;
> +	}

Is the intention here really to poll and sleep for 10 milliseconds and 
if so why ?

Shouldn't there be some sort of bootup IRQ or event that we can trap ?

That's how it works in the venus driver right ? Just kick a workqueue 
when the IRQ fires and have the iris_core_init_wait() do a 
wait_for_completion_timeout().


> +int iris_hfi_session_open(struct iris_inst *inst)
> +{
> +	struct iris_core *core;
> +	int ret;
> +
> +	inst->packet_size = 4096;
> +	inst->packet = kzalloc(inst->packet_size, GFP_KERNEL);
> +	if (!inst->packet)
> +		return -ENOMEM;

Who is responsible for cleaning up this allocation ?

> +
> +fail_free_packet:
> +	kfree(inst->packet);

freed here.

> +int iris_hfi_session_close(struct iris_inst *inst)
> +{
>  }

but not here ?

Still finding this alot of code to go through.

Please try to break this up into smaller series.

---
bod


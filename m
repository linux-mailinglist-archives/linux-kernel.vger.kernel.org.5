Return-Path: <linux-kernel+bounces-5104-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A7C581869C
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 12:48:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7811CB238E8
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 11:48:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4487E16407;
	Tue, 19 Dec 2023 11:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Vk3KrWML"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1440A15AD3
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 11:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-55370780c74so2336794a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 03:48:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702986515; x=1703591315; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wNbilt185g1wxKFzamONNfwxhQz25Ie/vMm1An19wsE=;
        b=Vk3KrWMLb6L7/pCQ7YRqw9ZQjfDI21XdPSNxmRDBo1zewcuxQpNGmSanEOFNB8h0A/
         34xl7nLNLy5nF+hKWaSvM3wiwmkCkIEYTLUQjzr2pe6TkBbyOtVhMIKrQMhY+zrA46hd
         Xezl+VZ3AZcEEm+AT8EqlyjhUECcba9QHqTXphv2Mrzly03+ebpGR/ARLMFA6pWOOuWp
         4ZdR+g74mK2NJ83WZT4aF2Igmm+APKGuklspG+6JLyngAN/j2TVAQH0eaN0JUdvcoQGC
         fEEyVUMNgxNXJYRHCKpaWZe3JxPY6OngyPg/6HTy3AI+pcpMNn9ZR6Hz18MICQoE3BLb
         BNCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702986515; x=1703591315;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wNbilt185g1wxKFzamONNfwxhQz25Ie/vMm1An19wsE=;
        b=GXNgex+a/LV1K2Uf9wLBBHjzNCEp13mYd2TkL18D9jazRFHoF2tkeppBdfLYFl02BQ
         Jwoh0601BdqXNdk0XqBiSXPAHHa0Egv8qnpvlRb/i9vyoG9x4z7gAhe1Upb9Bb6czDfw
         9K7Mmsx9qVzUxx7ZuhqfnkIEd2OdfWZD6LFBJESurWrAvIOUKxQ6nzNoIa75cArmnWsn
         nmraKIZ2WQrCiPc0zo0gANmnDa0yMm2xK5mru584Qz+cc/BDMX6hLwBimorAiBe1Lnzy
         ZghgwsfuGMC3HiGWQl/oanT177myM8on07d2iwckxrH0qQNKDDqgnfO0mBOuCuFe3UTz
         wbew==
X-Gm-Message-State: AOJu0YwMaNQkx9PKF1jXUhxsNew4RaUjFXfV5THq2UvBksHE789RMDrx
	v/XRVKlxvaCVJ38jEbgQZBvTYA==
X-Google-Smtp-Source: AGHT+IE1UXczG2bSR4oKNwgUpRn2UY9X60VdQQvVnO04IFDUlJZ2TtqiChLrg2FvfIAkuxCzST688w==
X-Received: by 2002:a50:99de:0:b0:553:35f8:e143 with SMTP id n30-20020a5099de000000b0055335f8e143mr2513712edb.67.1702986515321;
        Tue, 19 Dec 2023 03:48:35 -0800 (PST)
Received: from [192.168.199.59] (178235179206.dynamic-4-waw-k-1-3-0.vectranet.pl. [178.235.179.206])
        by smtp.gmail.com with ESMTPSA id q24-20020a056402041800b00553165eb4f7sm2966501edv.17.2023.12.19.03.48.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Dec 2023 03:48:35 -0800 (PST)
Message-ID: <23a3955e-744f-4436-adb7-790de9c2f084@linaro.org>
Date: Tue, 19 Dec 2023 12:48:33 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 15/34] media: iris: add handling for interrupt service
 routine(ISR) invoked by hardware
Content-Language: en-US
To: Dikshita Agarwal <quic_dikshita@quicinc.com>,
 linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
 stanimir.k.varbanov@gmail.com, quic_vgarodia@quicinc.com, agross@kernel.org,
 andersson@kernel.org, mchehab@kernel.org, bryan.odonoghue@linaro.org
Cc: linux-arm-msm@vger.kernel.org, quic_abhinavk@quicinc.com
References: <1702899149-21321-1-git-send-email-quic_dikshita@quicinc.com>
 <1702899149-21321-16-git-send-email-quic_dikshita@quicinc.com>
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <1702899149-21321-16-git-send-email-quic_dikshita@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 18.12.2023 12:32, Dikshita Agarwal wrote:
> Allocate interrupt resources, enable the interrupt line and IRQ handling.
> Register the IRQ handler to be called when interrupt occurs and
> the function to be called from IRQ handler thread.
> The threads invoke the driver's response handler which handles
> all different responses from firmware.
> 
> Signed-off-by: Dikshita Agarwal <quic_dikshita@quicinc.com>
> ---
[...]

> +
> +irqreturn_t iris_hfi_isr_handler(int irq, void *data)
> +{
> +	struct iris_core *core = data;
> +
> +	if (!core)
> +		return IRQ_NONE;
Should this even be possible?

> +
> +	mutex_lock(&core->lock);
> +	call_vpu_op(core, clear_interrupt, core);
> +	mutex_unlock(&core->lock);
> +
> +	__response_handler(core);
> +
> +	if (!call_vpu_op(core, watchdog, core, core->intr_status))
> +		enable_irq(irq);
> +
> +	return IRQ_HANDLED;
> +}
> diff --git a/drivers/media/platform/qcom/vcodec/iris/iris_hfi.h b/drivers/media/platform/qcom/vcodec/iris/iris_hfi.h
> index 8a057cc..8a62986 100644
> --- a/drivers/media/platform/qcom/vcodec/iris/iris_hfi.h
> +++ b/drivers/media/platform/qcom/vcodec/iris/iris_hfi.h
> @@ -14,4 +14,7 @@ int iris_hfi_core_deinit(struct iris_core *core);
>  int iris_hfi_session_open(struct iris_inst *inst);
>  int iris_hfi_session_close(struct iris_inst *inst);
>  
> +irqreturn_t iris_hfi_isr(int irq, void *data);
> +irqreturn_t iris_hfi_isr_handler(int irq, void *data);
> +
>  #endif
> diff --git a/drivers/media/platform/qcom/vcodec/iris/iris_hfi_response.c b/drivers/media/platform/qcom/vcodec/iris/iris_hfi_response.c
> new file mode 100644
> index 0000000..829f3f6
> --- /dev/null
> +++ b/drivers/media/platform/qcom/vcodec/iris/iris_hfi_response.c
> @@ -0,0 +1,184 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) 2022-2023 Qualcomm Innovation Center, Inc. All rights reserved.
> + */
> +
> +#include "hfi_defines.h"
> +#include "iris_hfi_packet.h"
> +#include "iris_hfi_response.h"
> +
> +static void print_sfr_message(struct iris_core *core)
I'm not sure how 'print' relates to what this function does

[...]

> +static int handle_system_error(struct iris_core *core,
> +			       struct hfi_packet *pkt)
> +{
> +	print_sfr_message(core);
> +
> +	iris_core_deinit(core);
Either take the return value of /\ into account, or make this function
void.

> +
> +	return 0;
> +}

[...]

> +
> +struct sfr_buffer {
> +	u32 bufsize;
> +	u8 rg_data[];
Looks like you skipped static code checks.. Use __counted_by

[...]

> @@ -17,6 +17,8 @@
>  #define CPU_CS_VCICMDARG0_IRIS3     (CPU_CS_BASE_OFFS_IRIS3 + 0x24)
>  #define CPU_CS_VCICMDARG1_IRIS3     (CPU_CS_BASE_OFFS_IRIS3 + 0x28)
>  
> +#define CPU_CS_A2HSOFTINTCLR_IRIS3  (CPU_CS_BASE_OFFS_IRIS3 + 0x1C)
You're mixing upper and lowercase hex throughout your defines.

[...]

> +static int clear_interrupt_iris3(struct iris_core *core)
> +{
> +	u32 intr_status = 0, mask = 0;
> +	int ret;
> +
> +	ret = read_register(core, WRAPPER_INTR_STATUS_IRIS3, &intr_status);
> +	if (ret)
> +		return ret;
> +
> +	mask = (WRAPPER_INTR_STATUS_A2H_BMSK_IRIS3 |
> +		WRAPPER_INTR_STATUS_A2HWD_BMSK_IRIS3 |
> +		CTRL_INIT_IDLE_MSG_BMSK_IRIS3);
unnecesary parentheses

> +
> +	if (intr_status & mask)
> +		core->intr_status |= intr_status;
> +
> +	ret = write_register(core, CPU_CS_A2HSOFTINTCLR_IRIS3, 1);
> +
> +	return ret;
why not return write_register directly?

Konrad


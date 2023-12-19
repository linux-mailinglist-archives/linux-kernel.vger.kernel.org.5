Return-Path: <linux-kernel+bounces-5120-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CFCA8186BB
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 12:57:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07727284968
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 11:57:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CCBB15E90;
	Tue, 19 Dec 2023 11:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Fj4jtHZx"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4BFB19BBD
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 11:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-548ce39b101so5494339a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 03:57:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702987020; x=1703591820; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ybdWg0p5ieAxtL6thx9FlqVpkKiWZwVkAS/JvS6cgMc=;
        b=Fj4jtHZxA7wMv+c9GAvWzMgNPt7fmryevnzjAnQxLzFVD6BjgckUqHAh/EMfROSksY
         I2o+f79qFH9Xl78z74ewMqvKCIKXv5K87WrF1L1gy/JcVl69ar5LmfkULP1N5yXsOPcz
         JMJn9Dk4LUWlJcXH52NAk39pxjiZFU5qGQ0IBSNoTqrj8NxYRXGEpblfzFhI82x0y50G
         LW/IJs2A92Cu04Tqujn2n+G1z8LwHx019van5ST6rDSU80mE9PgJnZbAeIejYFksIxuX
         FRy1GhCSEDKDP/D+kFnKsMA5AbJj5gOoluFyRaSVJSKRo0HE7OQN9q9fRb73aOzURP95
         G6sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702987020; x=1703591820;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ybdWg0p5ieAxtL6thx9FlqVpkKiWZwVkAS/JvS6cgMc=;
        b=NBvK1OAaPIPyP/mEmzuJi/L0p4eVwhWczY5BC/3OeP9Or8de0MMcXAGYxJtBYdBjtm
         4zS9XuIQfOQRQ3/u2RUjOAsPk0pxF8AKJJmV86JvHZ933bujxF0MZvks7lnCCUMYdnie
         c89U3DxlAev1+CW3RpqdIAD+v7A1nGsdHHerTO2ejS06pRH9rxO6Ges1FQjMa1U78pHF
         oPqjhtJoHtJprxLeZ/Q+6idkFt5RDS57WQbQKzk6zrDBwzWoq/XbPGzeEhVPe5PJzKEU
         8oXjEDhwgSa4GHO3RdtcSs4Tzx2DgpgsLy1NsftTyinii95Ki3rSgZEnmnPfjwso4FKH
         quCg==
X-Gm-Message-State: AOJu0YwaWQkwzmYcy9aLK5+hyOYHdWBRHRwO7WJdU39iSqrHGE6pwnkS
	g9PpD9exI1Cj4iB+qXGkkiUiHV7anpbxX77n854=
X-Google-Smtp-Source: AGHT+IFr/VSXFaGrMriE3FvKF1pNiIXNzuKVUdZZ1ydYQaWnE16tajT3EdnNVw5gCcv8KtDH1tcfXw==
X-Received: by 2002:a17:907:8688:b0:a23:682b:519b with SMTP id qa8-20020a170907868800b00a23682b519bmr994903ejc.152.1702987020005;
        Tue, 19 Dec 2023 03:57:00 -0800 (PST)
Received: from [192.168.199.59] (178235179206.dynamic-4-waw-k-1-3-0.vectranet.pl. [178.235.179.206])
        by smtp.gmail.com with ESMTPSA id x24-20020a170906135800b00a25501f4160sm458297ejb.1.2023.12.19.03.56.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Dec 2023 03:56:59 -0800 (PST)
Message-ID: <cb2a921c-5c8e-44c8-af1d-78d877977b62@linaro.org>
Date: Tue, 19 Dec 2023 12:56:57 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 17/34] media: iris: implement vb2_ops queue setup
Content-Language: en-US
To: Dikshita Agarwal <quic_dikshita@quicinc.com>,
 linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
 stanimir.k.varbanov@gmail.com, quic_vgarodia@quicinc.com, agross@kernel.org,
 andersson@kernel.org, mchehab@kernel.org, bryan.odonoghue@linaro.org
Cc: linux-arm-msm@vger.kernel.org, quic_abhinavk@quicinc.com
References: <1702899149-21321-1-git-send-email-quic_dikshita@quicinc.com>
 <1702899149-21321-18-git-send-email-quic_dikshita@quicinc.com>
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <1702899149-21321-18-git-send-email-quic_dikshita@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 18.12.2023 12:32, Dikshita Agarwal wrote:
> Implement queue_setup vb2_ops.
> Calculate the buffer count and buffer size as par video
> hardware requirement and updates to client.
> Also, allocate the video driver buffers for output and
> capture plane.
> 
> Signed-off-by: Dikshita Agarwal <quic_dikshita@quicinc.com>
> ---
[...]

> +static int input_min_count(struct iris_inst *inst)
> +{
> +	return MIN_BUFFERS;
> +}
Why is this a function?

> +
> +static int output_min_count(struct iris_inst *inst)
> +{
> +	int output_min_count;
> +
> +	switch (inst->codec) {
> +	case H264:
> +	case HEVC:
> +		output_min_count = 4;
> +		break;
> +	case VP9:
> +		output_min_count = 9;
> +		break;
> +	default:
> +		output_min_count = 4;
> +		break;
> +	}

switch (inst->codec) {
case VP9:
	return 9;
case H264:
case HEVC:
default:
	return 4;
}

> +
> +	return output_min_count;
> +}
> +
> +int iris_get_buf_min_count(struct iris_inst *inst,
> +			   enum iris_buffer_type buffer_type)
> +{
> +	switch (buffer_type) {
> +	case BUF_INPUT:
> +		return input_min_count(inst);
> +	case BUF_OUTPUT:
> +		return output_min_count(inst);
> +	default:
> +		return 0;
> +	}
> +}
> +
> +static u32 input_buffer_size(struct iris_inst *inst)
> +{
> +	u32 base_res_mbs = NUM_MBS_4k;
> +	u32 frame_size, num_mbs;
> +	struct v4l2_format *f;
> +	u32 div_factor = 1;
> +	u32 codec;
> +
> +	f = inst->fmt_src;
> +	codec = f->fmt.pix_mp.pixelformat;
> +
> +	num_mbs = get_mbpf(inst);
> +	if (num_mbs > NUM_MBS_4k) {
> +		div_factor = 4;
> +		base_res_mbs = inst->cap[MBPF].value;
> +	} else {
> +		base_res_mbs = NUM_MBS_4k;
> +		if (codec == V4L2_PIX_FMT_VP9)
> +			div_factor = 1;
> +		else
> +			div_factor = 2;
> +	}
> +
> +	frame_size = base_res_mbs * MB_IN_PIXEL * 3 / 2 / div_factor;
that's a bit magic..

> +
> +	 /* multiply by 10/8 (1.25) to get size for 10 bit case */
misaligned


Konrad


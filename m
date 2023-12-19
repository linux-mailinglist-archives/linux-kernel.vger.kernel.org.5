Return-Path: <linux-kernel+bounces-5156-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C103818751
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 13:22:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A54611C2361F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 12:22:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8572179BD;
	Tue, 19 Dec 2023 12:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sNw+3yVw"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7B4918627
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 12:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a235500d0e1so282352966b.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 04:21:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702988516; x=1703593316; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0CEiJgT5P0e8etc9AWKXXwUi/gsPPz45OiynIwkEEKA=;
        b=sNw+3yVwgzNdaI30nFtwMSE3JTWxugn49mhgfsnq2CB+A4VgD1QaSZTWIWZ8Zx9x2w
         EYjU4g7kDnrTrR/MSwAsldE3nTav70jrh7ZtLXHUci3UqcZuyszSVYQ+6QI/wn4yq07+
         cd+EwJc2xF/nU9foka9S1j2e0soh9N9a5y2gvRS2BV8aP/MmyrR9b7PHE7DFpR5CWaIy
         crnoB3w8EDBTSuZoIhATXma6E9u7b0g41Xu5LsdxFSweY6YJs1omcxls7LoRVAslKx9k
         DGy2hEEpI5dgPWdqqMJc1lw6mfncHY46nQEu5sQUUt5tpifRgkjesYCotgrVq2uW7Zcz
         a5zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702988516; x=1703593316;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0CEiJgT5P0e8etc9AWKXXwUi/gsPPz45OiynIwkEEKA=;
        b=NmfyrgpU5TxBUAmun1QgyrCav3Z0jM8mUkwIp1dw/OUz2aTzkvGzJN/CDSOuGZMKYI
         MXvhf6ThhDa8qUXXqOa9/7sAbxMkkM5xsinnT3sTX3E4chkPcRlkIHFdmXL9mKaJHlUa
         U1oLVTG8ON7n73QmPDVXSEvEJzHRYXd+J9Z+YhKCiBvgVA4oMebRlsSdtitr4ObyoxBJ
         ELJzaM78/hm/vz4M9PEMhF1JjI9oYhyrh9JqLUZ2x0unOeJuvP+hTQM0oWYi+revBuz7
         X74D9x0BzprZvdzCGtuvtzVvrUbNO1SLM8JGHxvFhIAmj4WOFlTWvAm56eKcHWxCoO6p
         UO8Q==
X-Gm-Message-State: AOJu0YxNXYAlk0StLudQVEabRw263k0H31ctRDS+RsW63+a1EPvNtVqe
	EA2FiXFJE26XggcSMdgfpILB6w==
X-Google-Smtp-Source: AGHT+IGwjMZX13mWqLSLi0GCb/GG41J8ap0XmRV+xreXW8Qy5BnoLfgVRE2b0x08Ttphc9Y5AUgEvA==
X-Received: by 2002:a17:906:5307:b0:a25:c27:11c6 with SMTP id h7-20020a170906530700b00a250c2711c6mr429255ejo.131.1702988515896;
        Tue, 19 Dec 2023 04:21:55 -0800 (PST)
Received: from [192.168.199.59] (178235179206.dynamic-4-waw-k-1-3-0.vectranet.pl. [178.235.179.206])
        by smtp.gmail.com with ESMTPSA id se13-20020a170907a38d00b00a1fa6a70b92sm11602034ejc.111.2023.12.19.04.21.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Dec 2023 04:21:55 -0800 (PST)
Message-ID: <10f7180f-0241-4b69-b331-9d82da15e0c5@linaro.org>
Date: Tue, 19 Dec 2023 13:21:53 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 27/34] media: iris: implement vb2 ops for buf_queue and
 firmware response
Content-Language: en-US
To: Dikshita Agarwal <quic_dikshita@quicinc.com>,
 linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
 stanimir.k.varbanov@gmail.com, quic_vgarodia@quicinc.com, agross@kernel.org,
 andersson@kernel.org, mchehab@kernel.org, bryan.odonoghue@linaro.org
Cc: linux-arm-msm@vger.kernel.org, quic_abhinavk@quicinc.com
References: <1702899149-21321-1-git-send-email-quic_dikshita@quicinc.com>
 <1702899149-21321-28-git-send-email-quic_dikshita@quicinc.com>
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <1702899149-21321-28-git-send-email-quic_dikshita@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 18.12.2023 12:32, Dikshita Agarwal wrote:
> Implement vb2 ops for buf queue. Below are the different
> buffer attributes:
> BUF_ATTR_DEFERRED - buffer queued by client but not submitted
> to firmware.
> BUF_ATTR_READ_ONLY - processed buffer received from firmware
> as read only. These buffers are held in firmware as reference
> for future frame processing.
> BUF_ATTR_PENDING_RELEASE - buffers requested to be released
> from firmware.
> BUF_ATTR_QUEUED - buffers submitted to firmware.
> BUF_ATTR_DEQUEUED - buffers received from firmware.
> BUF_ATTR_BUFFER_DONE - buffers sent back to vb2.
> 
> Buffers are submitted and received via HFI_CMD_BUFFER.
> Firmware associates below flags during buffer response:
> HFI_BUF_FW_FLAG_RELEASE_DONE - buffer released in firmware.
> HFI_BUF_FW_FLAG_READONLY - buffer used as reference in firmware.
> 
> Input buffers dequeued from firmware are sent directly to vb2.
> 
> Output buffers if read only, are sent to vb2 and also maintained
> in read only list. If the same read only buffer is received form
> client, HFI_BUF_HOST_FLAG_READONLY is attached to the buffer and
> submitted to firmware. Once the buffer is received from firmware
> as non read only, it is removed from read only list.
> 
> Signed-off-by: Dikshita Agarwal <quic_dikshita@quicinc.com>
> ---
[...]

>  
> +enum iris_buffer_flags {
> +	BUF_FLAG_KEYFRAME	= 0x00000008,
> +	BUF_FLAG_PFRAME		= 0x00000010,
> +	BUF_FLAG_BFRAME		= 0x00000020,
> +	BUF_FLAG_ERROR		= 0x00000040,
BIT(3), 4, 5, 6?

Konrad


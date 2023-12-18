Return-Path: <linux-kernel+bounces-3843-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BCC1E8173BA
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 15:37:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 26FB3B23553
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 14:36:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D22037881;
	Mon, 18 Dec 2023 14:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="A8R5TvCU"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEC553064A
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 14:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-40c3ceded81so30772285e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 06:36:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702910205; x=1703515005; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RFZs/3Wbmexgnl5ZTw/8x30eU3SHu9jamuPsXE1q52c=;
        b=A8R5TvCUydHGChdi+Dft2Uf/XrMmqK5fxUXSlXM66bRGjCFGDPBsMy77BgzVcqAtZV
         /wh38hyKLGP4L0CljAE5B/v9oswfDC+UNSQzbmmAYJ4DUwaNP2OniFq4jO3RedhbgIki
         IBkcl2mDykaFSndkBBwP81m/nCl/T9rK7V+niO6jxd83MO/ophmXQav0DF2x3pObJ1Ym
         8lW+CXbzABbBA4ox3mPa+aGKZcXH/Cu02A1oT9d+MZfyXIQGGMxo9r898HwokP67Qx0o
         9W5HRP0K0EV5kPxEuaF0AjRbDGI4tSPt8MvmMNd8+ecAgp2s0qqvMEEgJOTlytdCrtpQ
         iNYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702910205; x=1703515005;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RFZs/3Wbmexgnl5ZTw/8x30eU3SHu9jamuPsXE1q52c=;
        b=D4drfcY/6zDGLXJvLyLvWWpBF+8W5WZeGTqg+UJ8659gHsNGXbJfkN00GgjbBRa3Y5
         hJp0OIjyAL1OnZzHmDGKA7Q4lb302ctDWNd4w6dcmT23SIZmyQouovSbiNAkLMv0NB2U
         GB0rTLF2pyYehk9sobobTvYcilxoJIhJjNFtW0izU/Cw4ENBPd9XB01BQ/Lt4n1wRBYJ
         PYNY6KDkfmL9sZroSM4C+3ExX40Xf+8A05FEX8oBTNfqbcXomiz6XnNqpSfNVWte3lZl
         L0LkWiXbKi6MM4WBz3ki14sJemSS8IS7lRv7QBYeXgzyF+4DkYyA6W+SJOsjoPClJEzp
         3e9w==
X-Gm-Message-State: AOJu0YwfjqyXaDk2FwQukifCLCeyJfJs158ywEiHDj6jqQp61ZfyXnoG
	yUbBfxAMUWO9ypYDiiQCJEBDiEo9ZJTY7vKfwXLkeg==
X-Google-Smtp-Source: AGHT+IH2zU09XGn9a1A5jsiFX5EKxPAu8CnagvvjmrliEL3m0wJXol99SzLAdDlm534o1g/o7StY4w==
X-Received: by 2002:a05:600c:3790:b0:40b:5e21:ec3c with SMTP id o16-20020a05600c379000b0040b5e21ec3cmr8078122wmr.110.1702910204861;
        Mon, 18 Dec 2023 06:36:44 -0800 (PST)
Received: from [192.168.100.85] ([37.228.218.3])
        by smtp.gmail.com with ESMTPSA id fm14-20020a05600c0c0e00b00407b93d8085sm44580442wmb.27.2023.12.18.06.36.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Dec 2023 06:36:44 -0800 (PST)
Message-ID: <254de913-3ac7-4e19-ab32-2ee663e0d7e1@linaro.org>
Date: Mon, 18 Dec 2023 14:36:43 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/34] Qualcomm video encoder and decoder driver
To: Dikshita Agarwal <quic_dikshita@quicinc.com>,
 linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
 stanimir.k.varbanov@gmail.com, quic_vgarodia@quicinc.com, agross@kernel.org,
 andersson@kernel.org, konrad.dybcio@linaro.org, mchehab@kernel.org
Cc: linux-arm-msm@vger.kernel.org, quic_abhinavk@quicinc.com
References: <1702899149-21321-1-git-send-email-quic_dikshita@quicinc.com>
Content-Language: en-US
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <1702899149-21321-1-git-send-email-quic_dikshita@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 18/12/2023 11:31, Dikshita Agarwal wrote:

> Static tools like checkpatch, smatch, dt_binding_check, sparse and Coccinelle
> run successfully with this driver.
> 
>   The output of v4l2-compliance test looks like:
> 
> v4l2-compliance SHA: not available, 64 bits
>   
> Cannot open device /dev/vido0, exiting.
> root@qemuarm64:/usr/bin# ./v4l2-compliance -d /dev/video0
> v4l2-compliance SHA: not available, 64 bits
>   
> Compliance test for iris_driver device /dev/video0:
>   
> Driver Info:
>          Driver name      : iris_driver
>          Card type        : iris_decoder
>          Bus info         : platform:iris_bus
>          Driver version   : 6.6.0
>          Capabilities     : 0x84204000
>                  Video Memory-to-Memory Multiplanar
>                  Streaming
>                  Extended Pix Format
>                  Device Capabilities
>          Device Caps      : 0x04204000
>                  Video Memory-to-Memory Multiplanar
>                  Streaming
>                  Extended Pix Format

Good to see some code sharing, is there no way to facilitate the new 
code in existing venus ?

I applied your patches to -stable and was happy to find they didn't 
break venus on rb5, at least for the superficial test I did [1]. The 
names you export here look odd though.

"Driver name" and "Cart Type" should be something like "qcom-iris" and 
"Qualcomm Iris video decoder"

v4l2-compliance -d /dev/video15
v4l2-compliance 1.24.1, 64 bits, 64-bit time_t

Compliance test for qcom-venus device /dev/video15:

Driver Info:
         Driver name      : qcom-venus
         Card type        : Qualcomm Venus video encoder
         Bus info         : platform:qcom-venus
         Driver version   : 6.7.0
         Capabilities     : 0x84204000
                 Video Memory-to-Memory Multiplanar
                 Streaming
                 Extended Pix Format
                 Device Capabilities
         Device Caps      : 0x04204000
                 Video Memory-to-Memory Multiplanar
                 Streaming
                 Extended Pix Format
         Detected Stateful Encoder
  [1] 
https://file-examples.com/index.php/sample-video-files/sample-mp4-files/

ffplay -loglevel debug -codec:video h264_v4l2m2m -i sample-30s.mp4

> Driver Info:
>          Driver name      : iris_driver
>          Card type        : iris_encoder

Same comment on normalising names wrt to venus.

---
bod


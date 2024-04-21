Return-Path: <linux-kernel+bounces-152578-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 40DBC8AC0B8
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Apr 2024 20:18:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA6A11F2101B
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Apr 2024 18:18:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDF1D3C471;
	Sun, 21 Apr 2024 18:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R4KMYwQ1"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 874F6286AC;
	Sun, 21 Apr 2024 18:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713723524; cv=none; b=npNXAmotQi6FdXsPTUs5Dznbf3/hP3qLwcg5t5f7oJHzlJe32N84mv3myOTFrK/Xxo+XSZMwIWdryFmXNBq8qYmTNOd1OiwlX3hQr51kE0CmLjGP2Me6LbXUg0yRsr6eLipLKE7bwrpIY0U/9KaRrapR6R+7O8gBSdq1whmUYsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713723524; c=relaxed/simple;
	bh=6H1TIF/0XcXz6iEQrWrwLwyYZgPxQRBE8Doz/MbHlYc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fB+xHXJO/mSZOl2T/vlWIOX2Ar61gZHKlSMuVR0rDEj8IHCZCmiwlhd4dcT4rGLq8o7zw4FPhWdffjuF45tGn9H8L6dmQvSeKW2ThX3f8jj1iWf/EV7PwxbIyjdIlNJca7ngHO/09bnAzLWQGhcetArLoVXR5VzRjQiGqxUFJSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R4KMYwQ1; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a52223e004dso340282566b.2;
        Sun, 21 Apr 2024 11:18:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713723521; x=1714328321; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kGTvaXqfOO9FIjG6XNcvN3Rhrhq89n4tPuy0EipmS14=;
        b=R4KMYwQ1oZxqrFra+61GeVA96BEUeywvRtnzNooJBA8UluGc3XLdkUpMhn3ehUy+OS
         wjqR/wnXItP5iEoIW3L4EauRKDnI/0fpsWX/Ar/TiR5Kq6S+UxoGsPsJmPsAQFAQDgpR
         GXrGVWrF4iaz/hvJE0KTYKPA81FHnX1KbMXkKym83rP2wvJ0DMrUFVMGqgcd+oTdluIS
         H3Bn1aYjcC05J0A1xXjM/V3+ww0mBvGXORa+jpaW3sHPaw3eq6gK+vD+34I/L2p6pzKL
         2Nppq5gw0BSRinIqAI5gxa8oBnG33cPWvpuOLmnecB6MVriIXweDFFZBpQDvumL2ZbgS
         Ie1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713723521; x=1714328321;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kGTvaXqfOO9FIjG6XNcvN3Rhrhq89n4tPuy0EipmS14=;
        b=gszDhA/FdeYvzNf1kgM8VC7m4Cv+A3N1fyaA6ZnCY8qHwahIoRma0MfZb0W4sPTJz0
         Fv55VgmQ8b3pxgymgpA8w58nJr/yYF2D343Sn7ged5Oiw6+aGP6H4Qu1/rVjgkiGGuUH
         omG6LR5wz2/7MzBNBOOAnJqSYQ83zzdXBPHeP/3fYdrSCJozl6mBo2PVtwQsloWvrlha
         XH9agULU5kmAyswHayIwuQB6a+CgzeG9WsE656mm7uC/AUiVWXR0mblYRV67gL7iuf8m
         Crj1+3sWkNwS+FTbJYE6G3I5ozhv19B87IEoDyq3mJjvuq7SEUynYKTrxpfhy04IKauA
         0hIw==
X-Forwarded-Encrypted: i=1; AJvYcCVQS9GAxGYPo29GR9Rh4Ha9vGER13OKWlTlRYodBN0zHKThksrrfqLtHAmZXr93+qa9YUAyAv5Lj5TfjmrfkrG8vVUWwj70OSdTch2bjHKBIrtIinz2PscFsc/TcNFumOIPlNC/mhZ/ZnmRRBoINEN5tV8p8BgtRaAfr36fCftGJxctPJOavHQH
X-Gm-Message-State: AOJu0YyWR4Wvhg/n5jUQQGVeXgCAhShyYayl/ES0B2KYbQCxLldsH0U6
	heS1OMQe+KGhe1sjJvXghLAm4AFysDYQWzDpgTecmRPtG9g3lKOV
X-Google-Smtp-Source: AGHT+IEpeqp+JRc5yuVDctR/zRlHhMoEHEr9CcTtSJ5st1r/avCC7rh7p15I8Syu+76e0j3BpnFHIA==
X-Received: by 2002:a17:906:394e:b0:a52:4246:92fe with SMTP id g14-20020a170906394e00b00a52424692femr7529330eje.48.1713723520561;
        Sun, 21 Apr 2024 11:18:40 -0700 (PDT)
Received: from [192.168.1.19] (77-76-56-128.ip.btc-net.bg. [77.76.56.128])
        by smtp.gmail.com with ESMTPSA id z13-20020a17090655cd00b00a4739efd7cesm4823285ejp.60.2024.04.21.11.18.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 21 Apr 2024 11:18:40 -0700 (PDT)
Message-ID: <de4698af-e248-4653-89d9-8a421774d1fc@gmail.com>
Date: Sun, 21 Apr 2024 21:18:36 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] media: venus: flush all buffers in output plane
 streamoff
To: Dikshita Agarwal <quic_dikshita@quicinc.com>,
 Vikash Garodia <quic_vgarodia@quicinc.com>, Andy Gross <agross@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>,
 Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 Stanimir Varbanov <stanimir.varbanov@linaro.org>,
 linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <1704867134-5522-1-git-send-email-quic_dikshita@quicinc.com>
Content-Language: en-US, bg-BG
From: Stanimir Varbanov <stanimir.k.varbanov@gmail.com>
In-Reply-To: <1704867134-5522-1-git-send-email-quic_dikshita@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hello Dikshita,

On 10.01.24 г. 8:12 ч., Dikshita Agarwal wrote:
> For scenarios, when source change is followed by VIDIOC_STREAMOFF
> on output plane, driver should discard any queued OUTPUT
> buffers, which are not decoded or dequeued.
> Flush with HFI_FLUSH_INPUT does not have any actual impact.
> So, fix it, by invoking HFI_FLUSH_ALL, which will flush all
> queued buffers.
> 
> Fixes: 85872f861d4c ("media: venus: Mark last capture buffer")

Cc: stable is missing with a kernel version.

> Signed-off-by: Dikshita Agarwal <quic_dikshita@quicinc.com>
> ---
> Changes since v1:
> - Added fixes tag (Bryan)
> 
>   drivers/media/platform/qcom/venus/vdec.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/media/platform/qcom/venus/vdec.c b/drivers/media/platform/qcom/venus/vdec.c
> index 29130a9..0d2ab95 100644
> --- a/drivers/media/platform/qcom/venus/vdec.c
> +++ b/drivers/media/platform/qcom/venus/vdec.c
> @@ -1255,7 +1255,7 @@ static int vdec_stop_output(struct venus_inst *inst)
>   		break;
>   	case VENUS_DEC_STATE_INIT:
>   	case VENUS_DEC_STATE_CAPTURE_SETUP:
> -		ret = hfi_session_flush(inst, HFI_FLUSH_INPUT, true);
> +		ret = hfi_session_flush(inst, HFI_FLUSH_ALL, true);

Is it tested on msm8916? If I remember correctly FLUSH_ALL produces 
session error, could you confirm, please.

-- 
regards,
Stan


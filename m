Return-Path: <linux-kernel+bounces-52290-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 92F8A84965C
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 10:23:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 18C3A1F21A95
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 09:23:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D931612B8C;
	Mon,  5 Feb 2024 09:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JQ23TmhU"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A882125D8
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 09:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707125008; cv=none; b=OfFn/WpTDqidTzv3aOQwEdtZ2oQrxnflVzdd4c++F5Nqt97Op3nzfabUIwr84/hP4QMfQC+AslQYBVSc9zMupXzJb7NR0rVPmiCMGtc0toTqUk3kyuwrXOT8YwBs/XwDsjmFcjGTuXOXV2iQ8jXAFrUXirYjC+kOvBBcAGOGq4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707125008; c=relaxed/simple;
	bh=SGk7Kqu8TOYqzReLG1DQLeqdpHPC8Y3reHFMCaRDXMc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Dpy2EYnyJVMUxX4WcKbox6fZ6Ef+6FZDPyXrOnQnKzjXGnR1/s4cDVrPLYNIxRCKV4pGb3qq7AnfdLmmN0MFVBEXVaFZp1t/Fk1y9Ozqr++MnX83xok+2frmEbqpG7o3BioYxxXzaAmeA9AgJ1/KokeSv8jL+4/yqx0zljCrxjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JQ23TmhU; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a28a6cef709so567839666b.1
        for <linux-kernel@vger.kernel.org>; Mon, 05 Feb 2024 01:23:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707125004; x=1707729804; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=plBen78tfSSHk5XJw12rcPtrRcV/xDD72cRCl9pRHrY=;
        b=JQ23TmhU9dHYsEVlz6Twj6Is/Lz9sBrGD0xDKEvqiqitScqpMo3DOxLhVgIUoBLFcT
         yNWMTGe+oboVgMjxHm2mRhoS39lfJJkbhNcYTdIaXo5MLK0uKL7hpJyNkx5IC/vpGB+j
         s5ANUM44os8hqZFTKisUjfpynui0BgXec2yuS2j3RHC7KYGSuuVQ3SG3PndtMkiiaP84
         742qmQy8qYCT7Q/FwnqwFAR6vgv07kIEma+BAHCRHued5JzxpTkiWxBWYGfFf/d+cujh
         4kHBH3sw6jVvtlo+jSYEfS6GT5zzWjPr0JRDC3XSqXv+/e4XPRiGq1QTKOSjhbdEigSf
         PZhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707125004; x=1707729804;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=plBen78tfSSHk5XJw12rcPtrRcV/xDD72cRCl9pRHrY=;
        b=It14WZ+o9QlO7xWyRducn8k/Mz9Gifr3+3zOFrYZGY/Lk88KMCW6G7rwkVppEWp67f
         zq3WNrmLwag4Juvip/mK8L9iiNZiM7cjxvZH1MdiVBksZs0Jo/5IB7GczSAo6Fjv482t
         rjPY1Py0Ej8oDsXJ8kJIloDb+6qBPrJDVoXHpPMbnjQu5VGa3OxyjM9OAhxJrbQgZvAf
         XbpA6u9WUfufktW1ONGqJ21OZ+g+K8+dscaOgyhbL16H7h9QE/81vxI7ZAG1Gx1SxCZo
         S2uunfoHvP6ChkcnuQZ2lLvAV2ojwdluYyUkxiSqs9xtOw/gtO2y68i4NHZhIO71OlVt
         CQ0Q==
X-Gm-Message-State: AOJu0YxNd6g7Am8Bcg4Nq/VXv9UkWdU0ZNX2d/jQAeGC9fa1WIHB1B7U
	C25bX2BzJ7hJzRhW07jMlK2KFPRPwF4GJSp0osE98aD4HroMRXn5AJI08lW+Cy8=
X-Google-Smtp-Source: AGHT+IETGO7hpzeBCm89doRh3FvvyFPtjKEFgsgRwP4vmWmpqTfipD/6sS60qeShbDbOc9jI/l974g==
X-Received: by 2002:a17:906:c450:b0:a27:5446:27d9 with SMTP id ck16-20020a170906c45000b00a27544627d9mr6300956ejb.5.1707125004444;
        Mon, 05 Feb 2024 01:23:24 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCX2TMuzB4wTLScJqOeUfwQFnxYFrdc+XjbV2Yrj1Ubfagb52+syOwUeFdtuwecePz7lS5sqZTlW9OF1E1VEFwOBS5Gk7uvzEazG6TW//9E5sT4AgEv8iEA5P3N8VcucC6takvFNG0paAvDvMjH6u4Xcr4ft4txjDLf5L4zTCxllFJITVHW4k3+uLSBoAAVUX5xqJSYS6l6Ygs3NEe0tVLpUk+hlvheX6ljItf8rBkm5u5tfC+gjqS6iSuSXJn89YHw5JOHXzS680WBzSxZFaUY/xWELhTiwlmzVKfbJ0NcQpjYhbW9VDDB3f2tn2gs1YGmpHPhOIkqK4DE7lcIjVyvsExxF1vLRlWWUGiOHwW/J5bHpRTg4MAmFmeN4NceKfWkDWUlitZVx3zHeiCFtCho3sIkCcuy2H+y2PpdI2x/RBQrMqVavywq8T70Zn/+HrUwD143oHciSsJrYRymJINZ1y5aEalg1IiQDepAnUNoYvy16EOujrblaP73zcwk7XZbzcxyPopRhAnWhYmnbkZIMEcqhOymqJZND27pvUIBlMjOWIz8pJi+pG/owskb/AL74QzSbslv1tB+ze8AXMXnH+vHADPyGQmLMSgHhg+UDhUqW+B5yB/DjLj/DJpZS/IUc3TycZNjZ+zVy
Received: from [192.168.1.20] ([178.197.222.62])
        by smtp.gmail.com with ESMTPSA id gw14-20020a170906f14e00b00a35200615d7sm4101066ejb.1.2024.02.05.01.23.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Feb 2024 01:23:24 -0800 (PST)
Message-ID: <3d0ce98b-bb4a-44b5-a46a-aa0af9a4fcc8@linaro.org>
Date: Mon, 5 Feb 2024 10:23:21 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: display: msm: sm8650-mdss: Add missing
 explicit "additionalProperties"
To: Rob Herring <robh@kernel.org>, Rob Clark <robdclark@gmail.com>,
 Abhinav Kumar <quic_abhinavk@quicinc.com>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240202222338.1652333-1-robh@kernel.org>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240202222338.1652333-1-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 02/02/2024 23:23, Rob Herring wrote:
> In order to check schemas for missing additionalProperties or
> unevaluatedProperties, cases allowing extra properties must be explicit.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  .../devicetree/bindings/display/msm/qcom,sm8650-mdss.yaml     | 4 ++++
>  1 file changed, 4 insertions(+)
> 

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof



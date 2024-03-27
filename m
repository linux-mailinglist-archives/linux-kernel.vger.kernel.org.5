Return-Path: <linux-kernel+bounces-120994-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A825A88E200
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 14:17:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 53889B26B17
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 12:58:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0487315746B;
	Wed, 27 Mar 2024 12:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LCJ8FZQ+"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AC901386A1
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 12:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711541792; cv=none; b=FNU+vtH6Btot/jyNRhTj4CthpLr5aW7C6YaJkXI04jH/WvWWSdILDXsTeSl6XSRaja7p0C+NMEoTjKcCJ2Fy/VBwlCaXXY5QeiXqTEx7k4EuGvNIJ0ah0OGrLlaz5JHvfSGsdqA8XLF7oDx+hCE2yZmJLRxl0U9wXQ/dlI9dh2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711541792; c=relaxed/simple;
	bh=yGbTvt55JZ2yuDQH/tYgERxwi8pr+LShEOfGErix1xQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=M706wkP/NgMuD+RdWWXYKVpK2UEpjbxo3brGw3a5KqIKD0K4E6RoYH8dvT4tZS50flzdnCNzDI7lRzJbnxMiJk0AyfdXPlk7oXhuu17MuX0ZSNeR7z26Y5CGGIYzaKwIobz/QIQP577SpfLz/PJGT5rncDdSXy0SbGVb8KgGKL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LCJ8FZQ+; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-513d3746950so8307667e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 05:16:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711541788; x=1712146588; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=QGoONQs2q09/EmrMgof9g4Mv4aufcbjH95ck2Mtngjw=;
        b=LCJ8FZQ+0qIkI37OGLiFnpFGn+y0hJ2NND07a+4usaz/4F/LJaRfOFm03DKBU0er87
         vvMVDQ49bEJgIpSIlO7+vRuiFISpsVzZXL/ix7vZdTlHjYD1zl8hJNhbfNugf0vY23D3
         rqe98MM3EOkShv9sFppFWndZ/6p60S4E0q4+ToJZlYcFT+FZhCbR57WM/2K/J5kMrceo
         BdXj+1ZtBKC4aPcPqq6qNpu4OO30oJrYoPo1vNEQgZF+0KT85sMSjGmPtQcylGxwN2bP
         K5hOiyucfMrH33ZBdA7IFiQC5C8lYnk6bxSZwawOTzwd1yIrZEgz3KlFVb44/qWNziGo
         n40w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711541788; x=1712146588;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QGoONQs2q09/EmrMgof9g4Mv4aufcbjH95ck2Mtngjw=;
        b=ZonuhSIpz+9UXJK2o9h1sE+rcE+5CuLTjU5Zlgnt0B3h17nDnYMP6LeU81+yJBXsoq
         E+LkjH1A0TsMywupBEH9QTutp9v7aI6TRrfDtS8DujEPdsqJ73v1WbTvSnKonLK+FR9F
         OloaUYylQsQzc4K+/oTH08ZBAG9pyBm9a+ShCmT4028vZGBJoKeLUYdFJMlu57/Iy/AS
         rj4OdYYxUT/1KV4mljbK8v3i3AWts6mQxMiFRh+SUmA9mV8cIZrhiVoiqOKQ4aLSkjGa
         tICuDe/N7qKO4umTd/YcO5fK9vNap/bayJlaBZ2DJd+i96KH49pqhEg+6GlrBhvQq3VQ
         0h6A==
X-Forwarded-Encrypted: i=1; AJvYcCWnI1RYmX9Fx9xdCdbXdai1bXU56/BriwJOW3SX2tglBCVguxFJ8qtSbGvb7n9OdwTA+bzSAj4A4cOZetWt7Edl/mAPKr/MdRl38Z8k
X-Gm-Message-State: AOJu0YwMXoLZRi8Uesz2g/mNNQ+GKgCqiMTmR19zxOfKGtFFVlGSGs42
	UUDUr0hU42ISnA7GkoIQ8PKCOT7Y/d4XHIv757JIE0TRRoQNz15xFEhbBycnDe8=
X-Google-Smtp-Source: AGHT+IEBW23L28y0ojSMrVa/3AvQS2hcjIPuTGjzOiK2HxOvnKRvYjYdOJ6ZDfOkXAc4n2VT6ydGxw==
X-Received: by 2002:ac2:504a:0:b0:513:da61:9b46 with SMTP id a10-20020ac2504a000000b00513da619b46mr1660346lfm.53.1711541788426;
        Wed, 27 Mar 2024 05:16:28 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.206.205])
        by smtp.gmail.com with ESMTPSA id fi24-20020a056402551800b0056bfa6ad5eesm4904744edb.91.2024.03.27.05.16.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Mar 2024 05:16:27 -0700 (PDT)
Message-ID: <c807c633-c29f-4216-8a53-e0bfa16e6f24@linaro.org>
Date: Wed, 27 Mar 2024 13:16:25 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/2] ASoC: dt-bindings: qcom,qcm6490: Add qcm6490 snd
 qcs6490 sound card
To: Mohammad Rafi Shaik <quic_mohs@quicinc.com>,
 srinivas.kandagatla@linaro.org, bgoswami@quicinc.com, broonie@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, andersson@kernel.org,
 konrad.dybcio@linaro.org, lgirdwood@gmail.com, tiwai@suse.com,
 quic_rohkumar@quicinc.com, linux-kernel@vger.kernel.org,
 alsa-devel@alsa-project.org, linux-sound@vger.kernel.org,
 linux-arm-msm@vger.kernel.org
References: <20240327113228.1706975-1-quic_mohs@quicinc.com>
 <20240327113228.1706975-2-quic_mohs@quicinc.com>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240327113228.1706975-2-quic_mohs@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 27/03/2024 12:32, Mohammad Rafi Shaik wrote:
> Document bindings for the Qualcomm qcm6490 and qcs6490 SoC sound card.
> The bindings are the same as for other newer Qualcomm ADSP sound cards,
> thus keep them in existing qcom,sm8250.yaml file, even though Linux driver
> is separate.
> 
> Signed-off-by: Mohammad Rafi Shaik <quic_mohs@quicinc.com>
> ---
>  Documentation/devicetree/bindings/sound/qcom,sm8250.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/sound/qcom,sm8250.yaml b/Documentation/devicetree/bindings/sound/qcom,sm8250.yaml
> index 2ab6871e89e5..247ad3d10933 100644
> --- a/Documentation/devicetree/bindings/sound/qcom,sm8250.yaml
> +++ b/Documentation/devicetree/bindings/sound/qcom,sm8250.yaml
> @@ -29,6 +29,8 @@ properties:
>        - enum:
>            - qcom,apq8016-sbc-sndcard
>            - qcom,msm8916-qdsp6-sndcard
> +          - qcom,qcm6490-sndcard
> +          - qcom,qcs6490-sndcard

What are the differences between these sound cards? I know that we ask
for specific compatibles per each SoC block, but for similar SoCs sound
cards might be an exception. It's more of a software construct anyway.

Best regards,
Krzysztof



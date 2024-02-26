Return-Path: <linux-kernel+bounces-81024-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8A5E866F2E
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 10:50:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AFD611C24CF9
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 09:50:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13960129A7E;
	Mon, 26 Feb 2024 09:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rzmvm2gp"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71A9C129A72
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 09:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708938920; cv=none; b=RYQPfyQb6joWwteY+FQftvh2vdn/vzDkX5KBCFPJqPveBqoikeo6uxYJpQpk/xqkkXDlsFkHpP+Xp1EKDe4EvTsJjN/Ky5oD7GEnRq9ehSHqxUP3/ft2PhnLWndYos6FLgxM4wa9wdeJF5B/JOh+WkMItQz5A9d7R3tdPg1jfug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708938920; c=relaxed/simple;
	bh=G566LV+/F51/W9KYFln95LPDYYcArDHrm4mzHyYxoZ0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u2nO6n3WPViV+lCsEgkcZRtP/1QL3Mu+gj3khta7Pg6Fq4KNVMh9Pl+t9Ib32gsBDCgrDzEF/JO83Dv+rqL2r+1o2SJLcBWFH8zCRsqt+ht7AEzrGcQHhJYhv7Pr+uxVKesTThq3C7oXXRe+LM9RVE/RZo21SgVft29eO2/5bjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rzmvm2gp; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5655c7dd3b1so4408600a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 01:15:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708938917; x=1709543717; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wlH1Ter4o/LuhmUGIySGl8jfbKhW6NJPyE0QFDQ/6s4=;
        b=rzmvm2gpLi5FHXiOATNBh0HPBz6oZK3tydPONzg486EPi+f+whxmorKHyAtJCQgihS
         waGCktYzu1er1GADpg9n5pLevWKBJlwlxC8weJkbQtOCifNuGOq3a5KhzZad7gjedCyo
         +lgMyZ3g7rxBGrOgnYDCeSyT0eBz0Vi6S6IXVBs2OvYnihxMHkFxaLL19g9YzkJR6mye
         RsixNiZZ9zIPc293Rq6jkJD6WUaYd0tO/GSgychq79NUPetImQU6weoikR8qiiVflAeb
         OYmkLfYGwr0/Diz36Vdv/QeGAyW3JWo8yV0HgHmGSv3Y77LCnx4VnhUvwDe4ZMEAfdZf
         whsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708938917; x=1709543717;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wlH1Ter4o/LuhmUGIySGl8jfbKhW6NJPyE0QFDQ/6s4=;
        b=MkKg3DRstSGlBh/ePV1yc1zCOlWuWxpYpwUf0r/BbARmzAlFf6NPieYMAx+XB/MYX6
         5hujD1jWKDRHm0Go4n8NL1DBgB+evp2LdTvaMWvHHXTSePR8Gu0KeIHQ3p9WN0udtY9k
         s2JG9uSlT+DbsNMsJXTckiyxQP6A5Jf7pV9TBgGgPr8GkFzmno05js7VibSIu2exnQPt
         +gy+Tzp9A0SlVSVEwq6LjQcFS1NkMK+/tNDBlmCbVtKw7BZLxATuMrRLZ0jQIY1aD9pR
         kUFaa+mix6H4zIGFpVLNLPILnYi463wtn00PP0sV0gsuUPv9L0sR8J03P8fwMp6q+1yk
         7xNA==
X-Forwarded-Encrypted: i=1; AJvYcCWYvG51WU8jK+1+4OVJn61d0gUERZL8uCe7YZFrDtjQkoLzfz7t2Q68yssfewjWAstvio2Yi4+EdmX4Kl4dmIdfZXMyw8xUi+hMfn8X
X-Gm-Message-State: AOJu0Yzi1H4newCT/mCRhi/8phjBZHyVHXnnbEM0qWrdQWFPkFk8Q1Pq
	QdQugLQOeL7N39EsbrYEK1FSIu7zLQ/eQzy+dPiuVz8OOABmpMOwYAB7f2+iy9o=
X-Google-Smtp-Source: AGHT+IEXUVR/N8Ym4kzVlbEuwaD2lWsgOYP5/F36Su6nMdyWMJ//J8As/t2DKFX23EsFXq+ZVVEfZg==
X-Received: by 2002:a17:906:1745:b0:a3f:2168:214b with SMTP id d5-20020a170906174500b00a3f2168214bmr5890928eje.1.1708938916861;
        Mon, 26 Feb 2024 01:15:16 -0800 (PST)
Received: from [192.168.1.20] ([178.197.222.116])
        by smtp.gmail.com with ESMTPSA id tl18-20020a170907c31200b00a437d3e975esm167009ejc.210.2024.02.26.01.15.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Feb 2024 01:15:16 -0800 (PST)
Message-ID: <310cefcb-a4d5-4f4f-a482-ba2ff08a57f6@linaro.org>
Date: Mon, 26 Feb 2024 10:15:14 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 9/9] ARM: dts: chameleonv3: Add video device nodes
Content-Language: en-US
To: =?UTF-8?Q?Pawe=C5=82_Anikiel?= <panikiel@google.com>, airlied@gmail.com,
 akpm@linux-foundation.org, conor+dt@kernel.org, daniel@ffwll.ch,
 dinguyen@kernel.org, hverkuil-cisco@xs4all.nl,
 krzysztof.kozlowski+dt@linaro.org, maarten.lankhorst@linux.intel.com,
 mchehab@kernel.org, mripard@kernel.org, robh+dt@kernel.org,
 tzimmermann@suse.de
Cc: devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
 chromeos-krk-upstreaming@google.com, ribalda@chromium.org
References: <20240221160215.484151-1-panikiel@google.com>
 <20240221160215.484151-10-panikiel@google.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240221160215.484151-10-panikiel@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 21/02/2024 17:02, Paweł Anikiel wrote:
> Add device nodes for the video system present on the Chameleon v3.
> It consists of six framebuffers and two Intel Displayport receivers.
> 
> Signed-off-by: Paweł Anikiel <panikiel@google.com>
> ---

..

> +		dprx_sst: dp-receiver@c0064000 {
> +			compatible = "intel,dprx-20.0.1";
> +			reg = <0xc0064000 0x800>;
> +			interrupt-parent = <&dprx_sst_irq>;
> +			interrupts = <0 IRQ_TYPE_EDGE_RISING>;
> +			intel,max-link-rate = <0x1e>;

Rate is not in hex! Rate is in Hz, at least usually...

Fix your bindings...

Best regards,
Krzysztof



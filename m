Return-Path: <linux-kernel+bounces-50605-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F761847B7F
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 22:26:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C388D1C22A49
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 21:26:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C719A8175C;
	Fri,  2 Feb 2024 21:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Sf3OCmb+"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86D8280635
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 21:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706909180; cv=none; b=EYUfHH1fWufopw3c4llEp5fq4JWvPtslPzhJvFcdgvZAPinlwmyNys9TxiztrOyzFHlh7FC+FXK1PsGqV6hwy7YPlKCHfVGhXgVADLTwzRW5bVsKO/zuWMiO2M9xOA2Qw5fw+QmFcmetqbbsjU6WMsJP6RE2US7oU8v967tCcDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706909180; c=relaxed/simple;
	bh=laYlLSczKRguWCQE53OfIsdOEgJiAC/wjE7KI/+Blw8=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=ZCAAQPp0Fm5jRr4byuuZOiSjyPC+6HUXI7V5rSqZDz41C9oNfas4X6s40jg0lkyv1da6H/wJWZKe8mEFgUwp6/p4aH9klvDs+U1Ucr0uO43Et6XtdEwG/5d4gTcvfp8dJTO3Kpsbx1bPeQO8GrGWLEICqWrXtTSYcLDZZrgDwhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Sf3OCmb+; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-40fccd090c2so2538485e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 02 Feb 2024 13:26:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706909176; x=1707513976; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TmB9on2Qyd1/EoIwQXgbQR2FlMtBTSI1mKzg7M+hgpA=;
        b=Sf3OCmb+KdgFVYpXJ8PE3J4m3HVz0Hy82fxa133l+afQim2VDs0bi9/ZEqCog5EpAR
         T6ZXYioWzIZZUd0rGuS+F77v7iv1l2NVaDsuyMyzCWnNA0AQBhr3Lnlh79g8aPTTTKhv
         Fyrg5quTVV/Lfc5LEzuC4kJEJMr0IkmoOHVpdEGn+XC6ls8hQ1GFRxVrzcT/bczeWsit
         KMyRiaQGOpLot6Xmyz1k72c03DZTxdmlaFxn4QOOM5FWduhPuynmbPhM2CZhvvHAwrkh
         WYZV42M3NUFLoD5gWVzWMZnTyzaYMC87cZN/cf+FeXzr1WxT7+czsa1YjcgUjcJ8XmSK
         CVBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706909176; x=1707513976;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=TmB9on2Qyd1/EoIwQXgbQR2FlMtBTSI1mKzg7M+hgpA=;
        b=BqHz9Ql7XgESoSzWPSD0FU8cbJpcvkoS9ueW6GbVnAuHA8YD/YxWD7qFUz+whswhSE
         0LksVShYY0kzzBwtcb3BpFGA4wXNSJHMzdPp+IMSRIr7RRaXFRu1BgXdhNZrsXQwJenI
         7pk0EDfdOxBU0dlu1nNod4YPHoi/klv6e1oo8IkgSRvH6Fmg89bQd/wKoFQbVTz1bNoa
         XZvD1niWA9YQaSFMNB/FNmf3qf94Mdf/KVVRoHpdU/IPAu49FXy2hQrhxvOx6k+mq/UV
         mf6XuWVY9SQoEgYVnwKlkfm4XPZPrr+Jr7muWF8J19VQ5ezwIVH6QrlvuhpaeeOyQo8A
         lrLQ==
X-Gm-Message-State: AOJu0Yxl13U61Sk+AOY8lWHnISrjDdOBXFqugHdfAhUMyw1BkvcopWUg
	9TcdbnvyFtEKdmVLPUYiEoLz0wWDubDPIr/NdtTAgt3N3NkMZ8wwfMbKUIqV8W8=
X-Google-Smtp-Source: AGHT+IH5Vuk3yI8JNNLTuPlyb8tEfqYbcmNEYXqaI+D+1WXqokwDXjT4X6Qkm//NaQnNSShWgrOopQ==
X-Received: by 2002:a05:600c:3b83:b0:40e:facf:c05b with SMTP id n3-20020a05600c3b8300b0040efacfc05bmr5969062wms.23.1706909175694;
        Fri, 02 Feb 2024 13:26:15 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWe8738tc8wMiy3xXs1CNNQ5rM3MZmMLoYuaT2zNs+o0GN014Y5tIp62SXPsA7CKl3z8KfbeB8FqDjTJTm/HN+oXxloioKDJpJHlwv943sr8/UKCfyw6nUcbOYOxyArs5LS6GHOcmpZd73rZKKY15wpqseVswbMmEkgMRJqpx0Bj8KB9R/XufW+3kIOo7dt/jNsRSxBUrKV7JPVQugW0OeQ8ekn7gvSngZV/LESVdkR1JogStqmAgZO1TthSIIWQlWpr9jg9u4/AvVoiUCCLDXys1EjNQgnrl37wXoOS2NUjsWmjhP0like0fBWSyYzCxOktLEgWWMvWBLBVMBfYLMxUexfhNB6KrWC3ijvNpqEnzmhQgfdjHyeDfj23tlAVp50IvOjuC9HamBJ+EjUEJUxnfD0vOF2a/L9aKjACnbJ6L4VeU8v0GxhMcgM5NVp8ngEizzW16k+jjyHssayxf7OjK7wPYFSmJ9Ytp20qbYO
Received: from [192.168.27.65] (home.beaume.starnux.net. [82.66.176.246])
        by smtp.gmail.com with ESMTPSA id fa18-20020a05600c519200b0040f22171921sm976140wmb.3.2024.02.02.13.26.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Feb 2024 13:26:15 -0800 (PST)
Message-ID: <4992bea2-f22b-4953-8b14-d2810d47fb8a@linaro.org>
Date: Fri, 2 Feb 2024 22:26:12 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH] dt-bindings: visionox-rm69299: Update maintainers
Content-Language: en-US, fr
To: Jessica Zhang <quic_jesszhan@quicinc.com>, Sam Ravnborg
 <sam@ravnborg.org>, David Airlie <airlied@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: quic_abhinavk@quicinc.com, Bjorn Andersson <quic_bjorande@quicinc.com>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240202-rm69299-maintainers-v1-1-423aa40f344f@quicinc.com>
Autocrypt: addr=neil.armstrong@linaro.org; keydata=
 xsBNBE1ZBs8BCAD78xVLsXPwV/2qQx2FaO/7mhWL0Qodw8UcQJnkrWmgTFRobtTWxuRx8WWP
 GTjuhvbleoQ5Cxjr+v+1ARGCH46MxFP5DwauzPekwJUD5QKZlaw/bURTLmS2id5wWi3lqVH4
 BVF2WzvGyyeV1o4RTCYDnZ9VLLylJ9bneEaIs/7cjCEbipGGFlfIML3sfqnIvMAxIMZrvcl9
 qPV2k+KQ7q+aXavU5W+yLNn7QtXUB530Zlk/d2ETgzQ5FLYYnUDAaRl+8JUTjc0CNOTpCeik
 80TZcE6f8M76Xa6yU8VcNko94Ck7iB4vj70q76P/J7kt98hklrr85/3NU3oti3nrIHmHABEB
 AAHNKk5laWwgQXJtc3Ryb25nIDxuZWlsLmFybXN0cm9uZ0BsaW5hcm8ub3JnPsLAkQQTAQoA
 OwIbIwULCQgHAwUVCgkICwUWAgMBAAIeAQIXgBYhBInsPQWERiF0UPIoSBaat7Gkz/iuBQJk
 Q5wSAhkBAAoJEBaat7Gkz/iuyhMIANiD94qDtUTJRfEW6GwXmtKWwl/mvqQtaTtZID2dos04
 YqBbshiJbejgVJjy+HODcNUIKBB3PSLaln4ltdsV73SBcwUNdzebfKspAQunCM22Mn6FBIxQ
 GizsMLcP/0FX4en9NaKGfK6ZdKK6kN1GR9YffMJd2P08EO8mHowmSRe/ExAODhAs9W7XXExw
 UNCY4pVJyRPpEhv373vvff60bHxc1k/FF9WaPscMt7hlkbFLUs85kHtQAmr8pV5Hy9ezsSRa
 GzJmiVclkPc2BY592IGBXRDQ38urXeM4nfhhvqA50b/nAEXc6FzqgXqDkEIwR66/Gbp0t3+r
 yQzpKRyQif3OwE0ETVkGzwEIALyKDN/OGURaHBVzwjgYq+ZtifvekdrSNl8TIDH8g1xicBYp
 QTbPn6bbSZbdvfeQPNCcD4/EhXZuhQXMcoJsQQQnO4vwVULmPGgtGf8PVc7dxKOeta+qUh6+
 SRh3vIcAUFHDT3f/Zdspz+e2E0hPV2hiSvICLk11qO6cyJE13zeNFoeY3ggrKY+IzbFomIZY
 4yG6xI99NIPEVE9lNBXBKIlewIyVlkOaYvJWSV+p5gdJXOvScNN1epm5YHmf9aE2ZjnqZGoM
 Mtsyw18YoX9BqMFInxqYQQ3j/HpVgTSvmo5ea5qQDDUaCsaTf8UeDcwYOtgI8iL4oHcsGtUX
 oUk33HEAEQEAAcLAXwQYAQIACQUCTVkGzwIbDAAKCRAWmrexpM/4rrXiB/sGbkQ6itMrAIfn
 M7IbRuiSZS1unlySUVYu3SD6YBYnNi3G5EpbwfBNuT3H8//rVvtOFK4OD8cRYkxXRQmTvqa3
 3eDIHu/zr1HMKErm+2SD6PO9umRef8V82o2oaCLvf4WeIssFjwB0b6a12opuRP7yo3E3gTCS
 KmbUuLv1CtxKQF+fUV1cVaTPMyT25Od+RC1K+iOR0F54oUJvJeq7fUzbn/KdlhA8XPGzwGRy
 4zcsPWvwnXgfe5tk680fEKZVwOZKIEuJC3v+/yZpQzDvGYJvbyix0lHnrCzq43WefRHI5XTT
 QbM0WUIBIcGmq38+OgUsMYu4NzLu7uZFAcmp6h8g
Organization: Linaro Developer Services
In-Reply-To: <20240202-rm69299-maintainers-v1-1-423aa40f344f@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 02/02/2024 19:03, Jessica Zhang wrote:
> The current maintainer (Harigovindan P) is no longer reachable through
> the listed email. Update maintainers list to be Abhinav and I.
> 
> Signed-off-by: Jessica Zhang <quic_jesszhan@quicinc.com>
> ---
>   Documentation/devicetree/bindings/display/panel/visionox,rm69299.yaml | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/display/panel/visionox,rm69299.yaml b/Documentation/devicetree/bindings/display/panel/visionox,rm69299.yaml
> index fa745a6f4456c..7723990675158 100644
> --- a/Documentation/devicetree/bindings/display/panel/visionox,rm69299.yaml
> +++ b/Documentation/devicetree/bindings/display/panel/visionox,rm69299.yaml
> @@ -7,7 +7,8 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
>   title: Visionox model RM69299 Panels
>   
>   maintainers:
> -  - Harigovindan P <harigovi@codeaurora.org>
> +  - Abhinav Kumar <quic_abhinavk@quicinc.com>
> +  - Jessica Zhang <quic_jesszhan@quicinc.com>
>   
>   description: |
>     This binding is for display panels using a Visionox RM692999 panel.
> 
> ---
> base-commit: 51b70ff55ed88edd19b080a524063446bcc34b62
> change-id: 20240202-rm69299-maintainers-7e069f78334f
> 
> Best regards,

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>


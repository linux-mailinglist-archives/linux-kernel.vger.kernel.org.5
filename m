Return-Path: <linux-kernel+bounces-61386-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 07C5A8511B2
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 12:00:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2FE828606B
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 11:00:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60A3E2E632;
	Mon, 12 Feb 2024 11:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kr2729iD"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBA582BAF0
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 11:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707735626; cv=none; b=j4ZYs3jXncw2oaGZp3jtHEp963Si/NctflrxmTkHwZBwGkVgvvGro4N8OflxF4GyH3bQ1TGOSTfp7WoPjEB6105IuFJaVm9TCmfBPi0STMQ3higg+xUhA3uJ5GvONDt7hUTuKau7XXW3ezdfhmf6QAxIl1UvpEvnd9QvuFYPZjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707735626; c=relaxed/simple;
	bh=LWccpRX2+gLf6CTggYt7DhfiAYn55RZ5XYtMD8dHrXw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ULIwuUXJ6oSAIYKlwflGySIBGLhrE8qvNcGTFny2mwmha4sotpuF2UyAE8VIPBmZn+5CFtFASwwSUiGV1qXeH0UHE18FvrSbo02y7AwuyaJGy89ahu7enCDfGbyOO5sNCCNKrXTfSE3/8w2gSrOxCsrqui8hrhNxhnVMKMxksPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kr2729iD; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-51167e470f7so3647982e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 03:00:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707735623; x=1708340423; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=q8i7o5P1PuIVri7pPB4Y9ULBsVBvdNHUjDSmDfokZeY=;
        b=kr2729iDCB9O0qbBjojXLZz6ulQpWsAw/2Vau9tSczASpY8lLgovRbMBz7q4dUUFzy
         vL9scfSFbxi97f1gJEAXVAfn5JAzhY3VO7mPKmD1OdbGprkhglWw+Cg6egGKZ0OSmQVy
         mV6h5kQIcX5lsYf9vzhJ5ecO8W5CwWTDWyQSQuVe8Y5sTYBZ1sBZU9lphzqShLO9lZAN
         TiIvnQ4g/Er5OeQg0EwEpXVTTdREO9rBJJVRBHAi/s3LEbaFfpZ9Lm+AvR821CQK8jAa
         +mm+j6UxhASxTsLcGUMWrFLiMdOdjs+XwJXQUan9Qnwd4QPvCLPOLQQBJXmglEYuVH9H
         Y40Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707735623; x=1708340423;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q8i7o5P1PuIVri7pPB4Y9ULBsVBvdNHUjDSmDfokZeY=;
        b=pHOe/ualmK+LusEjWnc1OT9pB1wZ75QgTeUMlJr47vlzSapQPTp3HcD4YUWrfNx1OM
         oXot0QkTfYQ7wY/nvmWPQMgIljuDkHo6RrM2uAS+7ceXtBcBZNKEmcio3N8OIm5iIMDI
         aav63r+TRNeYfoziLci/mTHdt41gCCrYxpH6w8PF+6FxikaVQjBKyyeWp/vATSi0dZf3
         y+rX2iFHypBYcjsPsG06UTxKWWo/Wl8ibCDFAc9ezfAL3iob38W/TrpbUpckutLK02CY
         7ai92MRzkmryER55AvyOUj4U1S+vbCedlxyYN4fZ9p+rsi5uEZgHYkhLErlfECTTLcr9
         nB5A==
X-Forwarded-Encrypted: i=1; AJvYcCWHfTmqUt0kvbAm5SQkYGv5w1N5z2d9G2K15lmypllghg41hYjWS0JCrge9w5+TYt9oDyKdCqyOQCxcZUi4r18CxPxRf2eFMum4ZG8t
X-Gm-Message-State: AOJu0YySk5wnWidFSgOL+Y2oyG7HQIKfIF4qp791ME6Pz61u8UC6rx5/
	QYdU0QCFjsquW9a3974pGlYHSuJbyQJQVoMgqmVNzk44UXVzYKUBZTElotJJq5I=
X-Google-Smtp-Source: AGHT+IH19aSFbAEMJysF6sd6YLlZYgD6xAdYc7qRPYruPShtxZ3HcVjwtAi1K9T6Nq3GlUVH71n2Kw==
X-Received: by 2002:ac2:457c:0:b0:511:8e27:10fa with SMTP id k28-20020ac2457c000000b005118e2710famr1384070lfm.54.1707735622795;
        Mon, 12 Feb 2024 03:00:22 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXW+o4MXrarcYh53SKrVmEZ/HWlT28LAQqpypqvt1ebP3vPn7aCux7Wa+0bP62yTlSI+pqJ6Yy3cWXpnthZGpVVzNZrAB7CGErbvjzOxO+XY05QchS7m5xEOzcFM8wOUFv21YyMuSxcguJBadvPVM7ZZUd73eycn8WxCabw8wNFcKVeV+xth+ozvA0s173RsASV2IVuxXDt21EPfqlo3ffy0Fz0vqVTw4gm/rQ2u9iED5zp4GVM5w1tPAF/vEENR2BweV5Dg6goeDKrBH/3U8AfeeiAMDY6IlXMy6BTOb2XoYMXt5hEHKKFA3gsRea0plctE4TgBb5EbuJZrT34euiAEb9w+nYXCa09AGGNtA1BsyEhj5tBtp2aGheQUjR3d1oN1arbaWpZtXElDZgNqAR6Qz9SI5KUd2FoaLWrkTfyKHbiy7dhAsEYeljoq5E4arBAnCaWeiJT+goZQ18dcUBQJzS2M6wy
Received: from [192.168.1.20] ([178.197.223.6])
        by smtp.gmail.com with ESMTPSA id t22-20020a1c7716000000b0040fe308ff25sm8218212wmi.24.2024.02.12.03.00.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Feb 2024 03:00:22 -0800 (PST)
Message-ID: <069b82ac-b59c-4665-8a77-6c11a2463faa@linaro.org>
Date: Mon, 12 Feb 2024 12:00:19 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] arm64: dts: qcom: sm8650: Add dma-coherent property
Content-Language: en-US
To: Ling Xu <quic_lxu5@quicinc.com>, andersson@kernel.org,
 konrad.dybcio@linaro.org, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org
Cc: quic_kuiw@quicinc.com, quic_ekangupt@quicinc.com, kernel@quicinc.com,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, "Aiqun Yu (Maria)" <quic_aiquny@quicinc.com>,
 Neil Armstrong <neil.armstrong@linaro.org>
References: <20240125102413.3016-1-quic_lxu5@quicinc.com>
 <20240125102413.3016-3-quic_lxu5@quicinc.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240125102413.3016-3-quic_lxu5@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 25/01/2024 11:24, Ling Xu wrote:
> Add dma-coherent property to fastRPC context bank nodes to pass dma
> sequence test in fastrpc sanity test, ensure that data integrity is
> maintained during DMA operations.
> 
> Signed-off-by: Ling Xu <quic_lxu5@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/sm8650.dtsi | 13 +++++++++++++

This wasn't ever tested:

sm8650-qrd.dtb: remoteproc@32300000: glink-edge:fastrpc:compute-cb@1:
'dma-coherent' does not match any of the regexes: 'pinctrl-[0-9]+'

Ling,
How is this testing-patches-before-sending work in different teams? Do
you have such requirement?


Best regards,
Krzysztof



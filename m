Return-Path: <linux-kernel+bounces-77120-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D8CD86016E
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 19:33:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7FDF21C244B0
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 18:33:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CB9F15B98D;
	Thu, 22 Feb 2024 18:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jL8gx44E"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C487115B98A
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 18:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708625920; cv=none; b=Ocj3dNae2iZAb4gVFVyQE3HjNJvYDr+wfHCcvf5CURXw1vFxcwjZa/MgBqgnBfpUeDMHfIy8Whd5KgjtEMBzMv8Awkru7cohuR4XI2xXs1Em5SgjEYWqujeCoprRKqBK+7bA94hWgm2K5tKnIVcvEqUfwMnZb6gY0OG+eLXmWIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708625920; c=relaxed/simple;
	bh=lKTjjX840ZhP7xXnWdjJ0mssW7wDkPLLNHqkrVKU9Tg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ggjExLrxeST6Q8eEKjdkWwNsu1YB2xnNE0g5uMTDgbXP2mprRYiXPBqZJPQYv2tRYQFj7C4MwYheJZHE+CTan1ydA3Xaje5pujs3IMcbhcfvMT890k+8jXIhgk+ielXfbevOdMsKbR9hYJEOWPcPSF9Hlt92E7keWKJV7XY/xbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jL8gx44E; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a3122b70439so1367466b.3
        for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 10:18:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708625917; x=1709230717; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=d+X7v0o+8TmsinJHgaqYvlkWeXCyoa+AFdDkjxQ30WE=;
        b=jL8gx44ESFVZiHe6uN5EKdc/IQPl7IbMmQ2Qn4CptY3YaWXse3gHvJB/zfttSprQ6x
         q1aE4jM6XdNlewB+103EG32moNpzSEOHTrjoO7YvbUSHtdcgz/zjRQmO4HumdfUlf98n
         OGXzLw5r4NE6ivSelnzkGyaAAR1bTHSQCQGdXSYN86NwHfegfbXn6gF37V1YODw+D4ED
         LK6fntqaf9jEkD0vve/5tLMEu4HnMXU7jgS8NHms3qwq7Hxl7+2dNwyWzmSTS0+8A9rk
         91jQUO2VC6kvhdmNk8ZuBp9vyA4siXaHah2sV7cV9MU7yPKLKQDngHDZjppg6OyNMewr
         PotA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708625917; x=1709230717;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=d+X7v0o+8TmsinJHgaqYvlkWeXCyoa+AFdDkjxQ30WE=;
        b=mCM58QzIqFYILKdwh9kjFEPHIoeoW7HCSk0X+WWGupTUfvNmHT/CiT7itUmOSoORHU
         6RAFuEoVB6ouw456NfJF/BA41zBu2rv6yf4nykeovd0v21yl6L0/JvEbef1uJ5kNwDTj
         95JQYujS9kD+uivJYhQaunRFzuMakqd4A0GY4GO5IRif8eAu5+q0NKQv5MO1Jh6a04PI
         +8Oye/9mM25UYiucErmpDgtkg0xCWshj5hk9cRpJ4Ips2n0+JsUoD9Ra3db2EO7c0QFD
         UUG6fTD4JBDm8f/5wTlaDycfAj9MUbwSWb3wi1BgLPR3W8BHJqJpsne7yVsKBEaqF+1Z
         k0YQ==
X-Forwarded-Encrypted: i=1; AJvYcCXZMHk+pUbC70BBXt6h/QZerP1yFXETTjHBw8OoEkc5UCHU792z05cAvGgGOH8tVRBXE6zBKSVztgkn6n0GvYUQGieHr2uBlGcatyQD
X-Gm-Message-State: AOJu0YwPQsjoyu+/9/++ZfkfglVIT2Y9NwmRbYRugylMWopKlC5S7HaM
	6BJPRTkIcaUQGkM/fokUt6Z+tkzgnKMSPoytApmMyFJjBjS0luR4zd8c1Bdip4g=
X-Google-Smtp-Source: AGHT+IE2lI8oLedvZhwg7H4BUJ9pBUtr/yU8QeGokCefE5VHo+u5PynH2RyUNtTUJcw1nYI9ioAsVQ==
X-Received: by 2002:a17:906:168a:b0:a3e:f04c:5dfa with SMTP id s10-20020a170906168a00b00a3ef04c5dfamr6716898ejd.62.1708625917056;
        Thu, 22 Feb 2024 10:18:37 -0800 (PST)
Received: from [192.168.1.20] ([178.197.222.116])
        by smtp.gmail.com with ESMTPSA id j20-20020a170906411400b00a3efdb625cesm2762457ejk.124.2024.02.22.10.18.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Feb 2024 10:18:36 -0800 (PST)
Message-ID: <367ca75b-26f1-49cb-a74a-1222195716ca@linaro.org>
Date: Thu, 22 Feb 2024 19:18:34 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/8] ARM: dts: hisilicon: add missing compatibles to
 CRG node
Content-Language: en-US
To: Yang Xiwen <forbidden405@outlook.com>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: David Yang <mmyangfl@gmail.com>, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240222-clk-mv200-v3-0-f30795b50318@outlook.com>
 <20240222-clk-mv200-v3-2-f30795b50318@outlook.com>
 <2085057c-0000-4e0d-a633-c84e939313d6@linaro.org>
 <SEZPR06MB6959274FCF19F70B45589F4196562@SEZPR06MB6959.apcprd06.prod.outlook.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <SEZPR06MB6959274FCF19F70B45589F4196562@SEZPR06MB6959.apcprd06.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 22/02/2024 19:13, Yang Xiwen wrote:
> On 2/23/2024 2:08 AM, Krzysztof Kozlowski wrote:
>> On 21/02/2024 17:41, Yang Xiwen via B4 Relay wrote:
>>> From: Yang Xiwen <forbidden405@outlook.com>
>>>
>>> Add "syscon" and "simple-mfd" compatibles to CRG node due to recent
>>> binding changes.
>> Why? You claimed you added them in the bindings because DTS has them. In
>> DTS you claim reason is: binding has them.
>>
>> That's confusing.
> 
> 
> Because the old txt based binding claimed there should not be a "syscon" 
> and "simple-mfd".
> 
> 
> But it exists in hi3798cv200.dtsi. And i think it does no harm to be 
> there. So should i do it in two commits?

hi3798cv200 is not hi3519, is it? You are adding simple-mfd to one SoC
because some other has it? I don't see reason to do that. Er, why?

Best regards,
Krzysztof



Return-Path: <linux-kernel+bounces-72866-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E79685B9C1
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 11:59:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E898A286C55
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 10:59:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E800E65BDE;
	Tue, 20 Feb 2024 10:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kyCCxx/x"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0BC9657CA
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 10:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708426777; cv=none; b=rf/cPFzx645bO8vFVrtxwjv4LgJmBaRaOzqmFFWPKhQWfJQohfg9FMoATDtfcwHbAZYpgl2VTAqiQ1Q86gefPpu1J8z5C1pdk40vsWFBgTqUCi+MWEsuGO7EiYOkWZqh59O/h3fY/NcIO4GOw98Di4GUIq2GEElhJCF211hoS04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708426777; c=relaxed/simple;
	bh=g6dH5OPPvurQW89iZP3iNgRMNXyt8SpUEaAql9TeqdE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HDvlC2CFeGY8UGpjcsxXoNn0AadwEqMKKN2/28wfY7GfUUjftOv9TU5V5odqaxllb3w67ecORx935QG/a63sZUHV8ulUFnNB5Vjx/gJ5MkEK6siUsA4RZldip6uEofplCmwxPcILwCgS+iEhE7ymcADxIRABu1PT7I2sP1T6Xsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kyCCxx/x; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4127109686fso858255e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 02:59:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708426774; x=1709031574; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uF7mgOt/d46QgIPg4uY3jRzW28nws+KnyVyRH9CsNdg=;
        b=kyCCxx/xu5/fkRG0Jm0Xg62ie/7ylq6r/uc6DkobCwtUCxgf36Pvnl20di8FKYnhVk
         OFn2jMONjwWhG5rKrs0caQD5FHR9I7nnDijzjNbWFP5RWBd7hMmdsashehiDX8JzQOCD
         1+P/GzPS6StKd3D5CADCRi2mU8r1ZAdb+6aoYHETcNbFm4oJxpL96iW93xITc3GAvS3l
         4kJiJKy1bdiZycF9Sxad5XVXBaH1Hc/MNeWrG9lMgyYCZJWbsnZKFR6IFgBKu+hQa51L
         XutQZ8iDVeH6BLB2fE//W0/F9pC6JHe6bPCEzJWuVPW8Y4lbUP7bRGeNti9bsvGEVPkF
         WIuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708426774; x=1709031574;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uF7mgOt/d46QgIPg4uY3jRzW28nws+KnyVyRH9CsNdg=;
        b=KtZLnx3Ixguh65ufW4tDbgYyg4AD7G7/Ri/vmc5aBsoL5rELaBP0E1nHgZgzCyKLHR
         j6NmPiHYhHq4SJvbFtqaQkFQNWvv1g1PjDzrme9XHJI2ZYgLCBYp4kpxM4B5tFs+79gO
         YAjTYbR2OhC3hHvnUQC+sJBBfBZDb9DTlMHHj/Eeoyc8UaGoGZA6B0/WEtHvnJduo3Nd
         NvaG+oe2jfoFnUa1c9pD5EmQRVs2ZfadkQljk+KU/Utshz9Y9mWOaR+YT+xD/gkNmlPb
         BUICZl+sv3hAeb84KidvMkUHUB7BEO0lZ4X0LGa6QNDnMD5/Qc+qjoX/+0pyqN1/pZeC
         JdpQ==
X-Forwarded-Encrypted: i=1; AJvYcCUPmXfG3cJnxuMqE8tlqbfds3BIbWHtU/mtx4Z9c0KKg13rwv01YjBbFwtqSoc/dhXKVAhMLvN9xGnjN40emehUR++KkYnYuZra1Qs8
X-Gm-Message-State: AOJu0YzFHh3hU1/Yz7TaKFqUDkpU2lWy4G1/14z6ZcAQbieL0WFRyQK2
	KNQsoJ5iDGymZJ5mfOm3dg8ivaI6adRR+O/RNhOkfyXVMBZE1+ifze7xI+B5g8U=
X-Google-Smtp-Source: AGHT+IHY1+cRHKPB0CuniAq91NZoLHR7SQvLrwb80gvuidEDI3lyX01cORfCDqEnSwFbGme8z8FVBQ==
X-Received: by 2002:a05:600c:470c:b0:412:7058:eaa3 with SMTP id v12-20020a05600c470c00b004127058eaa3mr758048wmo.27.1708426774376;
        Tue, 20 Feb 2024 02:59:34 -0800 (PST)
Received: from [192.168.1.20] ([178.197.222.116])
        by smtp.gmail.com with ESMTPSA id n22-20020a05600c4f9600b00411a6ce0f99sm14439503wmq.24.2024.02.20.02.59.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Feb 2024 02:59:33 -0800 (PST)
Message-ID: <d2dbbbc2-7ce6-4aca-b9ab-590e4131fed1@linaro.org>
Date: Tue, 20 Feb 2024 11:59:32 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v2 3/5] dt-bindings: clock: merge all hisilicon clock
 bindings to hisilicon,clock-reset-generator
Content-Language: en-US
To: Yang Xiwen <forbidden405@outlook.com>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: David Yang <mmyangfl@gmail.com>, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240217-clk-mv200-v2-0-b782e4eb66f7@outlook.com>
 <20240217-clk-mv200-v2-3-b782e4eb66f7@outlook.com>
 <32d0a9c5-6c4b-4d85-bcbe-6192c63ba5fc@linaro.org>
 <SEZPR06MB69598A635C5AB1397348ED3296502@SEZPR06MB6959.apcprd06.prod.outlook.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <SEZPR06MB69598A635C5AB1397348ED3296502@SEZPR06MB6959.apcprd06.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 20/02/2024 11:52, Yang Xiwen wrote:
> On 2/20/2024 6:14 PM, Krzysztof Kozlowski wrote:
>> On 17/02/2024 13:52, Yang Xiwen via B4 Relay wrote:
>>> From: Yang Xiwen <forbidden405@outlook.com>
>>>
>>> We don't need so many separated and duplicated dt-binding files. Merge
>>> them all and convert them to YAML.
>> What was exactly duplicated? You created unspecific, lose binding...
> 
> You can take at the drivers at drivers/clk/hisilicon. All of them use 
> the same sets of APIs to register a few clocks and resets. That's why i 
> think they should be merged.

Drivers don't really matter for bindings. That's not a valid argument.

Creating invalid combinations and lose bindings is not the answer to
duplication of few parts.

Best regards,
Krzysztof



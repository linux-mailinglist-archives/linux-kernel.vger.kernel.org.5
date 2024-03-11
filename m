Return-Path: <linux-kernel+bounces-98686-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BD33877DF9
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 11:18:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B85EF1F22921
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 10:18:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A27B2BB16;
	Mon, 11 Mar 2024 10:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OXtFdGZo"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BF1222F07
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 10:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710152290; cv=none; b=d0Bbl2o/EZctJ/dLVPyrrPGmehAPJtmrMgw+RIpjuMi7xi6ewyBkNlcxIOyl6kgr2f/pBZKIaO2KZ8CXRIkIPskZ+K3CrRQVLyzU5hcpHBsW4zYY2if8rgYMY0RzmbYo1wsJ6MHsFiTxSVKqsNvTASCFbU/+IHtWbIL87HdRi4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710152290; c=relaxed/simple;
	bh=CgLEEXYxdr+/lRqJ2xUbK+mwBgS3fqIC4vqRFb4hrpI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iTgTGr3TixjhCKwYmIcDlk4mBT6E/fNyiuqT+wSF5307q7RS95ULqryITTIc8+X9uxO5OGd0VfD2zE0iKilVX5eJtSzReAI+L9IwuOhmuyx/dWfgxaSiwpwLpFW39Zy6PZkD+KP3TKIy/wL0TWE8B0d3F9oYB2PDmtznj0uEPaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OXtFdGZo; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-51323dfce59so2489246e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 03:18:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710152287; x=1710757087; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AsP/0qz8QlmA4JVNtkQu7AGls/ZfeI7jmrpsFvcLc28=;
        b=OXtFdGZob1rgzbKnnH06lTlWoC1Oxv466F2Kk76U/u4Zjxme80ihvvVoRuqE1jwn+G
         hbq1fbLIV5cu9kpb0qP5QHerNFNNvTGddjE3aybMbywgULTYN9HzuHGHSr1zfke1nYvU
         OOhd07lxuLS+aHanwi0+ZA1qwKEHA1syCA2R/Q+sSSZ26nsD/T44tt9MhgS4Dpc09d/s
         XJZWTvu0Nz4nOB0y2o4pc3lkcStsYGVOEKAtYbS1y6+IzyL2Td5LuHFv56pTKSbUKBYn
         dH2EPbDzpTql+Wlij0yNcCFtwPE3RO56GoXVKEM+/rNxl5u/+xpwNIJu3DLTl0EFPXbh
         WmZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710152287; x=1710757087;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AsP/0qz8QlmA4JVNtkQu7AGls/ZfeI7jmrpsFvcLc28=;
        b=ka3V0DeZi415d0xFfhMrs4JqcRrari0WINQBmr7/SVd/hWKgHHQvMd/fQu4687xkOv
         oi2gv5NeqzxZjGYANwZ6jHb4MQB/wtHgzBSOF2ZI0WKjvr13IZXF8YW0Rw/wXJ1cYyAF
         7oVLYggY5dBZx+doHL3QH4n72qiWbSKdg+RSUpmpHdASCIB1I7RuCp28kmyxl5RSpvPS
         xAN2A9tJ+z4OIqvoqf2Yt+efo+sx66ZRWEDJwFWj2U3TzQNMKAsiUj0UFKBIsAewS2wX
         j0FLi0BjyT/JkbRiGlA9k+g4XOoN7sTM4VyFfGFE0kJS0w8kVNY9e/cNVkduFXVfE8aW
         Is5g==
X-Forwarded-Encrypted: i=1; AJvYcCUDwcW1nYHFJCkCpyz1w41LCRs+hzVNrBPXj6hwWKTTP+/paO172WTsW6Uf1eLRk1cVfVxVK1A/x8yUf7w53ZC2QY1Cg2vyM2wMBIGW
X-Gm-Message-State: AOJu0YyCEvDuyGLLicly9GIDhPXcxQbWKv2B50hJhU2QQG2J7ZD+8Aym
	8NGGNOFwDAD+ZMStvfFL3prYvbOKkqskxO+P6AcKDwYDI5tSuwsR2Lj4syowKQ0=
X-Google-Smtp-Source: AGHT+IEPbwnztzbsrRlV9J9paTgwc4a4ZlvV7sSr+jRNTb6Ycx10ADEmEmgJ63NIgvTmv0iTNLY6cw==
X-Received: by 2002:a19:ae0c:0:b0:512:f679:665b with SMTP id f12-20020a19ae0c000000b00512f679665bmr3752164lfc.42.1710152286635;
        Mon, 11 Mar 2024 03:18:06 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.222.97])
        by smtp.gmail.com with ESMTPSA id i20-20020a05600c355400b004131035d28csm14552679wmq.23.2024.03.11.03.18.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Mar 2024 03:18:06 -0700 (PDT)
Message-ID: <c56407f7-b128-4264-b149-89682cd9500d@linaro.org>
Date: Mon, 11 Mar 2024 11:18:04 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: watchdog: sprd,sp9860-wdt: convert to YAML
Content-Language: en-US
To: Stanislav Jakubek <stano.jakubek@gmail.com>
Cc: baolin.wang7@gmail.com, baolin.wang@linux.alibaba.com,
 conor+dt@kernel.org, devicetree@vger.kernel.org,
 krzysztof.kozlowski+dt@linaro.org, linux-kernel@vger.kernel.org,
 linux-watchdog@vger.kernel.org, linux@roeck-us.net, orsonzhai@gmail.com,
 robh@kernel.org, wim@linux-watchdog.org, zhang.lyra@gmail.com
References: <Ze7GreWtuUtMh6MK@standask-GA-A55M-S2HP>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <Ze7GreWtuUtMh6MK@standask-GA-A55M-S2HP>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/03/2024 09:54, Stanislav Jakubek wrote:
> Hi all,
> 
> I was about to remind people that this patch exists, but apparently it
> already got applied without notice? Seems like it's in linux-next already.

You are not the first one surprised... I think I could count on fingers
of one hand the times I received any notification/confirmation from
watchdog that my patch was applied. That made me waste some time in the
past for unneeded checks and resends.

Best regards,
Krzysztof



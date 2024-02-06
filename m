Return-Path: <linux-kernel+bounces-55492-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 41E3084BD5C
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 19:50:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 738C71C24C39
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 18:50:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FC4220313;
	Tue,  6 Feb 2024 18:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EIjav9pA"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 501F52031D
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 18:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707245120; cv=none; b=los9Njx1rRuzNhT4jzsR5Mvwi0qczYJ1Ky5mBxrxHkp0meWBBkWHh3tt6DKRitDqDto6GfC5Dd8cZZj4qRjdOZPcm8PbFy+hCx8ZGuvFPvyz/uLPjkhYaq/xMFnzBmDTfAD4ZZP99rJlvvJ2Z/Topo47MHSB48fZkAtgEuzEQG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707245120; c=relaxed/simple;
	bh=dHh8Q8pc/dfOD0Q7HynCLUAR8CW2HZcJWWrTYZDglJo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i1hTlkOXNUvC3iKC7kWMXxSYzygy673yoluB4Vw084+0eZo6fCSf9oqwgX9SHXBpAY/nbSKapyXmHqDszax/iLAV0H7MJRDXEDdtl7eUAX3R0pU5yYZsShuGWK12jQ47P9QsSwI/Sa9qGlRxvQ4KgGs/E+8BqWUub/xwecruVOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=EIjav9pA; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a37721e42feso388933166b.2
        for <linux-kernel@vger.kernel.org>; Tue, 06 Feb 2024 10:45:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707245117; x=1707849917; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NWfu7OhWcuPORFzEPyNmzbF1225tQEpqe/wMru4KPm0=;
        b=EIjav9pAywvNuqwNBERYbJRdSbCf2LxLnAXw0lp9DTe2GTt1cMPFQBFn6Y1MjzCDX3
         TYrQqBvL4uQwTHNwhv2broeHwyyzaSjV5kOq4pq23JXVIdOQHfefqfkU8b93QFspOkgZ
         1MN3PfUaEjLXD0TuJpRK+U50ZPrH0fufYOo/x86hsv8PCuUn5UuSPK5hi7BnOjEg1qTN
         eYe8dWHUAyt66CnL7R1Fnf1OXLyDsr39F2BevfxhF2gR7voPlsMOXHjOgh2/xQ8q1gNu
         mK94c/apLwbgB83iPhhKsTI6/05oxzkL647et926BxlAOYEadUXdg0KRQr7s0J2q0Ubv
         FgcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707245117; x=1707849917;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NWfu7OhWcuPORFzEPyNmzbF1225tQEpqe/wMru4KPm0=;
        b=pML+v69mzRmOr5CAgDPVIzag28kxfkZZKqYgV5FNYzmOPO4+JQNzKMP+pl6aU0jv3o
         /xc3LNsl9VO77RZrdj2QrUGdf9vR1B6iRsV3hW2GKU6l4/wL5Z6T7u9xb82BNdYEc9If
         hOaejuM5SiF3IIbq7/Oi6BIO+4+Asn24Qb/27+dnASPHx7u5lZKuqs0vKHOujz/bNsmd
         WH8DyfEpFwHB91Qx+lHvAOqny3Z5nIHHJnYwhD9YSKfgba9+gApPTN6KAvoatZhVEXtt
         sOyS/Q3+8uKoSpH5+gad8Mn7T1Uctesp+kgryprnK8SCoDd0LLLqHloaof/69IXerVmu
         K7CA==
X-Gm-Message-State: AOJu0YxRJLO1nENkKmEreBpnla+qihDvCKfDZ1GvwYu1T1hgLUdFtd71
	BAJLsRH9nvCcxSJ6Iu/aIrodHev9OpNKjez+icyWzzvEMunu2wUvM3lTZEiJTOE=
X-Google-Smtp-Source: AGHT+IF7ayHNGZ4nCzUp50G3ec6udbLpaKeip9rw4QEJW+PWf4OP8WYTkDrqygtdQJNW1Yb2NCrCiQ==
X-Received: by 2002:a17:907:7798:b0:a38:2739:e7d1 with SMTP id ky24-20020a170907779800b00a382739e7d1mr1629312ejc.32.1707245117677;
        Tue, 06 Feb 2024 10:45:17 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCV/vaznrYttBMR5Ral8IOgR+zkfggSyciMGDROSqYwESfhrfgNn6lDXp3PhfvUoccJlxDoT3NL1RYY693QU6RgV9d1AERcj0Kq0a2PzHvBFpkvTDV4scoHD18IqASglz8MVqI0tEt7s1nzVknev1/mh1iPI/S7UVIYJ4Ih88fAgaqI=
Received: from [192.168.192.207] (037008245233.garwolin.vectranet.pl. [37.8.245.233])
        by smtp.gmail.com with ESMTPSA id h16-20020a17090619d000b00a385535a02asm209216ejd.171.2024.02.06.10.45.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Feb 2024 10:45:17 -0800 (PST)
Message-ID: <002d1f81-34f6-4d86-97e9-170c6a66d495@linaro.org>
Date: Tue, 6 Feb 2024 19:45:16 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: deconfig: enable Goodix Berlin SPI touchscreen
 driver as module
Content-Language: en-US
To: Neil Armstrong <neil.armstrong@linaro.org>,
 Bjorn Andersson <andersson@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org
References: <20240203-topic-sm8x50-upstream-goodix-spi-defconfig-v1-1-b69ed85ddd05@linaro.org>
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <20240203-topic-sm8x50-upstream-goodix-spi-defconfig-v1-1-b69ed85ddd05@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3.02.2024 21:20, Neil Armstrong wrote:
> enable Goodix Berlin SPI driver as module since used on the
> Qualcomm SM8550 QRD and SM8650 QRD platforms.
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---

Acked-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad


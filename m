Return-Path: <linux-kernel+bounces-132521-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9D7689962E
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 09:05:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 12BE51C222C6
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 07:05:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1139628E0B;
	Fri,  5 Apr 2024 07:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="li5+J0dD"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94D3A2C68B
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 07:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712300721; cv=none; b=b3APP2Wx5kDflnV0jXERMdWTzpJQ0CkhNw/TWrA8M2ZBvm1KxZAhzVWueMwrt28P8PSq81xCqEBDmwkNPVHsBv4A3s6C9vh9MlD1V79VpaLnaeMo3QUGWWFXlijVhzaQIx4pKzFMDcv+6ZkizjtqbVIP8VZT9OgGH5LFHrk9mJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712300721; c=relaxed/simple;
	bh=5GDYqlGoWHpmLkW1tshRpHFxtVkhZrBxb5Frs0Hrm2Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mMK5o+X9z1nyN4K2PW1LkZjXXMXDRRtsnwGcGmCbT/X5re2mnw2NVUP64YyxPLMuV557h5AwcMWDvWou/yiXcukG6cW4Vxg7fLkpzRBztJai5+2ZEKupmstbB//F2ihW2YmDxxIS5EU7qAww39gCrNKBODDfZmMcZFHrvjuhGPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=li5+J0dD; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-56e1e6e1d01so1946870a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 Apr 2024 00:05:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712300718; x=1712905518; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=zlT9j6FEHrfO0qYQCKbAHEC443rbPgXxIj6u+PXChGE=;
        b=li5+J0dDr6y/y6RB8Srfee3Tzcnn2RbYeGxEiPlDfqvmcFvsFZeW/ESntlBMCu8wNO
         ZYroAaxv/ACILzaZOQ6r51aLwcznW7SyOEglUgJNXpxdju68jP4mafeENdiD2OlTIcPb
         gg2PiHpVML/Z1uSN3bvUXkVSXlqW4ymFOrsi7QZpBQewrUxB3LXvKrIEEGuXWtPPgHc1
         1KTNPt5HJjMaS+Lpo3wkwvme356T1lY+8VrMlwlowIKp/d4yjc0Vbln9hgrcUoKZWEX2
         qC+NlDTQGnak/js/sjnYBKQPxrI5DRx9g+h4QanjY6gYozjwnnybSRbgE8L9LeAgEfXC
         IJDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712300718; x=1712905518;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zlT9j6FEHrfO0qYQCKbAHEC443rbPgXxIj6u+PXChGE=;
        b=uttZi3JnpkbJJrWLB+8/oc0U2zZI+8EYIbJVlasejtgXsrB0nxjZhvH9yk3ZIwW5Jq
         o/feJEgy4X/kieToocKxkm5q75QcC5dzYAfMna0OUYah7TqxQEGZtB/jE9bTzb8Tz4Z8
         BEKR5Bi7bNROxuOde0m+mSj24B/JZfgpI2jjoR0rOxkUst0X3FdO8zwEuZ5scUopbhiE
         PvM+/tTvBrzP1knh3mFkPSsQ9y7lnJQmuNpEY4t7KnRM58njd3+2g1CPF9sh+8abVGOx
         mxWWGqKds4yBKZB6eHWe8O/Ery22xco9ZNpaZaP7JoWf7GUJy3lw6wt0j/J0Om5Z9U0K
         P3NA==
X-Forwarded-Encrypted: i=1; AJvYcCXXPb+z/sm3ZMR4Yltp0tzfLlrbzqm2UBwx9YMhvh3pLnctXWykPeSk2DitRn0JXg9DfAybiiEwpzud56igOxqYPP44fzhqeFpUhrnF
X-Gm-Message-State: AOJu0YwqDDjk2CfP9mU1FYl1UyfuHdirZJwF2Nj/ntFfeRzbNmxQMojS
	AQwA2CoHkrhmr0ieOlR0/LVcjEngtPYiXSzJWMvO1i13f7qy/CV9/yvSUqnWocM=
X-Google-Smtp-Source: AGHT+IGY/2ABsPxXHsQkGARiD85CrwiaVpJ9u1pOBmUsyl3NH4jYOelTVryfYIcaWJh6YUy+aOP+wQ==
X-Received: by 2002:a50:d494:0:b0:56b:defb:3b59 with SMTP id s20-20020a50d494000000b0056bdefb3b59mr346159edi.19.1712300717977;
        Fri, 05 Apr 2024 00:05:17 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id f21-20020a056402195500b0056c0a668316sm492291edz.3.2024.04.05.00.05.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Apr 2024 00:05:17 -0700 (PDT)
Message-ID: <84bf0db5-856a-401b-8225-fd62f381beb6@linaro.org>
Date: Fri, 5 Apr 2024 09:05:15 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] arm64: dts: add description for solidrun cn9130
 som and clearfog boards
To: Josua Mayer <josua@solid-run.com>, Andrew Lunn <andrew@lunn.ch>,
 Gregory Clement <gregory.clement@bootlin.com>,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Rob Herring <robh@kernel.org>
Cc: Yazan Shhady <yazan.shhady@solid-run.com>,
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240404-cn9130-som-v2-0-3af2229c7d2d@solid-run.com>
 <20240404-cn9130-som-v2-3-3af2229c7d2d@solid-run.com>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240404-cn9130-som-v2-3-3af2229c7d2d@solid-run.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 04/04/2024 17:35, Josua Mayer wrote:
> Add description for the SolidRun CN9130 SoM, and Clearfog Base / Pro
> reference boards.
> 
> The SoM has been designed as a pin-compatible replacement for the older
> Armada 388 based SoM. Therefore it supports the same boards and a
> similar feature set.
> 
> Most notable upgrades:
> - 4x Cortex-A72
> - 10Gbps SFP
> - Both eMMC and SD supported at the same time
> 
> The developer first supporting this product at SolidRun decided to use
> different filenames for the DTBs: Armada 388 uses the full
> "clearfog" string while cn9130 uses the abbreviation "cf".
> This name is already hard-coded in pre-installed vendor u-boot and can
> not be changed easily.
> 
> NOTICE IN CASE ANYBODY WANTS TO SELF-UPGRADE:
> CN9130 SoM has a different footprint from Armada 388 SoM.
> Components on the carrier board below the SoM may collide causing
> damage, such as on Clearfog Base.
> 
> Signed-off-by: Josua Mayer <josua@solid-run.com>
> ---

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof



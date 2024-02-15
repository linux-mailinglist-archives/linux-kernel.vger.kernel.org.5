Return-Path: <linux-kernel+bounces-66416-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 34238855C6C
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 09:25:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 831241F232B2
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 08:25:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4338D134AF;
	Thu, 15 Feb 2024 08:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XzyHLDub"
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB4FB19A
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 08:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707985505; cv=none; b=CoCPjmJzEPXufprG0J6R5ns3CdbCHSAh/LTT9u2q0kTOySHTo+2LqOaRxr9ZfOwH2clVbrdWJxIfQBpoQyT9DUjIFb/H/pkHqyOTErj/gOxc/qczrqNMc6s7lnNXPE8O9MPF1IpXan44dvwlc5+bzd7wNw38EFRBOOkJ0XdbViM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707985505; c=relaxed/simple;
	bh=OxC8nbS93w6KQk0DI5EA44QT1rGCMjYm36P6qBiZdss=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Sy025B8cYOMQrtL5gucq4elb1VmSriUgbDNK12PzQkScIZL1eoe5Z+F+SjK3Ot65w6yQQjFK2PFUmngMKeR4xABH0yyLRSr1BGR2rrFxq6hVfHWE3gRyD3FT42BxnK1JmY41deU0BGBz8p77xW+2IXkdpbSgIliDiw3nLAYVwwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XzyHLDub; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2d0aabed735so7429221fa.0
        for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 00:25:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707985502; x=1708590302; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ntw3z7pJMwuhA+IHFxXM8UnffSSkVtxTI5eJwIDL+0s=;
        b=XzyHLDubj5KSDWGqVhq+gQt+ykfoPsKtHz3pnXpWYamYzeHEoBDkHKqMo/i8F7n+5g
         UHxrIcr7xy3R8ukfRdApDyQ9wjGyqewDbOobGbHpduOIFazoL6nmSLddLFiRV6jnwzz5
         s9mV1pESD0Gh7el4WltTqdoXhzK6EJSiN1ZErbt5+hGBR4Kyvmd8suWygZfV2NUirLq7
         UkG4MxsmEWzW+GnJ7PuOyuGuQtT/3Mj/k3PjpDtvq5VWuLDKQiCAqjR2KpRwYuTFvzCL
         tClt+1TnYTwhkZrbs1ULVHM3f05hJkILJDybxJ+RdeqCV3iOuv/p0M+GzCiX1sYKAIzj
         trxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707985502; x=1708590302;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ntw3z7pJMwuhA+IHFxXM8UnffSSkVtxTI5eJwIDL+0s=;
        b=woImOyDZPweA+ixWipawswQkxp44Asd3Lg2HBeN0XZsNJ8PmDw1YRlWJUG25SONUkQ
         GaitwVi2Z63feRjUH3J73VY80Eoa1HaJKbNyKUbomM1tbXTSVQ6qIcMRE1LMfHOH9mMu
         EA2y5klQSZaiFAk3TSkNJBmIw3x+x7VqXy27pY8zeBPhr1fBBGJt92pFJQfEZegv/YLA
         N8aj2Z41frkbn6nVA2le1dvWE6/97qh2usYi5stB2a8Jh/qgVYCIVdyfifyofJC8yhbr
         Vmw/+edFZq6vSlZWiC8TurujTNMDhY/AAv6jAmmpDUT+l76GCflo+sk9X+ko3XcbjeFT
         l/MQ==
X-Forwarded-Encrypted: i=1; AJvYcCXTVSI/CNNMc4GJ4aVsGnFdUX068w7czyxd6afasQNf/LDp0P5yh8eCzEZTIHaZ8obNrHIvYw0DNNMsbpgOcvWovSfQbZ00k08QBDYY
X-Gm-Message-State: AOJu0YzwZgnIhgXInXYdyzFMLGic8B1qdbWqvJhcolaS/kv1YUY2DsoC
	eCy6JCeKtzYpw79NJFIgUe0wtOoGuHTPmH/OCb4+jn0c0PoeZNU3rrnZ2iWpLOY=
X-Google-Smtp-Source: AGHT+IF2aqtWVjobeWJ5rEv5s8eK4ESA+WWY5BYeEFIVPGkmPJvk/q48jhqnjC4iZhEmhzEHbnIAjw==
X-Received: by 2002:a2e:7017:0:b0:2d0:c176:ebcc with SMTP id l23-20020a2e7017000000b002d0c176ebccmr812362ljc.18.1707985501903;
        Thu, 15 Feb 2024 00:25:01 -0800 (PST)
Received: from [192.168.0.22] ([78.10.207.130])
        by smtp.gmail.com with ESMTPSA id f23-20020a2e9517000000b002d0f3c58e60sm177617ljh.117.2024.02.15.00.25.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Feb 2024 00:25:01 -0800 (PST)
Message-ID: <46645341-1484-42d8-8540-580b586e2315@linaro.org>
Date: Thu, 15 Feb 2024 09:25:00 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] dt-bindings: cpufreq: Add nvmem-cells for chip
 information
Content-Language: en-US
To: Viresh Kumar <viresh.kumar@linaro.org>,
 Markus Schneider-Pargmann <msp@baylibre.com>,
 Rob Herring <robh+dt@kernel.org>
Cc: Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
 Stephen Boyd <sboyd@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Vignesh Raghavendra <vigneshr@ti.com>,
 Tero Kristo <kristo@kernel.org>, "Rafael J . Wysocki" <rafael@kernel.org>,
 Andrew Davis <afd@ti.com>, Dhruva Gole <d-gole@ti.com>,
 linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20240206145721.2418893-1-msp@baylibre.com>
 <20240206145721.2418893-2-msp@baylibre.com>
 <20240215072653.lscrdrmsges3psmc@vireshk-i7>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240215072653.lscrdrmsges3psmc@vireshk-i7>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 15/02/2024 08:26, Viresh Kumar wrote:
> On 06-02-24, 15:57, Markus Schneider-Pargmann wrote:
>> Add nvmem-cells to describe chip information like chipvariant and
>> chipspeed. If nvmem-cells are used, the syscon property is not necessary
>> anymore.
>>
>> Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
>> Acked-by: Andrew Davis <afd@ti.com>
> 
> Rob,
> 
> Can you please review / Ack this one ?

Done now, although it is not aligned with DTS in this patchset, so this
does not look tested...

Best regards,
Krzysztof



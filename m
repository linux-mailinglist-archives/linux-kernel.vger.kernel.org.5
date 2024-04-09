Return-Path: <linux-kernel+bounces-136831-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AC4BE89D8C1
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 14:03:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4BEBD1F21897
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 12:03:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FF3112A160;
	Tue,  9 Apr 2024 12:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UF7CxQlp"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD74F129E93;
	Tue,  9 Apr 2024 12:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712664154; cv=none; b=izAqqE8zR72pBR8GcoV+ozADZgio+Gz3TZuQD7nZTYmlnzetrS0Alc/qJYKauN6aK5bizP9I2sozLdIMLwzoKHahM8pOD7pWxwqjP4j1fdtm9h8Uc9j/hhNZrkkDuwegvtE1J/nhDaCPn4FX8ztmI7JsTbZYAZBhzMa0mgrm7VI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712664154; c=relaxed/simple;
	bh=vSvmTJBZXXJEgR7mOloXSqA3+8JPuGp6x3/LLxCsGBA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OtDAX1dFUpAk8klrOpfH+h9e6VKOPXxooU4ctRqUtPHcueQ664jcB7yk2OCVSdHtQEljTxn4WOyLrFT982ZXP85bKEEkHqODfkVIYd5435l6yw7WpQT1ZEXDlh05ZDc/LdsKq+BGeLErR/TAkAxRH1zqSi4OMO9SrhxyW5JNL6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UF7CxQlp; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-56c404da0ebso8215170a12.0;
        Tue, 09 Apr 2024 05:02:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712664151; x=1713268951; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AkRKDf5GLr5pj942wy9NJKid+umpjbRA7GynacZfPEQ=;
        b=UF7CxQlpen+fzohtmyluYOFznEXC0udM8O1ZGdLYhMK+so/LuvMSo6ix5a4ZZRrVZw
         8VzFbKfYQH/SbYQc2l3GZBWOdkW7W35TA/T7FPE8ZIdCQASV12HZ4pqG6BygoKKNW3gC
         8aQmKQg6rsC0oUuxBloP5bMBga3jcNZkv7sxlEI5uuCpk7p+wUmt6cJZCsIyD+bJvZI0
         w/fQA7I/tq3OZfebOSOSGxTr7VyBAltEgxFFG+3/4bVDyelprbcmku5Z5MweWbeWmNF0
         +XV1j1KAVvA53Cz5iZ7xTmgMgFvZRPiioItXao9UIryBvpdBZ6+OPQOue8rtJYXN49al
         ZJJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712664151; x=1713268951;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AkRKDf5GLr5pj942wy9NJKid+umpjbRA7GynacZfPEQ=;
        b=dRMD/fEVWx2c+5ODsX9n2OV0xOcTVmOl59YjA3dJ7cOhOg2lqpOOz2aQhLIP9czVvo
         8F+Hj/VeHXdbEed37EFDbIWtQxwq5k0okrDEE9Qz0nNgtqsuLt+61wyE0na0NgdkjaaY
         pWkl3xRQAKjXRiofKs637UDWH4YJ2x2CHfBhnmM+0mAdiFFPmeaw84YFR72I1u2GRdJV
         5SSpKTP4tBvPfbrIyFCDYCp4BHQPo06Q4dV7iniqt63aMoHoWIs2lOCjgq4AucBd91uc
         UwdmYTUwQz+RyF0UQf+kmb5CO8g3v20ZVrBIImuc7trCNcyO35kP+67IZgaIgI7T1Asd
         7UIg==
X-Forwarded-Encrypted: i=1; AJvYcCWK7dy9sFepMwBTmE7OVGRkQytwNB/pZQMOqs5BcJRx6LQp9yKbGeOFpZa7suopZHSMIgyMQY0uzP2ryy348k8Xo+ysPbH9PT2sU5REmpWcsOKscsHAdr8mgA1TGMAug8bGrKGcGijRAJ/MYREIv48TjgoGHknSal6cfo2D+e48OuG5QQ==
X-Gm-Message-State: AOJu0YwCSVeqEEROS+YsrdUEJy8ubDJjUIQvn7CorJBR+iGcd/Y+RSDq
	pxhmEsO6u6z0gnbXSre3hHsjNGa7//8Of6xIQUtuaRyaYex0Eyp9
X-Google-Smtp-Source: AGHT+IH3wXGsiaRiem9EQMmXVabh3sBI1WiYbDC3AT/ATTb2okPbMfexW2j0doktw3Yi0bClXEyv6Q==
X-Received: by 2002:a17:907:31c9:b0:a51:ddc6:edc1 with SMTP id xf9-20020a17090731c900b00a51ddc6edc1mr3751319ejb.28.1712664150849;
        Tue, 09 Apr 2024 05:02:30 -0700 (PDT)
Received: from [192.168.0.31] (84-115-213-64.cable.dynamic.surfer.at. [84.115.213.64])
        by smtp.gmail.com with ESMTPSA id jg18-20020a170907971200b00a51a60bf400sm5466509ejc.76.2024.04.09.05.02.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Apr 2024 05:02:30 -0700 (PDT)
Message-ID: <a4283479-2c4a-4f8f-b224-999dd12ba009@gmail.com>
Date: Tue, 9 Apr 2024 14:02:28 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/9] rtc: convert multiple bindings into dtschema
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Vladimir Zapolskiy <vz@mleia.com>, Joel Stanley <joel@jms.id.au>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>, linux-rtc@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org,
 linux-stm32@st-md-mailman.stormreply.com
References: <20240408-rtc_dtschema-v1-0-c447542fc362@gmail.com>
 <20240409102658d86fb2bd@mail.local>
Content-Language: en-US, de-AT
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
In-Reply-To: <20240409102658d86fb2bd@mail.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/9/24 12:26, Alexandre Belloni wrote:
> On 08/04/2024 17:53:00+0200, Javier Carrasco wrote:
>> This series converts the following bindings into dtschema, moving them
>> to trivial-rtc whenever possible:
>>
>> - orion-rtc: trival-rtc, referenced in arm arch.
>> - google,goldfish-rtc: trivial-rtc, referenced in mips arch.
>> - lpc32xx-rtc: trival-rtc, referenced in arm arch.
>> - maxim,ds1742: trivial-rtc, not referenced in arch, cheap conversion.
>> - rtc-aspeed: 3 devices to trivial-rtc, all referenced in arm arch.
>> - pxa-rtc: add missing properties and convert. Referenced in arm arch.
>> - st,spear600-rtc: trivial-rtc, referenced in arm arch.
>> - stmp3xxx-rtc: convert, referenced in arm arch.
>> - via,vt8500-rtc: trivial-rtc, referenced in arm arch.
> 
> Probably all the moves to trivial-rtc can be squashed.
> 

Sure, I will squash them for v2.

Best regards,
Javier Carrasco



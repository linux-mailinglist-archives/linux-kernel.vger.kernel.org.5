Return-Path: <linux-kernel+bounces-68410-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 473F88579DE
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 11:05:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0AFC8B2398D
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 10:05:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 448BF1CD24;
	Fri, 16 Feb 2024 10:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UByMmYQ0"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AF031CD1F
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 10:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708077878; cv=none; b=IuBiOZwR0Ij4aE9TXUHirIaobJ8ewgnytKX+i37WiQHZ7h1CGOcccA1P2RrGSyl4HfY5U0pl2O57oiKQaenexkNtWPrp0X3Jd8YA6wVwuccIS+m8dOJ9D5vFzg6K8rT9NuAtAduWK/H2v/F+r0nZYMhUsaMPlSyGAKr/JL2Kkgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708077878; c=relaxed/simple;
	bh=N4g28uYfvOfknjmxYNve4Ds7fEn1w3Rs0RQEYJdvEH8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rD9M4nBHyuV5BsLD8lT47Z7/sHBC98Br7L6Ezgg5nz6RbwoS8zXqKlz24YLgQyOLksYfe581Nqoft2rNM9ssY3dVc6lSbxcJqr3XCzEj2HxCGIcJhd+Oe/NOqw2xQZYacZtdwu58wrxPnlvDHWyaa6b7c+aCoLXFD0iTtkUJpZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UByMmYQ0; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a29c4bbb2f4so240296666b.1
        for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 02:04:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708077873; x=1708682673; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iB7vR/Sqo9AecEruRymtz3dLrzkK70dluG2YX/z3YbU=;
        b=UByMmYQ0No1f0fNvdHJ6GNKAJTOIW2xF5YS1etR0fYzV+5Xd4dNGxY013X5kkfSc4O
         k0d/nvJlkPN8e904NXlZ95ZmjC2phypkKhYAs+nMLRf9hfG0PXsS6zmK/NYfmMk19FGA
         hiTxhvlQJCpqR7a2UX28lrrHfP0poc2xjQuYHKqIrpg5DZyRRAWMLJCGp1tKSlgPcifC
         vC9JAqHVcWJ4mLd/M40XRsCZPGQvaqQZHGIG9VXIccvFpYHFreFEQQ6CuzHEWhxJknn7
         9T91ZpksD+zcdIdzKRcErsmFawqefrwYZbk1UOOYT8WxpmdUkYrWVIP5KfWVhkh7fMmp
         yoKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708077873; x=1708682673;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iB7vR/Sqo9AecEruRymtz3dLrzkK70dluG2YX/z3YbU=;
        b=uoZTM67JW1A/uhsa2Pqrxu9G7HX+AbIPK5id5KtyvpO02qCq0kCZnX/9ef1vCSzHif
         YcxUJeFyo7kPXbHKVCT1lOjS94NJTUu9YxJ4hMsOtRXwk+j984I+ICwqn7SkN2WBbhxb
         mGjerRVV4+8PWXulkrEL0iotRW7qnUSNxgz2SpnjyMPu8vk1PFbUA0XbaniVcdtyfSTK
         XrLLdH/4uGeDmxS2Je2gIsWYFU/NiJoRiR4adol44fIdLwCTaJ8R/x12BQ6/KAq91dfR
         KGFF8NiIbEtRfHIbS46FWYckxHEcYDxGVBu9Urbdwfh9P4bmUyjupFr5+E7/03Qg/2dt
         jrug==
X-Forwarded-Encrypted: i=1; AJvYcCU+Y2KrW36JicYWvq6AEKXGgjNz7eoFPhrwM0TLBF95e420FySVVyYtLapp2I7ZBu4bwZ+kLb4XsxiH4donAd5YGGCjIJKgIDwLVITI
X-Gm-Message-State: AOJu0Yy7em5G8R0kWlkGuySxQs2sKG5KWjp9IqJaOD78lA6gf0o91wxz
	SBkOsry6u2m6B7llgc+h6opAgX9NdYLE9wMI+UQpey105L2ohCq75Ys4DoWg9Rs=
X-Google-Smtp-Source: AGHT+IGXuJ8SEQ1oYprheSCuSG7SeZ0+/YIUhkmqo7ndJzVY6bUbs46PIDaDQOjv6HWG8WKUQNbobg==
X-Received: by 2002:a17:906:5615:b0:a3d:2762:71f7 with SMTP id f21-20020a170906561500b00a3d276271f7mr3200773ejq.66.1708077873540;
        Fri, 16 Feb 2024 02:04:33 -0800 (PST)
Received: from [192.168.0.22] ([78.10.207.130])
        by smtp.gmail.com with ESMTPSA id ty8-20020a170907c70800b00a3d1b3c5f1esm1400467ejc.77.2024.02.16.02.04.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Feb 2024 02:04:33 -0800 (PST)
Message-ID: <83b7b8ca-0a10-4271-8ef9-20094e05f23e@linaro.org>
Date: Fri, 16 Feb 2024 11:04:31 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: (subset) [linux][PATCH v6 3/3] dt-bindings: mfd: atmel,hlcdc:
 Convert to DT schema format
Content-Language: en-US
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Lee Jones <lee@kernel.org>, sam@ravnborg.org, bbrezillon@kernel.org,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, daniel@ffwll.ch, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
 claudiu.beznea@tuxon.dev, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, thierry.reding@gmail.com,
 linux-pwm@vger.kernel.org, Dharma Balasubiramani <dharma.b@microchip.com>,
 hari.prasathge@microchip.com, manikandan.m@microchip.com,
 Conor Dooley <conor.dooley@microchip.com>
References: <20240202001733.91455-1-dharma.b@microchip.com>
 <20240202001733.91455-4-dharma.b@microchip.com>
 <170738899221.920003.15342446791449663430.b4-ty@kernel.org>
 <cedecdb7-fe4a-42ea-9a11-faa82f84b57d@linaro.org>
 <aamdttvdk3jmswvy3rw3debk3ouddkgjbs6xmixroe6kqakjw4@lnd5crcgoeyj>
 <2e96c824-47e8-48bd-9e03-8c7390b02d24@linaro.org>
 <wkqqowh6ivn35d24n5ngdqno77wl7onrkdh43winac7bg7oekf@ykwhxujb4cjq>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <wkqqowh6ivn35d24n5ngdqno77wl7onrkdh43winac7bg7oekf@ykwhxujb4cjq>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 16/02/2024 09:43, Uwe Kleine-König wrote:
>>> I applied the pwm patch now. If Lee wants to pick up this one via his
>>> tree that would be fine for me, too. If that's the case please tell me,
>>> then I'll drop it from my for-next branch again. Feel free to add
>>> my Acked-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de> for patch
>>> #2 then.
>>
>> At least next is happy.
> 
> The pwm binding is in next now (as
> 0fa319a1427f7c8d0af4c255316624f7e6f649a0) but dt_binding_check still
> tells me (among others):
> 
> 	Documentation/devicetree/bindings/mfd/atmel,hlcdc.yaml:
> 	Error in referenced schema matching $id: http://devicetree.org/schemas/display/atmel/atmel,hlcdc-display-controller.yaml
> 
> This is what you meant, right? This goes away as soon as the first patch

Yeah, apparently there was more than one dependency.

> (dt-bindings: display: convert Atmel's HLCDC to DT schema) is applied,
> too. So next isn't completely happy yet.

Sigh...

Best regards,
Krzysztof



Return-Path: <linux-kernel+bounces-143686-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EDE58A3C48
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 12:43:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6FC8E1C20AB4
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 10:43:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFF5A2137F;
	Sat, 13 Apr 2024 10:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ONWJZdz3"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DAE31D688
	for <linux-kernel@vger.kernel.org>; Sat, 13 Apr 2024 10:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713005024; cv=none; b=ls1HEzDo+kgP9nwdC8et24t83/ANDJgoqYK9pOj+AfcI/B0HMR1ycJZgpHsqu47lEtukZj44lz2gE6LlXE5n+fdMx2oOt1BB6X3zC7JkivbsEPzTKFFolCj6F65h+HcarMK9M3QLYBVhnoHJzWMxbGFjH0ch3xrmP5SODmCUUas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713005024; c=relaxed/simple;
	bh=1l41Cdo2BQJ4F4UsaALf1Ueombq8eeBCU8ISjIV4uAo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oMc5AAG8c+RoBORSKDbzY/5XU4wvDIY5vVsupGQs20zj7CdVnbyY193NJPJMd1n28P9Tdwh1oe9BW7KAq4m+Zoo1bOizvGVJeJtfAyRfrox5nVLtVBIgc6arMShqldIXYDPKXI3a0MFRWul9WCbq5BLHUklkwUfJFd+104Cumk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ONWJZdz3; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-516d0c004b1so2237744e87.2
        for <linux-kernel@vger.kernel.org>; Sat, 13 Apr 2024 03:43:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713005020; x=1713609820; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=JLor0KE/dK61W7fnhr/rCnlASwbBvCTGAkHx7fm/a8Y=;
        b=ONWJZdz3ZWS9s/VzzCKunCgx76ivYdqCEvQoicZcaI2VDxKfA8msoUrgk8C3uWrhL4
         qwHoRYC5Lz59hOgU7iizRak4zBbQOLHvAkK+Ewu5L8CWZQJWQM4ne0mPKsBKsHGb2umc
         wF2uOSNygSWPWOGEUkWuS89jKhUMTcmdw70TO8rsXSWH3STlgbwJXK+VeJ8b0zfQfyj+
         yLLIAaNN6KgLGZzPR7QWa86xMuswgCsvxAKZAlUtNyxeXu9OS8NvMpfY/XyoZa5CoO7H
         FcFrVHxL7FKg7nZFdkRu+NUlp36JVfPL1yUj9uUUTJ+VLc0Xaj2VOHbz+0ctzmq9cdNK
         xq1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713005020; x=1713609820;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JLor0KE/dK61W7fnhr/rCnlASwbBvCTGAkHx7fm/a8Y=;
        b=iYCVYYZ8GnCdszumzL/vVy1zkzxz1LO4w82lnRzT8q+Fh3euRPWTMP1UfwWL1NThk4
         2oKiaOI5w8HrQkPfl1XrxCELs85ClDfy6gcxk15hkvdIe8iXF6Z7BmVD/jKeiNnob185
         uOXC0Rhz0pzsgCvNnNZO/SoTAt/f3ba9u59OWFNhgMd/NGJwiKH07OAusIOpWYr2a64X
         uXzJeIzvX4zqe+uDNWH2j14zJ4/ymCES001EduE3KCLUz9S7Q50JgNbqa0c6mLM+iClB
         taaamou4iLUQDNYBk0+RCBKLl1lyV9o1iwCMnkpfz6weSlGSaqIcplMCP2EgmB7PbF6O
         hDDg==
X-Forwarded-Encrypted: i=1; AJvYcCWZl/DTHlap9qBZRQHhpE8T+RXRo7b+m5ZExQlVK/eVLPbFyywkejQOrp6kEdM1jeeQEdViPTFyRcZ+NoAugS3qgPA23j7aQEcLfuLv
X-Gm-Message-State: AOJu0Yz3rJRIwW2UpmeNgK7ai7gmquKG14nk8xNXkM4KdH+FSn6M/ULk
	A8PSYi8oJWl/KbXZLYZjxa7dvS3Ivc+Gp1nODRmzN6Ofaf/k9Jc2R6abfsg8kto=
X-Google-Smtp-Source: AGHT+IEYjb2appB1aU3tNbqMdmp5wRsIVIfSgc+foH2WzCMZKqPBpqHwn9qirBDOQulZkne4M+wtCg==
X-Received: by 2002:ac2:5119:0:b0:516:afb5:6a71 with SMTP id q25-20020ac25119000000b00516afb56a71mr3239210lfb.67.1713005020328;
        Sat, 13 Apr 2024 03:43:40 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id a11-20020a05600c348b00b0041833ab5798sm415323wmq.42.2024.04.13.03.43.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 13 Apr 2024 03:43:39 -0700 (PDT)
Message-ID: <889ca65c-c9c7-4658-9c34-5d89774218cc@linaro.org>
Date: Sat, 13 Apr 2024 12:43:38 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] dt-bindings: tpm: Add st,st33ktpm2xi2c to TCG TIS
 binding
To: Lukas Wunner <lukas@wunner.de>
Cc: "M. Haener" <michael.haener@siemens.com>,
 linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
 Peter Huewe <peterhuewe@gmx.de>, Jarkko Sakkinen <jarkko@kernel.org>,
 Jason Gunthorpe <jgg@ziepe.ca>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Alexander Sverdlin <alexander.sverdlin@siemens.com>
References: <20240413071621.12509-1-michael.haener@siemens.com>
 <20240413071621.12509-3-michael.haener@siemens.com>
 <8c13a349-a721-44d3-9e23-2e01f4c2ca4d@linaro.org>
 <Zhpb2URMxuoilKAZ@wunner.de>
 <3d08cf54-f58f-446f-977e-21ba65986924@linaro.org>
 <ZhpfwaIUc0HpfZP1@wunner.de>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <ZhpfwaIUc0HpfZP1@wunner.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 13/04/2024 12:34, Lukas Wunner wrote:
> On Sat, Apr 13, 2024 at 12:23:47PM +0200, Krzysztof Kozlowski wrote:
>> On 13/04/2024 12:18, Lukas Wunner wrote:
>>> On Sat, Apr 13, 2024 at 10:10:49AM +0200, Krzysztof Kozlowski wrote:
>>>> I got only one patch, but if these are compatible, why do you need
>>>> second patch? Plus binding come before users.
>>>
>>> Right, the order of the patches needs to be reversed it seems.
>>
>> What is the second patch? Device is or is not compatible?
> 
> The other patch just adds an entry to of_tis_i2c_match[] in the driver,
> pretty unspectacular:
> 
> https://lore.kernel.org/all/20240413071621.12509-2-michael.haener@siemens.com/
> 

Then why is it needed?

To re-iterate:
"Device is or is not compatible?"

Decide, one of the two patches is wrong.

Best regards,
Krzysztof



Return-Path: <linux-kernel+bounces-143675-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 659ED8A3C38
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 12:24:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15898282F39
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 10:23:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3AF03D556;
	Sat, 13 Apr 2024 10:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vXiBDsx3"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63543381B1
	for <linux-kernel@vger.kernel.org>; Sat, 13 Apr 2024 10:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713003833; cv=none; b=a8NHAQXIkLF8V2Nkj63rXb6qWXVpaCVGhhQQFZ0cMncAMPGQojt6uFWoUupSiAOAR8XeoVKX3P44toG6wUGBqZ86rK02ulDyGawfZiTDJfGBZZxW8sCYTE7ZF2HtHqvJ+OGe27g7Rt6XrIUDkUaJ16GUdN018G9kzyQK5t0DPcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713003833; c=relaxed/simple;
	bh=k5zyZfhYtfNvSuxbELHZzcvrFsMbypvZgHyRD9jk0Ug=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gYZ6pNaoeMX6fpYm1Nx6bDIn0UrkeKFpFlsag394JRTtHC6+tqvWS+K7bAxih8vtbEjPH6JyETuvAcc1gJoLl4jgMU+URJcE3vzbHrXta8lhZi69afS0zuiYIWr/ziEXrrLSDULXzghtErDcphI7RgxCyVPjrimtZG96gN9Gs8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vXiBDsx3; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-417e327773cso12328535e9.1
        for <linux-kernel@vger.kernel.org>; Sat, 13 Apr 2024 03:23:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713003830; x=1713608630; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=PjfN/F1LHae6ZY2eA/wyPK9x2rm3pwkiPSCXj9C6JO8=;
        b=vXiBDsx3EGsP0GXBxKRXUZVDrAAy8AFzT/Wf+UC9bA72ipBAEMq/CFxPeieynRer3o
         58gze2gYjRAQyigTAJ4sawad2n7d3juN6nWtYrBGZL76VjW80jYds1OMJtV13QS0GbSz
         poKIxBW/AtG3tucfBMMgfMnFQZmgQCFNtaTHh1bC1XMRKru5SHt4YvlGbu3dLZ3g4ZcN
         UaBbtz4bdisNDLUTNJCWic4eo9qgUeF5xwnstsncplHkqZamH0ptJZFqLCgcpqU6O7rh
         8hmS8CyZJZOS0UxFrPJ5aB1HuIpfypfPYAxlEnj7dbfSl8ZJlAUNHMI9Q7fvXHki3ZHM
         0Pxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713003830; x=1713608630;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PjfN/F1LHae6ZY2eA/wyPK9x2rm3pwkiPSCXj9C6JO8=;
        b=o61DhC29dDENoSDkycJStA6XQMt6Xwdf26fjNT8lx6VNItowGLn9rws6WgN6pKBxTl
         plTezJPELQ6x49Gv8nH4M/3W9xe5izdlXveYMxXcelUmvmwKX9FmosoIu7W6kUCITfJi
         5qqXxGVSK0aOqHUKpSoz51pxelWW3Rd1k+69DQI3VPnpa2yZNQpmg192A56rwYmzVVVY
         dE9OgNmXk9urFE+vYfKnf+XKWx9t2wyG66NYy98cQXhYenPCVMENyOqOiccKkvMqImlB
         g9PTDfKN/6+kIp2P2TvmNkw+Bou24WLUHL7wZWnKbGE5cOfzwPjJwrQ3l2F361z49IZw
         sQGQ==
X-Forwarded-Encrypted: i=1; AJvYcCVDmL2qKbWqNLILp9HPLbYkcPU15huaMq/4f/j25nKwrIKP1Nw/Nf2TrrdFAQGuS5DHZViRpuy+GuwaOD2v5GafBfNGKmR3yKGvvjFL
X-Gm-Message-State: AOJu0YxFHyNFwBPQ9zOXfJF9pjK+fJktjc9uQGKlgz94BhUSjbTfneB9
	Bi2o6x03MU1dbm4+f99KjysEdGENBbZV206Fq7FR/k4Xo0hb5l5nJCXC5qC1k/M=
X-Google-Smtp-Source: AGHT+IGJwoHEpPLEpeipk9fiL8xEZuOZP5+6B51F4+UHQqbNcxpMDb+hnFz1Xa4wxUzp/YLQie0XTQ==
X-Received: by 2002:a05:6000:2c5:b0:343:cee1:cbc1 with SMTP id o5-20020a05600002c500b00343cee1cbc1mr8966338wry.14.1713003829602;
        Sat, 13 Apr 2024 03:23:49 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id v17-20020a05600c471100b00417ee784fcasm6112833wmo.45.2024.04.13.03.23.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 13 Apr 2024 03:23:49 -0700 (PDT)
Message-ID: <3d08cf54-f58f-446f-977e-21ba65986924@linaro.org>
Date: Sat, 13 Apr 2024 12:23:47 +0200
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
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <Zhpb2URMxuoilKAZ@wunner.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 13/04/2024 12:18, Lukas Wunner wrote:
> On Sat, Apr 13, 2024 at 10:10:49AM +0200, Krzysztof Kozlowski wrote:
>> Please use subject prefixes matching the subsystem. You can get them for
>> example with `git log --oneline -- DIRECTORY_OR_FILE` on the directory
>> your patch is touching.
> 
> To be fair, "dt-bindings: tpm: " is actually the only prefix used
> so far for the file that's touched here:
> 
> $ git log --oneline Documentation/devicetree/bindings/tpm/tcg,tpm-tis-i2c.yaml 
> 26c9d15 dt-bindings: tpm: Consolidate TCG TIS bindings

Command should be run on the directory, but anyway you are right. So
it's fine.

> 
> Personally I don't think we need to differentiate between spi/i2c/mmio
> bindings in the prefix, so the prefix used by Michael seems fine.
> 
> 
>> A nit, subject: drop second/last, redundant "binding". The "dt-bindings"
>> prefix is already stating that these are bindings.
>> See also:
>> https://elixir.bootlin.com/linux/v6.7-rc8/source/Documentation/devicetree/bindings/submitting-patches.rst#L18
> 
> Right, so maybe just:
> 
> dt-bindings: tpm: Add st,st33ktpm2xi2c
> 
> ?


> 
> 
>> I got only one patch, but if these are compatible, why do you need
>> second patch? Plus binding come before users.
> 
> Right, the order of the patches needs to be reversed it seems.

What is the second patch? Device is or is not compatible?

Best regards,
Krzysztof



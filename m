Return-Path: <linux-kernel+bounces-108681-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AB31B880E5A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 10:12:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A1A51F23122
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 09:12:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E389C3A1C9;
	Wed, 20 Mar 2024 09:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="foBBNRpD"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AFCE39870
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 09:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710925932; cv=none; b=H0knpOQl994UT50IWE3+gCwNptthzfy5ZQmcTEe8KChl8iUU2O1F0+Qmhgwwo5Bycu0Zi8JOwCNCh6naN0TQoxnRxlXL0aTs9rJgKKziyO0w0U1exhRniQXBsA6R5mpHHg9H4HRcDlpcGvsoKiS6LCKxRl3v/FwByMWcDsZ99ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710925932; c=relaxed/simple;
	bh=WeRJH0QRV2eBTRBUmo3FsX3wP6HwE+cjjZ35e1EOC2k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DPOSKVCOU77i1pyyQhAAXEQeXUMC1KXKa9Z1k+0G4aDLpicFIp1uXsYO+keS1rnCLHeZSD7vqfHUEIuJFehSFvXrV2pXz6IHq1TGPH31yzdBbs8DFem2+NEa76Ge81fPqF16VfIBZuO5oiaoxFzwdrGOCRD43fWSKRSrxoJs2Go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=foBBNRpD; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5101cd91017so9880139e87.2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 02:12:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710925928; x=1711530728; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=CLbF2Sp5cCoAXAJnzkvMalTtiea2jaTjpy6sAVr6xnI=;
        b=foBBNRpDs9nHyG0N+9YJTGCaB5jP9k0Ju40ojK7yPPRIgMwPcr3htkzv6tra4dKSw9
         6SdeQa4cxUdkHf8fdogDyLPrcnSsOlBO8g4Z8Lu1kCXY2C1otxuf4oablKEQULRyaEIH
         tY0vDjr7eFVU1gzzWTJatytWxJR4x1W12TEonte1ZXRFGzgpU7DsxLt7jL6UxwF0/DP0
         jOpSniAPr/GhM6M7m+h1WP2R24QUV1Alu9P9eI8Rblx/4VIxuUMw83Au23HrAb1+ASO2
         7+8fKaAw9/NiZP8wz6u2gohKuOTP4aZ5K2NoC0Smpukx63bq7LZA9WJDdpiObmlKPceQ
         t7xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710925928; x=1711530728;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CLbF2Sp5cCoAXAJnzkvMalTtiea2jaTjpy6sAVr6xnI=;
        b=qYZt3LyGNs5nmLDZDUlxSZh0C8DUehzNCMBPOouMAvSC2fpuNCMp7wzFKg7/NRyeOD
         A7CkeeIaiPQmFJVL0fD88Q7Xiq1qr6ZWP58DVRf0o6YZfVHC+Bj9lEZGwHuR2Q54EqEZ
         g1LkLby8V3a0iSVMYGW0YY3VzVQWCHY0+bK+ogiL7kz4F0HPRzgWwzd0tErGfRPZd4b6
         QpfC17hmepx1kVzbu2eXl/FnCRiKFzGtDG1vYJg0Ez4jP/25XXtr2oyImeTSHOX/d2la
         +hjJVIbYX9sjXPY2rVgN2aFzJCd0h1/dUfPLZ1BhNAdSTTBcbK43657sdE2Iq2rF77Cj
         pORw==
X-Forwarded-Encrypted: i=1; AJvYcCWyFAJEAS6fhRRu+ZbieXPDCXylbkhuzgAWxaerHCfKq0gxHjiaJwh9e+EgNmkvbkxD12kk92yfTnPOW1KBWopJDytCcgfOTCtXRWyO
X-Gm-Message-State: AOJu0YzcDdIoJH2mpQLkUlddxOdMVUwu2Zc8HF+fKcWPgdWYwmcLCzsO
	q/T92h9cheCPoIBBjBjSQSr3LOYWvD4CnzISCqZhvPLDHajUV894Zh2duZkbUlI=
X-Google-Smtp-Source: AGHT+IFV/PiWYZjnoZXMc0POCR8q15ZWiC273odgEqO+3PbOsPJEBJ+Yz5vK2kvl/K2NIVrDyzu5Gg==
X-Received: by 2002:a19:2d4a:0:b0:513:d917:7642 with SMTP id t10-20020a192d4a000000b00513d9177642mr10116817lft.22.1710925928318;
        Wed, 20 Mar 2024 02:12:08 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.222.97])
        by smtp.gmail.com with ESMTPSA id n6-20020a509346000000b0056b924663ecsm1914876eda.59.2024.03.20.02.12.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Mar 2024 02:12:07 -0700 (PDT)
Message-ID: <38aaf71a-511d-4e63-9014-07f591d8250b@linaro.org>
Date: Wed, 20 Mar 2024 10:12:05 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] dt-bindings: media: Add bindings for
 raspberrypi,rp1-cfe
To: Naushir Patuck <naush@raspberrypi.com>,
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Sakari Ailus <sakari.ailus@linux.intel.com>,
 Jacopo Mondi <jacopo.mondi@ideasonboard.com>,
 Kieran Bingham <kieran.bingham@ideasonboard.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
References: <20240318-rp1-cfe-v1-0-ac6d960ff22d@ideasonboard.com>
 <20240318-rp1-cfe-v1-2-ac6d960ff22d@ideasonboard.com>
 <eb854c43-1e92-4c19-bfd3-1bde94924319@linaro.org>
 <f97faeb9-8a6b-47c6-9317-daca88257802@ideasonboard.com>
 <30430e0e-70de-4831-97ad-974e350a2e54@ideasonboard.com>
 <5ca1d005-1beb-47ec-943a-9358ae3c6704@linaro.org>
 <CAEmqJPp7uGYe993L+ujth2mfRy66s8-S9FNxPY7vwkrboDq9yg@mail.gmail.com>
 <89d459dd-cc8c-4780-a56a-809e24343e69@linaro.org>
 <CAEmqJPrLP3j37Kcj0mX23x00p=gWuxZPNSUTRGNkcEqsUJ2MjQ@mail.gmail.com>
 <9d238cd6-0e11-4775-bc00-7df50f0a6638@linaro.org>
 <CAEmqJPoVFRUBRnuvRaeWg6vxDaNMzdFzgj2_Gi5bxh5nacdmDw@mail.gmail.com>
 <0401eb0f-0172-4371-9a16-f51b6b885b55@ideasonboard.com>
 <CAEmqJPohq1Y11uwBWdGGX3B1vPLEK9_A7OQC=-k+bHcdk3n=mQ@mail.gmail.com>
 <b95fb19d-1c22-45b2-8b87-78e56d17ae8e@ideasonboard.com>
 <CAEmqJPoBA4PrbvoGHtiah1B=C7WO+MODUUY0qr0ZdF2eWEB3TA@mail.gmail.com>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <CAEmqJPoBA4PrbvoGHtiah1B=C7WO+MODUUY0qr0ZdF2eWEB3TA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 20/03/2024 09:50, Naushir Patuck wrote:
>>>>
>>>> Also, I'm still wondering about the RP1 part there in the compatible
>>>> string. Is it necessary? The CFE is located in the RP1 co-processor, but
>>>> is that relevant?
>>>>
>>>> Is there a versioning for the whole RP1 chip? Maybe it's going to the
>>>> wrong direction if we use the board/SoC for this compatible name, as
>>>> it's actually the RP1 where the CFE is located in, not the SoC.
>>>>
>>>
>>> I don't really know the conversion required to answer this one.
>>> Logically CFE is on RP1, so it makes sense to me to have "rp1" in the
>>> string, but I will follow the judgment of the maintainers.
>>
>> Well, my thinking here was that if we have a register from which to read
>> the version, and Raspberry Pi would create a new co-processor, RP2, with
>> the same CFE. Would we then have "raspberrypi,rp1-cfe" and
>> "raspberrypi,rp2-cfe", even if there are no changes? 

That would follow guidelines as expressed in writing bindings.

>>Or would a plain
>> "raspberrypi,cfe" do for both?
>>
>> In other words, if we don't need the "rp1" for versioning purposes,
>> should it then be dropped?
> 
> I agree with the above, you've convinced me that "raspberrypi,cfe"
> might be the more appropriate string, or a convincing argument for
> that to be a fallback string.

Just follow the guidelines. If you come up with generic compatible
alone, you could run to the same problems everyone is running.

Best regards,
Krzysztof



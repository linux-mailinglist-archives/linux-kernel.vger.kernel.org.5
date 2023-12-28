Return-Path: <linux-kernel+bounces-12697-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AD1BB81F900
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 15:10:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 277DF1F2276F
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 14:10:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEEB1C8E2;
	Thu, 28 Dec 2023 14:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Katy/l3d"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 762178826;
	Thu, 28 Dec 2023 14:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-50e49a0b5caso6751899e87.0;
        Thu, 28 Dec 2023 06:10:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703772599; x=1704377399; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=c1QLjL/t9dV5lzMG8MOwQMq25dYxUQYtyICViUBElqU=;
        b=Katy/l3dvjT/PUHC6AJgtqupaV9OPc06Gs0+ZoscqZOZASn02m3V25+fuB+SdJYlu6
         2txyPNAg7pTLp0sKYeaOdk4srCw4M3cbezWg0J3yCqEV5h/CpnfCod4oLlCtOVKG/O7k
         B25SsUDkLDJoZ+wr/mlKphqHEXaaZVLX5kxdCwawln6Q2byYCh+Gn1Oqh/QAjhG6/Kzz
         k7hwwk2K2akZDq4xYbMm+cC/R8rS7A0lV+vkpnIXlnXxAVKMMYqoqRQ5lOHyPg+wjdRo
         aZ+cUVAoz9cHEx1Mbgxs/qE9R4VQo0BamPSGCJrZC35/EFYuHp/NH4je0364fIdECEE8
         XLOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703772599; x=1704377399;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c1QLjL/t9dV5lzMG8MOwQMq25dYxUQYtyICViUBElqU=;
        b=MqKGSvElAJBHElw43aPoLiQTCo4mSYifHJKp2HbPfxfe21nCpfQGzacFqtnUQcJzfA
         r9Y1ZdeoliALPHPwZxPQJb9UsnU3oRPzRGyyQ6uemJzFiqf9PtpHw2KWC3Pf0NVfa6IZ
         /nAiCxH5O10yDyO1ACOk7nBHzfH74xWUJzUVvZqzpGF1t0DzkT5G34trXyGUAKRokvEe
         qrJOEjWGJIPcvU1ueqwii1xJswpWSzekdfVDHJN/stOjVt7Sy5j3WCUIEh1welGmxoOS
         mPhwaTcrCBsNdeMZudBEwDaY05p5KEWh2lmFoQfYmHO6mpm7OGzCMZU1dVzGAtrNj4tZ
         tyXw==
X-Gm-Message-State: AOJu0YyF9M3IA6qda6ME6Sssydfy64nQjJMu6rlgWaZ0qgSprUxjpPw7
	F+OdQZCFI87HAnUa2DsEUac=
X-Google-Smtp-Source: AGHT+IEeVZDSTI4Sv/udWx44ul868ezI9P22d/R8+w0tgBIx8Z2Nz9DzLiiPH9JRUPTtPYUP2Ke4FQ==
X-Received: by 2002:a05:6512:128b:b0:50e:7f88:e124 with SMTP id u11-20020a056512128b00b0050e7f88e124mr2632826lfs.63.1703772599108;
        Thu, 28 Dec 2023 06:09:59 -0800 (PST)
Received: from ?IPV6:2a01:c22:7631:d500:84f:c992:adf1:8a6d? (dynamic-2a01-0c22-7631-d500-084f-c992-adf1-8a6d.c22.pool.telefonica.de. [2a01:c22:7631:d500:84f:c992:adf1:8a6d])
        by smtp.googlemail.com with ESMTPSA id vl23-20020a17090730d700b00a26f91a30e1sm3224776ejb.91.2023.12.28.06.09.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Dec 2023 06:09:58 -0800 (PST)
Message-ID: <2f1e9892-261d-4b5f-9fdd-b0f852e90ea6@gmail.com>
Date: Thu, 28 Dec 2023 15:09:57 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] net: phy: micrel: Add workaround for incomplete
 autonegotiation
Content-Language: en-US
To: Asmaa Mnebhi <asmaa@nvidia.com>, Florian Fainelli <f.fainelli@gmail.com>,
 "davem@davemloft.net" <davem@davemloft.net>,
 "marek.mojik@nic.cz" <marek.mojik@nic.cz>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Cc: David Thompson <davthompson@nvidia.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20231227231657.15152-1-asmaa@nvidia.com>
 <0cdb0461-ece3-4bfb-b058-9bf75c1f6fd3@gmail.com>
 <CH2PR12MB38952DAF6D1BD4CE6831EED1D79EA@CH2PR12MB3895.namprd12.prod.outlook.com>
From: Heiner Kallweit <hkallweit1@gmail.com>
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <CH2PR12MB38952DAF6D1BD4CE6831EED1D79EA@CH2PR12MB3895.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 28.12.2023 14:37, Asmaa Mnebhi wrote:
>  > On 12/28/2023 12:16 AM, Asmaa Mnebhi wrote:
>>> Very rarely, the KSZ9031 fails to complete autonegotiation although it
>>> was initiated via phy_start(). As a result, the link stays down.
>>> Restarting autonegotiation when in this state solves the issue.
>>>
>>> Signed-off-by: Asmaa Mnebhi <asmaa@nvidia.com>
>>
>> Is there a Micrel errata associated with this work around that could be
>> referenced here?
> 
> Hi Florian,
> 
> No there isn’t. This is based on observations and comparison with the behavior and testing of other PHYs. For example, we don’t see this issue with the Vitesse PHY.
> 
The Microchip KSZ9031 errata documentation lists few link-related errata.
May any of these be relevant in your case? If not, please check with Microchip.
KSZ9031 isn't new, and most likely we would have seen such reports before,
if there's an actual issue.
I'd like to avoid that we add code to work around an issue that is specific
to your setup.

> Thanks.
> Asmaa



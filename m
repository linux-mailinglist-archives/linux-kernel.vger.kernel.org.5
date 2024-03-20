Return-Path: <linux-kernel+bounces-109501-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C112A881A3D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 00:48:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F248A1C20FBC
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 23:48:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1549E8624B;
	Wed, 20 Mar 2024 23:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mN275+VG"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 172591E87E;
	Wed, 20 Mar 2024 23:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710978517; cv=none; b=YkCQ8/JJIHcc50Tok6GBnic0d97C1yO3KRKW0lc+CVGMak4uaANYc4seYBbqOaXFueF3l+/6wMde95/0ExgwrRL+lk27SJkdqzDgCvjnPlEhjocPnjOWc13hB22/Kta3c/NzuPRgBCnnL9mWBP18g38WPjfQVvdcRTCfhgEvkdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710978517; c=relaxed/simple;
	bh=KL5CfvgrzAOdpA4+ntk7QuKHud0kFyGAeVm4Y7ZfCSM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o1rQs7E29KTjU3f4kKjP6QR3fszWBFm5czpuXdTk7dvwUTdhJvu4l24Ru4m1CI2NjPwLqNG6AHItVhTekJm9Wn7+btj3tKiCbMhvsHinc5r1pBFOA/9gCuhaf63C8V5xTl0rOvXZ6go965cQHipbTsu2vADD1KDMYmLDLgooY7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mN275+VG; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-6e7425a6714so399703b3a.0;
        Wed, 20 Mar 2024 16:48:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710978515; x=1711583315; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VOvh2NpicGofkRCrFi8PYG6o+1WRhQwAy0mztmTg8ZE=;
        b=mN275+VGuNlAyw7llDMhoZiihoKzWTSHvUYJLtE/i5yMbZSePS7io3wmztVvBMBKld
         W0Iarf0GYRGIotcwuPocBZrCC9bMLfW/NTbPO1T9B4GwzIOjlXBfePLm9F/9+MdvHUbU
         12IXrVzYlV+yUvFqbwTkTBeh86SYwnw+k/Gv34lUubJtOXp66XTca5HYQu5SNnebHAyC
         XLLmB0bEsYoraXA3mcF6QFl0LIYdZIOL1o6smksL8JaPTrctTDv5FRrpqhX38UQMrLx6
         fa21BG1S3xhJskSn9czJN3+qWvQP2dFySHap+VEg7wKcnq304PD5Zu+bGTo31aKclBGA
         PjQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710978515; x=1711583315;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VOvh2NpicGofkRCrFi8PYG6o+1WRhQwAy0mztmTg8ZE=;
        b=RMCBdpwz7toWw5b8dJyGU+ybJLSw4wck0X3BOTroFHNOxkXIAhmYBLURbqGXWyce/T
         gq1em4xI2k2YYTEsoUKn61m1nUCLNBGEXB2b7lTDAs2Q+7ucj2kKG46zPDrt/AZesF9O
         sufweT6gyPNvuEG9VCKmr2CfXLqCk3LBMs/6j+HgEXaCYTcvGqftPTw9BY2/Rcf6DEbt
         e4hWM9XBdKehk8plmUiKD9ZoX5nnWaq42Ef2YDEH3O+eWGnLC5lyZAx5x0oASLqpCq4q
         NmXzeYs9B0fv/41hKFkuSUrcF32CU3HV4cCiKzeD9A7oLLgamErQYInaQnQOXRiApASc
         lLYw==
X-Forwarded-Encrypted: i=1; AJvYcCVNgWE3TzDdRIBXnix+leatHLS0gjkWL5+6ftUkKLhksb3rMyiElLt2dxJkEBjT4OoTLq8wewVqEM0Bt4hf7y8EBqygUvsj7BylsBBc7rxmAYPnDTDJiBmrATWjLymEFS9iWZXo
X-Gm-Message-State: AOJu0YzrYXIj4HePiN52+xKwteYmpBETQZjBQrth9FHm+nlwoG3KHFos
	Yj+f38AY1yWCA7iLphem+bry48VnRLB/f+NQ6owgK7GeR9BQ1qQg
X-Google-Smtp-Source: AGHT+IEELZrDc9PEiDf1iLRCYKxe9npw673W69ut+cyK7NVGDUO4VcRKLQPH8W3IVerjr8T2DRHZfg==
X-Received: by 2002:a05:6a00:4605:b0:6e7:355a:2f62 with SMTP id ko5-20020a056a00460500b006e7355a2f62mr3550039pfb.6.1710978515194;
        Wed, 20 Mar 2024 16:48:35 -0700 (PDT)
Received: from ?IPV6:2600:8802:b00:ba1:11e9:93a1:c5e1:1a7b? ([2600:8802:b00:ba1:11e9:93a1:c5e1:1a7b])
        by smtp.gmail.com with ESMTPSA id i3-20020a056a00004300b006e56e5c09absm12522162pfk.14.2024.03.20.16.48.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Mar 2024 16:48:32 -0700 (PDT)
Message-ID: <05a042d5-95fa-4eff-b2ad-c26e865837b1@gmail.com>
Date: Wed, 20 Mar 2024 16:48:31 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: dsa: add return value check of genphy_read_status()
To: =?UTF-8?B?0JDQu9C10LrRgdCw0L3QtNGA0LAg0JTRjtC/0LjQvdCw?=
 <adiupina@astralinux.ru>, Andrew Lunn <andrew@lunn.ch>
Cc: Vladimir Oltean <olteanv@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Sebastian Reichel <sre@kernel.org>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
References: <20240314063008.11214-1-adiupina@astralinux.ru>
 <99631ba3-36f9-4eed-80d9-4a663ef46d80@lunn.ch>
 <bb752899-dbf3-4dd2-89f0-d280488bd8bf@astralinux.ru>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <bb752899-dbf3-4dd2-89f0-d280488bd8bf@astralinux.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 15/03/2024 03:25, Александра Дюпина wrote:
> Hello, Andrew!

(please do not top-post)

> 
> The dsa_register_switch() function is used in various DSA
> drivers (in probe function), so it is necessary to check all
> possible errors. If the return value (may be an error code)
> of genphy_read_status() is not checked in
> dsa_shared_port_fixed_link_register_of(), a possible error
> in dsa_register_switch() may be missed.

This is not a path that will fail, because the fixed PHY emulation layer 
is not a real piece of hardware, therefore no MDIO read could really 
cause a problem here. I don't have a strong opinion however if you want 
to propagate it properly.
-- 
Florian


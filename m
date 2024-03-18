Return-Path: <linux-kernel+bounces-106315-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D85D287EC4A
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 16:39:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1406C1C213B4
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 15:39:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57EF7524BC;
	Mon, 18 Mar 2024 15:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RUjMLaty"
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B2814EB50;
	Mon, 18 Mar 2024 15:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710776341; cv=none; b=gQVpSA/XxB6kmmJPNMXUm6QBkVZC3NWpd4V8BwZc68awfmfzEB501g6q+evSjEK/oN0v4zvxygOiiI85ioXU8Ukaiiff9sjs6K4ACifg+nqC8Q5iF0wWdZrDAjyEKQBOgq0MLHZPynkW+bHVkgbqoDV8MP/plndcC/NUGBI0h8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710776341; c=relaxed/simple;
	bh=L9H8t7HnEPj3Hdh09oZeSwbBId8Zl9XEQCxkOP7thxk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sZzwap6f/wiYk4wqXCATMzPr08QrPiLwlEjuYqjUr48ZgNbCGCmaa74pdnRpuE0MapP7vR8C8socsFPlX6OYABwd0A0ObRwxy45PG0J8zIFnbtOpB5K9wvqdDnaPrMdRBrwdQ1zDJ/uHW5mwzMfyKwcelFhDHCcupMBZoAZoVIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RUjMLaty; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-29de4e12d12so3100108a91.3;
        Mon, 18 Mar 2024 08:39:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710776339; x=1711381139; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=R0wJSLY+Uv+yhR8IopuqKPTo2o4yVaHIVNr68XVgUWs=;
        b=RUjMLatyURRVThPbi5nXe09ujDCROHTGCKcGucX/x+qmupP9yJxLl5Ai064V/PEw1J
         iBqlZyzhhhWkRT6L3rDN+DG3ytlKtQYGohhnVoJOLQBZgc3TzY+OeuZkrxgie4YlMSHU
         J2vTOXup51D8Ztl2mevXkG9aRbBodhrtxKn7dovoPdlWU6GKqfnQkXaxN6n1MPqpVJG9
         YuP6LXGiqr5p3msaaZFJT+bZNhhEFBwMFGJP+/riwCyFMQXjT11Sw3SvlKsJRS0J/C47
         PVtsAhpLdseb60KwU4mwMmASYADrYqG1ZmUqfCe4YTJC9dKVd7suoppEkUnETiDSCMrO
         36fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710776339; x=1711381139;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R0wJSLY+Uv+yhR8IopuqKPTo2o4yVaHIVNr68XVgUWs=;
        b=IYFnpe07iDknWNGiWjr8wBi8v9UeUzXTPvN26DfenWfoC73haolMMbH6yDFxrxWhv9
         6cfFdjfdnfItahDwbNOF27uV3txkFmb1nQPYT50liVNjJyNlOH8IcAxtXSX2iy72F8Ab
         5ejSrJqnqjRiCE9mF4d2K/zdQlVVyRmol9AHLgTsZP/B8W9migibl8W937+2FvprW2x7
         w3yvCcONUlRHnvPKs3fVfpWG/kXnhusex9rP9/lp2gR3956E+aRLKm7mkpOt4B2YfMr/
         Ac2vRKWh7gFyXqJPxvcEOzc1QMu4JnGW5yx4rNLcJzN4ANjMkXGYeSKATJg/vqCAHGy4
         uQqQ==
X-Forwarded-Encrypted: i=1; AJvYcCW1GYfP0ZRP8PY1jiKv0yDXjQIy0P33D/cleT25TnejHTcG1Z3zPQL7VSt/dUXNAt7n+zMaDvve45nrcPqPUM1MMxsUDkd9+xsUWAQbOaYaWz1GuHCgOHYwQPR37+yyEMBo9SZQSuxuWw==
X-Gm-Message-State: AOJu0YxRcy9lwAhh0Bt4djSe2OTC8/QgNqA1dSOml6s3NmDSgc3buzwV
	tIoUiQZA655AZRvVIjldatJpZIAMRRnoCzk7QxGUNSQLpSJ9Km09
X-Google-Smtp-Source: AGHT+IFwwuU1jLlDgfi84MjIw2c0Tg2DpHNv23NVq4KsqnYYpEH/YjvrfH11kVR4gY7v9ExA1ahxjA==
X-Received: by 2002:a17:90a:1fc4:b0:29b:c17c:5fa6 with SMTP id z4-20020a17090a1fc400b0029bc17c5fa6mr7890253pjz.33.1710776339539;
        Mon, 18 Mar 2024 08:38:59 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id q98-20020a17090a17eb00b0029e077a9fe6sm5870067pja.27.2024.03.18.08.38.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Mar 2024 08:38:58 -0700 (PDT)
Message-ID: <23f4c9b1-5c6b-4f3c-9290-41d195650368@gmail.com>
Date: Mon, 18 Mar 2024 08:38:57 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] arm64: dts: mediatek: mt7622: set PHY address of
 MT7531 switch to 0x1f
Content-Language: en-US
To: =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Matthias Brugger
 <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: mithat.guner@xeront.com, erkin.bozoglu@xeront.com,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
References: <20240314-for-mediatek-mt7531-phy-address-v1-0-52f58db01acd@arinc9.com>
 <20240314-for-mediatek-mt7531-phy-address-v1-1-52f58db01acd@arinc9.com>
 <94e3d09a-e6a4-4808-bc29-3f494b65e170@gmail.com>
 <62d128f1-11ac-4669-90ff-e9cdd0ec5bd9@arinc9.com>
 <71dd200a-0306-4baa-abab-6e6906aeef2a@gmail.com>
 <7d1ad037-d8ac-4b9a-b6d2-ab683e52a898@arinc9.com>
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <7d1ad037-d8ac-4b9a-b6d2-ab683e52a898@arinc9.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 3/18/24 08:26, Arınç ÜNAL wrote:
> On 18.03.2024 16:02, Florian Fainelli wrote:
>>>> Can we call it a pseudo PHY to use a similar terminology as what is 
>>>> done through drivers/net/dsa/{bcm_sf2,b53}*?
>>>>
>>>> This is not a real PHY as in it has no actual transceiver/digital 
>>>> signal processing logic, this is a piece of logic that snoops for 
>>>> MDIO transactions at that specific address and lets you access the 
>>>> switch's internal register as if it was a MDIO device.
>>>
>>> I can get behind calling the switch a psuedo-PHY in the context of MDIO.
>>> However, as described on "22.2.4.5.5 PHYAD (PHY Address)" of "22.2.4.5
>>> Management frame structure" of the active standard IEEE Std 802.3™‐2022,
>>> the field is called "PHY Address". The patch log doesn't give an 
>>> identifier
>>> as to what a switch is in the context of MDIO. Only that it listens on a
>>> certain PHY address which the term complies with IEEE Std 802.3™‐2022.
>>>
>>> So I don't see an improvement to be made on the patch log. Feel free to
>>> elaborate further.
>>
>> I would just s/PHY/MDIO bus address/ since that is simply more 
>> generic, but if it is not written as-is in the spec, then I won't 
>> fight it much more than I already did.
> 
> I'm not sure what you're referring to by spec. Are you asking how specific
> the name of the PHYAD field is described on the standard?

Spec = IEEE Std 802.3-2022 standard, aka the document you are quoting.
-- 
Florian



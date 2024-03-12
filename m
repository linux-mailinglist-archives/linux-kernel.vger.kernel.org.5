Return-Path: <linux-kernel+bounces-99993-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 42FA287906C
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 10:13:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 744771C2197B
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 09:13:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3E6677F25;
	Tue, 12 Mar 2024 09:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="AFTEPtwt"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 834E677F2C;
	Tue, 12 Mar 2024 09:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710234786; cv=none; b=OwjQdu2SNmbYBVoXsJzJ2WV+V5hSmc71oB2mjNn3haQZ+ggyWBD9MmOzmj2U9jt1vhZxwAa8JnPPFmTLrwmdIwqIZt3plw/oPpUvWymEFL+cA6le2Bbr/cZNgFICutS5VXnIgWxrcu1bdejFoNiLBkDGeIJ+CSZ9uk5BAw1OfRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710234786; c=relaxed/simple;
	bh=hUK9GKxZcqwSKCCM/G5VBf6KN+AtFWuXgVSp0rInAbk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tNY1tP7mQxSLZg1Cs9hBn40bwpvoTMKF+X4sk5yrsP8U/1LhDO7D1p+l67so8YBJbNP0apnDhmvMzIp2q5yv3G7UGkWjzy8YskDqUNjSptI550LBspWyqqAc9tprQb2yPEsJeVfpEUeMlKVfpHmvb7v8PBAB66IoErJ725GNjIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=AFTEPtwt; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1710234776;
	bh=hUK9GKxZcqwSKCCM/G5VBf6KN+AtFWuXgVSp0rInAbk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=AFTEPtwt7N6hWovL7mBHbeTD6vKYsE9vI9nfgS9jjnF6czX5W0q8fLc5W638qcjHP
	 eeL4zfrhocVaFUsEsJ1KYDGsiIrjAS35apSECSppKgkFVY9+MzmOBUAxFTr77nTzd/
	 xazwIKA+mZu63G6UXPcm1xoM57l6Xa2QY3dRxOri+Tq6kYltQ2wKmqlFu3BNvp9arp
	 BJq/vDV4/vGfLZh+Dx3X6UrE3frebdJS6vi4ZrK/iy+DjertMOM/2gRQDz1Tjf3nh5
	 k+D65UxAcclepGTLsrFKiXoNxBQBBU+722oQDTAxtFu7KEEvUHTnGRjRT9i/etZ5VC
	 cGUGpWjAnfRkg==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 737983780029;
	Tue, 12 Mar 2024 09:12:55 +0000 (UTC)
Message-ID: <56fe79a2-8c39-455c-a402-06c9ae7b5bd1@collabora.com>
Date: Tue, 12 Mar 2024 10:12:54 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH AUTOSEL 6.1 12/12] arm64: dts: Fix dtc interrupt_provider
 warnings
To: Pavel Machek <pavel@ucw.cz>, Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Rob Herring <robh@kernel.org>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 Chanho Min <chanho.min@lge.com>, Arnd Bergmann <arnd@arndb.de>,
 tsahee@annapurnalabs.com, atenart@kernel.org, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, rjui@broadcom.com,
 sbranden@broadcom.com, andrew@lunn.ch, gregory.clement@bootlin.com,
 sebastian.hesselbarth@gmail.com, matthias.bgg@gmail.com,
 magnus.damm@gmail.com, linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org, linux-mediatek@lists.infradead.org,
 linux-renesas-soc@vger.kernel.org
References: <20240229204039.2861519-1-sashal@kernel.org>
 <20240229204039.2861519-12-sashal@kernel.org> <Ze9x6qqGYdRiWy3h@duo.ucw.cz>
 <CAMuHMdX-ht_Vetq7+Xh0TqWOcnCdi=3d0VvfgXBF4ExtzGcRDg@mail.gmail.com>
 <ZfAUgYj0ksDmGuhN@amd.ucw.cz>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <ZfAUgYj0ksDmGuhN@amd.ucw.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 12/03/24 09:38, Pavel Machek ha scritto:
> Hi!
> 
>>>> From: Rob Herring <robh@kernel.org>
>>>>
>>>> [ Upstream commit 91adecf911e5df78ea3e8f866e69db2c33416a5c ]
>>>>
>>>> The dtc interrupt_provider warning is off by default. Fix all the warnings
>>>> so it can be enabled.
>>>
>>> We don't have that warning in 6.1 and likely won't enable it, so we
>>> should not need this.
>>
>> Still, this fixes issues in DTS that were not noticed before because
>> the checks were disabled.
> 
> Is this patch known to fix user-visible behaviour?
> 

No, doesn't fix any user-visible issue.

Cheers,
Angelo


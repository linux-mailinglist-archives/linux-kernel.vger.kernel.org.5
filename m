Return-Path: <linux-kernel+bounces-44152-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B3F5C841E03
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 09:39:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B4A201C24E6E
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 08:39:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 587A156B94;
	Tue, 30 Jan 2024 08:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="KJ//jMYd"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AEB658107;
	Tue, 30 Jan 2024 08:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706603963; cv=none; b=rqLypXqCCrHXOMw1EEzHDYlJiisX0VGNeRG7migXIjc8M4QRdjaPMIoatQ5rnCWFW1UKAH0GSsokTfvV4iCIK4egYDq7kRUUpG8CYRS/qbE2XvTdXJZWCLpnShuc9PMGBek1P1MpZaGc7jS9mHoScKsb3YA+6di1ph3wz+JG0j8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706603963; c=relaxed/simple;
	bh=9fYopgXzbpsQiE7E/H2LDcOlBUc/v20dA7T49dXOcZA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DNM+/U3cSGMolciHTGlFDYVdYI8nVxXR9mDW3Y/YZdNPatRDdqViDvtlx8ns23y+/OSF1n3P7tjBazxD3V/L4sj9Hogy0EpMGacsWEB4Ok9czSN4j9wuXCiIbDyjhUG9E1zjSmWpqSX7kK3bIBzQiyb/BrnOEEqhubuf/CPpVCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=KJ//jMYd; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1706603960;
	bh=9fYopgXzbpsQiE7E/H2LDcOlBUc/v20dA7T49dXOcZA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=KJ//jMYd/5xJLL/l0JF6Usg6KpSaxKV6UEPWTOzcid5hnldRaFoWyGoZlVjfNpJAU
	 8v6aiI+zOR2OKs0pzqlTJZiCRsYVHVHl3y1EuYQudeWWIdSX8ThAkp730BLsd+8Fr+
	 Kd3VTLJcS/JBsbjk9vsVk+NE5jvLAvmDDBCy1LpxaEgldCbLzRm8JlaawMlrjzBISX
	 9A4zAwP7HJTScRIy4RL0jCNcmLQgLxuqf58R1H27MMTEocRm67PUoYS60mauL/BXXw
	 WasRNhhfC5eo0Z/xe6ASTBU+C6xhY5QsnH9Miy4ob7yJo9lHLMagZ41e6nYQEYgzyh
	 mzS/uShqbszZA==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 0719C3782076;
	Tue, 30 Jan 2024 08:39:19 +0000 (UTC)
Message-ID: <bc1d5824-fc34-4c04-b375-1f506a358193@collabora.com>
Date: Tue, 30 Jan 2024 09:39:19 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] dt-bindings: media: mediatek-jpeg-encoder: change
 max iommus count
Content-Language: en-US
To: Chen-Yu Tsai <wenst@chromium.org>
Cc: linux-mediatek@lists.infradead.org, linux-media@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
References: <20240127084258.68302-1-eugen.hristev@collabora.com>
 <170652472373.127352.5854831299483160743.b4-ty@collabora.com>
 <282822ba-0e96-4078-a807-4b0b08e42014@collabora.com>
 <CAGXv+5Em3HUJV1pv177LUwf9iMhKSLcGhVAt6ON9YZMNaT2oZw@mail.gmail.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <CAGXv+5Em3HUJV1pv177LUwf9iMhKSLcGhVAt6ON9YZMNaT2oZw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Il 30/01/24 04:24, Chen-Yu Tsai ha scritto:
> (Drop a bunch of people from CC)
> 
> On Mon, Jan 29, 2024 at 6:48 PM AngeloGioacchino Del Regno
> <angelogioacchino.delregno@collabora.com> wrote:
>>
>> Il 29/01/24 11:41, AngeloGioacchino Del Regno ha scritto:
>>>
>>> On Sat, 27 Jan 2024 10:42:57 +0200, Eugen Hristev wrote:
>>>> MT8186 has 4 iommus in the list, to cope with this situation, adjust
>>>> the maxItems to 4 (instead of previous 2).
>>>> Add also minItems as 2 to keep compatibility with current devices.
>>>>
>>>>
>>>
>>> Applied to v6.4-next/dts64, thanks!
>>>
>>
>> Sorry, typo: v6.8-next/dts64
> 
> I was wondering, what script produces this email?
> 
> AFAIK `b4 ty` gives a simple thank you letter without branch or commit
> hashes.
> 

That's exactly `b4 ty` :-)
You can use a custom template, so that it reads something like

`Applied to ${branch}, thanks!`

Cheers,
Angelo

> ChenYu
> 
>>> [1/2] dt-bindings: media: mediatek-jpeg-encoder: change max iommus count
>>>         commit: b824b32dd5e98221cbe2e8bcccc6fb4134e35fc1
>>> [2/2] arm64: dts: mediatek: mt8186: Add jpgenc node
>>>         commit: 4c5b46fbf52d52b0f392f0fc3913560bad438e49
>>>
>>> Best regards,
>>
>>



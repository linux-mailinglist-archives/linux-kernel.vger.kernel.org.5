Return-Path: <linux-kernel+bounces-88123-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86CB586DDA6
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 09:52:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F76A284E4E
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 08:52:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0A0F69E1F;
	Fri,  1 Mar 2024 08:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="2eLU34MP"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFCAA4596C;
	Fri,  1 Mar 2024 08:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709283151; cv=none; b=n7feEQ8j9PSctL1In23YnOVgLnuqGBwpHIKS8DJnE88kIP6ofv1y3bfRvSZHdMm8C4gjBLoYfz0sZlOa8Q6ZGE+WUs45ESFmAQ4oYGFUDcCZLNTViIOAQFmBnufuV0GNn6TIU9wrv5BZiIfbGPq3f+1J+5VsvPRbMs7zllsiWys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709283151; c=relaxed/simple;
	bh=CoA/3xdsDd4t5ac8pY/l+2uKa5imLpXNOKYGL42GD1M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YWfM9q7Px3eOoyIMY7Oggk/fXqyLcmKqAPFx/pGddSlED0X2sq/98CajBHQ+aMFzk2xE0kLNGLVDp4BdMZgsDgwimjAFDg05lw0qqYqwr3+1Y6c9V3KmpbFnkZCcsq14oc8lbWbRyvd3U9LCLxFt69qv6FCOnM42eqTKze6FASU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=2eLU34MP; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1709283148;
	bh=CoA/3xdsDd4t5ac8pY/l+2uKa5imLpXNOKYGL42GD1M=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=2eLU34MPpen1ZPVUW41Vx70RazzxeE1NBcPieddH4Krxxgv3kzhQQh3oawbOOGizh
	 Na8mptoha3JHdsZaeIPwWm+h3V4UbLvjOVbt7x8PXCF4MC1RbwdpPuBE2m45McZYXc
	 RFaPHyMfY9pA8B6g5UFuZvKdevNvf5sLuVmE0ZQFF/v4NBPZv/5vK2ceUsVX1SNUcC
	 oCqN6onOsmLhmC9kLw+8Kg9JFu30n36+bl2NPtcq05mrl2Mqqf1WibDkR4/N/kbljE
	 PBjWZiSi1i6wk7u7j0UR5u3q3tWgGtBRfEW87GqEofuJTsNqIMF641LzuRglfq9lOz
	 oaRaRM0D9F/dg==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 5D5013782017;
	Fri,  1 Mar 2024 08:52:27 +0000 (UTC)
Message-ID: <0ef31c6f-86f1-4824-a7d0-a1d8798b6647@collabora.com>
Date: Fri, 1 Mar 2024 09:52:27 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] arm64: dts: mediatek: cherry: Describe CPU
 supplies
Content-Language: en-US
To: =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= <nfraprado@collabora.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>,
 "Rafael J . Wysocki" <rafael@kernel.org>,
 Matthias Brugger <matthias.bgg@gmail.com>, kernel@collabora.com,
 Conor Dooley <conor+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-mediatek@lists.infradead.org
References: <20240110142305.755367-1-nfraprado@collabora.com>
 <20240110142305.755367-2-nfraprado@collabora.com>
 <e325a4d4-0df7-499c-9d55-7da093b744ea@collabora.com>
 <8a45151a-1d51-4001-b0f9-9cfb0027232a@notapiano>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <8a45151a-1d51-4001-b0f9-9cfb0027232a@notapiano>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Il 29/02/24 21:23, Nícolas F. R. A. Prado ha scritto:
> On Wed, Jan 10, 2024 at 03:32:02PM +0100, AngeloGioacchino Del Regno wrote:
>> Il 10/01/24 15:23, Nícolas F. R. A. Prado ha scritto:
>>> Describe in each CPU node the regulator supplying it.
>>>
>>> Fixes: 260c04d425eb ("arm64: dts: mediatek: cherry: Enable MT6315 regulators on SPMI bus")
>>> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
>>>
>>
>> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> 
> Hello,
> 
> looks like this patch was never picked up, while the cpufreq part has been
> merged for a while, so I'm still getting the mentioned hangs on linux-next.
> Could this be queued? :)
> 
> Thanks,
> Nícolas

Will send that on the next -fixes round.

Thanks for the reminder.


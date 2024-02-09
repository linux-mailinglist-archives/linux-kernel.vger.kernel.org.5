Return-Path: <linux-kernel+bounces-59116-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EB03784F17B
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 09:40:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 95895B22C62
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 08:40:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64808664AA;
	Fri,  9 Feb 2024 08:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Z4YmH6zs"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F48D57303;
	Fri,  9 Feb 2024 08:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707468020; cv=none; b=cCjrcOF5+xIDxbPAF5A++LC2O8Zsv4l5MvXyyU1iZPBDb9v29HFum+nfGPZ5cuBaNsGcr6oLh/bYuGO4yj3278eWkzlaLK+rEYCMfeGD0NksjXfTz2z24Je+HUSZTCMLkFC7VZ4qo2IqHLpEqy2y7/Z+rGAj+W21dcs6mVn+ToE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707468020; c=relaxed/simple;
	bh=rWeUK8kIRCrP3AvyVO4HwXkI+h4htosgYJJ/r64ObXM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EhaAuYl1KSVFrxXvZaeL0gdf5h3YigL0i4vC4ha5e+5V61gQdhz2Rd6x6GS0NgPoak63HcwCYi5qlfBj484jDwjI6KbFjHwsQXJ3KflqQf8f+cRdaAlXLZafoOjefmeKlmCxgk4aDv+H4kTK8H/x/Udm1Dac/NE+l9eAnfz02Hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Z4YmH6zs; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1707468017;
	bh=rWeUK8kIRCrP3AvyVO4HwXkI+h4htosgYJJ/r64ObXM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Z4YmH6zs1Fqk8U3NtnC/OFO6SYmTupi4k5jo5CSSJB7g7Btm0uiJrIDiCJNdCWjaA
	 +HlfZpeHCUJLFVoyTUeTeEikJLNssP9q/VDrbtrHS2+eZxzwVUmfWhc+i4YWTyR+SY
	 XGIjethQ12pQzgZX9N4a47kxBwlCIXOZ2TjjJPKmyo8d0Tbe/dfCQJwsZ3wRecV3QX
	 kFmWt8XE9AvRnZ7sQ3w3i0SLSdS9TnVFMM6h6dUyIww/GNgdn7pjHBJb5vHiIGsfsw
	 WhxpAb8wkrZIaFdArIdz+3P+4foadiehVHtM8PqHiWSP2QCj+hNxJ/IpNWl2pNQbwW
	 f8IlHktIJdVew==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 5EA8437809D0;
	Fri,  9 Feb 2024 08:40:16 +0000 (UTC)
Message-ID: <023a1706-f6ca-481e-8a95-bc9e0e7e46ad@collabora.com>
Date: Fri, 9 Feb 2024 09:40:16 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: media: convert Mediatek consumer IR to the
 json-schema
To: =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, Rob Herring
 <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>
Cc: Matthias Brugger <matthias.bgg@gmail.com>,
 Sean Wang <sean.wang@mediatek.com>, linux-media@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240124095230.25704-1-zajec5@gmail.com>
 <62fca33c-eb1a-42ad-b7f7-31b14f0aa446@collabora.com>
 <6012ec99-4246-41b6-adb2-1bcd4dd159ac@gmail.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <6012ec99-4246-41b6-adb2-1bcd4dd159ac@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Il 09/02/24 08:24, Rafał Miłecki ha scritto:
> On 24.01.2024 13:33, AngeloGioacchino Del Regno wrote:
>> The driver says:
>>
>>      ir->bus = devm_clk_get(dev, "bus");
>>      if (IS_ERR(ir->bus)) {
>>          /*
>>           * For compatibility with older device trees try unnamed
>>           * ir->bus uses the same clock as ir->clock.
>>           */
>>          ir->bus = ir->clk;
>>      }
>>
>> This makes me think that requiring *one* clock on MT7623 would be a mistake
>> and the devicetree should use clk, bus - CLK_INFRA_IRRX_PD, CLK_TOP_F10M_REF_SEL.
> 
> Looking at mt2701-clk.h I can see CLK_INFRA_IRRX (which I guess you
> meant above).
> 
> I can't find CLK_TOP_F10M_REF_SEL however. This seems to be available on
> MT7622 and MT7629 only.
> Could you take another look at it, please? Can you somehow verify what
> clock should be used by IR on MT7623?

For MT2701/MT7623N you can use topckgen CLK_TOP_AXI_SEL as bus clock.

Cheers,
Angelo


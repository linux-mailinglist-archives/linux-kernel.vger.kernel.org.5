Return-Path: <linux-kernel+bounces-140732-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D40D8A1869
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 17:17:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BE293B2731C
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 15:17:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAA5F33999;
	Thu, 11 Apr 2024 15:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="FiqyGx3B"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7F05134B0;
	Thu, 11 Apr 2024 15:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712848508; cv=none; b=tIVOWeGq9uh+ZFVQZLKqB12XpzYyY2rLGQEIomSgbMHtigwHYrItI9XquF3rZH1974MUSwmw86DYg9nDCaRgX1dVxZISyYJAD8k2GhU0EJ5Q5cQlCvVglyfQYihdse7egZvXy/SyTgf+5GL/KynGJ7wZBCg+2DQxqsVfBMKtkIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712848508; c=relaxed/simple;
	bh=JYFfYgPqUFb865Mf27i1hGQL9j2iqDH7TZlTJELDLRs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KCEhu8Enm54f2U2brCjQSD9jOsne+v2Z/XX3tH2BR5s0cG8JkNJ1fy7JR8ttlSp7B49rx25k+SmU70VqV6cJGTcGeL2cFPOupWWTo7U4LLgnZgBL/EbPJpb9A7Sul9vQaohC9G8HdDY7+XHFbFOf6essvTWzPO/PnGCkRBP9UoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=FiqyGx3B; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1712848505;
	bh=JYFfYgPqUFb865Mf27i1hGQL9j2iqDH7TZlTJELDLRs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=FiqyGx3Bf9yVBYg3tO7PjAsHN5EgcUUShJZl7ueLYtfX3wIKj4COemgGompwfQ2TX
	 eHySSC4a5g6ktoxoKwTlQwUSaVxnkeM2+YjpgPMBGzdZ+tw+OnFaD8puJoF83WZvFv
	 uZIih6V4EqpdTio+ar1qzIHksWOsMgyMs+KZ9zSni+WsUXyx76Wxw3gzjrbUBxY2wK
	 AD/9E02Yb3pGjyj0wvWU344sMBSEs2AGalKt/0cEy145/bRHnMPcpB0QPvXq/SQx5R
	 62wawEgW8U+n6Zge6u6eY7MTPnSpU93xGj+HKdmFZJ4kRZxsNC1PVJYrE3F7uKmacQ
	 U0y7Lg45gxUBw==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id DC7E037813C0;
	Thu, 11 Apr 2024 15:15:03 +0000 (UTC)
Message-ID: <de76dc16-8edd-4322-927e-61cdac374a3a@collabora.com>
Date: Thu, 11 Apr 2024 17:15:03 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 8/8] dt-bindings: ufs: mediatek,ufs: Document optional
 dvfsrc/va09 regulators
To: Conor Dooley <conor@kernel.org>
Cc: linux-scsi@vger.kernel.org, alim.akhtar@samsung.com, avri.altman@wdc.com,
 bvanassche@acm.org, robh@kernel.org, krzysztof.kozlowski+dt@linaro.org,
 conor+dt@kernel.org, peter.wang@mediatek.com, chu.stanley@gmail.com,
 jejb@linux.ibm.com, martin.petersen@oracle.com, lgirdwood@gmail.com,
 broonie@kernel.org, matthias.bgg@gmail.com, stanley.chu@mediatek.com,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org
References: <20240411114300.169055-1-angelogioacchino.delregno@collabora.com>
 <20240411114300.169055-9-angelogioacchino.delregno@collabora.com>
 <20240411-oaf-stove-b291a21ef404@spud>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20240411-oaf-stove-b291a21ef404@spud>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 11/04/24 17:11, Conor Dooley ha scritto:
> On Thu, Apr 11, 2024 at 01:43:00PM +0200, AngeloGioacchino Del Regno wrote:
>> Document the optional dvfsrc-vcore and va09 regulators used for,
>> respectively, crypt boost and internal MPHY power management in
>> when powering on/off the (external) MediaTek UFS PHY.
>>
>> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> 
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> 
> btw:
> <stanley.chu@mediatek.com>: host mailgw01.mediatek.com[216.200.240.184] said:
>      550 Relaying mail to stanley.chu@mediatek.com is not allowed (in reply to
>      RCPT TO command)
> 
> We should probably delete them from the binding (and maybe add yourself).

Yeah, count that done for v3 (tomorrow)!

Cheers


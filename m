Return-Path: <linux-kernel+bounces-71042-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 024B5859FD2
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 10:38:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AAB221F2233D
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 09:38:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BEED2377E;
	Mon, 19 Feb 2024 09:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b="ODAyBUXC"
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4670223755;
	Mon, 19 Feb 2024 09:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708335494; cv=none; b=IWPG89Cx5/Ot59DLgMgn/F5bbXYhi3unC5dFyc8mw39pG80U3eQ0UL1Pxrd+2Y7uw3aMUEf3+4KBO+X5J6fPoX+GSLk+RmcQnD8o7SMzIYogL4qINVANzMZ6PxqCNRfzeGIAgEyjJ+WLZnvl1IbgMEBpiBuNMcYZO5KdgEp3C10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708335494; c=relaxed/simple;
	bh=JZqE/ySqdsMfEywlr++2U8VqDqwCtrbDoFfqyNfv9TQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YMCKObKzYFbuaVJycY0rhWzzD4C/jXBx9yjstC0UNi3eSOFJbBSZllm8CZbFzGWAAo5gyrdJmKlJO0SKLMdr3tmCrRU+YhRCP//Dao0xDaKrPF4j5fz0sSVSmQmASmmZIRu/3lRrkBTxV0VgVxDUXhC5FolcAwfPzE30VVfdRF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com; spf=pass smtp.mailfrom=arinc9.com; dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b=ODAyBUXC; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arinc9.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 3CDB3E0006;
	Mon, 19 Feb 2024 09:38:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arinc9.com; s=gm1;
	t=1708335490;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tfpHxAcfl5M2NGtp+kneEgWWO1Zl5+LXLY73+P7UT5k=;
	b=ODAyBUXCl8yQM4qTctmYz70QQOi5vgZlS7TgpsCPz4ZPW3x3rTfBGhu+qm1C/jqljcwmos
	EoSsPdac6aGzYaSr4RCnI7/QC5DClNMsUTVE+A6cSzrg1voGInI3zKPwOT1OwrEcalroOp
	3Y0LT4Rx67IuRoFximD6UPR8heZIkCY/4WFGSZCSaGNt9WYnwP/U1ogOCEkD4ng58NI5rN
	l6kCnrTmPG1E93HfRifzEu+hCRHws03Agn9GZSalFPHS5vpkRqlOfeKzCS8RqGBAML4LHT
	PvZFSIGXfLKKKKpEj4y5TMU04hxBci0P5z/5zmP6b+cBZ2L/aD+HD+O1awftWA==
Message-ID: <27b9f494-b824-46b8-9028-23e2ed1ff0f9@arinc9.com>
Date: Mon, 19 Feb 2024 12:38:05 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: {mt7622,mt7986}: add port@5 as CPU port
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>
Cc: Frank Wunderlich <frank-w@public-files.de>, mithat.guner@xeront.com,
 erkin.bozoglu@xeront.com, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
References: <20230918074938.79796-1-arinc.unal@arinc9.com>
 <5d582382-9a31-4a95-bc81-01d99dde0a6e@arinc9.com>
 <2795a056-eac2-491b-bcb5-52bf4a331c07@collabora.com>
Content-Language: en-US
From: =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
In-Reply-To: <2795a056-eac2-491b-bcb5-52bf4a331c07@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-Sasl: arinc.unal@arinc9.com

On 19.02.2024 12:17, AngeloGioacchino Del Regno wrote:
> Il 18/02/24 11:52, Arınç ÜNAL ha scritto:
>> Matthias, please apply this patch.
>>
>> Arınç
> 
> Please split this by SoC and resend as two patches.
> 
> If you can resend fast enough, I can apply the patches for 6.9.

Done.

https://lore.kernel.org/linux-mediatek/20240219-for-mediatek-v1-0-7078f23eab82@arinc9.com/

Arınç


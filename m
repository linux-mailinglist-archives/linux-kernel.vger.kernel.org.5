Return-Path: <linux-kernel+bounces-148249-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EFCF8A7FD6
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 11:37:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B2681C2141A
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 09:37:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2722913AA2D;
	Wed, 17 Apr 2024 09:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="CI93zXtp"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3D0013A276;
	Wed, 17 Apr 2024 09:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713346494; cv=none; b=VHtzYyvDxgMcD2NYYFX58wtJeGVDdDXxIdltLqN/hy3gorUnaXW+rTdmpDILtgYp1KRVH1R0wUU89FjB5VKseqLo+CdiWuA+NnN5X7LOPQ2Mb2yAy1HxAiX8iuOZwcgpzfZNE7b+rup/TRvcR+h5SjfiaIxLI4VRp9cVCN5sdq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713346494; c=relaxed/simple;
	bh=P2KyDPtDgrufeVQNwR/8NacfwZdrMlwcBsOVnXpMJ38=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DHkQsIxUYRE03Zk300xDDl/CfNC8RSInxCaym1muj+BzNqqfWRKAhmjqYpDshy75PT/Oxd99rIRV29LKXjMdFniLugzJUw0PAOls1SmhOyICi7AhQptYXaCQ/kAZ4v1krqH+6sOQQei93r+8TERrHy0qjZUs6vYck0uMJ2RGnJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=CI93zXtp; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1713346491;
	bh=P2KyDPtDgrufeVQNwR/8NacfwZdrMlwcBsOVnXpMJ38=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=CI93zXtpM6qUvr/AbqoLPjEmIH2Q8m95FmZ6hkIlUcSY01RGKWQ6PKcvoYcytbRVA
	 J9s8yQAPE5kyoCjUxD2NshFYlNp7Xdu1WCUtMw/nnizow+zhgHbI0NQjIoNkwuxxW0
	 8mxSLSSXOZ0eyuv24EpmlKgOBVXAb6D4Nr5cM53AcZSnSMstf043C+XNvkqDBzyjl+
	 yJgeCRH4u1ANQhQWRNcmhzW/OHkLa7LbWaBZWXP5pHaNUNA8PU3mkrKIMksYIakytK
	 DgPYFu8eN+7Ju2Gw3PFNS5DeI4/chCUDJRTG+f8ScSfSxveRbngKFdpmUGs02bbNYh
	 HOpI46JIw/A8w==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 0E98C378020A;
	Wed, 17 Apr 2024 09:34:50 +0000 (UTC)
Message-ID: <657b3245-b294-44f0-8c40-668f474a9ea5@collabora.com>
Date: Wed, 17 Apr 2024 11:34:49 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/8] scsi: ufs: ufs-mediatek: Remove useless
 mediatek,ufs-boost-crypt property
To: =?UTF-8?B?UGV0ZXIgV2FuZyAo546L5L+h5Y+LKQ==?= <peter.wang@mediatek.com>,
 "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
 "jejb@linux.ibm.com" <jejb@linux.ibm.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
 "wenst@chromium.org" <wenst@chromium.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "avri.altman@wdc.com" <avri.altman@wdc.com>,
 "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
 "bvanassche@acm.org" <bvanassche@acm.org>,
 "broonie@kernel.org" <broonie@kernel.org>,
 "alim.akhtar@samsung.com" <alim.akhtar@samsung.com>,
 "conor+dt@kernel.org" <conor+dt@kernel.org>,
 "robh@kernel.org" <robh@kernel.org>,
 "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>,
 "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
 "amergnat@baylibre.com" <amergnat@baylibre.com>
References: <20240415110012.148871-1-angelogioacchino.delregno@collabora.com>
 <20240415110012.148871-4-angelogioacchino.delregno@collabora.com>
 <c9634a286fbdb4c98a7fe6703a4eb10d66dfcb9e.camel@mediatek.com>
 <4d60e9e4-9eae-4b0a-abb2-b1ad3d278fc9@collabora.com>
 <93db93aa7eb24a255f97a1a1e8e8d936dc908258.camel@mediatek.com>
 <f3920433-b0fa-4a64-9653-e385bf1eb5c7@collabora.com>
 <d11e174d85c7f5a9b4ffe5fb2bb15dfd5823f83e.camel@mediatek.com>
 <ecd7c691-db47-42aa-ab19-f554c20774af@collabora.com>
 <12cc437d2213720190a2fcf132411cfe4485f5d0.camel@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <12cc437d2213720190a2fcf132411cfe4485f5d0.camel@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Il 17/04/24 11:29, Peter Wang (王信友) ha scritto:
> On Wed, 2024-04-17 at 10:14 +0200, AngeloGioacchino Del Regno wrote:
>>
>>
>> Upstream supports platforms that do and don't need this feature, and
>> having
>> redundant device tree properties performing the same checks is not
>> just
>> suboptimal but plain wrong.
>>
>> Adding to this, devicetree describes the hardware - and there is no
>> physical
>> hardware switch that needs this redundant property, this means that
>> the
>> property that is getting removed in this commit (and the va09 one in
>> another
>> commit of this series) is a *software switch*, not HW.
>>
>> Keep in mind, also, that this feature (and again, the va09 one as
>> well) has
>> a specific requirement to be supported - and this is what the code
>> does even
>> without the software switch to add it.
>>
>> In case there's any need to disallow such feature from a specific
>> SoC, the DT
>> bindings can be modified such that a specific compatible string would
>> disallow
>> adding the required regulator and/or boost-microvolt properties.
>>
>> Besides, I want to remind you that there is no reason to drop
>> support, or have
>> them unreliably working, or use hacks, for SoCs that are "old" -
>> especially
>> when this is a driver that works on both old and new ones.
>>
>> Regards,
>> Angelo
> 
> Hi Angelo,
> 
> These two property(boost and va09) is not software switch, they
> are hardware switch. Because if platform support crypto boost, we set
> boost property in device tree. And if platform support ufs va09, we set
> va09 proberty in device tree. These property are main hardware switch.

I disagree. If a platform supports crypto boost, it will have the dvfsrc
regulator and the supported voltage for the boost; if a platform supports
ufs va09, it will have the va09 regulator assigned in the ufshci devicetree
node.

> 
> We don't use sub switch like voltage or clock setting becasue it is
> not intiutive. Especially when va09 is not used by ufs (No va09
> property but have va09 voltage), The behavior should be wrong if ufs
> control va09 which used by other module.
> 

As I said, devicetree describes hardware - and this strategy being intuitive
or not boils down to personal opinions and nothing else.
Aside personal opinions, again, properties not describing hardware are wrong.

And again, if VA09 shall not be controlled by the UFSHCI driver on a specific
platform, then the regulator shall not be assigned to the UFSHCI node on that
specific platform.

Regards,
Angelo


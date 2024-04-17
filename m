Return-Path: <linux-kernel+bounces-148115-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87A288A7DE7
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 10:15:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F3A72842FE
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 08:15:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA82F80614;
	Wed, 17 Apr 2024 08:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="RkLV/o1P"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D2CA7D07E;
	Wed, 17 Apr 2024 08:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713341679; cv=none; b=MCPFHP+WahtUAjYdfi7MKsjSxHC7mWQBZqlYOAUPwbPbjEBA4gJPTcoBTnt76z0rTLSyAHUrk/XTHlOEqmC0WeirwoEBnU/UoBDRK9hUgiKxR7w3GRcQT5RURiSkLUZ8BpMcObn1O5XcE7NULCo2sNI7j5M+G1YYlLHTqygu8r4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713341679; c=relaxed/simple;
	bh=nxKyq4H0ET8o57EUkk9BeFnAgDxkoDenfHs8BMo7Gwc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Bycw3nihI86PPAwWsY1JRbW25s828Vhyz40oMtJ3aHEKc8V+dJrnGRL9FEp/4DjDHi5hUGq9dr7G7Yv7C2qe946msh4NvdAOD9KJuwCWEuZCSALckC7mx+84yhnHOVc8oXCOZElhVWBtkT1Lia1HpM2MMyK7kDfRBjPL5dAggPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=RkLV/o1P; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1713341669;
	bh=nxKyq4H0ET8o57EUkk9BeFnAgDxkoDenfHs8BMo7Gwc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=RkLV/o1PU9ese6veoTStGg4K/NZagOdBE6LolLHaXNkrnLu/YEag41lL2b3bdSr37
	 Wh86fihPy7t3RocZmjM4JxFj080dJXzwuKOKMQohdyQAhfxnNx7wDlHFOT90mlCgqW
	 /hXnYC462KYH89DE2Tx+Oavowvd7RNcp0LXlcYJ9UyAQeL56BZK4WLW/JI2dkCrdJg
	 pciBYIEo/3AHBXF17BXKSmnhzALaMatAJ7lNRuXY8NdpevP1Z5dbWGCec4JlO73+L8
	 sZ1JCNimKuKWPqqGI4H+5aggw8DGG7JRzbtCSuFbTgbiVDeIKbr/vKs3ikzyEXFdf+
	 3Y0aQxTbbaA8Q==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id B6E033780629;
	Wed, 17 Apr 2024 08:14:28 +0000 (UTC)
Message-ID: <ecd7c691-db47-42aa-ab19-f554c20774af@collabora.com>
Date: Wed, 17 Apr 2024 10:14:28 +0200
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
 Chen-Yu Tsai <wenst@chromium.org>, Alexandre Mergnat <amergnat@baylibre.com>
References: <20240415110012.148871-1-angelogioacchino.delregno@collabora.com>
 <20240415110012.148871-4-angelogioacchino.delregno@collabora.com>
 <c9634a286fbdb4c98a7fe6703a4eb10d66dfcb9e.camel@mediatek.com>
 <4d60e9e4-9eae-4b0a-abb2-b1ad3d278fc9@collabora.com>
 <93db93aa7eb24a255f97a1a1e8e8d936dc908258.camel@mediatek.com>
 <f3920433-b0fa-4a64-9653-e385bf1eb5c7@collabora.com>
 <d11e174d85c7f5a9b4ffe5fb2bb15dfd5823f83e.camel@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <d11e174d85c7f5a9b4ffe5fb2bb15dfd5823f83e.camel@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Il 16/04/24 15:05, Peter Wang (王信友) ha scritto:
> On Tue, 2024-04-16 at 12:38 +0200, AngeloGioacchino Del Regno wrote:
>> Il 16/04/24 12:31, Peter Wang (王信友) ha scritto:
>>>
>>>> Yes this causes -> less than half of a millisecond <- of
>>>> additional
>>>> boot time
>>>> if the dvfsrc-supply is present but boost-microvolt is not.
>>>>
>>>> I really don't see the problem with that :-)
>>>>
>>>
>>> Adding a little bit of boot time to one smartphone might not be a
>>> problem, but when you consider a billion smartphones each adding a
>>> little bit, the cumulative effect becomes significant. The power
>>> consumption of these accumulated times will continue to increase,
>>> contributing to the Earth's carbon emissions. Moreover, removing
>>> the
>>> master switch for this feature doesn't seem to have any benefits
>>> other
>>> than not having to set it in the DTS. Similarly, the master switch
>>> for
>>> VA09 seems to have more disadvantage.
>>>
>>
>> Sorry, but I still don't see how a few *microseconds* more of boot
>> time can
>> be significant, even related to power consumption during boot.
>>
>> If that was a few milliseconds, then I'd agree with you, but that's
>> not the case.
>>
>> Removing the master switch has a benefit: you *lose* a few
>> microseconds of boot
>> time (so, boots in *few microseconds LESS*) on platforms that would
>> have this set
>> in devicetree, as this property is redundant with the other
>> activation checks
>> for those features.
>>
>> So, there you go: if the majority of MediaTek platforms are already
>> using this
>> crypt boost feature, then this commit reduces carbon emissions, as
>> those would
>> boot in a few less microseconds.
>>
> 
> But the majority platfomrs dosen't need this feature.
> This feature is only for legacy chip which at least 4 years ago.
> 

Upstream supports platforms that do and don't need this feature, and having
redundant device tree properties performing the same checks is not just
suboptimal but plain wrong.

Adding to this, devicetree describes the hardware - and there is no physical
hardware switch that needs this redundant property, this means that the
property that is getting removed in this commit (and the va09 one in another
commit of this series) is a *software switch*, not HW.

Keep in mind, also, that this feature (and again, the va09 one as well) has
a specific requirement to be supported - and this is what the code does even
without the software switch to add it.

In case there's any need to disallow such feature from a specific SoC, the DT
bindings can be modified such that a specific compatible string would disallow
adding the required regulator and/or boost-microvolt properties.

Besides, I want to remind you that there is no reason to drop support, or have
them unreliably working, or use hacks, for SoCs that are "old" - especially
when this is a driver that works on both old and new ones.

Regards,
Angelo


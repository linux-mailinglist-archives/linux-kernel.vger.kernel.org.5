Return-Path: <linux-kernel+bounces-146638-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ACBB8A68A0
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 12:38:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF0231F21D03
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 10:38:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04C84127E3B;
	Tue, 16 Apr 2024 10:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="J4d6Kzkw"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5DBC127B60;
	Tue, 16 Apr 2024 10:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713263916; cv=none; b=Xv4QH7iACQjCRrmgwsEuYN9pweSC0GovVvdwhKwpaEXpTg/HtTm1slV4/gSGWK6U7HZDnuG0g0G4ZS2RYbHKCB/QIV5fFDcLauP7ZFXtbFhRZdt0NAoZyvEBuwOF+xxU400yrM58I8pcRXLPwidgHVpmPxV84KDXivyT/oTVdN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713263916; c=relaxed/simple;
	bh=pK3vpmXoyhjgc5/+MqiOTT24oZivIAniiVbO1jnVuqM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QTYAxko7+M+ks4ZaRlLUQgjGUZ97pRVgvRCip+4Fvji5yHMV7000Vm69WYNCDUTIxzjDkVtmdAgs8PtowtgLttSzQpyg0XFZtpkJvFW0OMc7wWQGrwY0Qu0GMBE6HTTqbQh7LLJOjj1uuzcumD+Xa56WiPHDTmTqcZ2nBeiO+5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=J4d6Kzkw; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1713263910;
	bh=pK3vpmXoyhjgc5/+MqiOTT24oZivIAniiVbO1jnVuqM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=J4d6KzkwOJH5ozVybjyzmBm0u1oJN7TflqhG7AA63jTqV03T0tqGS1eyRsKFHcuu3
	 jPKyvtENm5I6a6o3xxJzwv0UWuUICe0IkDxEGQBLbExOZ1oTVpDhfbEG4LtfZofWK6
	 7ZHhOG5DgZO4fgZebNh2Q0ECiF42Q7x0xugerrAVdbVoaUM/MWZmEZBbRH1qsvqLt1
	 66hYXIDQU4uhh3mSWE7WuJ6p8A3SaH/qXQ42vb5NoUes/HdWOsOc2O7jPLBXAVPxrp
	 ee2SRQVw0WQMGc/wkVKuQEPk+cZkTZr6hiZOTl5BX0x5puowD22lYKzIhcwbtlefwu
	 H5HxRum/pijhw==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 5F51F378210B;
	Tue, 16 Apr 2024 10:38:29 +0000 (UTC)
Message-ID: <f3920433-b0fa-4a64-9653-e385bf1eb5c7@collabora.com>
Date: Tue, 16 Apr 2024 12:38:28 +0200
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
 "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
 "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
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
 "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>
References: <20240415110012.148871-1-angelogioacchino.delregno@collabora.com>
 <20240415110012.148871-4-angelogioacchino.delregno@collabora.com>
 <c9634a286fbdb4c98a7fe6703a4eb10d66dfcb9e.camel@mediatek.com>
 <4d60e9e4-9eae-4b0a-abb2-b1ad3d278fc9@collabora.com>
 <93db93aa7eb24a255f97a1a1e8e8d936dc908258.camel@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <93db93aa7eb24a255f97a1a1e8e8d936dc908258.camel@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Il 16/04/24 12:31, Peter Wang (王信友) ha scritto:
> 
>> Yes this causes -> less than half of a millisecond <- of additional
>> boot time
>> if the dvfsrc-supply is present but boost-microvolt is not.
>>
>> I really don't see the problem with that :-)
>>
> 
> Adding a little bit of boot time to one smartphone might not be a
> problem, but when you consider a billion smartphones each adding a
> little bit, the cumulative effect becomes significant. The power
> consumption of these accumulated times will continue to increase,
> contributing to the Earth's carbon emissions. Moreover, removing the
> master switch for this feature doesn't seem to have any benefits other
> than not having to set it in the DTS. Similarly, the master switch for
> VA09 seems to have more disadvantage.
> 

Sorry, but I still don't see how a few *microseconds* more of boot time can
be significant, even related to power consumption during boot.

If that was a few milliseconds, then I'd agree with you, but that's not the case.

Removing the master switch has a benefit: you *lose* a few microseconds of boot
time (so, boots in *few microseconds LESS*) on platforms that would have this set
in devicetree, as this property is redundant with the other activation checks
for those features.

So, there you go: if the majority of MediaTek platforms are already using this
crypt boost feature, then this commit reduces carbon emissions, as those would
boot in a few less microseconds.

Regards,
Angelo

> 
>> Regards,
>> Angelo
>>
>>> Thanks.
>>> Peter
>>>
>>>
>>>
>>>>    	ret = ufs_mtk_init_va09_pwr_ctrl(hba);
>>>>    	if (ret)
>>
>>




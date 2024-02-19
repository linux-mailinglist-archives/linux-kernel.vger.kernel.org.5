Return-Path: <linux-kernel+bounces-71100-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3586885A099
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 11:11:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF1FE282ABB
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 10:11:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDDBC25605;
	Mon, 19 Feb 2024 10:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="b5IP8oB0"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB0EB22F1E;
	Mon, 19 Feb 2024 10:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708337478; cv=none; b=DsjkIssor0774jyx+xJ93e1u3QzSJtl/f+MBAJ985So+Omf6us5CRFp5fi+9wHxi68jiERG9FIkfDY3g6EShjyGWDcQse6/vt4Giq2QcPlZddftNPigVjZAIvoAC76brIjCMaapz7axbJfEllbgmkeywnmA4qaW4lO+VnXcF38A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708337478; c=relaxed/simple;
	bh=nKglCQxaIL9KhzTcv2EpJnB3vJNsx8B6s925upveKuo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=RBRBBapwgBUdsh8Pm3gb5cs6LMWr2b2V+AXkaF1mgs3Y/Zm3Eb7bCVpqi7kcsz5ZqI+8Y4JZ5en6ZyEkKTZLiY6u6WgGgg+0Wuvd3dE7RWIKg5GnBNHKmIefG+hBt9P+oQWZ4xaATlPXWePKmWfxgGWPyHsC+dsfmyfa4PU11Gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=b5IP8oB0; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 34ead050cf0f11ee9e680517dc993faa-20240219
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:CC:To:Subject:MIME-Version:Date:Message-ID; bh=FrRtn58nRdzgiHjxO5LEX/AMpFVMDY48qkJZG+hrISI=;
	b=b5IP8oB0Z4PMPQbZStwzEWt/qKj8D2T6SxgxjuASMPY4nSOqRE5FqCyp4Biip4wM6Q5KI7hjwNiuSnhNn1LIHgSf976iWemmwoAZjUJzBvkonR4MiQIGC6gHNyJxGf2/aUcsmyQaEJu9at+E4YKhY8uIb/OOSaHCX1KciVVBOPM=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:d6fa4c11-acf9-4f1c-ae0e-dcbd7dee9419,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6f543d0,CLOUDID:95978e80-4f93-4875-95e7-8c66ea833d57,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 34ead050cf0f11ee9e680517dc993faa-20240219
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw01.mediatek.com
	(envelope-from <macpaul.lin@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1620944991; Mon, 19 Feb 2024 18:11:11 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 19 Feb 2024 18:11:10 +0800
Received: from [172.21.84.99] (172.21.84.99) by mtkmbs13n1.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.1118.26 via Frontend
 Transport; Mon, 19 Feb 2024 18:11:04 +0800
Message-ID: <91b2109d-1bf7-1fa7-ac16-ec1d9aba2f5b@mediatek.com>
Date: Mon, 19 Feb 2024 18:11:03 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v2 1/2] dt-bindings: phy: mediatek: tphy: add a property
 for force-mode switch
Content-Language: en-US
To: Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>, Chunfeng
 Yun <chunfeng.yun@mediatek.com>
CC: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
	<conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>,
	<linux-phy@lists.infradead.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>,
	<gregkh@linuxfoundation.org>
References: <20231211025624.28991-1-chunfeng.yun@mediatek.com>
 <170317895962.712473.102387666807925662.b4-ty@kernel.org>
From: Macpaul Lin <macpaul.lin@mediatek.com>
In-Reply-To: <170317895962.712473.102387666807925662.b4-ty@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit

On 12/22/23 01:15, Vinod Koul wrote:
> 	
> 
> External email : Please do not click links or open attachments until you 
> have verified the sender or the content.
> 
> On Mon, 11 Dec 2023 10:56:23 +0800, Chunfeng Yun wrote:
>> Due to some old SoCs with shared t-phy between usb3 and pcie only support
>> force-mode switch, and shared and non-shared t-phy may exist at the same
>> time on a SoC, can't use compatible to distinguish between shared and
>> non-shared t-phy, add a property to supported it.
>> Currently, only support switch from default pcie mode to usb3 mode.
>> But now prefer to use "mediatek,syscon-type" on new SoC as far as possible.
>> 
>> [...]
> 
> Applied, thanks!
> 
> [1/2] dt-bindings: phy: mediatek: tphy: add a property for force-mode switch
>        commit: cc230a4cd8e91f64c90b5494dfd76848197418ed
> [2/2] phy: mediatek: tphy: add support force phy mode switch
>        commit: 9b27303003f5af0d378f29ccccea57c7d65cc642
> 
> Best regards,
> -- 
> ~Vinod
> 
> 

Is it possible to cherry-pick these 2 patches to stable branches?
These 2 patches help fix USB port 1 (xhci1) for board mt8395-genio-1200-evb.
The following branch has been tested.
  - linux-6.7.y (6.7.5): apply test, build pass, function tested OK 
(with corresponded dtb change).
  - linux-6.6.y (6.6.17): apply test, build pass.
  - linux-6.1.y (6.1.78): apply test, build pass.

Thanks.
Macpaul Lin


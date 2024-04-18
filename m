Return-Path: <linux-kernel+bounces-149481-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AE518A91A6
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 05:44:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 29BEA1F21FCB
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 03:44:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 256E254900;
	Thu, 18 Apr 2024 03:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="Lhc9wMVh"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AB0A50A73;
	Thu, 18 Apr 2024 03:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713411873; cv=none; b=LSxLToQYAmgHUSGNXPtMWETc8cdNLRGdTP6F2D/C6zllR6lT+nMnoc7V1Xq2WU7e3+Og1KHJJ1TJnllzoEz9gGu+KV33SLvQaV5ZxEMf8bqSaF24AKdaGUgLvH+no62YEpBCACcaG3Fd1yf1AF9f4NagY5tYSVHQphRjyD1vQWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713411873; c=relaxed/simple;
	bh=U2Nj0y8rgDV3GxEW5hGYuCnMlaN52bBjiECPFvi+s40=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=tg/9nKTE6Cm4lIpXRoZ3gmtfpgFlvW9EldBsoyYcdK09ZGLvoaM3eey50aF9X5aMTUhh/EZmDp4ALYMsSqvUCXFRZbCz5szeVRIe6lnowDkJpeeYi/re8FVl2Bxm5acD6pXgSXG3KkD9fOKqjOfk3NY9h4ZcqYphzhSO7lnVLKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=Lhc9wMVh; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: f2ae429efd3511ee935d6952f98a51a9-20240418
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:CC:To:Subject:MIME-Version:Date:Message-ID; bh=2WZOZxeDxzclDmOroLLjFYiWM5YkLbMKvy/WySlZYsk=;
	b=Lhc9wMVhaxyGUSTN/TCoW9WtFk5f3/de7p46OKwpWVzZsIrcfq+o2ELf3Dc+/Fxx8l1ywf1oG8yx8zuvSEoM/mdZx3b5SDk5JKxdFnewhN1rasyzXzZhfCX0rmhmIisfYA9dvYIuHZg6wZ+f/jM9HDK3wmoQA85OfSh2XF9iDGM=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.38,REQID:74206c3e-81c0-41e8-915f-e84c0589e004,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:82c5f88,CLOUDID:8546b791-e2c0-40b0-a8fe-7c7e47299109,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-UUID: f2ae429efd3511ee935d6952f98a51a9-20240418
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by mailgw02.mediatek.com
	(envelope-from <macpaul.lin@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 562359842; Thu, 18 Apr 2024 11:44:24 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 MTKMBS09N2.mediatek.inc (172.21.101.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 17 Apr 2024 20:44:22 -0700
Received: from [172.21.84.99] (172.21.84.99) by mtkmbs13n1.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.1118.26 via Frontend
 Transport; Thu, 18 Apr 2024 11:44:22 +0800
Message-ID: <cdcadfdc-1861-b3b3-eafa-22071516197b@mediatek.com>
Date: Thu, 18 Apr 2024 11:44:20 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] arm64: dts: mediatek: mt8395-genio-1200-evk: add u3port1
 for xhci1
Content-Language: en-US
To: Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-mediatek@lists.infradead.org>
CC: Bear Wang <bear.wang@mediatek.com>, Pablo Sun <pablo.sun@mediatek.com>,
	Macpaul Lin <macpaul@gmail.com>, Chunfeng Yun <chunfeng.yun@mediatek.com>,
	MediaTek Chromebook Upstream
	<Project_Global_Chrome_Upstream_Group@mediatek.com>, Chen-Yu Tsai
	<wenst@chromium.org>, <stable@vger.kernel.org>
References: <20240216095751.4937-1-macpaul.lin@mediatek.com>
From: Macpaul Lin <macpaul.lin@mediatek.com>
In-Reply-To: <20240216095751.4937-1-macpaul.lin@mediatek.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit

On 2/16/24 17:57, Macpaul Lin wrote:
> This patch fixes an issue where xhci1 was not functioning properly because
> the state and PHY settings were incorrect.
> 
> The introduction of the 'force-mode' property in the phy-mtk-tphy driver
> allows for the correct initialization of xhci1 by updating the Device Tree
> settings accordingly.
> 
> The necessary fixup which added support for the 'force-mode' switch in the
> phy-mtk-tphy driver.
> commit 9b27303003f5 ("phy: mediatek: tphy: add support force phy mode switch")
> Link: https://lore.kernel.org/r/20231211025624.28991-2-chunfeng.yun@mediatek.com

Dear AngeloGioacchino,

Just a soft reminding about the patch has been sent a while back for the 
shared U3PHY and PCIe PHY setup for genio-1200 boards. I'm not sure if 
you've missed this patch in mail box. :)

The patch is pretty important as it lets the device tree (dts) decide 
whether to enable U3PHY or PCIe PHY. Because this is a shared hardware 
phy and could only be configured in dts to decide which function to be 
initialized, so it's something that should be included in the 
board-specific dts files.

Do you think it needs to be resubmitted, or is it still in the queue for 
review? It's meant to be ready for action from kernel version 6.8 onwards.

Looking forward to your thoughts on this. Let me know if there's 
anything else you need from my side.

> Prior to this fix, the system would exhibit the following probe failure messages
> for xhci1:
>    xhci-mtk 11290000.usb: supply vbus not found, using dummy regulator
>    xhci-mtk 11290000.usb: uwk - reg:0x400, version:104
>    xhci-mtk 11290000.usb: xHCI Host Controller
>    xhci-mtk 11290000.usb: new USB bus registered, assigned bus number 5
>    xhci-mtk 11290000.usb: clocks are not stable (0x1003d0f)
>    xhci-mtk 11290000.usb: can't setup: -110
>    xhci-mtk 11290000.usb: USB bus 5 deregistered
>    xhci-mtk: probe of 11290000.usb failed with error -110
> 
> With the application of this dts fixup, the aforementioned initialization errors
> are resolved and xhci1 is working.
> 
> Signed-off-by: Macpaul Lin <macpaul.lin@mediatek.com>
> ---
>   arch/arm64/boot/dts/mediatek/mt8395-genio-1200-evk.dts | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8395-genio-1200-evk.dts b/arch/arm64/boot/dts/mediatek/mt8395-genio-1200-evk.dts
> index 7fc515a07c65..e0b9f2615c11 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8395-genio-1200-evk.dts
> +++ b/arch/arm64/boot/dts/mediatek/mt8395-genio-1200-evk.dts
> @@ -854,6 +854,10 @@
>   
>   &u3phy1 {
>   	status = "okay";
> +
> +	u3port1: usb-phy@700 {
> +		mediatek,force-mode;
> +	};
>   };
>   
>   &u3phy2 {
> @@ -885,6 +889,8 @@
>   };
>   
>   &xhci1 {
> +	phys = <&u2port1 PHY_TYPE_USB2>,
> +	       <&u3port1 PHY_TYPE_USB3>;
>   	vusb33-supply = <&mt6359_vusb_ldo_reg>;
>   	status = "okay";
>   };

Thanks
Macpaul Lin


Return-Path: <linux-kernel+bounces-68398-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 659018579AF
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 11:01:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3557528B101
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 10:01:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77E6B1C292;
	Fri, 16 Feb 2024 09:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="CcMs6WvF"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27A821B812;
	Fri, 16 Feb 2024 09:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708077496; cv=none; b=B4XQXqp9re//dXZH2b3c356JosfoWIi8mGDXjSsPuoD+YPDmcm92rMd247l6nIPokiNMSp/Q9GaQ3VuvGGkdNDFx0XLiXSVcxvNGvYpJ8FQneZOodcGuq7FIKtqndjftwrcns7wkkgZHkUWt9XVUDHaAws5hZZcXg5D0wN8Tlpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708077496; c=relaxed/simple;
	bh=Igmoy1QfrGqffoxw4riM61fuv9HSbbNYM74Sz4fxSTg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Ehjn/huvL700jH9yVVmATBPz4HJy4VLaVfAGXjubx/5LFgOcIWy4y5Kf+hmxSrSTyisq9ws1VY9E8rhg0wDFQQZKh3JXyN2DT+QF0JvWcrWSK8Mvd0qQCVGqFjlrsWqwpAPgKFViPKzquyZcsJCie+jc5pVoSxih6Qhdf47pHZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=CcMs6WvF; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: dfaecea2ccb111eea2298b7352fd921d-20240216
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=9E/UvhK5CSAsRCQgb1278nkWwKaiC3/rTLcvlSnjgNE=;
	b=CcMs6WvF5d7loJMAWZtv51nKSvSl8fulQFJU5PZXS2zfL5CMi5Bm0AaKXoMqPQCFFKzkakF0SVxqg5iMI+d3myUQoc6dCZp1Ua3IjDfWKXPko/S+gJTUaJSmJkcw+D7Z8UQw8DGGeXpQ9qLAd1OSpkNmx791/6Xrl6bwTnncku0=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:599dcc33-084b-4862-ae1e-31e6349c55f2,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6f543d0,CLOUDID:f49af583-8d4f-477b-89d2-1e3bdbef96d1,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-UUID: dfaecea2ccb111eea2298b7352fd921d-20240216
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
	(envelope-from <macpaul.lin@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 447384518; Fri, 16 Feb 2024 17:58:02 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 16 Feb 2024 17:58:01 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 16 Feb 2024 17:58:01 +0800
From: Macpaul Lin <macpaul.lin@mediatek.com>
To: Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-mediatek@lists.infradead.org>
CC: Bear Wang <bear.wang@mediatek.com>, Pablo Sun <pablo.sun@mediatek.com>,
	Macpaul Lin <macpaul.lin@mediatek.com>, Macpaul Lin <macpaul@gmail.com>,
	Chunfeng Yun <chunfeng.yun@mediatek.com>, MediaTek Chromebook Upstream
	<Project_Global_Chrome_Upstream_Group@mediatek.com>, Chen-Yu Tsai
	<wenst@chromium.org>
Subject: [PATCH] arm64: dts: mediatek: mt8395-genio-1200-evk: add u3port1 for xhci1
Date: Fri, 16 Feb 2024 17:57:51 +0800
Message-ID: <20240216095751.4937-1-macpaul.lin@mediatek.com>
X-Mailer: git-send-email 2.18.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-MTK: N

This patch fixes an issue where xhci1 was not functioning properly because
the state and PHY settings were incorrect.

The introduction of the 'force-mode' property in the phy-mtk-tphy driver
allows for the correct initialization of xhci1 by updating the Device Tree
settings accordingly.

The necessary fixup which added support for the 'force-mode' switch in the
phy-mtk-tphy driver.
commit 9b27303003f5 ("phy: mediatek: tphy: add support force phy mode switch")
Link: https://lore.kernel.org/r/20231211025624.28991-2-chunfeng.yun@mediatek.com

Prior to this fix, the system would exhibit the following probe failure messages
for xhci1:
  xhci-mtk 11290000.usb: supply vbus not found, using dummy regulator
  xhci-mtk 11290000.usb: uwk - reg:0x400, version:104
  xhci-mtk 11290000.usb: xHCI Host Controller
  xhci-mtk 11290000.usb: new USB bus registered, assigned bus number 5
  xhci-mtk 11290000.usb: clocks are not stable (0x1003d0f)
  xhci-mtk 11290000.usb: can't setup: -110
  xhci-mtk 11290000.usb: USB bus 5 deregistered
  xhci-mtk: probe of 11290000.usb failed with error -110

With the application of this dts fixup, the aforementioned initialization errors
are resolved and xhci1 is working.

Signed-off-by: Macpaul Lin <macpaul.lin@mediatek.com>
---
 arch/arm64/boot/dts/mediatek/mt8395-genio-1200-evk.dts | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8395-genio-1200-evk.dts b/arch/arm64/boot/dts/mediatek/mt8395-genio-1200-evk.dts
index 7fc515a07c65..e0b9f2615c11 100644
--- a/arch/arm64/boot/dts/mediatek/mt8395-genio-1200-evk.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8395-genio-1200-evk.dts
@@ -854,6 +854,10 @@
 
 &u3phy1 {
 	status = "okay";
+
+	u3port1: usb-phy@700 {
+		mediatek,force-mode;
+	};
 };
 
 &u3phy2 {
@@ -885,6 +889,8 @@
 };
 
 &xhci1 {
+	phys = <&u2port1 PHY_TYPE_USB2>,
+	       <&u3port1 PHY_TYPE_USB3>;
 	vusb33-supply = <&mt6359_vusb_ldo_reg>;
 	status = "okay";
 };
-- 
2.18.0



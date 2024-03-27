Return-Path: <linux-kernel+bounces-120352-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FC1E88D62A
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 06:58:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A17751C24E3C
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 05:58:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5460241E9;
	Wed, 27 Mar 2024 05:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="HcP1G+T6"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D06EE572;
	Wed, 27 Mar 2024 05:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711519065; cv=none; b=aaT99o5IenXc6Tq+B2IMqnqofIAqdfBGnrrHDgiRF2QWYUcGvVq8VCOdtPSYhN7sNJZGZYB7DmQ42iJF+XVkn4Ckgn8jlgU0WbuuuONfpsf5OGhP95wGESPLQGVu2LkSr97zi+uOo1LAMwPZBEfbkDZriqFnLHnkEcQMwnBy4T0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711519065; c=relaxed/simple;
	bh=PpaI7Wp5A8h6hPsrg+Tlvy/MQSt7NhClwoEa3xbARaw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=YnhNzIzLfma/bNHBGfdNIL/SO0voNQELLyYbhiCrRxQzIH/2Mpc0mpYx8mOo2TEqmrm8Wyd1EIc7cCCVTXT09e8uoWk+6uxeCJgN4FapYm2CAfnXQdU7/LSoyHnXpJDWV5uyde4feyr4kweH0cpmrD3UwzSR40oHhT8W9pRVHEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=HcP1G+T6; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: e93d26a0ebfe11eeb8927bc1f75efef4-20240327
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=8IZzO+mOpfrBWdJYvNSqM18e12S2fKclk8r352xBKQY=;
	b=HcP1G+T6V7iczm9B++VZyr6FhvNgMSScfxNRqezj1cGx39IIuTWlUpZ6p8XnkVLViSJY46K6kCi0FtVe/PhjJ0Ech8RYTHh5+BQ07vMRvQJEKU3xVPZGdlvaNYX7tFTN99vvo53HRyZkbxatvnaaPfzO6yOpqumdqgeBJACNGv8=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:d991b348-9c0f-44e9-bbee-4d919011b753,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6f543d0,CLOUDID:32e37b85-8d4f-477b-89d2-1e3bdbef96d1,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-UUID: e93d26a0ebfe11eeb8927bc1f75efef4-20240327
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
	(envelope-from <yu-chang.lee@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 481297072; Wed, 27 Mar 2024 13:57:36 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 MTKMBS14N2.mediatek.inc (172.21.101.76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 27 Mar 2024 13:57:34 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 27 Mar 2024 13:57:34 +0800
From: yu-chang.lee <yu-chang.lee@mediatek.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, "Ulf
 Hansson" <ulf.hansson@linaro.org>, Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	"MandyJH Liu" <mandyjh.liu@mediatek.com>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-pm@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-mediatek@lists.infradead.org>,
	<Project_Global_Chrome_Upstream_Group@mediatek.com>, <fan.chen@mediatek.com>,
	<xiufeng.li@mediatek.com>, <yu-chang.lee@mediatek.com>
Subject: [PATCH v2 0/3] pmdomain: mediatek: solve power domain glitch issue
Date: Wed, 27 Mar 2024 13:57:29 +0800
Message-ID: <20240327055732.28198-1-yu-chang.lee@mediatek.com>
X-Mailer: git-send-email 2.18.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--8.489800-8.000000
X-TMASE-MatchedRID: 5DngdSbII22YvtVftxNfQUvrB8UvzFr4BdebOqawiLuCsBeCv8CM/Sse
	9qdFFe49mI8EBZ3uTGtSzpXv5ekotFrgS5K/qcaqDko+EYiDQxFQCOsAlaxN7w6QlBHhBZuwkwm
	4GnFKyckb7ifYusSVqcMHFIKAT3DiXSJ4c3nT+QcZXJLztZviXLLiLKO9VZOiGNAPebYwJ/sNir
	voD95MYraIKdGDLjghSHd+RjLgi2MWk4/JZEVmwAPZZctd3P4BSjyMfjCRfaObKItl61J/yZ+in
	TK0bC9eKrauXd3MZDWyPbu28yjM4gPvrALLbNcROH7ySOIYRUM7/nX4aM2lhoCh/NuaNOQW
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--8.489800-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	B131BB1C8C2F0B0239F1DB47012190F48CFE42F64402C447803B73104D73C13D2000:8
X-MTK: N

Hi,

This series aims to solve power-off failures and occasional SMI hang issues that
occur during camera stress tests. The issue arises because, when MTCMOS powers on
or off, signal glitches are sometimes produced. This is fairly normal, but the 
software must address it to avoid mistaking the glitch for a transaction signal.

The solutions in these patches can be summarized as follows:

1. Disable the sub-common port after turning off the Larb CG and before turning 
   off the Larb MTCMOS.
2. Use CLAMP to disable/enable the SMI common port.
3. Implement an AXI reset.
For previous discussion on the direction of the code modifications, please refer
to: https://lore.kernel.org/linux-arm-kernel/c476cc48-17ec-4e14-98d8-35bdffb5d296@collabora.com/

Change in v2
 - fix commit title to "pmdomain: mediatek:"
 - add dt-binding definition
 - remove unused function


yu-chang.lee (3):
  pmdomain: mediatek: add smi_larb_reset function when power on
  dt-bindings: power: Add mediatek larb definition
  pmdomain: mediatek: support smi clamp protection

 .../power/mediatek,power-controller.yaml      |   4 +
 drivers/pmdomain/mediatek/mt8188-pm-domains.h |  69 ++++++-
 drivers/pmdomain/mediatek/mtk-pm-domains.c    | 168 ++++++++++++++----
 drivers/pmdomain/mediatek/mtk-pm-domains.h    |  13 ++
 4 files changed, 218 insertions(+), 36 deletions(-)

-- 
2.18.0



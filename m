Return-Path: <linux-kernel+bounces-6495-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F31548199A4
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 08:37:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFC93282265
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 07:37:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95B0D1BDE3;
	Wed, 20 Dec 2023 07:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="bQpsF4Vf"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23E691A59E
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 07:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 850c2de89f0a11eeba30773df0976c77-20231220
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=56MmzR0c9zXysLe67Ot4Yef+jNl96T4Rvs/yNt96T7M=;
	b=bQpsF4Vf/Yvoc/vzSLb9vvfctXnYxPQbZ3SgwP/Zac38VXpgaBNM7FwjtBsGgPgNXcG1CeBiNX8Mmw0IJJ9b/UKR0Cy7g2vSfyYNKRvcIu9s8CAq6tTNxnBaLM0NetmrSH8VpHglm7kdb6afgrt/IfmUDDDuiGWM29w1EvL8QVE=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.35,REQID:754fb0e3-56f5-461a-9f03-57ee60da2467,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:5d391d7,CLOUDID:a07ac6fb-ea85-4237-b98b-756276f80e05,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:
	NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 850c2de89f0a11eeba30773df0976c77-20231220
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw02.mediatek.com
	(envelope-from <kuan-ying.lee@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 168092599; Wed, 20 Dec 2023 15:36:42 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 20 Dec 2023 15:36:39 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 20 Dec 2023 15:36:39 +0800
From: Kuan-Ying Lee <Kuan-Ying.Lee@mediatek.com>
To: Matthias Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>
CC: <casper.li@mediatek.com>, <chinwen.chang@mediatek.com>,
	<qun-wei.lin@mediatek.com>, <linux-mm@kvack.org>,
	<akpm@linux-foundation.org>, Kuan-Ying Lee <Kuan-Ying.Lee@mediatek.com>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-mediatek@lists.infradead.org>
Subject: [PATCH] scripts: Fix no space expression between sp and offset
Date: Wed, 20 Dec 2023 15:36:28 +0800
Message-ID: <20231220073629.2658-1-Kuan-Ying.Lee@mediatek.com>
X-Mailer: git-send-email 2.18.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--1.838400-8.000000
X-TMASE-MatchedRID: +ngMWxkROpCWHmpvkeKJB7MjW/sniEQKQKuv8uQBDjq95d3486lhDSdV
	PZLj058XKso8TQS0K69nHbrFgUuD0ug9HcxTn+DoKaMQ6tw7oDJMkOX0Uoduubra7c58qofOo8W
	MkQWv6iXBcIE78YqRWo6HM5rqDwqtbSlBMyqqDUULV7pRjhdwXMMzFZKbl0jgifiQwpPzKTMSI/
	jO40Gt+CQqeQ5Qn5jx7ltWiLNaZPyWqC20cd7+1qT7trat8oNiwZBgUyJVEbl6Fw8/PpTMRaVvm
	iAyeA2kc5MSfkiJFI5QBJtcKcOYfpRMZUCEHkRt
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--1.838400-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: 429CEE084C7287DB87733FD72DAC4F7D8977E3FCA84B8E1BD170B1C2EBFD7C472000:8
X-MTK: N

When I use older version aarch64 objdump (2.24) to disassemble
aarch64 vmlinux, I get the result like below.
There is no space between sp and offset.

ffff800008010000 <dw_apb_ictl_handle_irq>:
ffff800008010000:       d503233f        hint    #0x19
ffff800008010004:       a9bc7bfd        stp     x29, x30, [sp,#-64]!
ffff800008010008:       90011e60        adrp    x0, ffff80000a3dc000 <num_ictlrs>
ffff80000801000c:       910003fd        mov     x29, sp
ffff800008010010:       a9025bf5        stp     x21, x22, [sp,#32]

When I use newer version aarch64 objdump (2.35), I get
the result like below.
There is a space between sp and offset.

ffff800008010000 <dw_apb_ictl_handle_irq>:
ffff800008010000:       d503233f        paciasp
ffff800008010004:       a9bc7bfd        stp     x29, x30, [sp, #-64]!
ffff800008010008:       90011e60        adrp    x0, ffff80000a3dc000 <num_ictlrs>
ffff80000801000c:       910003fd        mov     x29, sp
ffff800008010010:       a9025bf5        stp     x21, x22, [sp, #32]

Add no space support of regular expression for old version objdump.

Cc: Casper Li <casper.li@mediatek.com>
Signed-off-by: Kuan-Ying Lee <Kuan-Ying.Lee@mediatek.com>
---
 scripts/checkstack.pl | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/checkstack.pl b/scripts/checkstack.pl
index b70482a95088..a0e25a8830b4 100755
--- a/scripts/checkstack.pl
+++ b/scripts/checkstack.pl
@@ -56,7 +56,7 @@ my (@stack, $re, $dre, $sub, $x, $xs, $funcre, $min_stack);
 	if ($arch =~ '^(aarch|arm)64$') {
 		#ffffffc0006325cc:       a9bb7bfd        stp     x29, x30, [sp, #-80]!
 		#a110:       d11643ff        sub     sp, sp, #0x590
-		$re = qr/^.*stp.*sp, \#-([0-9]{1,8})\]\!/o;
+		$re = qr/^.*stp.*sp, ?\#-([0-9]{1,8})\]\!/o;
 		$dre = qr/^.*sub.*sp, sp, #(0x$x{1,8})/o;
 	} elsif ($arch eq 'arm') {
 		#c0008ffc:	e24dd064	sub	sp, sp, #100	; 0x64
-- 
2.18.0



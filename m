Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7EDC7DEC3D
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 06:26:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348521AbjKBF0b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 01:26:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbjKBF03 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 01:26:29 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FD4F112;
        Wed,  1 Nov 2023 22:26:19 -0700 (PDT)
X-UUID: 4f114c72794011ee8051498923ad61e6-20231102
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=1RoP4Vi00/8tDFrasFZxtTo4Mo0n2O6LVcCZZtdc2rI=;
        b=puTlogJUUk98bS7tpHyHOM2+5IUsrQMf/ZY7OaT3aJO58dvaL4b4SYGQXzEz/9s+ByIph61RasynTT6c2JMZ9iHWLqRXyrUM++Hu5ZNM7uxk6YnPZ+IhiAKcXfjF4+DPpc5lZX4f6fyoQL0aTReeQzw4emsfGEVdfQXbjrECVVQ=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.33,REQID:4c68868e-b5f4-41bc-8d4c-0314c879d2b0,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:364b77b,CLOUDID:df13ec94-10ce-4e4b-85c2-c9b5229ff92b,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 4f114c72794011ee8051498923ad61e6-20231102
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
        (envelope-from <naomi.chu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 165308297; Thu, 02 Nov 2023 13:26:00 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 2 Nov 2023 13:25:58 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 2 Nov 2023 13:25:58 +0800
From:   <naomi.chu@mediatek.com>
To:     <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
CC:     <wsd_upstream@mediatek.com>, <peter.wang@mediatek.com>,
        <casper.li@mediatek.com>, <powen.kao@mediatek.com>,
        <alice.chao@mediatek.com>, <naomi.chu@mediatek.com>,
        <chun-hung.wu@mediatek.com>, <cc.chou@mediatek.com>,
        <eddie.huang@mediatek.com>
Subject: [PATCH v3 0/1] ufs: core: Expand MCQ queue slot to DeviceQueueDepth + 1
Date:   Thu, 2 Nov 2023 13:24:23 +0800
Message-ID: <20231102052426.12006-1-naomi.chu@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--1.335900-8.000000
X-TMASE-MatchedRID: bN0Ga+Wo/7iRD9Q6y2Li+hA0LjlGWpxLd0/IMHz0evnJV4VcizYObZas
        fA8Y/RCFeIvqE1htygk76TIx5LCnC1ubwQYL9vqCKaMQ6tw7oDJ9LQinZ4QefCP/VFuTOXUTl7B
        AyKmXjyPkwjHXXC/4I66NVEWSRWybUIm6NhAOqkXAI9vyxo2Fc12CDqjVS1NgPVnDUW5HaBsKIa
        lieSFYk3NkqN00n/6LLBahYPfvRa5rNSfbLIP9qTBkQdcr43gMjofsMjQaxVwyYjbiqIQ3Csykh
        tyXcigD6rVdgBjDT2r1nXJavJVNag==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--1.335900-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: 44CC1505BBD99239C072374F13D27B55828234EE079F1568F566B5B57503815E2000:8
X-MTK:  N
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Naomi Chu <naomi.chu@mediatek.com>

Expand the MCQ queue slots to comply with the UFSHCI 4.0 specification,
enabling host controllers to fully utilize the MCQ queue slots.

v2 -> v3
- Add patch description that why this patch is necessary

v1 -> v2
- Remove QUIRK_MCQ_EXPAND_QUEUE_SLOT quirk and make the change for all host controllers

v1
- Support quirk for host controllers not able to distinguish queue full or empty

Naomi Chu (1):
  ufs: core: Expand MCQ queue slot to DeviceQueueDepth + 1

 drivers/ufs/core/ufs-mcq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
2.18.0


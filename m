Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24FB27FCF60
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 07:52:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377039AbjK2Gvw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 01:51:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231393AbjK2Gvr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 01:51:47 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D31410F0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 22:51:52 -0800 (PST)
X-UUID: c3517d028e8311eea33bb35ae8d461a2-20231129
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=na6Um5bZE/lrzzyPLjzBP7E/V75yxzke3oahh4HsVvM=;
        b=ehmBPH6bcijIl4lJVtyGEm0Y8rxbngAzJUUvW00bdUx0WO06cFSmvDDQvtEQ0wMg+h5+3775wE3gYHMPBNriIbY/jr/mjAwgQ6wKXGyRzpue4WL3O2KDqQsPSyIUiyKMVKrfOs5kKqdRFWZ3wRS4jW9emluZSJQGP81I6iRcpo0=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.34,REQID:d9b25bc2-f4ee-4621-af13-ed8314a73867,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:abefa75,CLOUDID:c5e53273-1bd3-4f48-b671-ada88705968c,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:
        NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: c3517d028e8311eea33bb35ae8d461a2-20231129
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
        (envelope-from <kuan-ying.lee@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 267744989; Wed, 29 Nov 2023 14:51:46 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 29 Nov 2023 14:51:44 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 29 Nov 2023 14:51:44 +0800
From:   Kuan-Ying Lee <Kuan-Ying.Lee@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
CC:     <casper.li@mediatek.com>, <chinwen.chang@mediatek.com>,
        <qun-wei.lin@mediatek.com>, <linux-mm@kvack.org>,
        <akpm@linux-foundation.org>,
        Kuan-Ying Lee <Kuan-Ying.Lee@mediatek.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
Subject: [PATCH v2 0/3] Fix GDB commands error
Date:   Wed, 29 Nov 2023 14:51:37 +0800
Message-ID: <20231129065142.13375-1-Kuan-Ying.Lee@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--4.712100-8.000000
X-TMASE-MatchedRID: Xtk5aVnIUKpBEeXXYJxA3huZoNKc6pl+MVx/3ZYby7/jud2x7TPVt0pf
        KXQfMT86VUTnw0FQboc7/+RrYRAMW+g9HcxTn+DoP0HVIeixJdCuiRuR9mCaukYvSDWdWaRhbCp
        JOk5WRE/jCeE5v4lH5IAy6p60ZV62JW+71yEen6Zq8/xv2Um1avoLR4+zsDTtuVfc976pNypM1p
        XMu+IS/QAcUADeXmG7puWh80OThW5LFvCB7sGQg6YT3rx3c0p4nWgPrCj7FiKrfaTjXvF3NsapL
        HI0FIIU2WlY2vGr17l2a1GxGYqQBIlk9PZkM+7M8PZB/MwMuOGjrlS58dwO+A==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--4.712100-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: 80D5F2A9B89B0C5D38680BD326EF260A91A1AF04B08E5F621849C72AC8F48DC82000:8
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset fix some issues of gdb command.

Patch 1:
 - Fix lx-ps command error
Patch 2:
 - Fix stackdepot usage error
Patch 3:
 - Remove exception handling
 - Refine the printing format

---
V1->V2:
 - Remove unnecessary variable. (Thanks Oleg)
 - Refine commit message.

Kuan-Ying Lee (3):
  scripts/gdb/tasks: Fix lx-ps command error
  scripts/gdb/stackdepot: Rename pool_index to pools_num
  scripts/gdb: Remove exception handling and refine print format

 scripts/gdb/linux/page_owner.py | 58 ++++++++++++++-------------------
 scripts/gdb/linux/slab.py       |  3 +-
 scripts/gdb/linux/stackdepot.py |  6 ++--
 scripts/gdb/linux/tasks.py      | 18 ++++------
 4 files changed, 36 insertions(+), 49 deletions(-)

-- 
2.18.0


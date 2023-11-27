Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B3A37F9AB3
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 08:19:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230020AbjK0HFT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 02:05:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjK0HFQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 02:05:16 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E97F4133
        for <linux-kernel@vger.kernel.org>; Sun, 26 Nov 2023 23:05:18 -0800 (PST)
X-UUID: 4f332f068cf311ee8051498923ad61e6-20231127
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=NYKZdfMEZ8N9fLthqw1urmuNwplT4YFs5p5D6iB4J6Q=;
        b=EC7Qa0Ki5KIbmkklpYBf8JCkTVw7GbNx4ZYahGqkPDp5WY5B3JUG88YpwRFImEn8EoTNmoYWrszVWCNEtP5SGtqL/LULVNX6dRO49g6T/mdZUYL9fppM/7sFahcpNXnpoqHDF/CzDuVZYm7CMJWErNeRzy7yOrCH5TYfmmhZNWg=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.33,REQID:eda165ed-208f-4a28-a28e-bf5eac16fdf0,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:364b77b,CLOUDID:a2c01b73-1bd3-4f48-b671-ada88705968c,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:
        NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_ULN,TF_CID_SPAM_SNR
X-UUID: 4f332f068cf311ee8051498923ad61e6-20231127
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw02.mediatek.com
        (envelope-from <kuan-ying.lee@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1440168366; Mon, 27 Nov 2023 15:05:12 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 27 Nov 2023 15:05:10 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 27 Nov 2023 15:05:10 +0800
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
Subject: [PATCH 0/3] Fix GDB commands error
Date:   Mon, 27 Nov 2023 15:04:00 +0800
Message-ID: <20231127070404.4192-1-Kuan-Ying.Lee@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--1.823900-8.000000
X-TMASE-MatchedRID: 6efVvalF+GhBEeXXYJxA3huZoNKc6pl+MVx/3ZYby7/jud2x7TPVt/vO
        +ii1kEU9/pKwAK6MbUroNOYPho+2K3kXYHF7PdsXtxwPIeWtDDlKPIx+MJF9o5soi2XrUn/J8m+
        hzBStansUGm4zriL0oQtuKBGekqUpOlxBO2IcOBZcKP1ilp4RwRIWchrxYUogoPAkwJJUDVxm9A
        2MjQXQP/PURVwGjI4MF7+B6EXI4pUSA+HPw22nHoCBf9PLMTwKuFgIMLB2+FfBkGBTIlURuXoXD
        z8+lMxFpW+aIDJ4DaRzkxJ+SIkUjmncuUSUEdOX
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--1.823900-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: 3BFE860726066AA1B74EC332893E7866F20F00E093DBA136B8A9977664D1C52E2000:8
X-MTK:  N
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        RDNS_NONE,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNPARSEABLE_RELAY autolearn=no autolearn_force=no version=3.4.6
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
This patchset is based on linux-next-20231127.

Kuan-Ying Lee (3):
  scripts/gdb/tasks: Fix lx-ps command error
  scripts/gdb/stackdepot: Rename pool_index_cached to pools_num
  scripts/gdb: Remove exception handling and refine print format

 scripts/gdb/linux/page_owner.py | 58 ++++++++++++++-------------------
 scripts/gdb/linux/slab.py       |  3 +-
 scripts/gdb/linux/stackdepot.py |  6 ++--
 scripts/gdb/linux/tasks.py      | 12 +++----
 4 files changed, 33 insertions(+), 46 deletions(-)

-- 
2.18.0


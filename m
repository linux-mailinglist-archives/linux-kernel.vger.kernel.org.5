Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70C097FCF61
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 07:52:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377055AbjK2Gvy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 01:51:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231408AbjK2Gvs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 01:51:48 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 232B31735
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 22:51:53 -0800 (PST)
X-UUID: c42dc0fa8e8311ee8051498923ad61e6-20231129
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=n+R9PEoL0ecclUC6WsOy0WMmNQrV/Y6UQqst6Epr4yM=;
        b=V0o9TPNJcFSFmjfQ2E72V0bm5mC/33n9Mw1MKA06neCxe/rM9T/05c1qVE0NH8RH5Tk0cIWM1j1CxM1E1zIdIRz21Exp7YkQ2kREofcQSZ/nUF2Fi8sgAWkDLnzkhgMfmJjZI65y0l7gXisSX5Za/99TSsyDZECcE7nKQsw/TpM=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.34,REQID:93ea0bca-fa87-4db2-a888-103d912647ad,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:abefa75,CLOUDID:720014fd-4a48-46e2-b946-12f04f20af8c,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:
        NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: c42dc0fa8e8311ee8051498923ad61e6-20231129
Received: from mtkmbs14n1.mediatek.inc [(172.21.101.75)] by mailgw02.mediatek.com
        (envelope-from <kuan-ying.lee@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 395528039; Wed, 29 Nov 2023 14:51:47 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 29 Nov 2023 14:51:46 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 29 Nov 2023 14:51:46 +0800
From:   Kuan-Ying Lee <Kuan-Ying.Lee@mediatek.com>
To:     Jan Kiszka <jan.kiszka@siemens.com>,
        Kieran Bingham <kbingham@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
CC:     <casper.li@mediatek.com>, <chinwen.chang@mediatek.com>,
        <qun-wei.lin@mediatek.com>, <linux-mm@kvack.org>,
        <akpm@linux-foundation.org>,
        Kuan-Ying Lee <Kuan-Ying.Lee@mediatek.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
Subject: [PATCH v2 2/3] scripts/gdb/stackdepot: Rename pool_index to pools_num
Date:   Wed, 29 Nov 2023 14:51:39 +0800
Message-ID: <20231129065142.13375-3-Kuan-Ying.Lee@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20231129065142.13375-1-Kuan-Ying.Lee@mediatek.com>
References: <20231129065142.13375-1-Kuan-Ying.Lee@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--0.835400-8.000000
X-TMASE-MatchedRID: +ngMWxkROpBo3s9tP0IpFpA6S0SjvcYU2D9FbDg9BP4gOnjvjQ5gMV6Z
        DDGofYWNjwQarLbSitQRs1kezRVUMnAd/ISL1gqdA9lly13c/gFKKWJchzA/cTrJEXlYPBg2o8W
        MkQWv6iXBcIE78YqRWo6HM5rqDwqt8qdBHO1HlsES+YTonSEiTt0PqFWU/tup5zAcFqh011MOMd
        /q/g+8AskTTa0GhEGXTIXOwb8AX0MtexYu1hdC+zRYUfCeJoD9wZBgUyJVEbl6Fw8/PpTMRaVvm
        iAyeA2kc5MSfkiJFI5p3LlElBHTlw==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--0.835400-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: 7739E709B4D66CEF45A0A4020D64F3EA433CEF59176414BBAB9CD3D85FE3845F2000:8
X-MTK:  N
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,RDNS_NONE,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After stackdepot evicting support patchset[1], we rename
pool_index to pools_num.

To avoid from the below issue, we rename consistently in
gdb scripts.

Python Exception <class 'gdb.error'>: No symbol "pool_index" in current
context.
Error occurred in Python: No symbol "pool_index" in current context.

[1] https://lore.kernel.org/linux-mm/cover.1700502145.git.andreyknvl@google.com/
Cc: Andrey Konovalov <andreyknvl@google.com>
Signed-off-by: Kuan-Ying Lee <Kuan-Ying.Lee@mediatek.com>
---
 scripts/gdb/linux/stackdepot.py | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/scripts/gdb/linux/stackdepot.py b/scripts/gdb/linux/stackdepot.py
index 047d329a6a12..0281d9de4b7c 100644
--- a/scripts/gdb/linux/stackdepot.py
+++ b/scripts/gdb/linux/stackdepot.py
@@ -25,10 +25,10 @@ def stack_depot_fetch(handle):
     handle_parts_t = gdb.lookup_type("union handle_parts")
     parts = handle.cast(handle_parts_t)
     offset = parts['offset'] << DEPOT_STACK_ALIGN
-    pool_index_cached = gdb.parse_and_eval('pool_index')
+    pools_num = gdb.parse_and_eval('pools_num')
 
-    if parts['pool_index'] > pool_index_cached:
-        gdb.write("pool index %d out of bounds (%d) for stack id 0x%08x\n" % (parts['pool_index'], pool_index_cached, handle))
+    if parts['pool_index'] > pools_num:
+        gdb.write("pool index %d out of bounds (%d) for stack id 0x%08x\n" % (parts['pool_index'], pools_num, handle))
         return gdb.Value(0), 0
 
     stack_pools = gdb.parse_and_eval('stack_pools')
-- 
2.18.0


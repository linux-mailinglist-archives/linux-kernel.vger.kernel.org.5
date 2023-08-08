Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0F50773D95
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 18:20:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232119AbjHHQTt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 12:19:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232400AbjHHQSD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 12:18:03 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A3726A77;
        Tue,  8 Aug 2023 08:48:36 -0700 (PDT)
X-UUID: d824fe3c35c511ee9cb5633481061a41-20230808
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=of+Yq84+TCPrRdlX79cImaBtdd9LrIudC8T+juj2xpM=;
        b=HbqK8pPdZoJOnHhDY/nJ7xMYe/pfAjXTB82e027MUDyFkgfO+wWgJ+EvzpC9v1zDaVSkRP55FrN9UaalAMgz2gbBeNlDxdA/XavIlRb9we9yGSGGcQVuqUjaeZ4jAhupeccHExHXW4LJlIPL7qumh7+SmP+Qkc6YMXKEyu9rMhI=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.31,REQID:df494657-af38-46eb-b513-6039c93ef14b,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:95
X-CID-INFO: VERSION:1.1.31,REQID:df494657-af38-46eb-b513-6039c93ef14b,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACTION
        :quarantine,TS:95
X-CID-META: VersionHash:0ad78a4,CLOUDID:d93a04a1-0933-4333-8d4f-6c3c53ebd55b,B
        ulkID:230808163036TTTRMJO3,BulkQuantity:1,Recheck:0,SF:48|38|29|28|17|19,T
        C:nil,Content:0,EDM:-3,IP:nil,URL:11|1,File:nil,Bulk:40,QS:nil,BEC:nil,COL
        :0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_FSD,TF_CID_SPAM_ULN,TF_CID_SPAM_SNR,TF_CID_SPAM_SDM,
        TF_CID_SPAM_ASC,TF_CID_SPAM_FAS
X-UUID: d824fe3c35c511ee9cb5633481061a41-20230808
Received: from mtkmbs14n1.mediatek.inc [(172.21.101.75)] by mailgw01.mediatek.com
        (envelope-from <kuan-ying.lee@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 53193084; Tue, 08 Aug 2023 16:30:34 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 8 Aug 2023 16:30:33 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 8 Aug 2023 16:30:33 +0800
From:   Kuan-Ying Lee <Kuan-Ying.Lee@mediatek.com>
To:     Jan Kiszka <jan.kiszka@siemens.com>,
        Kieran Bingham <kbingham@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
CC:     <chinwen.chang@mediatek.com>, <qun-wei.lin@mediatek.com>,
        <linux-mm@kvack.org>, <linux-modules@vger.kernel.org>,
        <casper.li@mediatek.com>, <akpm@linux-foundation.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Kuan-Ying Lee <Kuan-Ying.Lee@mediatek.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>
Subject: [PATCH v2 3/8] scripts/gdb/utils: add common type usage
Date:   Tue, 8 Aug 2023 16:30:13 +0800
Message-ID: <20230808083020.22254-4-Kuan-Ying.Lee@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20230808083020.22254-1-Kuan-Ying.Lee@mediatek.com>
References: <20230808083020.22254-1-Kuan-Ying.Lee@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since we often use 'unsigned long', 'size_t', 'usigned int'
and 'struct page', we add these common types to utils.

Signed-off-by: Kuan-Ying Lee <Kuan-Ying.Lee@mediatek.com>
---
 scripts/gdb/linux/utils.py | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/scripts/gdb/linux/utils.py b/scripts/gdb/linux/utils.py
index 9f44df13761e..7d5278d815fa 100644
--- a/scripts/gdb/linux/utils.py
+++ b/scripts/gdb/linux/utils.py
@@ -35,12 +35,32 @@ class CachedType:
 
 
 long_type = CachedType("long")
+ulong_type = CachedType("unsigned long")
+uint_type = CachedType("unsigned int")
 atomic_long_type = CachedType("atomic_long_t")
+size_t_type = CachedType("size_t")
+struct_page_type = CachedType("struct page")
+
+def get_uint_type():
+    global uint_type
+    return uint_type.get_type()
+
+def get_page_type():
+    global struct_page_type
+    return struct_page_type.get_type()
 
 def get_long_type():
     global long_type
     return long_type.get_type()
 
+def get_ulong_type():
+    global ulong_type
+    return ulong_type.get_type()
+
+def get_size_t_type():
+    global size_t_type
+    return size_t_type.get_type()
+
 def offset_of(typeobj, field):
     element = gdb.Value(0).cast(typeobj)
     return int(str(element[field].address).split()[0], 16)
-- 
2.18.0


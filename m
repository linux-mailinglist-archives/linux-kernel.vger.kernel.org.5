Return-Path: <linux-kernel+bounces-56156-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F3FCE84C6C4
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 09:59:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A00BD285BD5
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 08:59:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20413208D6;
	Wed,  7 Feb 2024 08:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="lilmk+5/"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E852208BE
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 08:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707296357; cv=none; b=pVyZL9g6KUiF4YR2c0RiA4imNOk+arA4QgUvQ07J6ujAi+N5uRR/WMEe/D3YdSxwVU9T8lyi3LQ2LaXQugdhTYTfnp9Bb/LuV5aB1YfHbbdhT4cx26tsnsVCLBcBGDXbVSqf4rPQiAAev3yuoSmbi4kHE1yorpTrR615padF5rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707296357; c=relaxed/simple;
	bh=EbTp+Rdac+oY15jIhno4NYNkI0JeBaIHpXq2+JKH4tk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=V8DCag56Gu9ALoDxefD/coIXidVOAsJ9cnDxxg71YDMkQnNlnA3kucXEYMjRsyx/5hyTNZ0/6lzQnlu3CpFdwbhvLJr/xenZqFUbjm9IiE9RDU2RWT9qyVICIhs38wXR/8I+GQpEJPGYWQd3eva8jTQ586IpSG3fnMLgqCP/A3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=lilmk+5/; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 23f61056c59711eea2298b7352fd921d-20240207
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=M+kTxpzDu2kDUAi4jAk/bznBJUbRFLEVKzbdXxscehs=;
	b=lilmk+5/mLqqqHRjzMEs5kXL/gY7vxjYUbQ8CqLB8dplwmOZhNvdSdOgJLmqALKEGvgEMEuh2ahqQxf8SWisDPcGQORI8Iq1wZ99n3EaHcWVD3RWOH3jixKUS7qfoKMxicReaVZSXaJ1JxNrEn3EUGsHYG4lagQxF0NpJGjjOIU=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:d75d8ec7-7320-4654-ba09-99b1183feff6,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6f543d0,CLOUDID:cdca9cfe-c16b-4159-a099-3b9d0558e447,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 23f61056c59711eea2298b7352fd921d-20240207
Received: from mtkmbs14n1.mediatek.inc [(172.21.101.75)] by mailgw02.mediatek.com
	(envelope-from <kuan-ying.lee@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 2104500452; Wed, 07 Feb 2024 16:59:02 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 7 Feb 2024 16:58:58 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 7 Feb 2024 16:58:58 +0800
From: Kuan-Ying Lee <Kuan-Ying.Lee@mediatek.com>
To: Jan Kiszka <jan.kiszka@siemens.com>, Kieran Bingham <kbingham@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>
CC: <casper.li@mediatek.com>, <chinwen.chang@mediatek.com>,
	<qun-wei.lin@mediatek.com>, <linux-mm@kvack.org>,
	<akpm@linux-foundation.org>, <urezki@gmail.com>, Kuan-Ying Lee
	<Kuan-Ying.Lee@mediatek.com>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>
Subject: [PATCH] scripts/gdb/vmalloc: fix vmallocinfo error
Date: Wed, 7 Feb 2024 16:58:51 +0800
Message-ID: <20240207085856.11190-1-Kuan-Ying.Lee@mediatek.com>
X-Mailer: git-send-email 2.18.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--3.540600-8.000000
X-TMASE-MatchedRID: BrNJR/3XBtYgNXYDo2rRhjTR2TFg0xG3MVx/3ZYby7+QxjD98JXG4+h5
	+ziVqzh1jwQarLbSitQRs1kezRVUMnAd/ISL1gqdj1RGQOB2VvlMkOX0UoduuU4K0IMk2m3G9pj
	ehf9ti8tk9BhA+RcEjMcIK6S4JS2iHN0r1kHymECjrlYm3WTU730tCKdnhB589yM15V5aWpj6C0
	ePs7A07ba607moR85RnkXbdvwlTfPByDSHDuWGW2ASvsZfW+OWOo0k1o6+bTZ4Q/FXPcvQ5Xo3o
	hZ25BJZsdQa7QcOV1BxvuJG1fpOeqHee+3ZfiRJSZrfNhP3sgUBh9AgBSEFrJm+YJspVvj2xkvr
	HlT8euI+kK598Yf3Mg==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--3.540600-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: 6999A9595D8F99E6A1C2B5598210605692699934082BAD3D5FB294C0F38FC4AA2000:8
X-MTK: N

We met the gdb vmallocinfo issue as following.

(gdb) lx-vmallocinfo
Python Exception <class 'gdb.error'>: No symbol "vmap_area_list" in current context.
Error occurred in Python: No symbol "vmap_area_list" in current context.

Since Mitigate a vmap lock contention patchset [1], we
remove the vmap_area_list.

We need to use vmap_nodes to iterate all vmallocinfo.

[1] https://lore.kernel.org/linux-mm/20240102184633.748113-1-urezki@gmail.com/

Signed-off-by: Kuan-Ying Lee <Kuan-Ying.Lee@mediatek.com>
Cc: Casper Li <casper.li@mediatek.com>
---
 scripts/gdb/linux/vmalloc.py | 56 +++++++++++++++++++-----------------
 1 file changed, 29 insertions(+), 27 deletions(-)

diff --git a/scripts/gdb/linux/vmalloc.py b/scripts/gdb/linux/vmalloc.py
index d3c8a0274d1e..803f17371052 100644
--- a/scripts/gdb/linux/vmalloc.py
+++ b/scripts/gdb/linux/vmalloc.py
@@ -29,32 +29,34 @@ class LxVmallocInfo(gdb.Command):
         if not constants.LX_CONFIG_MMU:
             raise gdb.GdbError("Requires MMU support")
 
-        vmap_area_list = gdb.parse_and_eval('vmap_area_list')
-        for vmap_area in lists.list_for_each_entry(vmap_area_list, vmap_area_ptr_type, "list"):
-            if not vmap_area['vm']:
-                gdb.write("0x%x-0x%x %10d vm_map_ram\n" % (vmap_area['va_start'], vmap_area['va_end'],
-                    vmap_area['va_end'] - vmap_area['va_start']))
-                continue
-            v = vmap_area['vm']
-            gdb.write("0x%x-0x%x %10d" % (v['addr'], v['addr'] + v['size'], v['size']))
-            if v['caller']:
-                gdb.write(" %s" % str(v['caller']).split(' ')[-1])
-            if v['nr_pages']:
-                gdb.write(" pages=%d" % v['nr_pages'])
-            if v['phys_addr']:
-                gdb.write(" phys=0x%x" % v['phys_addr'])
-            if v['flags'] & constants.LX_VM_IOREMAP:
-                gdb.write(" ioremap")
-            if v['flags'] & constants.LX_VM_ALLOC:
-                gdb.write(" vmalloc")
-            if v['flags'] & constants.LX_VM_MAP:
-                gdb.write(" vmap")
-            if v['flags'] & constants.LX_VM_USERMAP:
-                gdb.write(" user")
-            if v['flags'] & constants.LX_VM_DMA_COHERENT:
-                gdb.write(" dma-coherent")
-            if is_vmalloc_addr(v['pages']):
-                gdb.write(" vpages")
-            gdb.write("\n")
+        nr_vmap_nodes = gdb.parse_and_eval('nr_vmap_nodes')
+        for i in range(0, nr_vmap_nodes):
+            vn = gdb.parse_and_eval('&vmap_nodes[%d]' % i)
+            for vmap_area in lists.list_for_each_entry(vn['busy']['head'], vmap_area_ptr_type, "list"):
+                if not vmap_area['vm']:
+                    gdb.write("0x%x-0x%x %10d vm_map_ram\n" % (vmap_area['va_start'], vmap_area['va_end'],
+                        vmap_area['va_end'] - vmap_area['va_start']))
+                    continue
+                v = vmap_area['vm']
+                gdb.write("0x%x-0x%x %10d" % (v['addr'], v['addr'] + v['size'], v['size']))
+                if v['caller']:
+                    gdb.write(" %s" % str(v['caller']).split(' ')[-1])
+                if v['nr_pages']:
+                    gdb.write(" pages=%d" % v['nr_pages'])
+                if v['phys_addr']:
+                    gdb.write(" phys=0x%x" % v['phys_addr'])
+                if v['flags'] & constants.LX_VM_IOREMAP:
+                    gdb.write(" ioremap")
+                if v['flags'] & constants.LX_VM_ALLOC:
+                    gdb.write(" vmalloc")
+                if v['flags'] & constants.LX_VM_MAP:
+                    gdb.write(" vmap")
+                if v['flags'] & constants.LX_VM_USERMAP:
+                    gdb.write(" user")
+                if v['flags'] & constants.LX_VM_DMA_COHERENT:
+                    gdb.write(" dma-coherent")
+                if is_vmalloc_addr(v['pages']):
+                    gdb.write(" vpages")
+                gdb.write("\n")
 
 LxVmallocInfo()
-- 
2.18.0



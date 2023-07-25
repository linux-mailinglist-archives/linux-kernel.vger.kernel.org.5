Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45A58760F69
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 11:37:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233326AbjGYJhG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 05:37:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233245AbjGYJgq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 05:36:46 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CE4C2724;
        Tue, 25 Jul 2023 02:35:32 -0700 (PDT)
X-UUID: 9179c1fe2ace11eeb20a276fd37b9834-20230725
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=C00yyw7N4UE3CQr7IQj99NXJeOHNCH/zFRWE/gdHGS8=;
        b=FG8WaoZJmjZ0ymIWxlWPaBDqgnjO1quo6vgPCoaMZ4oxt/6e/KyxLLzgAOGyRVnnyKNzu4I6cjrPLsWIO7e46bMm6EoOySSmmZ4Nz0ZD2IzK6Ct/E1vKp2pgeSZj51KAGSHks2gLVm8q+GJg+L+de0vr5nkxRhbvN0dS+EPSfYk=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.29,REQID:9720b3ba-0411-467a-bb30-3b40ca77daee,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:e7562a7,CLOUDID:36d0c3b3-a467-4aa9-9e04-f584452e3794,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:
        NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 9179c1fe2ace11eeb20a276fd37b9834-20230725
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw02.mediatek.com
        (envelope-from <kuan-ying.lee@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 919240075; Tue, 25 Jul 2023 17:35:18 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 25 Jul 2023 17:35:17 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 25 Jul 2023 17:35:17 +0800
From:   Kuan-Ying Lee <Kuan-Ying.Lee@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
CC:     <chinwen.chang@mediatek.com>, <qun-wei.lin@mediatek.com>,
        <linux-mm@kvack.org>, <linux-modules@vger.kernel.org>,
        <casper.li@mediatek.com>, <akpm@linux-foundation.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Kuan-Ying Lee <Kuan-Ying.Lee@mediatek.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>
Subject: [PATCH 0/8] Add GDB memory helper commands
Date:   Tue, 25 Jul 2023 17:34:50 +0800
Message-ID: <20230725093458.30064-1-Kuan-Ying.Lee@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,RDNS_NONE,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I've created some GDB commands I think useful when I debug
some memory issues and kernel module issue.

For memory issue, we would like to get slabinfo, slabtrace,
page_owner and vmallocinfo to debug the memory issues.

For module issue, we would like to query kernel module name
when we get a module text address and load module
symbol by specific path.

This patchset is based on v6.5-rc3.

Patch 1-2:
 - Add kernel module releated command.
Patch 3-5:
 - Prepares for the memory-releated command.
Patch 6-8:
 - Add memory-related commands.

Kuan-Ying Lee (8):
  scripts/gdb/symbols: add specific ko module load command
  scripts/gdb/modules: add get module text support
  scripts/gdb/utils: add common type usage
  scripts/gdb/aarch64: add aarch64 page operation helper commands and
    configs
  scripts/gdb/stackdepot: Add stackdepot support
  scripts/gdb/page_owner: add page owner support
  scripts/gdb/slab: Add slab support
  scripts/gdb/vmalloc: add vmallocinfo support

 scripts/gdb/linux/constants.py.in |  59 +++
 scripts/gdb/linux/mm.py           | 579 +++++++++++++++++++-----------
 scripts/gdb/linux/modules.py      |  32 +-
 scripts/gdb/linux/page_owner.py   | 189 ++++++++++
 scripts/gdb/linux/pgtable.py      | 222 ++++++++++++
 scripts/gdb/linux/slab.py         | 322 +++++++++++++++++
 scripts/gdb/linux/stackdepot.py   |  54 +++
 scripts/gdb/linux/symbols.py      |  23 +-
 scripts/gdb/linux/utils.py        |  20 ++
 scripts/gdb/linux/vmalloc.py      |  56 +++
 scripts/gdb/vmlinux-gdb.py        |   7 +-
 11 files changed, 1356 insertions(+), 207 deletions(-)
 create mode 100644 scripts/gdb/linux/page_owner.py
 create mode 100644 scripts/gdb/linux/pgtable.py
 create mode 100644 scripts/gdb/linux/slab.py
 create mode 100644 scripts/gdb/linux/stackdepot.py
 create mode 100644 scripts/gdb/linux/vmalloc.py

-- 
2.18.0


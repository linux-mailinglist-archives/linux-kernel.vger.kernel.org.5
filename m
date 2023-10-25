Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1EE57D65EB
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 10:57:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233863AbjJYI5c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 04:57:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232691AbjJYI5a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 04:57:30 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9776BB3;
        Wed, 25 Oct 2023 01:57:22 -0700 (PDT)
X-UUID: 7e449328731411ee8051498923ad61e6-20231025
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=5zkch3mSEJZ0E9AdlA4GQWgLG+OEFfNA8pOLGU7VfLY=;
        b=giOou+BurqmiI5tLpdca/H8HEfU716IzOYKEEBMWAMSyTjbIOo1HwixBAqct9ZowU6xpJDY/gkebwVVIHdOfTjJD31WQz0/2CY77RC+lC6eKQXISJiPn1Lr7ELZlSGygIBZs03Wg3f9EVYV5/WQWKyd11kREOIBUXxx03QssO8Y=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.32,REQID:94bcef1d-83a3-4e05-8dbf-a1707696cf07,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:5f78ec9,CLOUDID:9c8e9d94-10ce-4e4b-85c2-c9b5229ff92b,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 7e449328731411ee8051498923ad61e6-20231025
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
        (envelope-from <chun-hung.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1141831439; Wed, 25 Oct 2023 16:57:15 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 25 Oct 2023 16:57:12 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 25 Oct 2023 16:57:12 +0800
From:   Chun-Hung Wu <chun-hung.wu@mediatek.com>
To:     Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Can Guo <quic_cang@quicinc.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Asutosh Das <quic_asutoshd@quicinc.com>,
        "Bao D . Nguyen" <quic_nguyenb@quicinc.com>,
        Yang Li <yang.lee@linux.alibaba.com>,
        Eric Biggers <ebiggers@google.com>,
        Keoseong Park <keosung.park@samsung.com>,
        Arthur Simchaev <Arthur.Simchaev@wdc.com>
CC:     <wsd_upstream@mediatek.com>, <casper.li@mediatek.com>,
        <peter.wang@mediatek.com>, <powen.kao@mediatek.com>,
        <alice.chao@mediatek.com>, <naomi.chu@mediatek.com>,
        <cc.chou@mediatek.com>, <chaotian.jing@mediatek.com>,
        <jiajie.hao@mediatek.com>, <tun-yu.yu@mediatek.com>,
        <lin.gui@mediatek.com>, <eddie.huang@mediatek.com>,
        <qilin.tan@mediatek.com>, <linux-scsi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <kernel-team@android.com>,
        Chun-Hung Wu <chun-hung.wu@mediatek.com>
Subject: [PATCH v1 0/1] ufs: core: Add host quirk QUIRK_MCQ_EXPAND_QUEUE_SLOT
Date:   Wed, 25 Oct 2023 16:56:53 +0800
Message-ID: <20231025085656.10848-1-chun-hung.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--2.511800-8.000000
X-TMASE-MatchedRID: uajpMFX5fhcAb75z7qUG0lz+axQLnAVBK2i9pofGVSu6SmGkMbaxzqPF
        jJEFr+olKE0Je8DR/D4Qr/RhSnHzg90H8LFZNFG71sULACB0qRKUOL+zMbQzLC1Pjbl2IIImF+6
        oUWsfRNyCu9TcHpuLYi2cdJTMdLTMF0aD5ljt43pMcHZD6gqu7wxMjfifIXfowkvVoA11Twp+3B
        ndfXUhXQ==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--2.511800-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: 843DDFDE3226983DC684E2279F9EB70224AF7BBF85DA7A8D9AAA75B38B48E7E22000:8
X-MTK:  N
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RDNS_NONE,SPF_HELO_PASS,
        T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Support quirk for host controller not able to distinguish
queue full or empty.

Alice Chao (1):
  ufs: core: Add host quirk QUIRK_MCQ_EXPAND_QUEUE_SLOT

 drivers/ufs/core/ufs-mcq.c |  5 ++++-
 include/ufs/ufshcd.h       | 11 +++++++++++
 2 files changed, 15 insertions(+), 1 deletion(-)

-- 
2.18.0


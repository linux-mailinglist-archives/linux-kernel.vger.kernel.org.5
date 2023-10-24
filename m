Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4049C7D461E
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 05:51:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231986AbjJXDut (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 23:50:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232035AbjJXDuq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 23:50:46 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16B26A6
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 20:50:43 -0700 (PDT)
X-UUID: 7e5754ee722011eea33bb35ae8d461a2-20231024
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=wpm4TcIB3OYOcCxJa54HMVXQ69ZhCLq/f+kuj+mgEDk=;
        b=OLisONZAhE15Yk/OOpddBZ55G9gOYpuRkTjtM1fUGpvCqM/cf3jVqA4kyAdzANcRn7KdzIKtmweRBCEdtnskBgLZv2T/zvtAHF1g+TRDtjpG2sD9Ab39kULpLbdOVvuY5iUwPm4r1hOKM6G0AvM1Ddn9ujUfYmBO3YS6rmk5W1U=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.32,REQID:c9396c2f-5e5d-4c86-b1c9-3146a24e6c42,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:5f78ec9,CLOUDID:2ea58d94-10ce-4e4b-85c2-c9b5229ff92b,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 7e5754ee722011eea33bb35ae8d461a2-20231024
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw01.mediatek.com
        (envelope-from <maso.huang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 2072188800; Tue, 24 Oct 2023 11:50:37 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 24 Oct 2023 11:50:35 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 24 Oct 2023 11:50:35 +0800
From:   Maso Huang <maso.huang@mediatek.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
CC:     Maso Huang <maso.huang@mediatek.com>
Subject: [PATCH v2 0/3] ASoC: mediatek: Remove redundant code and add sample rate checker of MT7986 SoC
Date:   Tue, 24 Oct 2023 11:50:16 +0800
Message-ID: <20231024035019.11732-1-maso.huang@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--4.037400-8.000000
X-TMASE-MatchedRID: ND/xO4uap3TenZYssfD30BIRh9wkXSlFsEf8CpnIYtlg5Pw7hhnE1UvI
        Gy2vt/IyXOz3YkNtdKDmV8c8W4k5T0kjllSXrjtQFEUknJ/kEl5jFT88f69nG/oLR4+zsDTt9xS
        3mVzWUuCMx6OO8+QGvjdtq08NA0w6mvlaUfZ1z1xs9QJGDvYulKmvGJXOTdgth1Bd9dxlZGe4RR
        Kx95f7QvcQlY+HGebAB8W3VqlZP4YB/+VWccgI2XmVKZusLp922v9OjYWA2uMMswg45VMfPadst
        5iAforfVlxr1FJij9s=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--4.037400-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: 5C8626FAE56790049AE0ADA5E5774840D209DE1D7C0321B174A66BEE91DFBA6D2000:8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,UNPARSEABLE_RELAY
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes in v2:
 - devide v1 patch [1/2] into v2 [1/3] [2/3] with appropriate title and description
 - refine error log based on reviewer's suggestions [3/3]

1. Drop the remove callback of mt7986_wm8960.
2. Remove the mt7986_wm8960_priv structure
3. Add sample rate checker.
Patches are based on broonie tree "for-next" branch.

Maso Huang (3):
  ASoC: mediatek: mt7986: drop the remove callback of mt7986_wm8960
  ASoC: mediatek: mt7986: remove the mt7986_wm8960_priv structure
  ASoC: mediatek: mt7986: add sample rate checker

 sound/soc/mediatek/mt7986/mt7986-dai-etdm.c | 23 +++++++++--
 sound/soc/mediatek/mt7986/mt7986-wm8960.c   | 43 ++++++---------------
 2 files changed, 31 insertions(+), 35 deletions(-)

-- 
2.18.0


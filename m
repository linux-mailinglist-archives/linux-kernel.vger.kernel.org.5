Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DF9F7D2F28
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 11:56:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233378AbjJWJ4l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 05:56:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233609AbjJWJ4G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 05:56:06 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA7041BDC
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 02:55:14 -0700 (PDT)
X-UUID: 4157680e718a11eea33bb35ae8d461a2-20231023
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=Qmbr2w5tujfuurOZRA3SRLMQeRjiZeSosCGmD3RvDX0=;
        b=lelYArMj6Z8CYRXKqWwADfGZFFDv+nvM/JZBlhCGHlOy+uCCvI6nkZIL07jJwtkmqIjo5uL2zDB7gTt8Zd2Yp4+B3BB+9r1sIBmmCI/R18oOd0o19Wgtf+E6m7QE1j1ZpdEqkPndQy3CevCr9mGTOK9v9vt7jXdccUvhM3n1B+U=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.32,REQID:958110a5-7c95-4c0f-908d-d7c4d33ebd1e,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:5f78ec9,CLOUDID:ee12a9fb-4a48-46e2-b946-12f04f20af8c,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 4157680e718a11eea33bb35ae8d461a2-20231023
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
        (envelope-from <maso.huang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1612167485; Mon, 23 Oct 2023 17:55:11 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 23 Oct 2023 17:55:07 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 23 Oct 2023 17:55:07 +0800
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
Subject: [PATCH 0/2] ASoC: mediatek: Remove redundant code and add sample rate checker of MT7986 SoC
Date:   Mon, 23 Oct 2023 17:54:51 +0800
Message-ID: <20231023095453.4860-1-maso.huang@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--1.888400-8.000000
X-TMASE-MatchedRID: 1cUIhvZrMEAyRohotsnq51z+axQLnAVBojQrbrPpzzptJv7x/D93bILy
        KdE2c/PXKi8kfHJWoY+gVbxI8zQaQh8TzIzimOwP0C1sQRfQzEHEQdG7H66TyN+E/XGDLHcM5H4
        ky09s9NKNLGOuO04vodSYd3t+km3SiC7Dlcya3aYyzYzUVqX0RXmVKZusLp922v9OjYWA2uMMsw
        g45VMfPadst5iAforfVlxr1FJij9s=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--1.888400-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: 5C758EFB01D13D8E60F6A8BE080B9F24FB0F074251EB3EF620CBB287C29401A22000:8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,T_SPF_TEMPERROR,UNPARSEABLE_RELAY
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

1. Remove redundant remove function.
2. Add sample rate checker.
Patches are based on broonie tree "for-next" branch.

Maso Huang (2):
  ASoC: mediatek: mt7986: remove redundant remove function
  ASoC: mediatek: mt7986: add sample rate checker

 sound/soc/mediatek/mt7986/mt7986-dai-etdm.c | 22 +++++++++--
 sound/soc/mediatek/mt7986/mt7986-wm8960.c   | 43 ++++++---------------
 2 files changed, 30 insertions(+), 35 deletions(-)

-- 
2.18.0


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C565802F88
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 11:05:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231613AbjLDKEx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 05:04:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbjLDKEw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 05:04:52 -0500
Received: from smtp-relay-canonical-0.canonical.com (smtp-relay-canonical-0.canonical.com [185.125.188.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 250ADC4
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 02:04:58 -0800 (PST)
Received: from binli-P1G5.. (unknown [103.229.218.199])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 18D8E3F280;
        Mon,  4 Dec 2023 10:04:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1701684295;
        bh=gRcgEI7RGIHJ0Yu30p47NQQFOUT4LXqjIPSeJERS6Us=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=MjbGdsQdTZ3KeSHpFebs8fd9kAje64p2cWi3rQi2nKRAP46orKfWLvhZlhm2f0Yxq
         kzEWArjAc8cM/hn64olhf8MGcBKJKFL5clG4lh8fpCYyxgqpiLuBUi3zudVjraJgO7
         rSKBZFMdyuBQmjD6Y09u+6WdXPVgCb3Y2MwC6Q+fSO1ZedfjQLmgdeVMBM9Jz79RQP
         JwsF/CpCt8GxwKQbKiLPdgHiMrgbYdWhYpGTNzE1m/wvYrp/oKtwT7z3UjzpLsFCmF
         dKx3cTxuv5PBkjiCGMK2Iig7plXQ0d/0rR8f1hbrZdHbxZPUX36pSoBM99qSW3BTA7
         VG0VYCnDjbJtw==
From:   Bin Li <bin.li@canonical.com>
To:     tiwai@suse.com
Cc:     kailang@realtek.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, aaron.ma@canonical.com,
        libin.charles@gmail.com
Subject: [PATCH] ALSA: hda/realtek: Enable headset on Lenovo M90 Gen5
Date:   Mon,  4 Dec 2023 18:04:50 +0800
Message-Id: <20231204100450.642783-1-bin.li@canonical.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Lenovo M90 Gen5 is equipped with ALC897, and it needs
ALC897_FIXUP_HEADSET_MIC_PIN quirk to make its headset mic work.

Signed-off-by: Bin Li <bin.li@canonical.com>
---
 sound/pci/hda/patch_realtek.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index f9ddacfd920e..08ed008a63a4 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -12196,6 +12196,7 @@ static const struct snd_pci_quirk alc662_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x17aa, 0x32f7, "Lenovo ThinkCentre M90", ALC897_FIXUP_HEADSET_MIC_PIN),
 	SND_PCI_QUIRK(0x17aa, 0x3321, "Lenovo ThinkCentre M70 Gen4", ALC897_FIXUP_HEADSET_MIC_PIN),
 	SND_PCI_QUIRK(0x17aa, 0x331b, "Lenovo ThinkCentre M90 Gen4", ALC897_FIXUP_HEADSET_MIC_PIN),
+	SND_PCI_QUIRK(0x17aa, 0x3364, "Lenovo ThinkCentre M90 Gen5", ALC897_FIXUP_HEADSET_MIC_PIN),
 	SND_PCI_QUIRK(0x17aa, 0x3742, "Lenovo TianYi510Pro-14IOB", ALC897_FIXUP_HEADSET_MIC_PIN2),
 	SND_PCI_QUIRK(0x17aa, 0x38af, "Lenovo Ideapad Y550P", ALC662_FIXUP_IDEAPAD),
 	SND_PCI_QUIRK(0x17aa, 0x3a0d, "Lenovo Ideapad Y550", ALC662_FIXUP_IDEAPAD),
-- 
2.40.1


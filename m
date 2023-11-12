Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B93A17E91A9
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Nov 2023 17:30:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231781AbjKLQah (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Nov 2023 11:30:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231552AbjKLQaf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Nov 2023 11:30:35 -0500
X-Greylist: delayed 486 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 12 Nov 2023 08:30:30 PST
Received: from mail.malych.org (gateway.malych.org [185.150.1.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC84D2D49
        for <linux-kernel@vger.kernel.org>; Sun, 12 Nov 2023 08:30:30 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 26600AA8CD6;
        Sun, 12 Nov 2023 17:22:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=malych.org; s=dkim;
        t=1699806140; h=from:subject:date:message-id:to:cc:mime-version:
         content-transfer-encoding; bh=GCMcwORUQRqnOz5c+Ffs4hnmtdMXVgc71+oi7qf57u4=;
        b=Phh/Vnfayf2BhHSEnRVnm4+0OyCygXAyK2uaqmb853MmN8UKBvHHd/N6g97QHlXE9xYJYL
        CT7+ptW5z9wBmHsAe4coPnZe8Tp8jchI7p2VGSFsQS3mq5RPI7TyA/DAoEY4Y1wRdszYVp
        4Ypq63caFwGIEXQwtyolY+9TmnG33d80nN8zd5I48KbwByqLrnoqUbHXQL5SAtVCE1fJKO
        FckDRaIAVhTgPHLOYl43uapCudbpdxfjnBsOQuTGOFJJBaYEuZ6e4TkDnuMzsTQWpYLYzj
        ENjZS9WZkbxHiM2nYTrGeM1Mt4hbVyz0cnG/6u/S6G4P+p3/agf+cJJzt1TTmA==
From:   Matus Malych <matus@malych.org>
To:     tiwai@suse.com
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Matus Malych <matus@malych.org>
Subject: [PATCH] ALSA: hda/realtek: Enable Mute LED on HP 255 G10
Date:   Sun, 12 Nov 2023 17:18:22 +0100
Message-Id: <20231112161821.6754-1-matus@malych.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

HP 255 G10 has a mute LED that can be made to work using quirk
ALC236_FIXUP_HP_MUTE_LED_COEFBIT2. Enable already existing quirk.

Signed-off-by: Matus Malych <matus@malych.org>
---
 sound/pci/hda/patch_realtek.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index cdd808e02b44..bda4e9cb8f98 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -9833,6 +9833,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x103c, 0x88d0, "HP Pavilion 15-eh1xxx (mainboard 88D0)", ALC287_FIXUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x8902, "HP OMEN 16", ALC285_FIXUP_HP_MUTE_LED),
 	SND_PCI_QUIRK(0x103c, 0x890e, "HP 255 G8 Notebook PC", ALC236_FIXUP_HP_MUTE_LED_COEFBIT2),
+	SND_PCI_QUIRK(0x103c, 0x8b2f, "HP 255 15.6 inch G10 Notebook PC", ALC236_FIXUP_HP_MUTE_LED_COEFBIT2),
 	SND_PCI_QUIRK(0x103c, 0x8919, "HP Pavilion Aero Laptop 13-be0xxx", ALC287_FIXUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x896d, "HP ZBook Firefly 16 G9", ALC245_FIXUP_CS35L41_SPI_2_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x896e, "HP EliteBook x360 830 G9", ALC245_FIXUP_CS35L41_SPI_2_HP_GPIO_LED),
-- 
2.34.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E53887EB0FF
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 14:38:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232282AbjKNNii (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 08:38:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjKNNih (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 08:38:37 -0500
Received: from mail.malych.org (gateway.malych.org [185.150.1.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAB531B9
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 05:38:33 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 15682AA8C67;
        Tue, 14 Nov 2023 14:38:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=malych.org; s=dkim;
        t=1699969110; h=from:subject:date:message-id:to:cc:mime-version:
         content-transfer-encoding:in-reply-to:references;
        bh=M2W/mJKe/9mkt7dXkYSPCn0UkTJjRbISNIwGBXbQaKM=;
        b=Zvk4ID63K95XkuTNq3EqXHqlYuoJDscu0bATZmkk9sTVw0XWCfUSFv2gepdklKwN+pF/vL
        XnvT2jOFSCcejZ/v/TitswpuZFE52HvN9ZnMDqbkDP9UHcKeHOYadGQBoTWalV+APnWoc2
        g7ML7e+Z5ioVxfZY6VjNyOFbfeBLO4E+ScYRfDCs/ckDTZeCkgRO6+MeNXTkNDfeWXZO/w
        nTDIBsU+ajdjap+QzEmmct503FFGNx4X0YDxRGvgHSKrYNGlUabwYy7dlatujApVJ9K2Z0
        0gonxONj4Glg3EwdaABOKuVt0nTsD1co1NfgSTbyF2fXKCvr4szbuSVhdJDTew==
From:   Matus Malych <matus@malych.org>
To:     tiwai@suse.com
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Matus Malych <matus@malych.org>
Subject: [PATCH v2] ALSA: hda/realtek: Enable Mute LED on HP 255 G10
Date:   Tue, 14 Nov 2023 14:35:25 +0100
Message-Id: <20231114133524.11340-1-matus@malych.org>
In-Reply-To: <87r0kuoug5.wl-tiwai@suse.de>
References: <87r0kuoug5.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

HP 255 G10 has a mute LED that can be made to work using quirk
ALC236_FIXUP_HP_MUTE_LED_COEFBIT2.
Enable already existing quirk - at correct line to keep order

Signed-off-by: Matus Malych <matus@malych.org>
---
 sound/pci/hda/patch_realtek.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index cdd808e02b44..3c85b8247c11 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -9868,6 +9868,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x103c, 0x8abb, "HP ZBook Firefly 14 G9", ALC245_FIXUP_CS35L41_SPI_2_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x8ad1, "HP EliteBook 840 14 inch G9 Notebook PC", ALC245_FIXUP_CS35L41_SPI_2_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x8ad2, "HP EliteBook 860 16 inch G9 Notebook PC", ALC245_FIXUP_CS35L41_SPI_2_HP_GPIO_LED),
+	SND_PCI_QUIRK(0x103c, 0x8b2f, "HP 255 15.6 inch G10 Notebook PC", ALC236_FIXUP_HP_MUTE_LED_COEFBIT2),
 	SND_PCI_QUIRK(0x103c, 0x8b42, "HP", ALC245_FIXUP_CS35L41_SPI_2_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x8b43, "HP", ALC245_FIXUP_CS35L41_SPI_2_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x8b44, "HP", ALC245_FIXUP_CS35L41_SPI_2_HP_GPIO_LED),
-- 
2.34.1


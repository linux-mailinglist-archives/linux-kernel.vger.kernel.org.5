Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 959D679DF82
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 07:41:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235715AbjIMFlg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 01:41:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230003AbjIMFlf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 01:41:35 -0400
X-Greylist: delayed 462 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 12 Sep 2023 22:41:31 PDT
Received: from forward206b.mail.yandex.net (forward206b.mail.yandex.net [178.154.239.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABD21172A
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 22:41:31 -0700 (PDT)
Received: from forward101b.mail.yandex.net (forward101b.mail.yandex.net [IPv6:2a02:6b8:c02:900:1:45:d181:d101])
        by forward206b.mail.yandex.net (Yandex) with ESMTP id E0A3C630D7
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 08:33:51 +0300 (MSK)
Received: from mail-nwsmtp-smtp-production-main-44.sas.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-44.sas.yp-c.yandex.net [IPv6:2a02:6b8:c14:440b:0:640:fa3a:0])
        by forward101b.mail.yandex.net (Yandex) with ESMTP id 2C24E60031;
        Wed, 13 Sep 2023 08:33:46 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-44.sas.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id hXX1UA6DUGk0-5KRTeYJK;
        Wed, 13 Sep 2023 08:33:45 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ya.ru; s=mail;
        t=1694583225; bh=sB2ZQ7DHWeq2GnlLubNW3gqh2dptT89YWo7Pu1Ab5Pg=;
        h=Message-ID:Date:Cc:Subject:To:From;
        b=FAdJJjkMCOJfN98f6Bcm3hbOA1whkXEhiTT1agCQsOUL97bZaoaz4de2Osh8sg14p
         /wkPH67sIa8FA2llz+YKmFoVzfi1zYyKhdpSC1C5ryTe2AA2vSY5cGjMRdzjcKhmmk
         K6lNyQu7XLuYL6yNEO/VeCYVtINtKDI1jxUipPe8=
Authentication-Results: mail-nwsmtp-smtp-production-main-44.sas.yp-c.yandex.net; dkim=pass header.i=@ya.ru
From:   poseaydone@ya.ru
To:     Jaroslav Kysela <perex@perex.cz>
Cc:     Knyazev Arseniy <poseaydone@ya.ru>, Takashi Iwai <tiwai@suse.com>,
        "Luke D. Jones" <luke@ljones.dev>,
        Stefan Binding <sbinding@opensource.cirrus.com>,
        Andy Chi <andy.chi@canonical.com>,
        Shenghao Ding <shenghao-ding@ti.com>,
        Matthew Anderson <ruinairas1992@gmail.com>,
        Luka Guzenko <l.guzenko@web.de>,
        Yuchi Yang <yangyuchi66@gmail.com>,
        Vitaly Rodionov <vitalyr@opensource.cirrus.com>,
        Yang Yingliang <yangyingliang@huawei.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH] patch_realtek: Splitting the UX3402 into two separate models.
Date:   Wed, 13 Sep 2023 10:33:43 +0500
Message-ID: <20230913053343.119798-1-poseaydone@ya.ru>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Knyazev Arseniy <poseaydone@ya.ru>

UX3402VA and UX3402ZA models require different hex values, so comibining
them into one model is incorrect.

Signed-off-by: Knyazev Arseniy <poseaydone@ya.ru>
---
 sound/pci/hda/patch_realtek.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index b7e78bfcffd8..b002f947b0d2 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -9812,7 +9812,8 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1043, 0x1d1f, "ASUS ROG Strix G17 2023 (G713PV)", ALC287_FIXUP_CS35L41_I2C_2),
 	SND_PCI_QUIRK(0x1043, 0x1d42, "ASUS Zephyrus G14 2022", ALC289_FIXUP_ASUS_GA401),
 	SND_PCI_QUIRK(0x1043, 0x1d4e, "ASUS TM420", ALC256_FIXUP_ASUS_HPE),
-	SND_PCI_QUIRK(0x1043, 0x1e02, "ASUS UX3402", ALC245_FIXUP_CS35L41_SPI_2),
+	SND_PCI_QUIRK(0x1043, 0x1e02, "ASUS UX3402ZA", ALC245_FIXUP_CS35L41_SPI_2),
+	SND_PCI_QUIRK(0x1043, 0x16a3, "ASUS UX3402VA", ALC245_FIXUP_CS35L41_SPI_2),
 	SND_PCI_QUIRK(0x1043, 0x1e11, "ASUS Zephyrus G15", ALC289_FIXUP_ASUS_GA502),
 	SND_PCI_QUIRK(0x1043, 0x1e12, "ASUS UM3402", ALC287_FIXUP_CS35L41_I2C_2),
 	SND_PCI_QUIRK(0x1043, 0x1e51, "ASUS Zephyrus M15", ALC294_FIXUP_ASUS_GU502_PINS),
-- 
2.42.0


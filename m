Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 773817E8C1B
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Nov 2023 19:25:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229514AbjKKSZ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Nov 2023 13:25:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjKKSZx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Nov 2023 13:25:53 -0500
Received: from w4.tutanota.de (w4.tutanota.de [81.3.6.165])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EB21385C;
        Sat, 11 Nov 2023 10:25:51 -0800 (PST)
Received: from tutadb.w10.tutanota.de (unknown [192.168.1.10])
        by w4.tutanota.de (Postfix) with ESMTP id 420961060122;
        Sat, 11 Nov 2023 18:25:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1699727149;
        s=s1; d=chandradeepdey.com;
        h=From:From:To:To:Subject:Subject:Content-Description:Content-ID:Content-Type:Content-Type:Content-Transfer-Encoding:Content-Transfer-Encoding:Cc:Cc:Date:Date:In-Reply-To:MIME-Version:MIME-Version:Message-ID:Message-ID:Reply-To:References:References:Sender;
        bh=zjTsU2Y9JIQheTQGt9d6h5lsK/0ZYDgav9y1gb13Wd4=;
        b=AhE2gYaHhLdYDkGXw3ooSjeftkR3M8StPEOGg6ZtMdT9YiTGsRR7/igKkMjvRsoq
        p//SW7fEg3ONLLdr4etrdP0RavgT2UhT25cTFahiw97OV5dXW3aC4eCUR9VFSF0pbaZ
        zklK7Y6T6umnrcUP9/XxALw2/MTrOWZjLqvv44bLxtOrr2uF0N+sVvOCC0LaHElQU4M
        K6wlkmU8+Uu8XexotEFmPUCNG5EaJ6Zha1hP79otmMQPTlihCfyCAz3vqf4jvP6uRHv
        6KLPpVIw2RdJZ7ID1OYOCskN+rLh5zbAq8HVBdvISHhRqTZtpPdUvIOxbtGViYsIyr+
        vFbdIOKXAA==
Date:   Sat, 11 Nov 2023 19:25:49 +0100 (CET)
From:   Chandradeep Dey <codesigning@chandradeepdey.com>
To:     Jaroslav Kysela <perex@perex.cz>
Cc:     Takashi Iwai <tiwai@suse.com>,
        Linux Sound <linux-sound@vger.kernel.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Message-ID: <NizcVHQ--3-9@chandradeepdey.com>
References: <NizTVQz--3-9@chandradeepdey.com>
Subject: [PATCH] ALSA: hda/realtek - Enable internal speaker of ASUS K6500ZC
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Apply the already existing quirk chain ALC294_FIXUP_ASUS_SPK to enable the internal speaker of ASUS K6500ZC.

Signed-off by: Chandradeep Dey <codesigning@chandradeepdey.com>
---
diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 669ae3d6e447..6bf99b1a8c40 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -9906,6 +9906,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
	SND_PCI_QUIRK(0x1043, 0x10a1, "ASUS UX391UA", ALC294_FIXUP_ASUS_SPK),
	SND_PCI_QUIRK(0x1043, 0x10c0, "ASUS X540SA", ALC256_FIXUP_ASUS_MIC),
	SND_PCI_QUIRK(0x1043, 0x10d0, "ASUS X540LA/X540LJ", ALC255_FIXUP_ASUS_MIC_NO_PRESENCE),
+	SND_PCI_QUIRK(0x1043, 0x10d3, "ASUS K6500ZC", ALC294_FIXUP_ASUS_SPK),
	SND_PCI_QUIRK(0x1043, 0x115d, "Asus 1015E", ALC269_FIXUP_LIMIT_INT_MIC_BOOST),
	SND_PCI_QUIRK(0x1043, 0x11c0, "ASUS X556UR", ALC255_FIXUP_ASUS_MIC_NO_PRESENCE),
	SND_PCI_QUIRK(0x1043, 0x125e, "ASUS Q524UQK", ALC255_FIXUP_ASUS_MIC_NO_PRESENCE),

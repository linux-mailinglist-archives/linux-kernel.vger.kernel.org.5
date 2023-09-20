Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7C9B7A896B
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 18:29:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234561AbjITQ3D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 12:29:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233691AbjITQ3B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 12:29:01 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 018ECC2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 09:28:55 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-405082a8c77so137905e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 09:28:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695227334; x=1695832134; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+svc8ya/3hLXtgURW9qrBP4eP/nOp7XiMBrPk5Pez+k=;
        b=cGRJ2i889lXm3b231d5TXIkgnexVuNiIm4xmm7eJN16WEyMVMaU7lwsOlFBrF5Gdk5
         KaU9NHoyoVr9+l8uodCa6My44Tkt7cOzYxhPT9KFs0CCQrN2m6c3gj7VV0V9CcRTewOO
         M0vqyDe0lfX9mO7qTUt5NqY60kwiO0/neqIRA26NhgEAbyc4eEut41BQ+nxmyMB0hrOs
         tu01hBff3ahlx83TsETTKYHzAg5soA5vE5aJQ1OhHV0k/8hQ4Hlnq3HadQnF7W+Pu/9h
         BIl2xKjAAEqHOxqIApUQLCn0eHFvRtAVJTth+jZxq4q2UezsOWgitopcll00SWI/egpg
         xsbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695227334; x=1695832134;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+svc8ya/3hLXtgURW9qrBP4eP/nOp7XiMBrPk5Pez+k=;
        b=oHLPwZyJYbn+g/YfCeLMmOftVqXZAxjzzk10LTc15tpXUiXTP/aBCOPs9JoQGsgxZM
         EzpLA+eMCv0kJAmKFyi4nECBaD+ZsCXqxZTDfQLqdDYP0igqOqmU4/XBVuMPX9Yx3mLF
         roiN9zvcI3FvHeYgvmPiMDxnZ7y7QOPq3lS5c7Xk2nBhu/pld+HPRv2Oa2rFC2EcRx6J
         lstpUKzuqzcHNQB/SDNH2KJNJgZu5KLNbgqoSWsogvt26KyNAhCQ/QNEYi7cSzYQ7Jz+
         KsTw3LjbsL1b0Au7FycKEYl86z2/sUjDYIEQjJMHEC0l6qS+71hrDrXHjorpIlnyjg7L
         wdIg==
X-Gm-Message-State: AOJu0YxJt8qc8Op40OH8Lc8zdITk4fyD0AR4ZGG0arK5hSc2Aw1AQ0Hn
        7kmYfLU4FBTxIYy1spkVmTLDVlTIreCKCKurCOfZAY0DbjuaGQ==
X-Google-Smtp-Source: AGHT+IHCjQzkDiwVjdq1cmpM3eFdpKVPG1QOQho7PFze/UrSZ6xGis3QsOWY+ZlBZdUcJ/Vyxvo7paOZxqgPAM42DOQ=
X-Received: by 2002:a5d:4c47:0:b0:317:5e91:5588 with SMTP id
 n7-20020a5d4c47000000b003175e915588mr2834234wrt.3.1695227333726; Wed, 20 Sep
 2023 09:28:53 -0700 (PDT)
MIME-Version: 1.0
From:   Abby Ricart <aricart@gmail.com>
Date:   Wed, 20 Sep 2023 12:28:42 -0400
Message-ID: <CAE+SJcJ+pPob5cMZHoP01XPjU-zZjmku2YuHOWoo9gM0ruCkcQ@mail.gmail.com>
Subject: [PATCH] ALSA: hda/realtek: Add quirk for ASUS ROG G533Q
To:     linux-kernel@vger.kernel.org
Cc:     perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The same quirk applied to the ASUS G533Z is also applicable to the ASUS
G533Q (of which I am an owner and have thus tested).

Signed-off-by: Abelardo Ricart <aricart@gmail.com>
---
diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index b7e78bfcffd8..7bb3c1e05bf2 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -9781,6 +9781,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
  SND_PCI_QUIRK(0x1043, 0x1493, "ASUS GV601V", ALC285_FIXUP_ASUS_HEADSET_MIC),
  SND_PCI_QUIRK(0x1043, 0x1517, "Asus Zenbook UX31A",
ALC269VB_FIXUP_ASUS_ZENBOOK_UX31A),
  SND_PCI_QUIRK(0x1043, 0x1573, "ASUS GZ301V", ALC285_FIXUP_ASUS_HEADSET_MIC),
+ SND_PCI_QUIRK(0x1043, 0x1602, "ASUS ROG Strix G15 (G533Q)",
ALC285_FIXUP_ASUS_G533Z_PINS),
  SND_PCI_QUIRK(0x1043, 0x1662, "ASUS GV301QH", ALC294_FIXUP_ASUS_DUAL_SPK),
  SND_PCI_QUIRK(0x1043, 0x1683, "ASUS UM3402YAR", ALC287_FIXUP_CS35L41_I2C_2),
  SND_PCI_QUIRK(0x1043, 0x16b2, "ASUS GU603", ALC289_FIXUP_ASUS_GA401),

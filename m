Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0683782500
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 10:00:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233881AbjHUIAJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 04:00:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229993AbjHUIAJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 04:00:09 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FD3BA8;
        Mon, 21 Aug 2023 01:00:07 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-3fee5ddc334so8847015e9.1;
        Mon, 21 Aug 2023 01:00:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692604806; x=1693209606;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ot6x55z/o5kJL3OIQzE1UKq6wZSH+S1vm2jpybNx/zQ=;
        b=pv6otCQ7MCFG3Tgp7tj89Dnz5pn6FyqUzChKMyWUhJTDEQdqz7SvBh26wcCijLA1b6
         NGHx7DcyvaafU4NDn4q4zBKIT6TH2uZ2IRFpoMNHVcUINsmkL1qLbiv5yfd+mnMo479n
         3yNkf3eQf/QXtVXRJHS/zJd1E6BR5sQt5yi1NOmUVzDLxewW9l4DqyU09ONgtFU9rL55
         p8hBp4MEA9SFoK8qMIPTuOSpROu2K0rb3KtyMu36v+is18K1NdjMVjhCv7IUdDJk6ZzW
         5niyVsq8ueJ24RNwMUCQ2J4dufQK6s4VUsNfZdKqg5IXLOqufXA2i3MG0Y+pD/EZfBCD
         FLUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692604806; x=1693209606;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ot6x55z/o5kJL3OIQzE1UKq6wZSH+S1vm2jpybNx/zQ=;
        b=EDjsyVaQodXvmEt6wi5dC8+gnPbGmGLokaK+jQ8D9GATR8EyqAC8HY5j/mM/umGOxP
         rcSDaSmfOh3Fdl+DU2jolHIuFgsT46qaJQeAddKQy8eyZtsMr9RveK5EEpMKfOii1fqY
         ifoXGIDKnp7bGcxiOTHwJ/QMDqGcUHRR5I+6fJwCoSSsgt0SKoQL98x3GHmfROu6Hrs7
         lPwge3H8i3teYKJTGnNmH5wND/PUzFU/qvoVtOT/G0DVI+cK1GJHJkFbNyZN9+UiqJ1e
         VtiO7J/jIfPTE/ga7QFNPN3aiNptqoTgMIT0KlpHx7cPUHZAhJBb1U49ys0iEBeQ+VKt
         v27g==
X-Gm-Message-State: AOJu0YyzVC9IHEt4ZQU4TjJP841Wr/UQj7JCs7JfuZpBPniMnQMR/YBT
        iTFR/lmNIrAoxcVgHvb1/fw=
X-Google-Smtp-Source: AGHT+IEYLl5oXIc4TWT/aI34IjKXHvw/mEi3+rGhp9emNgXZmB1Ccj8ivADdvR7hvc8ttle93QSLIw==
X-Received: by 2002:a7b:cd06:0:b0:3fe:df0:c10f with SMTP id f6-20020a7bcd06000000b003fe0df0c10fmr4338342wmj.17.1692604805766;
        Mon, 21 Aug 2023 01:00:05 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id f6-20020a1c6a06000000b003fe2b6d64c8sm15223420wmc.21.2023.08.21.01.00.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Aug 2023 01:00:04 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        alsa-devel@alsa-project.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] ALSA: hda/realtek: Fix spelling mistake "powe" -> "power"
Date:   Mon, 21 Aug 2023 09:00:03 +0100
Message-Id: <20230821080003.16678-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a spelling mistake in a quirk entry. Fix it.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 sound/pci/hda/patch_realtek.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 6707db55f9c5..54e17791c6a8 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -9967,7 +9967,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x17aa, 0x3869, "Lenovo Yoga7 14IAL7", ALC287_FIXUP_YOGA9_14IAP7_BASS_SPK_PIN),
 	SND_PCI_QUIRK(0x17aa, 0x387d, "Yoga S780-16 pro Quad AAC", ALC287_FIXUP_TAS2781_I2C),
 	SND_PCI_QUIRK(0x17aa, 0x387e, "Yoga S780-16 pro Quad YC", ALC287_FIXUP_TAS2781_I2C),
-	SND_PCI_QUIRK(0x17aa, 0x3881, "YB9 dual powe mode2 YC", ALC287_FIXUP_TAS2781_I2C),
+	SND_PCI_QUIRK(0x17aa, 0x3881, "YB9 dual power mode2 YC", ALC287_FIXUP_TAS2781_I2C),
 	SND_PCI_QUIRK(0x17aa, 0x3884, "Y780 YG DUAL", ALC287_FIXUP_TAS2781_I2C),
 	SND_PCI_QUIRK(0x17aa, 0x3886, "Y780 VECO DUAL", ALC287_FIXUP_TAS2781_I2C),
 	SND_PCI_QUIRK(0x17aa, 0x38a7, "Y780P AMD YG dual", ALC287_FIXUP_TAS2781_I2C),
-- 
2.39.2


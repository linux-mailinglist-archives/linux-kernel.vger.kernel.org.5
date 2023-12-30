Return-Path: <linux-kernel+bounces-13405-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 611428204A3
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Dec 2023 12:40:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BD54DB2153A
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Dec 2023 11:40:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C1D379CD;
	Sat, 30 Dec 2023 11:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PhLhOjpB"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 064167465;
	Sat, 30 Dec 2023 11:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-40d60c49ee7so25512495e9.0;
        Sat, 30 Dec 2023 03:40:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703936424; x=1704541224; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jZVgsk7Ptq4Zn7LUzSb7KSddvFu6VpF8VaABTVbWLiI=;
        b=PhLhOjpBup5iWZ4obyOeTuPZfcWKF3tYahJ+CSmGpyV66xTtgRZTB/lCR7omI5fgCh
         LnCQiqMrx7xSYfl5C6qoncT2PIrRKczsER4C3C3bYUYwK0/YRtmYR9AeP/BZLB08Bika
         GlnKtPgF2bhkKmpKlqUDefz9zQSNSmbKEem/IICwhYzgL9LZRZNjnfqEuoQTwc5Vkzq/
         ejQAbeSIsOGKTwxuGTgg30EhyA2PDJdHAspfFyBpXPNI+SC3OtMBRLDCEZBoL62KopHJ
         F7iNKFg3PH9JPKBNO1tmVQVqXe8AJoUL71NgucyNwCnmvKC5bqhkQVd/b4VC8XXzO+PT
         NBfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703936424; x=1704541224;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jZVgsk7Ptq4Zn7LUzSb7KSddvFu6VpF8VaABTVbWLiI=;
        b=i3U8QQcX9v9DC44NZCHHNyfuOoNtMGCQuCZofWJj7Bw0BC/8h5HHT/O1QkaMRCatQA
         doLokwaTiI2x33nPPnFxBJuqieMp/4jQcgE387fxS+VEWmlKo5wS2/Phf5R68l8kF1EE
         vBQsDpadz5EDaKjiN8XS8osJbkNzOmTSQUjpiX+8krQD+47nFVn72yPsvn+j8pg2yvPV
         l/Ds1id2XKuECBiuKE9qT9VR4K6suKatSuRMX5mM1+pSMDwdxzJx6KxMft8M0tGLnEFM
         q9LaD1uggd2YEBZKlTZWnFmhgSFFbBKtLSZOqPD2yfp8SVbTMAqyAzRerk43sWGKfkWj
         FUuQ==
X-Gm-Message-State: AOJu0YyrAXMv8Czu9hDx+ryH4XRS+a40Aed/Jbt+hcNQuIF94u5mD1np
	qsSt/NWtsTK7zqw2BkcNbSU=
X-Google-Smtp-Source: AGHT+IF7cnKWL9Sl/Kj2ZKrQDAZ+xfJ7Y9Wja5AiQx6iNFiXVsZHcTHAoQqYfpjwblJz02kXI9278g==
X-Received: by 2002:a7b:cc8e:0:b0:40c:6b60:343e with SMTP id p14-20020a7bcc8e000000b0040c6b60343emr6104093wma.119.1703936423737;
        Sat, 30 Dec 2023 03:40:23 -0800 (PST)
Received: from localhost.localdomain ([2a02:842a:1ce:5301:f733:18af:2fff:3d3d])
        by smtp.gmail.com with ESMTPSA id r14-20020a05600c458e00b0040d724896cbsm6313296wmo.18.2023.12.30.03.40.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Dec 2023 03:40:23 -0800 (PST)
From: Dorian Cruveiller <doriancruveiller@gmail.com>
To: perex@perex.cz,
	tiwai@suse.com,
	sbinding@opensource.cirrus.com,
	kailang@realtek.com,
	luke@ljones.dev,
	andy.chi@canonical.com,
	shenghao-ding@ti.com,
	l.guzenko@web.de,
	ruinairas1992@gmail.com,
	yangyuchi66@gmail.com,
	vitalyr@opensource.cirrus.com,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Dorian Cruveiller <doriancruveiller@gmail.com>
Subject: [PATCH v2 1/2] ALSA:hda/realtek enable SND_PCI_QUIRK for Lenovo Legion Slim 7 Gen 8 (2023) serie
Date: Sat, 30 Dec 2023 12:40:01 +0100
Message-ID: <20231230114001.19855-1-doriancruveiller@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231229230703.73876-1-doriancruveiller@gmail.com>
References: <20231229230703.73876-1-doriancruveiller@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Link up the realtek audio chip to the cirrus cs35l41 sound amplifier chip
on 4 models of the Lenovo legion slim 7 gen 8 (2023). These models are
16IRH8 (2 differents subsystem id) and 16APH8 (2 differents subsystem ids).

Subsystem ids list:
 - 17AA38B4
 - 17AA38B5
 - 17AA38B6
 - 17AA38B7

Signed-off-by: Dorian Cruveiller <doriancruveiller@gmail.com>
---
 sound/pci/hda/patch_realtek.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 19040887ff67..bc4e3a85137c 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -10239,6 +10239,10 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x17aa, 0x3886, "Y780 VECO DUAL", ALC287_FIXUP_TAS2781_I2C),
 	SND_PCI_QUIRK(0x17aa, 0x38a7, "Y780P AMD YG dual", ALC287_FIXUP_TAS2781_I2C),
 	SND_PCI_QUIRK(0x17aa, 0x38a8, "Y780P AMD VECO dual", ALC287_FIXUP_TAS2781_I2C),
+	SND_PCI_QUIRK(0x17aa, 0x38b4, "Legion Slim 7 16IRH8", ALC287_FIXUP_CS35L41_I2C_2),
+	SND_PCI_QUIRK(0x17aa, 0x38b5, "Legion Slim 7 16IRH8", ALC287_FIXUP_CS35L41_I2C_2),
+	SND_PCI_QUIRK(0x17aa, 0x38b6, "Legion Slim 7 16APH8", ALC287_FIXUP_CS35L41_I2C_2),
+	SND_PCI_QUIRK(0x17aa, 0x38b7, "Legion Slim 7 16APH8", ALC287_FIXUP_CS35L41_I2C_2),
 	SND_PCI_QUIRK(0x17aa, 0x38ba, "Yoga S780-14.5 Air AMD quad YC", ALC287_FIXUP_TAS2781_I2C),
 	SND_PCI_QUIRK(0x17aa, 0x38bb, "Yoga S780-14.5 Air AMD quad AAC", ALC287_FIXUP_TAS2781_I2C),
 	SND_PCI_QUIRK(0x17aa, 0x38be, "Yoga S980-14.5 proX YC Dual", ALC287_FIXUP_TAS2781_I2C),
-- 
2.43.0



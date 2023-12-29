Return-Path: <linux-kernel+bounces-13272-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B3F58202C1
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Dec 2023 00:05:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 051291F22E0F
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 23:05:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E298D14AB4;
	Fri, 29 Dec 2023 23:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EqWHgWmY"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C736014AA1;
	Fri, 29 Dec 2023 23:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-40d5a41143fso33339665e9.3;
        Fri, 29 Dec 2023 15:05:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703891133; x=1704495933; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XuYPybffDFeo+aLlhJnUJLlzKhbvOFBWBB5vAdXznK8=;
        b=EqWHgWmYHUQuEwoSK1L4EmmYak1sZsUmPwadc4avaObtp96opqqkCa+ez+1TSOQVIS
         l7mwOoVQ7Kk6YnEp1F2G7r0h1xxIowFtjwZk2QrJAZEWpJslvhtRjsqdhrHF07Kcb/eD
         BdthFOIPJzAaEdVeF9aaRZSkGfPDpItBRj8r2fjwIO0RSNXE0iXIx4bNZGaDeQpA5mAb
         LgVcGGlJbxm0G7dWXrWrd/jKg67P5wXEowjz014XbZbnjrU7tDUai22bQWQhQzLJFCBb
         XfSg1vjwB9d96jOg0hQbHMD5RA5i5fAbfb+pLqIgQaYzOK9ExQJORtDS8399DrDuGLLr
         vJpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703891133; x=1704495933;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XuYPybffDFeo+aLlhJnUJLlzKhbvOFBWBB5vAdXznK8=;
        b=MTJJmFBVDDtUnxdIJVBEhuWQ7ue8dgvoYfz8fb+v166ZtlKB+LnLRgUcXaZJdZUktx
         QzLcJRW0OYH8W5jfb0LIZ97kki57SHmAreCNS4aEH+U3ny1wtfrF+JMxLN0oF3nu3dI9
         fM5X0hcViRup96AOAaXAjKGaWQpDnUE46c9mhGCDzi1+un5TSUvXHUwT4K8kPc6ttaLd
         jN69rcx09aXzwmz6177XsdpwrfRha3UepwOiM1vu9lCQf6CNUJ16Fy9XlNPi0Fapphrv
         W8/Fck5+IhMJNeuF2/+/1iWEOb29s5K/JcJ88AP0G/vTsiefof8lx7xxnToIfJwJ0/Rq
         Joag==
X-Gm-Message-State: AOJu0YwtJRSHjNe4oW+egvKx5mgl3vwFQyvjuvrqAtJWrBw5BPX1iqUc
	JrrzGsHyCN/PbobxuTF8rL4=
X-Google-Smtp-Source: AGHT+IEtytzksgyHe4iTbHaGZ60tYGKlCKHfdT3GyPcNDKHH8LohnZvxjlD1MFvvh/AveDkd7tEpqg==
X-Received: by 2002:a05:600c:1f8f:b0:40d:6572:e8e6 with SMTP id je15-20020a05600c1f8f00b0040d6572e8e6mr1680826wmb.124.1703891132607;
        Fri, 29 Dec 2023 15:05:32 -0800 (PST)
Received: from localhost.localdomain ([2a02:842a:1ce:5301:f733:18af:2fff:3d3d])
        by smtp.gmail.com with ESMTPSA id j17-20020a05600c191100b0040d5f3ef2a2sm9938103wmq.16.2023.12.29.15.05.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Dec 2023 15:05:32 -0800 (PST)
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
Subject: [PATCH 1/2] ALSA:hda/realtek enable SND_PCI_QUIRK for Lenovo Legion Slim 7 Gen 8 (2023) series
Date: Sat, 30 Dec 2023 00:04:50 +0100
Message-ID: <20231229230450.72291-1-doriancruveiller@gmail.com>
X-Mailer: git-send-email 2.43.0
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
index c3a756528886..3918bf994756 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -10226,6 +10226,10 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
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



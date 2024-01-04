Return-Path: <linux-kernel+bounces-16277-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D1536823C13
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 07:09:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B55961C24A9C
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 06:09:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AF5818EC3;
	Thu,  4 Jan 2024 06:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CM3dDIEk"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C29811D68D;
	Thu,  4 Jan 2024 06:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-6da55cc8e78so123699b3a.0;
        Wed, 03 Jan 2024 22:09:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704348542; x=1704953342; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5ZvQW0xU+LOb9bzaqP41SYyg4D476cxr1BBMCgwep1I=;
        b=CM3dDIEkdCwEq/fX96iKqcngPz1v4BV/QTxV2oToC1PWcFJ4BjrIP6640Eel3nJfdR
         EGI8nYu14C9cw7S26Qntl5mFf0IL1BK8lZoDG5HhM8tsalSgnBUISspbIZtxRdDrGmmx
         YrebOCtW/pC4NEHPSq2HlC/ciSmbRLyiTEpX5dzX6dY1sD+MBxr3mG6TOHpJNHGLsAX2
         3c0cJESQsI7sV0+JYLBKUR4cgJo5NRkgaUzpW5MF0Vn7Y/w5rcbaqKVZHXSIbOI0f+af
         DJw4BUIpGNbb7ipot6Hep7Sgcmb7hU2DuRXr5W9vY3cjuxCmf+UuyW1cb/sQa5kTiFob
         IIyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704348542; x=1704953342;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5ZvQW0xU+LOb9bzaqP41SYyg4D476cxr1BBMCgwep1I=;
        b=CZiTXBlDNh8cas5txrPY2E+Wi6gOdJ6Z0/jxzDnyaKjkX0pMLHW1c2QSPsJ3/cCe/q
         QMppCpkJFmaQUS6SwaUz+E4qGJVL1gOjsnJjfPeL6e4KPIhKkJKbUC11HaQhmlTnJJwA
         febWzarjR6xSvqtEu7WBu0ByECoHidxBQcbPnFYfJ7G7aYxAw2Xitn8Vk05qytBz5/IH
         FI7rSurYYaTlZLl/7kOlu4YGOZVlJVxSr+tlh80X/+UsWx8Zon/UB4iXU87KXsyu8Yvx
         EDy27jGi80ZXa+RfFRsl5U+n1SoUflXZOnWcFddfOLUsiit6oy/Z1kgnD0qo+PKU0b9v
         SNQA==
X-Gm-Message-State: AOJu0Yxifjax/3FDZkp+gD/EoWFB1QOue3C6mj0DITQyi4gbI1oKGS0Y
	Q1ioxUSEuQa4vYIK+ezbhVM=
X-Google-Smtp-Source: AGHT+IGPx7ipScYKtOWFT5j0xVd85A3lG6Rch/jPBtZBGlh0XwaA+0QEFOoH++nqD7CibZ/idq9h8g==
X-Received: by 2002:aa7:9e42:0:b0:6da:2898:1d6c with SMTP id z2-20020aa79e42000000b006da28981d6cmr142773pfq.51.1704348541947;
        Wed, 03 Jan 2024 22:09:01 -0800 (PST)
Received: from arch-hp.. ([2409:40c2:1059:c189:c8af:e8c3:986e:aea2])
        by smtp.gmail.com with ESMTPSA id m7-20020a62f207000000b006d9a846036asm19473072pfh.60.2024.01.03.22.08.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jan 2024 22:09:01 -0800 (PST)
From: Siddhesh Dharme <siddheshdharme18@gmail.com>
To: perex@perex.cz,
	tiwai@suse.com
Cc: alsa-devel@alsa-project.org,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Siddhesh Dharme <siddheshdharme18@gmail.com>
Subject: [PATCH] ALSA: hda/realtek: Fix mute and mic-mute LEDs for HP ProBook 440 G6
Date: Thu,  4 Jan 2024 11:37:36 +0530
Message-ID: <20240104060736.5149-1-siddheshdharme18@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

LEDs in 'HP ProBook 440 G6' laptop are controlled by ALC236 codec.
Enable already existing quirk 'ALC236_FIXUP_HP_MUTE_LED_MICMUTE_VREF'
to fix mute and mic-mute LEDs.

Signed-off-by: Siddhesh Dharme <siddheshdharme18@gmail.com>
---
 sound/pci/hda/patch_realtek.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index c80e2f3ac..1dcfba27e 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -9825,6 +9825,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x103c, 0x84da, "HP OMEN dc0019-ur", ALC295_FIXUP_HP_OMEN),
 	SND_PCI_QUIRK(0x103c, 0x84e7, "HP Pavilion 15", ALC269_FIXUP_HP_MUTE_LED_MIC3),
 	SND_PCI_QUIRK(0x103c, 0x8519, "HP Spectre x360 15-df0xxx", ALC285_FIXUP_HP_SPECTRE_X360),
+	SND_PCI_QUIRK(0x103c, 0x8537, "HP ProBook 440 G6", ALC236_FIXUP_HP_MUTE_LED_MICMUTE_VREF),
 	SND_PCI_QUIRK(0x103c, 0x860f, "HP ZBook 15 G6", ALC285_FIXUP_HP_GPIO_AMP_INIT),
 	SND_PCI_QUIRK(0x103c, 0x861f, "HP Elite Dragonfly G1", ALC285_FIXUP_HP_GPIO_AMP_INIT),
 	SND_PCI_QUIRK(0x103c, 0x869d, "HP", ALC236_FIXUP_HP_MUTE_LED),
-- 
2.43.0



Return-Path: <linux-kernel+bounces-48108-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4D8D845753
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 13:22:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 778A2B258F4
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 12:22:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1436D15DBC0;
	Thu,  1 Feb 2024 12:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dd/CU1EV"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 146DE15DBA6;
	Thu,  1 Feb 2024 12:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706790128; cv=none; b=N7l+oHf4auzFLbSj5wGll3lCnv0ON7KXRBloMWuM/VJG75fvTMZ5C7eW/Dfuw0s42TioICHMFTWk9tO4fD3REIcxpk+TF7d4n3IdP4AycAW0FsFlvglxLbFvdUznsuUrehX2ZRsI3CMf3ow9Yn/3trWB4EDUjhJ09SQNddqgS04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706790128; c=relaxed/simple;
	bh=Mo3g/8cqomXn8ixe5bxoeElp6dyY7KpGNezYRF7gozc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ukLvx+99YDF8o3WdkfxNd3YIModLSxCSIFwHLgLXSVvQurw9UQKzrHKF4a/em0uuSDALtRFO8T0Vu5VLhfplpcYTuegrVE2/zAcqdjFa79UDbobqEsZIUIG/aXBD3ZLWD5ieiTRiJsySAkumYdeX+7l4L5dQ+HKWPos5VzOifjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dd/CU1EV; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-6de0f53f8e8so1578851b3a.0;
        Thu, 01 Feb 2024 04:22:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706790126; x=1707394926; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=P+0tF3oqmWl88v5P0WDQqvV2piKFSEOQwx64jG9GX/g=;
        b=dd/CU1EVN3wJdZBHHapkCQzyCkg0Q8IQqlskVp210EOwcG4hwIJKEsMgn0gmQg8sy+
         upfd3A/sd5P0Lox10aIWnKEUd7yqR4cH2D31ZTLq1VIYtaPet2M6w1GIjaemP11JNInT
         gGUyt1DAIKm5kasapH8D8G4QuESOAMSlHEXb+aQPRX5eY2TOb5sORB9+cp/Jny9rQ3ph
         v9/RADRbsjKQ9OF7j9VKn+oQo8RAZvNxVTwhzMJ7H5QkPJPyibj8ukmRA/AglxrXjd7a
         voT9pHZNLP1M92NTM4VQ/itiD1CiGA8HuckmTs/EeFbA3+N19v/GO+t4dXgKzbkR83v7
         m3Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706790126; x=1707394926;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P+0tF3oqmWl88v5P0WDQqvV2piKFSEOQwx64jG9GX/g=;
        b=d/CI706mFF1KCMoBxlwfgOTMdO+tnLicgJ8U5R+IlWZojlcHigTdt4KmqLkx6QdrTs
         rL1tj2BMYRrELCcmVKUkSeFzeTJ0AkidMh2ogB68kSBvoymAw+ua1XJX8US1CI/Naoc9
         PM2L0TucMNTMb0vCTLNJJ7wlqkc7+Hry/gvwS6lDMUJoPBL7D/toTDrPBIHOuCwEDmWx
         TbtuP+9VaHtZky0nxy/i0TZk+MpwimllIjprVsvXGRYJZdXtTeN6hcvMXOTZKx8WXKo6
         W2MSb9KXrNtAMRnMxycuaApmdtcV3kircfsQ6jVFVx4LLsxJ77H/JgKLFNQUWOxXr2sv
         k5kw==
X-Gm-Message-State: AOJu0Yz1j0HwRQYCoBtKy4xJme+w8M5xpOeJKff/yeGKkqfnmcfpF/TX
	A1dsSPxGf9ZWOcE65k074L1mV6Jyv+BUq/aIBJNSPCidpHJ/LV9H
X-Google-Smtp-Source: AGHT+IG9gpalsHvSnUxG7Yy8G0uxD3AHxw960cD+IgMRdCRWYT1npBwaey2rQ8AU3FjJoh5SPnm9Vg==
X-Received: by 2002:a05:6a20:5488:b0:19e:2d00:10c6 with SMTP id i8-20020a056a20548800b0019e2d0010c6mr9710167pzk.23.1706790126178;
        Thu, 01 Feb 2024 04:22:06 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWZ8y9IWd+JVNOWEgD5RZ41nNxvIcSPAs/ylZWl4Vu73kE0OyGH5yy1PGj+dihySpi1brvoN11cC2zSOIR2fWwDnBWvoDMAFKYSPNx94xVfriRnrYA+yX7V3MVHr0KnezZJl5+Ivg4ehQoFzxASw+lb9vbaYqTLlrGhzPoMQbFzB2WcYyvqjL4AVQQtWhNQYs4CKH1u7/fFMpSgNjmNL5fZkpamqZ5/jHpo399XHOY/ry7JINovAMFWJqO2gMWDJqL1Kh0bFuhqGEpIf6N0pH3HOtHvP0J4awqQPOAWrGCLei0BXoSpPqrVVk+4Dt5tx2vJTLEkrKx8jUTNqqD6wl+6EYq/qvr9yIMVHJbVRB19amlzOmZp6BzSo2fwqQhbiehbHwtQLbY2McWa94qnw/E=
Received: from localhost.localdomain ([187.17.230.203])
        by smtp.gmail.com with ESMTPSA id l2-20020a63f302000000b005cd8044c6fesm12363894pgh.23.2024.02.01.04.22.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Feb 2024 04:22:05 -0800 (PST)
From: Edson Juliano Drosdeck <edson.drosdeck@gmail.com>
To: tiwai@suse.com
Cc: perex@perex.cz,
	sbinding@opensource.cirrus.com,
	kailang@realtek.com,
	luke@ljones.dev,
	andy.chi@canonical.com,
	shenghao-ding@ti.com,
	ruinairas1992@gmail.com,
	vitalyr@opensource.cirrus.com,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	edson.drosdeck@gmail.com
Subject: [PATCH] ALSA: hda/realtek: Enable headset mic on Vaio VJFE-ADL
Date: Thu,  1 Feb 2024 09:21:14 -0300
Message-Id: <20240201122114.30080-1-edson.drosdeck@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Vaio VJFE-ADL is equipped with ALC269VC, and it needs
ALC298_FIXUP_SPK_VOLUME quirk to make its headset mic work.

Signed-off-by: Edson Juliano Drosdeck <edson.drosdeck@gmail.com>
---
 sound/pci/hda/patch_realtek.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index f6f16622f9cc..c7e8b27d486e 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -10322,6 +10322,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1d72, 0x1945, "Redmi G", ALC256_FIXUP_ASUS_HEADSET_MIC),
 	SND_PCI_QUIRK(0x1d72, 0x1947, "RedmiBook Air", ALC255_FIXUP_XIAOMI_HEADSET_MIC),
 	SND_PCI_QUIRK(0x2782, 0x0232, "CHUWI CoreBook XPro", ALC269VB_FIXUP_CHUWI_COREBOOK_XPRO),
+	SND_PCI_QUIRK(0x2782, 0x1707, "Vaio VJFE-ADL", ALC298_FIXUP_SPK_VOLUME),
 	SND_PCI_QUIRK(0x8086, 0x2074, "Intel NUC 8", ALC233_FIXUP_INTEL_NUC8_DMIC),
 	SND_PCI_QUIRK(0x8086, 0x2080, "Intel NUC 8 Rugged", ALC256_FIXUP_INTEL_NUC8_RUGGED),
 	SND_PCI_QUIRK(0x8086, 0x2081, "Intel NUC 10", ALC256_FIXUP_INTEL_NUC10),
-- 
2.39.2



Return-Path: <linux-kernel+bounces-63101-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EA2C852AEF
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 09:23:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 156C32820CB
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 08:23:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2888C22618;
	Tue, 13 Feb 2024 08:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iPh2cO4z"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B44922208A;
	Tue, 13 Feb 2024 08:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707812514; cv=none; b=P2/+Aq+u0wyUQFwbvqyl7Nmk+/6y1oEwEVy6c/H+xGS3A5ncbBiQlDuPMO/QtIXzNJBlvc7X3iZ6jTbloTKbKGRw6bAlUV9pu06byeESOdpeTazX8BYtJ+LAlIUiQ8vKdNaGdBCr+BG0f7TgzzZ1Vl6ZmmqHSuxjp4OipM9gcmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707812514; c=relaxed/simple;
	bh=EvesecZhCS+F8B4ydJvfk8KC+jJVk5kwfen9WAPTcVE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hgfeV6g9uICsXujesH6YBe2mzbS5jQnvLKpyOEqb3FWlcMUerzg+nagJcCglKG5or7R/AbKfXmjga6e9jMrL3KPYrWUc0Mq17sPxh90yuoBuWJw6XGNsQ+TeBv2c3HSndr6TKxwCj9TKiJLwftsVw7u0XQ8PmzhcoR+Urd2AuhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iPh2cO4z; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-56003c97d98so4846961a12.3;
        Tue, 13 Feb 2024 00:21:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707812511; x=1708417311; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hww4KX6AuerRDewZUOzhuppFnbJN24s7IBnlzI92hEg=;
        b=iPh2cO4zV4YMNpILe9Ewbdhy5iEoYR/t5hhuD/GmiFV90Bp3/qOyC0CFIkbfDXz+YP
         xHSR+m1lGjiHICMvADO9wie1fzcQs5jSm3jDwhFZaM6Uk+8k1AEADCaKO0a/zCSWYjD8
         Wmfi9Gd46lOB5RBUwo1kSEQ0IHO7FbuXAtdl2e+e6szNnOrFmIvM/cPxwB1HjQq2ErV8
         gq+rNB9mPjwEUjSOp4or28y5Z/f3NbOATqgXHa5ZtUyIh3lAPwAY7ZBUm2i1tJLzrXk2
         9TgWcOEiYF0VcVQYqVn6JLJjknOlzbP1mQC9Yo7mbqcD+nRXLYSJ9balg/LYbBrjjzJO
         hfOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707812511; x=1708417311;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hww4KX6AuerRDewZUOzhuppFnbJN24s7IBnlzI92hEg=;
        b=m29bPlM3zpfrVlNXcDyJSQtsH6UG9ikTwT9FDfcsaiVHWGmIfJte0+7qox4SPtzIeT
         xkwAM28XgofxTvy7zB4oiEZVUHET78c4DTb7fG2aZew3Zu23x8nVxMHt04ZF+h8FjTQs
         vqkXbQ7VR6kINFsBpjfoxEp6arKdorAYfdsdIzR2vyGT/PE3IwZOTgGO7lsm6o6pJ9Zs
         yyQJsTRog4PfRopQao9UeEpQMHha3vZyd6Ff1xOVpumlouNWxta77ezCIV6obl3B8PKc
         Fk+paw3HX2OteK4Nlu/2tnQvQBTXYmBqz5WYEOfyqBQ9gvFZR0gKiDqSR2c0J4G9hsav
         RU6A==
X-Forwarded-Encrypted: i=1; AJvYcCU/u93C4wA1U+QwVxHv7OOO7D+8wcrr0mqLTZdhe6wzOBDHeE3J5Yves3Wrs81bB3pt3nFtWfQ6yBEbSYrpbKiDIPtpzBfOq+S5zqWBZLgmkPy0sRxxNxcrbzTiIo6o/+3SWUzEPMv59ws=
X-Gm-Message-State: AOJu0Yx9Ax5uug+3RSietGC8kJua0GJpnMrW10KtxDiMwaZkAQU2/OwJ
	cqo0DG2Kk+LK5ygVZkvPcr+dbAX+8EBQHkxkf//Kr2mBmyXSUVDb
X-Google-Smtp-Source: AGHT+IEtbOgAQCr2q9wNkojH1FVB5yqlZL4vx2tEJYwJ0iwk5cxr4EarSrt3PNOwz/J1gIq7ItlMMQ==
X-Received: by 2002:a17:906:3755:b0:a3c:9ad4:b8ff with SMTP id e21-20020a170906375500b00a3c9ad4b8ffmr4179109ejc.49.1707812510698;
        Tue, 13 Feb 2024 00:21:50 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUsW2MBxSOX85UTqI3VynXX3cao1HNaEQjG8oN1kRIdQqMfckBiAidkpBjgOk3hEe0AWVG5To5wB0IaewSmr+n+mSe6soBntPCGASJngzEHoTxp7u+Fq61wWHw3lx4H8uOKzHbKsAISoXq30d5iL90WBf/IujhptnRvkWpj2bY3tuYCWXeCAPnVbjOV0BSDSUdhaqRpWpb0WEcRZ0Qx0r/KcE030I6+qwErlOMDDF4KmJB25NQZZ4Ph4PyQUmnB8vaJCfD2HS6aHbMHzrxwV1Q6nd7Ml+Oh10LMLC7U1+gSufr7vnCnc+K2vPFWRV9xxLsaPcgzjH0YW+PlhPpoEw7lJN4wUI2BSA2SbpijbjHIQHEnaT3wAU9OUw19CbaIKk/B1usYDzhIFMy9y8C7F6C2eKjiyj5mWG8+6PQj9qHlNVp5LoCjLjWc+JKO5jEH2ErRMiU6Gk4rK8uR510MPoJHaiSHbA0O25ihOeG/ep/qnl8fqCWJGEqU4jIwq5Gv6llMsq1dX2t25wseG/gHiPQ8XhCLhHVye5Rg0P8vhMdCNpzY
Received: from tkudela.. (c156-103.icpnet.pl. [85.221.156.103])
        by smtp.gmail.com with ESMTPSA id hw13-20020a170907a0cd00b00a3cf2f71408sm594983ejc.152.2024.02.13.00.21.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 00:21:50 -0800 (PST)
From: Tomasz Kudela <ramzes005@gmail.com>
To: ramzes005@gmail.com
Cc: alsa-devel@alsa-project.org,
	andy.chi@canonical.com,
	david.rhodes@cirrus.com,
	james.schulman@cirrus.com,
	kailang@realtek.com,
	linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org,
	luke@ljones.dev,
	patches@opensource.cirrus.com,
	perex@perex.cz,
	rf@opensource.cirrus.com,
	ruinairas1992@gmail.com,
	sbinding@opensource.cirrus.com,
	shenghao-ding@ti.com,
	tiwai@suse.com,
	vitalyr@opensource.cirrus.com
Subject: [PATCH v2] Add Lenovo Legion 7i gen7 sound quirk
Date: Tue, 13 Feb 2024 09:21:16 +0100
Message-Id: <20240213082116.15049-1-ramzes005@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240212193327.59507-1-ramzes005@gmail.com>
References: <20240212193327.59507-1-ramzes005@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "T. Kudela" <ramzes005@gmail.com>

Add sound support for the Legion 7i gen7 laptop (16IAX7).

Signed-off-by: Tomasz Kudela <ramzes005@gmail.com>
---
 sound/pci/hda/cs35l41_hda_property.c | 2 ++
 sound/pci/hda/patch_realtek.c        | 1 +
 2 files changed, 3 insertions(+)

diff --git a/sound/pci/hda/cs35l41_hda_property.c b/sound/pci/hda/cs35l41_hda_property.c
index d74cf11eef1e..8a6b484b2184 100644
--- a/sound/pci/hda/cs35l41_hda_property.c
+++ b/sound/pci/hda/cs35l41_hda_property.c
@@ -95,6 +95,7 @@ static const struct cs35l41_config cs35l41_config_table[] = {
 	{ "10431F12", 2, INTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 0, 1, -1, 1000, 4500, 24 },
 	{ "10431F1F", 2, EXTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 1, -1, 0, 0, 0, 0 },
 	{ "10431F62", 2, EXTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 1, 2, 0, 0, 0, 0 },
+	{ "17AA386F", 2, EXTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 0, 1, -1, 0, 0, 0 },
 	{ "17AA38B4", 2, EXTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 0, 1, -1, 0, 0, 0 },
 	{ "17AA38B5", 2, EXTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 0, 1, -1, 0, 0, 0 },
 	{ "17AA38B6", 2, EXTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 0, 1, -1, 0, 0, 0 },
@@ -431,6 +432,7 @@ static const struct cs35l41_prop_model cs35l41_prop_model_table[] = {
 	{ "CSC3551", "10431F12", generic_dsd_config },
 	{ "CSC3551", "10431F1F", generic_dsd_config },
 	{ "CSC3551", "10431F62", generic_dsd_config },
+	{ "CSC3551", "17AA386F", generic_dsd_config },
 	{ "CSC3551", "17AA38B4", generic_dsd_config },
 	{ "CSC3551", "17AA38B5", generic_dsd_config },
 	{ "CSC3551", "17AA38B6", generic_dsd_config },
diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 6994c4c5073c..0029f61d4693 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -10260,6 +10260,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x17aa, 0x3853, "Lenovo Yoga 7 15ITL5", ALC287_FIXUP_YOGA7_14ITL_SPEAKERS),
 	SND_PCI_QUIRK(0x17aa, 0x3855, "Legion 7 16ITHG6", ALC287_FIXUP_LEGION_16ITHG6),
 	SND_PCI_QUIRK(0x17aa, 0x3869, "Lenovo Yoga7 14IAL7", ALC287_FIXUP_YOGA9_14IAP7_BASS_SPK_PIN),
+	SND_PCI_QUIRK(0x17aa, 0x386f, "Legion 7i 16IAX7", ALC287_FIXUP_CS35L41_I2C_2),
 	SND_PCI_QUIRK(0x17aa, 0x3870, "Lenovo Yoga 7 14ARB7", ALC287_FIXUP_YOGA7_14ARB7_I2C),
 	SND_PCI_QUIRK(0x17aa, 0x387d, "Yoga S780-16 pro Quad AAC", ALC287_FIXUP_TAS2781_I2C),
 	SND_PCI_QUIRK(0x17aa, 0x387e, "Yoga S780-16 pro Quad YC", ALC287_FIXUP_TAS2781_I2C),
-- 
2.34.1



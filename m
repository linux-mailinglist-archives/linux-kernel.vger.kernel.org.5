Return-Path: <linux-kernel+bounces-24861-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 246E182C39D
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 17:35:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C9F21F23B51
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 16:35:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04A67768E7;
	Fri, 12 Jan 2024 16:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eKxUNkex"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEC1C74E2A;
	Fri, 12 Jan 2024 16:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-337874b8164so1585763f8f.2;
        Fri, 12 Jan 2024 08:35:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705077316; x=1705682116; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LlIMTu749xK+G2nXubgKLsCYahSVNlgmIkXmTS0PwKs=;
        b=eKxUNkexotkQSlpuTCUQ/IJJiW9VMbMxHXDF+/t+X+viomZBY1wu25N8YOqYUG6ZlB
         v8rJeyx3kTgcnKQSCYjxtllh5xApe+eCzBiuf3R3W/XbSaHYf3yn5lyG7IvdEMy5O95C
         7zb8nh3/LV/W2ITCdCoBYF9GRr9E81BiMItbZ22GmMxguRcCfu9RExjCBg7nytBLCe8u
         XNjZYFT81aDNctFRjglRxnDmmOTo8IDqHBZ7TNK8ryvWrW/TmTrMmiUIbCFsz39LZoIw
         TQVGAin2edmRPwLOlsqqJUqjVa/fDWl7bO6atIOYjUE75WMuUim87ALt9vLENXxneQoL
         goLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705077316; x=1705682116;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LlIMTu749xK+G2nXubgKLsCYahSVNlgmIkXmTS0PwKs=;
        b=IV4FZDtpY/VR1x+9p43THj6tjx5mRsUv4EDOkJvNH77ZO7437TlAcZtdWSZ8xSlkjK
         O7k39VqoG32rfhvo5/1NgxhHZRwShI+cvwyehAjs3ChLZA6VDBKwDS11Xu2565pjuxfs
         Qwfa3fwl7n+2aPELwAbhBCGmB2f5mL0FX5iSFc2zpnuQ9JW7BvjkBvWO6Ip2dap02bKI
         fUt546v7pSgJd6jUgcgj8Jku+jZLreujlZjYzaBfAS0eXLkjoioe8x6+NXfStajf3f7f
         Tkd3uxxXtbZJ3MfMfP65W+oEgmY1s/c049jJ5ANa3lpf86fXToKHHmCldEmLW4sEuCLR
         x/aA==
X-Gm-Message-State: AOJu0YypruvUSYWfcpJ9zrSTtWwANyae5ZbLzpRunhUl44aMBL3QmSx9
	woUr+scr1WczP2+REYVqY2Y=
X-Google-Smtp-Source: AGHT+IHIaYT4sw8rtu3Wb5cOS37Igtd1/bCisVWU7eVb4vG7lRY3sMPZwc5lgYivI8nUeoVlHEFP9g==
X-Received: by 2002:a05:6000:11d1:b0:333:2fd2:5d1a with SMTP id i17-20020a05600011d100b003332fd25d1amr1025646wrx.76.1705077315961;
        Fri, 12 Jan 2024 08:35:15 -0800 (PST)
Received: from kenzo-linux-laptop.bicolor-pike.ts.net (154.red-88-26-51.staticip.rima-tde.net. [88.26.51.154])
        by smtp.gmail.com with ESMTPSA id h18-20020adf9cd2000000b00336a1f6ce7csm4298766wre.19.2024.01.12.08.35.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jan 2024 08:35:15 -0800 (PST)
From: Kenzo Gomez <kenzo.sgomez@gmail.com>
To: sbinding@opensource.cirrus.com
Cc: Kenzo Gomez <kenzo.sgomez@gmail.com>,
	James Schulman <james.schulman@cirrus.com>,
	David Rhodes <david.rhodes@cirrus.com>,
	Richard Fitzgerald <rf@opensource.cirrus.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	alsa-devel@alsa-project.org,
	patches@opensource.cirrus.com,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ALSA: hda: cs35l41: Support additional ASUS Zenbook UX3402VA
Date: Fri, 12 Jan 2024 17:32:15 +0100
Message-ID: <20240112163239.59743-1-kenzo.sgomez@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add new model entry into configuration table.

Signed-off-by: Kenzo Gomez <kenzo.sgomez@gmail.com>
---
 sound/pci/hda/cs35l41_hda_property.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/pci/hda/cs35l41_hda_property.c b/sound/pci/hda/cs35l41_hda_property.c
index c1afb721b4c6..adfb31a6bf1e 100644
--- a/sound/pci/hda/cs35l41_hda_property.c
+++ b/sound/pci/hda/cs35l41_hda_property.c
@@ -67,6 +67,7 @@ static const struct cs35l41_config cs35l41_config_table[] = {
 	{ "10431D1F", I2C, 2, INTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 0, 1, -1, 1000, 4500, 24 },
 	{ "10431DA2", SPI, 2, EXTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 1, 2, 0, 0, 0, 0 },
 	{ "10431E02", SPI, 2, EXTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 1, 2, 0, 0, 0, 0 },
+	{ "104316A3", SPI, 2, EXTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 1, 2, 0, 0, 0, 0 },
 	{ "10431EE2", I2C, 2, EXTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 0, -1, -1, 0, 0, 0 },
 	{ "10431F12", I2C, 2, INTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 0, 1, -1, 1000, 4500, 24 },
 	{ "10431F1F", SPI, 2, EXTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 1, -1, 0, 0, 0, 0 },
@@ -371,6 +372,7 @@ static const struct cs35l41_prop_model cs35l41_prop_model_table[] = {
 	{ "CSC3551", "10431D1F", generic_dsd_config },
 	{ "CSC3551", "10431DA2", generic_dsd_config },
 	{ "CSC3551", "10431E02", generic_dsd_config },
+	{ "CSC3551", "104316A3", generic_dsd_config },
 	{ "CSC3551", "10431EE2", generic_dsd_config },
 	{ "CSC3551", "10431F12", generic_dsd_config },
 	{ "CSC3551", "10431F1F", generic_dsd_config },
-- 
2.43.0



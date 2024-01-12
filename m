Return-Path: <linux-kernel+bounces-24964-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0602882C55B
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 19:24:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7F8BBB21A76
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 18:24:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6E5F25618;
	Fri, 12 Jan 2024 18:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ME5K2Wvg"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88C912560A;
	Fri, 12 Jan 2024 18:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-40d6b4e2945so78026195e9.0;
        Fri, 12 Jan 2024 10:24:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705083855; x=1705688655; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pTWj3rihL8bSDfLhEga4c9xLiiLPW6jDT6R2juZX/CY=;
        b=ME5K2Wvg+Ly1P0QIIXH02w1AXrfIzkpRFB1IDNNA4gQSGo5Kwy6bRImhx0gQL2Phwa
         LK1niqzLSlVd9PbkUDmilltdB6PcP96dCqt/CdXL/Z0BsPeXlpLl2H2H0JdAtkEfpsSW
         ccTa+8dADkTm01e+QqTBW+nnhGbejWN9FgbcYiumOFoYOckKBIQGjSfB5+T8CQZyVUFJ
         cwsEqKp8LXsTKL7lix1mlOyvYMNNnMnp+B/AaND4oEvvSU58koH0z6quGP7vQT8YZ3fA
         Xul82t6rPuLSSVFXTUFYTbbUKCh9InClf3raIUYQO83/wSGw3/I/lY6zjcF6BHRTeDAw
         cYiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705083855; x=1705688655;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pTWj3rihL8bSDfLhEga4c9xLiiLPW6jDT6R2juZX/CY=;
        b=hlAaDBeBrR3kBDCn+9N/67L6NhmIe5lOpNkiiX4QDpHyJUEiUv6VeQ+qNQ8sNMSlCb
         pbim+vg6DOt8wgLX8JV6qIIQfrfzlNorivJK8cQvYfZSm1gzs5ibiHVfDEdg3khJrJin
         v2EenQBbms/Sdq11klszsF2fSbLACx+sRTGUL5vP4sIi2+Z85HwwPu6VR++SpHjp/T0/
         PrZO1d/tVL/ML+mnvNDQcfyofYslajlJXLhaUwSiOAIzgZ2JH6wyyb8YcwhdpEg6eFgm
         K7lFUjIn3jkeW8gqnW7jJTCbutBQXEXhgCaIYutCqWPrwnxIGJr244NeR1Zv+iNQAzCv
         BsSw==
X-Gm-Message-State: AOJu0YwIl4QCdiy9GqjDjrPkXtkyRFdDS87yaT5RPuR8ylOp2lFs56U/
	8FEJv10bPuslUWZuinQx9M469rhXBWyULA==
X-Google-Smtp-Source: AGHT+IG7YWD6hzcwCjnkvQXzbiGmgtZPEtPzRB21len23MAiK4rXbujptBECL5ruziLhYjMSAtv0ig==
X-Received: by 2002:a05:600c:4286:b0:40e:68da:dd2d with SMTP id v6-20020a05600c428600b0040e68dadd2dmr285867wmc.17.1705083854527;
        Fri, 12 Jan 2024 10:24:14 -0800 (PST)
Received: from kenzo-linux-laptop.bicolor-pike.ts.net (154.red-88-26-51.staticip.rima-tde.net. [88.26.51.154])
        by smtp.gmail.com with ESMTPSA id g16-20020a05600c4ed000b0040d91912f2csm6694521wmq.1.2024.01.12.10.24.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jan 2024 10:24:14 -0800 (PST)
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
Subject: [PATCH v2] ALSA: hda: cs35l41: Support additional ASUS Zenbook UX3402VA
Date: Fri, 12 Jan 2024 19:20:34 +0100
Message-ID: <20240112182113.70650-1-kenzo.sgomez@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240112163239.59743-1-kenzo.sgomez@gmail.com>
References: <20240112163239.59743-1-kenzo.sgomez@gmail.com>
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
index c1afb721b4c6..9ec5773e580e 100644
--- a/sound/pci/hda/cs35l41_hda_property.c
+++ b/sound/pci/hda/cs35l41_hda_property.c
@@ -54,6 +54,7 @@ static const struct cs35l41_config cs35l41_config_table[] = {
 	{ "10431533", I2C, 2, INTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 0, 1, -1, 1000, 4500, 24 },
 	{ "10431573", SPI, 2, INTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 1, 2, 0, 1000, 4500, 24 },
 	{ "10431663", SPI, 2, INTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 1, -1, 0, 1000, 4500, 24 },
+	{ "104316A3", SPI, 2, EXTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 1, 2, 0, 0, 0, 0 },
 	{ "104316D3", SPI, 2, EXTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 1, 2, 0, 0, 0, 0 },
 	{ "104316F3", SPI, 2, EXTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 1, 2, 0, 0, 0, 0 },
 	{ "104317F3", I2C, 2, INTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 0, 1, -1, 1000, 4500, 24 },
@@ -358,6 +359,7 @@ static const struct cs35l41_prop_model cs35l41_prop_model_table[] = {
 	{ "CSC3551", "10431533", generic_dsd_config },
 	{ "CSC3551", "10431573", generic_dsd_config },
 	{ "CSC3551", "10431663", generic_dsd_config },
+	{ "CSC3551", "104316A3", generic_dsd_config },
 	{ "CSC3551", "104316D3", generic_dsd_config },
 	{ "CSC3551", "104316F3", generic_dsd_config },
 	{ "CSC3551", "104317F3", generic_dsd_config },
-- 
2.43.0



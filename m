Return-Path: <linux-kernel+bounces-6500-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 211BF8199AE
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 08:38:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 532B11C2218E
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 07:38:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBAA91CA93;
	Wed, 20 Dec 2023 07:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k2Ho7DVX"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F24D6171CA
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 07:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-54c5d041c23so6536683a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 23:38:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703057892; x=1703662692; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZHyUbHVpES213ODZcnBd6hLrNU+I64lailKfIQRqxos=;
        b=k2Ho7DVXmYzfAInGPcabCuJhxf77/FW7+PulZG63QkPTMRFzohR7dFzr6V3loy6iQF
         NsqWN2wiZ5jvv/eYeK1c55UZh4LFYGUiAPao1z0fc4m1cn0CX2iG3/ABHe2LdvoEWbBW
         JWfUGEDMqLaFVAHwDf9+ac/Z9d09pENXu2Q6pZcaAiCFYKl4xqX1abAJI6QxaKCryzvo
         I7I+z/zoWPgJA9jrQtwO+hnAPzSU5SHKIq1+BWJZStsUTlmchW4/4Xg93hQB/9Jd5Rjv
         pA3BDxjmdDe8mPcmDHxuMF4ogfaC1BBfK1P6/swvIwHmxY1/1gxPT985ZLzcGlB8WDZM
         +oZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703057892; x=1703662692;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZHyUbHVpES213ODZcnBd6hLrNU+I64lailKfIQRqxos=;
        b=GkEx9tsAEjSWNTvh4zwcquMmGTFDiCakltd/PO1E24NBzAzLpmjENRxS481VAUDecj
         u5HhYIbiw1HEOj8OtvA7ZI1L4zs8Gt3yW/8wr215lN1KuGxEnpfwu03hkEDpZjXlCohZ
         imvMCOzTMJxmNYlDp7Pn/tmxPKHYFay1QeJXG7Pw39GKL9HagdzAZ4piJdeDB2eRIg3M
         bn7ZROP/3PBz0TFfaK+jo1cVDxnaFfhn07lBe0/OwwdaIM/mlzG04IFF3b3ndPPKauES
         usheG3KO5Kylqubry+qW2nRXuG/lnJD5Cfaz2OlJi9auzhpB1vJUWjZhWdt6U1Mrxz7U
         BJRg==
X-Gm-Message-State: AOJu0YwtlCXWhMV5/0XoMZ1Mc5fyMfTYXZln4n3IoRbHmTZUd4fhN6nx
	gUuYYoxng0iNY28RLsP8KA==
X-Google-Smtp-Source: AGHT+IFq8fykuywISDMznNtD+bwpovn1I9rqNtzdYNP/Iv9ilU/ky9etGWkivuriBSkpv49QUETGbg==
X-Received: by 2002:a50:8753:0:b0:553:3354:297f with SMTP id 19-20020a508753000000b005533354297fmr1542463edv.59.1703057892157;
        Tue, 19 Dec 2023 23:38:12 -0800 (PST)
Received: from alex-pc-ubuntu.lan (31-10-153-16.cgn.dynamic.upc.ch. [31.10.153.16])
        by smtp.gmail.com with ESMTPSA id p7-20020a056402500700b0055283720ec3sm5979043eda.76.2023.12.19.23.38.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Dec 2023 23:38:11 -0800 (PST)
From: Aleksandrs Vinarskis <alex.vinarskis@gmail.com>
To: tiwai@suse.de
Cc: alex.vinarskis@gmail.com,
	alsa-devel@alsa-project.org,
	david.rhodes@cirrus.com,
	james.schulman@cirrus.com,
	josbeir@gmail.com,
	linux-kernel@vger.kernel.org,
	patches@opensource.cirrus.com,
	perex@perex.cz,
	sbinding@opensource.cirrus.com,
	stuarth@opensource.cirrus.com,
	tiwai@suse.com
Subject: [PATCH v2 2/2] ALSA: hda: cs35l41: Support Dell XPS 9530 (2023)
Date: Wed, 20 Dec 2023 08:38:09 +0100
Message-Id: <20231220073809.22027-3-alex.vinarskis@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231220073809.22027-1-alex.vinarskis@gmail.com>
References: <87ttokpyws.wl-tiwai@suse.de>
 <20231220073809.22027-1-alex.vinarskis@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add new model entries into configuration table.

Co-developed-by: Jasper Smet <josbeir@gmail.com>
Signed-off-by: Jasper Smet <josbeir@gmail.com>
Signed-off-by: Aleksandrs Vinarskis <alex.vinarskis@gmail.com>
---
 sound/pci/hda/cs35l41_hda_property.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/pci/hda/cs35l41_hda_property.c b/sound/pci/hda/cs35l41_hda_property.c
index cb305b093311..ee105743333f 100644
--- a/sound/pci/hda/cs35l41_hda_property.c
+++ b/sound/pci/hda/cs35l41_hda_property.c
@@ -41,6 +41,7 @@ static const struct cs35l41_config cs35l41_config_table[] = {
  * Since this laptop has valid ACPI, we do not need to handle cs-gpios, since that already exists
  * in the ACPI. The Reset GPIO is also valid, so we can use the Reset defined in _DSD.
  */
+	{ "10280BEB", SPI, 2, EXTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 1, -1, 0, 0, 0, 0 },
 	{ "103C89C6", SPI, 2, INTERNAL, { CS35L41_RIGHT, CS35L41_LEFT, 0, 0 }, -1, -1, -1, 1000, 4500, 24 },
 	{ "104312AF", SPI, 2, INTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 1, 2, 0, 1000, 4500, 24 },
 	{ "10431433", I2C, 2, INTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 0, 1, -1, 1000, 4500, 24 },
@@ -355,6 +356,7 @@ struct cs35l41_prop_model {
 static const struct cs35l41_prop_model cs35l41_prop_model_table[] = {
 	{ "CLSA0100", NULL, lenovo_legion_no_acpi },
 	{ "CLSA0101", NULL, lenovo_legion_no_acpi },
+	{ "CSC3551", "10280BEB", generic_dsd_config },
 	{ "CSC3551", "103C89C6", generic_dsd_config },
 	{ "CSC3551", "104312AF", generic_dsd_config },
 	{ "CSC3551", "10431433", generic_dsd_config },
-- 
2.40.1



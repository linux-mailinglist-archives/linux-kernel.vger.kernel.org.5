Return-Path: <linux-kernel+bounces-13406-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 85B9B8204A6
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Dec 2023 12:43:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C1AB71C20B0F
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Dec 2023 11:43:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96F3879E0;
	Sat, 30 Dec 2023 11:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P8ttRqSv"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76A327481;
	Sat, 30 Dec 2023 11:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-40d60a96533so30693275e9.1;
        Sat, 30 Dec 2023 03:43:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703936595; x=1704541395; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qvrLNC3g/wzxAt5MvFq+hYUdLZQM7U+bQ6kKSNvKMdo=;
        b=P8ttRqSv3oc0fejYUXtxsGch7A4bH2Vv8Nnv8hApq67kd9d5Pi6jd8f8r4bUN61lxs
         FPVhm56+StElVCcuEJhh57lg4YYIaWMSyk0s3ZRHgkTeLGwKYWuBkSmL3hg8ge9Fl/MD
         Sot4chW5pEjom2GEvFAzQJYMceS7V55lb/BAmSV/Bc9u5WpzvZtex7/RLEDah6XiXzg+
         99NKOGImUCK1qidVsww8vdTuIoPLLIRQLI613Gcm4KNmNsxDMXAZ394SBCs1RsrAavvC
         s0U3vudVxi5/tcZgMxe1aQ1oH2aFJF3vk0XgmTHWbGClxnm2bjtHTySYMoeXvZLF8/B7
         KtWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703936595; x=1704541395;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qvrLNC3g/wzxAt5MvFq+hYUdLZQM7U+bQ6kKSNvKMdo=;
        b=FTGkf1CUiyOfD7RA89J0TKvL4tJPTMP+0XrzCsvAd/7Ih4XhYLGbxkjASd+LEEXAxm
         7lZm6Nh7IWXRNRXrAVcKlyx+cqdW1+qmTjHmlIdZBtl3lbX+4jMR4RoBTau4xyD3dhtU
         TTRVpAQjGLU9gUkkp3opBDcmwxGiH63/N52UXmY1chTJyXSE9sEoswRSezPKQlSwkvXn
         IgoI43dt0bt413ce6qjRSXgcIZoEZs631GYBR/PH+4GNYxuHwk9Qad367gSy/wTknF+v
         R+uCoxvmLHYIRys+hFzyIg2PdKQFxjR8yJix+WfzMaMZ+/XxiuS9nH/Ph42xvdC3iGfZ
         c4QA==
X-Gm-Message-State: AOJu0Yw++A7isEq/mWUJf2mf4j835SxgGBp5oT2FkSDIkzH9E4/Ho3xT
	MIdmLqQMp+AunOzDQR1HnHc=
X-Google-Smtp-Source: AGHT+IF2hsAFPytjlDGngKmBi5SYH9/xT8jozGqndryZPjzVWQTFpFgzBFjbs714v/q7bbKsQM63HQ==
X-Received: by 2002:a05:600c:1994:b0:40d:5f45:fa2c with SMTP id t20-20020a05600c199400b0040d5f45fa2cmr2931815wmq.27.1703936595540;
        Sat, 30 Dec 2023 03:43:15 -0800 (PST)
Received: from localhost.localdomain ([2a02:842a:1ce:5301:f733:18af:2fff:3d3d])
        by smtp.gmail.com with ESMTPSA id z4-20020a5d4d04000000b00336a1f6ce7csm16845745wrt.19.2023.12.30.03.43.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Dec 2023 03:43:15 -0800 (PST)
From: Dorian Cruveiller <doriancruveiller@gmail.com>
To: james.schulman@cirrus.com,
	david.rhodes@cirrus.com,
	rf@opensource.cirrus.com,
	perex@perex.cz,
	tiwai@suse.com,
	alsa-devel@alsa-project.org,
	patches@opensource.cirrus.com,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Dorian Cruveiller <doriancruveiller@gmail.com>
Subject: [PATCH v2 2/2] Add driver properties for cs35l41 for Lenovo Legion Slim 7 Gen 8 serie
Date: Sat, 30 Dec 2023 12:43:12 +0100
Message-ID: <20231230114312.22118-1-doriancruveiller@gmail.com>
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

Add driver properties on 4 models of this laptop serie since they don't
have _DSD in the ACPI table

Signed-off-by: Dorian Cruveiller <doriancruveiller@gmail.com>
---
 sound/pci/hda/cs35l41_hda_property.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/sound/pci/hda/cs35l41_hda_property.c b/sound/pci/hda/cs35l41_hda_property.c
index be2b01b596c2..52820ca9c603 100644
--- a/sound/pci/hda/cs35l41_hda_property.c
+++ b/sound/pci/hda/cs35l41_hda_property.c
@@ -71,6 +71,10 @@ static const struct cs35l41_config cs35l41_config_table[] = {
 	{ "10431F12", 2, INTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 0, 1, -1, 1000, 4500, 24 },
 	{ "10431F1F", 2, EXTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 1, -1, 0, 0, 0, 0 },
 	{ "10431F62", 2, EXTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 1, 2, 0, 0, 0, 0 },
+	{ "17AA38B4", 2, EXTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 0, 1, -1, 0, 0, 0 },
+	{ "17AA38B5", 2, EXTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 0, 1, -1, 0, 0, 0 },
+	{ "17AA38B6", 2, EXTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 0, 1, -1, 0, 0, 0 },
+	{ "17AA38B7", 2, EXTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 0, 1, -1, 0, 0, 0 },
 	{}
 };
 
@@ -381,6 +385,10 @@ static const struct cs35l41_prop_model cs35l41_prop_model_table[] = {
 	{ "CSC3551", "10431F12", generic_dsd_config },
 	{ "CSC3551", "10431F1F", generic_dsd_config },
 	{ "CSC3551", "10431F62", generic_dsd_config },
+	{ "CSC3551", "17AA38B4", generic_dsd_config },
+	{ "CSC3551", "17AA38B5", generic_dsd_config },
+	{ "CSC3551", "17AA38B6", generic_dsd_config },
+	{ "CSC3551", "17AA38B7", generic_dsd_config },
 	{}
 };
 
-- 
2.43.0



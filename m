Return-Path: <linux-kernel+bounces-41321-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D101D83EEC4
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 17:47:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C9BF11C20DE9
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 16:47:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B10E2C6AC;
	Sat, 27 Jan 2024 16:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SPmD8xj9"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 111491E493;
	Sat, 27 Jan 2024 16:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706374061; cv=none; b=AEW3mCk81TFrixxHGiBUR+3IQdQEID7LYkLiGElWMu6CP3UlN1k5h03XyvZBhRTg35olSHBuW+mOzELBfUR8jhQd1TWbqSPw1wr8xOAPxaQJmfPNd0lvoDOT3OGOKYoCHL1PrGWk/1lih36wWU1uv0PrHZdrZjYhu62eSJNyNDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706374061; c=relaxed/simple;
	bh=P5inWfry6T1Czl6TsnTuVIoqd+ZhftxFosxgazH4yR8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mevy6hrbz81fGAoiGGVpp6jhcGzWHhn/PcfjCclq1O1X/d/sTO01uv2qSOrPrTPrgwRtb0AvcBPhObEcYUwZScm6AEE1hQ1Qa+B1kqFNDc0k/g+WqwhfEpEWXaH+TVznYimINfVAPqpwxE/EvhOJnflUS8NHv//Q/KMG1n9hyCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SPmD8xj9; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-40e76626170so21918605e9.2;
        Sat, 27 Jan 2024 08:47:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706374058; x=1706978858; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jq5nWV4gc+boSoV96VgLy7nj/n+DgQjkGxXgMwyJKWg=;
        b=SPmD8xj9CHzf23D9cFGsX0aOts6W+BZi1tIlZMWEd2K04bbdeCjxURuIoNWnQQYyBn
         vzYBIgDopQjk/FBgEKnKRAb7omH2CzYjGIpUxn2RFADCt9IpfOlmv0KfTylQRicrqtpU
         QfiNWIu1/0IwQMgI9T081kgahwa+Fu2+iR/DNaItiNkhDhhxB650/yaP0Yh7Ok6zKgDt
         F0aNE3ZBA708lG3jP+3BXg7qGokVb6UkqRLeZ4N52iJLZWCg6tefScjnq+mCVlPQy1KB
         KKS2m/V0DsTJ9m6N0jZFoMdeXrbJ7L9cYHBGNeUXkuzoxCZTzS+5iK3Cx+CfT+Eg2ssS
         /20Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706374058; x=1706978858;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jq5nWV4gc+boSoV96VgLy7nj/n+DgQjkGxXgMwyJKWg=;
        b=FX/F65N2dhizPOTtO4ALFqj4kKJugEt3d76PCCOv5ZaADKxEQO+SG+VG0anTkNKFe+
         3Kydk6vjLuNC1mY+9nvCePXG4xOSLV9U/eRzTHuERbaq6JHLTvy4fER4XUh7nsGVLGMJ
         s089KGC7s4qej7Ce0zsskg3PSMhsLSl/TTTN20TghEbWjXKE+533mavg6tYf4QbhkLBz
         IgX5yDo9ONhfQeDxql4S/azPw2geuvgKHQgEk4Go8cpygtL/8DfFkmJMJfb5X4lIXX2x
         f67HLh/wc9r2nefVlzenVjTp7zbW0f9qCoHQtJTDB2W5q1eCGl/UUAENlvjoRtVcYzIE
         Ewig==
X-Gm-Message-State: AOJu0YxffyKUTDzgBeK9YqpVFf9uVJVCJgGbWxBt1uZFDPWgj6Zu7/Rv
	0LnOBxYXXn4OeTHGKper5tUqT2k/PvnyvgmoRapMq24i52vwIzyq
X-Google-Smtp-Source: AGHT+IG4fFkwwlanBWpqJW1F0dTLbqKbMH0i4rK9ABL48tuKQ/mudc3Aug7IIsmMoMMeS0psJTUOlQ==
X-Received: by 2002:a05:600c:4ec8:b0:40e:ace6:4fc2 with SMTP id g8-20020a05600c4ec800b0040eace64fc2mr1439967wmq.24.1706374058012;
        Sat, 27 Jan 2024 08:47:38 -0800 (PST)
Received: from kenzo-linux-laptop.bicolor-pike.ts.net (154.red-88-26-51.staticip.rima-tde.net. [88.26.51.154])
        by smtp.gmail.com with ESMTPSA id i9-20020a05600c354900b0040eee435571sm1895013wmq.45.2024.01.27.08.47.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Jan 2024 08:47:37 -0800 (PST)
From: Kenzo Gomez <kenzo.sgomez@gmail.com>
To: tiwai@suse.de
Cc: alsa-devel@alsa-project.org,
	david.rhodes@cirrus.com,
	james.schulman@cirrus.com,
	kenzo.sgomez@gmail.com,
	linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org,
	patches@opensource.cirrus.com,
	perex@perex.cz,
	rf@opensource.cirrus.com,
	sbinding@opensource.cirrus.com,
	tiwai@suse.com
Subject: [PATCH v3] ALSA: hda: cs35l41: Support additional ASUS Zenbook UX3402VA
Date: Sat, 27 Jan 2024 17:46:21 +0100
Message-ID: <20240127164621.26431-1-kenzo.sgomez@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <874jfdwsfg.wl-tiwai@suse.de>
References: <874jfdwsfg.wl-tiwai@suse.de>
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
index 35277ce890a4..59504852adc6 100644
--- a/sound/pci/hda/cs35l41_hda_property.c
+++ b/sound/pci/hda/cs35l41_hda_property.c
@@ -76,6 +76,7 @@ static const struct cs35l41_config cs35l41_config_table[] = {
 	{ "10431533", 2, INTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 0, 1, -1, 1000, 4500, 24 },
 	{ "10431573", 2, INTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 1, 2, 0, 1000, 4500, 24 },
 	{ "10431663", 2, INTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 1, -1, 0, 1000, 4500, 24 },
+	{ "104316A3", 2, EXTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 1, 2, 0, 0, 0, 0 },
 	{ "104316D3", 2, EXTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 1, 2, 0, 0, 0, 0 },
 	{ "104316F3", 2, EXTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 1, 2, 0, 0, 0, 0 },
 	{ "104317F3", 2, INTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 0, 1, -1, 1000, 4500, 24 },
@@ -410,6 +411,7 @@ static const struct cs35l41_prop_model cs35l41_prop_model_table[] = {
 	{ "CSC3551", "10431533", generic_dsd_config },
 	{ "CSC3551", "10431573", generic_dsd_config },
 	{ "CSC3551", "10431663", generic_dsd_config },
+	{ "CSC3551", "104316A3", generic_dsd_config },
 	{ "CSC3551", "104316D3", generic_dsd_config },
 	{ "CSC3551", "104316F3", generic_dsd_config },
 	{ "CSC3551", "104317F3", generic_dsd_config },
-- 
2.43.0



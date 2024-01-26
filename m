Return-Path: <linux-kernel+bounces-39749-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C694883D5B0
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 10:13:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2EC0AB260C7
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 09:13:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66E576BB2B;
	Fri, 26 Jan 2024 08:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e+dUfNQK"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4463A63A;
	Fri, 26 Jan 2024 08:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706256635; cv=none; b=UjfjldnexlZGyU7j55jPx3WGpDGC8bucxcf439gVPeOSo6XCg2AztVaWX0PDkQ/RwgD1fIvxqh9+3wJNrmAXOKs9fUj68b90XAyZhzwtfA0qqgP+pkjzB2GHyVQ6i2vm2HX9WN/F7aqjTRFUYGL7843pezuet22XstZ3a/Y2qQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706256635; c=relaxed/simple;
	bh=2k8JQREzbKJEsbJpI95q160VXYyJ08a0uiksUeW2oZ8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nzsqL1gREWwNUp68yw/Va31OR0sryg7nvtCkkP5qR+exGESeDnnMZHFKqwDpywEV/Pvr3fB7q8z7/aEg6eI/GBXohrjSFSfrWXWagzPYgwH4nkH2bVIVMsWfCWMqK/QHeHKOi+pY7Ni078hu39mn3ROtI1HW+fLLnk+25erT2ZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e+dUfNQK; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-6dddc5e34e2so79648b3a.0;
        Fri, 26 Jan 2024 00:10:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706256633; x=1706861433; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nELBdfPl4AQ5uJ/P9USF4aInhb1zNUypDMneqWNj1G0=;
        b=e+dUfNQKmE+FbzArhJefZoCJ03K8/ttSqGD1YFtNz9h/uGAL0ElFeUpxoHiz0SDd4X
         SLKFUFnnC5reoeaidzswroZGATt9f6WukMoFoAHETqEDcIWAL1fTwZhEzO9fvA/qW85C
         lwsLN13BI138QdATMtmeNLTWsM1RelWdDRfZMJyYVz9pchTOX21dFB98Q0RgveQsOHlT
         yBiz8RPwuy4NoO0Hh1BozBEhLdF2NigU0cqsEOVbr0qMbsh4mthE5uzoGUxjo/gMUdJg
         ZeFXl2h8SnOoFLL7rXY2RpJq1UPHsbbBkPkXn7ICGW4cKNpR228wsynCkFJUGUuIb77V
         zLBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706256633; x=1706861433;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nELBdfPl4AQ5uJ/P9USF4aInhb1zNUypDMneqWNj1G0=;
        b=rcHsAmZcXT30qWxbnEkdu4Hfx2IA6k4TqVLslVSbCsa/m6EWwviYX6d8BL7vWypZHx
         3H1OSSaPAU61WbeGHN9PULk/DgpE3Y96laaTw8bdImBKtQGrOEpGjLY4rBow4W5dP1gI
         AzcbZfDNnEepZ0QswuqseEZFs8O7pxUqpeYyYYRcEZ2KzoVIDTb1rzjsfmHxTqHhUIR0
         bo6bDv65PXKejCWDNC91HC2xVL/T8Xg4tIUkuQ0/1DaTT3gTR2cm7uz+4gZtwGlN5Hh9
         0I7EbY2V6bEdhXR5bG7k+HIVX24Ilu24B5TIiI+Jx6s7qQxdNridc2NCz0muFCL0fuct
         w5+g==
X-Gm-Message-State: AOJu0Yxx0KF4gwrKsl2f16PQ22l2MSqWZqi+fFz7O6H2TwBYPwDnJgMz
	IUZYaGLjQQN4jPgWbR+azNoPT/f07ev8OudvHswX7jQOMS6epAYN
X-Google-Smtp-Source: AGHT+IHGE4d3r5oPSndwRCufRq2TEcmfDoEFq+Uu0uhZPgljgZJDpVKhMZNkV1x5Mf0sWyGONMJnxQ==
X-Received: by 2002:a05:6a00:c92:b0:6dd:c0a5:3f2e with SMTP id a18-20020a056a000c9200b006ddc0a53f2emr783610pfv.25.1706256633452;
        Fri, 26 Jan 2024 00:10:33 -0800 (PST)
Received: from localhost.localdomain ([51.79.240.130])
        by smtp.gmail.com with ESMTPSA id f14-20020a056a00228e00b006dde27853afsm626942pfe.113.2024.01.26.00.10.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jan 2024 00:10:33 -0800 (PST)
From: Chhayly Leang <clw.leang@gmail.com>
To: Stefan Binding <sbinding@opensource.cirrus.com>,
	Takashi Iwai <tiwai@suse.com>,
	patches@opensource.cirrus.com
Cc: James Schulman <james.schulman@cirrus.com>,
	David Rhodes <david.rhodes@cirrus.com>,
	Richard Fitzgerald <rf@opensource.cirrus.com>,
	Jaroslav Kysela <perex@perex.cz>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chhayly Leang <clw.leang@gmail.com>
Subject: [PATCH] ALSA: hda: cs35l41: Support ASUS Zenbook UM3402YAR
Date: Fri, 26 Jan 2024 15:09:12 +0700
Message-ID: <20240126080912.87422-1-clw.leang@gmail.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adds sound support for ASUS Zenbook UM3402YAR with missing DSD

Signed-off-by: Chhayly Leang <clw.leang@gmail.com>
---
 sound/pci/hda/cs35l41_hda_property.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/pci/hda/cs35l41_hda_property.c b/sound/pci/hda/cs35l41_hda_property.c
index 35277ce890a..2af083183d8 100644
--- a/sound/pci/hda/cs35l41_hda_property.c
+++ b/sound/pci/hda/cs35l41_hda_property.c
@@ -76,6 +76,7 @@ static const struct cs35l41_config cs35l41_config_table[] = {
 	{ "10431533", 2, INTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 0, 1, -1, 1000, 4500, 24 },
 	{ "10431573", 2, INTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 1, 2, 0, 1000, 4500, 24 },
 	{ "10431663", 2, INTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 1, -1, 0, 1000, 4500, 24 },
+	{ "10431683", 2, EXTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 0, 1, -1, 0, 0, 0 },
 	{ "104316D3", 2, EXTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 1, 2, 0, 0, 0, 0 },
 	{ "104316F3", 2, EXTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 1, 2, 0, 0, 0, 0 },
 	{ "104317F3", 2, INTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 0, 1, -1, 1000, 4500, 24 },
@@ -410,6 +411,7 @@ static const struct cs35l41_prop_model cs35l41_prop_model_table[] = {
 	{ "CSC3551", "10431533", generic_dsd_config },
 	{ "CSC3551", "10431573", generic_dsd_config },
 	{ "CSC3551", "10431663", generic_dsd_config },
+	{ "CSC3551", "10431683", generic_dsd_config },
 	{ "CSC3551", "104316D3", generic_dsd_config },
 	{ "CSC3551", "104316F3", generic_dsd_config },
 	{ "CSC3551", "104317F3", generic_dsd_config },
-- 
2.42.0



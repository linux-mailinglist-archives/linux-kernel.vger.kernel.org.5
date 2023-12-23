Return-Path: <linux-kernel+bounces-10324-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A27AE81D2BE
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 07:42:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D4F881C224D4
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 06:42:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92B2F63D8;
	Sat, 23 Dec 2023 06:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DcDZEPw+"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A58F68F56;
	Sat, 23 Dec 2023 06:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-6dbcc5d78eeso610105a34.3;
        Fri, 22 Dec 2023 22:42:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703313720; x=1703918520; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Opo0R05OB5wID6sQJu4dx2K7wLhXLYuO4epgLQz9yZE=;
        b=DcDZEPw+UdSVjSCR3kvMThhyXvrqUg4ZXC1nNA9zbHwpTWYSl+ZTR4au90UK91cMTQ
         94oOJn+bCDJ5fw35YWwuacljX0y0jl8FYwRuABD1aCfna0E1CzvD0inqFQ2GnuQJW1g8
         0AWS/TT79DwK2HFnqkoVMd7fPaWsidgBn5+S/et7VBflcyUgsrwkQUxlkaKkRnDujmw3
         Q+MvoQpbkuCut6m/5lvAJuZKSG2WulWxTsBl+E//+/majAssSLpTOlTPKnoNHf3LQhmz
         XIJcr53F83NWGInNduppofSqNAy6plflroCzWTgo9/l8ZRsZqHYmBe5C9o9zP9v1UfIl
         VLcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703313720; x=1703918520;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Opo0R05OB5wID6sQJu4dx2K7wLhXLYuO4epgLQz9yZE=;
        b=qYAN0Gn+LA5kAJzKzkH4aqQix/qgHZhCJUujh4/MoJokb2QGC9+ISTP9iJReRJX6kL
         nk5RFDDjlIScKIbB/3F3qMeVHq0czB8842t4YpPulwMcmqkizWtJYscNIT3mxaX5rKmD
         rPt619h67n3GwQITwvGtn3LJ8SVMGUJ25L+ecu1Rje52UDjXHZzp2z1xKlJ/W0qdFIki
         pAcHHW6gmtF1BA9HOy85F5LW7c3AaBml6LW1V1glJ0zEDpJHuVmp5gcDvt8cmEzjSZNS
         1ZYFLuMUgLu+dSjsLU7DL/jIN1spxd/qR5bnYZt4du7pUy/XqcEMqOkxwUvAoDCSLUxW
         eqJg==
X-Gm-Message-State: AOJu0YxIpcfYPj0eJGVgwmaHQLMg6T2HxO6zPOdW4a0/sTFDfCMRI8kJ
	iD5h0mReunDS76rIoGAqjBM=
X-Google-Smtp-Source: AGHT+IGbvtCMw5QMbF5aP6/UdVWZWEKE1p3xJRB03uLf1/uxV2A9/CYxiwT4/8kX/82sgTUfK53q/Q==
X-Received: by 2002:a05:6358:7e05:b0:172:fdd5:805 with SMTP id o5-20020a0563587e0500b00172fdd50805mr2924464rwm.27.1703313720528;
        Fri, 22 Dec 2023 22:42:00 -0800 (PST)
Received: from localhost.localdomain ([2400:1a00:b060:2b26:f462:e3d9:c28:4c99])
        by smtp.gmail.com with ESMTPSA id a15-20020a17090ad80f00b0028c35076de0sm423230pjv.35.2023.12.22.22.41.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Dec 2023 22:42:00 -0800 (PST)
From: Dipendra Khadka <kdipendra88@gmail.com>
To: hdegoede@redhat.com,
	mchehab@kernel.org,
	sakari.ailus@linux.intel.com,
	gregkh@linuxfoundation.org,
	hpa@redhat.com
Cc: Dipendra Khadka <kdipendra88@gmail.com>,
	linux-media@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linuxfoundation.org
Subject: [PATCH] staging: media/atomisp/pci: Fix spelling mistakes in sh_css_mipi.c
Date: Sat, 23 Dec 2023 12:26:52 +0545
Message-Id: <20231223064152.79712-1-kdipendra88@gmail.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

codespell reported following spelling mistake
in sh_css_mipi.c as below:

'''
./sh_css_mipi.c:177: separatelly ==> separately
./sh_css_mipi.c:540: ofset ==> offset, of set
'''
This patch fixes these spelling mistakes by changing
"separatelly" to "separately" and "ofset" to "offset".

Signed-off-by: Dipendra Khadka <kdipendra88@gmail.com>
---
 drivers/staging/media/atomisp/pci/sh_css_mipi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/media/atomisp/pci/sh_css_mipi.c b/drivers/staging/media/atomisp/pci/sh_css_mipi.c
index b7c1e164ee24..6e11fd771938 100644
--- a/drivers/staging/media/atomisp/pci/sh_css_mipi.c
+++ b/drivers/staging/media/atomisp/pci/sh_css_mipi.c
@@ -174,7 +174,7 @@ ia_css_mipi_frame_calculate_size(const unsigned int width,
 	mem_words = ((embedded_data_size_words + 7) >> 3) +
 	mem_words_for_first_line +
 	(((height + 1) >> 1) - 1) * mem_words_per_odd_line +
-	/* ceil (height/2) - 1 (first line is calculated separatelly) */
+	/* ceil (height/2) - 1 (first line is calculated separately) */
 	(height      >> 1) * mem_words_per_even_line + /* floor(height/2) */
 	mem_words_for_EOF;
 
@@ -537,7 +537,7 @@ send_mipi_frames(struct ia_css_pipe *pipe)
 
 	/* Hand-over the SP-internal mipi buffers */
 	for (i = 0; i < my_css.num_mipi_frames[port]; i++) {
-		/* Need to include the ofset for port. */
+		/* Need to include the offset for port. */
 		sh_css_update_host2sp_mipi_frame(port * NUM_MIPI_FRAMES_PER_STREAM + i,
 						 my_css.mipi_frames[port][i]);
 		sh_css_update_host2sp_mipi_metadata(port * NUM_MIPI_FRAMES_PER_STREAM + i,
-- 
2.39.2 (Apple Git-143)



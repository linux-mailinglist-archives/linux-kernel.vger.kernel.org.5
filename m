Return-Path: <linux-kernel+bounces-10306-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9838381D265
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 06:11:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36ACE1F22B3F
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 05:11:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7980953A6;
	Sat, 23 Dec 2023 05:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BbvGIqhx"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0274746AD;
	Sat, 23 Dec 2023 05:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-3bb802341eeso1626113b6e.3;
        Fri, 22 Dec 2023 21:11:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703308285; x=1703913085; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6EkT/azvdp1IApYTuFWMWihPRdkqSk2ylPHg0StEj/w=;
        b=BbvGIqhxKh6Ftwi6+h6YKcsBS7tIImZJM+ugVqKh4GozpZm1V3AqHBS3CzgCOITpIl
         p4vMs8BF9q3wVY1oE0/PGxYtlLjKL2YmevOV2fL5qa/0ENTT7pyXmlIykA0gET64vGSG
         LPo6CYH5CBhjYAJtEoA7vnCYYDEoeMNP82EKwCXZ0LR1jDs0G+yNBSj5jvsE7t4KqMqm
         rc+EzYNR1MJFAFn4NQKd4IeqsR5k6ZHTk3vUAd4G3PWCP8HGS0ysVEszod3Z2xmDmyL8
         pfurHYnhOgV61TYtGGY9emVASL2tcqkVOfTRWPXPe1G4xBIFfwA6wEL4KQ2rgnHRktI1
         //jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703308285; x=1703913085;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6EkT/azvdp1IApYTuFWMWihPRdkqSk2ylPHg0StEj/w=;
        b=q828+kAu8tkzRXNBKSM9vL8BA5QKr20FDXqVqRpwy4/UyFt57ANqx5Y9wuMh3GeH0B
         oWnTMBp1xD3Wys1TJwvpV+hbJefGjqobsD59HEyaS4yOwjJoGRji5/36nzTAIKX61ab0
         2wmPph0HaxF7ycBSSOslADqAZBBkaXcHMobRdftSY/P2OJsnTakodLNruGrmRQdVHluu
         wj4YGgbQ8qx/EWbmVWI/MTvcMhGGYxH2QPfUW6KJoaIhD8riTrLc0LGcROL/O9j+Eosh
         aILSOFfCgbVtbafEVPOXhptzbalu0EmEqSmF1CWEl5J5z9YY2D1Rf8A1QV+VpvG96uvU
         MaQw==
X-Gm-Message-State: AOJu0Yznn6bYpLS+ozYNL23t7i+HA+e+BinTCuXYHxLt5JaVkmhsid+0
	eUKXjop9lm3m2L5K+QUCK+w=
X-Google-Smtp-Source: AGHT+IG1PNTUKwu9bMQXjBLLbcz31IATHPAu7BsHiv2B1Wuu7Dhgv6JkzOan1nOid89nmtN0Z5yAxA==
X-Received: by 2002:a05:6808:169e:b0:3ba:1417:43a with SMTP id bb30-20020a056808169e00b003ba1417043amr3234390oib.42.1703308284964;
        Fri, 22 Dec 2023 21:11:24 -0800 (PST)
Received: from localhost.localdomain ([2400:1a00:b060:2b26:f462:e3d9:c28:4c99])
        by smtp.gmail.com with ESMTPSA id p26-20020a62ab1a000000b006d9415b769csm4246653pff.169.2023.12.22.21.11.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Dec 2023 21:11:24 -0800 (PST)
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
Subject: [PATCH v2] staging: media: atomisp: pci: Fix spelling mistake in ia_css_acc_types.h
Date: Sat, 23 Dec 2023 10:56:08 +0545
Message-Id: <20231223051108.74711-1-kdipendra88@gmail.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

codespell reported spelling mistakes in
ia_css_acc_types.h as below:

'''
ia_css_acc_types.h:87: cummulative ==> cumulative
ia_css_acc_types.h:411: descibes ==> describes
'''

This patch fixes these spelling mistakes.

Signed-off-by: Dipendra Khadka <kdipendra88@gmail.com>
---
v2:
 - Previously only corrected spelling  mistake reported by checkpatch.pl.
 - All spelling mistakes reported by codespell are fixed.
v1: https://lore.kernel.org/lkml/20231222200350.2024-1-kdipendra88@gmail.com/

 drivers/staging/media/atomisp/pci/ia_css_acc_types.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/media/atomisp/pci/ia_css_acc_types.h b/drivers/staging/media/atomisp/pci/ia_css_acc_types.h
index d6e52b4971d6..1dc2085ecd61 100644
--- a/drivers/staging/media/atomisp/pci/ia_css_acc_types.h
+++ b/drivers/staging/media/atomisp/pci/ia_css_acc_types.h
@@ -84,7 +84,7 @@ struct ia_css_blob_info {
 		memory_offsets;  /** offset wrt hdr in bytes */
 	u32 prog_name_offset;  /** offset wrt hdr in bytes */
 	u32 size;			/** Size of blob */
-	u32 padding_size;	/** total cummulative of bytes added due to section alignment */
+	u32 padding_size;	/** total cumulative of bytes added due to section alignment */
 	u32 icache_source;	/** Position of icache in blob */
 	u32 icache_size;	/** Size of icache section */
 	u32 icache_padding;/** bytes added due to icache section alignment */
@@ -408,7 +408,7 @@ struct ia_css_acc_sp {
 };
 
 /* Acceleration firmware descriptor.
-  * This descriptor descibes either SP code (stand-alone), or
+  * This descriptor describes either SP code (stand-alone), or
   * ISP code (a separate pipeline stage).
   */
 struct ia_css_acc_fw_hdr {
-- 
2.39.2 (Apple Git-143)



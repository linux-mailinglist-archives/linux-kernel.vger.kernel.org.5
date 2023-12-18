Return-Path: <linux-kernel+bounces-3935-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1197B817543
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 16:32:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8FDB4B227B1
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 15:32:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72D8242399;
	Mon, 18 Dec 2023 15:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="khIxFo52"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37C353D54D;
	Mon, 18 Dec 2023 15:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1d3ce28ace2so3898465ad.3;
        Mon, 18 Dec 2023 07:32:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702913535; x=1703518335; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LPnry4ABNCRoEF7YlhZVOqsWCrakY3lvjh/I9JX4fyE=;
        b=khIxFo52nFLDsg9e7NPJGj7qqjAEjS31tXc1gM3kKosMjoalT02iIvEpxoo2QLa7L7
         bSNc+LE9EoHkh4AkHPefc9gGRl2+U3u9M5r6jrOAB5TqY10Eb1L4aly8sgQ4zUYcscKP
         UijztDrgAIwSoDpQbh3Awyq1FDnBzhxJN7DZOpAmAt0y/G0UPWDR5dVBCEmEekFZ4sEE
         QXGJJmVG4EY95wFi/sOm8NaLSCa9WYVr/P6JlvoVNKFAZkuZpQNJ/veUsts29pDQg0Aq
         a4GGEt0yfCMkyF7ndnTYL663bg0mvCd9IrDRywjstTEXjW+RVmGO4ndROYIgS1nZGVEt
         Yqkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702913535; x=1703518335;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LPnry4ABNCRoEF7YlhZVOqsWCrakY3lvjh/I9JX4fyE=;
        b=qycwEww9xiFus2uAijKI3a2LUWXukF3i7EWxEDOYg0fnu6xWC1p7XPtqWRKDcODADw
         /VtZTqC8ueext5Bj/xzeTOlcndJoNnnS3pTM9Ua45LD9G+7SgN3UUuryODl4HcqZ7kvX
         Vi6pEuKmmzoIt+oi59GB1Tej31O97MrcP7Eg3OsmU6pydepOPAcy+aoGJW0xrUtes/dE
         gaE6uQT9TAHYU4q6D++8MogwTwP/BEmRmYDwkezzxdT2qytHRV2URDZdNPRbFJQmsLiR
         KG/eG5wbKsdLDjHkaA7JE1+eB0XsZNcfhYDIPmrXbcnBY2MMYYeTwz0gjJOBG3AE2Xig
         wOJg==
X-Gm-Message-State: AOJu0Yy3XV0dkkjoMTk9PI8Xfh388gs5HP1cT4ht6bDcUtEaaKINHZyJ
	31j4FSo/RvADyjYCmOwUjWc=
X-Google-Smtp-Source: AGHT+IGR6fcR7dY6sUS+4s0yRsbTxaaJhn99EhB3+ag/KdKrhMD/ddYr9LLElMWyaO+iubF7GhPEWA==
X-Received: by 2002:a17:903:2b0e:b0:1d3:6b17:5eb with SMTP id mc14-20020a1709032b0e00b001d36b1705ebmr10352773plb.49.1702913535439;
        Mon, 18 Dec 2023 07:32:15 -0800 (PST)
Received: from ubuntu.. ([110.44.116.44])
        by smtp.gmail.com with ESMTPSA id g3-20020a170902740300b001d39d4fa323sm4358415pll.55.2023.12.18.07.32.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 07:32:15 -0800 (PST)
From: Dipendra Khadka <kdipendra88@gmail.com>
To: hdegoede@redhat.com,
	mchehab@kernel.org,
	sakari.ailus@linux.intel.com,
	gregkh@linuxfoundation.org
Cc: Dipendra Khadka <kdipendra88@gmail.com>,
	linux-media@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linuxfoundation.org
Subject: [PATCH] drivers: staging: media: atomisp: pci: Fixes a spelling mistake in sh_css_defs.h
Date: Mon, 18 Dec 2023 15:32:00 +0000
Message-Id: <20231218153200.450148-1-kdipendra88@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The script checkpatch.pl reported a spelling error
in sh_css_defs.h as below:

'''
WARNING: 'upto' may be misspelled - perhaps 'up to'?
/* The FPGA system (vec_nelems == 16) only supports upto 5MP */
                                                    ^^^^
'''

This patch corrects a spelling error,
changing "upto" to "up to".

Signed-off-by: Dipendra Khadka <kdipendra88@gmail.com>
---
 drivers/staging/media/atomisp/pci/sh_css_defs.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/media/atomisp/pci/sh_css_defs.h b/drivers/staging/media/atomisp/pci/sh_css_defs.h
index 7eb10b226f0a..2afde974e75d 100644
--- a/drivers/staging/media/atomisp/pci/sh_css_defs.h
+++ b/drivers/staging/media/atomisp/pci/sh_css_defs.h
@@ -131,7 +131,7 @@ RGB[0,8191],coef[-8192,8191] -> RGB[0,8191]
  * invalid rows/columns that result from filter initialization are skipped. */
 #define SH_CSS_MIN_DVS_ENVELOPE           12U
 
-/* The FPGA system (vec_nelems == 16) only supports upto 5MP */
+/* The FPGA system (vec_nelems == 16) only supports up to 5MP */
 #define SH_CSS_MAX_SENSOR_WIDTH           4608
 #define SH_CSS_MAX_SENSOR_HEIGHT          3450
 
-- 
2.34.1



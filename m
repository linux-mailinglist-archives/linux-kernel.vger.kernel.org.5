Return-Path: <linux-kernel+bounces-10341-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CF7CC81D316
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 09:14:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B0F6285AD8
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 08:14:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52C398BF8;
	Sat, 23 Dec 2023 08:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HdlWDP9K"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 773728BE0;
	Sat, 23 Dec 2023 08:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1d2e6e14865so16165115ad.0;
        Sat, 23 Dec 2023 00:14:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703319244; x=1703924044; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kWY/DrbKpHrD7fzJ1z2jZBqElDolNrxGwdlBP2/yWF8=;
        b=HdlWDP9KVGF8jRu79QWL1Cq5jMTdgRh7k90eykKMbEOGLc0rHgdEcWfDLbx39ansaH
         x+z4UZC2s0rZ1C+kHVXN6ztaCCY/XM7jT3hmk+dXVhKCEZi6+Q58zH0nKB+CxvU7eVTg
         wYIqRyvkCAF+YoOxL4F9CtGkviwDSvYnWpaHB/X4VSBaG4PJn9rQHykIj3/Vp1GfqjfJ
         ebaMkAnqnjw5wRMChuRw3zravGLcsyf9Y4Zfqa/9r438FbASSpG+PiF5EzOZrxhJ/orc
         yJVZ0mtLi+Dt5mOtD5agcPLyidGC0yj9OF6KsQ4cNVE2P0I2IPt5xnAP8QaU7NOkBKfK
         aZ2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703319244; x=1703924044;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kWY/DrbKpHrD7fzJ1z2jZBqElDolNrxGwdlBP2/yWF8=;
        b=UTxXUVCU/G0Zb5twdcQJ/FMWup8fUF4CkImNari4XQOWFEcFzWcjjOfLzrfS2HbI5p
         39pbTuMA+idR5hmPOs7W+u732OLmdJQrcYESnFM/l3X+6MBr0tK9uJVKIKWJ8bARGT3c
         pTc8CGFhAreNIArYwEg6KGCMzMqWIgSZThaYf816Re0I1RYUWqSEc3/VfEuIQd9Tl5DP
         sBGJNHSMr3WEQntKtD7kYM75ZsGfr8bwFDBnZLcmXjmVU0kNLDD+JB+QK1YpG5x49xCF
         3+njriP1Nj/iIji/F1QlZxsCcvxa2DAjHSXvi1OZCtWj89etuW1gEjT4NJINqoISJomM
         dv4w==
X-Gm-Message-State: AOJu0YyDvu+VAgGGBLe9nOYQR8+jm3hcTd1p+zyS89fyXSd4003K+VOO
	KEhXlruDOUBmvdv36OhM3Vot0f7z6lmqOQ==
X-Google-Smtp-Source: AGHT+IEbzbGvxC0VlmUd4kvcsYMPpJni2HxqelHej4BgKav2uvZ4yLinClyCCZgffXUfCLVIYLFwuQ==
X-Received: by 2002:a17:90b:f0c:b0:28c:2b2c:1bf4 with SMTP id br12-20020a17090b0f0c00b0028c2b2c1bf4mr115808pjb.15.1703319243544;
        Sat, 23 Dec 2023 00:14:03 -0800 (PST)
Received: from localhost.localdomain ([2400:1a00:b060:2b26:f462:e3d9:c28:4c99])
        by smtp.gmail.com with ESMTPSA id pb11-20020a17090b3c0b00b0028c2e36c449sm750776pjb.51.2023.12.23.00.13.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Dec 2023 00:14:03 -0800 (PST)
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
Subject: [PATCH] staging: media/atomisp/pci/isp/kernels/macc/macc_1.0: Fix spelling mistakes in ia_css_macc_table.host.c
Date: Sat, 23 Dec 2023 13:58:54 +0545
Message-Id: <20231223081354.83318-1-kdipendra88@gmail.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

codespell reported following spelling mistake
in ia_css_macc_table.host.c below:

'''
./isp/kernels/macc/macc_1.0/ia_css_macc_table.host.c:22: matix ==> matrix
./isp/kernels/macc/macc_1.0/ia_css_macc_table.host.c:39: matix ==> matrix
'''
This patch fixes these spelling mistakes.

Signed-off-by: Dipendra Khadka <kdipendra88@gmail.com>
---
 .../pci/isp/kernels/macc/macc_1.0/ia_css_macc_table.host.c    | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/media/atomisp/pci/isp/kernels/macc/macc_1.0/ia_css_macc_table.host.c b/drivers/staging/media/atomisp/pci/isp/kernels/macc/macc_1.0/ia_css_macc_table.host.c
index 946b074e8288..d25bf59273ba 100644
--- a/drivers/staging/media/atomisp/pci/isp/kernels/macc/macc_1.0/ia_css_macc_table.host.c
+++ b/drivers/staging/media/atomisp/pci/isp/kernels/macc/macc_1.0/ia_css_macc_table.host.c
@@ -19,7 +19,7 @@
 
 /* Multi-Axes Color Correction table for ISP1.
  *	64values = 2x2matrix for 16area, [s2.13]
- *	ineffective: 16 of "identity 2x2 matix" {8192,0,0,8192}
+ *	ineffective: 16 of "identity 2x2 matrix" {8192,0,0,8192}
  */
 const struct ia_css_macc_table default_macc_table = {
 	{
@@ -36,7 +36,7 @@ const struct ia_css_macc_table default_macc_table = {
 
 /* Multi-Axes Color Correction table for ISP2.
  *	64values = 2x2matrix for 16area, [s1.12]
- *	ineffective: 16 of "identity 2x2 matix" {4096,0,0,4096}
+ *	ineffective: 16 of "identity 2x2 matrix" {4096,0,0,4096}
  */
 const struct ia_css_macc_table default_macc2_table = {
 	{
-- 
2.39.2 (Apple Git-143)



Return-Path: <linux-kernel+bounces-8213-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 48DA881B3BB
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 11:37:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DD4C8B234F5
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 10:37:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38DD969799;
	Thu, 21 Dec 2023 10:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ecG/RIxA"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 216EF6A00A;
	Thu, 21 Dec 2023 10:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1d3e05abcaeso4347415ad.1;
        Thu, 21 Dec 2023 02:37:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703155036; x=1703759836; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IO8ymlIh0gwHq3H5R4Z60V2oV0umNMIZNVLXryGviuo=;
        b=ecG/RIxA/2o3CmvCfRjiQz4EdwhgY6JzxAa9+gs/Ro1jgMa+ivK6HQDee2tRjnNR2/
         zWyzhH1VfsXz1EVI4tPFHC6XC/VoChjUGz67QOHuVoi7MtSfBHKcO0xhXOa2K14fMo4a
         akmozCAl78OLvlQiQBBh8rW4L0sjvUK1V6M9zqAK8uwA1DUTgp05jOJK0ZyQTKdJ+Nk0
         AMj8RnUyHi2dO/bLtb3H0LMAmC3/P6lZQTov7Qegpe4ncOdyE85JpWpXJnOeS7z4VIds
         07cGq4qEouTpY50VmL4DT1sP9+h+pTmLOpddiNUa++cnIootjflV/wNF/U15l0oPKDJJ
         qScw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703155036; x=1703759836;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IO8ymlIh0gwHq3H5R4Z60V2oV0umNMIZNVLXryGviuo=;
        b=irfFEDJ0PhR5aJnTE9jZVIgtJAR1WdGyKJy55rdm2eCvBwq0HjqYML/+VbW3nJWuJF
         sJcXtdYDBpce0aRXkHYUDR/dEjsgzyfQ2d1SLHQZXYhYRY6IS85IDlfPBb5wYwqVc8FL
         t3wA4xtf3mRyYJ0CX0or/QHFmSHb9uAJz8wS7SChN7KIdVA5OgdnNoKf4+8djUQDWiDp
         nc+0nr9/Y7F10cLoeXLJYxjE8tghbjqZmlCcsE8jU7ENVz/9C0cj87olDrN1Kr+HPj6U
         J1ineJNNwkCoy5JRadvcqvCu1d7DY9jYy8RV9+iYefE2wrSUpITfIjKnPXRIDu9XsI0T
         Z77Q==
X-Gm-Message-State: AOJu0YyhIsD2XZVMg/WgxxQLs+f/jDiqed5obA6+2dUNpxULEkvsiUpM
	GolZbLAI+ufA9lR7/+T4yxk=
X-Google-Smtp-Source: AGHT+IGGapBB/ZVyZ5dQirjzaEf8Bd8ICbenKipZ4RF+MCrODOjbzrEx3sy7ioh372Oew4KHI3OMJw==
X-Received: by 2002:a17:902:c406:b0:1d0:44f6:ccb9 with SMTP id k6-20020a170902c40600b001d044f6ccb9mr12403732plk.65.1703155036374;
        Thu, 21 Dec 2023 02:37:16 -0800 (PST)
Received: from g2039B650.. ([2001:da8:203:a502:3f:1d17:2d9c:d20])
        by smtp.gmail.com with ESMTPSA id w19-20020a170902d3d300b001d3eb987bb6sm1301005plb.149.2023.12.21.02.37.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Dec 2023 02:37:15 -0800 (PST)
From: Gui-Dong Han <2045gemini@gmail.com>
To: mchehab@kernel.org,
	hverkuil-cisco@xs4all.nl,
	gregkh@linuxfoundation.org,
	mcgrof@kernel.org
Cc: linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	baijiaju1990@outlook.com,
	Gui-Dong Han <2045gemini@gmail.com>,
	BassCheck <bass@buaa.edu.cn>
Subject: [PATCH] [media] xc4000: Fix atomicity violation in xc4000_get_frequency
Date: Thu, 21 Dec 2023 18:37:07 +0800
Message-Id: <20231221103707.4129-1-2045gemini@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In xc4000_get_frequency():
	*freq = priv->freq_hz + priv->freq_offset;
The code accesses priv->freq_hz and priv->freq_offset without holding any
lock.

In xc4000_set_params():
	// Code that updates priv->freq_hz and priv->freq_offset
	...

xc4000_get_frequency() and xc4000_set_params() may execute concurrently,
risking inconsistent reads of priv->freq_hz and priv->freq_offset. Since
these related data may update during reading, it can result in incorrect
frequency calculation, leading to atomicity violations.

This possible bug is found by an experimental static analysis tool
developed by our team. This tool analyzes the locking APIs to extract
function pairs that can be concurrently executed, and then analyzes the
instructions in the paired functions to identify possible concurrency bugs
including data races and atomicity violations. The above possible bug is
reported when our tool analyzes the source code of Linux 6.2.

To address this issue, it is proposed to add a mutex lock pair in
xc4000_get_frequency() to ensure atomicity. With this patch applied, our
tool no longer reports the possible bug, with the kernel configuration
allyesconfig for x86_64. Due to the lack of associated hardware, we cannot
test the patch in runtime testing, and just verify it according to the
code logic.

Fixes: 4c07e32884ab6 ("[media] xc4000: Fix get_frequency()")
Reported-by: BassCheck <bass@buaa.edu.cn>
Signed-off-by: Gui-Dong Han <2045gemini@gmail.com>
---
 drivers/media/tuners/xc4000.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/media/tuners/xc4000.c b/drivers/media/tuners/xc4000.c
index 57ded9ff3f04..29bc63021c5a 100644
--- a/drivers/media/tuners/xc4000.c
+++ b/drivers/media/tuners/xc4000.c
@@ -1515,10 +1515,10 @@ static int xc4000_get_frequency(struct dvb_frontend *fe, u32 *freq)
 {
 	struct xc4000_priv *priv = fe->tuner_priv;
 
+	mutex_lock(&priv->lock);
 	*freq = priv->freq_hz + priv->freq_offset;
 
 	if (debug) {
-		mutex_lock(&priv->lock);
 		if ((priv->cur_fw.type
 		     & (BASE | FM | DTV6 | DTV7 | DTV78 | DTV8)) == BASE) {
 			u16	snr = 0;
@@ -1529,8 +1529,8 @@ static int xc4000_get_frequency(struct dvb_frontend *fe, u32 *freq)
 				return 0;
 			}
 		}
-		mutex_unlock(&priv->lock);
 	}
+	mutex_unlock(&priv->lock);
 
 	dprintk(1, "%s()\n", __func__);
 
-- 
2.34.1



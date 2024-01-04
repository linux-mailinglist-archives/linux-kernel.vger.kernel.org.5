Return-Path: <linux-kernel+bounces-17271-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B2E1A824AAC
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 23:04:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4FA3D1F22838
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 22:04:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ECCB2CCC4;
	Thu,  4 Jan 2024 22:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IRAbE2cF"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3262B2C855;
	Thu,  4 Jan 2024 22:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3368b9bbeb4so850664f8f.2;
        Thu, 04 Jan 2024 14:03:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704405827; x=1705010627; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L37iP5wZC6+NhbM5dhp3reaMn3AlmKWJuWzqr7zQQm0=;
        b=IRAbE2cF02wrFyZiJc1qMCiKwGTjTosGKx7564myTA9G/GyUsWBrGOVsLPLrJ3mF2X
         jwohwF8x06e/3ELp9SYet99StUzsCQ5UFFY5oXfh1mAnj97KWfuwqiw8Vx8HKwVOOClb
         QRzRG20hANYjLID4Sghczak56W/c+X43RwbW377mhc3FxhXhGzvC3tdS+dkvLX0aOoC5
         kGXQzx3Oj+OHGBaoS9mKuXB/nNTdeXu7V0rFGJ4sfIovXYHyxSy6yN31GBCLRw9Po5gq
         OWLpdqz0ZAx0xDsaCK4/q0XSNGOgnd27GbEsYEfaG7lh6PFCEm3V9Q2v1Jx69J7UCGjx
         x40w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704405827; x=1705010627;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L37iP5wZC6+NhbM5dhp3reaMn3AlmKWJuWzqr7zQQm0=;
        b=K6wThHlXMZArHm/KfSVJd3L0PyBeQeQmcM3mEA6p17KzfLajVT7Tdbaoo8A5bAn38g
         SM/b4LO4m9wyXaUyhBVa5ua1JW5tRcMiU4Xs26/IuA4nM2WDJBeXCIEwOjzN+rzDlYe0
         hCMrcavDX0xmovR3yJwgxIjIUlhXyvxBmbPpykl1SxKqaMEOTTzTCXaHHw6yn6Nw97kL
         XDHyCXnQ97ShrpKlMPRL8kx5K8ILtiMpdt75BKeZ3VWM2Ax03UqvJE8OIzXr/ND4jdD1
         4tR+KQD2bYQNW8YOzJ1hmmk4PA52LGSJaX5bM4ojMudyNJxLt8uPSeV9R7ga184JMhiB
         T6aw==
X-Gm-Message-State: AOJu0YxaNNwJYJUOeIimTwYao6HysoB25hwGqtjcV2mkAyOoks0yZrJn
	JSXGhJ+d7PBjjCjBZKBPZgo=
X-Google-Smtp-Source: AGHT+IHOoj2J3p1f/TsePnHkqfKwgsnL3dOvGOc7CMokST49azDTdR+vnWvUBPghYV4eFpaSRhRS0A==
X-Received: by 2002:adf:f410:0:b0:32d:cd02:d4f3 with SMTP id g16-20020adff410000000b0032dcd02d4f3mr308124wro.40.1704405827246;
        Thu, 04 Jan 2024 14:03:47 -0800 (PST)
Received: from localhost.localdomain (host-80-116-159-187.pool80116.interbusiness.it. [80.116.159.187])
        by smtp.googlemail.com with ESMTPSA id e18-20020adfe7d2000000b003367a5b6b69sm164286wrn.106.2024.01.04.14.03.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jan 2024 14:03:46 -0800 (PST)
From: Christian Marangi <ansuelsmth@gmail.com>
To: MyungJoo Ham <myungjoo.ham@samsung.com>,
	Kyungmin Park <kyungmin.park@samsung.com>,
	Chanwoo Choi <cw00.choi@samsung.com>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Jonghwa Lee <jonghwa3.lee@samsung.com>,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [RESEND PATCH 2/2] PM / devfreq: Convert to use sysfs_emit_at() API
Date: Thu,  4 Jan 2024 22:55:15 +0100
Message-ID: <20240104215521.10772-2-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240104215521.10772-1-ansuelsmth@gmail.com>
References: <20240104215521.10772-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Follow the advice of the Documentation/filesystems/sysfs.rst and show()
should only use sysfs_emit() or sysfs_emit_at() when formatting the
value to be returned to user space.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/devfreq/devfreq.c | 37 +++++++++++++++++--------------------
 1 file changed, 17 insertions(+), 20 deletions(-)

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index 8459512d9b07..92f211774f9b 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -1697,7 +1697,7 @@ static ssize_t trans_stat_show(struct device *dev,
 	max_state = df->max_state;
 
 	if (max_state == 0)
-		return scnprintf(buf, PAGE_SIZE, "Not Supported.\n");
+		return sysfs_emit(buf, "Not Supported.\n");
 
 	mutex_lock(&df->lock);
 	if (!df->stop_polling &&
@@ -1707,47 +1707,44 @@ static ssize_t trans_stat_show(struct device *dev,
 	}
 	mutex_unlock(&df->lock);
 
-	len += scnprintf(buf + len, PAGE_SIZE - len, "     From  :   To\n");
-	len += scnprintf(buf + len, PAGE_SIZE - len, "           :");
+	len += sysfs_emit_at(buf, len, "     From  :   To\n");
+	len += sysfs_emit_at(buf, len, "           :");
 	for (i = 0; i < max_state; i++) {
 		if (len >= PAGE_SIZE - 1)
 			break;
-		len += scnprintf(buf + len, PAGE_SIZE - len, "%10lu",
-				 df->freq_table[i]);
+		len += sysfs_emit_at(buf, len, "%10lu",
+				     df->freq_table[i]);
 	}
+
 	if (len >= PAGE_SIZE - 1)
 		return PAGE_SIZE - 1;
-
-	len += scnprintf(buf + len, PAGE_SIZE - len, "   time(ms)\n");
+	len += sysfs_emit_at(buf, len, "   time(ms)\n");
 
 	for (i = 0; i < max_state; i++) {
 		if (len >= PAGE_SIZE - 1)
 			break;
-		if (df->freq_table[i] == df->previous_freq)
-			len += scnprintf(buf + len, PAGE_SIZE - len, "*");
+		if (df->freq_table[2] == df->previous_freq)
+			len += sysfs_emit_at(buf, len, "*");
 		else
-			len += scnprintf(buf + len, PAGE_SIZE - len, " ");
+			len += sysfs_emit_at(buf, len, " ");
 		if (len >= PAGE_SIZE - 1)
 			break;
-
-		len += scnprintf(buf + len, PAGE_SIZE - len, "%10lu:",
-				 df->freq_table[i]);
+		len += sysfs_emit_at(buf, len, "%10lu:", df->freq_table[i]);
 		for (j = 0; j < max_state; j++) {
 			if (len >= PAGE_SIZE - 1)
 				break;
-			len += scnprintf(buf + len, PAGE_SIZE - len, "%10u",
-					 df->stats.trans_table[(i * max_state) + j]);
+			len += sysfs_emit_at(buf, len, "%10u",
+				df->stats.trans_table[(i * max_state) + j]);
 		}
 		if (len >= PAGE_SIZE - 1)
 			break;
-		len += scnprintf(buf + len, PAGE_SIZE - len, "%10llu\n", (u64)
-				 jiffies64_to_msecs(df->stats.time_in_state[i]));
+		len += sysfs_emit_at(buf, len, "%10llu\n", (u64)
+				     jiffies64_to_msecs(df->stats.time_in_state[i]));
 	}
 
 	if (len < PAGE_SIZE - 1)
-		len += scnprintf(buf + len, PAGE_SIZE - len, "Total transition : %u\n",
-				 df->stats.total_trans);
-
+		len += sysfs_emit_at(buf, len, "Total transition : %u\n",
+				     df->stats.total_trans);
 	if (len >= PAGE_SIZE - 1) {
 		pr_warn_once("devfreq transition table exceeds PAGE_SIZE. Disabling\n");
 		return -EFBIG;
-- 
2.43.0



Return-Path: <linux-kernel+bounces-72232-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C43785B103
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 03:56:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03B261F225B1
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 02:56:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 355913EA64;
	Tue, 20 Feb 2024 02:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lYQ3wlmQ"
Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E18F753368;
	Tue, 20 Feb 2024 02:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708397774; cv=none; b=Jpuq10SOa52XnAW9NKcWSadA6NbmPCk2ayFZYC/+kjErBWUv3mZLulXKELaKacHW0pRJS9VemhNw/V8v3UzTqbbxrwkskq3W71DQGigrYCNRZKy4CkuE3FwMqx5HpAAVK3J613Jw8PGPKotYLqOJyNRzeqTnuDMCpAWxDtGOlV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708397774; c=relaxed/simple;
	bh=KhBNFU+vcyXrw7hhZzFLQaO6Met4JrtBVXoFaiW5Cyg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MsPW8uW1F17QxZ3PGIMnFewCFlMEpTDzBuh+G2FysbJqTiN/WgEXgySHHrXJeCtiWxRjCoVuVHO3UCO2ERg5aaVwKl92mORAQ1sOS60L0tsMM661KwyFj0PwTtm8NY68YC5b9r+EoeTs+vKUSvdphXS8YEk9NnS3xxnjdrGZj5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lYQ3wlmQ; arc=none smtp.client-ip=209.85.161.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-59fd69bab3bso381483eaf.2;
        Mon, 19 Feb 2024 18:56:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708397772; x=1709002572; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tiMCpE6cizjhU1RT67E8V4r+8Ln0KAuPCSDlqhlksl4=;
        b=lYQ3wlmQkg875YHxkcF2t0CzyKPv+eAk6wtBUySqdAnAFuL+sreO40XFY6BhiUFijz
         qm7CqjOa3wY9WF/OVxR/eVlFvD2lCtKP5FuCVztydAthk3pmFVYRPd/uKNxBKLKbfD7g
         UtlFkc2F3ryiYrNmWBmTX3E8leben5RGq61GIv2lCV2OJxgCkXz7ZEV99nar+qS8hYaq
         WTDT8W8wkWZnVB+GgB3DZFjRiXzqMlCWDu2P5DAoCq5YULp+fH02y4gXCo8XYPDX0I+/
         FrYv1ohtR+F660q860Dl2R9v1KOW9pEol53HMzOfaqG5t8/tAvGqMd+I2q7kVpVa2gvh
         TNrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708397772; x=1709002572;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tiMCpE6cizjhU1RT67E8V4r+8Ln0KAuPCSDlqhlksl4=;
        b=Tu3P0ng/nC53ezgubiUWq0wVoV/qAttyN411vqArVtr79mprcjbxU0P2+KQR9I8I7Q
         prccw3PnpMXsZS5VNOhJtHJlK/1Jz/HQCaYXBdWkruN30D+L7UBFfxJye1LvDzeIHuEj
         p69PRXKe5xKQkVOB+lWaj69I7YAMSskjpAd+kzmvWJhn5oxJkznl2WsyU96y0tgKKOBB
         NVEQQE7zGpIlaiHI9nWNeUqV8tFWsIpDslUsOmivZX4HoiwjRaIsqOMuelapmPJY+oqY
         cqcnkSa1E7ImqN+HS1q23eF0sKCtfUWJbraUO0aZhv/WCpW6rR2S3vJlyJR6f0OXUfH+
         QzZQ==
X-Forwarded-Encrypted: i=1; AJvYcCUz3AdNmZ7HQ2tD1cPGWacdC7CMkGOG1qkACON1aeA6nKL3aAs7eG7X7QgX8/4MsMrh8rf0Gdii/5XoFeMWVyERzN3IVnxw5HPwtWrphcscpqkq7HKV/DCy/Duz/pKkK51oJ0YXhTspoaWR
X-Gm-Message-State: AOJu0YwT5K8cIl65mM2Izr/ceF79OImUD03Z9UI0CZ6IcqIwXHvb1NLL
	PSLRZhqsnRyOgo0/ycf6p6pwVaoqQ1k/L2lXHGUP87VUKYCTkLFv
X-Google-Smtp-Source: AGHT+IGt+eY+tIvCG4LwXzbVuI0ZKfC6ws0uDOdftQOJVvSjsz5UFEJGJlJE5E0UOzF0YnLQ2I4PrA==
X-Received: by 2002:a05:6358:7f0e:b0:176:92d1:568f with SMTP id p14-20020a0563587f0e00b0017692d1568fmr13688884rwn.18.1708397771772;
        Mon, 19 Feb 2024 18:56:11 -0800 (PST)
Received: from barry-desktop.hub ([2407:7000:8942:5500:a5bd:9c11:af2b:aecf])
        by smtp.gmail.com with ESMTPSA id j34-20020a63fc22000000b005dc1edf7371sm5500047pgi.9.2024.02.19.18.56.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Feb 2024 18:56:11 -0800 (PST)
From: Barry Song <21cnbao@gmail.com>
To: akpm@linux-foundation.org,
	davem@davemloft.net,
	hannes@cmpxchg.org,
	herbert@gondor.apana.org.au,
	linux-crypto@vger.kernel.org,
	linux-mm@kvack.org,
	nphamcs@gmail.com,
	yosryahmed@google.com,
	zhouchengming@bytedance.com
Cc: chriscli@google.com,
	chrisl@kernel.org,
	ddstreet@ieee.org,
	linux-kernel@vger.kernel.org,
	sjenning@redhat.com,
	vitaly.wool@konsulko.com,
	Barry Song <v-songbaohua@oppo.com>,
	Yang Shen <shenyang39@huawei.com>,
	Zhou Wang <wangzhou1@hisilicon.com>,
	Tom Zanussi <tom.zanussi@linux.intel.com>
Subject: [PATCH v4 1/3] crypto: introduce crypto_acomp_get_alg_flags to expose algorithm flags
Date: Tue, 20 Feb 2024 15:55:43 +1300
Message-Id: <20240220025545.194886-2-21cnbao@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240220025545.194886-1-21cnbao@gmail.com>
References: <20240220025545.194886-1-21cnbao@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Barry Song <v-songbaohua@oppo.com>

acomp's users might want to know algorithm flags to optimize
themselves. One typical user which can benefit from exposed
alg flags is zswap.

In zswap, zsmalloc is the most commonly used allocator for
(and perhaps the only one). For zsmalloc, we cannot sleep
while we map the compressed memory, so we copy it to a
temporary buffer. By knowing the alg won't sleep can help
zswap to avoid the need for a buffer. This shows noticeable
improvement in load/store latency of zswap.

This patch also fixes the missing ASYNC cra_flags in Intel
iaa and Hisilicon zip drivers.

Cc: Yang Shen <shenyang39@huawei.com>
Cc: Zhou Wang <wangzhou1@hisilicon.com>
Cc: Tom Zanussi <tom.zanussi@linux.intel.com>
Signed-off-by: Barry Song <v-songbaohua@oppo.com>
---
 drivers/crypto/hisilicon/zip/zip_crypto.c  | 1 +
 drivers/crypto/intel/iaa/iaa_crypto_main.c | 1 +
 include/crypto/acompress.h                 | 5 +++++
 include/linux/crypto.h                     | 5 +++++
 4 files changed, 12 insertions(+)

diff --git a/drivers/crypto/hisilicon/zip/zip_crypto.c b/drivers/crypto/hisilicon/zip/zip_crypto.c
index c650c741a18d..94e2d66b04b6 100644
--- a/drivers/crypto/hisilicon/zip/zip_crypto.c
+++ b/drivers/crypto/hisilicon/zip/zip_crypto.c
@@ -591,6 +591,7 @@ static struct acomp_alg hisi_zip_acomp_deflate = {
 	.base			= {
 		.cra_name		= "deflate",
 		.cra_driver_name	= "hisi-deflate-acomp",
+		.cra_flags		= CRYPTO_ALG_ASYNC,
 		.cra_module		= THIS_MODULE,
 		.cra_priority		= HZIP_ALG_PRIORITY,
 		.cra_ctxsize		= sizeof(struct hisi_zip_ctx),
diff --git a/drivers/crypto/intel/iaa/iaa_crypto_main.c b/drivers/crypto/intel/iaa/iaa_crypto_main.c
index dfd3baf0a8d8..91adf9d76a2e 100644
--- a/drivers/crypto/intel/iaa/iaa_crypto_main.c
+++ b/drivers/crypto/intel/iaa/iaa_crypto_main.c
@@ -1916,6 +1916,7 @@ static struct acomp_alg iaa_acomp_fixed_deflate = {
 	.base			= {
 		.cra_name		= "deflate",
 		.cra_driver_name	= "deflate-iaa",
+		.cra_flags		= CRYPTO_ALG_ASYNC,
 		.cra_ctxsize		= sizeof(struct iaa_compression_ctx),
 		.cra_module		= THIS_MODULE,
 		.cra_priority		= IAA_ALG_PRIORITY,
diff --git a/include/crypto/acompress.h b/include/crypto/acompress.h
index 574cffc90730..07bd8f6bc79a 100644
--- a/include/crypto/acompress.h
+++ b/include/crypto/acompress.h
@@ -160,6 +160,11 @@ static inline void acomp_request_set_tfm(struct acomp_req *req,
 	req->base.tfm = crypto_acomp_tfm(tfm);
 }
 
+static inline u32 crypto_acomp_get_alg_flags(struct crypto_acomp *tfm)
+{
+	return crypto_tfm_alg_flags(crypto_acomp_tfm(tfm));
+}
+
 static inline struct crypto_acomp *crypto_acomp_reqtfm(struct acomp_req *req)
 {
 	return __crypto_acomp_tfm(req->base.tfm);
diff --git a/include/linux/crypto.h b/include/linux/crypto.h
index b164da5e129e..811bfaf8b6f8 100644
--- a/include/linux/crypto.h
+++ b/include/linux/crypto.h
@@ -467,6 +467,11 @@ static inline unsigned int crypto_tfm_alg_blocksize(struct crypto_tfm *tfm)
 	return tfm->__crt_alg->cra_blocksize;
 }
 
+static inline unsigned int crypto_tfm_alg_flags(struct crypto_tfm *tfm)
+{
+	return tfm->__crt_alg->cra_flags;
+}
+
 static inline unsigned int crypto_tfm_alg_alignmask(struct crypto_tfm *tfm)
 {
 	return tfm->__crt_alg->cra_alignmask;
-- 
2.34.1



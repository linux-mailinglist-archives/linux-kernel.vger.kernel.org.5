Return-Path: <linux-kernel+bounces-69680-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DB4D858D39
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 05:51:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39EE028289F
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 04:51:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C6FC1CAB1;
	Sat, 17 Feb 2024 04:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lyUDzjsZ"
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D00081CAA1;
	Sat, 17 Feb 2024 04:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708145490; cv=none; b=OMBmIFGJgiIJRi8FUDYuMcNZ71NZtBATTDWhcw9bELds8JBWreiQUwzIq3nu64i9RvesQif9MfqWU4ZCv05GK2HcjVSie6IywQmN6e6y0Qvys5ANV+9ogBWUpn+KG3/T8nHZihcU2tioQBwRNHufxQaIvuzv3/c5q2RSFkQf3qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708145490; c=relaxed/simple;
	bh=Ew9zGK8bj2uKG63OPEEIKUoe5Q8XkSHHeHR+1OENHDY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ga+53xREkGOwewq40piUCrZNsqagl1c9+feEdWHn0X4XrnHLBLbtElHKEOAuZGGeYBfH9yTazd6EjiuUOSiGZF2fTfGcm0RGT7tYH89tygO7gpqEP8BYoY6d7R++UikAM/jXAWgU1kohaeB3occwAzIj92/k6kBzpFlH00SXzzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lyUDzjsZ; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-5cfd95130c6so1646083a12.1;
        Fri, 16 Feb 2024 20:51:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708145488; x=1708750288; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lBwGphqaBGgnqVopSLPzNP3HsID/sdo6yu3ftKGqOG4=;
        b=lyUDzjsZ4AraNAd8lELDST4SeqlNvDThJ9p/Ea9CZaadbnWAonEmlvVKXVVd0jWNhE
         ieVily6OX9jMZLBgdSprUIrezOWEtakIhowbbsOv9aT1bA/oEWXmXzuDvB5/CTbpKGT0
         JMj+phAJYH2834ZYC9wYr37Rs87oGFCciKsBZm35kNIt+I3eMtISzCHISotxUL+81tw6
         6g/p15hwZBEczxFUmPOBIIyyJfgtDt9yytu+/eX2VyPaXlGxOGPRmGH8dP6ABTE+LVX2
         i1TMVvD21d/y1On/hmqbGOz4TtVPngwIz/yBSxiIc42EoJKcCqRPLeJ5sOYo2oK5KKHr
         Aukg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708145488; x=1708750288;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lBwGphqaBGgnqVopSLPzNP3HsID/sdo6yu3ftKGqOG4=;
        b=Cnv2qX7iWhPHBPNuFVIazNWoRAQiIVG6hIDDPPwNVVS6u1Ws0L6NH7iYOVXGyBJ2E/
         Xph6ib+snvSBlhaMpf+Ikjjs3FRXqHYv57N+8Rl40AsHWlXKTHvF37rjuJF1PIP4VvMR
         OuuInqcsFdSk+4XyygLeusl9gb+vGQlFrieeThZkf1qp32XwporuNzsffuUTzhffDR+M
         Pgll5DL2Y6LdMwsvPj3DtvVDxRGlOSJgSlyo29zSuhx0chbmpaAHRa1viCheWtGnHI8x
         3UyEyNt9ng8gN0h7dkwhyUMU2K43MYgYfRVDb5o3mres00InW7+9B+mMVwcFn5vAxWay
         cp0g==
X-Forwarded-Encrypted: i=1; AJvYcCUC7k1LjFYUyOKyev/D74/fTGqWcHoH/ZSjhAarbIk6IkXqOA48mXRn8D+Ent6f8JEokvqbjKLrzCpai5m2xPqGBUqHWigqKTLSlLyJSd5DRUQ6u60G/xhBRuv/4zzr+7qJL43e3vWFK+NV
X-Gm-Message-State: AOJu0Yx+0j5Gu0ROH0ZbEbWAoteGngi0LEkOsX+97H9t1nqy271cGDBv
	IUnuY+oaVVgQjzaRwxdfoAkbRWiImUbNhlRddT+MwihvsPiauUR6
X-Google-Smtp-Source: AGHT+IHDHukVZC3Tl6VbSP7cvk6J3RQAkpvZafO4xOt+DersUqDTPAn7tJNGZjo9EuDadh2/3wlOaA==
X-Received: by 2002:a05:6a00:80b:b0:6e0:71bd:3322 with SMTP id m11-20020a056a00080b00b006e071bd3322mr9708070pfk.10.1708145487782;
        Fri, 16 Feb 2024 20:51:27 -0800 (PST)
Received: from barry-desktop.hub ([2407:7000:8942:5500:e82e:22f2:1bdb:989f])
        by smtp.gmail.com with ESMTPSA id n14-20020a635c4e000000b005dc2ca5b667sm610703pgm.10.2024.02.16.20.51.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Feb 2024 20:51:27 -0800 (PST)
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
	Barry Song <v-songbaohua@oppo.com>
Subject: [PATCH v3 1/3] crypto: introduce acomp_is_sleepable to expose if comp drivers might sleep
Date: Sat, 17 Feb 2024 17:51:00 +1300
Message-Id: <20240217045102.55339-2-21cnbao@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240217045102.55339-1-21cnbao@gmail.com>
References: <20240217045102.55339-1-21cnbao@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Barry Song <v-songbaohua@oppo.com>

Almost all CPU-based compressors/decompressors are actually synchronous
though they support acomp APIs. While some hardware has hardware-based
accelerators to offload CPU's work such as hisilicon and intel/qat/,
their drivers are working in async mode.
Letting acomp's users know exactly if the acomp is really async will
help users know if the compression and decompression procedure can
sleep.
Generally speaking, async and sleepable are semantically similar but
not equal. But for compress drivers, they are actually equal at least
due to the below facts.
Firstly, scompress drivers - crypto/deflate.c, lz4.c, zstd.c, lzo.c
etc have no sleep. Secondly, zRAM has been using these scompress
drivers for years in atomic contexts, and never worried those drivers
going to sleep.

Signed-off-by: Barry Song <v-songbaohua@oppo.com>
Tested-by: Chengming Zhou <zhouchengming@bytedance.com>
---
 crypto/acompress.c         | 8 ++++++++
 include/crypto/acompress.h | 9 +++++++++
 2 files changed, 17 insertions(+)

diff --git a/crypto/acompress.c b/crypto/acompress.c
index 1c682810a484..fa15df394a4c 100644
--- a/crypto/acompress.c
+++ b/crypto/acompress.c
@@ -152,6 +152,14 @@ struct crypto_acomp *crypto_alloc_acomp_node(const char *alg_name, u32 type,
 }
 EXPORT_SYMBOL_GPL(crypto_alloc_acomp_node);
 
+bool acomp_is_sleepable(struct crypto_acomp *acomp)
+{
+	struct crypto_tfm *tfm = crypto_acomp_tfm(acomp);
+
+	return tfm->__crt_alg->cra_type == &crypto_acomp_type;
+}
+EXPORT_SYMBOL_GPL(acomp_is_sleepable);
+
 struct acomp_req *acomp_request_alloc(struct crypto_acomp *acomp)
 {
 	struct crypto_tfm *tfm = crypto_acomp_tfm(acomp);
diff --git a/include/crypto/acompress.h b/include/crypto/acompress.h
index 574cffc90730..88ca33532313 100644
--- a/include/crypto/acompress.h
+++ b/include/crypto/acompress.h
@@ -204,6 +204,15 @@ struct acomp_req *acomp_request_alloc(struct crypto_acomp *tfm);
  */
 void acomp_request_free(struct acomp_req *req);
 
+/**
+ * acomp_is_sleepable() -- check if an acomp is sleepable
+ *
+ * @tfm:	ACOMPRESS tfm handle allocated with crypto_alloc_acomp()
+ *
+ * Return:	true if the acomp is sleepable, otherwise, false
+ */
+bool acomp_is_sleepable(struct crypto_acomp *tfm);
+
 /**
  * acomp_request_set_callback() -- Sets an asynchronous callback
  *
-- 
2.34.1



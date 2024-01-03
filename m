Return-Path: <linux-kernel+bounces-15103-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBDAA822744
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 03:58:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD1CE284BE1
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 02:58:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AAC34A31;
	Wed,  3 Jan 2024 02:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z8jxNEjL"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59ECA3D6A;
	Wed,  3 Jan 2024 02:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-2046b2cd2d3so6655698fac.0;
        Tue, 02 Jan 2024 18:58:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704250696; x=1704855496; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NIIzA7fbS8s/FhcBsRrFPB1nSchgGWmbbp2yPMvhK/E=;
        b=Z8jxNEjLZb3IUGGLhfOnGxAi/J6EAdWcyPV2U8lkmWauTyM9C4fkcD5Ol3B7Ez4Pai
         Dhe3G9EYRPFARHzP0aG6RZANTMMQQMTzqwu96u9of3BdDgVGcmFA80euxjuiTw2zDGwE
         Of9XANPiJyiCJ2R2yWWKbsfIFO9LpFSSh1ijtxTm06uBpBWtvoU0AYNRrMXsSdTsJm9y
         EdY+zKLEXkVl9XVZDjt5oQUJYVH7vfb2WiGsHId/SNJQ61Jiub1feldW2FsqYWk5R19+
         AwyUbxT5tTxBaK/xMgXGWY648pFI0/OPBjk0vHE5i+25u0cDYE1AXujyN3xLxhti0e+Y
         gYvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704250696; x=1704855496;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NIIzA7fbS8s/FhcBsRrFPB1nSchgGWmbbp2yPMvhK/E=;
        b=qQyQWLdieq5VyZKGk0iZwntnLf7oICKmbzt2LYGY8MswHEE5oq6RstYoPEoJIxl3P0
         O00X/5PTRLy/w3BPyReUPnCnSHJgwNCEJS8s273iqqdpbN944uUT0D/0Vt+q/S5+x3tn
         4glYNTkBatcutZ1CdpJnwurorhQiMo+z5OazXGj/sPre/tBlmdmk/5KFe8wDphER9VgK
         iueY+253UQpVZMsmcCv+pe9bg4ha7hbnDecxlDpVC4Td13+kML/be2jfzj6wAk4eQNMe
         UM49OMGS4JFGls77MugGbZvFcXMMP/tfxiyp7T2Fm6hA0I48f4IYuKogaxmkUH+YGB/q
         RjNQ==
X-Gm-Message-State: AOJu0Yws1La4jDqdnAxzY7WaQMqK0ngVSyzx+08X/TJ6k8Oz2MTL9OzC
	ShpbFuzctViXWwUE8VWZgUg=
X-Google-Smtp-Source: AGHT+IH4gkLqk3A49fXuIeNbtthqeFpcn7JnphMh82PHSJ+6uaZVY858IfbtgwvP6EPPGlBkrzHNJw==
X-Received: by 2002:a05:6870:ad0f:b0:204:9c06:fa91 with SMTP id nt15-20020a056870ad0f00b002049c06fa91mr19005485oab.110.1704250696495;
        Tue, 02 Jan 2024 18:58:16 -0800 (PST)
Received: from barry-desktop.hub ([2407:7000:8942:5500:a7d6:f37a:9130:cd96])
        by smtp.gmail.com with ESMTPSA id d6-20020a63fd06000000b005cd8ada89e5sm21168572pgh.70.2024.01.02.18.58.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jan 2024 18:58:16 -0800 (PST)
From: Barry Song <21cnbao@gmail.com>
To: herbert@gondor.apana.org.au,
	davem@davemloft.net,
	akpm@linux-foundation.org,
	chriscli@google.com,
	chrisl@kernel.org,
	ddstreet@ieee.org,
	hannes@cmpxchg.org,
	linux-mm@kvack.org,
	nphamcs@gmail.com,
	sjenning@redhat.com,
	vitaly.wool@konsulko.com,
	yosryahmed@google.com,
	zhouchengming@bytedance.com
Cc: linux-kernel@vger.kernel.org,
	linux-crypto@vger.kernel.org,
	Barry Song <v-songbaohua@oppo.com>
Subject: [PATCH RFC 1/2] crypto: introduce acomp_is_async to expose if a acomp has a scomp backend
Date: Wed,  3 Jan 2024 15:57:57 +1300
Message-Id: <20240103025759.523120-1-21cnbao@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <ZY1EnEefZsRTGYnP@gondor.apana.org.au>
References: <ZY1EnEefZsRTGYnP@gondor.apana.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Barry Song <v-songbaohua@oppo.com>

Almost all CPU-based compressors/decompressors are actually synchronous
though they support acomp APIs. While some chips have hardware-based
accelerators to offload CPU's work such as hisilicon and intel/qat/,
their drivers are working in async mode.
Letting acomp's users know exactly if the acomp is really async will
help users know if the compression and decompression procedure can
sleep and make their decisions accordingly.

Signed-off-by: Barry Song <v-songbaohua@oppo.com>
---
 crypto/acompress.c         | 8 ++++++++
 include/crypto/acompress.h | 9 +++++++++
 2 files changed, 17 insertions(+)

diff --git a/crypto/acompress.c b/crypto/acompress.c
index 1c682810a484..99118e879a4a 100644
--- a/crypto/acompress.c
+++ b/crypto/acompress.c
@@ -152,6 +152,14 @@ struct crypto_acomp *crypto_alloc_acomp_node(const char *alg_name, u32 type,
 }
 EXPORT_SYMBOL_GPL(crypto_alloc_acomp_node);
 
+bool acomp_is_async(struct crypto_acomp *acomp)
+{
+	struct crypto_tfm *tfm = crypto_acomp_tfm(acomp);
+
+	return tfm->__crt_alg->cra_type == &crypto_acomp_type;
+}
+EXPORT_SYMBOL_GPL(acomp_is_async);
+
 struct acomp_req *acomp_request_alloc(struct crypto_acomp *acomp)
 {
 	struct crypto_tfm *tfm = crypto_acomp_tfm(acomp);
diff --git a/include/crypto/acompress.h b/include/crypto/acompress.h
index 574cffc90730..5831080479e9 100644
--- a/include/crypto/acompress.h
+++ b/include/crypto/acompress.h
@@ -195,6 +195,15 @@ static inline int crypto_has_acomp(const char *alg_name, u32 type, u32 mask)
  */
 struct acomp_req *acomp_request_alloc(struct crypto_acomp *tfm);
 
+/**
+ * acomp_is_async() -- check if an acomp is asynchronous(can sleep)
+ *
+ * @tfm:	ACOMPRESS tfm handle allocated with crypto_alloc_acomp()
+ *
+ * Return:	true if the acomp is asynchronous, otherwise, false
+ */
+bool acomp_is_async(struct crypto_acomp *tfm);
+
 /**
  * acomp_request_free() -- zeroize and free asynchronous (de)compression
  *			   request as well as the output buffer if allocated
-- 
2.34.1



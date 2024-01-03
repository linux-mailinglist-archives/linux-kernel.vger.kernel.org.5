Return-Path: <linux-kernel+bounces-15354-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DF5B822A92
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 10:51:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E179284C57
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 09:51:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C25E418C2E;
	Wed,  3 Jan 2024 09:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ldjPPMSl"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C64E918C18;
	Wed,  3 Jan 2024 09:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-dbe87cbc052so1124982276.2;
        Wed, 03 Jan 2024 01:50:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704275434; x=1704880234; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HwysZAJ6ghv3K37MmkiHDv50fMbQAcaQTVa/Nper+78=;
        b=ldjPPMSl1PG1zd92nHUJeehHW9xucdJ7r0i/VTZmdUP2P9qW44SFPGYK9Mo9IJACiE
         NMrHMnI1iP9oWztGlL4VHkczAbw9G1mB0oOoC23FFNaGrjK1dDZVPlXbo6TvgDE0AM4J
         BwvHd557gTCA7MYFUqBv51Nv4WLXwgqDAOpGucOZYFBsW9IjIXP+yWyJmAbm3coPEXZd
         jsnzNQdFMYgiwLmx80ubFROChudp1IydjZWF1ynd+pzxKtgLSop7vuRWk5+4xGlqn3PE
         oq7VuEn/4cIL7pMZ7dx/78uIU3tKnCLwl1AHBc0Sf1pDuvItEYwGU41tngkQ6/Hi2IKz
         wPgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704275434; x=1704880234;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HwysZAJ6ghv3K37MmkiHDv50fMbQAcaQTVa/Nper+78=;
        b=e4bc1SIPesnJN9fkDw9jLAKVwWQIgo0+eCwdtg9pyadz9wHHg9fAvQNn33Ov/ZydkP
         BdkW2NOY+1J/WBhOR8EYG0gplkiDvgmMfMIPCNhrcHtc4p00LfN3xm8zRAdYwX7qcN1d
         H1h9Mxgm6wrNtl9/qZr58eH06AHqrUKSDYqr9Gshc5V6XU53kutE+I7TCFk61qE/xt61
         Rw3IJ0wc7E87rztVigPolNvCesd/PXnn96G4Tcdc50n4gLRFMv075SjQbOp4xFGZJrdA
         //Bi017HpcOUgJ9qUhG4Mpz43dsYBXi3RYWWWDbm6gS3ooaJazPnr8Nesw/EBWim+5L2
         Ix/A==
X-Gm-Message-State: AOJu0YzBldatd7WDNqKN4/bUhVYZVw1PuXx4SJ4X+WsImvQrlEYOYGjO
	4iQXuD2YDWlADNXWwyynvNc=
X-Google-Smtp-Source: AGHT+IH42YZIV6OEBL93QwLYO40q0ASQ2KNUbZP1KhhoeQJlaCT6y4cGhqSERL4Av/vp/qrwoEL/nA==
X-Received: by 2002:a25:b8b:0:b0:db5:4ece:ad01 with SMTP id 133-20020a250b8b000000b00db54ecead01mr8579026ybl.25.1704275433672;
        Wed, 03 Jan 2024 01:50:33 -0800 (PST)
Received: from barry-desktop.hub ([2407:7000:8942:5500:a7d6:f37a:9130:cd96])
        by smtp.gmail.com with ESMTPSA id a34-20020a631a22000000b005c65e82a0cbsm21823483pga.17.2024.01.03.01.50.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jan 2024 01:50:33 -0800 (PST)
From: Barry Song <21cnbao@gmail.com>
To: herbert@gondor.apana.org.au,
	davem@davemloft.net,
	akpm@linux-foundation.org,
	ddstreet@ieee.org,
	sjenning@redhat.com,
	vitaly.wool@konsulko.com,
	linux-crypto@vger.kernel.org
Cc: chriscli@google.com,
	chrisl@kernel.org,
	hannes@cmpxchg.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	nphamcs@gmail.com,
	yosryahmed@google.com,
	zhouchengming@bytedance.com,
	Barry Song <v-songbaohua@oppo.com>
Subject: [PATCH 1/3] crypto: introduce acomp_is_async to expose if a acomp has a scomp backend
Date: Wed,  3 Jan 2024 22:50:04 +1300
Message-Id: <20240103095006.608744-2-21cnbao@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240103095006.608744-1-21cnbao@gmail.com>
References: <20240103095006.608744-1-21cnbao@gmail.com>
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

Signed-off-by: Barry Song <v-songbaohua@oppo.com>
Tested-by: Chengming Zhou <zhouchengming@bytedance.com>
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
index 574cffc90730..d91830c2d442 100644
--- a/include/crypto/acompress.h
+++ b/include/crypto/acompress.h
@@ -204,6 +204,15 @@ struct acomp_req *acomp_request_alloc(struct crypto_acomp *tfm);
  */
 void acomp_request_free(struct acomp_req *req);
 
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
  * acomp_request_set_callback() -- Sets an asynchronous callback
  *
-- 
2.34.1



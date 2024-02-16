Return-Path: <linux-kernel+bounces-68045-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B5165857546
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 05:17:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 37A501F2A024
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 04:17:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DD7414F62;
	Fri, 16 Feb 2024 04:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bX8Q/+hS"
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C59014AA3;
	Fri, 16 Feb 2024 04:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708056541; cv=none; b=i+NSdS79WWqBkrbuDqNBDRiTjkRMXzzE+8pjV8k5p1yzI0419ZmN3V7vUHwYGpPZWdZdGIE6j1E4mbVYZ9N/xUhBuvX7fbhyL5NFNK5O/Gy+u6oPJsizdxZMPV7xnsZLOEQXa4qQWdXpxlxllHF3nilPVGhk+KVxzschB05G3gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708056541; c=relaxed/simple;
	bh=dZFmMb0eUSR9kF0J/d1NN2tRjiMEitp/3HXoSB/UdT8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JF7tfInyXcL1lKAMvI2NdapTb6uWrwDHTscMJ2WpFXMD8ql91WemRjq+RTdn/DrRLJgdzFDfbrlRecXJFg68M5IpTsRYJVIT5lOHiwCgEDfyIcED5pACUfp83mdotqMUz4OAeSAqn1SRYOIPVqZnof8Wd3XgbpIloHuEVWfpLEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bX8Q/+hS; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-53fbf2c42bfso302285a12.3;
        Thu, 15 Feb 2024 20:08:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708056539; x=1708661339; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ip6H/hpmZhzyeEdQqkgVS2/3JYDDw9wfoPqTzf/YhGo=;
        b=bX8Q/+hSMnGLsen8mxLD4KmobJxOgUwi8oAMnRiXC5F/qDs3NlarcXXszXsItFSHmk
         l887Sk3nbRRXblJR9PSlg4r8ZVWq2sESPiTOyQUWBwt/jnT4188Dt3n5uxdmq7lJUnjA
         wJtXRpXCyOEUv5MLfQSh8/8k6D48+eHdDMisufx9kYubIqbqVXbjE6iYsCaQ7b+/1Vn+
         l2PdscB38C+q9cjPAJtfIqFgQEarlweshfrHJcQIptok/+Aqvba+EUFsYNAtlkaK6DYz
         +DeGDVMr3vxvLszWyTgtk/3YXeatUfPbDNth9Tard80d0OVtwu6VJO4DDqZ4wpb+LpYL
         bpig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708056539; x=1708661339;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ip6H/hpmZhzyeEdQqkgVS2/3JYDDw9wfoPqTzf/YhGo=;
        b=YTgp/iOrlGVpKAcRT7U557KXi3p0Jv/X+0wrgrPkUO1H/R2myTl1HHtrWWfyghMWKA
         MSmuUSBH7//TuMrQIpmFr0OvGKpoloodQACb54HCEIe82GXRjKNqH1BU1g/dwzWgZN8f
         MixlnGH9pE5dJ2J0g7Sh1yryW7KeIkJOhBhyC8Ifoo7VxW+hZ/6Nga2QAcH1PfFuoxxf
         N+Ajxu0Fzi7p95WSh8o8XUlXyJk3CZLNnsp4ChaPr+6cuqZFyvMq0kZ1rRKyVRU+J87+
         mUWh2BHwcq3qgLGT0+Cbi0AFoo8QkSjneB+Iu2/KuZqD73W3Mco/2d8y7FREYSq27/u1
         U7jg==
X-Forwarded-Encrypted: i=1; AJvYcCWAbeaIbpXz/Od8vBfKhLXKL2GI+lVmEjcTJdjVwoxRYRDF0BkZ8niG73IyVhfxV91eALemagMV0GTQe5FCJJ9OdyVK7jChcOuqdshmax6U9FIN+Pu+Z9IPjI4tzdQjiLeHaDLzfTFHQP3n
X-Gm-Message-State: AOJu0YxhsZCRWxQ6FyJluUOqe+NjGa80AclqRkA6wuvkvN6ZQj6JHwZe
	jev8JMjSsVG942b136Z45lOVjNm0mkvPA/15F7uLhmRQ/4oZONPv
X-Google-Smtp-Source: AGHT+IGnxw942wN0X8APNw9Z9LImEaaq2+ARj4+iKb7RV8ZNkpfq2Y5zhnFisTYBv2GrtJMh2d8vNg==
X-Received: by 2002:a05:6a20:9585:b0:19e:3709:f3f9 with SMTP id iu5-20020a056a20958500b0019e3709f3f9mr5626996pzb.2.1708056538819;
        Thu, 15 Feb 2024 20:08:58 -0800 (PST)
Received: from barry-desktop.hub ([2407:7000:8942:5500:f28b:3925:777f:45d4])
        by smtp.gmail.com with ESMTPSA id pt12-20020a17090b3d0c00b00298ff26e4c8sm2321393pjb.26.2024.02.15.20.08.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Feb 2024 20:08:58 -0800 (PST)
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
Subject: [PATCH v2 1/3] crypto: introduce acomp_is_sleepable to expose if a acomp has a scomp backend
Date: Fri, 16 Feb 2024 17:08:13 +1300
Message-Id: <20240216040815.114202-2-21cnbao@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240216040815.114202-1-21cnbao@gmail.com>
References: <20240216040815.114202-1-21cnbao@gmail.com>
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



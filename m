Return-Path: <linux-kernel+bounces-76067-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F3ED85F286
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 09:12:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 616C91C2336E
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 08:12:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BF961B599;
	Thu, 22 Feb 2024 08:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GICgMRGl"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 618B017BBE;
	Thu, 22 Feb 2024 08:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708589522; cv=none; b=GVAksJOlZBBDRsu6DDENgUIiQDq/jYr4wWcvNLgIcsjr9v4AOC9ZstA8oS7BUC8EkWQGan3WvvCUhEW+G6IPCgs20Vr/pvh9Ty+zsCnJFsq9rfMTRGmcMDTKjXiqgzjLMRKJKH5wjVcHW5bIonzrl8CMoSSX3LihLV6Ra1nuhjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708589522; c=relaxed/simple;
	bh=9Ps2NP75no4OnAmlUhTQGFRfVnHYMA1QQnKhCrM+BXI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=W8DkW7xfrqvIYnE+RUfBWaq9dMEVTxnnLEpK18hEKiyfFZzHJ2WPP1W5Q4bvRwKr6nTQBRBklR14TcUH6UUA1S4ewzqpruV/iEZiTdC/uXme7lR/ajURFdHYK79yJT8huPoo1llVyiSEKRpR8Ll0EqAa/CUWsHvbqhYIbHQr2hU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GICgMRGl; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-6e08dd0fa0bso553164b3a.1;
        Thu, 22 Feb 2024 00:12:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708589520; x=1709194320; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ejiG5wp8wHYtqv4OVHF7H3n1cMrEsgDccZLLuZArdnY=;
        b=GICgMRGlA36/ZKtybmiZ7HQYlybINrhs6ITok6hvbY9/TY6X+Vf42Ka1DBdTudzR0a
         ZM26BC3kzGje7UDhs5OGiNkvPqbvX5G5MaKVj5PIUGEUWtan1iuTppfuo1DSCH1DXNEF
         6FLaJrOvwTJShwSOQsANFw96Hb7DxoveDyXh0I8S0Bg1dLFDaDhJN9TIgU1Ri1KTcOEb
         3J5Y9yXdOxLOEUEhKPqw96dVpapHdXMNlb6JtMywlxInr4HTn98ZJTmVFef7HJb87g97
         pAmE5wWDIZByeFRfTNqFOO1g4lPAy4caH3R74FjJXkSpcW7REMcp/esR/5wmIO23knWS
         K5+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708589520; x=1709194320;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ejiG5wp8wHYtqv4OVHF7H3n1cMrEsgDccZLLuZArdnY=;
        b=nu/j+vl7ybddJJzl7SscaZzE0uf+y3fjwAeRFitT0H0blGmCI1xJgBsNPtPBqNHMHh
         yELLux6Of3jX/bKWJJxHB4FSPO2thicB1lcIr+mc/1MCz2+tdAYVHyQQiM925AVHqiX+
         pS6s8HxJpg1GsUKxUaBvyxDSps7SN5mhhsGpXjttrrh+zhordzICZmYWx9yqp7DMXj6E
         55JnlFPrfvAM42X39Oq2EHUDaqdTABthXBDNmSZrtmJNzVu23kQodIrRO4UepuksYAiM
         +V+Y0gFIXxccKcZ4A3nZWH9fY3VyHGm7o1yzVVw5gx49s6957/mJmTOhCaFTlEN5XGQG
         21Lg==
X-Forwarded-Encrypted: i=1; AJvYcCVtjlNHbe15cyV12Q1+blK8wccToNQlZaqKoYD2KCaPTXyW25DEnjYkj/VioEof+7e8sf8O7j+c50H3vBmb96qyDUIEyTOhD/rVhVQY3IQaWfTsDt99qIE9xPQkQG82l8PvgB/USWLApQXA
X-Gm-Message-State: AOJu0YzUg8Vy869HzQxOyIn2N8y2ZLQCljsmzvld8cm0UKh9zOvo6N6N
	IDg5ILuqaa4+nHHnBrVfwl4oZGiotfqVdgApp50I2bNXrnav1j5N
X-Google-Smtp-Source: AGHT+IG4Sfvb1A6057v5bmOBRwDro0a1UI6orgA95fIP6RLJByG94Z7EUV9wpMjkFx/vclOd59g6pw==
X-Received: by 2002:a05:6a00:1d03:b0:6e4:c3e1:8fb8 with SMTP id a3-20020a056a001d0300b006e4c3e18fb8mr3075598pfx.8.1708589520591;
        Thu, 22 Feb 2024 00:12:00 -0800 (PST)
Received: from barry-desktop.hub ([2407:7000:8942:5500:3b18:a2e2:f00b:c965])
        by smtp.gmail.com with ESMTPSA id du17-20020a056a002b5100b006e46672df97sm6989554pfb.75.2024.02.22.00.11.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 00:12:00 -0800 (PST)
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
Subject: [PATCH v6 1/2] crypto: introduce: acomp_is_async to expose if comp drivers might sleep
Date: Thu, 22 Feb 2024 21:11:34 +1300
Message-Id: <20240222081135.173040-2-21cnbao@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240222081135.173040-1-21cnbao@gmail.com>
References: <20240222081135.173040-1-21cnbao@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Barry Song <v-songbaohua@oppo.com>

acomp's users might want to know if acomp is really async to
optimize themselves. One typical user which can benefit from
exposed async stat is zswap.

In zswap, zsmalloc is the most commonly used allocator for
(and perhaps the only one). For zsmalloc, we cannot sleep
while we map the compressed memory, so we copy it to a
temporary buffer. By knowing the alg won't sleep can help
zswap to avoid the need for a buffer. This shows noticeable
improvement in load/store latency of zswap.

Signed-off-by: Barry Song <v-songbaohua@oppo.com>
Acked-by: Herbert Xu <herbert@gondor.apana.org.au>
---
 include/crypto/acompress.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/crypto/acompress.h b/include/crypto/acompress.h
index 574cffc90730..80e243611fe2 100644
--- a/include/crypto/acompress.h
+++ b/include/crypto/acompress.h
@@ -160,6 +160,12 @@ static inline void acomp_request_set_tfm(struct acomp_req *req,
 	req->base.tfm = crypto_acomp_tfm(tfm);
 }
 
+static inline bool acomp_is_async(struct crypto_acomp *tfm)
+{
+	return crypto_comp_alg_common(tfm)->base.cra_flags &
+	       CRYPTO_ALG_ASYNC;
+}
+
 static inline struct crypto_acomp *crypto_acomp_reqtfm(struct acomp_req *req)
 {
 	return __crypto_acomp_tfm(req->base.tfm);
-- 
2.34.1



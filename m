Return-Path: <linux-kernel+bounces-72424-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9642985B314
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 07:45:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4CC061F22357
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 06:45:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 257D45A4CF;
	Tue, 20 Feb 2024 06:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KcNJbOon"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 207F25A4C4;
	Tue, 20 Feb 2024 06:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708411481; cv=none; b=WMrNtITXgdaoa1WmXM5w4a4o2OeoGY50Q+DaMFXi1+zBIyU701FnUg31B/EFvH0RKMaOFL5PV2UFMZF95nvKEQ9QHnPV5Dlv6tz85pPe/OufcHem1JpsLN5/mqs4I7rekYEqht7EaNSz3qsqSrTKtDLAFJKhwOwwdU37bauUYOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708411481; c=relaxed/simple;
	bh=oQim727lZINnY49Gi9z7V9PnX8PQ7vzU9hPZtVyzet8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Wce9l24sqXCxy9CNG4g/CPjbWzg0xxy9wM6BPNxKjc8PVkN7kaLjJj5oHPRAFBbQottWVoNkxEzbd9gY4R11TeYdLNV5UjalS3JjbBDm2lUT9Yv6slDeYOgLjl7vmvEhA8mJJY08luNYSPp/Yo1dXyIno/1LB8IIIYQuOSnjYPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KcNJbOon; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1d932f6ccfaso41332415ad.1;
        Mon, 19 Feb 2024 22:44:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708411479; x=1709016279; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VwTIFpBnJrjGyIT/20HYU3RPVaQg5c8zhvFCBIT6Ljs=;
        b=KcNJbOonnPzzRUBBbfLkj0GMcgkGITFQhJ0yg8uDtpRsOz7u2J1L3GJdQrirUT7yj+
         X4ZCmBhsX7y+silEIF08GUIG8RPW/dykcSFTD4viRE+GadJssDoV/AGygVxI71k3p3QY
         o6DkbsB8KVxmXRikGFrQsAh16dEOs8Ayr7bASp4mKstd/qq0mde2XOhpHkzTGqVHxr3S
         nWHY8+b2Ta1ngEjLkzxXxqOs5cTTlE2yl6M/DAS5zuc/uveEVCsjeHgX7kLqn82+f9+U
         ptki9uUWi6itIa8k2ucgmEqPIB5LWpDUql2kTHFUuW1dJMEEpxW8DIkY0FcnjEzT/fbj
         UR9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708411479; x=1709016279;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VwTIFpBnJrjGyIT/20HYU3RPVaQg5c8zhvFCBIT6Ljs=;
        b=QVr7bSGzOUszWkvWJyoRWf6GFSCQlO7a0c7W77s6on2DrYiSVBc39Cq7ZFmBjJp2RC
         j2+0dhObLWuQ/m9L7UbxByinMXPk3NmocK/WSc06t5XXEYwg/y+C19kT1HhtdQxQ3X7j
         iBZEuehhld1hiol8W7Ribk1TPvxEQwZIg3GssXLJ89ctUwJf2MiMXI1C6J8/lg/Lanbl
         gvjDgQo0VZVohzO2pClMmPpPvjvYpC1o2ZwIYUORiWHN9uifhM5+LIBD1W92nXdZhejQ
         Y58f/vOKzv3hlyfJAMSfu2v/GUfrpje7Tsbzzg7F3Nsv8tYCiryVXI1M9Mt/eZoHaE2C
         L1ag==
X-Forwarded-Encrypted: i=1; AJvYcCU449GkHUTNKEuJwyuCvWMVoEWZFZLrwKT0uUpCJG8wkOIT4VdAMSpXnIRilaO66vxw9phriOExEWKhPLkSlMHVKz3uKZ6wl35iQHqQATWMR0omdiTsWb3gWswu1/YGd8t632nKWq6slDPa
X-Gm-Message-State: AOJu0Yz0+Zp/RjD9IFSxwf/ds0ingkEYQRi4oBLvy27xB4AmNCn8TclA
	94Sjv1vUxUHi8HOFWuUiz7BLSaVi5Vp2coHgP6WcBGFLNVXr1L//
X-Google-Smtp-Source: AGHT+IGai50/e9Dq4GggyO4YXfBocAVgdbPmMRi2mn4PPi0R3OTzklhwKOf6W7+VfocVSf50DBd0sg==
X-Received: by 2002:a17:902:dac8:b0:1db:cea0:9d62 with SMTP id q8-20020a170902dac800b001dbcea09d62mr7790208plx.9.1708411479355;
        Mon, 19 Feb 2024 22:44:39 -0800 (PST)
Received: from barry-desktop.hub ([2407:7000:8942:5500:a5bd:9c11:af2b:aecf])
        by smtp.gmail.com with ESMTPSA id w16-20020a1709029a9000b001db60446abdsm5419090plp.262.2024.02.19.22.44.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Feb 2024 22:44:39 -0800 (PST)
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
Subject: [PATCH v5 1/3] crypto: introduce: acomp_is_async to expose if comp drivers might sleep
Date: Tue, 20 Feb 2024 19:44:12 +1300
Message-Id: <20240220064414.262582-2-21cnbao@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240220064414.262582-1-21cnbao@gmail.com>
References: <20240220064414.262582-1-21cnbao@gmail.com>
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



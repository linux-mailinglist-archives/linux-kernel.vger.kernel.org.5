Return-Path: <linux-kernel+bounces-24351-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EACCE82BB72
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 08:00:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 851D1283289
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 07:00:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9874F5C911;
	Fri, 12 Jan 2024 06:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mPASxGTR"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9549A5D723
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 06:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-336c9acec03so5078569f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 22:59:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705042785; x=1705647585; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aMDSp2ZNZdvA1/0x96e6idKEXK9ueWlbixOmKjycJeI=;
        b=mPASxGTRG4ee1EsbMUtyLbavfZwSNuWYoQ2tS7jA2O33T5m815dQsGECfJUq5smV5y
         rkI/FprsHB+As5Pm82Z9NlqURdjNipW3FNw9TQd3XmeD1sdCYYm+NT6Y+NLIDkvl2fi4
         +EshQEnELjsu+TREkJigi7yaUNAz04SjX6QL7mnoMuF/PS3EwlFvuc58N1Kp1xwDsW49
         Tad9FzEdwdkwSlmVb5nkypHZ9khY4BLpvXME6KsUDL7sdaEKw6Pq9pi0NT45PdmtEVgl
         i8xmhtMG6VLILGDmYiAJmeHtlxwHNVM866/U+vmQ2S7glyAQRhrgwQJ0/9RtX8YU4Qh+
         l8ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705042785; x=1705647585;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aMDSp2ZNZdvA1/0x96e6idKEXK9ueWlbixOmKjycJeI=;
        b=Dq3kFIsZW0OHyuuy176Y156L2gXeW8sPwJaieH4PHCg+uBra4jChzzEwGud+PZ13GY
         KgwdIbperl+WOuGeLUc0JNgbbcZq8ZWiZIjzvhQ1Xjm6Nq2DilNzfOdYuAXpxAfALDGY
         m5OX2m5UXvLE14lfBC1lLDx+wIifsIjDxIQ7Owwz59RGaVxVekreHTyAzMRm6gZ8ZP6p
         GGUtDdy5yuP7JOKyESO4/QN4vN8JdDCCr1A9AOgxfjTr7S9+Mi/CWVMnuYCstH9npCJM
         UDen/Y4xcjCiOvgfzxSAFcG/ki6WoPP4fT4mDz9Vb9sCWb8RFR7QzkDdCORC70Y8KxvL
         ugIg==
X-Gm-Message-State: AOJu0Yx18NKMzbyhPsEv9muUqK0ijskW9hpI7jiIl2Y7iwI7Dbyk8g53
	VfKnIiiB5l7eoMvR2d3jaZYCa8OF4DgHCA==
X-Google-Smtp-Source: AGHT+IFIM8WcAUdOil9Y7u+h4e46rIteWp4Vx2BN9L2wWJb+W2y9/7uTleu8vvvEr7YShi+xUYEX6w==
X-Received: by 2002:a05:6000:cd:b0:336:77a5:479d with SMTP id q13-20020a05600000cd00b0033677a5479dmr436727wrx.123.1705042784923;
        Thu, 11 Jan 2024 22:59:44 -0800 (PST)
Received: from localhost ([102.140.209.237])
        by smtp.gmail.com with ESMTPSA id k16-20020a5d6d50000000b00336a0c083easm2990218wri.53.2024.01.11.22.59.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jan 2024 22:59:44 -0800 (PST)
Date: Fri, 12 Jan 2024 09:59:41 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: David Howells <dhowells@redhat.com>
Cc: Jeff Layton <jlayton@kernel.org>, linux-cachefs@redhat.com,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH v2] netfs, fscache: Prevent Oops in fscache_put_cache()
Message-ID: <e84bc740-3502-4f16-982a-a40d5676615c@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

This function dereferences "cache" and then checks if it's
IS_ERR_OR_NULL().  Check first, then dereference.

Fixes: 9549332df4ed ("fscache: Implement cache registration")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
v2: My first version introduced a race and a possible use after free.

 fs/netfs/fscache_cache.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/netfs/fscache_cache.c b/fs/netfs/fscache_cache.c
index d645f8b302a2..9397ed39b0b4 100644
--- a/fs/netfs/fscache_cache.c
+++ b/fs/netfs/fscache_cache.c
@@ -179,13 +179,14 @@ EXPORT_SYMBOL(fscache_acquire_cache);
 void fscache_put_cache(struct fscache_cache *cache,
 		       enum fscache_cache_trace where)
 {
-	unsigned int debug_id = cache->debug_id;
+	unsigned int debug_id;
 	bool zero;
 	int ref;
 
 	if (IS_ERR_OR_NULL(cache))
 		return;
 
+	debug_id = cache->debug_id;
 	zero = __refcount_dec_and_test(&cache->ref, &ref);
 	trace_fscache_cache(debug_id, ref - 1, where);
 
-- 
2.43.0



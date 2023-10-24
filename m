Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E98337D5EC8
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 01:45:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344675AbjJXXpO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 19:45:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344668AbjJXXpM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 19:45:12 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ADE110D0;
        Tue, 24 Oct 2023 16:45:10 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-6ba54c3ed97so4894372b3a.2;
        Tue, 24 Oct 2023 16:45:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698191110; x=1698795910; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+x0VqA3cD4M+ao6grVHPW3xmsMyW1K3p+Nk8uf2CQsI=;
        b=KIonIqMbf4sAJeJGfxg0GjkAj94/XmT3HBe8IyeiTv6W/d8j4VDwDGKgT4do+m+3+d
         oElF/JnipZueHqfY0/MJ+AfhJb+rWxN1BKmQuv9Hn5OU66pOIvjoY1XMgS7oj/08CxeF
         KIixbF0hk1Zid5Lex4vfhjW9QeIm7dcfLiKgZempLR0jpfTnP0Uilfvf2++R601vGKva
         bjaUTLnZmQl3uEwkdTDN+KPanFkPtZrJJwWq3UIqLNBqIivJ42Cioye99IHViyWd4T1z
         xqhupeeUFcNLf7yP+RBzRchgIoMp58jHXGJoGVGwTh0UbBFg/upqLGFL1msULL57LwC7
         lt/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698191110; x=1698795910;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+x0VqA3cD4M+ao6grVHPW3xmsMyW1K3p+Nk8uf2CQsI=;
        b=jnOelc3/5jAQZld8g/ZlE94O3gEQpYW62lEdAe23XTkZVGu98nqvv77u0yaPcl2R+h
         Vpxg4/wH3slXwBkm9S2rA/pYHb2cynX69cmE9pqfAR1xfn9wVAgVzsAKlZLfbqhbunHY
         C+0eQk3IkVgHXqjE1T9tC2jZg+lSJ7jB4aTC2I3gzty0ca7ivOFjwlQ4lDvmeWvKHQCW
         5wV/uYIADOIsVbYyrvdLzj7xHYeh+E5F/lQLbsYf9CWfl+IUuK5/kWXCIji81qOBhO1p
         H+u3uYO970/tALr0Uw7MRu5HL6fSUd7v7PtsKlx/Us03fMnuipgWxVO6r/XTra+Zzgkg
         tXFA==
X-Gm-Message-State: AOJu0YzwX409tWK0hp2m/FQduJ5/0GabV3fGtHYVjGHY/OQN1cp6/r2s
        pUmW0amssZLN2Vla5AOn+d8=
X-Google-Smtp-Source: AGHT+IG9b7uiwD4opdLGFWcO+BS8gEzyOBmXiwUWx48lzcMpqTQYDgS4zrtFiMvQGqA8/nHWUnmEHw==
X-Received: by 2002:a05:6a00:2482:b0:6be:130a:22a0 with SMTP id c2-20020a056a00248200b006be130a22a0mr15986264pfv.14.1698191109799;
        Tue, 24 Oct 2023 16:45:09 -0700 (PDT)
Received: from localhost (fwdproxy-prn-117.fbsv.net. [2a03:2880:ff:75::face:b00c])
        by smtp.gmail.com with ESMTPSA id w14-20020aa7954e000000b00686b649cdd0sm8076226pfq.86.2023.10.24.16.45.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Oct 2023 16:45:09 -0700 (PDT)
From:   Nhat Pham <nphamcs@gmail.com>
To:     akpm@linux-foundation.org
Cc:     hannes@cmpxchg.org, cerasuolodomenico@gmail.com,
        yosryahmed@google.com, sjenning@redhat.com, ddstreet@ieee.org,
        vitaly.wool@konsulko.com, mhocko@kernel.org,
        roman.gushchin@linux.dev, shakeelb@google.com,
        muchun.song@linux.dev, linux-mm@kvack.org, kernel-team@meta.com,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
Subject: [PATCH] zswap: export compression failure stats
Date:   Tue, 24 Oct 2023 16:45:09 -0700
Message-Id: <20231024234509.2680539-1-nphamcs@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

During a zswap store attempt, the compression algorithm could fail (for
e.g due to the page containing incompressible random data). This is not
tracked in any of existing zswap counters, making it hard to monitor for
and investigate. We have run into this problem several times in our
internal investigations on zswap store failures.

This patch adds a dedicated debugfs counter for compression algorithm
failures.

Signed-off-by: Nhat Pham <nphamcs@gmail.com>
---
 mm/zswap.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/mm/zswap.c b/mm/zswap.c
index 37d2b1cb2ecb..e12e76289226 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -61,6 +61,8 @@ static u64 zswap_pool_limit_hit;
 static u64 zswap_written_back_pages;
 /* Store failed due to a reclaim failure after pool limit was reached */
 static u64 zswap_reject_reclaim_fail;
+/* Store failed due to compression algorithm failure */
+static u64 zswap_reject_compress_fail;
 /* Compressed page was too big for the allocator to (optimally) store */
 static u64 zswap_reject_compress_poor;
 /* Store failed because underlying allocator could not get memory */
@@ -1309,8 +1311,10 @@ bool zswap_store(struct folio *folio)
 	ret = crypto_wait_req(crypto_acomp_compress(acomp_ctx->req), &acomp_ctx->wait);
 	dlen = acomp_ctx->req->dlen;
 
-	if (ret)
+	if (ret) {
+		zswap_reject_compress_fail++;
 		goto put_dstmem;
+	}
 
 	/* store */
 	zpool = zswap_find_zpool(entry);
@@ -1550,6 +1554,8 @@ static int zswap_debugfs_init(void)
 			   zswap_debugfs_root, &zswap_reject_alloc_fail);
 	debugfs_create_u64("reject_kmemcache_fail", 0444,
 			   zswap_debugfs_root, &zswap_reject_kmemcache_fail);
+	debugfs_create_u64("reject_compress_fail", 0444,
+			   zswap_debugfs_root, &zswap_reject_compress_fail);
 	debugfs_create_u64("reject_compress_poor", 0444,
 			   zswap_debugfs_root, &zswap_reject_compress_poor);
 	debugfs_create_u64("written_back_pages", 0444,
-- 
2.34.1


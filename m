Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B54BB77A655
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Aug 2023 14:23:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229943AbjHMMXv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Aug 2023 08:23:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjHMMXt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Aug 2023 08:23:49 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 847D11709;
        Sun, 13 Aug 2023 05:23:51 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-4fe457ec6e7so5433393e87.3;
        Sun, 13 Aug 2023 05:23:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691929430; x=1692534230;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=S9aOwELJQ+F+xl9knJbQEprQYGdN9bqzH4UAwE44Iy8=;
        b=L1Rd643b/O6Pz8sYs7YuWESy2LE3bR1U5qzHhWc/Psq/p4ZeMX7cuvRBCZMP9XwuZC
         qdpMUoPVVOIo67AGHQR1bIRHXWC7EbtlVPhf+tvA7cnlNrJWnIKM2MATx6oSc7unI3Ym
         E5L/xECrn+9qCRgCCe0voCkx2Q5OpI3bbEzzDzQpGCeNIUzEhZvn7w8oQjIKV9LHM+ES
         MrYZLRBXFIizjZ6kWcjyCXHsMNB0803FC3CRqeQdPv6WBKyZ8i1py+twJZ1sxArNmkB1
         Sm9n6i5lXO4dNCIeUnAjR9nIUFn+NJMP0hcr/5NJe0avegLc+5Md+vLr1Knb5ZEb+lM9
         aedw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691929430; x=1692534230;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=S9aOwELJQ+F+xl9knJbQEprQYGdN9bqzH4UAwE44Iy8=;
        b=T8RR31koiA1rH30REmrkXteg/64FGEvPyCLfVLq0OWYb4mzHsHqVE2d6jxwjpQnr/l
         XmBcxTh6QZ6hUmcExqSu7MPg4PlHfAAcfdzD1nE5mbTJaX+WlY7nDKa6YUorIfZhzf72
         ucqn6mA7q8bEmSLxbnq/eH5U6ufhaSLL2tWQmY1PkJF6f0UiTsw1F/V33+bTxqEYZQ/1
         HH7mzaFDrHWzBWtYZfSKuAC6GLJqAhA2/QQ+6mVQ+yTSI1cvuI3py7zNZjhUSq1iKAm9
         ijfu3f2C6ib7opyDQnN8zmeLlJj82O0MhTKRVYsAA6xaBomeRv5N2mPRYQ3sivbvRlCw
         amRg==
X-Gm-Message-State: AOJu0YxteMTCMQuy21mfOqBkm0KbMIXPqoibMu5Q2EaSFVQnJe97NEGP
        mivj07fsfrO/A6IUI6ebHa8=
X-Google-Smtp-Source: AGHT+IGzWwCAV2smT1cQu4c6Bc23bJIrbp2XC0beYhSpUgyALr+CNHoJ6M0cFJ4URfABqU+gFe2zzw==
X-Received: by 2002:a05:6512:3287:b0:4fe:1dc8:7ec with SMTP id p7-20020a056512328700b004fe1dc807ecmr4218969lfe.37.1691929429355;
        Sun, 13 Aug 2023 05:23:49 -0700 (PDT)
Received: from fedora.. ([2a00:1370:8180:6b00:a1a8:4887:1af4:637a])
        by smtp.gmail.com with ESMTPSA id t9-20020ac25489000000b004fe36bae2d6sm1500488lfk.81.2023.08.13.05.23.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Aug 2023 05:23:49 -0700 (PDT)
From:   Pavel Skripkin <paskripkin@gmail.com>
To:     herbert@gondor.apana.org.au, davem@davemloft.net,
        dhowells@redhat.com, pabeni@redhat.com
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        Pavel Skripkin <paskripkin@gmail.com>,
        syzbot+cba21d50095623218389@syzkaller.appspotmail.com
Subject: [PATCH] crypto: fix uninit-value in af_alg_free_resources
Date:   Sun, 13 Aug 2023 15:23:44 +0300
Message-Id: <20230813122344.14142-1-paskripkin@gmail.com>
X-Mailer: git-send-email 2.40.1
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

Syzbot was able to trigger use of uninitialized memory in
af_alg_free_resources.

Bug is caused by missing initialization of rsgl->sgl.need_unpin before
adding to rsgl_list. Then in case of extract_iter_to_sg() failure, rsgl
is left with uninitialized need_unpin which is read during clean up

BUG: KMSAN: uninit-value in af_alg_free_sg crypto/af_alg.c:545 [inline]
BUG: KMSAN: uninit-value in af_alg_free_areq_sgls crypto/af_alg.c:778 [inline]
BUG: KMSAN: uninit-value in af_alg_free_resources+0x3d1/0xf60 crypto/af_alg.c:1117
 af_alg_free_sg crypto/af_alg.c:545 [inline]
 af_alg_free_areq_sgls crypto/af_alg.c:778 [inline]
 af_alg_free_resources+0x3d1/0xf60 crypto/af_alg.c:1117
 _skcipher_recvmsg crypto/algif_skcipher.c:144 [inline]
...

Uninit was created at:
 slab_post_alloc_hook+0x12f/0xb70 mm/slab.h:767
 slab_alloc_node mm/slub.c:3470 [inline]
 __kmem_cache_alloc_node+0x536/0x8d0 mm/slub.c:3509
 __do_kmalloc_node mm/slab_common.c:984 [inline]
 __kmalloc+0x121/0x3c0 mm/slab_common.c:998
 kmalloc include/linux/slab.h:586 [inline]
 sock_kmalloc+0x128/0x1c0 net/core/sock.c:2683
 af_alg_alloc_areq+0x41/0x2a0 crypto/af_alg.c:1188
 _skcipher_recvmsg crypto/algif_skcipher.c:71 [inline]

Fixes: c1abe6f570af ("crypto: af_alg: Use extract_iter_to_sg() to create scatterlists")
Reported-and-tested-by: syzbot+cba21d50095623218389@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=cba21d50095623218389
Signed-off-by: Pavel Skripkin <paskripkin@gmail.com>
---
 crypto/af_alg.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/crypto/af_alg.c b/crypto/af_alg.c
index 06b15b9f661c..4e4f2d837481 100644
--- a/crypto/af_alg.c
+++ b/crypto/af_alg.c
@@ -1241,6 +1241,8 @@ int af_alg_get_rsgl(struct sock *sk, struct msghdr *msg, int flags,
 				return -ENOMEM;
 		}
 
+		rsgl->sgl.need_unpin = 0;
+
 		rsgl->sgl.sgt.sgl = rsgl->sgl.sgl;
 		rsgl->sgl.sgt.nents = 0;
 		rsgl->sgl.sgt.orig_nents = 0;
-- 
2.40.1


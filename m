Return-Path: <linux-kernel+bounces-82373-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 73427868361
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 22:56:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94FD81C2169C
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 21:56:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69C8B131E36;
	Mon, 26 Feb 2024 21:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mhvVYNVZ"
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBFEA131E2F;
	Mon, 26 Feb 2024 21:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708984592; cv=none; b=ELUFG3rmtgQWKHhk5N48AH44fUFg3djrHFqUGyULlp0mTbrCGwJQHbaINZQ+zIlFQ1JgSAWUiRbrsS+Vv/9y0Yat0E7317emJ4ZXQEnLBxMzwFWLt+up92GKf+rqsBCsxhuL641uUIY6+3r3zUUDjK1TjU0pGAHT4rf0jK+YUGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708984592; c=relaxed/simple;
	bh=SLknjA5Z15uYeDnlExQifv2QhXWofp4qqSN0YtcmwZk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dO1SOiw7aUp7A8jYKZD5gZk121fUXVCxCiggGyDwGsqJYveex5juqe0kYnl7XNFZOfCX4zDkRc1G7YdKYjfv82oJ08oCzDzCu1CG6yUhLRrTHcBVHZMKCoWNdnC2ctPvHCoDWdQGPyAlN43XZ4qGcOOvTnwLcP2efHGQ/d25uZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mhvVYNVZ; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2d24a727f78so50932271fa.0;
        Mon, 26 Feb 2024 13:56:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708984589; x=1709589389; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=u1eIEAwPr48i+Yenfq0jlQKcUkAqO/w8pfipw6YSNWk=;
        b=mhvVYNVZDGa538nSUn+rk38VBsJ7qp7ZIPYOSc5UpeSFtNrR10xROr/VavxaUAqxgT
         NnadlzaQyvvfERehVzeFNU48dlEqtg2ub/vt9bJ6f94GavNZj3PXDgbZplPb5oCcNKRk
         NCsvJSc38aegBVu/N+t6fEP8kM2VTaT5JvHxtYjes79lFqQGbJkY7ffvGgDLlMZ7cCg0
         DwW10/gqWcQmUI47Y6AV1v8FI66+yLMCFlLktoOBhP/vUGdyv7bCMFAvValrcfLr3CFh
         jLl9yl3L0e214xbzCZy6ozMOPZpZ+Yag0+09LLkJSfFA5JJRtuyxCjKG4RyuVNyVJP/e
         lDfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708984589; x=1709589389;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u1eIEAwPr48i+Yenfq0jlQKcUkAqO/w8pfipw6YSNWk=;
        b=J6H5SIY3+BzgvRznYbFI9PjYh37wM8httLibzhgZCpJWplX62i+kGycSKcqT+8nwXK
         lCrfNX2L81MrB/wr0iLZmSdc7Tol6B+qHqPbEYwqG+jRz6+Xuigt/vkOWlSuMNAMp230
         bpT/Aq5nb8tDq0O05RTLFwZSlDQCY4H3m9VriQ6wEGhsXKypfotml/GAUQ0hevU4RhQd
         HraMi3tlWGFM44utxEkBH0xnBhgCFIvOv3/WuKXHvHuVLYZ7X8KeetD7DysP5FBit7q3
         RKshLG/kWvaLpZmIWHzAgHaLcprzdASIXEX9yw3w537TW00pvGscCeGo11LdIpHBf+XG
         9I6g==
X-Forwarded-Encrypted: i=1; AJvYcCVh0kd2QruLH0ix5S/TMvfaI9YdsT2LEcJ9vpgaFOGUDTXSJIjAu1h+UqbWv9OheBodCS4Whi1S1qt5invOXvI1YXw2RKzTAcLSK2lpNgFtW++r0AVC/sJUs8Em3dXGEgyvXIAxS4dCdoFV
X-Gm-Message-State: AOJu0YwL+V6LAcJgSeEhsARHPkTmXCsecaB4VDKnZmWYilYQ55Ucq3rS
	/u7T8u8f0GS6j/OgbmxMr0nEPMT+yp7dv3LX/MAntDyBUyjZlNaA
X-Google-Smtp-Source: AGHT+IGGbUJ58ZLM7LIZyXCH7sTUgCAfWQZm/Ne7NZYSrHReRIXBPDv7+mmqDgsGTYNJAYLkOcLpsg==
X-Received: by 2002:a05:651c:97:b0:2d2:438a:11ec with SMTP id 23-20020a05651c009700b002d2438a11ecmr5209265ljq.2.1708984588910;
        Mon, 26 Feb 2024 13:56:28 -0800 (PST)
Received: from localhost.localdomain ([94.19.228.143])
        by smtp.gmail.com with ESMTPSA id k3-20020a2ea283000000b002d08f3640b5sm1018539lja.11.2024.02.26.13.56.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 13:56:28 -0800 (PST)
From: Andrey Skvortsov <andrej.skvortzov@gmail.com>
To: Corentin Labbe <clabbe.montjoie@gmail.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Ovidiu Panait <ovidiu.panait@windriver.com>,
	linux-crypto@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Arnaud Ferraris <arnaud.ferraris@collabora.com>,
	Andrey Skvortsov <andrej.skvortzov@gmail.com>
Subject: [PATCH] crypto: sun8i-ce - Fix use after free in unprepare.
Date: Tue, 27 Feb 2024 00:53:57 +0300
Message-ID: <20240226215358.555234-1-andrej.skvortzov@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

sun8i_ce_cipher_unprepare should be called before
crypto_finalize_skcipher_request, because client callbacks may
immediately free memory, that isn't needed anymore. But it will be
used by unprepare after free. Before removing prepare/unprepare
callbacks it was handled by crypto engine in crypto_finalize_request.

Usually that results in a pointer dereference problem during a in
crypto selftest.
 Unable to handle kernel NULL pointer dereference at
                                      virtual address 0000000000000030
 Mem abort info:
   ESR = 0x0000000096000004
   EC = 0x25: DABT (current EL), IL = 32 bits
   SET = 0, FnV = 0
   EA = 0, S1PTW = 0
   FSC = 0x04: level 0 translation fault
 Data abort info:
   ISV = 0, ISS = 0x00000004, ISS2 = 0x00000000
   CM = 0, WnR = 0, TnD = 0, TagAccess = 0
   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
 user pgtable: 4k pages, 48-bit VAs, pgdp=000000004716d000
 [0000000000000030] pgd=0000000000000000, p4d=0000000000000000
 Internal error: Oops: 0000000096000004 [#1] SMP

This problem is detected by KASAN as well.
 ==================================================================
 BUG: KASAN: slab-use-after-free in sun8i_ce_cipher_do_one+0x6e8/0xf80 [sun8i_ce]
 Read of size 8 at addr ffff00000dcdc040 by task 1c15000.crypto-/373

 Hardware name: Pine64 PinePhone (1.2) (DT)
 Call trace:
  dump_backtrace+0x9c/0x128
  show_stack+0x20/0x38
  dump_stack_lvl+0x48/0x60
  print_report+0xf8/0x5d8
  kasan_report+0x90/0xd0
  __asan_load8+0x9c/0xc0
  sun8i_ce_cipher_do_one+0x6e8/0xf80 [sun8i_ce]
  crypto_pump_work+0x354/0x620 [crypto_engine]
  kthread_worker_fn+0x244/0x498
  kthread+0x168/0x178
  ret_from_fork+0x10/0x20

 Allocated by task 379:
  kasan_save_stack+0x3c/0x68
  kasan_set_track+0x2c/0x40
  kasan_save_alloc_info+0x24/0x38
  __kasan_kmalloc+0xd4/0xd8
  __kmalloc+0x74/0x1d0
  alg_test_skcipher+0x90/0x1f0
  alg_test+0x24c/0x830
  cryptomgr_test+0x38/0x60
  kthread+0x168/0x178
  ret_from_fork+0x10/0x20

 Freed by task 379:
  kasan_save_stack+0x3c/0x68
  kasan_set_track+0x2c/0x40
  kasan_save_free_info+0x38/0x60
  __kasan_slab_free+0x100/0x170
  slab_free_freelist_hook+0xd4/0x1e8
  __kmem_cache_free+0x15c/0x290
  kfree+0x74/0x100
  kfree_sensitive+0x80/0xb0
  alg_test_skcipher+0x12c/0x1f0
  alg_test+0x24c/0x830
  cryptomgr_test+0x38/0x60
  kthread+0x168/0x178
  ret_from_fork+0x10/0x20

 The buggy address belongs to the object at ffff00000dcdc000
  which belongs to the cache kmalloc-256 of size 256
 The buggy address is located 64 bytes inside of
  freed 256-byte region [ffff00000dcdc000, ffff00000dcdc100)

Signed-off-by: Andrey Skvortsov <andrej.skvortzov@gmail.com>
Fixes: 4136212ab18e ("crypto: sun8i-ce - Remove prepare/unprepare request")
---
 .../allwinner/sun8i-ce/sun8i-ce-cipher.c      | 34 +++++++++----------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-cipher.c b/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-cipher.c
index 1262a7773ef3..de50c00ba218 100644
--- a/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-cipher.c
+++ b/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-cipher.c
@@ -299,22 +299,6 @@ static int sun8i_ce_cipher_prepare(struct crypto_engine *engine, void *async_req
 	return err;
 }
 
-static void sun8i_ce_cipher_run(struct crypto_engine *engine, void *areq)
-{
-	struct skcipher_request *breq = container_of(areq, struct skcipher_request, base);
-	struct crypto_skcipher *tfm = crypto_skcipher_reqtfm(breq);
-	struct sun8i_cipher_tfm_ctx *op = crypto_skcipher_ctx(tfm);
-	struct sun8i_ce_dev *ce = op->ce;
-	struct sun8i_cipher_req_ctx *rctx = skcipher_request_ctx(breq);
-	int flow, err;
-
-	flow = rctx->flow;
-	err = sun8i_ce_run_task(ce, flow, crypto_tfm_alg_name(breq->base.tfm));
-	local_bh_disable();
-	crypto_finalize_skcipher_request(engine, breq, err);
-	local_bh_enable();
-}
-
 static void sun8i_ce_cipher_unprepare(struct crypto_engine *engine,
 				      void *async_req)
 {
@@ -360,6 +344,23 @@ static void sun8i_ce_cipher_unprepare(struct crypto_engine *engine,
 	dma_unmap_single(ce->dev, rctx->addr_key, op->keylen, DMA_TO_DEVICE);
 }
 
+static void sun8i_ce_cipher_run(struct crypto_engine *engine, void *areq)
+{
+	struct skcipher_request *breq = container_of(areq, struct skcipher_request, base);
+	struct crypto_skcipher *tfm = crypto_skcipher_reqtfm(breq);
+	struct sun8i_cipher_tfm_ctx *op = crypto_skcipher_ctx(tfm);
+	struct sun8i_ce_dev *ce = op->ce;
+	struct sun8i_cipher_req_ctx *rctx = skcipher_request_ctx(breq);
+	int flow, err;
+
+	flow = rctx->flow;
+	err = sun8i_ce_run_task(ce, flow, crypto_tfm_alg_name(breq->base.tfm));
+	sun8i_ce_cipher_unprepare(engine, areq);
+	local_bh_disable();
+	crypto_finalize_skcipher_request(engine, breq, err);
+	local_bh_enable();
+}
+
 int sun8i_ce_cipher_do_one(struct crypto_engine *engine, void *areq)
 {
 	int err = sun8i_ce_cipher_prepare(engine, areq);
@@ -368,7 +369,6 @@ int sun8i_ce_cipher_do_one(struct crypto_engine *engine, void *areq)
 		return err;
 
 	sun8i_ce_cipher_run(engine, areq);
-	sun8i_ce_cipher_unprepare(engine, areq);
 	return 0;
 }
 
-- 
2.43.0



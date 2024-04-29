Return-Path: <linux-kernel+bounces-162392-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E34DC8B5A84
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 15:50:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 121F11C21534
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 13:50:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A7A6745F0;
	Mon, 29 Apr 2024 13:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Miyn4RRs"
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F6032E401;
	Mon, 29 Apr 2024 13:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714398626; cv=none; b=jdbMKWlmbRUDuB2I+TNYrwrckD1zfNvqXD6FyW3bk7E2iNzgZn7nlGO6ugzrZ2EBygED0sT1GVj27WOeMOx1x8Lodv0JOpUlWeEn9XE4wVYb0r1QpbSzzOThxXWw01zo4tqvcDIeiM27wqpVgTtcyjR3upa++opWXH2LYlqS/Ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714398626; c=relaxed/simple;
	bh=+0By3Q1rGnmYRl/UhuSgmrbF78ae6+PB61PhQldbPaM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ipUeYBaLajGOGL/bre1WcpXhXUlMoS97BBjhzF8mZV/pCCdnyP4Do072WO9s8706+xRgMmSx1NKABSzQtgJ0tnxr1rASlzDJk5Sx/HwezbklNJTdhJqF728uExGI0ztNDbFptbJBNOyu1N6t0mHGvl/UJrXY0lNyXYR9Dn6fUcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Miyn4RRs; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-2330f85c2ebso2754928fac.1;
        Mon, 29 Apr 2024 06:50:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714398624; x=1715003424; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XrhYSG3xhMDj7OBlL1tC1PWG3ln9HAJzaFMOoyJkhZ4=;
        b=Miyn4RRsaK0ofNecUnKAnYu/YL4R2QqKNOIjFtmXFhLmQIvLwzDWwh6WcfOvjFzgAO
         bdM0rQ0qbdE8ID9iezf/kbDAHemIHdoYzN9WPgIegqQNn2xXTrKZC0Bfb16f6dtmoDnt
         zeii0JfK4JKomPl4CsK6GVY1NdzC8ERj82CgRLvW9ri3Sdz4nlR64IQ4TESoyH3xB1MS
         /FAYmJuyO1DCqVrHFoEKg5F2gFbHlSrdQXUNe3pmHqR+rq0V0DWkN76AMItnrr+LjiQg
         BnSh73O+pLV2E829HTjnQEGc61VBUiUh1pbw3vJGAF6oxLRykF1tNoDS5Jy80u8hHLDU
         ud6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714398624; x=1715003424;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XrhYSG3xhMDj7OBlL1tC1PWG3ln9HAJzaFMOoyJkhZ4=;
        b=Ew9Vj/WOrihZkaoxvZtFM7z5mG0CvgI1aVLNNQXrXLCQClDBmvZaJ8Y4lj4FEGoHm/
         IvCiAwvT0W0RwoM+ycxSi9y1myYYbuuWrLN1/B9Qkk9yPYmixYNKsoA/Rj7sHHeYcClm
         eprqaHWeL7NWw1cL1WevfbnuJfx/r9ZTVKt9igic0eYYCXXQ8qoK73EcMX7OI2Nn2Mri
         ClJ5Dph7k+CneTiOKF5fYVsqEK9wjtEmfzbvW3mUdjwsVlxASU6AVgo0Yk+Ssq6WX9WE
         N0ZYetkCIT721UC4TGm9s8NehreeuaruAsNrY4O0gkfIptdMNZ62wta13Aq2f6Y+HuKB
         Ra3w==
X-Forwarded-Encrypted: i=1; AJvYcCXZ0Njks8iGfU+kl2D6w6aq4Qd4RVc7uswPDdkSXWTPcjaVTK5Pu5zXPKsFq5awSTT7dShH3v/5f5nDdjDt7fP71HkZz3+vKEJvI12n26wHa1WS0TdK6DxrlQuMSgFhlCd2dQ3JPLL77AJw
X-Gm-Message-State: AOJu0Yz7LsJdZ4LwEHNugtPIm86qn6vIMA0erYi0rt+FucyD7xeY1BLd
	IzUxAkFRpwChn7bYa9KnYWZtTqN8sqFXdxTcVXKn1LGOBCiddKZd
X-Google-Smtp-Source: AGHT+IGFBF9LW2f4hp7yGLnn003gFHU/d1F8U7C1YHmI+jPbYT4dNTlp68ZwOuiPM700ftEs4rXNIA==
X-Received: by 2002:a05:6870:5d8a:b0:23c:a649:4a48 with SMTP id fu10-20020a0568705d8a00b0023ca6494a48mr3246819oab.36.1714398624128;
        Mon, 29 Apr 2024 06:50:24 -0700 (PDT)
Received: from perdition.xmission.com ([2607:fa18:0:2::74])
        by smtp.gmail.com with ESMTPSA id l5-20020a654485000000b005d8b2f04eb7sm15952921pgq.62.2024.04.29.06.50.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 06:50:23 -0700 (PDT)
From: Aaron Toponce <aaron.toponce@gmail.com>
To: 
Cc: aaron.toponce@gmail.com,
	"Theodore Ts'o" <tytso@mit.edu>,
	"Jason A. Donenfeld" <Jason@zx2c4.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	linux-kernel@vger.kernel.org,
	linux-crypto@vger.kernel.org
Subject: [PATCH] random: add chacha8_block and swtich the rng to it
Date: Mon, 29 Apr 2024 07:48:49 -0600
Message-ID: <20240429134942.2873253-1-aaron.toponce@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

According to Jean-Philippe Aumasson in his paper "Too Much Crypto" [1]:

> "The best result on ChaCha is a key recovery attack on the 7-round version
> with 2^237.7 time complexity using output data from 2^96 instances of ChaCha,
> that is, 2^105 bytes of data."

He then proposes that ChaCha use 8 rounds instead of 20, providing a 2.5x
speed-up. As such, this patch adds chacha8_block and chacha12_block and switches
the RNG from ChaCha20 to ChaCha8 to take advantage of that efficiency without
sacrificing security.

[1]: https://eprint.iacr.org/2019/1492

On my ThinkPad T480s with an Intel(R) Core(TM) i7-8650U CPU @ 1.90GHz, the
speed-up is close to what would be expected.

Without the patch:

  $ dd if=/dev/urandom of=/dev/null bs=32M count=300
  300+0 records in
  300+0 records out
  10066329600 bytes (10 GB, 9.4 GiB) copied, 20.4806 s, 492 MB/s

With the patch:

  $ dd if=/dev/urandom of=/dev/null bs=32M count=300
  300+0 records in
  300+0 records out
  10066329600 bytes (10 GB, 9.4 GiB) copied, 11.5321 s, 873 MB/s

Signed-off-by: Aaron Toponce <aaron.toponce@gmail.com>
---
 drivers/char/random.c   |  8 ++++----
 include/crypto/chacha.h | 14 ++++++++++++--
 lib/crypto/chacha.c     |  6 +++---
 3 files changed, 19 insertions(+), 9 deletions(-)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index 2597cb43f438..2e14a30b795f 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -302,7 +302,7 @@ static void crng_fast_key_erasure(u8 key[CHACHA_KEY_SIZE],
 	chacha_init_consts(chacha_state);
 	memcpy(&chacha_state[4], key, CHACHA_KEY_SIZE);
 	memset(&chacha_state[12], 0, sizeof(u32) * 4);
-	chacha20_block(chacha_state, first_block);
+	chacha8_block(chacha_state, first_block);
 
 	memcpy(key, first_block, CHACHA_KEY_SIZE);
 	memcpy(random_data, first_block + CHACHA_KEY_SIZE, random_data_len);
@@ -388,13 +388,13 @@ static void _get_random_bytes(void *buf, size_t len)
 
 	while (len) {
 		if (len < CHACHA_BLOCK_SIZE) {
-			chacha20_block(chacha_state, tmp);
+			chacha8_block(chacha_state, tmp);
 			memcpy(buf, tmp, len);
 			memzero_explicit(tmp, sizeof(tmp));
 			break;
 		}
 
-		chacha20_block(chacha_state, buf);
+		chacha8_block(chacha_state, buf);
 		if (unlikely(chacha_state[12] == 0))
 			++chacha_state[13];
 		len -= CHACHA_BLOCK_SIZE;
@@ -444,7 +444,7 @@ static ssize_t get_random_bytes_user(struct iov_iter *iter)
 	}
 
 	for (;;) {
-		chacha20_block(chacha_state, block);
+		chacha8_block(chacha_state, block);
 		if (unlikely(chacha_state[12] == 0))
 			++chacha_state[13];
 
diff --git a/include/crypto/chacha.h b/include/crypto/chacha.h
index b3ea73b81944..64c45121c69a 100644
--- a/include/crypto/chacha.h
+++ b/include/crypto/chacha.h
@@ -8,8 +8,7 @@
  *
  * The ChaCha paper specifies 20, 12, and 8-round variants.  In general, it is
  * recommended to use the 20-round variant ChaCha20.  However, the other
- * variants can be needed in some performance-sensitive scenarios.  The generic
- * ChaCha code currently allows only the 20 and 12-round variants.
+ * variants can be needed in some performance-sensitive scenarios.
  */
 
 #ifndef _CRYPTO_CHACHA_H
@@ -31,11 +30,22 @@
 #define XCHACHA_IV_SIZE		32
 
 void chacha_block_generic(u32 *state, u8 *stream, int nrounds);
+
 static inline void chacha20_block(u32 *state, u8 *stream)
 {
 	chacha_block_generic(state, stream, 20);
 }
 
+static inline void chacha12_block(u32 *state, u8 *stream)
+{
+	chacha_block_generic(state, stream, 12);
+}
+
+static inline void chacha8_block(u32 *state, u8 *stream)
+{
+	chacha_block_generic(state, stream, 8);
+}
+
 void hchacha_block_arch(const u32 *state, u32 *out, int nrounds);
 void hchacha_block_generic(const u32 *state, u32 *out, int nrounds);
 
diff --git a/lib/crypto/chacha.c b/lib/crypto/chacha.c
index b748fd3d256e..15e773629f1d 100644
--- a/lib/crypto/chacha.c
+++ b/lib/crypto/chacha.c
@@ -18,7 +18,7 @@ static void chacha_permute(u32 *x, int nrounds)
 	int i;
 
 	/* whitelist the allowed round counts */
-	WARN_ON_ONCE(nrounds != 20 && nrounds != 12);
+	WARN_ON_ONCE(nrounds != 20 && nrounds != 12 && nrounds != 8);
 
 	for (i = 0; i < nrounds; i += 2) {
 		x[0]  += x[4];    x[12] = rol32(x[12] ^ x[0],  16);
@@ -67,7 +67,7 @@ static void chacha_permute(u32 *x, int nrounds)
  * chacha_block_generic - generate one keystream block and increment block counter
  * @state: input state matrix (16 32-bit words)
  * @stream: output keystream block (64 bytes)
- * @nrounds: number of rounds (20 or 12; 20 is recommended)
+ * @nrounds: number of rounds (20, 12, or 8; 20 is recommended)
  *
  * This is the ChaCha core, a function from 64-byte strings to 64-byte strings.
  * The caller has already converted the endianness of the input.  This function
@@ -93,7 +93,7 @@ EXPORT_SYMBOL(chacha_block_generic);
  * hchacha_block_generic - abbreviated ChaCha core, for XChaCha
  * @state: input state matrix (16 32-bit words)
  * @stream: output (8 32-bit words)
- * @nrounds: number of rounds (20 or 12; 20 is recommended)
+ * @nrounds: number of rounds (20, 12, or 8; 20 is recommended)
  *
  * HChaCha is the ChaCha equivalent of HSalsa and is an intermediate step
  * towards XChaCha (see https://cr.yp.to/snuffle/xsalsa-20081128.pdf).  HChaCha
-- 
2.43.0



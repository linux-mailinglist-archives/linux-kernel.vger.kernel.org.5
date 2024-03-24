Return-Path: <linux-kernel+bounces-114628-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E6AF5889090
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:21:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6082D1F2BEC6
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 06:21:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25927634E2;
	Sun, 24 Mar 2024 23:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FcXtrGSb"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 821C714E2E1;
	Sun, 24 Mar 2024 23:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711322293; cv=none; b=AURyyjb70BPlaNddwH+y8Vm7b666awBGAci3NLewL8tYDcpkGf+7mfXj2xDKbsB8urCBEQdCsgBNDhsSFbuQ76VZB7W7SEKFKml40kwdfxpP8H9NDQBXeFjzxWxT6Giz0ozVXPBiPn86LjypTSiih0357Kd6FexVKWBTVFnjV08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711322293; c=relaxed/simple;
	bh=qlqGs1KBg1SApJuhcEoN2eLBvYnOi0RiyvgtUQtvjUE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hPL1ASq7aguMoPBCzNYepV67HG8xwaSN2xX9BfHITo6r8m8wN4n4yYdvNS1YVuJhbbVHLkjYPzjj0nXnUZve2pTJ1xVCvaJUyMECDwnPgSTWVLIKf/O7qgYP2dEGd5BY1LY7xFMj/ZXyQ3SYe0YTPTysSz0O63E+3kp2qPKZrIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FcXtrGSb; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1e0511a4383so25819455ad.2;
        Sun, 24 Mar 2024 16:18:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711322289; x=1711927089; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=wUHGCa8f3fjObt552t0V01N5ZUBRCYjs2IcWQiSkU3A=;
        b=FcXtrGSbf6osnlG0UIkwPpVHwqtkpvGUs2d/QRk6F/XOjthigOmaWaT24kAXiag98Z
         43BEWbF9ysVJSivwWVL3U0JM5Us1aoXPm29Lri/E8wHJiLUBDqNhzIA7hrHY5173cbln
         CTmDzq2vV/H4t/dYjSwXlFoyvwD6Y/a+OAzBaLiNwrXj85xryn7J+x7r3tfLA5Oyi6X+
         kx7HQntUJz77+hc2vQCtTXfqEjCd9LgxPIeIFQphe91f4riGi6Tx9XO2WsYJT2oQSA6E
         nGqPXzFK2TznevFjHx9tSKU2bM4hJn1Wxm08//2PIukixJT2tVTX1DEXwpdLOzZ6lsOE
         nnTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711322289; x=1711927089;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wUHGCa8f3fjObt552t0V01N5ZUBRCYjs2IcWQiSkU3A=;
        b=QOrg0OF0zrBARHZaQqFyFD43t4jKNEjt+BmppPN8UQ0YJiDHzl4QKqob2+jnHyf4YW
         LOPUInNaWPFlB5ORNQJKphpCm2yL2Db5dJtXcoOnyDhf0HCLn0ke9zyzPGlt2fcQFvs1
         ZsYRNZxYHrwtNytkUZUrg4TZ71xSd/BqTCwGw1Z0XAFMV90XiJ/36VGLVe4DoEipXVui
         cJd1VW1PbykuEkqqa/hUv6dkchLlFalB/BWQobygVubMbQrJzXXQ5v2c4r95h/k4EiOC
         clGKHUpsVPLlNJVSfZrRgA70w9azRxoSbB3pdqagocgfDoTUWOLT4sCAl9h7uQUlz+wE
         7VtQ==
X-Forwarded-Encrypted: i=1; AJvYcCWf4ruTRXjbs1RL+lX2Vi4k91XVaLs13vj+OI1UaCr8tdvFX78V/u7jL308WujMFVEl7JVa948HRxNd7Gs9vIYUz/zUGSB/t9M0bczRieb57WjJn1wZZaIN7tr0rWZzvDNEd9IbyYU=
X-Gm-Message-State: AOJu0YzG5PjIOvIIdkaLwZCZtxBZ9ct1Vi9kRkzfq2NMWcJ3/JjtbmGH
	NXTbHPtfjuf3qZx2eipTbFFPAkRpOOdoebYBTiWcl5gk+FxgZ/l/EMcd0gGJ
X-Google-Smtp-Source: AGHT+IEZClRknRww4wVYAyV0CjCkAxoD+LJz0wxucbyg1TOFMn0qM1tD62kuXF1Fdb2/vUJPyMmQWw==
X-Received: by 2002:a17:902:f708:b0:1e0:648e:8336 with SMTP id h8-20020a170902f70800b001e0648e8336mr6135391plo.4.1711322288573;
        Sun, 24 Mar 2024 16:18:08 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id q8-20020a170902b10800b001e00d9680cesm3529370plr.130.2024.03.24.16.18.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Mar 2024 16:18:07 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
To: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: Rich Felker <dalias@libc.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	linux-sh@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH] Revert "sh: Handle calling csum_partial with misaligned data"
Date: Sun, 24 Mar 2024 16:18:04 -0700
Message-Id: <20240324231804.841099-1-linux@roeck-us.net>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This reverts commit cadc4e1a2b4d20d0cc0e81f2c6ba0588775e54e5.

Commit cadc4e1a2b4d ("sh: Handle calling csum_partial with misaligned
data") causes bad checksum calculations on unaligned data. Reverting
it fixes the problem.

    # Subtest: checksum
    # module: checksum_kunit
    1..5
    # test_csum_fixed_random_inputs: ASSERTION FAILED at lib/checksum_kunit.c:500
    Expected ( u64)result == ( u64)expec, but
        ( u64)result == 53378 (0xd082)
        ( u64)expec == 33488 (0x82d0)
    # test_csum_fixed_random_inputs: pass:0 fail:1 skip:0 total:1
    not ok 1 test_csum_fixed_random_inputs
    # test_csum_all_carry_inputs: ASSERTION FAILED at lib/checksum_kunit.c:525
    Expected ( u64)result == ( u64)expec, but
        ( u64)result == 65281 (0xff01)
        ( u64)expec == 65280 (0xff00)
    # test_csum_all_carry_inputs: pass:0 fail:1 skip:0 total:1
    not ok 2 test_csum_all_carry_inputs
    # test_csum_no_carry_inputs: ASSERTION FAILED at lib/checksum_kunit.c:573
    Expected ( u64)result == ( u64)expec, but
        ( u64)result == 65535 (0xffff)
        ( u64)expec == 65534 (0xfffe)
    # test_csum_no_carry_inputs: pass:0 fail:1 skip:0 total:1
    not ok 3 test_csum_no_carry_inputs
    # test_ip_fast_csum: pass:1 fail:0 skip:0 total:1
    ok 4 test_ip_fast_csum
    # test_csum_ipv6_magic: pass:1 fail:0 skip:0 total:1
    ok 5 test_csum_ipv6_magic
 # checksum: pass:2 fail:3 skip:0 total:5
 # Totals: pass:2 fail:3 skip:0 total:5
not ok 22 checksum

Fixes: cadc4e1a2b4d ("sh: Handle calling csum_partial with misaligned data")
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 arch/sh/lib/checksum.S | 67 ++++++++++++------------------------------
 1 file changed, 18 insertions(+), 49 deletions(-)

diff --git a/arch/sh/lib/checksum.S b/arch/sh/lib/checksum.S
index 3e07074e0098..06fed5a21e8b 100644
--- a/arch/sh/lib/checksum.S
+++ b/arch/sh/lib/checksum.S
@@ -33,7 +33,8 @@
  */
 
 /*	
- * asmlinkage __wsum csum_partial(const void *buf, int len, __wsum sum);
+ * unsigned int csum_partial(const unsigned char *buf, int len,
+ *                           unsigned int sum);
  */
 
 .text
@@ -45,31 +46,11 @@ ENTRY(csum_partial)
 	   * Fortunately, it is easy to convert 2-byte alignment to 4-byte
 	   * alignment for the unrolled loop.
 	   */
+	mov	r5, r1
 	mov	r4, r0
-	tst	#3, r0		! Check alignment.
-	bt/s	2f		! Jump if alignment is ok.
-	 mov	r4, r7		! Keep a copy to check for alignment
+	tst	#2, r0		! Check alignment.
+	bt	2f		! Jump if alignment is ok.
 	!
-	tst	#1, r0		! Check alignment.
-	bt	21f		! Jump if alignment is boundary of 2bytes.
-
-	! buf is odd
-	tst	r5, r5
-	add	#-1, r5
-	bt	9f
-	mov.b	@r4+, r0
-	extu.b	r0, r0
-	addc	r0, r6		! t=0 from previous tst
-	mov	r6, r0
-	shll8	r6
-	shlr16	r0
-	shlr8	r0
-	or	r0, r6
-	mov	r4, r0
-	tst	#2, r0
-	bt	2f
-21:
-	! buf is 2 byte aligned (len could be 0)
 	add	#-2, r5		! Alignment uses up two bytes.
 	cmp/pz	r5		!
 	bt/s	1f		! Jump if we had at least two bytes.
@@ -77,17 +58,16 @@ ENTRY(csum_partial)
 	bra	6f
 	 add	#2, r5		! r5 was < 2.  Deal with it.
 1:
+	mov	r5, r1		! Save new len for later use.
 	mov.w	@r4+, r0
 	extu.w	r0, r0
 	addc	r0, r6
 	bf	2f
 	add	#1, r6
 2:
-	! buf is 4 byte aligned (len could be 0)
-	mov	r5, r1
 	mov	#-5, r0
-	shld	r0, r1
-	tst	r1, r1
+	shld	r0, r5
+	tst	r5, r5
 	bt/s	4f		! if it's =0, go to 4f
 	 clrt
 	.align	2
@@ -109,31 +89,30 @@ ENTRY(csum_partial)
 	addc	r0, r6
 	addc	r2, r6
 	movt	r0
-	dt	r1
+	dt	r5
 	bf/s	3b
 	 cmp/eq	#1, r0
-	! here, we know r1==0
-	addc	r1, r6			! add carry to r6
+	! here, we know r5==0
+	addc	r5, r6			! add carry to r6
 4:
-	mov	r5, r0
+	mov	r1, r0
 	and	#0x1c, r0
 	tst	r0, r0
-	bt	6f
-	! 4 bytes or more remaining
-	mov	r0, r1
-	shlr2	r1
+	bt/s	6f
+	 mov	r0, r5
+	shlr2	r5
 	mov	#0, r2
 5:
 	addc	r2, r6
 	mov.l	@r4+, r2
 	movt	r0
-	dt	r1
+	dt	r5
 	bf/s	5b
 	 cmp/eq	#1, r0
 	addc	r2, r6
-	addc	r1, r6		! r1==0 here, so it means add carry-bit
+	addc	r5, r6		! r5==0 here, so it means add carry-bit
 6:
-	! 3 bytes or less remaining
+	mov	r1, r5
 	mov	#3, r0
 	and	r0, r5
 	tst	r5, r5
@@ -159,16 +138,6 @@ ENTRY(csum_partial)
 	mov	#0, r0
 	addc	r0, r6
 9:
-	! Check if the buffer was misaligned, if so realign sum
-	mov	r7, r0
-	tst	#1, r0
-	bt	10f
-	mov	r6, r0
-	shll8	r6
-	shlr16	r0
-	shlr8	r0
-	or	r0, r6
-10:
 	rts
 	 mov	r6, r0
 
-- 
2.39.2



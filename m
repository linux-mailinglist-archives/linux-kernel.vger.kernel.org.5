Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41AB98117F7
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 16:46:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442591AbjLMPqQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 10:46:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442633AbjLMPpr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 10:45:47 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FEEE1A3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 07:45:35 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id ffacd0b85a97d-33634ed6200so163061f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 07:45:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702482334; x=1703087134; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/6lUS/g1laxQCVVAVJXpN956K5iMIXsWwq/VHyu1zHk=;
        b=S70zZDjDf3XBKbRYELUTiaFt9VfIoNSI85uhC77keuHwctUxUIzELfN2GX8Kr0fOyg
         Zq9axQxKEYIdAYvYyKBs/taxr+vTUH1wm1JbGG0mTdzpkYrD7ZolLEg5Z4hLtkcDV4ab
         HBrlX+IRZCq3B9bMMcjGZud3joTkpAdFpbYRkL0W6ZraCpCNDDtdO1FVk5Bx5vmSQCN0
         Wir83uhhOfHOzngLOsZFEfoK6Z3XmopECiek+WcunHIAWE2Nd6Vjg6or/2Q+0uL7cbKV
         N1/DzJGPIrIO6dzRtNPIw6c2DkG/BrFWDoZl3K4OFtC9dwmqaWVxQkfI48EIB9yjfMWZ
         PIxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702482334; x=1703087134;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/6lUS/g1laxQCVVAVJXpN956K5iMIXsWwq/VHyu1zHk=;
        b=q2P6c55d7y0yPVo9raQSeMnSm21riVlt3/SkUf6GZNokDxSOUCWv2BuQXPzpAFY0aP
         XerGGLWUXcL9opkybrtjxc1o5+h9Vyj5+AZFBvJQALLKo1cGkOMBTBZ/7kmBd0GamqJZ
         omFiE1BTWhjdWO9ppXVyiZ4ioSEkTt0hXx/23iDFXJFLYBJGYxs25HJluWmSZ6xyVjbD
         IvPIZsoH5DloXymfljGsOFDgFSdru07du5rSwuZmFGfgsDcxbg+mvbyCay81+HIvYUZw
         kUQlknHc0l39UA69KYlSi+2ElcohGUdcoWM+1JNl5nbyLBzSiPmJeelwtOp08jcjK5KE
         FJzQ==
X-Gm-Message-State: AOJu0Yyvt0v6y82t4uIOxu06PISxSFdPjjGqy+x5JJxAFtRFGTidZEwl
        J8hDsY1ZmGk8+X6QCCN22CY=
X-Google-Smtp-Source: AGHT+IGshHAl2eK9hEA+3zLn++WEHxJirAYQ6TQG8PT1AbNLEWonPLRlRz4I8Rm+Ma+qjjtZHqjgEw==
X-Received: by 2002:a5d:64ee:0:b0:333:538a:af10 with SMTP id g14-20020a5d64ee000000b00333538aaf10mr10212763wri.6.1702482333813;
        Wed, 13 Dec 2023 07:45:33 -0800 (PST)
Received: from ivan-HLYL-WXX9.guest.codethink.co.uk ([167.98.27.226])
        by smtp.gmail.com with ESMTPSA id e18-20020a056000121200b00333404e9935sm13546482wrx.54.2023.12.13.07.45.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 07:45:33 -0800 (PST)
From:   Ivan Orlov <ivan.orlov0322@gmail.com>
To:     paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu
Cc:     Ivan Orlov <ivan.orlov0322@gmail.com>, conor.dooley@microchip.com,
        ajones@ventanamicro.com, samuel@sholland.org,
        alexghiti@rivosinc.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, skhan@linuxfoundation.org
Subject: [PATCH] riscv: lib: Optimize 'strlen' function
Date:   Wed, 13 Dec 2023 15:45:30 +0000
Message-Id: <20231213154530.1970216-1-ivan.orlov0322@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current non-ZBB implementation of 'strlen' function iterates the
memory bytewise, looking for a zero byte. It could be optimized to use
the wordwise iteration instead, so we will process 4/8 bytes of memory
at a time.

Word could be tested for containing the zero byte in just 4 operations:

1. Subtract 0x0101..01 from the word. If there was a zero byte in the
word, the leading zero bit of this byte will turn to 1.
2. Calculate ~word.
3. And the subtraction result with ~word. That way we will know if some
bits were 0 and then turned to 1.
4. And the result of step 3 with 0x8080..80. 0x8080..90 filters leading
bits for every byte in the word, so we will know if one of them turned
from 0 to 1.

This patch modifies the riscv-specific strlen function to work in the
following way:

1. If the address is unaligned, iterate SZREG - (address % SZREG) bytes
to align it.
2. After the address is aligned, iterate words of memory and check them
for containing the zero byte using the algorithm described above.
3. When we found a word with a zero byte, iterate through the word
bytewise to get the exact position of the 0 and return the corresponding
string length.

Here you can find the benchmarking results for the VisionFive2 board
comparing the old and new implementations of the strlen function.

Size: 1 (+-0), mean_old: 673, mean_new: 666
Size: 2 (+-0), mean_old: 672, mean_new: 676
Size: 4 (+-0), mean_old: 685, mean_new: 659
Size: 8 (+-0), mean_old: 682, mean_new: 673
Size: 16 (+-0), mean_old: 718, mean_new: 694
Size: 32 (+-0), mean_old: 753, mean_new: 726
Size: 64 (+-3), mean_old: 835, mean_new: 773
Size: 128 (+-8), mean_old: 994, mean_new: 821
Size: 256 (+-4), mean_old: 1314, mean_new: 924
Size: 512 (+-38), mean_old: 1978, mean_new: 1105
Size: 1024 (+-40), mean_old: 3263, mean_new: 1542
Size: 2048 (+-54), mean_old: 5871, mean_new: 2352
Size: 4096 (+-155), mean_old: 11061, mean_new: 3972
Size: 8192 (+-542), mean_old: 21431, mean_new: 7214
Size: 16384 (+-43), mean_old: 42239, mean_new: 13722
Size: 32768 (+-2712), mean_old: 85674, mean_new: 28471
Size: 65536 (+-907), mean_old: 189219, mean_new: 74236
Size: 131072 (+-1343), mean_old: 377023, mean_new: 147130
Size: 262144 (+-411), mean_old: 752993, mean_new: 292799
Size: 524288 (+-12242), mean_old: 1504279, mean_new: 583952

The function was tested on different string lengths and random offsets
(to check how it works with unaligned addresses). The clocks count were
measured with ktime_get and the mean values are calculated from 1000
test runs for every string length.

You can notice that the new function is slightly faster for small string
lengths and 2-3 times faster for longer strings, therefore I believe
this change could be really useful.

Signed-off-by: Ivan Orlov <ivan.orlov0322@gmail.com>
---
 arch/riscv/lib/strlen.S | 72 +++++++++++++++++++++++++++++++----------
 1 file changed, 55 insertions(+), 17 deletions(-)

diff --git a/arch/riscv/lib/strlen.S b/arch/riscv/lib/strlen.S
index 8ae3064e45ff..76486dd3c07d 100644
--- a/arch/riscv/lib/strlen.S
+++ b/arch/riscv/lib/strlen.S
@@ -5,29 +5,67 @@
 #include <asm/alternative-macros.h>
 #include <asm/hwcap.h>
 
-/* int strlen(const char *s) */
-SYM_FUNC_START(strlen)
+#define REP_80 __REG_SEL(0x8080808080808080, 0x80808080)
+#define REP_01 __REG_SEL(0x0101010101010101, 0x01010101)
 
+/* size_t strlen(const char *s) */
+SYM_FUNC_START(strlen)
 	ALTERNATIVE("nop", "j strlen_zbb", 0, RISCV_ISA_EXT_ZBB, CONFIG_RISCV_ISA_ZBB)
 
 	/*
-	 * Returns
-	 *   a0 - string length
-	 *
-	 * Parameters
-	 *   a0 - String to measure
-	 *
-	 * Clobbers:
-	 *   t0, t1
-	 */
-	mv	t1, a0
+         * Returns
+         *   a0 - string length
+         *
+         * Parameters
+         *   a0 - String to measure
+         *
+         * Clobbers:
+         *   t0, t1, t2, t3, t4
+         */
+
+
+	mv t4, a0
+
+	/* Check the address memory alignment */
+	andi t2, a0, SZREG-1
+	beqz t2, 2f
+
+	/* Get SZREG - (address remainder) */
+	xori t2, t2, SZREG-1
+	addi t2, t2, 1
+
+	/* align the address */
+	add t2, a0, t2
 1:
-	lbu	t0, 0(t1)
-	beqz	t0, 2f
-	addi	t1, t1, 1
-	j	1b
+	beq a0, t2, 2f
+	lbu t1, 0(a0)
+	beqz t1, 5f
+	addi a0, a0, 1
+	j 1b
 2:
-	sub	a0, t1, a0
+	li t2, REP_80
+	li t3, REP_01
+3:
+	/* v contains 0 byte if (v - 0x0101..01) & ~v & 0x8080..80 != 0 */
+	REG_L t0, 0(a0)
+	sub t1, t0, t3
+	not t0, t0
+	and t1, t1, t0
+	and t1, t1, t2
+	bnez t1, 4f
+	addi a0, a0, SZREG
+	j 3b
+4:
+	/*
+	 * We found the word with 0, iterate it byte-wise to find the actual
+	 * string length.
+	 */
+	lbu t0, 0(a0)
+	beqz t0, 5f
+	addi a0, a0, 1
+	j 4b
+5:
+	sub a0, a0, t4
 	ret
 
 /*
-- 
2.34.1


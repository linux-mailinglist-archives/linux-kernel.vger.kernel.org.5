Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01644779264
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 17:06:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234802AbjHKPGL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 11:06:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229987AbjHKPGK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 11:06:10 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F8712D79
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 08:06:09 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id ffacd0b85a97d-317715ec496so1896786f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 08:06:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1691766367; x=1692371167;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+UvZ9HrNi6+0yvLdChwz5BHmbfK5E+QD2Q28lED/r0w=;
        b=DoAkr8vQPF+g1TAc2v1DWTvRvYCOdl+r1dl2Gn3/JA21fcwn/yjAJVGIMwtQRglFEZ
         LG3+WQigEgoFMBi5nkax70WTsesmgUPV4QmvGhhTNPXFHoWJ+wrdnWSxoeMtAzIUyNog
         VfjRy/yNxn6huscKH8uRh4XYWKOebfrCiof1yVnhUaV/SKSmHkIytq+bQLqHNd+/u0G0
         JOoNfaEweEsBww5/QQYdCm6+vvN7S1UNBeqviZChjv5/kG38WdiVTl0TV3mdLkU+hc3m
         QnKkIURJn+Ll0SvggNw7RiienZoO/34+sLH7H5IlTYAhvqAm1LsdokweIzqX/fjVaaG/
         49sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691766367; x=1692371167;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+UvZ9HrNi6+0yvLdChwz5BHmbfK5E+QD2Q28lED/r0w=;
        b=cEdxS7WTPCgXD84ZYp/dSj6LwR+9kwZhJOPMBExqk+RMuWJ5twuDzlaxB+owrbNHY9
         Kwii0Kvfdd1TgsxqfF/lMZkQqWj3CUvnby4mXRVqhRGuhRrG9kVP03H3FRzpW3hx+nbq
         bmwkbGSEJbk7NdtBp0HzaHRlfkavylIzSSyEo3awoHzREtbXkNTM/Hbs/chraJlvKaZ3
         mby7PNUKDInFoWYfKCaWoFE68jVI26uHKYIQ2M5EmuWD8shDA4xa5ul0fFUdFPKD7rKR
         YHl6I2HgPeazMO3pJtNF3qVaiwbHNRxZfHo+uI16tecJWgtoFMoARqXPqN0p/Ie4ZVT2
         NA4g==
X-Gm-Message-State: AOJu0YyaXLnNZuBhlHEjwjjRmUfraKPXTqv0FDYKHsv7LyY8/9G6eUK6
        +UsvNlkl4pkdGCVGdXHGGMfJMg==
X-Google-Smtp-Source: AGHT+IEspuCzVImRxZHDzo52eLe0Y1eyFUEFhTu07gl6/+etdGcwcvyYYYANXY5lJOKHC8KYzPjJ4Q==
X-Received: by 2002:a5d:62d1:0:b0:317:3d36:b2cd with SMTP id o17-20020a5d62d1000000b003173d36b2cdmr1302741wrv.71.1691766367377;
        Fri, 11 Aug 2023 08:06:07 -0700 (PDT)
Received: from alex-rivos.ba.rivosinc.com (amontpellier-656-1-456-62.w92-145.abo.wanadoo.fr. [92.145.124.62])
        by smtp.gmail.com with ESMTPSA id w4-20020adfcd04000000b003176eab8868sm5704018wrm.82.2023.08.11.08.06.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Aug 2023 08:06:07 -0700 (PDT)
From:   Alexandre Ghiti <alexghiti@rivosinc.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Alan Kao <alankao@andestech.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Alexandre Ghiti <alexghiti@rivosinc.com>,
        Bo YU <tsu.yubo@gmail.com>,
        Aurelien Jarno <aurelien@aurel32.net>,
        =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@rivosinc.com>
Subject: [PATCH -fixes v2] riscv: uaccess: Return the number of bytes effectively not copied
Date:   Fri, 11 Aug 2023 17:06:04 +0200
Message-Id: <20230811150604.1621784-1-alexghiti@rivosinc.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It was reported that the riscv kernel hangs while executing the test
in [1].

Indeed, the test hangs when trying to write a buffer to a file. The
problem is that the riscv implementation of raw_copy_from_user() does not
return the correct number of bytes not written when an exception happens
and is fixed up, instead it always returns the initial size to copy,
even if some bytes were actually copied.

generic_perform_write() pre-faults the user pages and bails out if nothing
can be written, otherwise it will access the userspace buffer: here the
riscv implementation keeps returning it was not able to copy any byte
though the pre-faulting indicates otherwise. So generic_perform_write()
keeps retrying to access the user memory and ends up in an infinite
loop.

Note that before the commit mentioned in [1] that introduced this
regression, it worked because generic_perform_write() would bail out if
only one byte could not be written.

So fix this by returning the number of bytes effectively not written in
__asm_copy_[to|from]_user() and __clear_user(), as it is expected.

Link: https://lore.kernel.org/linux-riscv/20230309151841.bomov6hq3ybyp42a@debian/ [1]
Fixes: ebcbd75e3962 ("riscv: Fix the bug in memory access fixup code")
Reported-by: Bo YU <tsu.yubo@gmail.com>
Closes: https://lore.kernel.org/linux-riscv/20230309151841.bomov6hq3ybyp42a@debian/#t
Reported-by: Aurelien Jarno <aurelien@aurel32.net>
Closes: https://lore.kernel.org/linux-riscv/ZNOnCakhwIeue3yr@aurel32.net/
Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
Reviewed-by: Björn Töpel <bjorn@rivosinc.com>
Tested-by: Aurelien Jarno <aurelien@aurel32.net>
Reviewed-by: Aurelien Jarno <aurelien@aurel32.net>
---

Changes in v2:
  - Add RB/TB from Bjorn and Aurelien
  - Fix commit changelog as it incorrectly stated the functions should
    return the number of bytes copied, whereas it is actually the number
    of bytes *not* written
  - Improved changelog a bit in the 2nd paragraph

 arch/riscv/lib/uaccess.S | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/arch/riscv/lib/uaccess.S b/arch/riscv/lib/uaccess.S
index ec486e5369d9..09b47ebacf2e 100644
--- a/arch/riscv/lib/uaccess.S
+++ b/arch/riscv/lib/uaccess.S
@@ -17,8 +17,11 @@ ENTRY(__asm_copy_from_user)
 	li t6, SR_SUM
 	csrs CSR_STATUS, t6
 
-	/* Save for return value */
-	mv	t5, a2
+	/*
+	 * Save the terminal address which will be used to compute the number
+	 * of bytes copied in case of a fixup exception.
+	 */
+	add	t5, a0, a2
 
 	/*
 	 * Register allocation for code below:
@@ -176,7 +179,7 @@ ENTRY(__asm_copy_from_user)
 10:
 	/* Disable access to user memory */
 	csrc CSR_STATUS, t6
-	mv a0, t5
+	sub a0, t5, a0
 	ret
 ENDPROC(__asm_copy_to_user)
 ENDPROC(__asm_copy_from_user)
@@ -228,7 +231,7 @@ ENTRY(__clear_user)
 11:
 	/* Disable access to user memory */
 	csrc CSR_STATUS, t6
-	mv a0, a1
+	sub a0, a3, a0
 	ret
 ENDPROC(__clear_user)
 EXPORT_SYMBOL(__clear_user)
-- 
2.39.2


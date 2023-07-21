Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 901AC75C070
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 09:53:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230339AbjGUHxE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 03:53:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231270AbjGUHw6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 03:52:58 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6963A113
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 00:52:57 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-3fc0aecf107so13182015e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 00:52:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1689925976; x=1690530776;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QIkLQY6GoloV+JD+TWBkfog1jNXXj5pA5kZEBb1l9EU=;
        b=HQvTIAF9kXtSBDxc6tLNKF2+dn0pwpuDwz+pTMhkOwXmyeOGg8xAiNUhNnrPO8Dq2y
         4qtg31yEtRbWRk6+t72F//zXGUmoPocJIDJpDymiCpDUTYjzYMc/K1KSMusEKX+EzGpb
         Onx08zYI0yjWTkhbJSYI1/+N96bRSjIDVgihEqMphLRp/3zaXJe49Cb655DDzB1mx6uR
         ocZRWbhHUp3HprcZiYWCq4GoJKSaudJX10Sdxpnj7dMYxADg9UgfBBh6hih4mhXR6q0W
         abIx1B634Ijjxw9D+pVa03qX00zOtsDPl5DUspThYTkeCHEHopNM6fECusVvN7QUpQIh
         BCMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689925976; x=1690530776;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QIkLQY6GoloV+JD+TWBkfog1jNXXj5pA5kZEBb1l9EU=;
        b=H85x9S5YmoCbFs5xgMTQ+RGvRrLjDIQzJwfXSgxEF1euugKYJEYPD/S9aaRXtjI2po
         RTO+NNqeGcQRcJiaQRz7+lkAqjqXhT5rtffvWy+97/gVFClpRIxm1cw1uKiS/ffFt++6
         DmfIA5esnoI2gLQQl+Z/bBtRcCJjRxx5RGCzsVF7fhBKB9oNAe+6TS+P6XZFCz5vmMQV
         yeSpTVVHTCXTqnS9ZHL5KXWAt6+FIASSAmvWzpIHbs3NIog6nmQILLHAirYiONELDxcQ
         GStPsqjZ+fbrXBNhqXTcv7dYOEhYTwFtZdajZ0cgYdexCKGPxYAfJjq83Bs0Pzfd4L3s
         ZMWA==
X-Gm-Message-State: ABy/qLboKu0pw12RUvlRfdpNzYcUWzAn2FmZG2/bEcXHzMU6QjLYW2i0
        sTwp2bpBv3NiAzhzeKWfpyIn/A==
X-Google-Smtp-Source: APBJJlG4jUnWsu4FpTlpiZiIgK9Wy8Mxui/x11b/YNZFd0j/KrT9RSHmNXz3WtNSoHHU5vOtTYDJlQ==
X-Received: by 2002:a05:600c:289:b0:3fc:586:ccb4 with SMTP id 9-20020a05600c028900b003fc0586ccb4mr748526wmk.36.1689925975962;
        Fri, 21 Jul 2023 00:52:55 -0700 (PDT)
Received: from alex-rivos.ba.rivosinc.com (amontpellier-656-1-456-62.w92-145.abo.wanadoo.fr. [92.145.124.62])
        by smtp.gmail.com with ESMTPSA id y9-20020a7bcd89000000b003fbb1a9586esm5663454wmj.15.2023.07.21.00.52.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jul 2023 00:52:55 -0700 (PDT)
From:   Alexandre Ghiti <alexghiti@rivosinc.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Ard Biesheuvel <ardb@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-efi@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Alexandre Ghiti <alexghiti@rivosinc.com>
Subject: [PATCH v5 4/5] libstub: Fix compilation warning for rv32
Date:   Fri, 21 Jul 2023 09:48:49 +0200
Message-Id: <20230721074850.310644-5-alexghiti@rivosinc.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230721074850.310644-1-alexghiti@rivosinc.com>
References: <20230721074850.310644-1-alexghiti@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following warning which appears when compiled for rv32 by using
unsigned long type instead of u64.

../drivers/firmware/efi/libstub/efi-stub-helper.c: In function 'efi_kaslr_relocate_kernel':
../drivers/firmware/efi/libstub/efi-stub-helper.c:846:28: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
  846 |                            (u64)_end < EFI_ALLOC_LIMIT) {

Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
---
 drivers/firmware/efi/libstub/kaslr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/efi/libstub/kaslr.c b/drivers/firmware/efi/libstub/kaslr.c
index be0c8ab0982a..afb857329799 100644
--- a/drivers/firmware/efi/libstub/kaslr.c
+++ b/drivers/firmware/efi/libstub/kaslr.c
@@ -130,7 +130,7 @@ efi_status_t efi_kaslr_relocate_kernel(unsigned long *image_addr,
 		if (!check_image_region(*image_addr, kernel_memsize)) {
 			efi_err("FIRMWARE BUG: Image BSS overlaps adjacent EFI memory region\n");
 		} else if (IS_ALIGNED(*image_addr, min_kimg_align) &&
-			   (u64)_end < EFI_ALLOC_LIMIT) {
+			   (unsigned long)_end < EFI_ALLOC_LIMIT) {
 			/*
 			 * Just execute from wherever we were loaded by the
 			 * UEFI PE/COFF loader if the placement is suitable.
-- 
2.39.2


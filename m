Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0224E761B53
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 16:21:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232724AbjGYOVN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 10:21:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232555AbjGYOUw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 10:20:52 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C4E126AF
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 07:19:30 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-3fbea14706eso46825655e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 07:19:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1690294768; x=1690899568;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NuP7PfUWkHmNyDCiiBKijYVB5Ha6vR4zrSGdSILdtOY=;
        b=VobxKKfj3YlLkMovUBsPqivFLT1NQJ6OYhCHAqVTKo9GWx9ePkndLU6RA9fqyBnbX9
         0cEyorheLHBaC3FUSmD55JY9EoBsNwU8YGmrJ6nrSoqx25pRKblUqIhKmr6l4hoxs0Pi
         WpqUv23b/CbIvjtIA9NOhD8EuFNdCi4A+flYzcXovy3RJ4k1usDUx29HqclIi08ouCzR
         a/j6sfz0MvHe+JXGN/kO+kL3mbo2zUkUstTdjll1Jzo5fKn1G0fOR2aRjiddntLh6QhP
         Ga1awsWTGFVzQUVRckzNcjQap5cmvojdYtvXEyDUc6XbjB0MPUPoEMPcZvMOwzChtzNd
         sb7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690294768; x=1690899568;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NuP7PfUWkHmNyDCiiBKijYVB5Ha6vR4zrSGdSILdtOY=;
        b=crj6HaqMz8gfNCovB/Sjyog+INf38WeKEdmxPjWAs1iw9D8BOF3TuT2qXUAI8RNQlt
         rcs4Yj5tApdvw6om3mog+fEUBDUGsBm5oYtcDUqaGu4V1YjcLNnzL9r8d1FvJ3VvSxlk
         GGct6aGlLgJwaqjIYPuPiobXEJYn+A0LQwwiRaeDfftO4TwPCkG2hWHwATtWm2sBNqEl
         GpC4sa0HcKUKnAzxpg4bhEkv131WstmlY0YCDjueLXmG/9JyK9TpMBd8YU+oAbXn2wJB
         1eFf8WUabIX3MpWgqWGx1L74ZDFjdWx3Gm58sPhQOWwTZB9dtZPTS/n7Ff3jtkcpRvEp
         BgjA==
X-Gm-Message-State: ABy/qLYWCaDimQOw750dsEh4O93mJBrqp/31MH01qcH6dkVU9d+B8q48
        bmXD8v9PFAOZDNlubaOznHx2+g==
X-Google-Smtp-Source: APBJJlEfIjpTWK3hKuGbaXC9p3pwmKCgC7ZtILnlK9IbfVHDNYwlUwlSUbRxcXQArkn+Q0EUY/j0KA==
X-Received: by 2002:adf:ed08:0:b0:317:634c:46e9 with SMTP id a8-20020adfed08000000b00317634c46e9mr4183117wro.43.1690294767655;
        Tue, 25 Jul 2023 07:19:27 -0700 (PDT)
Received: from alex-rivos.ba.rivosinc.com (amontpellier-656-1-456-62.w92-145.abo.wanadoo.fr. [92.145.124.62])
        by smtp.gmail.com with ESMTPSA id a17-20020adffad1000000b003143cdc5949sm16619297wrs.9.2023.07.25.07.19.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jul 2023 07:19:27 -0700 (PDT)
From:   Alexandre Ghiti <alexghiti@rivosinc.com>
To:     Jonathan Corbet <corbet@lwn.net>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@rivosinc.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Sunil V L <sunilvl@ventanamicro.com>,
        Song Shuai <songshuaishuai@tinylab.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-doc@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Alexandre Ghiti <alexghiti@rivosinc.com>,
        Atish Patra <atishp@rivosinc.com>
Subject: [PATCH v6 1/3] Documentation: arm: Add bootargs to the table of added DT parameters
Date:   Tue, 25 Jul 2023 16:19:23 +0200
Message-Id: <20230725141926.823153-1-alexghiti@rivosinc.com>
X-Mailer: git-send-email 2.39.2
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

The bootargs node is also added by the EFI stub in the function
update_fdt(), so add it to the table.

Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
Reviewed-by: Atish Patra <atishp@rivosinc.com>
Reviewed-by: Song Shuai <songshuaishuai@tinylab.org>
---

- Changes in v5:
  * Rebase on top of docs-next

 Documentation/arch/arm/uefi.rst | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/arch/arm/uefi.rst b/Documentation/arch/arm/uefi.rst
index baebe688a006..2b7ad9bd7cd2 100644
--- a/Documentation/arch/arm/uefi.rst
+++ b/Documentation/arch/arm/uefi.rst
@@ -50,7 +50,7 @@ The stub populates the FDT /chosen node with (and the kernel scans for) the
 following parameters:
 
 ==========================  ======   ===========================================
-Name                        Size     Description
+Name                        Type     Description
 ==========================  ======   ===========================================
 linux,uefi-system-table     64-bit   Physical address of the UEFI System Table.
 
@@ -67,4 +67,6 @@ linux,uefi-mmap-desc-ver    32-bit   Version of the mmap descriptor format.
 
 kaslr-seed                  64-bit   Entropy used to randomize the kernel image
                                      base address location.
+
+bootargs                    String   Kernel command line
 ==========================  ======   ===========================================
-- 
2.39.2


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19AC17AAC93
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 10:26:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232207AbjIVI0b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 04:26:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232328AbjIVI00 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 04:26:26 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C74E3199;
        Fri, 22 Sep 2023 01:26:19 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id d2e1a72fcca58-690f7bf73ddso1602619b3a.2;
        Fri, 22 Sep 2023 01:26:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695371179; x=1695975979; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8TjkO42V3TjmILslatWiNnLGbuZ1pxt7DnaUwvpRCv4=;
        b=mNi14FsV/wuy7LEBE1bTbgtC/a0Xwmh8B6TJpOoLsM5Q5YcJzkXwo0p7n3rYHihetc
         jpDum5OhSG/CSBcQdw654yjQgtx+pNOCFuc7us1ZmtwsjoK8pvbsKsle0GeNm7b8g2vD
         Kv+g78FcpkBXyV13uFHNTx9ZG/+RzG6wChNMxu1HjBEJ1EO8kfr04wzZpp7SIn3mRXnn
         9IY/0ufEwxWdU23WSuF6mEyV1sXsqsAauOfGgn0fzTraZXewlSWriqw9q9FC0ilzzgkg
         x92KwAvmcdHVrr93Flq/JbGipJ5an7akD/T+j8d21BQXyY9KdypK40BfYOyg2Q5WHiTg
         n65A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695371179; x=1695975979;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8TjkO42V3TjmILslatWiNnLGbuZ1pxt7DnaUwvpRCv4=;
        b=kJcsjMFa8agRIxIUjp/QaqOUxOb2uhYIGZ9atnQTJtO0JIVRiUX6cqZYFpinWe3fYF
         HSkNA48W9m2VO8y9Or+allG9zkBymhb0BqQvEJMbUe/4iLVw438P58KWPifjqMn/AeOh
         49tHfIUZ7NS2yFRyVzgWTPiL8oIegIi0JucLaMKNqcogW+lDwkUlFFbKcsLr2lqqYeXH
         XT2oY7DPQzCIyjkkSphSXbMoXuRWJj9foVZvjWu4Qf396DYvlV7EMqfH8Rf5mnwQTYzE
         xcD5Vrz+rvRT0ozjZmJl9xcJPCEK+6ttnR4Zkx4LZ7DYCbzqi0BrbruPR6iTQtwG88cl
         3S3A==
X-Gm-Message-State: AOJu0YxCyN4CWpcAaO4Gn06UYqipYktIkQ8X092Vp6Tg1SNDEepKGBNH
        8H7vdkw/A6uISYYwbsIPBFY=
X-Google-Smtp-Source: AGHT+IHon40oRfrCjQP3QqxMuV6iApwqDxiFYXRlKv8F08B30xQOAiiGxkWExrzE3RWpMbNQN0EBfQ==
X-Received: by 2002:a05:6a00:cc8:b0:68e:380c:6b15 with SMTP id b8-20020a056a000cc800b0068e380c6b15mr8659120pfv.26.1695371179093;
        Fri, 22 Sep 2023 01:26:19 -0700 (PDT)
Received: from localhost.localdomain ([140.112.90.93])
        by smtp.gmail.com with ESMTPSA id 9-20020aa79209000000b00690d8a119c1sm2643576pfo.206.2023.09.22.01.26.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Sep 2023 01:26:18 -0700 (PDT)
From:   Jianlin Li <ljianlin99@gmail.com>
To:     corbet@lwn.net
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Jianlin Li <ljianlin99@gmail.com>
Subject: [PATCH] docs: x86: Update document url in amd-memory-encryption.rst
Date:   Fri, 22 Sep 2023 16:25:47 +0800
Message-Id: <20230922082547.522689-1-ljianlin99@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The previous link to AMD programmer's manual is no longer available.
Replace it with the new one.

Signed-off-by: Jianlin Li <ljianlin99@gmail.com>
---
 Documentation/arch/x86/amd-memory-encryption.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/arch/x86/amd-memory-encryption.rst b/Documentation/arch/x86/amd-memory-encryption.rst
index 934310ce7258..07caa8fff852 100644
--- a/Documentation/arch/x86/amd-memory-encryption.rst
+++ b/Documentation/arch/x86/amd-memory-encryption.rst
@@ -130,4 +130,4 @@ SNP feature support.
 
 More details in AMD64 APM[1] Vol 2: 15.34.10 SEV_STATUS MSR
 
-[1] https://www.amd.com/system/files/TechDocs/40332.pdf
+[1] https://www.amd.com/content/dam/amd/en/documents/processor-tech-docs/programmer-references/24593.pdf
-- 
2.25.1


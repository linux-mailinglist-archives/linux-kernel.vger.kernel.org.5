Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB9137EE60B
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 18:39:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345319AbjKPRj3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 12:39:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231238AbjKPRj2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 12:39:28 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26242D49
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 09:39:24 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-6b87c1edfd5so969303b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 09:39:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700156363; x=1700761163; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2WCSmneoM9uf6Svz2UcyqIAwpMe+ZMJI369FRUKvVDE=;
        b=jfHPDfuKz2L40UI0PEqWYLKdh1U0IlDY9BLKCbwB11J8vOmHsAZmQ4HF9pNVNZTxVi
         wIBJ9kRWSG9xg+UCymI0SYvj3hhADa0hqjhL/+hKtZLLJ9RwSLFb2sBIIbU7wFU57GtF
         JhETLvyIMKbwduNAc1kMboIacU9gMD/etKuQhdXCoC4WEbJGA46czuwCLVBOfnrQ0wyA
         9YWYPeEnfEHISMgwOtuy+Q0K4/AQ1AUb8U1y7ujw16tZ1FDirIo28M1nWyxduQNoLPJv
         IO9a0O32Ewv9cKzzrCdjavSBFKL4zWHw5z/RrFvNpUE7cdpfnERQJKWKK573T8qdssA9
         n4zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700156363; x=1700761163;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2WCSmneoM9uf6Svz2UcyqIAwpMe+ZMJI369FRUKvVDE=;
        b=Duvtg269xF9RLPCC+zcGg1VGlt9MYSjA4zCNfyAvgA45Su5tcjy4qH0rw37cKyhcys
         7oj0VuWUuwleoaIvowAOUzp2sFI9S3QrAOpuMLKbFuYNQmaa57w7NlT6H5ielcRVpPDN
         Vt04ZaEr8Ztc+J+oUF6PS4hp1fEOdIv6jApmOpp+rrPKcpwPMq27ypvfdQ5iphT2wRbL
         IQrCDFGwC3eYqCVo5NmcMhqVNEVa7IZKkcOaQ1v1iTdt+f9o1oSZPK2ljBWcm2aAaXrw
         9nHmJVRRro7V6XMgIwScA2SzxN5hr0sc9wI5iUjEk4g6VbbESZyIs8awKr/7xmS5lZSR
         vGHw==
X-Gm-Message-State: AOJu0YyuY4vVra8sJyJF1NGVMEGSsNmMRuvP1Ly2nJnIbj3gp+xPhJxJ
        VV8K65eIcefru2kEo3JFZHU2FI50yGJbAIY7
X-Google-Smtp-Source: AGHT+IGsuwqrPu4gt/9ZfkKsVzUzm8IovzzP7UFPMz2gzEPyElxZczZC/ujwlOg6zLaEDdzZiRFfhg==
X-Received: by 2002:a05:6a20:42a4:b0:174:2361:b4a3 with SMTP id o36-20020a056a2042a400b001742361b4a3mr15814090pzj.59.1700156363220;
        Thu, 16 Nov 2023 09:39:23 -0800 (PST)
Received: from ubuntu.. ([110.44.116.44])
        by smtp.gmail.com with ESMTPSA id e22-20020a62aa16000000b0068fd026b496sm4794566pff.46.2023.11.16.09.39.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Nov 2023 09:39:22 -0800 (PST)
From:   Dipendra Khadka <kdipendra88@gmail.com>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com
Cc:     Dipendra Khadka <kdipendra88@gmail.com>, mjguzik@gmail.com,
        ira.weiny@intel.com, linux-kernel@vger.kernel.org
Subject: [PATCH] x86: Fixes warning: cast removes address space '__user' of expression in uaccess_64.h
Date:   Thu, 16 Nov 2023 17:38:48 +0000
Message-Id: <20231116173849.210205-1-kdipendra88@gmail.com>
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

Sparse has identified a warning as follows:

./arch/x86/include/asm/uaccess_64.h:88:24: warning: cast removes address space '__user' of expression.

Since the valid_user_address(x) macro implicitly casts the argument
to long and compares the converted value of x to zero, casting ptr
to unsigned long has no functional impact and does not trigger a 
Sparse warning either.

Signed-off-by: Dipendra Khadka <kdipendra88@gmail.com>
---
 arch/x86/include/asm/uaccess_64.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/uaccess_64.h b/arch/x86/include/asm/uaccess_64.h
index f2c02e4469cc..da24d807e101 100644
--- a/arch/x86/include/asm/uaccess_64.h
+++ b/arch/x86/include/asm/uaccess_64.h
@@ -85,7 +85,7 @@ static inline unsigned long __untagged_addr_remote(struct mm_struct *mm,
 static inline bool __access_ok(const void __user *ptr, unsigned long size)
 {
 	if (__builtin_constant_p(size <= PAGE_SIZE) && size <= PAGE_SIZE) {
-		return valid_user_address(ptr);
+		return valid_user_address((unsigned long)ptr);
 	} else {
 		unsigned long sum = size + (unsigned long)ptr;
 		return valid_user_address(sum) && sum >= (unsigned long)ptr;
-- 
2.34.1


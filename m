Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C1617F65E9
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 19:03:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231176AbjKWSD0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 13:03:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231400AbjKWSDU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 13:03:20 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0326C170E
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 10:03:18 -0800 (PST)
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com [209.85.208.197])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 0B4F0420C2
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 18:03:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1700762589;
        bh=Rm0AYGktCFDwiZQ3qlgqUctwWO5n1BUkIpQTDe2RZHA=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=Ar41MqkZdDfnVnP0i1hKvpuuBVR+OvcBpG4lF65J6ExgiQaNOtCFNUyFyHLSxDOXU
         x6XfiG8eVtmGwwfrnn6hjhWHMuPDUeuPXRoAhgVVpPTn02IGtWEDjz7oyDWtVYKc4x
         JTXTvd3IZm/fxSNQNH+RyMrlZeh2cCmMcPsIR7bbG+kTgpw+5SMafP8BbVEEvou2le
         x3EVnmc7b+AVqAwy+NvD6qat5G8DARJL2espUsSOwKQbY+8e6utC97gsxQVIq0WEbQ
         eqjdd2Lsh/sl8Tx014QfuDiSdZtx6afWJfcrHC44Zkf/6Mb+f/9RGIMsfglI/lqupO
         3eXi6BHegKOIQ==
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-2c87972a358so8992881fa.2
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 10:03:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700762585; x=1701367385;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Rm0AYGktCFDwiZQ3qlgqUctwWO5n1BUkIpQTDe2RZHA=;
        b=DQpO0dXC31vQ0jJgA8HLuy8Mr0H7HtOuZHls+KnInNAjKe90KgxOaDTZ0fkcz0G0Ac
         SG7bkFV94guunToiWXMMkJWEmW8B8Ex/vfzO0Uo+GZf0B/sAqsUMZQ8s6m3yopgwgmHC
         rgUtwwC2AHNTSt992XUAptDANT2hb1JuWkb2EavtrFSJS7ZjvynlEspMJZqBGyR5r9g2
         dcVvUn4j8Nnpk92zdkW8KaA3DRMaZLRP297eIMji0GSxbGEm3x2Oj9xmPpp6/ycpURAQ
         MwjUd9dS6cmWuU8KYMc+yzFEAIrr54TilPkQnPohDeucVYgFWve8k432jjoPC93/0l/8
         CmWw==
X-Gm-Message-State: AOJu0YzaZX2iisAIsP936IvgMGUKDDrw4RrGJVBE8bSYjiwxdEwZbfc2
        f5c2YZVldiqHfy/Ls8sARgw368UCZDkpRnf8qcR6C12tINH3VTx9rhQiw0P15pjjm8+850f+Xxc
        ZMi7ovRZnwNnpUvvjYzCEE3fkTy9d0LhDWVjC37Ucgg==
X-Received: by 2002:a2e:8ec4:0:b0:2c5:380:2a10 with SMTP id e4-20020a2e8ec4000000b002c503802a10mr75204ljl.25.1700762585148;
        Thu, 23 Nov 2023 10:03:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHesVBUJYAMuhXm2aJM3OcIgDBJBWLRSC2IvYeJ+0Iszdqg6ZuVQphYDAKfGHjKuvTwytv/NQ==
X-Received: by 2002:a2e:8ec4:0:b0:2c5:380:2a10 with SMTP id e4-20020a2e8ec4000000b002c503802a10mr75189ljl.25.1700762584814;
        Thu, 23 Nov 2023 10:03:04 -0800 (PST)
Received: from localhost ([2001:67c:1560:8007::aac:c15c])
        by smtp.gmail.com with ESMTPSA id bg9-20020a05600c3c8900b0040836519dd9sm2700868wmb.25.2023.11.23.10.03.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Nov 2023 10:03:03 -0800 (PST)
From:   Dimitri John Ledkov <dimitri.ledkov@canonical.com>
To:     Richard Henderson <richard.henderson@linaro.org>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H . Peter Anvin" <hpa@zytor.com>
Cc:     linux-alpha@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        x86@kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/5] m68k: stop shipping a.out.h uapi headers
Date:   Thu, 23 Nov 2023 18:02:43 +0000
Message-Id: <20231123180246.750674-4-dimitri.ledkov@canonical.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231123180246.750674-1-dimitri.ledkov@canonical.com>
References: <20231123180246.750674-1-dimitri.ledkov@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Stop shipping a.out.h uapi headers, unused.

Signed-off-by: Dimitri John Ledkov <dimitri.ledkov@canonical.com>
---
 arch/m68k/include/uapi/asm/a.out.h | 21 ---------------------
 1 file changed, 21 deletions(-)
 delete mode 100644 arch/m68k/include/uapi/asm/a.out.h

diff --git a/arch/m68k/include/uapi/asm/a.out.h b/arch/m68k/include/uapi/asm/a.out.h
deleted file mode 100644
index 3eb24fd8b8..0000000000
--- a/arch/m68k/include/uapi/asm/a.out.h
+++ /dev/null
@@ -1,21 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
-#ifndef __M68K_A_OUT_H__
-#define __M68K_A_OUT_H__
-
-struct exec
-{
-  unsigned long a_info;		/* Use macros N_MAGIC, etc for access */
-  unsigned a_text;		/* length of text, in bytes */
-  unsigned a_data;		/* length of data, in bytes */
-  unsigned a_bss;		/* length of uninitialized data area for file, in bytes */
-  unsigned a_syms;		/* length of symbol table data in file, in bytes */
-  unsigned a_entry;		/* start address */
-  unsigned a_trsize;		/* length of relocation info for text, in bytes */
-  unsigned a_drsize;		/* length of relocation info for data, in bytes */
-};
-
-#define N_TRSIZE(a)	((a).a_trsize)
-#define N_DRSIZE(a)	((a).a_drsize)
-#define N_SYMSIZE(a)	((a).a_syms)
-
-#endif /* __M68K_A_OUT_H__ */
-- 
2.34.1


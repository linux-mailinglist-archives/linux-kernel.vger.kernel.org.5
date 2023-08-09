Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 017357754DF
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 10:14:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231892AbjHIIOL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 04:14:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231879AbjHIIOH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 04:14:07 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4B4E10F6
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 01:14:06 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-4fe28e4671dso10587850e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 09 Aug 2023 01:14:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691568845; x=1692173645;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zTXAtK4LyKDOWesDbd7G0no9IFm0HYr1YL9cGl87EzQ=;
        b=AaZNvaOLHpTrWuNHOIAzKFkJD8Yhj84hT19T1S7uT/t4tAzdb7OJkojkl/IfOZM0ZT
         9OINRO5D+ZqlDOHj1/yMIimjGzifYxI4yS9+jjO4Xn+E6Vya6HLMzKt3k76Dg/VjFSMI
         PvMctNeBYwj67QOe5HCfNpg6SS6/OFsOV5WrJIYEy4YlQhsGyTgb2yhcsak2KrWHzLtr
         KVOcpMyQfhALHBin9A/U1b/I5aJw2ovXVaIN6hjIeRn7l1HHNMV3eZ9i7JiLNF6zYT9v
         O1a1qb9IK2i/+JXmfbv24ygVsmeoyP4XXvc1d+Q636+IwmVApXCHvdX5yKKaco2Q556t
         ONfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691568845; x=1692173645;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zTXAtK4LyKDOWesDbd7G0no9IFm0HYr1YL9cGl87EzQ=;
        b=fsbEPf/FEfyZ5rgwEEsOgtjdGuCTOpvlc9YXESYRgdW1q4NCFH3Lso0FN9hOYhiTzV
         iIUQw68fGfMRWr0ytevO87Ts2ldyLgu1XMgz9Io3+hEXii1aL/55cWQTIy2qrajjO0JO
         WaU7Yl1AtdKLBRJGhmIqGEvPh+Zomd07y6TO0C7M3RSLLY+NU6UpaCJRVuCZpyhOKGNN
         lGv/y+hSYGa8v7zxS2xq6ZaNSbw/FEqWNTyVQnDDodr9nebuWLtcOj1Jbv+BD0Fo264/
         xsgZ79VnX7BuH/EJoHYEh85kOv+IEcu+b+PXesezF13gCqnrHMXsHcKPfAiw+RIp19Sk
         4kLg==
X-Gm-Message-State: AOJu0YwWrGRD/FhbdY6meIJFldscMrMmp7HwWevJ+Qy0bCWLJW/fcKvZ
        mEst20ivNIuKac15nyFRxd/ZhA==
X-Google-Smtp-Source: AGHT+IEo8krRs8F/gpp8zmi1UGtwXUgDYy/Wh4w3IdCIabujY5wZOYPZK6TC/S1L29E7S+3sft7jKA==
X-Received: by 2002:a05:6512:2507:b0:4f8:770f:1b08 with SMTP id be7-20020a056512250700b004f8770f1b08mr1528563lfb.13.1691568844988;
        Wed, 09 Aug 2023 01:14:04 -0700 (PDT)
Received: from [127.0.1.1] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id w12-20020ac25d4c000000b004f84a92ba75sm2196916lfd.65.2023.08.09.01.14.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Aug 2023 01:14:04 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 09 Aug 2023 10:14:02 +0200
Subject: [PATCH v2 2/2] csky: Make pfn accessors static inlines
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230809-csky-virt-to-phys-v2-2-2697c93f60cf@linaro.org>
References: <20230809-csky-virt-to-phys-v2-0-2697c93f60cf@linaro.org>
In-Reply-To: <20230809-csky-virt-to-phys-v2-0-2697c93f60cf@linaro.org>
To:     Vineet Gupta <vgupta@kernel.org>, Guo Ren <guoren@kernel.org>
Cc:     linux-snps-arc@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-csky@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Making virt_to_pfn() a static inline taking a strongly typed
(const void *) makes the contract of a passing a pointer of that
type to the function explicit and exposes any misuse of the
macro virt_to_pfn() acting polymorphic and accepting many types
such as (void *), (unitptr_t) or (unsigned long) as arguments
without warnings.

For symmetry to the same thing with pfn_to_virt().

In order to do this we move the virt_to_phys() and
phys_to_virt() below the definitions of the __pa()
and __va() macros so it compiles. The macro version was also
able to do recursive symbol resolution.

Acked-by: Guo Ren <guoren@kernel.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/csky/include/asm/page.h | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/arch/csky/include/asm/page.h b/arch/csky/include/asm/page.h
index b23e3006a9e0..57b3f106ae77 100644
--- a/arch/csky/include/asm/page.h
+++ b/arch/csky/include/asm/page.h
@@ -34,9 +34,6 @@
 
 #include <linux/pfn.h>
 
-#define virt_to_pfn(kaddr)      (__pa(kaddr) >> PAGE_SHIFT)
-#define pfn_to_virt(pfn)        __va((pfn) << PAGE_SHIFT)
-
 #define virt_addr_valid(kaddr)  ((void *)(kaddr) >= (void *)PAGE_OFFSET && \
 			(void *)(kaddr) < high_memory)
 
@@ -80,6 +77,16 @@ extern unsigned long va_pa_offset;
 
 #define __pa_symbol(x)	__pa(RELOC_HIDE((unsigned long)(x), 0))
 
+static inline unsigned long virt_to_pfn(const void *kaddr)
+{
+	return __pa(kaddr) >> PAGE_SHIFT;
+}
+
+static inline const void * pfn_to_virt(unsigned long pfn)
+{
+	return (const void *)((unsigned long)__va(pfn) << PAGE_SHIFT);
+}
+
 #define MAP_NR(x)	PFN_DOWN((unsigned long)(x) - PAGE_OFFSET - \
 				 PHYS_OFFSET_OFFSET)
 #define virt_to_page(x)	(mem_map + MAP_NR(x))

-- 
2.34.1


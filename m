Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF2BD773F73
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 18:47:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230488AbjHHQrw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 12:47:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230512AbjHHQqi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 12:46:38 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58514170F8
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 08:56:40 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-523100882f2so7029207a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 08 Aug 2023 08:56:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691510170; x=1692114970;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bRPNurCVUK+kZN7q7E8TsOpZ2X9nLclQ5Lcqn45M43Y=;
        b=D3+x+5n0GK3u4IvyihWkyCDxlrk5NlbF30zhFFSecLGrMNk+OEE3v4EwF9AfA1eH28
         aWko4PAPAhq3crmSkM4DS9FaQXVn59L/RJ2o0WbCUeXbJQD80e542cRGjBKeThWKzDp5
         RzdGlI0QNdni3iyzCyR0dA+N850UqCvO3wH+CivA8vWzB1Ad4ShikNMWhkDhNImk++2a
         aVGQd/lEfDlS+G0RSjnqQ3RrtwWiUX4852zTl99SWCCAvI9tdzFZa1hDYkViTWMTbPLr
         FYbgStzldNz+GSaLyS37jAl3hfVSMLJzdvkC2z/k/Pqe/VgW1WLWi/GHMm76YEA2c5pt
         mSSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691510170; x=1692114970;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bRPNurCVUK+kZN7q7E8TsOpZ2X9nLclQ5Lcqn45M43Y=;
        b=ilAITqXFVU4dSf0PSK1SNapD2fDIq/3i4tztPNrBX1c7GgqX7xGEBdX93gNbH44FZD
         wpyux/k48xJAco5Tqz0HBeYDW8FZ4q77iY7IdocU+uPQ9j010dwO9TxOIGCjEdbyKI7l
         9BQpyJHUwElrAAwFHijrJ9/vIh+x7H2RTaE6W+ogkXLEAvImMZgL6pAm3Co9sWQk0Hj2
         p05eU0LhshPEgBEFvDTzpEEhf3kgNoW8ZC93Ot7DEQEKsAxz/I5iYDe32hR+cAEtpMid
         gO+KvYYwf4kv0A/Kg9FPJANDAGqLUc3WT+Ml7K0QQbheanwoWW33N/If1cFzbs+BKhtV
         iajQ==
X-Gm-Message-State: AOJu0Yz2L8MjDq9O5urZPyEMNNSKjgdp7Hwms6rYDjT5RNMIUklqaDcZ
        BN+84SBwotEH56j+tJMrDai7JSbTlmZBZ3rFtTk=
X-Google-Smtp-Source: AGHT+IFcKitgCUMDjTXmYFgGTjati7nhjKf1RmPJEXoKcYA78VEzCeeOhe2OLLR3Pt79LBJFdpGryg==
X-Received: by 2002:a05:6512:358b:b0:4fd:d4b4:faba with SMTP id m11-20020a056512358b00b004fdd4b4fabamr7004297lfr.51.1691483164349;
        Tue, 08 Aug 2023 01:26:04 -0700 (PDT)
Received: from [127.0.1.1] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id t13-20020a19ad0d000000b004fbae18984dsm1787087lfc.255.2023.08.08.01.26.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Aug 2023 01:26:03 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 08 Aug 2023 10:25:56 +0200
Subject: [PATCH 2/2] csky: Make pfn accessors static inlines
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230808-csky-virt-to-phys-v1-2-ac727f8def2f@linaro.org>
References: <20230808-csky-virt-to-phys-v1-0-ac727f8def2f@linaro.org>
In-Reply-To: <20230808-csky-virt-to-phys-v1-0-ac727f8def2f@linaro.org>
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

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/csky/include/asm/page.h | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/arch/csky/include/asm/page.h b/arch/csky/include/asm/page.h
index b23e3006a9e0..80da7e96a8fa 100644
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
+static inline void * pfn_to_virt(unsigned long pfn)
+{
+	return __va(pfn) << PAGE_SHIFT;
+}
+
 #define MAP_NR(x)	PFN_DOWN((unsigned long)(x) - PAGE_OFFSET - \
 				 PHYS_OFFSET_OFFSET)
 #define virt_to_page(x)	(mem_map + MAP_NR(x))

-- 
2.34.1


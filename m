Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37A6B782460
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 09:21:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233693AbjHUHVn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 03:21:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232856AbjHUHVj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 03:21:39 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF360A9;
        Mon, 21 Aug 2023 00:21:13 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-3fbd33a57b6so28459195e9.2;
        Mon, 21 Aug 2023 00:21:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692602457; x=1693207257;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QC1pRvrNyLiVD1h/D+teZ8aHEzmdmZeRSHjacOPpsZw=;
        b=fmNwq+0FqFp0bR8U9XknpCheXzMgN8PgS44eXJJGvUyrfLMwFEJS8usQCoyfFtWlJs
         xutrUM+6oszrKdJmSXF9YxyKt3Yv83+NoQWIcZNsLA4Y2XePfQ6j+wS4occ+s2nRklZF
         uiwDxzIXbi4g+J7K8WKEdbrpfF/CYqHO3Kp3hK5IV38j/TlwWZqytsWCKjfD9+zUewUi
         RmluAP/m+8wHfjVfhR1hR3ns7NElB2FHK1/9lrMSppVZ6dbiFCJSf+0FD+1Yqx8fl/je
         3c4tou46nfwjDMYNta87SZtPdZziq6zZ36D+BW/GcAFv+L+vfscidraZn40ylVItkguB
         ODsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692602457; x=1693207257;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QC1pRvrNyLiVD1h/D+teZ8aHEzmdmZeRSHjacOPpsZw=;
        b=SFGo4TIRuEIZUXtYrUPOFhHvjNZj+2Ix5K9SljBvlqQXyuyEKGMazh3Z4m+8CAc/B3
         xvVOfCl4Y79pKKlQu0E7rtTbm/Dm2yT8fkJEURvnalpISrv5K5gpcMU4Ez8EmKHaBCbb
         LCftQldQJfkig7/8vnehJ2yBARbpXxuFZlNULSp7ybL65XKEUcexyTbUN2pnYcVjDCwu
         AfqPly6T17o/k/rt/JXbjE7fygNnSRplb8nKmJ1TZPFWjUtp8ycaaL3/BlbH9CKdt0Y0
         jaf98oTW9HbgOha6Tb4V8DhENudmbTeY/nTPKdyBiE/WhOwskcHrEAh0CK/Gh+bTq5ZZ
         1t6g==
X-Gm-Message-State: AOJu0Yy49bxT81l7UGhbWyi+kreGJcOrcqedZm0le65xvPjYjD/3s8+k
        ZltiuzsqE1N+LlmkQcsKKQ/YnqYQwj0=
X-Google-Smtp-Source: AGHT+IFW1+UpsEH8D3c6eUX7uDf76KpVXePxuZiPPzZaNyfB2F2z7xVYUzY3rsO7j0GfeFF1IDD7Ng==
X-Received: by 2002:a05:600c:364a:b0:3fe:d70f:b0a2 with SMTP id y10-20020a05600c364a00b003fed70fb0a2mr4863614wmq.6.1692602457408;
        Mon, 21 Aug 2023 00:20:57 -0700 (PDT)
Received: from localhost (cpc1-brnt4-2-0-cust862.4-2.cable.virginm.net. [86.9.131.95])
        by smtp.gmail.com with ESMTPSA id l3-20020a1ced03000000b003fe1a96845bsm15153571wmh.2.2023.08.21.00.20.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Aug 2023 00:20:57 -0700 (PDT)
From:   Stafford Horne <shorne@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Stafford Horne <shorne@gmail.com>, Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        linux-openrisc@vger.kernel.org
Subject: [PATCH 8/8] openrisc: Remove kernel-doc marker from ioremap comment
Date:   Mon, 21 Aug 2023 08:20:07 +0100
Message-Id: <20230821072007.2698186-9-shorne@gmail.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230821072007.2698186-1-shorne@gmail.com>
References: <20230821072007.2698186-1-shorne@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace the kernel-doc marker (/**) with a regular comment to fix the
warning:

  arch/openrisc/mm/ioremap.c:108: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst

Signed-off-by: Stafford Horne <shorne@gmail.com>
---
 arch/openrisc/mm/ioremap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/openrisc/mm/ioremap.c b/arch/openrisc/mm/ioremap.c
index 8ec0dafecf25..c6717f876c1c 100644
--- a/arch/openrisc/mm/ioremap.c
+++ b/arch/openrisc/mm/ioremap.c
@@ -104,7 +104,7 @@ void iounmap(volatile void __iomem *addr)
 }
 EXPORT_SYMBOL(iounmap);
 
-/**
+/*
  * OK, this one's a bit tricky... ioremap can get called before memory is
  * initialized (early serial console does this) and will want to alloc a page
  * for its mapping.  No userspace pages will ever get allocated before memory
-- 
2.39.1


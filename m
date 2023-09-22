Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95BDC7AB81E
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 19:50:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233077AbjIVRue (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 13:50:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233500AbjIVRuU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 13:50:20 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B73A6CC9
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 10:50:08 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1c59c40b840so23142665ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 10:50:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1695405008; x=1696009808; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KgYTKXR/I1FPvObxorvJSFTW8JIzpStmNm7nH5Non2I=;
        b=VOonxcK75+nzXNe8OkKAoH3Qwlb23335pR/QCmMdP7cCQer2LB4e/E2t+ixUXlWneL
         ragX7EEMg6g4gXJABvVYGUM1NRUplb7/J3vEFXYl7CBzrOAWp8BEF8Yq+kZU6IRU/I7/
         1rDhzoXSAJMdv3UAIn/Bx5EBWr0g1xJ59fyOk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695405008; x=1696009808;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KgYTKXR/I1FPvObxorvJSFTW8JIzpStmNm7nH5Non2I=;
        b=QWJ6j47FOMQxA+i5rymPQ9H+Q0eH07l/vScW/lZX9oSOgJk+DV3nFhDzKEW9ydo5fB
         p86+VuSv3bTNcPzskwcDSkNCM4QybZyAoZ8NRBr9uJVlX7cFzM3KHQWag/hKuahKEaa3
         iz660wA6Kt6a2jTCwZ9us6zVOcH/BKDt6IxtrqquD2AGLg7pL/HRgylGo/oMIXqyi+dq
         7bQBe/oTMal3wHAGbpFMXI0eRTtzRm2xTBXRzjwiL0bsCpjw8Wyxhg260VwCIVfpJ1GA
         sLVFuDDMvreFdDlm2EPGN3GUaL2BqZAyqlPO/VwzZDX3mQz+LF+aB+8ArYxsYPG9FK52
         /R/Q==
X-Gm-Message-State: AOJu0YyCmWVFCqFL+Oi4NM2ZbnAhdeG8fCwX8donWOl8Aclg0CHljiM1
        HWScrYyQqT94S4IeJFVLYoj8gA==
X-Google-Smtp-Source: AGHT+IFoNtsi25M+QrWUhiPSf6zW6D/xwoc6OJ3HOy2c3JyRBK7yqttvE9WeRwOY/cIOvf6x0iTR+Q==
X-Received: by 2002:a17:902:f551:b0:1c3:3b5c:1fbf with SMTP id h17-20020a170902f55100b001c33b5c1fbfmr216816plf.10.1695405008186;
        Fri, 22 Sep 2023 10:50:08 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id p7-20020a170902e74700b001bf6ea340b3sm3777501plf.116.2023.09.22.10.50.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Sep 2023 10:50:07 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, linux-hardening@vger.kernel.org
Subject: [PATCH] pinctrl: uniphier: Annotate struct uniphier_pinctrl_reg_region with __counted_by
Date:   Fri, 22 Sep 2023 10:50:06 -0700
Message-Id: <20230922175006.work.421-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1374; i=keescook@chromium.org;
 h=from:subject:message-id; bh=Tm7WSbhCUuk32XvIW7v3CIW2EM0z50wK155ChWrac9c=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlDdPOjizzHR2Fjm5ECZPVLRxlOXXgda6lwE7va
 Ga/RNMhW1yJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZQ3TzgAKCRCJcvTf3G3A
 JhnID/9BsoGqvMvrhL7fUCSef2KOrN+0LY8Y9Gh+WefjyMcP4C22g4sclGpsrxAQkqk8krUt+5w
 c7zIvVimPqMsIxiBaJWr1OqtIB0pDqA7Jb9lW7lh9N68utQ2cB2YXUYQmvUM4N6MgXplPdH42V8
 y1MjcClXYSpmWA19UsRuXCGUG9dxZ4OdFC0yxoUW6D5nN3u4hL+hsWlwH50C4TBF0TEt2WWkNJ3
 rBbr/WxM67dRdxxurhQZjdL1O1fFBezTz2PbpZJTg4BL1pRSwu/3zexiLxHjIi9mAugGtkzBWSb
 ueMncH+Gb06R2+p3vmMrWonH4OPujnK4xFzBcOfrfn4dEUF9UZBjHM7NE/I/KRR2VcYvr7n+LpB
 YZJDrvy+6inR3Am6Ib+dY8Vwo//eb/uPXD0KXtGAwA0H3098tSkdl3eDQxDR3/g+Ih66IWvwkrP
 GqJRkE8sF3Nxzk9eBkl3C2myQjSsEuodvl45xOyqOUPpqF5sZNeJfu9dSMTgV7izNogHL8n2OgE
 JLb5a0Akkl9jAqBRGsKQPxNFYEu1Pi+bMfCc0fiWj7xTMCrMPFQMrlOb+tH9RaYnX4eHZC3gfdj
 O/tYjcDU6tm2Ak81vIxZ9R+zc/Y45CD0xr09bAu8gjOGQfLMYC5IYhCqGT3fzqOCd4wI4BFWpGn
 nW5lHw/ 91efgg9g==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Prepare for the coming implementation by GCC and Clang of the __counted_by
attribute. Flexible array members annotated with __counted_by can have
their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS
(for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
functions).

As found with Coccinelle[1], add __counted_by for struct uniphier_pinctrl_reg_region.

[1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci

Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: linux-gpio@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/pinctrl/uniphier/pinctrl-uniphier-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/uniphier/pinctrl-uniphier-core.c b/drivers/pinctrl/uniphier/pinctrl-uniphier-core.c
index 18d3a4f69e63..fbd0fcdb42c8 100644
--- a/drivers/pinctrl/uniphier/pinctrl-uniphier-core.c
+++ b/drivers/pinctrl/uniphier/pinctrl-uniphier-core.c
@@ -31,7 +31,7 @@ struct uniphier_pinctrl_reg_region {
 	struct list_head node;
 	unsigned int base;
 	unsigned int nregs;
-	u32 vals[];
+	u32 vals[] __counted_by(nregs);
 };
 
 struct uniphier_pinctrl_priv {
-- 
2.34.1


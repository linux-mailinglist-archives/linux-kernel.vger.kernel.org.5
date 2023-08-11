Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 586FB778748
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 08:05:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232663AbjHKGFx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 02:05:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229992AbjHKGFw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 02:05:52 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 614B9270F
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 23:05:52 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id 5614622812f47-3a78a29bca3so1377629b6e.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 23:05:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1691733951; x=1692338751;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=E/+lBClPndqGoiitD3Opw+ILBbpFxp3xNzPARhwp7y4=;
        b=aNoomnlcJZQhDUc4CoSqPPpkLjO5yDHnddYPjfDXHwKtGWUujpAk/hqbIa1UjBvO7n
         hnaxR3ByDl0U5K7MkO0LbrJzwczrdfCZ9hOYgSzYSLDuIPL6hDBWXqQjRSTHQKvbQMF1
         glxrGY036r+b8oWDrtzs4dalz9dsLoQ4rm7yU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691733951; x=1692338751;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E/+lBClPndqGoiitD3Opw+ILBbpFxp3xNzPARhwp7y4=;
        b=NeAR9oeuU2BfoR62zvR76vx5o8y6+A0ZBYiiIAVfz2jJDn5DVEds6YOO0OGqOtc/O+
         VnOFNHFLsjkg60WNGg3WnhVcp1D14Opp55NCE6F8n7n2hs5TT2rnAPToFQlQPvhb+q3R
         WWAyFDwHdc6Df27fqH+vFOM3T2VODqvrcMGW073DMTpnEp599aIHK17GLTX21Vp7We2h
         KySIVgC0syzmexlqFL3UMYgVTQ35brniaCBzwsXktJ0625F8vA+wQR8XUstT6ZgAh9WN
         VKlF67/Nr+9JKD0t83uZV8T0wwhcq0MRn5R1JrKYKPUhvT/0Dnwnu3De9jM2a+A2vnn6
         4TDg==
X-Gm-Message-State: AOJu0YxT+5kbXPH/97AD9oa7D/e9LmZAFbwAlkXKgoZLD4AOsxzTgHpB
        b9nHQXbGByOLh/T6jRjGQgTGgefQhIGYUw5llzQ=
X-Google-Smtp-Source: AGHT+IFe1I+Che/PlHxuUiTQoj+Iq8npyTZIcrhKMiNJXkOo7FYJ2hWe50wFm7az1tFP7WW6BcDjkg==
X-Received: by 2002:a54:4192:0:b0:3a1:e5b1:f915 with SMTP id 18-20020a544192000000b003a1e5b1f915mr1093589oiy.55.1691733951693;
        Thu, 10 Aug 2023 23:05:51 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id s82-20020a632c55000000b005579f12a238sm2548794pgs.86.2023.08.10.23.05.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 23:05:51 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     linux-hardening@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] gcc-plugins: Rename last_stmt() for GCC 14+
Date:   Thu, 10 Aug 2023 23:05:49 -0700
Message-Id: <20230811060545.never.564-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=746; i=keescook@chromium.org;
 h=from:subject:message-id; bh=8AaF7U4OBYvk4miZLHfIWW2jfVJVQ12iOH7qSgZtno4=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBk1c+8hUNWDnUnX1OxcoKDqd2k/sQcGoENQHll1
 9OkpaBwTH6JAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZNXPvAAKCRCJcvTf3G3A
 JqEkEAClG1uhinHy4kCqcqB7+ILmn5Vl7LJcvPUn6PWokfY3tayGSdu81p4TWz7vwl9mQtX1Sae
 e/9sR+lbdp+bPqEBuiSZpdyw4iqu1GeCCGnqAXYhaUuKnSFtruHuxBSbbtd6PJIT7+7P8808ysv
 fBNuWSv/+yDoIp0Syy0oxJgAzrIuIZ4NGmaA6ir5WF3AH6za+nNw/2vmCOvX0bi/G+fG0avH4xx
 jovXiDIacuEHfoz6fWBDJnyX5WGZt7zUO5MBU2Ul8aqDy22kGvTfsQl9p+w9MduDKCeKMkU8vnD
 TGaR72rtSATmazgBcvvob+QoqT8q6ex6HcWfV5b+zBHQSGoIJbxwiDIWhD7fgBCFbrQgxiOOncG
 1CYzVeXAfB4bh4KEnyErgjqwI+sUAAFGTr20KgTVjWDSQwPCLq7Vh5fO0Ur8V5eL1AKrrhq2ruA
 kvfJ5c0/sF4JA/BU2bpakdbTDxeGgvi0EuwNCAfdevSPphQ7jpuk00820aQvxgqSUFPCocdN92v
 EOdNxlfpRkaXayHULbeOtOVMdxgRGdj+3/l2D5kr7bavoZoYyqf8w8RMb0nD7oxu/EZE9pezlQI
 yozKkBZ2hWcHHVwSoWHMwCSEKfDpW3AV6tXZD7vqZ8XZW/5c2UTplMQGR42cd/jWQkU1fXM1s1y
 iLaT9QIH 7rRSnxw==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In GCC 14, last_stmt() was renamed to last_nondebug_stmt(). Add a helper
macro to handle the renaming.

Cc: linux-hardening@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 scripts/gcc-plugins/gcc-common.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/scripts/gcc-plugins/gcc-common.h b/scripts/gcc-plugins/gcc-common.h
index 84c730da36dd..1ae39b9f4a95 100644
--- a/scripts/gcc-plugins/gcc-common.h
+++ b/scripts/gcc-plugins/gcc-common.h
@@ -440,4 +440,8 @@ static inline void debug_gimple_stmt(const_gimple s)
 #define SET_DECL_MODE(decl, mode)	DECL_MODE(decl) = (mode)
 #endif
 
+#if BUILDING_GCC_VERSION >= 14000
+#define last_stmt(x)			last_nondebug_stmt(x)
+#endif
+
 #endif
-- 
2.34.1


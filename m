Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79D237AB8D0
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 20:05:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233527AbjIVSF2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 14:05:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233668AbjIVSFN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 14:05:13 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4691DCEC
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 10:53:47 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id 41be03b00d2f7-54290603887so1793461a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 10:53:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1695405226; x=1696010026; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1gNurJf9bPkrNjjS2vpGJrBtEB1rQaAhnj6nnffgxoc=;
        b=X6Lz4eU+fdKxMZXEt1DftyodRwA4l78iTPGn+owfPPgGy8PFhvvBt7+DgzBY0VbPba
         iYMlV3ShSaS8orQgKKs1hCRfgoOWo8sTr50ZrRACPSwi9YYAgPKEDpTI8yDSLNpZwmr7
         oh/dgME+yyoe+E4rr5UKw6MSh6fKYz7Y6XdhU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695405226; x=1696010026;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1gNurJf9bPkrNjjS2vpGJrBtEB1rQaAhnj6nnffgxoc=;
        b=XcrKGCPRXAkXRIqoX6wNcZEJJU6TkUTrFhYRckshjNAO/CSuuLxFWlBqyu7UebqWPY
         jO6Z/BAK4GadkF1BmCMULKt0Zl7XTCSuPpakJ9DAbRcU47WIfVAREfrhO7lYH1MQwyzb
         yuPF/ge90LxkRLh3h2aSw54HdeOVWvVxwiFNVijRlnfDJqco3xHrohLiBSMHrtjITrBR
         Zpoi5zMZ3htdTdBsWhqREKZT+JGR+dHxpy8uP7O0EGNdTo/c0MTiyAssgbrLku7CAtmm
         R8EAhqY1+8VTnIa15h/iJUpjpJHXVgqCcgzAelsq1IhLa4BzjhPARyyh13bTpNgZJM8M
         Q7fg==
X-Gm-Message-State: AOJu0YyCXf04g3E/L0DQTos5baL6S8PXMr8pFTTOHOQ1WqRk/Q6dyK6q
        d8xmVhvwXmbDmzEvF1pD5hmQZg==
X-Google-Smtp-Source: AGHT+IHkxohEACGL5SdKjjjF6fvIKs4dereoSKUrMsNeSZs7VJM1Pw4putVJp0cW2246JmGYARZqVQ==
X-Received: by 2002:a17:90a:5b14:b0:277:1070:74a2 with SMTP id o20-20020a17090a5b1400b00277107074a2mr433536pji.23.1695405226659;
        Fri, 22 Sep 2023 10:53:46 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id 25-20020a17090a031900b00267b38f5e13sm3859593pje.2.2023.09.22.10.53.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Sep 2023 10:53:46 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Dipen Patel <dipenp@nvidia.com>
Cc:     Kees Cook <keescook@chromium.org>, timestamp@lists.linux.dev,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, linux-hardening@vger.kernel.org
Subject: [PATCH] hte: Annotate struct hte_device with __counted_by
Date:   Fri, 22 Sep 2023 10:53:45 -0700
Message-Id: <20230922175344.work.987-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1059; i=keescook@chromium.org;
 h=from:subject:message-id; bh=OVQryODqCB/g4WR7XuD79/l8NqVt3nhB0829UdPi/wk=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlDdSpf3Kwx7fKZxRa2y0wbXOPspvLR/tDumOgh
 fVe2SQmpeGJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZQ3UqQAKCRCJcvTf3G3A
 JmZcD/9keGvTb17NpgoZzukMmIn84X59d8K5OywhWbstHwMwEltRXVlNb34PPUwO81o4K2Dc4lB
 pyR5vetBSR9coOmG/BX7+Bt5w3OaUDgjxoaF47Xn2wbVgvHz84Zebkl6nk0xVPa9eCMY4Qkl6SZ
 1BpM027eTkhtCtdyXBcbPPhTerEmb3jUMno/g5ZoExPUUY5/Ww3lL7P7y2H6slJcYtdWv4Z7vhO
 ER2uVigan6DH3jZ69AuAhfDVt2xNPY3r8yIP5vJjsCAHolhjGWj61cjsc3UQaKQBkouMPcFf+p7
 SnphUaYvroXEc+zNP2b6XHDgRmPWI6FCTmH832k1pqlVDNzkCXYAvfgImEu6vqD17SNRwDunQc1
 Bg3Gzi6K6TIT+2LY3n3vFrBfbPBIObwhwyLH3kH0BA+af1J7Lm22jIIb0ImERafPbKJ97wTvF+E
 7xIdMZCM9WoGPQ/VSRaFdJRUP9tCi2IRSPMOkhAMzeWQytI5MheDDA/xBR5GyMdWmlObSF7ms6m
 fFRpVciXEOvXp71M2QrUWpYApR3xjF2z7JDqIhzWVUTHzOkX/xz2zpsCV8oj8UmKmh5SUG3mxri
 2tbY+erRzfRbgMhzycyEnFA3ar30UyL8s6ZiBiCqi/TA4ACp3DqSl0x8lpaptlN9AxBdDWoyGd6
 wJKKZcv TUduAbNw==
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

Prepare for the coming implementation by GCC and Clang of the __counted_by
attribute. Flexible array members annotated with __counted_by can have
their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS
(for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
functions).

As found with Coccinelle[1], add __counted_by for struct hte_device.

[1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci

Cc: Dipen Patel <dipenp@nvidia.com>
Cc: timestamp@lists.linux.dev
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/hte/hte.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hte/hte.c b/drivers/hte/hte.c
index 598a716b7364..1fd8d2d4528b 100644
--- a/drivers/hte/hte.c
+++ b/drivers/hte/hte.c
@@ -88,7 +88,7 @@ struct hte_device {
 	struct list_head list;
 	struct hte_chip *chip;
 	struct module *owner;
-	struct hte_ts_info ei[];
+	struct hte_ts_info ei[] __counted_by(nlines);
 };
 
 #ifdef CONFIG_DEBUG_FS
-- 
2.34.1


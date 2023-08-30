Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70B4A78DF84
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 22:14:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242065AbjH3TLK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 15:11:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245741AbjH3QI0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 12:08:26 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0469D193;
        Wed, 30 Aug 2023 09:08:24 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id ca18e2360f4ac-792623074edso24675039f.1;
        Wed, 30 Aug 2023 09:08:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693411703; x=1694016503; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+o8LtjT+8MaibSIlGxDw3+5yjc0VlIt1qjVe3m2s/Vg=;
        b=EjNBilr/ksuaH4ePBygOPrG6B4Cp0F/zUKt96Bj4pu86O0uPTr9aZ8bAOmc3lE+Jxc
         +Iw6O1NIJDIRkED7BpaiRnbYzXs6M2sXucAQBK2apH65EoaLw2477xOpBfelIoslHeG5
         CVHAgyRlFAiWzBe+QOpArOqdW9ge6dhDC5ypR6Gxbb8xe2CKP+ldkhsm2RVi+HA4fVnZ
         QVIc4K7FYJcPMTUsHbkzUYNgXLJ7BO1xQdDvJtuqL2/HKkNP5L36EU8JMBw3MgUJpiMi
         Cwz3Roh6wgtoyVXZUIHl0WQ2NUPW2/qIzoCW186DxQIiykefvfTyT1XbQV5BJYJhJxbp
         ae1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693411703; x=1694016503;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+o8LtjT+8MaibSIlGxDw3+5yjc0VlIt1qjVe3m2s/Vg=;
        b=FMEIbXmEosf0+suJ12Xn6h6FGLWzdZfl3RrkiY977C+gCPDwXipDaE7HU5RiyQBvRs
         huWrVlA+QhhkbPdQlSmROhbdHWsNkR05Yj8GoYkYXrfUxc0Zio0O0kxXH6CzpR8Qx3TU
         GOQV39OU+djJy2uR7RjOWlt0Yeo8wfgj2ekEPygLfwgXDQ4B8IJhxMdVdJK5s6XYQceI
         w8yixEXiZkUZ+g3ivYQcSQJ9ZVOtSp0aopmZ/bDy0A8tsDRPhEx8MTFB/QyW2H6xMt72
         nvin255hi+/FMFODmKQa+SH5jhznPZTiTILJiewzA9SzhKWK+LbNI2gEG9oPrcBtoRS3
         6mLw==
X-Gm-Message-State: AOJu0Yw4esZwlvUOLC/qnjC9XLoZIfkkUeg+kYPJRtFVwC203mUIkd+6
        IBPyoRy578XMy8Xb+CfEtHAnJ9fF8V4Qjg==
X-Google-Smtp-Source: AGHT+IHZE4wbHqPln6/a5HmYi+TSnxjscUyR7Ut/uvGI5UYvEp/KrpvlbbEUxb5wS4I7N/2So43JLw==
X-Received: by 2002:a92:dc47:0:b0:348:7f18:68be with SMTP id x7-20020a92dc47000000b003487f1868bemr80212ilq.4.1693411703313;
        Wed, 30 Aug 2023 09:08:23 -0700 (PDT)
Received: from azeems-kspp.c.googlers.com.com (161.74.123.34.bc.googleusercontent.com. [34.123.74.161])
        by smtp.gmail.com with ESMTPSA id bp7-20020a056e02348700b0034ce78e2450sm3121290ilb.39.2023.08.30.09.08.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Aug 2023 09:08:22 -0700 (PDT)
From:   Azeem Shaikh <azeemshaikh38@gmail.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-hardening@vger.kernel.org,
        Azeem Shaikh <azeemshaikh38@gmail.com>,
        linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>
Subject: [PATCH] init/version.c: Replace strlcpy with strscpy
Date:   Wed, 30 Aug 2023 16:08:06 +0000
Message-ID: <20230830160806.3821893-1-azeemshaikh38@gmail.com>
X-Mailer: git-send-email 2.42.0.rc2.253.gd59a3bf2b4-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

strlcpy() reads the entire source buffer first.
This read may exceed the destination size limit.
This is both inefficient and can lead to linear read
overflows if a source string is not NUL-terminated [1].
In an effort to remove strlcpy() completely [2], replace
strlcpy() here with strscpy().

Direct replacement is safe here since return value of -errno
is used to check for truncation instead of sizeof(dest).

[1] https://www.kernel.org/doc/html/latest/process/deprecated.html#strlcpy
[2] https://github.com/KSPP/linux/issues/89

Signed-off-by: Azeem Shaikh <azeemshaikh38@gmail.com>
---
 init/version.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/init/version.c b/init/version.c
index f117921811b4..94c96f6fbfe6 100644
--- a/init/version.c
+++ b/init/version.c
@@ -21,10 +21,10 @@ static int __init early_hostname(char *arg)
 {
 	size_t bufsize = sizeof(init_uts_ns.name.nodename);
 	size_t maxlen  = bufsize - 1;
-	size_t arglen;
+	ssize_t arglen;

-	arglen = strlcpy(init_uts_ns.name.nodename, arg, bufsize);
-	if (arglen > maxlen) {
+	arglen = strscpy(init_uts_ns.name.nodename, arg, bufsize);
+	if (arglen < 0) {
 		pr_warn("hostname parameter exceeds %zd characters and will be truncated",
 			maxlen);
 	}
--
2.41.0.255.g8b1d071c50-goog



Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CB5E78DFFD
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 22:16:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245458AbjH3TQF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 15:16:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245275AbjH3PBv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 11:01:51 -0400
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F5721A2;
        Wed, 30 Aug 2023 08:01:49 -0700 (PDT)
Received: by mail-il1-x12a.google.com with SMTP id e9e14a558f8ab-34961362f67so2510245ab.0;
        Wed, 30 Aug 2023 08:01:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693407709; x=1694012509; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KO0ZQFicCSdSCysZFTM2H7s5pykSU7LfpCSZ9Y7Djcc=;
        b=A0vLxtFtqvN3LPu6ZMvHaPBEAKXRxLWY0n88+d2JTjwfCwVqr5NkasaBNjr7WpucIJ
         5TGjBo++LmvrrHFuOB27h3FykfjBCLKHwCviqHKtOEYkopZUPkjXn6rqCu2iw23VhXjd
         0XCyHYzTI2Qm8OyFkwcAM96W89+7YoDGN29yxv6ZKB2NKFJzSrWaz55HPZi6c/sc9S+C
         gJPc+SAuaVkv8S1X8zfP0toFKqZYyP8g+1UFZcYCtd1Z5R+E3kYlcX3mQB3BObct57ws
         mm+r9y+5d4vNEWRQKsyZARaR1D4mE1plpV4Iejcf1+uh0EHaNfP6z9Vj7ZjU06m+9zLf
         /K1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693407709; x=1694012509;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KO0ZQFicCSdSCysZFTM2H7s5pykSU7LfpCSZ9Y7Djcc=;
        b=IlgeNtyv2+d5NU5r/3+0gy0lRXpf3TlUDZXEk/Jdd99rpyZ2pmJJfb/S3MkqEY1ZjV
         wkzX92slZDIoJ65uU2M5ujEpp3l3saz1RrVpWiLaVo+zOp3e7tmvkIx9FCBnpceEOJoP
         ugOz8/muRvJpbNLzoNWJgg+aRcXdexmfnAIME3KbUZ0NdKeERe5ep8fqWXIcJeU/ws8q
         R4jz9f6e1oHbxpqNmzR26xiu7YV+QvuiMD7tmD8mAC7uSUHfBCAS7qPPa5CYz/SwYSKe
         xtFUeQMQx3b7KpnBwKSJZnaZ5ij1nEg4fQbu3Xhcz8yOd0Ux7rUJVcAKN7kGTBfukwHp
         ys7g==
X-Gm-Message-State: AOJu0Yx42w+kazZU2KNgmj/cwl8NSRmuILGcOmrC5d5NzjQedBKeUFpM
        khn3TrCAffkQewdSe+gQqus=
X-Google-Smtp-Source: AGHT+IHmmRVoSTfRy3w+RS8z6j8/ShkNBcmlbcnp9tBSwybUgQ74s/Dg3bLzQ9xX6EuCH4X8Z72efg==
X-Received: by 2002:a05:6e02:12b3:b0:348:b07e:fdac with SMTP id f19-20020a056e0212b300b00348b07efdacmr2164954ilr.3.1693407708633;
        Wed, 30 Aug 2023 08:01:48 -0700 (PDT)
Received: from azeems-kspp.c.googlers.com.com (161.74.123.34.bc.googleusercontent.com. [34.123.74.161])
        by smtp.gmail.com with ESMTPSA id i10-20020a056e02054a00b0034cb37f0636sm3838801ils.40.2023.08.30.08.01.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Aug 2023 08:01:48 -0700 (PDT)
From:   Azeem Shaikh <azeemshaikh38@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        David Laight <David.Laight@aculab.com>,
        Kees Cook <keescook@chromium.org>
Cc:     linux-hardening@vger.kernel.org,
        Azeem Shaikh <azeemshaikh38@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] kobject: Replace strlcpy with strscpy
Date:   Wed, 30 Aug 2023 15:01:36 +0000
Message-ID: <20230830150136.3798414-1-azeemshaikh38@gmail.com>
X-Mailer: git-send-email 2.42.0.rc2.253.gd59a3bf2b4-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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
v2:
 * Updated error message to remove @len which is errno now.

v1:
 * https://lore.kernel.org/all/20230703180528.3709258-1-azeemshaikh38@gmail.com/

 lib/kobject_uevent.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/lib/kobject_uevent.c b/lib/kobject_uevent.c
index 7c44b7ae4c5c..323127e444d4 100644
--- a/lib/kobject_uevent.c
+++ b/lib/kobject_uevent.c
@@ -254,10 +254,10 @@ static int init_uevent_argv(struct kobj_uevent_env *env, const char *subsystem)
 	int buffer_size = sizeof(env->buf) - env->buflen;
 	int len;
 
-	len = strlcpy(&env->buf[env->buflen], subsystem, buffer_size);
-	if (len >= buffer_size) {
-		pr_warn("init_uevent_argv: buffer size of %d too small, needed %d\n",
-			buffer_size, len);
+	len = strscpy(&env->buf[env->buflen], subsystem, buffer_size);
+	if (len < 0) {
+		pr_warn("init_uevent_argv: insufficient buffer space "
+                        "(%u left) for %s\n", buffer_size, subsystem);
 		return -ENOMEM;
 	}
 
-- 
2.42.0.rc2.253.gd59a3bf2b4-goog



Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CEC2765FF2
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 00:51:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230112AbjG0Wv1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 18:51:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbjG0WvZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 18:51:25 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D04B430D2
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 15:51:01 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d052f49702dso1363092276.3
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 15:51:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690498261; x=1691103061;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=9gBFfLJA2QnUt2o02yj0CBzRwwnMTjBwRjYaFoYtp30=;
        b=tRjo0W7c5gh+Dl3UY4mPCGq5xDIupvaIqcoLAO+9A9kMjC1WtyedfU6hNp4MSytOPv
         +tlpG0WLRrdfIwlylaKATwQVYjuLN6/5nw+atV3kXwCugkKtuurz4KvMOG+WiX99AZKE
         JpuagiL99epKN2RpBFrz2XNkolkmASb84Mm39epg2pYFJ+aTGHvDFAR454touPNQrlxv
         9PbUxILqC2VhCabFZuQA18iK20AVBdQIa0RykF6333oDvdoV2lUpoOUj7jbw0gwqtJ8B
         wccBZPAUPOHacmQ/pxoXlIGHNrW8HHMFWFHNOmkhzaIoPSyUgArPtv1HenJDOYcgiMC9
         I6Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690498261; x=1691103061;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9gBFfLJA2QnUt2o02yj0CBzRwwnMTjBwRjYaFoYtp30=;
        b=kdOoaQ1Nu9KrVMmFjw91T9at2eaFzlj679HkOK0C2tFDntO8b3/lEGkzuUtdVvSGLb
         zwkSSgC2lMXx9myy37/tpzS18OfFSHUsLXoYsBtbub6auy3EPe4/iIi+FYQO7j+qASNo
         KLWajeShaOh5Bu3MHyyRzl+MTLyyT5IUqhvFzKJUGTrVCkBFEumBSweDXFAy1kTHfcbK
         nI64iq3pORAIyOxC6Gmht6nSN9TpvrtiXqR+6+WXaqzG5W0m9w785vQzQ7x1lyUTx4Tw
         Z+mIcGeism95MgNQpPr7nCvkyWUoqXbyuU9/nFsFnjY3121FSzSNO/L0lEir0L9NBe5M
         Ax9w==
X-Gm-Message-State: ABy/qLaLkQ2BAe5apdmWIHYL9DPPtx6tHZQuk4zlMnbGSDJvQ6QJJlMG
        85MCVwK9Fz5Ec5HojtdmpSpctJtn10cx5clz86c=
X-Google-Smtp-Source: APBJJlHs1u1Z2TVx58in2bo8paryCsP0hXDuuvI0B3YUjX8FowCyzCFy0y9JpwKV4OLjAO/T78ne7OXi3rwgeHRzdVE=
X-Received: from ndesaulniers-desktop.svl.corp.google.com ([2620:15c:2d1:203:659f:4728:cfbb:8cc3])
 (user=ndesaulniers job=sendgmr) by 2002:a25:d2c9:0:b0:d05:7ba4:67f9 with SMTP
 id j192-20020a25d2c9000000b00d057ba467f9mr144ybg.3.1690498261119; Thu, 27 Jul
 2023 15:51:01 -0700 (PDT)
Date:   Thu, 27 Jul 2023 15:50:58 -0700
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIANH0wmQC/2WNyw6DIBQFf8XcdWl4hCJd+R+NC8RbIFEwUE0b4
 7+Xuu1yJidzdiiYAxa4Nztk3EIJKVbglwasN9EhCWNl4JQLqrgiZh7dshItLEUpKNeSQR0PpiA
 ZsonW13lcp6nKJeMzvM/6o6/sQ3ml/DnPNvazf92NEUaMljdNUUnRtp1LyU14tWmG/jiOL3UgT tOyAAAA
X-Developer-Key: i=ndesaulniers@google.com; a=ed25519; pk=UIrHvErwpgNbhCkRZAYSX0CFd/XFEwqX3D0xqtqjNug=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1690498259; l=3950;
 i=ndesaulniers@google.com; s=20220923; h=from:subject:message-id;
 bh=HmXOPSMRuaQICNAuT3z+gT3+4lGoIiU2zn92zax0abE=; b=C/jkLISLEg3RiEbGKI3rgPrsu0tsBb8GyyA/jdmvz1BRew0Z+NUTi11CP6+Z2T96EFYYXYUQh
 jtpaWUls+1bBQK1bfjI0vJFqRDFd85XQSGhQzFzs1b9y8kZQH7Qiop7
X-Mailer: b4 0.12.2
Message-ID: <20230727-amdgpu-v2-1-7fc66bc52bf6@google.com>
Subject: [PATCH v2] drm: fix indirect goto into statement expression UB
From:   ndesaulniers@google.com
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Nathan Chancellor <nathan@kernel.org>,
        Tom Rix <trix@redhat.com>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, Naresh Kamboju <naresh.kamboju@linaro.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A new diagnostic in clang-17 now produces the following build error:

drivers/gpu/drm/tests/drm_exec_test.c:41:3: error: cannot jump from this
indirect goto statement to one of its possible targets
   41 |                 drm_exec_retry_on_contention(&exec);
      |                 ^
include/drm/drm_exec.h:96:4: note: expanded from macro
'drm_exec_retry_on_contention'
   96 |                         goto *__drm_exec_retry_ptr;
      |                         ^
drivers/gpu/drm/tests/drm_exec_test.c:39:2: note: possible target of
indirect goto statement
   39 |         drm_exec_until_all_locked(&exec) {
      |         ^
include/drm/drm_exec.h:79:33: note: expanded from macro
'drm_exec_until_all_locked'
   79 |                 __label__ __drm_exec_retry;
drivers/gpu/drm/tests/drm_exec_test.c:39:2: note: jump enters a
statement expression

The GCC manually currently states that:
>> Jumping into a statement expression with a computed goto (see Labels
>> as Values) has undefined behavior.

So the diagnostic appears correct, even if codegen happened to produce
working code.

Looking closer at this code, while the original combination of statement
expression, local label, and computed/indirect goto GNU C expressions
were clever, a simple while loop and continue block might have sufficed.

This approach might not work as expected if drm_exec_until_all_locked
"loops" can be nested, but that doesn't appear to be an existing use
case in the codebase.

Fixes: commit 09593216bff1 ("drm: execution context for GEM buffers v7")
Link: https://gcc.gnu.org/onlinedocs/gcc/Statement-Exprs.html
Link: https://github.com/ClangBuiltLinux/linux/issues/1890
Link: https://github.com/llvm/llvm-project/commit/20219106060208f0c2f5d096eb3aed7b712f5067
Reported-by: Nathan Chancellor <nathan@kernel.org>
Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
---
Changes in v2:
Fix the continue to be outside of the do while
- Link to v1: https://lore.kernel.org/r/20230727-amdgpu-v1-1-a95690e75388@google.com
---
 include/drm/drm_exec.h | 21 +++++----------------
 1 file changed, 5 insertions(+), 16 deletions(-)

diff --git a/include/drm/drm_exec.h b/include/drm/drm_exec.h
index 73205afec162..fa1cc5c3d021 100644
--- a/include/drm/drm_exec.h
+++ b/include/drm/drm_exec.h
@@ -70,18 +70,8 @@ struct drm_exec {
  * Core functionality of the drm_exec object. Loops until all GEM objects are
  * locked and no more contention exists. At the beginning of the loop it is
  * guaranteed that no GEM object is locked.
- *
- * Since labels can't be defined local to the loops body we use a jump pointer
- * to make sure that the retry is only used from within the loops body.
  */
-#define drm_exec_until_all_locked(exec)				\
-	for (void *__drm_exec_retry_ptr; ({			\
-		__label__ __drm_exec_retry;			\
-__drm_exec_retry:						\
-		__drm_exec_retry_ptr = &&__drm_exec_retry;	\
-		(void)__drm_exec_retry_ptr;			\
-		drm_exec_cleanup(exec);				\
-	});)
+#define drm_exec_until_all_locked(exec)	while(drm_exec_cleanup(exec))
 
 /**
  * drm_exec_retry_on_contention - restart the loop to grap all locks
@@ -90,11 +80,10 @@ __drm_exec_retry:						\
  * Control flow helper to continue when a contention was detected and we need to
  * clean up and re-start the loop to prepare all GEM objects.
  */
-#define drm_exec_retry_on_contention(exec)			\
-	do {							\
-		if (unlikely(drm_exec_is_contended(exec)))	\
-			goto *__drm_exec_retry_ptr;		\
-	} while (0)
+#define drm_exec_retry_on_contention(exec)		\
+	if (unlikely(drm_exec_is_contended(exec)))	\
+		continue;				\
+	do {} while (0)
 
 /**
  * drm_exec_is_contended - check for contention

---
base-commit: 451cc82bd11eb6a374f4dbcfc1cf007eafea91ab
change-id: 20230727-amdgpu-93c0e5302951

Best regards,
-- 
Nick Desaulniers <ndesaulniers@google.com>


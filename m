Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DCAA79F5BA
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 01:54:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233204AbjIMXyX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 19:54:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233157AbjIMXyW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 19:54:22 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D94BE69
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 16:54:18 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1bd9b4f8e0eso2682745ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 16:54:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1694649257; x=1695254057; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TmQ1vlrBfUMvjYgfJYVMsqlQZ4GMxfIJbcG1jqAE/6c=;
        b=KYGwYidmtfdn/dlj8oYuvfxjws2xHrEMd1iOLoC73SvwTPuBPVk/NAVOoZucY9ON2W
         pVP7B0D8lORNTfDupoplEYpU+aNS0d75NfcbJHeVO7n7ViWQgLVu2W2Dvp0ioDx2MUw4
         zUS+XOy3nJ0xTf+v3jtCiX2uAuA2VX1mgIIsE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694649257; x=1695254057;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TmQ1vlrBfUMvjYgfJYVMsqlQZ4GMxfIJbcG1jqAE/6c=;
        b=hoVU/K/CRsQqSB+PGw7XXXtBKFR7upsbKZKgL9BQXBlFvu70OeGpErReQOcX/twoLt
         m+Ozy82fsCkdjREirwTZE/TBTUbr6QPAGDTSTEwJOdEv1OPPk3us2qFXVTLQaVsGvfir
         mgnmu7GLnDkxtTYhMUbOnz1xMKmeSKQo47a0fD/vXnacO458Pmrl+ZOl5qkkcSax9a0Z
         IsODDuc3T/OfNbOLPp+oTz8Ew+BpUvrcWb3khxxg6aevKb6ZA8TwtlnmNF0mjA5K19pi
         /whJoB0Iw2r1xUp24K66oxDi3Eu9Suqr7XX48wSxVVo+IH1mEqp/ZzHmMZihuDnIZLZs
         9g9w==
X-Gm-Message-State: AOJu0YxPV0RczbtF1PPCZxc+iJIymYzCVCtLSpurpo1roKAmgqzs9OoI
        W3tmjik8ZKffeeOIS07cR3b3Ag==
X-Google-Smtp-Source: AGHT+IHHGiBglQQYGl+V0dzdJ7yOnXC6bJL5bkPKwBmwTtLt+2HI3ODYI/P87KBasDHTHHpBjUAVCA==
X-Received: by 2002:a17:903:32cf:b0:1bc:6c00:a2cf with SMTP id i15-20020a17090332cf00b001bc6c00a2cfmr5268838plr.53.1694649257342;
        Wed, 13 Sep 2023 16:54:17 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id 19-20020a170902c11300b001b9d7c8f44dsm175831pli.182.2023.09.13.16.54.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Sep 2023 16:54:16 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>, Johan Hovold <johan@kernel.org>,
        Jessica Yu <jeyu@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
        Nick Desaulniers <ndesaulniers@gooogle.com>,
        Miguel Ojeda <ojeda@kernel.org>, Joe Perches <joe@perches.com>,
        linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: [PATCH v2] module: Clarify documentation of module_param_call()
Date:   Wed, 13 Sep 2023 16:54:14 -0700
Message-Id: <20230913235407.gonna.817-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2680; i=keescook@chromium.org;
 h=from:subject:message-id; bh=pNcngmHYrvDvUxoczJLnyZVd+nVJiePsfxEYP+mQ0xQ=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlAkuma27fQb+IVRynpM5+rd9HXGa5bQURQdPIS
 Wt4kC4XqSeJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZQJLpgAKCRCJcvTf3G3A
 JqnbD/42vpNafZEmP4ggRIZjSYnTNljv/5iB7eQ3O5HsbD5EckktJlskTx4nh5U8W6Aq19QK2ud
 cpUdzg+pXwtgB6Cc8dE/tSxo48uWZInMrTT2ImA75OAgvHUoTukoDigzVuGNfNSrj8wwOCRNOgp
 5Z9CVTPYynY4j4HAk0gix5Vb7hKvTofXGIvDZxeKISf6PHd9GQaF+u90y3eC5GXv7jbXG2nUWMd
 4NXLlFB0iZ5C+DHn4YK8I3agbJcRGR8AQlUunhBMMCJxeU3HUju5BiP3kEbx4DBIYjBrSA/QU1O
 8/tjv6OGGs3fYvAQ3xMFWvy2TbCupCo1lfgi3O6BiRNEv50X+1mcQkXNI54EXvhubFgNuxReHZH
 2fm2UDFT/B5IPWfve0GeE0NEa0xOIb917g8ValpzTBbn1wwa4Cb37YnEqKyRG22SBqa0NqTjB0S
 iHnXFAqAXLpyx//pUD7Ks9PGgleLZaU8eJRa/nFsbK56NHu5jc7aUphIaQMXjJqqPskKe0Nh2cp
 a9nfclOGfgol2VuYRRce2AEQ7ntXiAMeFWHx2QThOLBUaiUJmwsZgGsG00gYWZtg80rEv3BEcAB
 Wn7nkaHEBmeBdG64VcXqh1BpeLkTj3RmG8xmxghATmcI4X+1ERuTGdwGWV+cPvnJFVQAOrI4S6w
 a+qnLUI SM27XxvQ==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 9bbb9e5a3310 ("param: use ops in struct kernel_param, rather than
get and set fns directly") added the comment that module_param_call()
was deprecated, during a large scale refactoring to bring sanity to type
casting back then. In 2017 following more cleanups, it became useful
again as it wraps a common pattern of creating an ops struct for a
given get/set pair:

  b2f270e87473 ("module: Prepare to convert all module_param_call() prototypes")
  ece1996a21ee ("module: Do not paper over type mismatches in module_param_call()")

        static const struct kernel_param_ops __param_ops_##name = \
                { .flags = 0, .set = _set, .get = _get }; \
        __module_param_call(MODULE_PARAM_PREFIX, \
                            name, &__param_ops_##name, arg, perm, -1, 0)

        __module_param_call(MODULE_PARAM_PREFIX, name, ops, arg, perm, -1, 0)

Many users of module_param_cb() appear to be almost universally
open-coding the same thing that module_param_call() does now. Don't
discourage[1] people from using module_param_call(): clarify the comment
to show that module_param_cb() is useful if you repeatedly use the same
pair of get/set functions.

[1] https://lore.kernel.org/lkml/202308301546.5C789E5EC@keescook/

Cc: Luis Chamberlain <mcgrof@kernel.org>
Cc: Johan Hovold <johan@kernel.org>
Cc: Jessica Yu <jeyu@kernel.org>
Cc: Sagi Grimberg <sagi@grimberg.me>
Cc: Nick Desaulniers <ndesaulniers@gooogle.com>
Cc: Miguel Ojeda <ojeda@kernel.org>
Cc: Joe Perches <joe@perches.com>
Cc: linux-modules@vger.kernel.org
Reviewed-by: Miguel Ojeda <ojeda@kernel.org>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
Luis, I note that include/linux/moduleparam.h isn't in the MAINTAINERS
file pattern. Perhaps you want to use include/linux/module*.h?
---
 include/linux/moduleparam.h | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/include/linux/moduleparam.h b/include/linux/moduleparam.h
index 962cd41a2cb5..d4452f93d060 100644
--- a/include/linux/moduleparam.h
+++ b/include/linux/moduleparam.h
@@ -293,7 +293,11 @@ struct kparam_array
 	= { __param_str_##name, THIS_MODULE, ops,			\
 	    VERIFY_OCTAL_PERMISSIONS(perm), level, flags, { arg } }
 
-/* Obsolete - use module_param_cb() */
+/*
+ * Useful for describing a set/get pair used only once (i.e. for this
+ * parameter). For repeated set/get pairs (i.e. the same struct
+ * kernel_param_ops), use module_param_cb() instead.
+ */
 #define module_param_call(name, _set, _get, arg, perm)			\
 	static const struct kernel_param_ops __param_ops_##name =	\
 		{ .flags = 0, .set = _set, .get = _get };		\
-- 
2.34.1


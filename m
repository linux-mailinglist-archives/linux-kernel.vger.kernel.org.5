Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED7A67ACBA6
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Sep 2023 21:30:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229816AbjIXTa1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Sep 2023 15:30:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbjIXTa0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Sep 2023 15:30:26 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FB55FB
        for <linux-kernel@vger.kernel.org>; Sun, 24 Sep 2023 12:30:19 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-4053c6f0db8so41021755e9.3
        for <linux-kernel@vger.kernel.org>; Sun, 24 Sep 2023 12:30:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695583817; x=1696188617; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rgDFx3OpC7QRJPhJl74znPd+GcKZN1H5/4UCuW8FWRk=;
        b=nkcZFVXeCZvqnp8pjGPtAbTiCWc4qjxCm22zRzk9Yr9KWh3e7A3vs1gdiwhrySe3AM
         /vmaB7HWPO5npkaR8BhMdPJ5cXY1DxfjslJhQwrBTCqaTRvKUX57ezRwaeCxEMBxBoH2
         d0Osd8Gpz+yfbIdSKfXfkQF36TW7ko3sj0p3XZ0wEIwm91VcrMg6E4kKOTr/7jNaWcvl
         tcVxdVpKLHMLD32+gchMg5WSAYzcfiI3gAFrkp8q1TsDE9JxS1uONZfmQ1lSYg6vDCyZ
         ImGu2iX3FC4thSBX3q9hni8pXOqnvC1WsqX0dIPaAEpOkzIAdP4pgvVOzCsPZNm0xMFo
         rV6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695583817; x=1696188617;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rgDFx3OpC7QRJPhJl74znPd+GcKZN1H5/4UCuW8FWRk=;
        b=KhwbdSBovL1U+ddvMXmieLb3t4t3Tt22EGMeox1q57NUczMK2RAoLDm3h5YeWT+UW1
         rE534XcQs3LqV2JArCIDPlwQ1VVATpv8K02ck06FpN6Z2w+YzzLNdUbpZa12ZbkrydyT
         IG14chyPX4B/aIsyVUCeRDeNhIae9SeIzyonUzyrLRr5erOvUZYH1t7S4ikei4h04XFJ
         1JjBjlwUp1sgGlPeah4r0NSgfZ0Ky8rH80q/BIvKxhpT9Qa+bMPdx8+jZa8qsI3pv0Go
         1qS9LfaSGXTMsCzi80VBwzVHNWZq3lu/iIwFO0C4fnwcHHDyME8Y+efB78D5ZgRNwuEc
         oVww==
X-Gm-Message-State: AOJu0Yyn4b3V4v79dNck+xlk7H0IrKBFpHWgojtL9h4Stg8mBJVZwgsN
        ruVUjQ1SwrmPT7Bgf6rh92I=
X-Google-Smtp-Source: AGHT+IENeyDzLBf/mxX+t3aCyhbLfEtHBeZYY7KUbadC62npJv3Xi9K3RDZOHY94J2jksRDajCe6+g==
X-Received: by 2002:a05:600c:280b:b0:3fb:e2af:49f6 with SMTP id m11-20020a05600c280b00b003fbe2af49f6mr3935018wmb.39.1695583817290;
        Sun, 24 Sep 2023 12:30:17 -0700 (PDT)
Received: from nz.home ([2a00:23c8:a613:101:f234:417a:2d3e:68c9])
        by smtp.gmail.com with ESMTPSA id h4-20020a056000000400b0031aef72a021sm10028430wrx.86.2023.09.24.12.30.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Sep 2023 12:30:16 -0700 (PDT)
Received: by nz.home (Postfix, from userid 1000)
        id 2F43010F655DF4; Sun, 24 Sep 2023 20:30:16 +0100 (BST)
From:   Sergei Trofimovich <slyich@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Sergei Trofimovich <slyich@gmail.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>, linux-mm@kvack.org
Subject: [PATCH] uapi: increase MAX_ARG_STRLEN from 128K to 6M
Date:   Sun, 24 Sep 2023 20:30:05 +0100
Message-ID: <20230924193005.1721655-1-slyich@gmail.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Before the change linux allowed individual execve() arguments or
environment variable entries to be only as big as 32 pages.

Histroically before b6a2fea3931 "mm: variable length argument support"
MAX_ARG_STRLEN used to be full allowed size `argv[] + envp[]`.

When full limit was abandoned individual parameters were still limited
by a safe limit of 128K.

Nowadays' linux allows `argv[]+envp[]` to be as laerge as 6MB (3/4
`_STK_LIM`).

Some build systems like `autoconf` use a single environment variable
to pass `CFLAGS` environment variable around. It's not a bug problem
if the argument list is short.

But some packaging systems prefer installing each package into
individual directory. As a result that requires quite long string of
parameters like:

    CFLAGS="-I/path/to/pkg1 -I/path/to/pkg2 ..."

This can easily overflow 128K and does happen for `NixOS` and `nixpkgs`
repositories on a regular basis.

Similar pattern is exhibited by `gcc` which converts it's input command
line into a single environment variable (https://gcc.gnu.org/PR111527):

  $ big_100k_var=$(printf "%0*d" 100000 0)

  # this works: 200KB of options for `printf` external command
  $ $(which printf) "%s %s" $big_100k_var $big_100k_var >/dev/null; echo $?
  0

  # this fails: 200KB of options for `gcc`, fails in `cc1`
  $ touch a.c; gcc -c a.c -DA=$big_100k_var -DB=$big_100k_var
  gcc: fatal error: cannot execute 'cc1': execv: Argument list too long
  compilation terminated.

I would say this 128KB limitation is arbitrary.
The change raises the limit of `MAX_ARG_STRLEN` from 32 pakes (128K
n `x86_64`) to the maximum limit of stack allowed by Linux today.

It has a minor chance of overflowing userspace programs that use
`MAX_ARG_STRLEN` to allocate the strings on stack. It should not be a
big problem as such programs are already are at risk of overflowing
stack.

Tested as:
    $ V=$(printf "%*d" 1000000 0) ls

Before the change it failed with `ls: Argument list too long`. After the
change `ls` executes as expected.

WDYT of abandoning the limit and allow user to fill entire environment
with a single command or a single variable?

CC: Eric Biederman <ebiederm@xmission.com>
CC: Kees Cook <keescook@chromium.org>
CC: linux-mm@kvack.org
CC: linux-kernel@vger.kernel.org
Signed-off-by: Sergei Trofimovich <slyich@gmail.com>
---
 include/uapi/linux/binfmts.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/uapi/linux/binfmts.h b/include/uapi/linux/binfmts.h
index c6f9450efc12..4e828515a22e 100644
--- a/include/uapi/linux/binfmts.h
+++ b/include/uapi/linux/binfmts.h
@@ -8,11 +8,11 @@ struct pt_regs;
 
 /*
  * These are the maximum length and maximum number of strings passed to the
- * execve() system call.  MAX_ARG_STRLEN is essentially random but serves to
- * prevent the kernel from being unduly impacted by misaddressed pointers.
+ * execve() system call.  MAX_ARG_STRLEN is as large as Linux allows new
+ * stack to grow.  Currently it's `_STK_LIM / 4 * 3 = 6MB` (see fs/exec.c).
  * MAX_ARG_STRINGS is chosen to fit in a signed 32-bit integer.
  */
-#define MAX_ARG_STRLEN (PAGE_SIZE * 32)
+#define MAX_ARG_STRLEN (6 * 1024 * 1024)
 #define MAX_ARG_STRINGS 0x7FFFFFFF
 
 /* sizeof(linux_binprm->buf) */
-- 
2.42.0


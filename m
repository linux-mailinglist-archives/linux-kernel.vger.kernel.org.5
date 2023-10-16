Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7739A7CB53F
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 23:25:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233282AbjJPVZV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 17:25:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229666AbjJPVZT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 17:25:19 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8637AA2
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 14:25:17 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-40776b20031so27205485e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 14:25:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697491516; x=1698096316; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VhbRGW1BROKWRFNldIDINnruhAZTrbVrzlHubFel+Hc=;
        b=LTmA3Uv6jthiKo78TwukFJKONbYJRuqxoLDO276hNxSY6wB27kQrMKGJvrjQLCmu2g
         pgoXRQe1dPJhZNwNS2tjgaGqW32EcoMulyYANasLQOD96RUljQQhShshfpLX2ebKMNxP
         X7oLl5T307nRf159lwZ/f4TQp8nvR9ItdydXMGYJvfHJEveBMs6VlYOmgDnE2mjOb6t7
         xDVTl0nc4n3CxIOZc65zLZQVEZiqs7yf0B43K0USxRO1gmqJSa46ja0skRyXYyXWd5KV
         aT+8B7VJcMaytPXgEvCQKEewEd3ajQCPFbpyYGhtFTzWj0MpN2DsGcqYosALtwdUcp7z
         Xikg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697491516; x=1698096316;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VhbRGW1BROKWRFNldIDINnruhAZTrbVrzlHubFel+Hc=;
        b=MFUUingTbo/J3jLYUsljAAUoDDkl/QwhVYQuVWUn+QAcoz8DS9zQd7s7Q6y/H8R8gv
         UHCnSQpbX+k4TndWUlMYT9ria5BwD0fJsqWV56Kj2L+EZYSIHJCCrEOig7J2q+FAA0Op
         +ydA6mPl2hs4/geOQngMumRzmJR2iYt0mN6aezyc9nVSwDQ43Pa8+H77WgQMy+lJOGxl
         0JQvVMnVzTNPGDNqjQExGuDh/nSrsT1EY9Tm1sFNSkiTQrkYnxu9C/4pLDWotwRPccnD
         MS5l5qKrbZpeOjR5adeRPoSDc8vWP9ArK1vlloKiqvDaLXsAi1wWGkehVQGB+tBH5Mqn
         8K1w==
X-Gm-Message-State: AOJu0YwShgDCnyrf966KSQJ3g3/Eh4w4gvf4scRiUCsTbV4ARkKKdkeG
        5Z6Qt1WN94w2yvzSdVLxk4I=
X-Google-Smtp-Source: AGHT+IFHtYyWfnE5O+k5ho1gaylct1XmzISsWkPydW8kDPEVlPNwTOG0Jqli/dOqv0AmSYtoKkS23A==
X-Received: by 2002:a05:600c:a48:b0:3fe:2a98:a24c with SMTP id c8-20020a05600c0a4800b003fe2a98a24cmr242150wmq.26.1697491515524;
        Mon, 16 Oct 2023 14:25:15 -0700 (PDT)
Received: from nz.home (host86-139-202-110.range86-139.btcentralplus.com. [86.139.202.110])
        by smtp.gmail.com with ESMTPSA id k21-20020a05600c1c9500b0040607da271asm8229381wms.31.2023.10.16.14.25.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Oct 2023 14:25:14 -0700 (PDT)
Received: by nz.home (Postfix, from userid 1000)
        id 3CD2111AC29807; Mon, 16 Oct 2023 22:25:14 +0100 (BST)
From:   Sergei Trofimovich <slyich@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Sergei Trofimovich <slyich@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Eric Biederman <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>, linux-mm@kvack.org
Subject: [RESEND PATCH] uapi: increase MAX_ARG_STRLEN from 128K to 6M
Date:   Mon, 16 Oct 2023 22:25:07 +0100
Message-ID: <20231016212507.131902-1-slyich@gmail.com>
X-Mailer: git-send-email 2.42.0
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

CC: Andrew Morton <akpm@linux-foundation.org>
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


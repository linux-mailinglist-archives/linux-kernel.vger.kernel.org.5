Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D45057834BA
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 23:13:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229868AbjHUVN2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 17:13:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjHUVN1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 17:13:27 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1D1DC7
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 14:13:25 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id 41be03b00d2f7-5657ca46a56so612590a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 14:13:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692652405; x=1693257205;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ObBOek7iojEwB7ExWwwtEdpENiqzElzxJsPPeIaR1pQ=;
        b=luHn4O5nqwBnW/+kdRc//EfplU4LzzbmGuJmP7XwsXS3YYdaN/o+vonQqD6TQauIWL
         IHJ3K9Z4FBjXIisdMiIW6vPWp0K/xAK9+f9faEUdUV24Uvodsq4mM1b+cjoqwYM1WIkz
         9P6ZimYBe5KnvIH7oUgFhH0lpctnIBRmtkPrqjOyflATIUAEevRGTye3Vc8HvrnKUgJi
         fU09l9+bgB3+RIKI5lY9WkEH4tqdqhN3I0aS+nSeI0B7KPe9skbsewTc1jt2W/Ig1HUQ
         fEg6FNdUxnA5/jsQ9NNmWty9S2d6QKhvA11m2liP+KksA3jeuG5O5MWIdVOyVsSRMSnl
         tuNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692652405; x=1693257205;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ObBOek7iojEwB7ExWwwtEdpENiqzElzxJsPPeIaR1pQ=;
        b=e+Fli6zibFX0AlzYzLBXBXBE2CK/YsnFW+g2AP7p7cr1T5rKU9dqVKwZY6EM7uI1YL
         uNe0NUMuArQab+VJA4AjlZAAbkfHn5PveC2lNUqZuJCap7NOwOen8DC9tMu1rPedQz+c
         8qUiR0kVgPIzRJeLGsaFdIQspQb577ChcvJKHOd7UOOAbDOOGB237bQuGAXSIEI8OIQQ
         GaSg95qXIeMt+3SfB9hILhv1f/xo1UY60KBhAIz9umuzs6t5bl7otVnWVPAhLOmijPml
         sB9Km5gA2p2ybi5YZcd+EpmDEeoUkat9G2yRh+8ur0FtwN6NF9MMgOLpYHMY+n87AGP7
         WQ3w==
X-Gm-Message-State: AOJu0YyuzPiDt1SJlBCpK2hl3JPqDbPcJ34cZXJYONuSDlmC73zidRxP
        z5Cwmx4+ZhHOZkUSdKbzXkw4IaCYGTymjg==
X-Google-Smtp-Source: AGHT+IE7EI+d0LXKjdbcgMRgK3RTgKTRDSBle6ExNPGqc6FCaU/6x3bxx5OVauicRcm8wpjrK5R6yw==
X-Received: by 2002:a05:6a00:1892:b0:68a:61fb:8025 with SMTP id x18-20020a056a00189200b0068a61fb8025mr1727018pfh.1.1692652404485;
        Mon, 21 Aug 2023 14:13:24 -0700 (PDT)
Received: from mail.google.com (122-60-12-59-adsl.sparkbb.co.nz. [122.60.12.59])
        by smtp.gmail.com with ESMTPSA id m65-20020a633f44000000b0056601f864aesm6777805pga.2.2023.08.21.14.13.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Aug 2023 14:13:24 -0700 (PDT)
Date:   Tue, 22 Aug 2023 09:13:18 +1200
From:   Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>
To:     masahiroy@kernel.org, bgray@linux.ibm.com, ajd@linux.ibm.com,
        n.schier@avm.de
Cc:     paulo.miguel.almeida.rodenas@gmail.com,
        linux-kernel@vger.kernel.org, keescook@chromium.org
Subject: [PATCH v2] [next] initramfs: Parse KBUILD_BUILD_TIMESTAMP as UTC date
Message-ID: <ZOPTbkHvj8XQiott@mail.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When KBUILD_BUILD_TIMESTAMP is specified, the date command will parse
it to Unix Epoch time in UTC. However, the date command is
timezone-aware so it will convert from the local timezone to UTC first
which hits some of the sanity checks added on commit 5efb685bb3af1
("initramfs: Check negative timestamp to prevent broken cpio archive")

This creates an edge case for the UTC+<N> part of the world. For instance

 - In New Zealand (UTC+12:00):
     $ date -d"1970-01-01" +%s
     -43200

     $ make KBUILD_BUILD_TIMESTAMP=1970-01-01
     make[1]: Entering directory '<snip>/linux/'
       GEN     Makefile
       DESCEND objtool
       INSTALL libsubcmd_headers
       CALL    ../scripts/checksyscalls.sh
       GEN     usr/initramfs_data.cpio
     ERROR: Timestamp out of range for cpio format
     make[4]: *** [../usr/Makefile:76: usr/initramfs_data.cpio] Error 1

 - In Seattle, WA (UTC-07:00):
     $ date -d"1970-01-01" +%s
     32400

     $ make KBUILD_BUILD_TIMESTAMP=1970-01-01
     <builds fine>

Parse KBUILD_BUILD_TIMESTAMP date string as UTC so no localtime
conversion is done, which fixes the edge case aforementioned

Signed-off-by: Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>
---
Changelog:

- v2: Document behaviour and way to override it on
      Documentation/kbuild/kbuild.rst. (Req: Andrew Donnellan)

- v1: https://lore.kernel.org/lkml/ZMSdUS37BD5b%2Fdn7@mail.google.com/
---
 Documentation/kbuild/kbuild.rst | 9 ++++++++-
 usr/gen_initramfs.sh            | 2 +-
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/Documentation/kbuild/kbuild.rst b/Documentation/kbuild/kbuild.rst
index bd906407e307..8c204186c762 100644
--- a/Documentation/kbuild/kbuild.rst
+++ b/Documentation/kbuild/kbuild.rst
@@ -296,7 +296,14 @@ KBUILD_BUILD_TIMESTAMP
 Setting this to a date string overrides the timestamp used in the
 UTS_VERSION definition (uname -v in the running kernel). The value has to
 be a string that can be passed to date -d. The default value
-is the output of the date command at one point during build.
+is the output of the date command at one point during build. E.g.::
+
+    $ make KBUILD_BUILD_TIMESTAMP="1991-08-25"
+
+By default, the value is interpreted as UTC. To override this, append
+the desired timezone. E.g.::
+
+    $ make KBUILD_BUILD_TIMESTAMP="1991-08-25 UTC+03:00"
 
 KBUILD_BUILD_USER, KBUILD_BUILD_HOST
 ------------------------------------
diff --git a/usr/gen_initramfs.sh b/usr/gen_initramfs.sh
index 14b5782f961a..a90316d9a080 100755
--- a/usr/gen_initramfs.sh
+++ b/usr/gen_initramfs.sh
@@ -221,7 +221,7 @@ while [ $# -gt 0 ]; do
 			shift
 			;;
 		"-d")	# date for file mtimes
-			timestamp="$(date -d"$1" +%s || :)"
+			timestamp="$(date -d"$1" -u +%s || :)"
 			if test -n "$timestamp"; then
 				timestamp="-t $timestamp"
 			fi
-- 
2.41.0


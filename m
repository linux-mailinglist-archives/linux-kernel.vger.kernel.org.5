Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B54BE797A8F
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 19:44:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243159AbjIGRow (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 13:44:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245263AbjIGRop (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 13:44:45 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BF0A1700
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 10:44:21 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id ca18e2360f4ac-79536bc669dso50878839f.3
        for <linux-kernel@vger.kernel.org>; Thu, 07 Sep 2023 10:44:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694108659; x=1694713459; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aEzLFbcIiAVh5ftNySaU8V9gJpiW38T2myqFmqQaqUw=;
        b=Orp9TZuL/tBDSaIa0LADh+MYud/CMKRtrZIbkpWpjIpxl0H0YgA60EYSokcTAiFNpa
         HUqJLl0e5X7aIt8t0RbCFrMhiCYafAFSrIo//MNLV93CISs5azeKOaXIfK/CHRdb2YoB
         bdvIk/hAoQhsMEluso1IQZNiHR/YgzGFNBNEnwjhesLfwTXYoFYz+Z31G59QOaJL8mR2
         uYicCjsgkKZFWFpG5r4nUexjtqfKePndYbKjcU59QB+CcLFPTBcrXDozkZiBGUaNjl2J
         qf0x8eDidu1r2UVU0HbYfhq6j0Jf9pvo+0G+TZnpWIjnYEvUhDPHCxqJVzgZvQkOske2
         IVlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694108659; x=1694713459;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aEzLFbcIiAVh5ftNySaU8V9gJpiW38T2myqFmqQaqUw=;
        b=urMNcPBXUGfJoZWOeBjuZR0WgawzS/N7VHI1bQ81Rl3N5cdWxgdSNualaEnb3IFIgJ
         ia6oDhL4toJDlHlZg4xBaTTg1KcWuDASPnQIRxra05t1sbM41hnL+sKvHWG5di04zI75
         Z/uJcz+2wyTrrbyNvePvVxHjdWKe/OvAHpUbGr1/T/4w1cLt+nvzSmiQhxZAeDEOeX05
         mWKDc24BvoQ3ESz8hdHpviGI4nh2mpck1I+ldtZ1Ikm/ekKMMIUOXGisNgS/fsJs1rXC
         TrBXlLYI4+xiiME+ucovtNfQRYW6POpA17Z3FTi1Dcs4R6sklQd4QL1hHIvQ5Xzf+SLl
         cf7Q==
X-Gm-Message-State: AOJu0Yw4TELOZ7NBV8qLAgOQDA5FFpN9RZYsNRdOz9aNLP0Z15DOzz04
        SdavBWuP53ZUcxKQsFgbZS7Y6bAFePJ7vA==
X-Google-Smtp-Source: AGHT+IHxQx/oYPcPJRi8g0n88K5ntMMpUrbAsfjsst+YxlwZnVqJLl3xT3JsrdPzkfO4ulQF0EXlUw==
X-Received: by 2002:a05:6602:256d:b0:792:63d9:b6b4 with SMTP id dj13-20020a056602256d00b0079263d9b6b4mr362009iob.21.1694108658995;
        Thu, 07 Sep 2023 10:44:18 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id dk21-20020a0566384bd500b0042b21e8853bsm5530512jab.36.2023.09.07.10.44.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Sep 2023 10:44:18 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     akpm@linux-foundation.org, Jim Cromie <jim.cromie@gmail.com>,
        apw@canonical.com, joe@perches.com,
        Kees Cook <keescook@chromium.org>
Subject: [PATCH 1/2] checkpatch: special case extern struct in .c
Date:   Thu,  7 Sep 2023 11:44:14 -0600
Message-ID: <20230907174415.593856-1-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.41.0
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

The warning "externs should be avoided in .c files" wants an exception
for linker symbols (named in vmlinux.lds.h etc), like those that mark
the __start, __stop/__end symbols delimiting many kernel sections.

Since checkpatch already checks REALNAME to avoid looking at patch
chunks changing vmlinux.lds.h, add a new else-if block to look at them
instead.  As a simple heuristic, treat all words (in the + patch-lines)
as candidate symbols, to screen later warnings about the same symbols
being found in following chunks that change *.c files.

Where the "# check for new externs in .c files." is done, precede it
with a new else-if block to isolate one common extern-in-c use case:
"extern struct foo bar[]".  For this case, we can issue a more
informative warning:

  WARN("AVOID_EXTERNS",
     "found a file-scoped extern type:$st_type name:$st_name in .c file\n"
     . "is this a linker symbol ?\n" . $herecurr);

NOTE: The "screening" is a regex match, not an exact match.  This
accepts __start_foo and __stop_foo symbols found in a *.c file, if
"foo" was found previously in a vmlinux.lds.h chunk.

It does require that the patch adding "externs in .c's" also have the
additions to vmlinux.lds.h.  And it requires vmlinux.lds.h chunks
before .c chunks.

Cc: apw@canonical.com
Cc: joe@perches.com
Cc: Kees Cook <keescook@chromium.org>
Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 scripts/checkpatch.pl | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 880fde13d9b8..6aabcc1f66c1 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -74,6 +74,8 @@ my $git_command ='export LANGUAGE=en_US.UTF-8; git';
 my $tabsize = 8;
 my ${CONFIG_} = "CONFIG_";
 
+my %maybe_linker_symbol; # for externs in c exceptions, when seen in *vmlinux.lds.h
+
 sub help {
 	my ($exitcode) = @_;
 
@@ -6051,6 +6053,9 @@ sub process {
 
 # check for line continuations outside of #defines, preprocessor #, and asm
 
+		} elsif ($realfile =~ m@/vmlinux.lds.h$@) {
+		    $line =~ s/(\w+)/$maybe_linker_symbol{$1}++/ge;
+		    #print "REAL: $realfile\nln: $line\nkeys:", sort keys %maybe_linker_symbol;
 		} else {
 			if ($prevline !~ /^..*\\$/ &&
 			    $line !~ /^\+\s*\#.*\\$/ &&		# preprocessor
@@ -7119,6 +7124,21 @@ sub process {
 				     "arguments for function declarations should follow identifier\n" . $herecurr);
 			}
 
+		} elsif ($realfile =~ /\.c$/ && defined $stat &&
+		    $stat =~ /^\+extern struct\s+(\w+)\s+(\w+)\[\];/)
+		{
+			my ($st_type, $st_name) = ($1, $2);
+
+			for my $s (keys %maybe_linker_symbol) {
+			    #print "Linker symbol? $st_name : $s\n";
+			    goto LIKELY_LINKER_SYMBOL
+				if $st_name =~ /$s/;
+			}
+			WARN("AVOID_EXTERNS",
+			     "found a file-scoped extern type:$st_type name:$st_name in .c file\n"
+			     . "is this a linker symbol ?\n" . $herecurr);
+		  LIKELY_LINKER_SYMBOL:
+
 		} elsif ($realfile =~ /\.c$/ && defined $stat &&
 		    $stat =~ /^.\s*extern\s+/)
 		{
-- 
2.41.0


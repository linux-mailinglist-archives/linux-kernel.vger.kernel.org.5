Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF51C76BAB0
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 19:04:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234291AbjHAREr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 13:04:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234147AbjHAREP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 13:04:15 -0400
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B18AC2717
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 10:03:48 -0700 (PDT)
Received: by mail-il1-x12d.google.com with SMTP id e9e14a558f8ab-34930fe8608so4120095ab.3
        for <linux-kernel@vger.kernel.org>; Tue, 01 Aug 2023 10:03:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690909412; x=1691514212;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HTIptaY1Q1Cw8tbq8hqtoZUus2V/66qWUMbxjps5ClE=;
        b=DBM1VlojjC1c4IaxOfDZLDxXUxA9E6CwSVUV5iPtJGlh/jhdn+Z1O05pTkM+QpLBGd
         msg8B6RQKG2RxTePtA5nAQBJyXNXbckAw+s0K0Re2jABj6rfI07mGBxEfg5A9UuYDUmM
         +PJWL/pt2POaLEHJd/QKlpgeed76hBWankEcMkTwPSykYwD7m7ifqA59TLeLGxvj0GrK
         N/lh/wouZUbdd3mOIBlmF6L0Okwdh+P4LSQz2TKwF4BB58nZfScsk6lB8ptXZLGEzqTI
         VYoJhmoF0AbGxZPzTXkTK8IIMc1OmgZf7+Hlh7kBaKjps/x00BFy3aXCNb1xNrN2zrTC
         r3qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690909412; x=1691514212;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HTIptaY1Q1Cw8tbq8hqtoZUus2V/66qWUMbxjps5ClE=;
        b=ekk/t1Af0EAf+uc3ULBhcvyAAtpp+nm08s1h9LjCYDedhhuMVHtQwMZUEuSSqmZIac
         7YK2ahYp4HzMKeZOOXeLnCBaN1YijxXtBGWA97AHH8VsDrF6Ss5KE7KkDuTg36BwWC4r
         kAb9RIRVYzQaIGwgugxqCPHZzbQTZgyp2KrZ/w/Q+tAKv32wphAb7D2pU8tbKr/k8Pc7
         UgEo+itKDrHMsTsbkXSZLsYtBjJppwBWxiX+BxHvnasYNcu6R8iuhpptkBePgJDBCK/S
         o3/+iu7QHrLa0zLjHITtg8trqnNimToGA8WeIQaTwq+U6z28eT9hLYANgAnRKvGZ8pYu
         zgMg==
X-Gm-Message-State: ABy/qLajXpfEJ7bWScAyVx3dKJp56IIHvI8Fuxih7CtTkBSXqNTmFTdd
        ooT0h9JtIM+qRHi7AD2hcb0=
X-Google-Smtp-Source: APBJJlEvxEOAmmWhBekjDXEKP44F1wzy+JOf74gmXKw6CXVXw+vjRTBjU6kykBbo/XVcjPeJ6tQHdQ==
X-Received: by 2002:a05:6e02:1068:b0:348:ec12:fb31 with SMTP id q8-20020a056e02106800b00348ec12fb31mr12258462ilj.0.1690909412652;
        Tue, 01 Aug 2023 10:03:32 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id o20-20020a02c6b4000000b0042b144abf71sm3768577jan.179.2023.08.01.10.03.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Aug 2023 10:03:32 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     daniel.vetter@ffwll.ch, daniel@ffwll.ch, jbaron@akamai.com,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org
Cc:     linux@rasmusvillemoes.dk, joe@perches.com, jani.nikula@intel.com,
        ville.syrjala@linux.intel.com, seanpaul@chromium.org,
        robdclark@gmail.com, Jim Cromie <jim.cromie@gmail.com>,
        apw@canonical.com
Subject: [PATCH v5 13/22] checkpatch: file-scoped extern special case for linker-symbol
Date:   Tue,  1 Aug 2023 11:02:45 -0600
Message-ID: <20230801170255.163237-14-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230801170255.163237-1-jim.cromie@gmail.com>
References: <20230801170255.163237-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"externs should be avoided in .c files" needs an exception for linker
symbols, like those that mark the start, stop of many kernel sections.

Since code already checks REALNAME to avoid linker-scripts entirely,
add a new else-if block to look at them instead.  As a simple
heuristic, treat all words (in the patch-line) as possible symbols,
and save them to screen the WARN quoted above.  For my test case, this
included BOUNDED_BY (a macro), which is extra, but not troublesome.

Where the WARN is issued, precede it with an else-if block to catch
one common extern-in-c use case: "extern struct foo bar[]".  Here we
can at least issue a softer warning, after checking for a match with a
maybe-linker-symbol parsed earlier from the patch.  Though heuristic,
it worked for my test-case, allowing both (start|stop)$symbol's,
matched by $symbol, it wasn't thrown by noise (BOUNDED_BY) in the
maybe-linker-symbols.

NB: git diff ordering dependence on vmlinux.lds.h before c files ?

Cc: apw@canonical.com
Cc: joe@perches.com
Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 scripts/checkpatch.pl | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index b30114d637c4..f6b6b2a50dfe 100755
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
@@ -7107,6 +7112,21 @@ sub process {
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


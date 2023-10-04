Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D2EB7B8EB2
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 23:22:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243743AbjJDVVX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 17:21:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233800AbjJDVVU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 17:21:20 -0400
Received: from mail-oo1-xc49.google.com (mail-oo1-xc49.google.com [IPv6:2607:f8b0:4864:20::c49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9B8E9E
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 14:21:16 -0700 (PDT)
Received: by mail-oo1-xc49.google.com with SMTP id 006d021491bc7-57e43ab7b89so289561eaf.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 Oct 2023 14:21:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696454476; x=1697059276; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=uustZycB7kJeJ83TA5F/0nr7LHNmB7Mbe0hjj9D6IWQ=;
        b=Ha54N8pytjNC9tkGgZGjlSvCkiI4i6WxohaCDS3C1rDdFEdVSZSo4F6o9Fuj+ja/lQ
         3GQRfasrw8cx2qpgfSO0BQTlmNgfAeL5veLd0vNOr4Z2x5wgCFROBjPDgk3ZMSx44LjB
         TxJ6dsJMbYv8Of6AbnNkFQ2Q+z5svXtXcv6q9m4AEKCNEHNfxZ0lgOtyi6d/Z+yhqYNQ
         smWKdgwDmBT0UUhb9sqseGgJlXQiUUBGXNdi1MJPHSBRABKIZ52f1kwp86OqscPzTWBB
         nBAmyQ6kp3HguWFnxP4uS5elCpA9ZqGpR2an3I1LEnUlaQfIWMLphbMXRvXxCRHOn6A8
         SfqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696454476; x=1697059276;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uustZycB7kJeJ83TA5F/0nr7LHNmB7Mbe0hjj9D6IWQ=;
        b=sbnprJ2/K7RpqXoF9rzufTQejCe/2yhn3Ddvds58+RfiS1KcwSIyVp7+90dBwsC8AP
         EF1cucdEnOQANd9f37xvi8WY1LIUc89omMZ0aYk9ElP5/hDRZI7q7K79oHpMGyQB2nEe
         d/wwqPhCoipONOslTxI0LJ5Mu+6STnY59aU9wLeOYD3lPkA6JrG36T3fmIXfMBT9spqD
         /S1rQXSPr4xy+7c2XN2bskJUSXM5Qppb9DADd2ZvZDw2/6CGbWew1KD+YCJk4B0Af10D
         F6XDoC23dw9XFs4hmWCbar2fREij6az/I0GCn/ohM2lFehf3l20WNqadh0kCFfXKBTwf
         UD9Q==
X-Gm-Message-State: AOJu0YwS/YxYf2r5c0OxlUuDkEoMQJ2NQcoqZfv5R8IqoyDwHl/BlevW
        IdrEd4q8EWrtnmPfXsoI5sTpqRuo+LwRXzvalw==
X-Google-Smtp-Source: AGHT+IF8HPtoxElCtn0FYHz6hgD7VdhAjwhpZ+vOOPCUvCw1fEz+MDwpbdsvMHCbhuZ4uitVeXs10ddDSLdObuK34g==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a4a:3786:0:b0:56c:86f2:ae14 with SMTP
 id r128-20020a4a3786000000b0056c86f2ae14mr1194962oor.0.1696454476216; Wed, 04
 Oct 2023 14:21:16 -0700 (PDT)
Date:   Wed, 04 Oct 2023 21:21:15 +0000
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAErXHWUC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI2NDAwMT3fTUkvjcxMy8EiBOLYqHKIrP1jUxSzQyMDVNNUo2tVQC6i4oSk3 LrACbHB1bWwsA8EjKJGkAAAA=
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1696454475; l=3356;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=1ouqrRVKZGujiAVFhjDudh3UU/n1klQ/sSPG4zQOfLc=; b=UD+GQ6914b8AOXn9ZvlYU2isRdr9rJqkMSxpIASk0X2jcIMhDfhUbpSvTGdbMM4eAL9IJoqIY
 DCGiTzLeTBECDKA4a+u9c4v381L8zcnlapyBvdWHrh36B5ZJEAAHyZ0
X-Mailer: b4 0.12.3
Message-ID: <20231004-get_maintainer_change_k-v1-1-ac7ced18306a@google.com>
Subject: [PATCH] get_maintainer/MAINTAINERS: confine K content matching to patches
From:   Justin Stitt <justinstitt@google.com>
To:     Joe Perches <joe@perches.com>
Cc:     linux-kernel@vger.kernel.org,
        Justin Stitt <justinstitt@google.com>,
        Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current behavior of K: is a tad bit noisy. It matches against the
entire contents of files instead of just against the contents of a
patch.

This means that a patch with a single character change (fixing a typo or
whitespace or something) would still to/cc maintainers and lists if the
affected file matched against the regex pattern given in K:. For
example, if a file has the word "clang" in it then every single patch
touching that file will to/cc Nick, Nathan and some lists.

Let's change this behavior to only content match against patches
(subjects, message, diff) as this is what most people expect the
behavior already is. Most users of "K:" would prefer patch-only content
matching. If this is not the case let's add a new matching type as
proposed in [1].

This patch involves 1) ripping out the file-based keyword matching from
get_maintainer.pl and 2) updating the MAINTAINERS documentation to
reflect patch-only semantics.

Signed-off-by: Justin Stitt <justinstitt@google.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Nick Desaulniers <ndesaulniers@google.com>
Link: https://lore.kernel.org/all/20230928-get_maintainer_add_d-v2-0-8acb3f394571@google.com/ [1]
---
 MAINTAINERS               |  8 ++++----
 scripts/get_maintainer.pl | 13 -------------
 2 files changed, 4 insertions(+), 17 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 35977b269d5e..13e7f40ea70b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -51,13 +51,13 @@ Descriptions of section entries and preferred order
 	   get_maintainer will not look at git log history when an F: pattern
 	   match occurs.  When an N: match occurs, git log history is used
 	   to also notify the people that have git commit signatures.
-	K: *Content regex* (perl extended) pattern match in a patch or file.
+	K: *Content regex* (perl extended) pattern match patch content
 	   For instance:
 	   K: of_get_profile
-	      matches patches or files that contain "of_get_profile"
+	      matches patches that contain "of_get_profile"
 	   K: \b(printk|pr_(info|err))\b
-	      matches patches or files that contain one or more of the words
-	      printk, pr_info or pr_err
+	      matches patches that contain one or more of the words printk,
+        pr_info or pr_err
 	   One regex pattern per line.  Multiple K: lines acceptable.
 
 Maintainers List
diff --git a/scripts/get_maintainer.pl b/scripts/get_maintainer.pl
index ab123b498fd9..ea58929287bf 100755
--- a/scripts/get_maintainer.pl
+++ b/scripts/get_maintainer.pl
@@ -548,19 +548,6 @@ foreach my $file (@ARGV) {
 	$file =~ s/^\Q${cur_path}\E//;	#strip any absolute path
 	$file =~ s/^\Q${lk_path}\E//;	#or the path to the lk tree
 	push(@files, $file);
-	if ($file ne "MAINTAINERS" && -f $file && $keywords) {
-	    open(my $f, '<', $file)
-		or die "$P: Can't open $file: $!\n";
-	    my $text = do { local($/) ; <$f> };
-	    close($f);
-	    if ($keywords) {
-		foreach my $line (keys %keyword_hash) {
-		    if ($text =~ m/$keyword_hash{$line}/x) {
-			push(@keyword_tvi, $line);
-		    }
-		}
-	    }
-	}
     } else {
 	my $file_cnt = @files;
 	my $lastfile;

---
base-commit: cbf3a2cb156a2c911d8f38d8247814b4c07f49a2
change-id: 20231004-get_maintainer_change_k-46a2055e2c59

Best regards,
--
Justin Stitt <justinstitt@google.com>


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDB2F7B1177
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 06:23:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230152AbjI1EXN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 00:23:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230017AbjI1EXJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 00:23:09 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21142121
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 21:23:08 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d814634fe4bso19615744276.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 21:23:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695874987; x=1696479787; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=himG2EUevZ0nCD5wQ/EEtMYJiUF1xza4FD5wJPxrdQw=;
        b=UWJbYQh9SIj1SpWpkWBWung+DQntfECaAY+ifuVegnN48ISUdFIWIY6/V2qUN2CBxu
         P+BMtPamqHFFBP8hoZl+Zgodddm+A8FwCIVXp9EK40LU1lY7/lYLYvHbR/hUegd3gTzb
         CmDyhhHN2sG7Vh36k5ZB7P9vuwwHyjSqptyzKA3F6Ze48FkuTFiUl4XtE7NHi/1OzOhU
         l6F5EWT/FRyznsJjS3XkoNTzqrUboKSo5CIhv6mN1fMfmVRLprRL3aApyLDc3W2GWlgr
         ZQ5ifCvTb5vhCSsgk25z4mVOm5AGfMh2jAaLR+fQObinTGk/Rm13Fe0SnyItM3CKLHMH
         gACA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695874987; x=1696479787;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=himG2EUevZ0nCD5wQ/EEtMYJiUF1xza4FD5wJPxrdQw=;
        b=rDKY8JCYzj0DfgyDCcZud7GuEu3LlZHRyk7EaUbrQYWWTEAWLYjm0x1kEzd1xJ4JOU
         Q3jIQCSSP7aXp07Wd0pN8+b04+t6YCsA4SO53VmEBLxZiQNBMyURErev8fvWp2o4oU7U
         mDDTDTVCAvMF0yEadph8L0NwKS/UC3SfbzN5GA2ittrz8H/GiweBom51HLV198Nq1bJk
         p1TVBzRhO5AAjSJQDzkIBgtyLtsvGuNmxbzRds9w7Eslb6BlPLrMt/kRrg3tR0kyRG3A
         iJNcFsWC1+FrHwmHoLE/3pMPFSaQGVAB+77fy7VPIMVN4ZiBqQdrB6CZ4q6CRCRYW+Qj
         cw1w==
X-Gm-Message-State: AOJu0YygqH52BfPEeuDTvoy9rcY7v1AzHPxwrItwT64qg9EY5WhPa6CZ
        Gj7z332ywUGWSjbl0HJ1gUYR/WFRk+CRx3PXjw==
X-Google-Smtp-Source: AGHT+IFrIVKw2+EmPNZNHezNbm1WiVv0NLjoNor2pjdg9EKmdrqDih2JZzJ1TzIHqg97E8RGR0YgmBNwAHrmGwOrwA==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a25:aa8a:0:b0:d80:eb4:9ca with SMTP id
 t10-20020a25aa8a000000b00d800eb409camr1562ybi.0.1695874987336; Wed, 27 Sep
 2023 21:23:07 -0700 (PDT)
Date:   Thu, 28 Sep 2023 04:23:05 +0000
In-Reply-To: <20230928-get_maintainer_add_d-v2-0-8acb3f394571@google.com>
Mime-Version: 1.0
References: <20230928-get_maintainer_add_d-v2-0-8acb3f394571@google.com>
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1695874985; l=2683;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=8gNirzReiW8c5pSV52GSSvvpxk3c6q7GcY+X85S9HH4=; b=xwcKdSmbabKVDWwN+jZOMEgT7h6u6HvkFc9xKfMjjlkxx7J0S4QweUye920eCS7CHIZHGABKT
 kfvh7sj8MklDQvVoXOoPCKfTde7bv3D+NNiE6uIQI/EhZTcGx27HCsJ
X-Mailer: b4 0.12.3
Message-ID: <20230928-get_maintainer_add_d-v2-1-8acb3f394571@google.com>
Subject: [PATCH v2 1/2] get_maintainer: add patch-only keyword-matching
From:   Justin Stitt <justinstitt@google.com>
To:     Joe Perches <joe@perches.com>
Cc:     linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        geert@linux-m68k.org, gregkh@linuxfoundation.org,
        workflows@vger.kernel.org, mario.limonciello@amd.com,
        Justin Stitt <justinstitt@google.com>
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

Add the "D:" type which behaves the same as "K:" but will only match
content present in a patch file.

To illustrate:

Imagine this entry in MAINTAINERS:

NEW REPUBLIC
M: Han Solo <hansolo@rebelalliance.co>
W: https://www.jointheresistance.org
D: \bstrncpy\b

Our maintainer, Han, will only be added to the recipients if a patch
file is passed to get_maintainer (like what b4 does):
$ ./scripts/get_maintainer.pl 0004-some-change.patch

If the above patch has a `strncpy` present in the subject, commit log or
diff then Han will be to/cc'd.

However, in the event of a file from the tree given like:
$ ./scripts/get_maintainer.pl ./lib/string.c

Han will not be noisily to/cc'd (like a K: type would in this
circumstance)

Signed-off-by: Justin Stitt <justinstitt@google.com>
---
 MAINTAINERS               |  5 +++++
 scripts/get_maintainer.pl | 12 ++++++++++--
 2 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index b19995690904..94e431daa7c2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -59,6 +59,11 @@ Descriptions of section entries and preferred order
 	      matches patches or files that contain one or more of the words
 	      printk, pr_info or pr_err
 	   One regex pattern per line.  Multiple K: lines acceptable.
+  D: *Diff content regex* (perl extended) pattern match that applies only to
+     patches and not entire files (e.g. when using the get_maintainers.pl
+     script).
+     Usage same as K:.
+
 
 Maintainers List
 ----------------
diff --git a/scripts/get_maintainer.pl b/scripts/get_maintainer.pl
index ab123b498fd9..a3e697926ddd 100755
--- a/scripts/get_maintainer.pl
+++ b/scripts/get_maintainer.pl
@@ -342,6 +342,7 @@ if ($tree && !top_of_kernel_tree($lk_path)) {
 
 my @typevalue = ();
 my %keyword_hash;
+my %patch_keyword_hash;
 my @mfiles = ();
 my @self_test_info = ();
 
@@ -369,8 +370,10 @@ sub read_maintainer_file {
 		    $value =~ s@([^/])$@$1/@;
 		}
 	    } elsif ($type eq "K") {
-		$keyword_hash{@typevalue} = $value;
-	    }
+          $keyword_hash{@typevalue} = $value;
+	    } elsif ($type eq "D") {
+          $patch_keyword_hash{@typevalue} = $value;
+      }
 	    push(@typevalue, "$type:$value");
 	} elsif (!(/^\s*$/ || /^\s*\#/)) {
 	    push(@typevalue, $line);
@@ -607,6 +610,11 @@ foreach my $file (@ARGV) {
 			push(@keyword_tvi, $line);
 		    }
 		}
+    foreach my $line(keys %patch_keyword_hash) {
+      if ($patch_line =~ m/${patch_prefix}$patch_keyword_hash{$line}/x) {
+        push(@keyword_tvi, $line);
+      }
+    }
 	    }
 	}
 	close($patch);

-- 
2.42.0.582.g8ccd20d70d-goog


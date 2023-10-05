Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B4767BAB39
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 22:09:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230334AbjJEUJ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 16:09:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230149AbjJEUJ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 16:09:26 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1591DE
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 13:09:24 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d85fc108f0eso1996286276.2
        for <linux-kernel@vger.kernel.org>; Thu, 05 Oct 2023 13:09:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696536564; x=1697141364; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=FIkxLSuLMl0TMTK26Cp/K+KBz1/MVryZPZpvEY8CMYY=;
        b=gu8HQcf+jR02J87NgGVAbQ+pr/r2yLML9Vfm01xJqNSdiVSLB4MStLy/GFd88cvMbx
         TeFo7UgQNKseldXUCUHe/76WEdgPkVpwVe2ZtrTNHCR7BbUYcuqZqt7LqeLY44S+poJc
         HM9MroJguqnDdB+zgYP/+18HdYnrVoOxJzNPP4M47SoFm46ttYD4Q2j+xtp5f2fKCe3t
         +pE49MdwZm9m0tsAqHY9pBueUBZDo4d6Dxiurey3zFtSzICv72w2SKh7HUcqOKIbxmVL
         vsv8H9Hr4KMLOZUvmTrixhU7Kkodii9EBQnk5MzQWD6gTmgdZm9/Tj+tX7lJ8cQOvGbf
         +d3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696536564; x=1697141364;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FIkxLSuLMl0TMTK26Cp/K+KBz1/MVryZPZpvEY8CMYY=;
        b=khWe0ubeI5qO2zfOZN5bN9qj9AiytaE9BZFx9qsuNqmoVVKm0O4Ntaay1+qkIMbNNj
         w9/mJqRM4Rm7WjG+GChTjrt+sHyFZVAKDm+SgO2JegehhdT3pofob9DaDP7ew7HUtUmc
         LsD5dP8/ZNDmWrmIenWssjGffLaPAsLAC+n/oMss5TJDmItXC/CtTO2nRNLlcdEAq7p0
         pcSR1HH6Gbm+ecUqg893cYnSvJJkJAAthV6sFJCRGt2bnll5LfifoJBgJvaLvJpwRaDl
         69DQSjfTFPqx8UbEf5kFmj+hCl4ftfTUeARWtP4sjhnkWzyMZymaZ/gzPlfJx43wf0L2
         3r2g==
X-Gm-Message-State: AOJu0YyxY65V3B6bWoT+lZwDKzN9SY1m5A1kElCrubYFuClDyvCK9CmV
        tWxab/IQpQc406d6tENYpB4rMWYUtld+6L12jw==
X-Google-Smtp-Source: AGHT+IE4mHTBCQd5jwfb7RyI5adE/fTB2xH8PZ6raek3p3kROd2NEo22HI7I/cqBf227auqY2yjygamE4KW+EmR2kA==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a5b:741:0:b0:d81:bb31:d2fa with SMTP
 id s1-20020a5b0741000000b00d81bb31d2famr96939ybq.3.1696536564013; Thu, 05 Oct
 2023 13:09:24 -0700 (PDT)
Date:   Thu, 05 Oct 2023 20:09:17 +0000
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAOwXH2UC/4WNSw7CIBRFt9K8sRigHz8j92EaQuiTvmjBACGah
 r2LdQEO7uDc3M8KEQNhhHOzQsBMkbyrIHcNmFk7i4ymyiC5bAXnHbOY1KLJpSoM6hdSd9YNWvK
 +R2n6E9T2M+CNXtvydaw8U0w+vLejLL7u/80smGDaHAxO4tjyQV+s9/aBe+MXGEspH8KI/nq/A AAA
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1696536562; l=6269;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=uTLqLBacy5qmuPeujaFq1E3oe1sLCIVcWlUEkOzKLbg=; b=pPxXME5xQ6C8IgpaF272pSf1N6m6vWtZggZZExr8kkG2YZYNsaPqIgKaH+IvwV8PHaya7h0sn
 /0ZEsXBA1OMCRcA6oK9YoIKqTfcPXmCZvr/H4B9Avozv6kVmBKfCcWY
X-Mailer: b4 0.12.3
Message-ID: <20231005-get_maintainer_change_k-v2-1-5f7febcfedb3@google.com>
Subject: [PATCH v2] get_maintainer: add --keywords-in-file
From:   Justin Stitt <justinstitt@google.com>
To:     Joe Perches <joe@perches.com>
Cc:     linux-kernel@vger.kernel.org, Justin Stitt <justinstitt@google.com>
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

There were some recent attempts [1] [2] to make the K: field less noisy
and its behavior more obvious. Ultimately, a shift in the default
behavior and an associated command line flag is the best choice.

Currently, K: will match keywords found in both patches and files.
Matching content from entire files is (while documented) not obvious
behavior and is usually not wanted by maintainers. This patch opts to
only allow patch content to be matched against unless --keywords-in-file
is provided.

Link: https://lore.kernel.org/all/20230928-get_maintainer_add_d-v2-0-8acb3f394571@google.com/ [1]
Link: https://lore.kernel.org/all/3dca40b677dd2fef979a5a581a2db91df2c21801.camel@perches.com/ [2]
Authored-by: Joe Perches <joe@perches.com>
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
Changes in v2:
- Use Joe's patch and ditch this one
- Link to v1: https://lore.kernel.org/r/20231004-get_maintainer_change_k-v1-1-ac7ced18306a@google.com
---
Note: I've opted to make this a v2 instead of a whole new patch since
it's related and the patch is authored in v1 by Joe. It will simply
replace the old patch in its entirety.
---
 scripts/get_maintainer.pl | 38 ++++++++++++++++++++------------------
 1 file changed, 20 insertions(+), 18 deletions(-)

diff --git a/scripts/get_maintainer.pl b/scripts/get_maintainer.pl
index ab123b498fd9..befae75e61ab 100755
--- a/scripts/get_maintainer.pl
+++ b/scripts/get_maintainer.pl
@@ -57,6 +57,7 @@ my $subsystem = 0;
 my $status = 0;
 my $letters = "";
 my $keywords = 1;
+my $keywords_in_file = 0;
 my $sections = 0;
 my $email_file_emails = 0;
 my $from_filename = 0;
@@ -272,6 +273,7 @@ if (!GetOptions(
 		'letters=s' => \$letters,
 		'pattern-depth=i' => \$pattern_depth,
 		'k|keywords!' => \$keywords,
+		'kf|keywords-in-file!' => \$keywords_in_file,
 		'sections!' => \$sections,
 		'fe|file-emails!' => \$email_file_emails,
 		'f|file' => \$from_filename,
@@ -318,6 +320,7 @@ if ($sections || $letters ne "") {
     $subsystem = 0;
     $web = 0;
     $keywords = 0;
+    $keywords_in_file = 0;
     $interactive = 0;
 } else {
     my $selections = $email + $scm + $status + $subsystem + $web;
@@ -548,16 +551,14 @@ foreach my $file (@ARGV) {
 	$file =~ s/^\Q${cur_path}\E//;	#strip any absolute path
 	$file =~ s/^\Q${lk_path}\E//;	#or the path to the lk tree
 	push(@files, $file);
-	if ($file ne "MAINTAINERS" && -f $file && $keywords) {
+	if ($file ne "MAINTAINERS" && -f $file && $keywords && $keywords_in_file) {
 	    open(my $f, '<', $file)
 		or die "$P: Can't open $file: $!\n";
 	    my $text = do { local($/) ; <$f> };
 	    close($f);
-	    if ($keywords) {
-		foreach my $line (keys %keyword_hash) {
-		    if ($text =~ m/$keyword_hash{$line}/x) {
-			push(@keyword_tvi, $line);
-		    }
+	    foreach my $line (keys %keyword_hash) {
+		if ($text =~ m/$keyword_hash{$line}/x) {
+		    push(@keyword_tvi, $line);
 		}
 	    }
 	}
@@ -919,7 +920,7 @@ sub get_maintainers {
 	}
 
 	foreach my $line (sort {$hash{$b} <=> $hash{$a}} keys %hash) {
-	    add_categories($line);
+	    add_categories($line, "");
 	    if ($sections) {
 		my $i;
 		my $start = find_starting_index($line);
@@ -947,7 +948,7 @@ sub get_maintainers {
     if ($keywords) {
 	@keyword_tvi = sort_and_uniq(@keyword_tvi);
 	foreach my $line (@keyword_tvi) {
-	    add_categories($line);
+	    add_categories($line, ":Keyword");
 	}
     }
 
@@ -1076,6 +1077,7 @@ Output type options:
 Other options:
   --pattern-depth => Number of pattern directory traversals (default: 0 (all))
   --keywords => scan patch for keywords (default: $keywords)
+  --keywords-in-file => scan file for keywords (default: $keywords_in_file)
   --sections => print all of the subsystem sections with pattern matches
   --letters => print all matching 'letter' types from all matching sections
   --mailmap => use .mailmap file (default: $email_use_mailmap)
@@ -1086,7 +1088,7 @@ Other options:
 
 Default options:
   [--email --tree --nogit --git-fallback --m --r --n --l --multiline
-   --pattern-depth=0 --remove-duplicates --rolestats]
+   --pattern-depth=0 --remove-duplicates --rolestats --keywords]
 
 Notes:
   Using "-f directory" may give unexpected results:
@@ -1312,7 +1314,7 @@ sub get_list_role {
 }
 
 sub add_categories {
-    my ($index) = @_;
+    my ($index, $suffix) = @_;
 
     my $i;
     my $start = find_starting_index($index);
@@ -1342,7 +1344,7 @@ sub add_categories {
 			if (!$hash_list_to{lc($list_address)}) {
 			    $hash_list_to{lc($list_address)} = 1;
 			    push(@list_to, [$list_address,
-					    "subscriber list${list_role}"]);
+					    "subscriber list${list_role}" . $suffix]);
 			}
 		    }
 		} else {
@@ -1352,12 +1354,12 @@ sub add_categories {
 				if ($email_moderated_list) {
 				    $hash_list_to{lc($list_address)} = 1;
 				    push(@list_to, [$list_address,
-						    "moderated list${list_role}"]);
+						    "moderated list${list_role}" . $suffix]);
 				}
 			    } else {
 				$hash_list_to{lc($list_address)} = 1;
 				push(@list_to, [$list_address,
-						"open list${list_role}"]);
+						"open list${list_role}" . $suffix]);
 			    }
 			}
 		    }
@@ -1365,19 +1367,19 @@ sub add_categories {
 	    } elsif ($ptype eq "M") {
 		if ($email_maintainer) {
 		    my $role = get_maintainer_role($i);
-		    push_email_addresses($pvalue, $role);
+		    push_email_addresses($pvalue, $role . $suffix);
 		}
 	    } elsif ($ptype eq "R") {
 		if ($email_reviewer) {
 		    my $subsystem = get_subsystem_name($i);
-		    push_email_addresses($pvalue, "reviewer:$subsystem");
+		    push_email_addresses($pvalue, "reviewer:$subsystem" . $suffix);
 		}
 	    } elsif ($ptype eq "T") {
-		push(@scm, $pvalue);
+		push(@scm, $pvalue . $suffix);
 	    } elsif ($ptype eq "W") {
-		push(@web, $pvalue);
+		push(@web, $pvalue . $suffix);
 	    } elsif ($ptype eq "S") {
-		push(@status, $pvalue);
+		push(@status, $pvalue . $suffix);
 	    }
 	}
     }

---
base-commit: cbf3a2cb156a2c911d8f38d8247814b4c07f49a2
change-id: 20231004-get_maintainer_change_k-46a2055e2c59

Best regards,
--
Justin Stitt <justinstitt@google.com>


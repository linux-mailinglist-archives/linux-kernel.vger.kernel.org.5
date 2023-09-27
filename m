Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DB3A7AF958
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 06:27:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229482AbjI0E1K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 00:27:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229663AbjI0EZ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 00:25:56 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABC981E97F
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 20:19:31 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-59e8ebc0376so194932087b3.2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 20:19:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695784771; x=1696389571; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=dyw5nVs/Tyo6Y3pNA9sKsXY24DP8vNfYIUrfBpfBjjQ=;
        b=SbWEWb8RSqkQzPAtFF9PIqFCx0EKEs0MMHwberG8U8TkdEH3JCItMEpp777vkVGF4t
         RhP+bsLXtXfOMnYO0A9o2RMksDkBuQYMUaKM+uQCX1aIm4bOf6+lbwl8TpADuY5cAr8f
         QEf3DW/54o6azSCYNNsv9jxLdXrk11vN5sFhzlp0HahP8L8dCHl15puWuRqDVDIH1TWf
         tKTvIyMxtcOincNlIOZ0CgcaRqSbjUv5bmUe33v87oxgk5fNbslVuTRDGz9KKIfQm2rI
         TeeICkKx2YxEUYtRKOGrtjXgJJLn3S7JU4bLjD7UdyVN2q3Z4/WsHXAbVDDMRLKcqky6
         bbxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695784771; x=1696389571;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dyw5nVs/Tyo6Y3pNA9sKsXY24DP8vNfYIUrfBpfBjjQ=;
        b=c0bgspcXZeR0KO586DOz7e5XwbqPDOmfIOBGcp16PE45l/8heiO/oh3dnLblbH+Lf4
         SLdhwFnqEpLDtK0WK+rJVsgQ7Fn+xDT4+BFU0IbiPNXgg4Nvw188t0OPzHy+8xeWP1V6
         8voJej6gMXcslxXzEcWUkE9QPdSHmrC6tvavKCHah/wkIoqQkPYSaIFY/Cb9h5+neR6l
         bDl+C4h/p5m2dqEGIbIjbHCvpOzwOAswZSkabxYUHfq76/C3uB9NeUTXes/be54PKuAj
         0fcgRv8YQ7O1Ynkp3gGCw7/KjgOeWbsgRCKUjqweluMSwn3Cps78f89AzRHH8cJOP8v+
         kc4Q==
X-Gm-Message-State: AOJu0Yx9lZIfT4S9kc/RRDgbRBbBIzoNjsLfUL7NFkZzWBQgV+QB37Ni
        opXOhEKIU+/DYymfrD6JkDGde+GeJzVMtBjDdQ==
X-Google-Smtp-Source: AGHT+IEGEo/O7VE1r16ztudiMkRH38IsAIribtuFttyLm5IVZpWkBr3/TPR/MRD256HZpEWT6hU73o87KNCZSmZBJA==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a81:af18:0:b0:562:837:122f with SMTP
 id n24-20020a81af18000000b005620837122fmr11387ywh.9.1695784770950; Tue, 26
 Sep 2023 20:19:30 -0700 (PDT)
Date:   Wed, 27 Sep 2023 03:19:16 +0000
In-Reply-To: <20230927-get_maintainer_add_d-v1-0-28c207229e72@google.com>
Mime-Version: 1.0
References: <20230927-get_maintainer_add_d-v1-0-28c207229e72@google.com>
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1695784766; l=2241;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=brnvnOlAf7Mom32eNFzX4SER9DsZxfr52jtHqIFd0Tc=; b=u+De8jqs3sCr0vhyWyIDMa9Ml2NRvLcM2ZDAdAeGGoVwGB79yVpiSaW5aHdTOgTI6GlvvkASV
 3K+rJxXSaWOBAhwuIIqONR0DnACTdy54dtzfFhlMF+kB/klgChvklV4
X-Mailer: b4 0.12.3
Message-ID: <20230927-get_maintainer_add_d-v1-3-28c207229e72@google.com>
Subject: [PATCH 3/3] get_maintainer: add patch-only pattern matching type
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

Note that folks really shouldn't be using get_maintainer on tree files
anyways [1].

[1]: https://lore.kernel.org/all/20230726151515.1650519-1-kuba@kernel.org/
---
 scripts/get_maintainer.pl | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/scripts/get_maintainer.pl b/scripts/get_maintainer.pl
index e679eac96793..f290bf0948f1 100755
--- a/scripts/get_maintainer.pl
+++ b/scripts/get_maintainer.pl
@@ -309,6 +309,7 @@ if ( $tree && !top_of_kernel_tree($lk_path) ) {
 
 my @typevalue = ();
 my %keyword_hash;
+my %patch_keyword_hash;
 my @mfiles         = ();
 my @self_test_info = ();
 
@@ -339,6 +340,9 @@ sub read_maintainer_file {
             elsif ( $type eq "K" ) {
                 $keyword_hash{@typevalue} = $value;
             }
+            elsif ( $type eq "D" ) {
+                $patch_keyword_hash{@typevalue} = $value;
+            }
             push( @typevalue, "$type:$value" );
         }
         elsif ( !( /^\s*$/ || /^\s*\#/ ) ) {
@@ -591,6 +595,11 @@ foreach my $file (@ARGV) {
                         push( @keyword_tvi, $line );
                     }
                 }
+                foreach my $line ( keys %patch_keyword_hash ) {
+                    if ($patch_line =~ m/${patch_prefix}$patch_keyword_hash{$line}/x ) {
+                        push( @keyword_tvi, $line );
+                    }
+                }
             }
         }
         close($patch);

-- 
2.42.0.582.g8ccd20d70d-goog


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B19077D2FDF
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 12:29:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230411AbjJWK3S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 06:29:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbjJWK3P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 06:29:15 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86362DE;
        Mon, 23 Oct 2023 03:29:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698056953; x=1729592953;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=UmqjVrYASSiI8y9GzFATTpUJpkA5uG3SLXCtcYS0Z+o=;
  b=NsHax1uPHF2UPqZzo0UQqPUz+cxDWELt7mYq7SLm2kWEb3ZmmTJ/VaJw
   tFjcIXoQjF8unrfQQpy1IGduQLcYZ9CNiil5MqcQvKbUgqx3o2BiwsI25
   hkX12L4VNY7uKK/KySOJ0eGC7Cq8/q+zdRaHsrYbpdig2sC7vsZvG9cUk
   JA7LLUHtRYP+B355Hkxb9QMzyfSd9hLCDi0aes9OPVnDrioQRoMjK9GZR
   qw8cvgGwek0h3X5QReh5r1NfnsBMP84zncVhj/Siig9XSKa+U4cLG3PZr
   JFfrt/4oov1hS5vZbHceKHU09N0v7V5e5oRsYiSrq5qkHeOogcY4QAj0c
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10871"; a="451030800"
X-IronPort-AV: E=Sophos;i="6.03,244,1694761200"; 
   d="scan'208";a="451030800"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2023 03:29:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10871"; a="734626960"
X-IronPort-AV: E=Sophos;i="6.03,244,1694761200"; 
   d="scan'208";a="734626960"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by orsmga006.jf.intel.com with ESMTP; 23 Oct 2023 03:29:09 -0700
Received: from pkitszel-desk.tendawifi.com (unknown [10.255.195.121])
        by irvmail002.ir.intel.com (Postfix) with ESMTP id AE6B53C42E;
        Mon, 23 Oct 2023 11:29:06 +0100 (IST)
From:   Przemek Kitszel <przemyslaw.kitszel@intel.com>
To:     Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Sean Christopherson <seanjc@google.com>,
        workflows@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org,
        Przemek Kitszel <przemyslaw.kitszel@intel.com>,
        Jacob Keller <jacob.e.keller@intel.com>
Subject: [PATCH] checkpatch: allow tags between co-developed-by and their sign-off
Date:   Mon, 23 Oct 2023 12:28:46 +0200
Message-Id: <20231023102846.14830-1-przemyslaw.kitszel@intel.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow additional tags between Co-developed-by: and Signed-off-by:.

Removing the "immediately" word from the doc is a great summary of the
change - there is no need for the two tags to be glued together, barring
ease of checkpatch implementation.

Additional tags between Co-developed-by and corresponding Signed-off-by
could include Reviewed-by tags collected by Submitter, which is also
a Co-developer, but should sign-off at the very end of tags provided by
the Submitter.

Two sets of perl %hashes introduced to keep both (int) line numbers and
(string) messages handy for warning reporting, while keeping it correct
across 100+ line long commit messages.

Mateusz Polchlopek <mateusz.polchlopek@intel.com> has reported this to me.

Bump severity of missing SoB to ERROR, while that piece of code needs
touch anyway.

changelog:
v2: update also the doc, slight reword of commitmsg,
    added workflows & doc MLs;

Links:
v1: https://lore.kernel.org/all/20231020132156.37882-1-przemyslaw.kitszel@intel.com

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
---
 Documentation/process/5.Posting.rst          |  2 +-
 Documentation/process/submitting-patches.rst |  6 ++--
 scripts/checkpatch.pl                        | 36 +++++++++++++-------
 3 files changed, 28 insertions(+), 16 deletions(-)

diff --git a/Documentation/process/5.Posting.rst b/Documentation/process/5.Posting.rst
index de4edd42d5c0..5dbc874de0f4 100644
--- a/Documentation/process/5.Posting.rst
+++ b/Documentation/process/5.Posting.rst
@@ -243,7 +243,7 @@ The tags in common use are:
  - Co-developed-by: states that the patch was co-created by several developers;
    it is a used to give attribution to co-authors (in addition to the author
    attributed by the From: tag) when multiple people work on a single patch.
-   Every Co-developed-by: must be immediately followed by a Signed-off-by: of
+   Every Co-developed-by: must be followed by a Signed-off-by: of
    the associated co-author.  Details and examples can be found in
    :ref:`Documentation/process/submitting-patches.rst <submittingpatches>`.
 
diff --git a/Documentation/process/submitting-patches.rst b/Documentation/process/submitting-patches.rst
index efac910e2659..f07521fdb287 100644
--- a/Documentation/process/submitting-patches.rst
+++ b/Documentation/process/submitting-patches.rst
@@ -489,7 +489,7 @@ have been included in the discussion.
 Co-developed-by: states that the patch was co-created by multiple developers;
 it is used to give attribution to co-authors (in addition to the author
 attributed by the From: tag) when several people work on a single patch.  Since
-Co-developed-by: denotes authorship, every Co-developed-by: must be immediately
+Co-developed-by: denotes authorship, every Co-developed-by: must be
 followed by a Signed-off-by: of the associated co-author.  Standard sign-off
 procedure applies, i.e. the ordering of Signed-off-by: tags should reflect the
 chronological history of the patch insofar as possible, regardless of whether
@@ -509,16 +509,18 @@ Example of a patch submitted by the From: author::
 	Signed-off-by: Second Co-Author <second@coauthor.example.org>
 	Signed-off-by: From Author <from@author.example.org>
 
-Example of a patch submitted by a Co-developed-by: author::
+Example of a patch submitted by a Co-developed-by: author, who also collected
+a Reviewed-by: tag posted for earlier version::
 
 	From: From Author <from@author.example.org>
 
 	<changelog>
 
 	Co-developed-by: Random Co-Author <random@coauthor.example.org>
 	Signed-off-by: Random Co-Author <random@coauthor.example.org>
 	Signed-off-by: From Author <from@author.example.org>
 	Co-developed-by: Submitting Co-Author <sub@coauthor.example.org>
+	Reviewed-by: Some Reviewer <srev@another.example.org>
 	Signed-off-by: Submitting Co-Author <sub@coauthor.example.org>
 
 
diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 7d16f863edf1..0400bf092bfa 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -2682,6 +2682,10 @@ sub process {
 	my $suppress_statement = 0;
 
 	my %signatures = ();
+	my %signoffs = ();
+	my %signoffs_msg = ();
+	my %codevs = ();
+	my %codevs_msg = ();
 
 	# Pre-scan the patch sanitizing the lines.
 	# Pre-scan the patch looking for any __setup documentation.
@@ -2967,11 +2971,13 @@ sub process {
 		if ($line =~ /^\s*signed-off-by:\s*(.*)/i) {
 			$signoff++;
 			$in_commit_log = 0;
+			my $ctx = $1;
+			$signoffs{$ctx} = $linenr;
+			$signoffs_msg{$ctx} = $herecurr;
 			if ($author ne ''  && $authorsignoff != 1) {
-				if (same_email_addresses($1, $author)) {
+				if (same_email_addresses($ctx, $author)) {
 					$authorsignoff = 1;
 				} else {
-					my $ctx = $1;
 					my ($email_name, $email_comment, $email_address, $comment1) = parse_email($ctx);
 					my ($author_name, $author_comment, $author_address, $comment2) = parse_email($author);
 
@@ -3158,22 +3164,15 @@ sub process {
 				$signatures{$sig_nospace} = 1;
 			}
 
-# Check Co-developed-by: immediately followed by Signed-off-by: with same name and email
+# Collect Co-developed-by: to check if each is backed up by Signed-off-by: with
+# the same name and email. Checks are made after main loop.
 			if ($sign_off =~ /^co-developed-by:$/i) {
 				if ($email eq $author) {
 					WARN("BAD_SIGN_OFF",
 					      "Co-developed-by: should not be used to attribute nominal patch author '$author'\n" . $herecurr);
 				}
-				if (!defined $lines[$linenr]) {
-					WARN("BAD_SIGN_OFF",
-					     "Co-developed-by: must be immediately followed by Signed-off-by:\n" . $herecurr);
-				} elsif ($rawlines[$linenr] !~ /^signed-off-by:\s*(.*)/i) {
-					WARN("BAD_SIGN_OFF",
-					     "Co-developed-by: must be immediately followed by Signed-off-by:\n" . $herecurr . $rawlines[$linenr] . "\n");
-				} elsif ($1 ne $email) {
-					WARN("BAD_SIGN_OFF",
-					     "Co-developed-by and Signed-off-by: name/email do not match\n" . $herecurr . $rawlines[$linenr] . "\n");
-				}
+				$codevs{$email} = $linenr;
+				$codevs_msg{$email} = $herecurr;
 			}
 
 # check if Reported-by: is followed by a Closes: tag
@@ -7712,6 +7711,17 @@ sub process {
 				     "From:/Signed-off-by: email subaddress mismatch: $sob_msg\n");
 			}
 		}
+		# check if each Co-developed-by tag is backed up by Sign-off,
+		# warn if Co-developed-by tag was put after a Signed-off-by tag
+		foreach my $codev (keys %codevs) {
+			if (!$signoffs{$codev}) {
+				ERROR("BAD_SIGN_OFF",
+				      "Co-developed-by: must be followed by Signed-off-by:\n" . $codevs_msg{$codev});
+			} elsif ($signoffs{$codev} <= $codevs{$codev}) {
+				WARN("BAD_SIGN_OFF",
+				     "Co-developed-by: must be followed by Signed-off-by:, but was placed after it\n" . $signoffs_msg{$codev} . $codevs_msg{$codev});
+			}
+		}
 	}
 
 	print report_dump();
-- 
2.38.1


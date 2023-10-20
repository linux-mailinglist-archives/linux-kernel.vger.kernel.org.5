Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07F687D106D
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 15:22:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377348AbjJTNWT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 09:22:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377121AbjJTNWS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 09:22:18 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 630971A4
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 06:22:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697808136; x=1729344136;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=lgFBsksrThg+LeGxqSd4+8oVFDLCpEtdibbHLoIWvaw=;
  b=ASAtGfs95i/MEDMyyfoNABuUBb+Gy7GB+3zPQ7/PZKxMIxTMc8wxZuzu
   sWBtTsqKEGG1NKAhO6NeOhWCx15DtsjN8XwCLPzNUOVg1rvn3lAeBgOjG
   9XDrZfZcI3CgR3FocCcR40IROXRm0NhHYcQyc8e9Pvh1dnxrvEAKL7lso
   nOmRZ8Q5RmDt8w2Z5PJWQwkfkSU1WYZ+UXCQxOvJARL0bATfzAI+H3xh2
   LjA9xOoFo95J9HDRKvupLvI1SguO8H4S2ujO1djd4CbLN+2BhDR1Sw9C4
   jRfQ0GhDKTGMiF5mHqEVlPaFzYDK0kiaCOkcZOvd/AiDv4MTKoqMo9Vcw
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10869"; a="452973477"
X-IronPort-AV: E=Sophos;i="6.03,239,1694761200"; 
   d="scan'208";a="452973477"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2023 06:22:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10869"; a="901137858"
X-IronPort-AV: E=Sophos;i="6.03,239,1694761200"; 
   d="scan'208";a="901137858"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by fmsmga001.fm.intel.com with ESMTP; 20 Oct 2023 06:20:03 -0700
Received: from pkitszel-desk.tendawifi.com (unknown [10.255.194.60])
        by irvmail002.ir.intel.com (Postfix) with ESMTP id 840AE2FC7B;
        Fri, 20 Oct 2023 14:22:10 +0100 (IST)
From:   Przemek Kitszel <przemyslaw.kitszel@intel.com>
To:     Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     Przemek Kitszel <przemyslaw.kitszel@intel.com>,
        Jacob Keller <jacob.e.keller@intel.com>
Subject: [PATCH] checkpatch: allow tags between co-developed-by and their sign-off
Date:   Fri, 20 Oct 2023 15:21:56 +0200
Message-Id: <20231020132156.37882-1-przemyslaw.kitszel@intel.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow additional tags between Co-developed-by: and Signed-off-by:.
Bump severity of missing SoB to ERROR.

Additional tags between Co-developed-by and corresponding Signed-off-by
could include Reviewed-by tags collected by Submitter, which is also
a Co-developer, but should sign-off at the very end of tags provided by
themself.

Missing SoB is promoted to error while that piece of code is touched.

Two sets of perl %hashes introduced to keep both (int) line numbers and
(string) messages handy for warning reporting, while keeping it correct
across 100+ line long commit messages.

Mateusz Polchlopek <mateusz.polchlopek@intel.com> has reported this to me.

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
---
 scripts/checkpatch.pl | 36 +++++++++++++++++++++++-------------
 1 file changed, 23 insertions(+), 13 deletions(-)

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


Return-Path: <linux-kernel+bounces-123497-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C939890988
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 20:44:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02132291627
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 19:44:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F100139591;
	Thu, 28 Mar 2024 19:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mff.cuni.cz header.i=@mff.cuni.cz header.b="Vwd+3EBA"
Received: from smtp1.ms.mff.cuni.cz (smtp-in1.ms.mff.cuni.cz [195.113.20.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C80F0137C3E;
	Thu, 28 Mar 2024 19:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.113.20.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711655078; cv=none; b=oOm38+3oJxHkKhjUnvnEo1MtKRzJEEJnDYSevpZhc1IAWIhLHHGZnDhsQsj5niA+Kf6eSDr786ZSt6nLI8Wix6kbMkoSNd+95Wc542cm3Hzij8M2KCQ4jtXEN6T6UcuzcU8NHPkw+kgUjk+2yUCZgr9mAw/iYOhgSSHRa61eMyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711655078; c=relaxed/simple;
	bh=K1GshZCfbLKa6QEHPkRv6RV6iSYP1FmBNTplfgXrwRg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YDLppYuYLn5zF+VjhEbGnlt9l40WeVtl6BexDIGN/hgyGQ2Xp+ZaoECxFpPEeIwhQTe7eP1luYQ9yXgyhsVcpDZCVE7j1UCXAYpztvofsYigHJ8Df86a7h2quN7hsqCLTpPcDsjLU98gOcSE9qm6RK7EE4CB8uZ7QW9WMEVsvsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=matfyz.cz; spf=pass smtp.mailfrom=matfyz.cz; dkim=pass (2048-bit key) header.d=mff.cuni.cz header.i=@mff.cuni.cz header.b=Vwd+3EBA; arc=none smtp.client-ip=195.113.20.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=matfyz.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=matfyz.cz
X-SubmittedBy: id balejk@matfyz.cz subject /postalCode=110+2000/O=Univerzita+20Karlova/street=Ovocn+5CxC3+5CxBD+20trh+20560/5/ST=Praha,+20Hlavn+5CxC3+5CxAD+20m+5CxC4+5Cx9Bsto/C=CZ/CN=Karel+20Balej/emailAddress=balejk@matfyz.cz
	serial F5FD910E8FE2121B897F7E55B84E351D
	issued by /C=NL/O=GEANT+20Vereniging/CN=GEANT+20Personal+20CA+204
	auth type TLS.CUNI
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mff.cuni.cz;
	s=submission; t=1711655063; x=1712955063;
	bh=SnM7FC2DV6SmTr/+TJk4/tBoa35oRJnbmKF8S0q/IRc=;
	h=From:MIME-Version;
	b=Vwd+3EBAZ/mDwrOKBWG9VDnVkViRYluHBIs7aYXObErJx4I2CJQVLPc9B18YIxVkr
	 2YrcA1FIM7oKmhM+c5dq5mVHqP0BZi0LGCdSGNY6kCQYEb4xDEUyI+3SsRpNH+eR7S
	 i65sP7wNSQE04pz8qfJKpPQcVlllyOR5huRqhV7W7x3jNypF+f8RpXJBu+guXyPlON
	 5ZbTxP+WgSAPa1Pg4YXaGlJxIJCJTD+flJRa/m7Gskh6ouSiaItJFPmBrDe7sn85f9
	 KKghS1Pg39RlqTgJNEfH28UbbIXNab6cTQSnBQsvqRmumo6Q6013AmNMoPgCN0I8eK
	 k6tpoprO7O+zg==
Received: from localhost (internet5.mraknet.com [185.200.108.250])
	(authenticated)
	by smtp1.ms.mff.cuni.cz (8.16.1/8.16.1) with ESMTPS id 42SJiLdV074688
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
	Thu, 28 Mar 2024 20:44:22 +0100 (CET)
	(envelope-from balejk@matfyz.cz)
From: Karel Balej <balejk@matfyz.cz>
To: Thorsten Leemhuis <linux@leemhuis.info>, Jonathan Corbet <corbet@lwn.net>,
        regressions@lists.linux.dev, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, workflows@vger.kernel.org
Cc: balejk@matfyz.cz
Subject: [PATCH 2/2] docs: handling-regressions.rst: clarify that "Closes:" tags work too
Date: Thu, 28 Mar 2024 20:29:16 +0100
Message-ID: <20240328194342.11760-3-balejk@matfyz.cz>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240328194342.11760-1-balejk@matfyz.cz>
References: <20240328194342.11760-1-balejk@matfyz.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The regressions handling manual claims that regzbot associates patches
fixing an issue with the report based on the occurrence of the
appropriate "Link:" trailers. It reasons that this does not add any
burden on the maintainers/bug fix authors as this is already mandated by
the "Submitting patches" guide. In fact however, the guide encourages
using "Link:" tags for related discussions or issues which the patch
fixes only partially, recommending "Closes:" for full resolutions.

Despite it not being mentioned anywhere in the "Handling regressions"
guide, regzbot does in fact take the "Closes:" tags into account and
seems to in fact treat them fully equivalently to "Link:" tags.

Clarify this in the regressions handling guide by always mentioning both
of the tags.

Signed-off-by: Karel Balej <balejk@matfyz.cz>
---
 .../process/handling-regressions.rst          | 30 ++++++++++---------
 1 file changed, 16 insertions(+), 14 deletions(-)

diff --git a/Documentation/process/handling-regressions.rst b/Documentation/process/handling-regressions.rst
index 49ba1410cfce..b9f8c8aa5936 100644
--- a/Documentation/process/handling-regressions.rst
+++ b/Documentation/process/handling-regressions.rst
@@ -40,9 +40,9 @@ The important bits (aka "The TL;DR")
        #regzbot from: Some N. Ice Human <some.human@example.com>
        #regzbot monitor: http://some.bugtracker.example.com/ticket?id=123456789
 
-#. When submitting fixes for regressions, add "Link:" tags to the patch
-   description pointing to all places where the issue was reported, as
-   mandated by Documentation/process/submitting-patches.rst and
+#. When submitting fixes for regressions, add "Closes:" (or "Link:") tags to
+   the patch description pointing to all places where the issue was reported,
+   as mandated by Documentation/process/submitting-patches.rst and
    :ref:`Documentation/process/5.Posting.rst <development_posting>`.
 
 #. Try to fix regressions quickly once the culprit has been identified; fixes
@@ -91,8 +91,8 @@ When doing either, consider making the Linux kernel regression tracking bot
    Note the caret (^) before the "introduced": it tells regzbot to treat the
    parent mail (the one you reply to) as the initial report for the regression
    you want to see tracked; that's important, as regzbot will later look out
-   for patches with "Link:" tags pointing to the report in the archives on
-   lore.kernel.org.
+   for patches with "Closes:" or "Link:" tags pointing to the report in the
+   archives on lore.kernel.org.
 
  * When forwarding a regressions reported to a bug tracker, include a paragraph
    with these regzbot commands::
@@ -102,7 +102,8 @@ When doing either, consider making the Linux kernel regression tracking bot
        #regzbot monitor: http://some.bugtracker.example.com/ticket?id=123456789
 
    Regzbot will then automatically associate patches with the report that
-   contain "Link:" tags pointing to your mail or the mentioned ticket.
+   contain "Closes:" or "Link:" tags pointing to your mail or the mentioned
+   ticket.
 
 What's important when fixing regressions
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
@@ -112,7 +113,8 @@ remember to do what Documentation/process/submitting-patches.rst,
 :ref:`Documentation/process/5.Posting.rst <development_posting>`, and
 Documentation/process/stable-kernel-rules.rst already explain in more detail:
 
- * Point to all places where the issue was reported using "Link:" tags::
+ * Point to all places where the issue was reported using "Closes:" or "Link:"
+   tags::
 
        Link: https://lore.kernel.org/r/30th.anniversary.repost@klaava.Helsinki.FI/
        Link: https://bugzilla.kernel.org/show_bug.cgi?id=1234567890
@@ -126,8 +128,8 @@ All this is expected from you and important when it comes to regression, as
 these tags are of great value for everyone (you included) that might be looking
 into the issue weeks, months, or years later. These tags are also crucial for
 tools and scripts used by other kernel developers or Linux distributions; one of
-these tools is regzbot, which heavily relies on the "Link:" tags to associate
-reports for regression with changes resolving them.
+these tools is regzbot, which heavily relies on the "Closes:" and "Link:" tags
+to associate reports for regression with changes resolving them.
 
 Expectations and best practices for fixing regressions
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
@@ -326,9 +328,9 @@ How does regression tracking work with regzbot?
 
 The bot watches for replies to reports of tracked regressions. Additionally,
 it's looking out for posted or committed patches referencing such reports
-with "Link:" tags; replies to such patch postings are tracked as well.
-Combined this data provides good insights into the current state of the fixing
-process.
+with "Closes:" or "Link:" tags; replies to such patch postings are tracked as
+well. Combined this data provides good insights into the current state of the
+fixing process.
 
 Regzbot tries to do its job with as little overhead as possible for both
 reporters and developers. In fact, only reporters are burdened with an extra
@@ -338,8 +340,8 @@ take care of that using ``#regzbot ^introduced``.
 
 For developers there normally is no extra work involved, they just need to make
 sure to do something that was expected long before regzbot came to light: add
-"Link:" tags to the patch description pointing to all reports about the issue
-fixed.
+"Closes:" (or "Link:") tags to the patch description pointing to all reports
+about the issue fixed.
 
 Do I have to use regzbot?
 ~~~~~~~~~~~~~~~~~~~~~~~~~
-- 
2.44.0



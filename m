Return-Path: <linux-kernel+bounces-123496-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C7CD890986
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 20:44:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF1FE1C27D20
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 19:44:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E7D813956B;
	Thu, 28 Mar 2024 19:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mff.cuni.cz header.i=@mff.cuni.cz header.b="NlEnnHSa"
Received: from smtp1.ms.mff.cuni.cz (smtp-in1.ms.mff.cuni.cz [195.113.20.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C8F3137C3A;
	Thu, 28 Mar 2024 19:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.113.20.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711655077; cv=none; b=GtI17ps3oAr10rN0UJe5M14WL2jZWJj3dJmLW0Xp8bKiFd+Dv8Pwb8q0xQIe0G8fZKVZwEYvY1QVgWPW40WAaYXDjcUsw9wy0WqTkfSDJyjiykGX2QU5lbRGxvTVzfLHIFabbUiqJs8F+1bxwJ4Ligd57YhFAV6Xruh775GIlOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711655077; c=relaxed/simple;
	bh=IMM7pX0S/20MBfDaEQqTmc8STQSMb9+1QvUdP+afCQ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ov73d7HGRmGR/pRJDTy1i6Rubt+ZQEQfl2rVcT80W3vRtioOeFU7paGkvPsQ0FJqvHCqa1MBP0hqJs9BsjtxjUz2RqvmQINzCjisZzOXdCC1b4PXv4IvQo3R1XOhoOy5n/OAOK4FsAVU0OANHWrg/XUGXTB3dHGl+LRoYaAJ/Ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=matfyz.cz; spf=pass smtp.mailfrom=matfyz.cz; dkim=pass (2048-bit key) header.d=mff.cuni.cz header.i=@mff.cuni.cz header.b=NlEnnHSa; arc=none smtp.client-ip=195.113.20.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=matfyz.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=matfyz.cz
X-SubmittedBy: id balejk@matfyz.cz subject /postalCode=110+2000/O=Univerzita+20Karlova/street=Ovocn+5CxC3+5CxBD+20trh+20560/5/ST=Praha,+20Hlavn+5CxC3+5CxAD+20m+5CxC4+5Cx9Bsto/C=CZ/CN=Karel+20Balej/emailAddress=balejk@matfyz.cz
	serial F5FD910E8FE2121B897F7E55B84E351D
	issued by /C=NL/O=GEANT+20Vereniging/CN=GEANT+20Personal+20CA+204
	auth type TLS.CUNI
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mff.cuni.cz;
	s=submission; t=1711655057; x=1712955057;
	bh=rmZ05qxyHXjpoz6a0NKYqZVQgD21CgPOcmsOzKDdabA=;
	h=From:MIME-Version;
	b=NlEnnHSaoZbHt/38e/oipS0Ag8oetT/F27ftdJLIg+rRtE2s7kHYSoxiTa5ArpT9B
	 npOInGtwiLlWdI4gf96Pr7LtacfBuGiJfJHs+hvx3ssJdXVyBATXJfnILke8DZGu5R
	 V7u86++VlIo+QpxFt4RAaavPiqy7rEfmCD86VtxB4JfbwrwwT5NrrK1eGAxrBZnw1N
	 Gp2mi085Tr/8/Q+HocPBOYMDo9wZPbEsI06DYev5VfkB3+auWXUBx5lRGKfPVNrRE3
	 7SKVoXc88sVrhqJ+AEaGS+JoKZTHWYa0fgxOEVb82BQxBOUpkApD3OcH7WHAwpysqI
	 Hu+l0uql5FpmQ==
Received: from localhost (internet5.mraknet.com [185.200.108.250])
	(authenticated)
	by smtp1.ms.mff.cuni.cz (8.16.1/8.16.1) with ESMTPS id 42SJiF3Q074680
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
	Thu, 28 Mar 2024 20:44:17 +0100 (CET)
	(envelope-from balejk@matfyz.cz)
From: Karel Balej <balejk@matfyz.cz>
To: Thorsten Leemhuis <linux@leemhuis.info>, Jonathan Corbet <corbet@lwn.net>,
        regressions@lists.linux.dev, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, workflows@vger.kernel.org
Cc: balejk@matfyz.cz
Subject: [PATCH 1/2] docs: *-regressions.rst: unify quoting, add missing word
Date: Thu, 28 Mar 2024 20:29:15 +0100
Message-ID: <20240328194342.11760-2-balejk@matfyz.cz>
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

Quoting of the '"no regressions" rule' expression differs between
occurrences, sometimes being presented as '"no regressions rule"'. Unify
the quoting using the first form which seems semantically correct or is
at least used dominantly, albeit marginally.

One of the occurrences is obviously missing the 'rule' part -- add it.

Signed-off-by: Karel Balej <balejk@matfyz.cz>
---
 Documentation/admin-guide/reporting-regressions.rst | 10 +++++-----
 Documentation/process/handling-regressions.rst      |  2 +-
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/Documentation/admin-guide/reporting-regressions.rst b/Documentation/admin-guide/reporting-regressions.rst
index 76b246ecf21b..946518355a2c 100644
--- a/Documentation/admin-guide/reporting-regressions.rst
+++ b/Documentation/admin-guide/reporting-regressions.rst
@@ -42,12 +42,12 @@ The important basics
 --------------------
 
 
-What is a "regression" and what is the "no regressions rule"?
+What is a "regression" and what is the "no regressions" rule?
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
 It's a regression if some application or practical use case running fine with
 one Linux kernel works worse or not at all with a newer version compiled using a
-similar configuration. The "no regressions rule" forbids this to take place; if
+similar configuration. The "no regressions" rule forbids this to take place; if
 it happens by accident, developers that caused it are expected to quickly fix
 the issue.
 
@@ -173,7 +173,7 @@ Additional details about regressions
 ------------------------------------
 
 
-What is the goal of the "no regressions rule"?
+What is the goal of the "no regressions" rule?
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
 Users should feel safe when updating kernel versions and not have to worry
@@ -199,8 +199,8 @@ Exceptions to this rule are extremely rare; in the past developers almost always
 turned out to be wrong when they assumed a particular situation was warranting
 an exception.
 
-Who ensures the "no regressions" is actually followed?
-~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+Who ensures the "no regressions" rule is actually followed?
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
 The subsystem maintainers should take care of that, which are watched and
 supported by the tree maintainers -- e.g. Linus Torvalds for mainline and
diff --git a/Documentation/process/handling-regressions.rst b/Documentation/process/handling-regressions.rst
index ce6753a674f3..49ba1410cfce 100644
--- a/Documentation/process/handling-regressions.rst
+++ b/Documentation/process/handling-regressions.rst
@@ -284,7 +284,7 @@ What else is there to known about regressions?
 Check out Documentation/admin-guide/reporting-regressions.rst, it covers a lot
 of other aspects you want might want to be aware of:
 
- * the purpose of the "no regressions rule"
+ * the purpose of the "no regressions" rule
 
  * what issues actually qualify as regression
 
-- 
2.44.0



Return-Path: <linux-kernel+bounces-136356-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2366589D318
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 09:32:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CEA971F23774
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 07:32:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E225F7E58C;
	Tue,  9 Apr 2024 07:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="PtPjQ1rS"
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 931E37BB1A;
	Tue,  9 Apr 2024 07:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712647858; cv=none; b=oHBRsCZ5JfNcjDKG1TTAi6CKNGONJ42+8NtgQ+uBLwvOmo16cEOIdYODl8F2dowq6wfIOpYT2iT8Si0pePSTIy+Wa8BV9I60aym19ZBVZTCeSCvfrRr/vlCPVUQ36hdjQxRtU6gTjBE2IF5GOaoIi35dfJKOWWcsxo4lwVtga5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712647858; c=relaxed/simple;
	bh=pE/Y96b4Lmsy+ebjj+zVv1h1X+yVjer7tDax3IgAqLI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JNRB5h9qjvclyul5KRj+cz7UPb3s+wbA994ZKl2hd2oaxO29Fqtre/4ALALzGn7xItiiVYwRy4jp6KWzNWkSN72LHIeN6sF86y8mwJl6vA+MPANFx0/Mma+LwI9U2MnwDQcKqhSZQRRHfHdBDBpNGGxc3ji17qxNHK2Tj8tQV4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=PtPjQ1rS; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:From:Sender:
	Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=mWeps612SQJGKPCMCZ4KyBqfdzQNYoeA60QuHY4EFvU=; t=1712647855;
	x=1713079855; b=PtPjQ1rSUV2a8BqdueeOhIn535xJFcQ9IPB9ylAfTj+iTWcCG4K2+256HX+NA
	OIuaJjtmV34gBHp4Xhll5MrJY0VOrdhvWsj22/Rd8AnM7MUHS4rlOm7HdZ23GXJyVPqdHhXtQDaeK
	X8XuuMltFvAXqAtTw0MYbnthTihyB5Jp8ZfuJGxNo4BbLc/M0AhuzM/WURLIFaE8B8m2jGU+Zucor
	rMmdPedAGKIJ7Ld2Fh+BGXKWUasixw6DqKGMzD39lKk9WeNamUT80FbgvA1/weUEJw88DAZ5Q5HiF
	WcVuXsPvnG3qc212h65CqOK39BG3PYZF3G5OWrwlqWe3Inyrjg==;
Received: from ip4d148da6.dynamic.kabel-deutschland.de ([77.20.141.166] helo=truhe.fritz.box); authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	id 1ru5wQ-0006Ld-Hl; Tue, 09 Apr 2024 09:30:50 +0200
From: Thorsten Leemhuis <linux@leemhuis.info>
To: Jonathan Corbet <corbet@lwn.net>
Cc: regressions@lists.linux.dev,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bagas Sanjaya <bagasdotme@gmail.com>,
	=?UTF-8?q?Petr=20Tesa=C5=99=C3=ADk?= <petr@tesarici.cz>
Subject: [PATCH v2 2/6] docs: verify/bisect: add and fetch stable branches ahead of time
Date: Tue,  9 Apr 2024 09:30:45 +0200
Message-ID: <57dcf312959476abe6151bf3d35eb79e3e9a83d1.1712647788.git.linux@leemhuis.info>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1712647788.git.linux@leemhuis.info>
References: <cover.1712647788.git.linux@leemhuis.info>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1712647855;18e5c630;
X-HE-SMSGID: 1ru5wQ-0006Ld-Hl

Add and fetch all required stable branches ahead of time. This fixes a
bug, as readers that wanted to bisect a regression within a stable or
longterm series otherwise did not have them available at the right time.
This way also matches the flow somewhat better and avoids some "if you
haven't already added it" phrases that otherwise become necessary in
future changes.

Signed-off-by: Thorsten Leemhuis <linux@leemhuis.info>
---
 .../verify-bugs-and-bisect-regressions.rst    | 31 +++++++++++--------
 1 file changed, 18 insertions(+), 13 deletions(-)

diff --git a/Documentation/admin-guide/verify-bugs-and-bisect-regressions.rst b/Documentation/admin-guide/verify-bugs-and-bisect-regressions.rst
index c999e40c79ab7f..06278501a4bdcc 100644
--- a/Documentation/admin-guide/verify-bugs-and-bisect-regressions.rst
+++ b/Documentation/admin-guide/verify-bugs-and-bisect-regressions.rst
@@ -136,8 +136,7 @@ will be considered the 'good' release and used to prepare the .config file.
 
 * **Segment 3**: perform and validate the bisection.
 
-  a) In case your 'broken' version is a stable/longterm release, add the Git
-     branch holding it::
+  a) Retrieve the sources for your 'bad' version::
 
        git remote set-branches --add stable linux-6.1.y
        git fetch stable
@@ -371,6 +370,21 @@ Preparations: set up everything to build your own kernels
 
   [:ref:`details<sources_bisref>`]
 
+.. _stablesources_bissbs:
+
+* Retrieve the sources for any stable or longterm series you might need.
+
+  Is the version you earlier established as 'bad' a stable or longterm release?
+  Then download the code for the series it belongs to ('linux-6.1.y' in this
+  example)::
+
+    git remote set-branches --add stable linux-6.1.y
+    git fetch stable
+
+  If the version earlier established as 'good' is from a different stable or
+  longterm series (say 6.0.13), repeat the previous step, but this time for the
+  branch holding the series the 'good' version belongs to (e.g. linux-6.0.y).
+
 .. _oldconfig_bissbs:
 
 * Start preparing a kernel build configuration (the '.config' file).
@@ -620,12 +634,10 @@ be a waste of time. [:ref:`details<introlatestcheck_bisref>`]
   reproduce it with the mainline kernel you just built? One that according to
   the `front page of kernel.org <https://kernel.org/>`_ is still supported? Then
   check if the latest codebase for the particular series might already fix the
-  problem. To do so, add the stable series Git branch for your 'good' kernel
-  (again, this here is assumed to be 6.0) and check out the latest version::
+  problem. To do so, check out that series latest version (again, this here is
+  assumed to be 6.0)::
 
     cd ~/linux/
-    git remote set-branches --add stable linux-6.0.y
-    git fetch stable
     git switch --discard-changes --detach linux-6.0.y
 
   Now use the checked out code to build and install another kernel using the
@@ -717,13 +729,6 @@ configuration created earlier this works a lot faster than many people assume:
 overall on average it will often just take about 10 to 15 minutes to compile
 each kernel on commodity x86 machines.
 
-* In case your 'bad' version is a stable/longterm release (say 6.1.5), add its
-  stable branch, unless you already did so earlier::
-
-    cd ~/linux/
-    git remote set-branches --add stable linux-6.1.y
-    git fetch stable
-
 .. _bisectstart_bissbs:
 
 * Start the bisection and tell Git about the versions earlier established as
-- 
2.44.0



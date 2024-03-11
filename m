Return-Path: <linux-kernel+bounces-98972-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 053A68781BE
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 15:37:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7A9AFB22084
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 14:37:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16244405F9;
	Mon, 11 Mar 2024 14:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="nDAAz8Ye"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBAC440BEB;
	Mon, 11 Mar 2024 14:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710167822; cv=none; b=qnuQWdv7df8zA2FFrYmDTjAJsf53qt/gSCDPsv1sP2A8pFcP7mAlyWsQAm5bRjCFyoJJrMbJxnBnvjv9P8bl9qnROogzWLNTHYTsC3A4f9egcgqVYBdyj6WizbVLLoObuuFmeUbDbtnFODAsyI8I8DdJzTK8+xaCIUkhF2VZizE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710167822; c=relaxed/simple;
	bh=UFPOecFc2L38drS5wrZlNteUKAczbKk6GzEv+wTUtq8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=M4AGEW8iV6GCgLVhutsP6Tm38Q/Vso3RrGCeQobQWk3d7ZfgRYBUFOxODuPAiSmEJB2zRC0wFcsO7k8bXq4x1BBZ00pU6xRpEen7Kqahuxa+oUB4vaFY11Zgj/kW24S5tA00O9CR5Z4kZ3YItd418GtXc4ZgNHtBAhDuxvDsxeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=nDAAz8Ye; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1710167819;
	bh=UFPOecFc2L38drS5wrZlNteUKAczbKk6GzEv+wTUtq8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=nDAAz8YedyJCCREMRW7vSAqh5u+uaWvdiU+5BCURN4w3BeAJD+plvc7iNbTBIInZh
	 I3Z7bUjOdze1xDT0QYRxE/6FmMMmUJq90ykgm0zN3YinOFASvVf9R3kABrYb1BA6aw
	 wg+NdiQOtxtPdwzeELXN1cX0uv3hUOqWmRdiRFP3dPTkzOoUszUkhSCzfL8C4/sNvF
	 hS3Tyzdokey5ixmrUrrYa1QawlIpcXIBBkR5uSQ0A6okX9UptG9gy0P+VHbZdFU9It
	 7LZNAZ8eVuQm4KDUMDknU5NB/eCRbqPEksybql3WjZMYKhRVT8PmIHXLfYA7eiIPES
	 5Rp+iDePewMZw==
Received: from [192.168.1.36] (zone.collabora.co.uk [167.235.23.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 4706D378201D;
	Mon, 11 Mar 2024 14:36:57 +0000 (UTC)
From: =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>
Date: Mon, 11 Mar 2024 10:36:15 -0400
Subject: [PATCH v2 1/2] docs: *-regressions.rst: Add colon to regzbot
 commands
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240311-regzbot-fixes-v2-1-98c1b6ec0678@collabora.com>
References: <20240311-regzbot-fixes-v2-0-98c1b6ec0678@collabora.com>
In-Reply-To: <20240311-regzbot-fixes-v2-0-98c1b6ec0678@collabora.com>
To: Thorsten Leemhuis <linux@leemhuis.info>, 
 Jonathan Corbet <corbet@lwn.net>
Cc: kernel@collabora.com, regressions@lists.linux.dev, 
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 workflows@vger.kernel.org, Chris Bainbridge <chris.bainbridge@gmail.com>, 
 =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>
X-Mailer: b4 0.13.0

Use colon as command terminator everywhere for consistency, even though
it's not strictly necessary. That way it will also match regzbot's
reference documentation.

Link: https://gitlab.com/knurd42/regzbot/-/blob/main/docs/reference.md
Reviewed-by: Thorsten Leemhuis <linux@leemhuis.info>
Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
---
 Documentation/admin-guide/reporting-regressions.rst |  2 +-
 Documentation/process/handling-regressions.rst      | 10 +++++-----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/Documentation/admin-guide/reporting-regressions.rst b/Documentation/admin-guide/reporting-regressions.rst
index d8adccdae23f..76b246ecf21b 100644
--- a/Documentation/admin-guide/reporting-regressions.rst
+++ b/Documentation/admin-guide/reporting-regressions.rst
@@ -31,7 +31,7 @@ The important bits (aka "TL;DR")
    Linux kernel regression tracking bot "regzbot" track the issue by specifying
    when the regression started like this::
 
-       #regzbot introduced v5.13..v5.14-rc1
+       #regzbot introduced: v5.13..v5.14-rc1
 
 
 All the details on Linux kernel regressions relevant for users
diff --git a/Documentation/process/handling-regressions.rst b/Documentation/process/handling-regressions.rst
index 5d3c3de3f4ec..42b13f77b019 100644
--- a/Documentation/process/handling-regressions.rst
+++ b/Documentation/process/handling-regressions.rst
@@ -27,11 +27,11 @@ The important bits (aka "The TL;DR")
    is optional, but recommended):
 
     * For mailed reports, check if the reporter included a line like ``#regzbot
-      introduced v5.13..v5.14-rc1``. If not, send a reply (with the regressions
+      introduced: v5.13..v5.14-rc1``. If not, send a reply (with the regressions
       list in CC) containing a paragraph like the following, which tells regzbot
       when the issue started to happen::
 
-       #regzbot ^introduced 1f2e3d4c5b6a
+       #regzbot ^introduced: 1f2e3d4c5b6a
 
     * When forwarding reports from a bug tracker to the regressions list (see
       above), include a paragraph like the following::
@@ -79,7 +79,7 @@ When doing either, consider making the Linux kernel regression tracking bot
 "regzbot" immediately start tracking the issue:
 
  * For mailed reports, check if the reporter included a "regzbot command" like
-   ``#regzbot introduced 1f2e3d4c5b6a``. If not, send a reply (with the
+   ``#regzbot introduced: 1f2e3d4c5b6a``. If not, send a reply (with the
    regressions list in CC) with a paragraph like the following:::
 
        #regzbot ^introduced: v5.13..v5.14-rc1
@@ -398,9 +398,9 @@ By using a 'regzbot command' in a direct or indirect reply to the mail with the
 regression report. These commands need to be in their own paragraph (IOW: they
 need to be separated from the rest of the mail using blank lines).
 
-One such command is ``#regzbot introduced <version or commit>``, which makes
+One such command is ``#regzbot introduced: <version or commit>``, which makes
 regzbot consider your mail as a regressions report added to the tracking, as
-already described above; ``#regzbot ^introduced <version or commit>`` is another
+already described above; ``#regzbot ^introduced: <version or commit>`` is another
 such command, which makes regzbot consider the parent mail as a report for a
 regression which it starts to track.
 

-- 
2.44.0



Return-Path: <linux-kernel+bounces-97144-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2364F876609
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 15:10:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B7F3D1F26AF2
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 14:10:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A0294C631;
	Fri,  8 Mar 2024 14:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="x5g/UUj+"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37D6340858;
	Fri,  8 Mar 2024 14:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709907017; cv=none; b=JANIjGoVETqEczkkE13ELPP4ThjIi5dStfWdF8cTyiyxzA+bMai/hZJUJwhAwpwD702eL9pZTfi9m29bvvR1F9IjtSjnBMOlkvIbTZOapEJvSdNoZtv1vwcjlmWJF78IjnbT8uazPTPi0iNs3qyGLmx0o2P5p5on/IAoCxA+3fE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709907017; c=relaxed/simple;
	bh=udrzgvrvmu967VyBoqxb4iOs9I00A7Sc5sCTWbiBLY0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tgW1h/oa0tWzD5FJ0RmW6Nww4kL3HCWyTa6NB/Eii0q2sSv0eOOtBMqKEt0/5RF3Ef8QyAA1NYhoPUjHYDIBdivLyY0rxyqApl0tLLqa3ACxYFhwj0lwII/gIlbUs280UU10DZQIAvwFxYgQsXgFj6bdR6jxycfKU3VsCXQxMxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=x5g/UUj+; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1709907014;
	bh=udrzgvrvmu967VyBoqxb4iOs9I00A7Sc5sCTWbiBLY0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=x5g/UUj+cUo/LIILHVPNpRT8KuDznCg0dsJtRZ87ULz8ajWYsDQttZ8oOfsBmleCE
	 KzU5tUByuNX/vKWEiyvCguCNtpK+3xD2KDgvP7NeUti5eESw6Btj73MZkl2E6y24RB
	 NkL7mlIkI04TPVUVHhbpRDR8wi0sBxFMuTMf3uPOzhaMYDeD+7YR2r047bl1vqJHTy
	 EPwKDaXYYyQwMnEv0t4LPEKHKn7Egd75nzO45na/atvna9f3DfmqPM9jrY/f8xlTVR
	 e9Zociw2sx7awWSLWDwCszhNCTnePsjfCiLSppQMP2MxI4Cd2qbWv1xcOConC60c+O
	 5zS+nfsfQwzNQ==
Received: from [192.168.1.13] (zone.collabora.co.uk [167.235.23.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id CD9B737820F2;
	Fri,  8 Mar 2024 14:10:12 +0000 (UTC)
From: =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>
Date: Fri, 08 Mar 2024 09:09:59 -0500
Subject: [PATCH 1/2] docs: *-regressions.rst: Use collon after regzbot
 introduced command
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240308-regzbot-fixes-v1-1-577a4fe16e12@collabora.com>
References: <20240308-regzbot-fixes-v1-0-577a4fe16e12@collabora.com>
In-Reply-To: <20240308-regzbot-fixes-v1-0-577a4fe16e12@collabora.com>
To: Thorsten Leemhuis <linux@leemhuis.info>, 
 Jonathan Corbet <corbet@lwn.net>
Cc: kernel@collabora.com, regressions@lists.linux.dev, 
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 workflows@vger.kernel.org, 
 =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>
X-Mailer: b4 0.13.0

All the examples in the reference documentation for regzbot have a
collon after the "introduced" command, while on the kernel documentation
some have and others don't. This suggests both are acceptable, but in
order to avoid confusion, add collons after all the commands to match
the reference docs.

Link: https://gitlab.com/knurd42/regzbot/-/blob/main/docs/reference.md
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



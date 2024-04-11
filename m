Return-Path: <linux-kernel+bounces-139781-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 302D48A07A6
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 07:25:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D9B631F26817
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 05:25:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C54B213C8F0;
	Thu, 11 Apr 2024 05:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="j8mGbOpn"
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F048313C806;
	Thu, 11 Apr 2024 05:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712813114; cv=none; b=UeEZ6ErQW9rSKbpyR+O4Id8p7aPgrTv/IYQD8WOepQK2WnmGvZ5Nr9lBvMJpbJVIrhfPTPoyfph7yLYDPLGubgmmORhhKJAPNsRiXMxjycGob37x7CmODuclYTm7teb/ZSTlGOUAbxidLV1Z7km24SvoSL5c1PnHi/4KF+9ze14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712813114; c=relaxed/simple;
	bh=04+mK6HKoT8RZ0P6doMsa/v6ffRcXjtHwC7347AJ/Vo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LnQ7a+J2ZL6IHEuihsC7rWXsnIao/7Iw6kCa4i/wDghvBg2vgBGbsB4qRuAIKj9mTy7EAe7iDHGelUw0hI+2/7nAKC9C1rYD/HM/eND2ikUs+r3LZxOuXHOabjK0whiCdApM+YLQlvjENmxCuMAdkfNKvdosh7f5O2arBn8m+OQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=j8mGbOpn; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:From:Sender:
	Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=nUsTnawfVlx4CUiM4HRUc248jICa8eEQVZBkmyx2shk=; t=1712813112;
	x=1713245112; b=j8mGbOpnv7XLtsQq5ozX0f1dLZI7s6z9t/xwjWbgGUvNzKHUY//dW1HAHil4G
	cBsrfWDdmVL8tjSI2XkFxU/Kqc3Rg9vtRRwd21tT+AnVr5fbRTpjNlLqsT5U7ohm0cZFm0GzBo4/v
	yYbr5LzPBaTDb6Ri6NlqbvDjVgg6+B87mkxhIWIixy3NN+Z0SlUcs6pnC80Qc2e2YPIU6m12ZgQj0
	j2CQRIQ/JOmss8lZ8y3/4HdXOToR9tnH9alZGCpqlNZvsBY2766RqYVgqb9Jn+961iHiWAf2fR2wa
	sCnqJ1AZPIboFb2Yi0g6w1l2Hfu4S32fKqUJBBXgqL6zgt8lCg==;
Received: from ip4d148da6.dynamic.kabel-deutschland.de ([77.20.141.166] helo=truhe.fritz.box); authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	id 1rumvr-0000rh-V2; Thu, 11 Apr 2024 07:25:08 +0200
From: Thorsten Leemhuis <linux@leemhuis.info>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>,
	stable@vger.kernel.org,
	workflows@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 4/4] docs: stable-kernel-rules: remove code-labels tags
Date: Thu, 11 Apr 2024 07:25:06 +0200
Message-ID: <82e9304d61a1ebebfabfae86b386d2547a8479ab.1712812895.git.linux@leemhuis.info>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1712812895.git.linux@leemhuis.info>
References: <cover.1712812895.git.linux@leemhuis.info>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1712813112;8245af4a;
X-HE-SMSGID: 1rumvr-0000rh-V2

Remove the 'code-block:: none' labels and switch to the shorter '::' to
reduce noise.

CC: Jonathan Corbet <corbet@lwn.net>
Signed-off-by: Thorsten Leemhuis <linux@leemhuis.info>
---
Intentionally the last patch in the series to make it easy to skip in
case Jonathan or someone else points out there is a reason for these
tags.
---
 Documentation/process/stable-kernel-rules.rst | 37 +++++--------------
 1 file changed, 10 insertions(+), 27 deletions(-)

diff --git a/Documentation/process/stable-kernel-rules.rst b/Documentation/process/stable-kernel-rules.rst
index 3c05f39858c78a..0ae38472bb688c 100644
--- a/Documentation/process/stable-kernel-rules.rst
+++ b/Documentation/process/stable-kernel-rules.rst
@@ -68,22 +68,17 @@ Option 1
 ********
 
 To have a patch you submit for mainline inclusion later automatically picked up
-for stable trees, add the tag
-
-.. code-block:: none
+for stable trees, add this tag in the sign-off area::
 
      Cc: stable@vger.kernel.org
 
-in the sign-off area. Once the patch is mainlined it will be applied to the
-stable tree without anything else needing to be done by the author or
-subsystem maintainer.
+Once the patch is mainlined it will be applied to the stable tree without
+anything else needing to be done by the author or subsystem maintainer.
 
 To sent additional instructions to the stable team, use a shell-style inline
 comment to pass arbitrary or predefined notes:
 
- * Specify any additional patch prerequisites for cherry picking:
-
-   .. code-block:: none
+ * Specify any additional patch prerequisites for cherry picking::
 
      Cc: <stable@vger.kernel.org> # 3.3.x: a1f84a3: sched: Check for idle
      Cc: <stable@vger.kernel.org> # 3.3.x: 1b9508f: sched: Rate-limit newidle
@@ -91,24 +86,18 @@ comment to pass arbitrary or predefined notes:
      Cc: <stable@vger.kernel.org> # 3.3.x
      Signed-off-by: Ingo Molnar <mingo@elte.hu>
 
-   The tag sequence has the meaning of:
-
-   .. code-block:: none
+   The tag sequence has the meaning of::
 
      git cherry-pick a1f84a3
      git cherry-pick 1b9508f
      git cherry-pick fd21073
      git cherry-pick <this commit>
 
- * Point out kernel version prerequisites:
-
-   .. code-block:: none
+ * Point out kernel version prerequisites::
 
      Cc: <stable@vger.kernel.org> # 3.3.x
 
-   The tag has the meaning of:
-
-   .. code-block:: none
+   The tag has the meaning of::
 
      git cherry-pick <this commit>
 
@@ -129,9 +118,7 @@ comment to pass arbitrary or predefined notes:
 
      Cc: <stable@vger.kernel.org> # after 6 weeks in a stable mainline release
 
- * Point out known problems:
-
-   .. code-block:: none
+ * Point out known problems::
 
      Cc: <stable@vger.kernel.org> # see patch description, needs adjustments for <= 6.3
 
@@ -153,15 +140,11 @@ Option 3
 Send the patch, after verifying that it follows the above rules, to
 stable@vger.kernel.org and mention the kernel versions you wish it to be applied
 to. When doing so, you must note the upstream commit ID in the changelog of your
-submission with a separate line above the commit text, like this:
-
-.. code-block:: none
+submission with a separate line above the commit text, like this::
 
     commit <sha1> upstream.
 
-or alternatively:
-
-.. code-block:: none
+Or alternatively::
 
     [ Upstream commit <sha1> ]
 
-- 
2.44.0



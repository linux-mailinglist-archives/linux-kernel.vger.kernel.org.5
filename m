Return-Path: <linux-kernel+bounces-120804-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A60B88DDD3
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 13:11:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC70628EAE7
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 12:11:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 807D213118B;
	Wed, 27 Mar 2024 12:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JcwMLm96"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA332130E38;
	Wed, 27 Mar 2024 12:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711541249; cv=none; b=jr2U6Pdgtoqx9xsMMZ0hfbscPwRYaBfpcOYcY2ei0iV1H2QNnglbGLYLKvJr/PcvUClGLJpp1keJdY68Kn65EEqm+wIs9N4pW1eA2PZiS0Wni3YRTHAkQYC8jbhckOtM5pOz6WGfGzHkCGu6dBv/PGHLLl8TnvnNQkzmmVPbJmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711541249; c=relaxed/simple;
	bh=i7c1+qba0ObGp6CT2p/tivHqp96gllnbdFSkQpkJ02Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Vl4avIi7ZZGPwmYqqaiTbP459bXZtcghLQqfak5zbRF3QoLdDhSGKmKgudehOdEe1Q+dShAi/zQHzZbaHE4B7p92Df0ED+0DeLnUsCjbfgwDgsF2TixNS+RHJqpm5hCv0e6UQVE7qh3jV/vaqjw8rGcfl0ddI4xgbRpmzF68nHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JcwMLm96; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91816C433F1;
	Wed, 27 Mar 2024 12:07:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711541249;
	bh=i7c1+qba0ObGp6CT2p/tivHqp96gllnbdFSkQpkJ02Q=;
	h=From:To:Cc:Subject:Date:From;
	b=JcwMLm96wNEsZKZRa7ZzeMiygmTVehM5U//BGH7GexHljaKYovHQfBINTlgj2Awvd
	 FLfS9zRZbRI2s83owEqg5hzXZfOVHjrtnPgBjfDN2QyPn7yjtsM7APzX8TkSwVZ46S
	 khmKqtXzjXr/Eyi9go17WQomiXnDx8uyq3ADHj5cuM3VcK6oknvmwb5784TYRpejKz
	 WJ7apsjyP07zpplQZBz5jQ8XVJOIDGVI3iEFqKxo1t3sHSl5kqRvu98lSoK4qj234b
	 Cnb0/AV1MilzYCT39deJZAf2M5OOr/06yJVPtXP+LgqaVTSDqcMMOdJ+eRqhjvt+RN
	 PNgOAv/o3iRbA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	vegard.nossum@oracle.com
Cc: Justin Forbes <jforbes@fedoraproject.org>,
	Salvatore Bonaccorso <carnil@debian.org>,
	Jani Nikula <jani.nikula@intel.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: FAILED: Patch "docs: kernel_feat.py: fix build error for missing files" failed to apply to 6.8-stable tree
Date: Wed, 27 Mar 2024 08:07:27 -0400
Message-ID: <20240327120727.2825435-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: ignore
X-stable: review
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 6.8-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 983e20cfdcb6e08b3560071a147169f3a1be4391 Mon Sep 17 00:00:00 2001
From: Vegard Nossum <vegard.nossum@oracle.com>
Date: Mon, 5 Feb 2024 18:51:26 +0100
Subject: [PATCH] docs: kernel_feat.py: fix build error for missing files

If the directory passed to the '.. kernel-feat::' directive does not
exist or the get_feat.pl script does not find any files to extract
features from, Sphinx will report the following error:

    Sphinx parallel build error:
    UnboundLocalError: local variable 'fname' referenced before assignment
    make[2]: *** [Documentation/Makefile:102: htmldocs] Error 2

This is due to how I changed the script in c48a7c44a1d0 ("docs:
kernel_feat.py: fix potential command injection"). Before that, the
filename passed along to self.nestedParse() in this case was weirdly
just the whole get_feat.pl invocation.

We can fix it by doing what kernel_abi.py does -- just pass
self.arguments[0] as 'fname'.

Fixes: c48a7c44a1d0 ("docs: kernel_feat.py: fix potential command injection")
Cc: Justin Forbes <jforbes@fedoraproject.org>
Cc: Salvatore Bonaccorso <carnil@debian.org>
Cc: Jani Nikula <jani.nikula@intel.com>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: stable@vger.kernel.org
Signed-off-by: Vegard Nossum <vegard.nossum@oracle.com>
Link: https://lore.kernel.org/r/20240205175133.774271-2-vegard.nossum@oracle.com
Signed-off-by: Jonathan Corbet <corbet@lwn.net>
---
 Documentation/sphinx/kernel_feat.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/sphinx/kernel_feat.py b/Documentation/sphinx/kernel_feat.py
index b9df61eb45013..03ace5f01b5c0 100644
--- a/Documentation/sphinx/kernel_feat.py
+++ b/Documentation/sphinx/kernel_feat.py
@@ -109,7 +109,7 @@ class KernelFeat(Directive):
             else:
                 out_lines += line + "\n"
 
-        nodeList = self.nestedParse(out_lines, fname)
+        nodeList = self.nestedParse(out_lines, self.arguments[0])
         return nodeList
 
     def nestedParse(self, lines, fname):
-- 
2.43.0






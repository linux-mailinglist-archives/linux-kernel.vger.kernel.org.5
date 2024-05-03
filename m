Return-Path: <linux-kernel+bounces-168002-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 71D7C8BB216
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 20:05:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6BC261C219EF
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 18:05:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6147E158DAA;
	Fri,  3 May 2024 18:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RNaMciG4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97F07158D7B;
	Fri,  3 May 2024 18:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714759407; cv=none; b=W5AOToa9PYu/SoXz2csa2EsJzvRjRokvaJqv30naTXS5yGWhNHSX77m3eSDC640XI4Ax2PA6ASAWo1XDXGN7qvIvRf3K4UMagL8/fUtfRJ+Z6TBMPGh7Wb2iXKT+WPU3qWdbEZzGQEJplwu2iViclbTZ2fi8mjaY07AkuZkuOIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714759407; c=relaxed/simple;
	bh=KPWNhDHoK1WCiSSpG+hqPSsIhkDFJ5Gj7faBmjSb9kA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hOzSEVzkDcYiT1nb6Ew0MrQf5hC1ju1lc+UHyoodixdBmpcd+sbjyhadfj20ewiOFIRYYJxBukhBqCMbYb9r6bMJfwsx0dekJwX/zNw24ty9ecaOYjG7phbbFJvkB1Ps1EDjBsMxhb8/sPXZ4nA3omq2XGIE1NdSLdYwwQL4Lag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RNaMciG4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A14E9C4AF18;
	Fri,  3 May 2024 18:03:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714759407;
	bh=KPWNhDHoK1WCiSSpG+hqPSsIhkDFJ5Gj7faBmjSb9kA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RNaMciG4+Dgw2+9RRQO/lsyLSTD1cz1ayVlCpEn3dwnyprRbglpLy1lfTg7rGhZ4j
	 bSM9JZFtnPhK9QxYb3PnrI0Ry8Tq6wJyWtpu+oLasQN27ysClArNLObWsQVzWWSidn
	 Lp5HshD0xLuIeOqjMDAkwyoiCc1WOm2bRIekRbJN8awSmkciQlznyYd0PHIGV6Ud4z
	 LwWIFN2MQq4Ff2wfvdUT3xD/J5oBoP7ffRBCV/EApv/tW9s2Wd1jmp8m4nSkSI61Fm
	 RW5ugV8nhg5yAGArxE5dolr6yhf3PI12Mu5zxXfU2NMW4moeZPisjWtm2X1J7nfIEo
	 M5vX5WxitzZSg==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 07/10] Docs/admin-guide/mm/damon/usage: fix wrong schemes effective quota update command
Date: Fri,  3 May 2024 11:03:15 -0700
Message-Id: <20240503180318.72798-8-sj@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240503180318.72798-1-sj@kernel.org>
References: <20240503180318.72798-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To update effective size quota of DAMOS schemes on DAMON sysfs file
interface, user should write 'update_schemes_effective_quotas' to the
kdamond 'state' file.  But the document is mistakenly saying the input
string as 'update_schemes_effective_bytes'.  Fix it (s/bytes/quotas/).

Fixes: a6068d6dfa2f ("Docs/admin-guide/mm/damon/usage: document effective_bytes file")
Cc: <stable@vger.kernel.org> # 6.9.x
Signed-off-by: SeongJae Park <sj@kernel.org>
---
 Documentation/admin-guide/mm/damon/usage.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/mm/damon/usage.rst b/Documentation/admin-guide/mm/damon/usage.rst
index 3ce3f0aaa1d5..e58ceb89ea2a 100644
--- a/Documentation/admin-guide/mm/damon/usage.rst
+++ b/Documentation/admin-guide/mm/damon/usage.rst
@@ -153,7 +153,7 @@ Users can write below commands for the kdamond to the ``state`` file.
 - ``clear_schemes_tried_regions``: Clear the DAMON-based operating scheme
   action tried regions directory for each DAMON-based operation scheme of the
   kdamond.
-- ``update_schemes_effective_bytes``: Update the contents of
+- ``update_schemes_effective_quotas``: Update the contents of
   ``effective_bytes`` files for each DAMON-based operation scheme of the
   kdamond.  For more details, refer to :ref:`quotas directory <sysfs_quotas>`.
 
@@ -342,7 +342,7 @@ Based on the user-specified :ref:`goal <sysfs_schemes_quota_goals>`, the
 effective size quota is further adjusted.  Reading ``effective_bytes`` returns
 the current effective size quota.  The file is not updated in real time, so
 users should ask DAMON sysfs interface to update the content of the file for
-the stats by writing a special keyword, ``update_schemes_effective_bytes`` to
+the stats by writing a special keyword, ``update_schemes_effective_quotas`` to
 the relevant ``kdamonds/<N>/state`` file.
 
 Under ``weights`` directory, three files (``sz_permil``,
-- 
2.39.2



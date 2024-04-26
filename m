Return-Path: <linux-kernel+bounces-160639-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73A698B4081
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 21:54:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5E9E1C228CB
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 19:54:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E50237707;
	Fri, 26 Apr 2024 19:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DSFNDYcZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DD8C3613E;
	Fri, 26 Apr 2024 19:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714161184; cv=none; b=hUQl87jsTzzsh9i2CyCf50VKnDOYpLnTj15ZG/pduc8WaQEgXZNlXeTT2i4UjPl/xSwk170WW/vN/Tq974jVJa3soCi333gjZu2PJ1zEgU2SiDl+25+rr8+OOdFWUGcHjKUo1HOSRhC0gS3p97cWSzq/jX8HHLyd7SACQ9ibCBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714161184; c=relaxed/simple;
	bh=K2q9FissW13tAkvxEMeW2S5JbkJ5qv3UfNIiwo/yV/I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ffCI8aT8qx6P5Xqmp5lG0vnru2ZvlSI3UXabwvuYUzxsEs6oEou6AsVQzOms3RUYODxZEA1DXAQvFCiKg4dOmLaXSvaATAQkszBCAJq6pQtcXoWZmHor3HIwQCVSuZP9sipDxPU+gyiGz41/3/sUazQKwY+dfNgXfaVCzLI5VdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DSFNDYcZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3142C2BD10;
	Fri, 26 Apr 2024 19:53:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714161184;
	bh=K2q9FissW13tAkvxEMeW2S5JbkJ5qv3UfNIiwo/yV/I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DSFNDYcZ5ydHl9BLQEPGlilvTLW2NF0PHASHNaeYYzH/IQkb7TIhayU7DHFGXKWuq
	 yDnjWbS6g5F/zwAj2dSG84H1DBt9ceqztSEcropReTs4M7kuxPV9TThRzeKu/JuD0U
	 h2gjAkllDCJQSEr4OWpX16oU+h/cobOIqx/kvuZr/ZPvqRxLsdDz1TWq58Y1uSjTdB
	 KG2/YRUz3XFQ2lUMj8D4sUDlvXOvo0ZwJYL+Zh8slDqm6FtGDbhgNPxTbZ/CqoMjY7
	 4C07ybL+Udwe/39rogZpBtUgPe9/Cefr/RZWfqMfcHwYR7QnGWrNRTLKkjCC5eUayp
	 wgHoLmDGbo8Nw==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 6/7] Docs/admin-guide/mm/damon/usage: update for young page type DAMOS filter
Date: Fri, 26 Apr 2024 12:52:45 -0700
Message-Id: <20240426195247.100306-7-sj@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240426195247.100306-1-sj@kernel.org>
References: <20240426195247.100306-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update DAMON usage document for the newly added DAMOS filter type,
'young page'.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 Documentation/admin-guide/mm/damon/usage.rst | 26 ++++++++++----------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/Documentation/admin-guide/mm/damon/usage.rst b/Documentation/admin-guide/mm/damon/usage.rst
index 6fce035fdbf5c..69bc8fabf3781 100644
--- a/Documentation/admin-guide/mm/damon/usage.rst
+++ b/Documentation/admin-guide/mm/damon/usage.rst
@@ -410,19 +410,19 @@ in the numeric order.
 
 Each filter directory contains six files, namely ``type``, ``matcing``,
 ``memcg_path``, ``addr_start``, ``addr_end``, and ``target_idx``.  To ``type``
-file, you can write one of four special keywords: ``anon`` for anonymous pages,
-``memcg`` for specific memory cgroup, ``addr`` for specific address range (an
-open-ended interval), or ``target`` for specific DAMON monitoring target
-filtering.  In case of the memory cgroup filtering, you can specify the memory
-cgroup of the interest by writing the path of the memory cgroup from the
-cgroups mount point to ``memcg_path`` file.  In case of the address range
-filtering, you can specify the start and end address of the range to
-``addr_start`` and ``addr_end`` files, respectively.  For the DAMON monitoring
-target filtering, you can specify the index of the target between the list of
-the DAMON context's monitoring targets list to ``target_idx`` file.  You can
-write ``Y`` or ``N`` to ``matching`` file to filter out pages that does or does
-not match to the type, respectively.  Then, the scheme's action will not be
-applied to the pages that specified to be filtered out.
+file, you can write one of five special keywords: ``anon`` for anonymous pages,
+``memcg`` for specific memory cgroup, ``young`` for young pages, ``addr`` for
+specific address range (an open-ended interval), or ``target`` for specific
+DAMON monitoring target filtering.  In case of the memory cgroup filtering, you
+can specify the memory cgroup of the interest by writing the path of the memory
+cgroup from the cgroups mount point to ``memcg_path`` file.  In case of the
+address range filtering, you can specify the start and end address of the range
+to ``addr_start`` and ``addr_end`` files, respectively.  For the DAMON
+monitoring target filtering, you can specify the index of the target between
+the list of the DAMON context's monitoring targets list to ``target_idx`` file.
+You can write ``Y`` or ``N`` to ``matching`` file to filter out pages that does
+or does not match to the type, respectively.  Then, the scheme's action will
+not be applied to the pages that specified to be filtered out.
 
 For example, below restricts a DAMOS action to be applied to only non-anonymous
 pages of all memory cgroups except ``/having_care_already``.::
-- 
2.39.2



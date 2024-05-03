Return-Path: <linux-kernel+bounces-168005-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 75AC58BB21C
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 20:05:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0DA2D1F230AA
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 18:05:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92376159213;
	Fri,  3 May 2024 18:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MpCAjq/P"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA9E41591ED;
	Fri,  3 May 2024 18:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714759409; cv=none; b=UeUEzfaCihg0KkujZtn3NI4XEjYueWlKpr1E0bXpx3PVe35aBNVufMm+TWSBL7cMAp91YHNPulwZJjpjf6g/+Zb9MyvYnzgiGRwHYwZPSI+pheXHAH2Ebb0JGIQ5Gkjlvg+FCplOUQan9jd2YFZgbz57uFAnaovy9fXaUs4gpcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714759409; c=relaxed/simple;
	bh=a02Zh+VsvTrK6WKXPgaeuspiXlSro+oRgLJGLtu2svs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AXbD8W5l2Aga47ow1plg5V0kijHX6KuTj1/WfYWx9EpPyZPBEcdvqmC36C3keyahWLSgZlqkJuGdPnIXW8CpxswO8lx8V6H+kV+4NO0bDVgFCF+2Jf8/Ye6+RWFbFD6xG10zDJnCvQXvl3m19YYqkuYVbdx9/XSaU5eXjhYPZTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MpCAjq/P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D96B5C4AF50;
	Fri,  3 May 2024 18:03:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714759409;
	bh=a02Zh+VsvTrK6WKXPgaeuspiXlSro+oRgLJGLtu2svs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MpCAjq/PwjGAnPgFL65cPmH9OKC2XvO5cfrU8CelwHa2IjOGwUR0spNoneoQ+JHve
	 ZgAe/EcGmV3QJyTq7sRJvcm8P2lyZIS8GBZmaKK3gefvVc8Isf5nGB7VqWBWT5rQcm
	 qMgn/KlZTV8pXq45eCEn1+waj4K/7iJwm7zKZ9Ap36o/OUKs0+rnoBrw10EFWI6kRO
	 4RwdQluz00sczmBT4/baD9TMPZvHAm786k1iPaJSNeYuiMTTGeFCn+nYOaWhQKV+SG
	 H8ijK9qv6VG1m2OaOebzIHIAH93JhcP6CiPt2596d0bRT6b8/msyRk7yaZ43MSEOLz
	 NYCe7Utr+bpzA==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 10/10] Docs/mm/damon/maintainer-profile: allow posting patches based on damon/next tree
Date: Fri,  3 May 2024 11:03:18 -0700
Message-Id: <20240503180318.72798-11-sj@kernel.org>
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

The document mentions any patches for review should based on mm-unstable
instead of damon/next.  It should be the recommended process, but
sometimes patches based on damon/next could be posted for some reasons.
Actually, the DAMON-based tiered memory management patchset[1] was
written on top of 'young page' DAMOS filter patchset, which was in
damon/next tree as of the writing.

Allow such case and just ask such things to be clearly specified.

[1] https://lore.kernel.org/20240405060858.2818-1-honggyu.kim@sk.com

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 Documentation/mm/damon/maintainer-profile.rst | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/Documentation/mm/damon/maintainer-profile.rst b/Documentation/mm/damon/maintainer-profile.rst
index ea42f57cf9dc..8213cf61d38a 100644
--- a/Documentation/mm/damon/maintainer-profile.rst
+++ b/Documentation/mm/damon/maintainer-profile.rst
@@ -20,9 +20,10 @@ management subsystem maintainer.  After more sufficient tests, the patches will
 be queued in mm-stable [3]_ , and finally pull-requested to the mainline by the
 memory management subsystem maintainer.
 
-Note again the patches for review should be made against the mm-unstable
-tree [1]_ whenever possible.  damon/next is only for preview of others' works
-in progress.
+Note again the patches for mm-unstable tree [1]_ are queued by the memory
+management subsystem maintainer.  If the patches requires some patches in
+damon/next tree [2]_ which not yet merged in mm-unstable, please make sure the
+requirement is clearly specified.
 
 Submit checklist addendum
 -------------------------
-- 
2.39.2



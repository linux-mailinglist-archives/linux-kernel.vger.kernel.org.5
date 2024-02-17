Return-Path: <linux-kernel+bounces-69604-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92A30858C45
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 02:02:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C59ED1C20ABC
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 01:02:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE55122EF9;
	Sat, 17 Feb 2024 00:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sAnP8Y39"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD6711B5B3;
	Sat, 17 Feb 2024 00:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708131528; cv=none; b=nJHYiw96uDF1HwMERUrNfDV5SGrhE6skjPyqEOZvG8a2MohKkP0SSJqo0H1Cak5sWkt+XZCpxpFBebBl254+mfrKM/g+pI3ysOeNTRqTcCMMoG5cKjvMjtem2SziQ8eSavoFvDAQKworCW2sJqoQrUQbifxMVKDMWSaxOADGKMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708131528; c=relaxed/simple;
	bh=Amv7MsMRrFhTpSKvV6b53ASGSJnoAb83web7cZHL2Xc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CWhIDH8hIFjV19P2oNGet8K0Idzkyd3455/sQv9HIIIqr/cQFeaWELKNPNXTMoLmJt65JxjPonbAVDUm175AQ0W9p6Nf9zdokwTB9daFND487WOAcrCi1qZeRgYWWlmXR82Dg8se2cl/nerA/EfcSctrHCccbmx4fNjyMM74DO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sAnP8Y39; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9018EC4160D;
	Sat, 17 Feb 2024 00:58:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708131527;
	bh=Amv7MsMRrFhTpSKvV6b53ASGSJnoAb83web7cZHL2Xc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sAnP8Y392axNOEc8YRW/0sLDcxwLLHJPPXLuM6vPeVUqHE9FZZ/BorXpOA8r46Lfe
	 aZFCAYNsDJYrS2BSgzsvoHGCGNdYJwdwkZCXotxUD+CrxbXlossn69i4lNDZDDN9/S
	 qauCf0OHvQfTTOGIw7WEGv+QabZEoJiePobg1Iv1ZlICP+jxERy+4cqGy9v0tqXoRp
	 xff7mNIotAANdwocgZQ5Ap6kzQs3DuaXmJwU5j0xOURVwc9cGhqGxAD3GGTcOE9lpg
	 ZmA34gsmsrJ9cJ4Bhhbbezp0nsFTU+wZcYyV9lG9IPuHGrsll0j6aelOHeoESW634c
	 xNlHDVxJQYEZw==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/5] Docs/mm/damon/maintainer-profile: fix reference links for mm-[un]stable tree
Date: Fri, 16 Feb 2024 16:58:38 -0800
Message-Id: <20240217005842.87348-2-sj@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240217005842.87348-1-sj@kernel.org>
References: <20240217005842.87348-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A couplt of sentences on maintainer-profile.rst are having reference
links for mm-unstable and mm-stable trees with wrong rst markup.  Fix
those.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 Documentation/mm/damon/maintainer-profile.rst | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/mm/damon/maintainer-profile.rst b/Documentation/mm/damon/maintainer-profile.rst
index a84c14e59053..5a306e4de22e 100644
--- a/Documentation/mm/damon/maintainer-profile.rst
+++ b/Documentation/mm/damon/maintainer-profile.rst
@@ -21,8 +21,8 @@ be queued in mm-stable [3]_ , and finally pull-requested to the mainline by the
 memory management subsystem maintainer.
 
 Note again the patches for review should be made against the mm-unstable
-tree[1] whenever possible.  damon/next is only for preview of others' works in
-progress.
+tree [1]_ whenever possible.  damon/next is only for preview of others' works
+in progress.
 
 Submit checklist addendum
 -------------------------
@@ -41,8 +41,8 @@ Further doing below and putting the results will be helpful.
 Key cycle dates
 ---------------
 
-Patches can be sent anytime.  Key cycle dates of the mm-unstable[1] and
-mm-stable[3] trees depend on the memory management subsystem maintainer.
+Patches can be sent anytime.  Key cycle dates of the mm-unstable [1]_ and
+mm-stable [3]_ trees depend on the memory management subsystem maintainer.
 
 Review cadence
 --------------
-- 
2.39.2



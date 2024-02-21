Return-Path: <linux-kernel+bounces-75168-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3578285E40F
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 18:09:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 672B41C229B6
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 17:09:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32A5A83CC8;
	Wed, 21 Feb 2024 17:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T0A28dBr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71B6883CAE;
	Wed, 21 Feb 2024 17:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708535341; cv=none; b=bVfcIfdm3GVqGN1Iy+MlaorfStoXHdwPtLD/Ba91TY/PO9zGHWQg1r9XiO95vaZ8D6GH36WcOjqMeDUM51eDBf7dYxsNyOeAFXPhOHbGwf7q2VE1PaI/T+WKxY7XVPSuU6TJVQ7o5pPUf0En7Rmwg9Q/d/KSVoDvprpS7R/m5as=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708535341; c=relaxed/simple;
	bh=2+5nRP+YTxElTT97T2B5k4RuQvMaKWkXNGWxveIPqKA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=R8bGDKvNQIvR1grTctPa79gkdq3ViWKf6wpnIzRPZ+d+byqu4zYPsuP9TkpWGKaRtf0cSiRADLxUIFFO5n6B7f6EP7DX4Cbdr7NbEpgwxaWgttJJ79mh6sz6SLRtavvek4aRQxdEg8lEEGdE+SRT2JHHXxO68GLK/GvB24H6Jac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T0A28dBr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF6F2C433C7;
	Wed, 21 Feb 2024 17:09:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708535341;
	bh=2+5nRP+YTxElTT97T2B5k4RuQvMaKWkXNGWxveIPqKA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=T0A28dBrfGOlXDBc/m40UeAfYuzc3zZYwp8IqWeTe2nGj7bpFtauo49MTACSseBfU
	 kiRVV2MydaiHFhb2VL2b/Cq6eRoRFSa74hJVAYhZWXdAXCbSXtGMYtZnDLYTZpPoVs
	 /0Qv7uLHDYeiMFw1gCbhyzpRxlpeRubqcySihhFz71Zrpz/XkhrvkN/CSNWK2Mi2xc
	 lcbXzNFrU3twegSMdAsbWtB5xaZ4P9e7urIvoyKB7dIyOr1+HdOZ1LmzShffwDDV6F
	 kJd1u6c4rLOznqGoXtOzots16ONsK7QcxhiMGjfu7KJ5MF8ZmugPjVGNFHPtON/FGN
	 w2gdhCFVsrhMg==
From: SeongJae Park <sj@kernel.org>
To: akpm@linux-foundation.org
Cc: corbet@lwn.net,
	sfr@canb.auug.org.au,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	SeongJae Park <sj@kernel.org>
Subject: [PATCH mm-unstable 2/2] Docs/admin-guide/mm/damon/usage: fix a typo on the auto-tuning design reference link
Date: Wed, 21 Feb 2024 09:08:52 -0800
Message-Id: <20240221170852.55529-3-sj@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240221170852.55529-1-sj@kernel.org>
References: <20240221170852.55529-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There was a typo on the quota auto-tuning design reference link that
caused below document build warning.  Fix it.

    WARNING: undefined label: 'damon_design_damos_quota_auto_tuning'

Fixes: d50e871bd78b ("Docs/admin-guide/mm/damon/usage: document quota goal metric file")
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Closes: https://lkml.kernel.org/r/20240221162745.4332955c@canb.auug.org.au
Signed-off-by: SeongJae Park <sj@kernel.org>
---
 Documentation/admin-guide/mm/damon/usage.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/mm/damon/usage.rst b/Documentation/admin-guide/mm/damon/usage.rst
index 952528f0739ba..6fce035fdbf5c 100644
--- a/Documentation/admin-guide/mm/damon/usage.rst
+++ b/Documentation/admin-guide/mm/damon/usage.rst
@@ -369,7 +369,7 @@ Among the multiple feedback, the best one is used.
 Each goal directory contains three files, namely ``target_metric``,
 ``target_value`` and ``current_value``.  Users can set and get the three
 parameters for the quota auto-tuning goals that specified on the :ref:`design
-doc <damon_design_damos_quota_auto_tuning>` by writing to and reading from each
+doc <damon_design_damos_quotas_auto_tuning>` by writing to and reading from each
 of the files.  Note that users should further write
 ``commit_schemes_quota_goals`` to the ``state`` file of the :ref:`kdamond
 directory <sysfs_kdamond>` to pass the feedback to DAMON.
-- 
2.25.1



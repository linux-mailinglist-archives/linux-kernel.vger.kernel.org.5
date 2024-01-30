Return-Path: <linux-kernel+bounces-43721-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47850841860
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 02:36:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 792751C22C13
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 01:36:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C93563613C;
	Tue, 30 Jan 2024 01:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TyTGrLjQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F0202E40E;
	Tue, 30 Jan 2024 01:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706578558; cv=none; b=PM9JZBi3vKx78ME0Nb7HbG/sBAN6NFH6qyYyEE6rlFazE5pQh0M2FUkGGVOV5W/hLZPH2zRwLPN9RVNHTM4OczaoXkfram/Dgsunl/esTRIpzMIFqREuOb132uZC2lVt0bbRKYhAtngQSzWo+KvPoDegfFM2ZS/EYQ0lM0IBKHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706578558; c=relaxed/simple;
	bh=77VtE5VeGNNpbwa0hrebctF5G9UJB4sc86yojoaICLY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UkIUWKaPOnTnJbuZX5mj1lUmBnQnmmwnfZpkIEGbvpAE/FQGzmGN4r9/MzW5I8h65mCLqJF+n2A8NthYqRIC5cVYFIPcbBi0oAz596dMzd3lb3Iuq2cUdlth7pmZL80zAUJ0OELSIhSQmSTZyL1zicLwOwN27UvA8hiVllSoZYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TyTGrLjQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2ADB8C43390;
	Tue, 30 Jan 2024 01:35:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706578557;
	bh=77VtE5VeGNNpbwa0hrebctF5G9UJB4sc86yojoaICLY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TyTGrLjQCQhz8bD5mowo3BX2lOX8zP9+UFaUtGUfheU1Uga89bmlQqQelNt3gE8hy
	 PauFBb9VoHKnGQDPacecP/BTTR1EEFJC3kkM57zEqm/y1HA5DXYwSiRz7BkD10BbAZ
	 4N5f0LVlsLMTdBmyHOQyegGstohPrML3/8mtPMvJuIa9a5AegAE33ILmxRSQtbJR8/
	 dHglWue96C9Z8l6orgyB+HDb8j8V1+P4e27BBR+IdlQpT3ItD4Gq9VOBQIhO5FvDs5
	 hK7URWQ03wLuU6J+N3oUBz+Kp7yAvXCYx4uPCzV2e887ccgqZn9cVhd3QcGqEmvk9t
	 w0mJHW11Ao0Sg==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/9] Docs/admin-guide/mm/damon/usage: use sysfs interface for tracepoints example
Date: Mon, 29 Jan 2024 17:35:40 -0800
Message-Id: <20240130013549.89538-2-sj@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240130013549.89538-1-sj@kernel.org>
References: <20240130013549.89538-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DAMON tracepoints example on the DAMON usage document is using DAMON
debugfs interface, which is deprecated.  Use its alternative, DAMON
sysfs interface.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 Documentation/admin-guide/mm/damon/usage.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/mm/damon/usage.rst b/Documentation/admin-guide/mm/damon/usage.rst
index 9d23144bf985..f2feabb4bd35 100644
--- a/Documentation/admin-guide/mm/damon/usage.rst
+++ b/Documentation/admin-guide/mm/damon/usage.rst
@@ -579,11 +579,11 @@ monitoring results recording.
 While the monitoring is turned on, you could record the tracepoint events and
 show results using tracepoint supporting tools like ``perf``.  For example::
 
-    # echo on > monitor_on
+    # echo on > kdamonds/0/state
     # perf record -e damon:damon_aggregated &
     # sleep 5
     # kill 9 $(pidof perf)
-    # echo off > monitor_on
+    # echo off > kdamonds/0/state
     # perf script
     kdamond.0 46568 [027] 79357.842179: damon:damon_aggregated: target_id=0 nr_regions=11 122509119488-135708762112: 0 864
     [...]
-- 
2.39.2



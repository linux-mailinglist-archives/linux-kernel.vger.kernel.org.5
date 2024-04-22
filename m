Return-Path: <linux-kernel+bounces-154220-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AC4B68AD96F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 01:54:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 60FA71F21A85
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 23:54:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39625502A5;
	Mon, 22 Apr 2024 23:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YONnhphh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F24747A76;
	Mon, 22 Apr 2024 23:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713830047; cv=none; b=iUqA/GsOw7SA1oXRfKl9DgsXydJRXWeHqWjqJCdFjFk8S4mpjn71rZOAGUPg+CoK0TbuMoFuMpK10mc9wc1fbMEWzK7gvz3n8rYP7JnjTnAFAVfCvHa8C3DVJrifKgggSxJe43O8vvBSjbmoolJxOidNj2abiDZrnym1NVY7QqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713830047; c=relaxed/simple;
	bh=bStklwwtNdltoD12r8eJEawIcHIsh/UnVk0kuaeICpk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CzhiyluwoPZBX6lBDK4X3qCAt3CZMdUSUuzgWe7TNaznoYselxw82ZBC4+9szE0DQmGKpWvhLB6ZyLaqTwNRnTAMPs5vvDRdbFCCnUe9saK/5saxwHcF1HHHk4AO4JsGkNawLW2/5ggUdWcTW87symcPk2ASFDLkH4ktFqM+CHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YONnhphh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FA2FC2BD11;
	Mon, 22 Apr 2024 23:54:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713830047;
	bh=bStklwwtNdltoD12r8eJEawIcHIsh/UnVk0kuaeICpk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YONnhphhT17RXnGNGYa33pqjuJ3wAjsebY+AGzmgFHqMXEQvjmPfviX3PqGxoIXYc
	 bheO1OxLP64sGWvzAosUktgPr16a5ZB9q3448GlpQCL/Xe3cS/ehT4y90R2tnZ/281
	 1WXVur/4yxnbnHqXO4c2au73Il6s/RdRrAvthpVU54tcJfGpSuwl3uyDiZpcizyLL2
	 UaDSDJRixl7XYPRZt13/qAR0vlxK689cPcJSW5OSOmUj3Ltvg3IsgpZkcEqFW8BAiE
	 oh5T90qXPuLTC0VBzMr31qizlsoWtBmkLfjkSpzD7WscMMi/pJauOek+UCjCjR/1JV
	 HWp0afNI9HIpQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Peng Liu <liupeng17@lenovo.com>,
	Len Brown <len.brown@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	lenb@kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH AUTOSEL 6.8 03/43] tools/power turbostat: Fix Bzy_MHz documentation typo
Date: Mon, 22 Apr 2024 19:13:49 -0400
Message-ID: <20240422231521.1592991-3-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240422231521.1592991-1-sashal@kernel.org>
References: <20240422231521.1592991-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.8.7
Content-Transfer-Encoding: 8bit

From: Peng Liu <liupeng17@lenovo.com>

[ Upstream commit 0b13410b52c4636aacb6964a4253a797c0fa0d16 ]

The code calculates Bzy_MHz by multiplying TSC_delta * APERF_delta/MPERF_delta
The man page erroneously showed that TSC_delta was divided.

Signed-off-by: Peng Liu <liupeng17@lenovo.com>
Signed-off-by: Len Brown <len.brown@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/power/x86/turbostat/turbostat.8 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/power/x86/turbostat/turbostat.8 b/tools/power/x86/turbostat/turbostat.8
index 8f08c3fd498d5..1ba6340d3b3da 100644
--- a/tools/power/x86/turbostat/turbostat.8
+++ b/tools/power/x86/turbostat/turbostat.8
@@ -370,7 +370,7 @@ below the processor's base frequency.
 
 Busy% = MPERF_delta/TSC_delta
 
-Bzy_MHz = TSC_delta/APERF_delta/MPERF_delta/measurement_interval
+Bzy_MHz = TSC_delta*APERF_delta/MPERF_delta/measurement_interval
 
 Note that these calculations depend on TSC_delta, so they
 are not reliable during intervals when TSC_MHz is not running at the base frequency.
-- 
2.43.0



Return-Path: <linux-kernel+bounces-154339-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B615B8ADAED
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 02:23:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5786B1F2161E
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 00:23:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E23841C9ECF;
	Mon, 22 Apr 2024 23:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FKV9XUNI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27D771C9EAE;
	Mon, 22 Apr 2024 23:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713830365; cv=none; b=BOeADodtcinkqHXHyrIAGGSpx5ainVCGZbN1OfBUzAVicpKSmt+pYqjVlrJpE5U1SAQfIKlDFNCrVcO4hxKIWCJ+/5seVrYIWIT26iraDILawbJjZUwQoqPGxDPCzlGIFjxRDUjBv8ooUlwo3jKi4IGp0j4l42Oa95UbLv/HWxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713830365; c=relaxed/simple;
	bh=vLQFAZIJubsoxdjKFTHmou1qkN+kTNZCtLfClWjL4vI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HDXv+QDwAl70iDgtzu+iN8o0i+YmkGy7doUBs6kNjrp6NAFheVJN9VupZAPdS+a3UzH6OBiQtAlrkNHrI0QuJ2KvMDwKiG5yqxRdIuYdgNX1AP0BjG0Kjx5aXdFwKbXwtrGQhzL91JoatRD4vtuz/wRbIzEWH51fChoOAvKSNn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FKV9XUNI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9DD7C3277B;
	Mon, 22 Apr 2024 23:59:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713830364;
	bh=vLQFAZIJubsoxdjKFTHmou1qkN+kTNZCtLfClWjL4vI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FKV9XUNIaU3cFaRRVaApE73GUuUO8boG8m6JIrL69lWA8as8oNSh8ff7ydRPgJUzX
	 /Uvuv53wQZxc8EUXMbiigBLo0SOxDaaPlzrAJq8xtAbz82crl9BrpKnVI5Z4KlEZYR
	 2Pk1MV+YAzyCv7ZGqcGXigA0mpQgn8PqZDM6QGHgTQxFyTZfrLXA11Ao78JJYDcsyV
	 wrefZVCb3YWpRkqxU2d2Nuz6cb08aTL5KDAahtWx8O6CXch9c7heJuZZ8d8NFqM+kB
	 +37e8OBChChaIxrV/sb146HZ68OR0fHSwtgzuyR/t4zr0jMCzYn/m27l3ysaO91VSc
	 +8DlJj+Z8Xo0A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Peng Liu <liupeng17@lenovo.com>,
	Len Brown <len.brown@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	lenb@kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 2/7] tools/power turbostat: Fix Bzy_MHz documentation typo
Date: Mon, 22 Apr 2024 19:20:34 -0400
Message-ID: <20240422232040.1616527-2-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240422232040.1616527-1-sashal@kernel.org>
References: <20240422232040.1616527-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 4.19.312
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
index a6db83a88e852..25a560c41321d 100644
--- a/tools/power/x86/turbostat/turbostat.8
+++ b/tools/power/x86/turbostat/turbostat.8
@@ -318,7 +318,7 @@ below the processor's base frequency.
 
 Busy% = MPERF_delta/TSC_delta
 
-Bzy_MHz = TSC_delta/APERF_delta/MPERF_delta/measurement_interval
+Bzy_MHz = TSC_delta*APERF_delta/MPERF_delta/measurement_interval
 
 Note that these calculations depend on TSC_delta, so they
 are not reliable during intervals when TSC_MHz is not running at the base frequency.
-- 
2.43.0



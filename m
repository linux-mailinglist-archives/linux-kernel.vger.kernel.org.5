Return-Path: <linux-kernel+bounces-154321-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E1DAB8ADAB0
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 02:18:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 824381F20CEA
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 00:18:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A58001A0B10;
	Mon, 22 Apr 2024 23:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qe4NDqw2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E66CF1A0AF6;
	Mon, 22 Apr 2024 23:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713830320; cv=none; b=WG6J+jlBohaa+g9P8z0fSkWWVPynL/1cImNA8WNLPQ1/HvpUwN7LNGkmijtx6IKDb4yhSGJgrjU3lqUHOeNCMO+GaL5qCB0M860bJ81I0KiPgRU9DbN9FJoHECPIV13Ym45k8Z+eJ/ix0FJyEmNCTURBc5+fHDYyix/U1EHJkCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713830320; c=relaxed/simple;
	bh=ZcWYBw/aQ++cOybcjfSeuQ5sdKnCiuMEN4fdirKcXeg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eqT5LAGEJmXJC3OVAH2FJ9mbtdhoG9kibuKnwiNCpr4UMHqQNGk5jhhu4/94OCZTpHhzT2kAt4qUAkBh95F8dyYiHMNPSKWpSzXy/SFnVZgWPG1zZ4tLzQwqlh2tSWHxwpJXgEZv4MBpn9+OU3UYHv7+X/O1opbZvXdWc0urQTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qe4NDqw2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05D69C32786;
	Mon, 22 Apr 2024 23:58:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713830319;
	bh=ZcWYBw/aQ++cOybcjfSeuQ5sdKnCiuMEN4fdirKcXeg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Qe4NDqw2AKaY49u3ffVRp28IwHOsxqXKfguvVEcwoKRsvKMS19p+metcm62eGjuVL
	 tiK/IyXU+eV+kSQBXrTtNxu5ms+/1GCtbhJtwPZpnGuhPUaluLqTne8uQerWb7zj0d
	 LpFlhCUcBUAQKdiBhb+N/08uJkwNEhV5PSSjI4FMgQXkxLsgTn4ZWCIase1esmIeej
	 W0SXpy3XHCpK/dIlTLLmuidnqEY6tTECAjeY8tab3gHDBfpicCO0kFhGUl3R1DiobI
	 kKG/UHlhiiLQPA39zlgPwuLIN95OvDbQ4uCy27JGHGmpup7BMwrN2Gf0qAnbj/Cvk+
	 asvH49cux79nw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Peng Liu <liupeng17@lenovo.com>,
	Len Brown <len.brown@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	lenb@kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 2/9] tools/power turbostat: Fix Bzy_MHz documentation typo
Date: Mon, 22 Apr 2024 19:19:43 -0400
Message-ID: <20240422231955.1613650-2-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240422231955.1613650-1-sashal@kernel.org>
References: <20240422231955.1613650-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.215
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
index 71e3f3a68b9df..f8cc88c56ae8f 100644
--- a/tools/power/x86/turbostat/turbostat.8
+++ b/tools/power/x86/turbostat/turbostat.8
@@ -320,7 +320,7 @@ below the processor's base frequency.
 
 Busy% = MPERF_delta/TSC_delta
 
-Bzy_MHz = TSC_delta/APERF_delta/MPERF_delta/measurement_interval
+Bzy_MHz = TSC_delta*APERF_delta/MPERF_delta/measurement_interval
 
 Note that these calculations depend on TSC_delta, so they
 are not reliable during intervals when TSC_MHz is not running at the base frequency.
-- 
2.43.0



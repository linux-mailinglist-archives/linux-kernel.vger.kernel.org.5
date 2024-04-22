Return-Path: <linux-kernel+bounces-154330-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 12BD88ADACE
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 02:21:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A7C431F21E98
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 00:21:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B7D21C231B;
	Mon, 22 Apr 2024 23:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aMwirvHr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2DD9158DAB;
	Mon, 22 Apr 2024 23:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713830344; cv=none; b=SMzQtuheuyi11SBlJsBP1nDNh+UT9ihP23uhcO6NP0bEiX412+pEPtyYU2hHiIipqn152SFqCSH/tAWlY9DWMAs7OSjwRgAzsLfHXQK5QtUaDk0u1dJY9MQF/G1N8uyQNj5Tnjumzolrb6ZKi4C/NtUC9eURvFvw7r/3HaWpmEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713830344; c=relaxed/simple;
	bh=vLQFAZIJubsoxdjKFTHmou1qkN+kTNZCtLfClWjL4vI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KwqKeKMO8ioozAh/U5Vx3yYt3MzGF9ypz6i6EfVS15jd7XR5HCii1UAm1ZJxnJj98s4VoGX0lkIrrStOGyXGGsQ3Onxty0guBDq/u2bkCOvrZzrR5LfPint3cifq+yQXbQ58FUl+rZMX3nGWS3X4MYM28ix5MJFBlGDUmwIXWM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aMwirvHr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 683E4C2BD11;
	Mon, 22 Apr 2024 23:59:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713830344;
	bh=vLQFAZIJubsoxdjKFTHmou1qkN+kTNZCtLfClWjL4vI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aMwirvHru/GqyZHy795VoU8lf/oPGYhLBABsI/zdS9RoRt5Fmkz1CM4EX5ocYF6ro
	 bPDVqbm40jEHp6r6vIPl0OA2bLYRpKw8Mv6Fzl0NMnP0pO2L6pY839kAiSQeH76nfC
	 T5nH/BLVIArOnlNlK/a5R8Tgk1yceoYxvBQmEJuZFEPq0F+3g+IC5/LngjrxKDMaMi
	 MWjzk7bxziqL9W5z/iK3wuFaOTP/rASQY2kRIkPyxHrpH9bF3ye/ByHLwCu96Fh8eX
	 x7O3yKNTmIoWFJrBjGDF0/3BAh1DCYAe0azJO2HAoZM5WeLjwgTwaoNkATl+iT9iFB
	 7IDGyyyqx1FDA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Peng Liu <liupeng17@lenovo.com>,
	Len Brown <len.brown@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	lenb@kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 2/9] tools/power turbostat: Fix Bzy_MHz documentation typo
Date: Mon, 22 Apr 2024 19:20:07 -0400
Message-ID: <20240422232020.1615476-2-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240422232020.1615476-1-sashal@kernel.org>
References: <20240422232020.1615476-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.274
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



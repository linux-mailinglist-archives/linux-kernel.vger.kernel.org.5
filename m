Return-Path: <linux-kernel+bounces-154311-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E35F28ADA91
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 02:16:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 095171C21791
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 00:16:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8773A181D0C;
	Mon, 22 Apr 2024 23:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i7Y2QGDc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6A84181CF6;
	Mon, 22 Apr 2024 23:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713830293; cv=none; b=Tp2zK2mt3m0IKylt3ma0u9zFUBtKkagNFNqmGAse0TRzlYuHiPq77CMnzDtyv2Tl8eRiZBKh8EHhR6E7UbmUl/N7+17NFD5xjiDN+jwgUXqzfyrFXovF7dkLRwf5Brf8GVgj892twf9U1befmIUosv89FtUKHd2Qb3DQZ9KchBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713830293; c=relaxed/simple;
	bh=ULYRngvSrE1ihyauZb9R0fvGX+bl8nDcQtyzkXkJm9U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fWbzyV0YkZmK46cDPLhFTNMGCzdf3aO6NqKpHSDJEg6oLNEa8ZbsNLdlEMezecwZSL3RVKZcewFyqn3y1+BBLjJeWgsnFojMAum8P1Ga8StNFD7l5/39q4kg3d5i6r1o/4TpvJevlOni4A7Od/SVFNloQedlVnkfVWm/oGJ7ZZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i7Y2QGDc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD2E9C32786;
	Mon, 22 Apr 2024 23:58:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713830293;
	bh=ULYRngvSrE1ihyauZb9R0fvGX+bl8nDcQtyzkXkJm9U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=i7Y2QGDc1qSoPoPXWMxQRXhjUr0TAYgMWp0ZW4GWqpknbcBFddeVaOPCxB282rAdZ
	 kaTHHHyBQy2/iZaXRSV1bbJIiqoq5/o/SO4f6shDjJ6XxNkOm+kay7TZ6mLAz1pmmX
	 OdqWojTHidtSqtlSYszRMOYxSrNECys/MRxmtTQwVp5Ttp/a+wY1pDWNuBx30InjiT
	 /WS7H7XNHlngmkX+pzsf/pUOUW8hDdwjXNpYGuBCgcRBPFfW5q5Wi0+bnLLSr93B1j
	 g9dzY5p9Cgk9uSbfkylzy5q+L5ote/TQdnFcgyIlDcpnnQC1u4uKtxDUEh0tXhS3ln
	 VrQwv7Tv6vQWg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Peng Liu <liupeng17@lenovo.com>,
	Len Brown <len.brown@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	lenb@kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 02/10] tools/power turbostat: Fix Bzy_MHz documentation typo
Date: Mon, 22 Apr 2024 19:19:15 -0400
Message-ID: <20240422231929.1611680-2-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240422231929.1611680-1-sashal@kernel.org>
References: <20240422231929.1611680-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.156
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
index b3d4bf08e70b1..f382cd53cb4e8 100644
--- a/tools/power/x86/turbostat/turbostat.8
+++ b/tools/power/x86/turbostat/turbostat.8
@@ -322,7 +322,7 @@ below the processor's base frequency.
 
 Busy% = MPERF_delta/TSC_delta
 
-Bzy_MHz = TSC_delta/APERF_delta/MPERF_delta/measurement_interval
+Bzy_MHz = TSC_delta*APERF_delta/MPERF_delta/measurement_interval
 
 Note that these calculations depend on TSC_delta, so they
 are not reliable during intervals when TSC_MHz is not running at the base frequency.
-- 
2.43.0



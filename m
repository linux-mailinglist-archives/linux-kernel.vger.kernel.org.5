Return-Path: <linux-kernel+bounces-154293-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87B4F8ADA63
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 02:11:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B80711C216FF
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 00:11:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02F97179203;
	Mon, 22 Apr 2024 23:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PfoiByLh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EEB2176FC3;
	Mon, 22 Apr 2024 23:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713830252; cv=none; b=UTiahN8wlAvv73FkCsXSW2jsU7fVw/urBNuokV7ydV/i48jsP5cwbp4BTabVnaQh1iyj6uA2gsIXLdOnuhg3HbTbsRySold/OOPklS/nesHkOttq98MB+wRaLvIRfnxPbEr+JLMw061dU42H/BQXnRJdSPMgjx1xUI31iNlEg3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713830252; c=relaxed/simple;
	bh=Ahr8/zYK+zZs32yVTptNcG2uRJYuvk3bfshcRfebxmo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S/nCJshCNfJ2tPHWK72tcYWlmBFavsftYh1srEX6SzuxL67BRrV+zDXmex3jUmFqKxvkJe/6SFe6AcAPMB58i0FRdTOkKFdpBHyNsvAAfjWKLDS+QM8JkL3cAIgr0sudNa44w18YUHoNGznGqzGIoL+7tefVgwHnq7DIZ5lvX34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PfoiByLh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA6AEC2BD11;
	Mon, 22 Apr 2024 23:57:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713830250;
	bh=Ahr8/zYK+zZs32yVTptNcG2uRJYuvk3bfshcRfebxmo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PfoiByLhbgs7r76GR5H8cYdNJj7VpR8LBXFxRYj2FwmNdv3+9ikdl/B1p3g7RDVL2
	 RzF7owp//zxi3bCS1x6qKMf2qcsS4ZzvQCtVFVRvN6TF7SIq+8o5i8HvAA1vZMm617
	 vxHI47BIuggHf/b8yE80nqqD3ZN+T+/HD6ePYLy2Y/xXlEQ+1338pX8QxOCxw4UKqo
	 inSQOsDstcBgU8DPH8KhBb91HL8yqTCMc+fXqasFl79njdLT4nO+g0VpdwEIqAzDAt
	 PE3j0DPoH9HQChbFI0fQK6U5n+gvD1D4aZ34WorbsM9Cqo1+OuDRppN/Rc1fkV9xjN
	 vQOxyZgrUqOBQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Peng Liu <liupeng17@lenovo.com>,
	Len Brown <len.brown@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	lenb@kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 03/19] tools/power turbostat: Fix Bzy_MHz documentation typo
Date: Mon, 22 Apr 2024 19:18:17 -0400
Message-ID: <20240422231845.1607921-3-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240422231845.1607921-1-sashal@kernel.org>
References: <20240422231845.1607921-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.87
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
index 3e1a4c4be001a..7112d4732d287 100644
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



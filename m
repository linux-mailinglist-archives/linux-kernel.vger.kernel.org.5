Return-Path: <linux-kernel+bounces-154264-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 673E28ADA0C
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 02:04:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E89D5B256DF
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 00:04:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE19615ECFD;
	Mon, 22 Apr 2024 23:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iy1PVr2G"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 326BB15ECE3;
	Mon, 22 Apr 2024 23:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713830176; cv=none; b=ezVamdtLHPjHkSFm8cBDbTvpr54C8iU6NzTcSgAw6qXIl1AzFjegPtWTK5QWRUSfxrDYnzx6QCC1qeiVYIs/hfOTgrpuO7bSwz3+RB3SfP5u1ErGk4l74qAUosw96AsOmhZIBVvgqJablal1FIO+Ozit/6vY6JSIZjVQV6pxJJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713830176; c=relaxed/simple;
	bh=bStklwwtNdltoD12r8eJEawIcHIsh/UnVk0kuaeICpk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=knokrs8PO5hiiIbJ7Xq01C6+VJuTYITUpVhKWj8/6U9dxQx3GrVuUQzHYcsaxV+hex03plv8CJYST8w/YBVHFK3utQMJEIKmIaVR8CvNk8Z7JJEEsOSOCPoh1VBtl9u7qu9GllmkmdcqfnZYcGzPyv8rZDVG3W/C0U3Unvm1P04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iy1PVr2G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C0BCC2BD11;
	Mon, 22 Apr 2024 23:56:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713830176;
	bh=bStklwwtNdltoD12r8eJEawIcHIsh/UnVk0kuaeICpk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iy1PVr2GJib0d28J5aLScsc4XAKCEvY8znDBDehE+tsNfnwKe2JwEPAiEkbIyMl8Y
	 xfpFnTdZZbGyJhJt8Eo3206riZSsmIlFBaB6PuWoWfwfbqB6mxTtiD1MaSCuLQ3tlc
	 QAqRzwNkGZ1mdPJLTAlMs8rtUknigFQswMhTIkb1PBX/8V6rBeIUDch9g+jNi4Qu+Z
	 NeHtBIl/rDfnBT/nTGq7SaZr+X2q1l5P02tuBfRjWOyKqc0XyVzKLQeJ08twyIK9DL
	 a/N0V74gF55j+xL8R/lxbYn8sFuwv7PhR/Uh12QSnDcjq/EGWu4kT3NBrkEVFuebXx
	 rFdImhti3fzjw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Peng Liu <liupeng17@lenovo.com>,
	Len Brown <len.brown@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	lenb@kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 03/29] tools/power turbostat: Fix Bzy_MHz documentation typo
Date: Mon, 22 Apr 2024 19:16:44 -0400
Message-ID: <20240422231730.1601976-3-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240422231730.1601976-1-sashal@kernel.org>
References: <20240422231730.1601976-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.28
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



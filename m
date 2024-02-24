Return-Path: <linux-kernel+bounces-79394-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 459C786218F
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 02:11:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF9261F266CB
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 01:11:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99E4E4A15;
	Sat, 24 Feb 2024 01:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sw3MujSS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2DDC3C39;
	Sat, 24 Feb 2024 01:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708737068; cv=none; b=dPXd6djycwmomhyekfCSI3wWXXeOZvCSOaQv3s/jrK8kARH+GJhDjVL4tzRCp/GT/EdNhG7pQo2kTF58APiGY9j+nuYEFf3jKLkbT+/kfIRAskTVuX4i7b5MJEuenpyVaN54tk7RORWM7jLtUvvFdY/Puu9XDM3saiT0E5wjgl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708737068; c=relaxed/simple;
	bh=G1a33vTP84d0+3QZ0jbrzf9wPqj/sGi8fNaIuQ1yvls=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WInhHSii/bFXQFcruiAYapqHGK7daRnCaOcp5bljhk5keJMXVUtNcmkhgJj50rvZ2zrP1L/IQDhemOGPzIk67x11Y6n+C8HVt1C0RAFNbs6wMCv74KCTDbQShTNGVhfJfRkLvp0TLvso1/3sUEOSyMOtm+TzPCycZUWjfLcfleA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sw3MujSS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8BBEC433F1;
	Sat, 24 Feb 2024 01:11:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708737068;
	bh=G1a33vTP84d0+3QZ0jbrzf9wPqj/sGi8fNaIuQ1yvls=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=Sw3MujSS2+6W5dVkxymiSSw4RXwbyxNk+O4NCLTO2/85DEFuKWTH8T84fqwUm5KjX
	 fqleHvatvbRHsXuncO9auONelk2kj50dc340mVjDycRCDj7TrcLnXJgpBPABkUOoQ2
	 q30HcEIPOuFJ6SxDX2xHp4vRYZYmjrxFOVu6x5eP95VpgHWb0ImHoNWIqUOOC6mVuf
	 8pEYoDKefGdl+i1fbY6YrtcgA+nuiMPO3N97vEbjRQiYtEx/KozcWU80YcGtn/v9vl
	 Ii9jfdvMpgg9LzK66BkygmmcH4IuoxKHSPJKnFy2Sq/CHWTIAbfIpwLVX7+VMA1UZM
	 +CrbNZOZW8GLg==
Date: Fri, 23 Feb 2024 17:11:08 -0800
Subject: [PATCH 04/10] time_stats: add larger units
From: "Darrick J. Wong" <djwong@kernel.org>
To: akpm@linux-foundation.org, daniel@gluo.nz, kent.overstreet@linux.dev,
 djwong@kernel.org
Cc: linux-xfs@vger.kernel.org, linux-bcachefs@vger.kernel.org,
 linux-kernel@vger.kernel.org
Message-ID: <170873668005.1860949.11612121203653366580.stgit@frogsfrogsfrogs>
In-Reply-To: <170873667916.1860949.11027844260383646446.stgit@frogsfrogsfrogs>
References: <170873667916.1860949.11027844260383646446.stgit@frogsfrogsfrogs>
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

Filesystems can stay mounted for a very long time, so add some larger
units.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>
Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
---
 lib/time_stats.c |    3 +++
 1 file changed, 3 insertions(+)


diff --git a/lib/time_stats.c b/lib/time_stats.c
index 767b1a340e805..43106bda43a92 100644
--- a/lib/time_stats.c
+++ b/lib/time_stats.c
@@ -16,6 +16,9 @@ static const struct time_unit time_units[] = {
 	{ "s",		NSEC_PER_SEC	 },
 	{ "m",          (u64) NSEC_PER_SEC * 60},
 	{ "h",          (u64) NSEC_PER_SEC * 3600},
+	{ "d",          (u64) NSEC_PER_SEC * 3600 * 24},
+	{ "w",          (u64) NSEC_PER_SEC * 3600 * 24 * 7},
+	{ "y",          (u64) NSEC_PER_SEC * ((3600 * 24 * 7 * 365) + (3600 * (24 / 4) * 7))}, /* 365.25d */
 	{ "eon",        U64_MAX          },
 };
 



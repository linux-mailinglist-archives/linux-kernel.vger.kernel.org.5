Return-Path: <linux-kernel+bounces-34133-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 91CD683741E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 21:42:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C59291C2554B
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 20:42:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7233547F76;
	Mon, 22 Jan 2024 20:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MrWPu4fF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8BED47F6B;
	Mon, 22 Jan 2024 20:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705956141; cv=none; b=O8F9qOEeuvvJRs14wcc4HEmQDrjHKgetUQpHhXnhj/VoxqPodhHZ7+tgHJg6Fs/6uaFJ/QSnpvTIkadc8u6KqLB3mkExME08r52X4d4KYCupKc6sYJaZRredadVjGIMHTYr1hHi3pJG7ZdRi9DaixInpYAO1NIE/Xdt9ELo6u5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705956141; c=relaxed/simple;
	bh=2LI5A66NtYYs0c3+CFqA3f6NBGFtQt1rRRkpBo53+tY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ripcEo9EfS/Csvpm8ewM8jN9lO5gk5LVhTXaLJoPzqZ5pfK/3v3jVf9q020Sz4MxZfvJp/81kNs3rQAttSd1d8B4hFrqGwezEeyhkjSCZBH52F3oRA1Tb9vCpe2c542z3FEwXE5EwopXyweOgprGRWGoMzfKrXWOECLsRSGIMTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MrWPu4fF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF516C433B2;
	Mon, 22 Jan 2024 20:42:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705956141;
	bh=2LI5A66NtYYs0c3+CFqA3f6NBGFtQt1rRRkpBo53+tY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=MrWPu4fFzFvOJiNPFgjHlKBWqgjnUQVLsReSEslKUrYWzGmyewGgdg4rWrTjArDnZ
	 wKoXpUq0EA+R3VoSGd4Iv83OIwLfzoErnQO1o+TOb9pz+iraPpYfdEHKV4uYAINmSe
	 Ar+652uIg2AalXKrFY4kJttecHLXUbeSPB3gBsoiHLEtaTjC0lHyyFClDssUbpoLgn
	 HftQdeN9OdpQj8npAPjZQH9aGEAThyPH5Bd/SVYaWduOJDHblkreWyqpyw+2MzGU89
	 gBngbv6hCx91WZfn9d8h/6V6HVNpcwZe8kCex+OAcNWFC4n6kNPH0P4QykBbYhr+gn
	 4OXM8dUEpWsWw==
From: Mark Brown <broonie@kernel.org>
Date: Mon, 22 Jan 2024 20:41:52 +0000
Subject: [PATCH 2/4] arm64/sme: Fix cut'n'paste in ABI document
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240122-arm64-sve-sme-doc-v1-2-3d492e45265b@kernel.org>
References: <20240122-arm64-sve-sme-doc-v1-0-3d492e45265b@kernel.org>
In-Reply-To: <20240122-arm64-sve-sme-doc-v1-0-3d492e45265b@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Jonathan Corbet <corbet@lwn.net>
Cc: Dave Martin <dave.martin@arm.com>, linux-arm-kernel@lists.infradead.org, 
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Mark Brown <broonie@kernel.org>, 
 Edmund Grimley-Evans <edmund.grimley-evans@arm.com>
X-Mailer: b4 0.13-dev-5c066
X-Developer-Signature: v=1; a=openpgp-sha256; l=1479; i=broonie@kernel.org;
 h=from:subject:message-id; bh=2LI5A66NtYYs0c3+CFqA3f6NBGFtQt1rRRkpBo53+tY=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBlrtMiQWgzM6b3u/SZr1xZS0wLY+G9U2uI6gub7nqh
 Ddw+TreJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZa7TIgAKCRAk1otyXVSH0G2nB/
 44xZPX2DfylvBDshiwux6gUY/1TyyezZYWDNhHcvN0y0OEgzTGUDuHtcVdPuJBXPWUVDdhTPHTGkJn
 RzbkpZarjcwWzwZ1WEwh+cSwgJGRhqX4KHk9F0pWvVky3o8Swoe4pkZ4GyY8U0+tVz/82wwtHXPt2l
 sQVFPb0q3gCWvzWSmr8KcOwpwHYC5eL1rzJFSHKt4FI1iPujU4FUAiWuzUBiCFmytTlyjU2ZFsRgMZ
 mljHhD90EKIikRfwRfSDlnTV3dQTaarH/tLnp7kedPRJQpneJTMfr1Pi6qUZF2Md3YQVS3GtDyOWIt
 PmgbgJVJVYsTpcbdBAbILjbiAkgqqT
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

The ABI for SME is very like that for SVE so bits of the ABI were copied
but not adequately search and replaced, fix that.

Reported-by: Edmund Grimley-Evans <edmund.grimley-evans@arm.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 Documentation/arch/arm64/sme.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/arch/arm64/sme.rst b/Documentation/arch/arm64/sme.rst
index 3d0e53ecac4f..3133d0e91b48 100644
--- a/Documentation/arch/arm64/sme.rst
+++ b/Documentation/arch/arm64/sme.rst
@@ -238,12 +238,12 @@ prctl(PR_SME_SET_VL, unsigned long arg)
       bits of Z0..Z31 except for Z0 bits [127:0] .. Z31 bits [127:0] to become
       unspecified, including both streaming and non-streaming SVE state.
       Calling PR_SME_SET_VL with vl equal to the thread's current vector
-      length, or calling PR_SME_SET_VL with the PR_SVE_SET_VL_ONEXEC flag,
+      length, or calling PR_SME_SET_VL with the PR_SME_SET_VL_ONEXEC flag,
       does not constitute a change to the vector length for this purpose.
 
     * Changing the vector length causes PSTATE.ZA and PSTATE.SM to be cleared.
       Calling PR_SME_SET_VL with vl equal to the thread's current vector
-      length, or calling PR_SME_SET_VL with the PR_SVE_SET_VL_ONEXEC flag,
+      length, or calling PR_SME_SET_VL with the PR_SME_SET_VL_ONEXEC flag,
       does not constitute a change to the vector length for this purpose.
 
 

-- 
2.30.2



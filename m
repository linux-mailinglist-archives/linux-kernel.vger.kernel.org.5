Return-Path: <linux-kernel+bounces-37494-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8512583B0C5
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 19:13:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B8CC21C21EE7
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 18:13:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDC3412BE88;
	Wed, 24 Jan 2024 18:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FgHeIsLd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C5EA12AAE3;
	Wed, 24 Jan 2024 18:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706119970; cv=none; b=FzPTkIvpLnqurRfYKq91yKs2ZfPVeuVFe7yvm21wiGmprVUnxOEHzxvNOzjXSXOEK/T3gCYr1PfmUrqD7Q2orRK7RRvTeq4HyabIQc8jryMnq0qBnaVS8n838kXReBX5VOUiZKvTEnbvrzf+7zw0H5C6SncqthwI4vWIhbHyyfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706119970; c=relaxed/simple;
	bh=2LI5A66NtYYs0c3+CFqA3f6NBGFtQt1rRRkpBo53+tY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FX2+Oy8VRaRryFxuFWpqXbc7HQeohbFIHN6INa/p42LogOX8zaN0tyfOEGG2GgEPbyGNNS7u7iXzGkMg6mpugynaeyW7mxHdVrDSybQ4Yop7J2hQ5ST6zclzMCIVb3Jg89Y02crYIrwWHJHLPp+zv0Td1NJPlXHPAT6TVvMj734=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FgHeIsLd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6DABC433C7;
	Wed, 24 Jan 2024 18:12:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706119969;
	bh=2LI5A66NtYYs0c3+CFqA3f6NBGFtQt1rRRkpBo53+tY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=FgHeIsLdtoDa7SSwCq2mpMN6G3JoUpfhaqvMUcGO1+wvPmt1WhcHDyE2WMFk01aF8
	 MJRF8n/oBlGNG7YuqAkuuEaXrrSD0xkGwSh4GNgw7u+vn2mYiDcKbdVAxsP8iKrAZj
	 /bVa3aCtz2msMxffaGD006592+g5mAn/JJM0fM7yuqQ2bv7O/80n1aQZLBe8hYVaoS
	 V8/twOMVKnmgr76C76whyLAeK0f7PiCprkRyOcX5p9iunRL+cW6qTXUJ2zLcZwr1Gq
	 VVtQilq7jCmTmCuwsQJQPcC+YCkM0gUkmaikbhk7z1flnibTxz8zlIUeHRSatLQzIs
	 NBf4jDNo/rubA==
From: Mark Brown <broonie@kernel.org>
Date: Wed, 24 Jan 2024 18:12:36 +0000
Subject: [PATCH v2 2/4] arm64/sme: Fix cut'n'paste in ABI document
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240124-arm64-sve-sme-doc-v2-2-fe3964fb3c19@kernel.org>
References: <20240124-arm64-sve-sme-doc-v2-0-fe3964fb3c19@kernel.org>
In-Reply-To: <20240124-arm64-sve-sme-doc-v2-0-fe3964fb3c19@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Jonathan Corbet <corbet@lwn.net>
Cc: Dave Martin <Dave.Martin@arm.com>, linux-arm-kernel@lists.infradead.org, 
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Mark Brown <broonie@kernel.org>, 
 Edmund Grimley-Evans <edmund.grimley-evans@arm.com>
X-Mailer: b4 0.13-dev-a684c
X-Developer-Signature: v=1; a=openpgp-sha256; l=1479; i=broonie@kernel.org;
 h=from:subject:message-id; bh=2LI5A66NtYYs0c3+CFqA3f6NBGFtQt1rRRkpBo53+tY=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBlsVMYklGisR2HSaKlrxEpAGCLKSYUF3aDgX2/vxZB
 gOIHR4KJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZbFTGAAKCRAk1otyXVSH0PaMB/
 4ubQz4xobPi4XlnA531QckFklF11ys4y3qltDpU8ElUI8IURI3RwAC6LRduWVvowvYNlPFJ9fwHsZU
 T9DLL13MKrb4vxQUcpjrjrSbrDUUf7Q5+tLHMO+lh14iF3y+GqFGqiBXPUFpj1mgGEkPmdvY+Q3wJR
 9Gfcx1YIrO39SRrJ7LHxFhaoAge3ysDjKE9kt3rIfXZm73heuir/+fot8uIITq0KKIduxjmG5NbZ7k
 bbdb8O/mmOpJJ/pmLzh+gJ75Sm+Yz1VL+CP9rlq1oYYTWGTgdFketihTPXMpdzltvnwrpSdoNgvJj0
 /7akL5qvBriciMAlIQrw9MuPr/+3PT
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



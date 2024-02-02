Return-Path: <linux-kernel+bounces-50352-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F26898477E0
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 19:42:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 316101C2282C
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 18:42:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B06E15A48F;
	Fri,  2 Feb 2024 18:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jJm4HYkq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ABC51586E0;
	Fri,  2 Feb 2024 18:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706899180; cv=none; b=YA+rORI2O05Vrn6p8BrFSFBkoR+tTm+wXbBTzu5Xj/hwFDt9fQThNgvB33RQOJglku+bOcENQYZj73TVO5F7M18IKKeGxlv2jYJvPuESImtKlKzv24aotVcHBn2Zq7gavgn7mEsXlcopK/oZ1Cgnq7jyh/ISlHxxJcM4uO8duyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706899180; c=relaxed/simple;
	bh=tChvbH3WJ4jv5ceSmRADst+lV4Lko4l57ZYmO3gq8Cg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LPcjL0TZxAQU4ksQL3UiGJig2dpDpsIZg9NFzkAy3nUzRblemnLyQMKp8Jvac59lYqf6A9clxiQvI+xTZk5EvReLHIgiy9DOCZwLNqOrSHaiE7zyh+UOJOArWzr+I2uKHkRX+GBCsz5h9NPDDzWl5w+DGyh/J+ryXWsP78MAoHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jJm4HYkq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFC1FC433C7;
	Fri,  2 Feb 2024 18:39:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706899179;
	bh=tChvbH3WJ4jv5ceSmRADst+lV4Lko4l57ZYmO3gq8Cg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jJm4HYkqSD0iMCvByI94kHjBk+LI7+EZHUM+PX6p1NQDw2gxLtcMG7nUGClkyxI1/
	 TsuxHDwA7+Ihp/X7HPbV7MTB5KeDW7HZieJUqu5lSsC+t443yKIbUx4nRA4jTabgMg
	 wAWg05CH9SX3p3rWdt0PZ5V4sI05HjYhwD8m+Kj2JeA6ejh7GZoIxnn8Cd6ZILHAOs
	 LnW2HNdgW9q2eAn14F34mpwKn9kKGOuBUtW5ABsiuGwnbEXOTspobhRwni2plN4VSn
	 rEddpYgqIaFsiwc6KQNw7mH1+/0c4EoS33gdfZIc9xN+J3h6CYRhOVCT8NeD3XsUrg
	 131/03KFYJ7BQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Tony Luck <tony.luck@intel.com>,
	Borislav Petkov <bp@alien8.de>,
	Sasha Levin <sashal@kernel.org>,
	x86@kernel.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	dave.hansen@linux.intel.com
Subject: [PATCH AUTOSEL 6.7 08/23] x86/cpu: Add model number for Intel Clearwater Forest processor
Date: Fri,  2 Feb 2024 13:39:04 -0500
Message-ID: <20240202183926.540467-8-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240202183926.540467-1-sashal@kernel.org>
References: <20240202183926.540467-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.7.3
Content-Transfer-Encoding: 8bit

From: Tony Luck <tony.luck@intel.com>

[ Upstream commit 090e3bec01763e415bccae445f5bfe3d0c61b629 ]

Server product based on the Atom Darkmont core.

Signed-off-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20240117191844.56180-1-tony.luck@intel.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/include/asm/intel-family.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/include/asm/intel-family.h b/arch/x86/include/asm/intel-family.h
index 197316121f04..b65e9c46b922 100644
--- a/arch/x86/include/asm/intel-family.h
+++ b/arch/x86/include/asm/intel-family.h
@@ -162,6 +162,8 @@
 #define INTEL_FAM6_ATOM_CRESTMONT_X	0xAF /* Sierra Forest */
 #define INTEL_FAM6_ATOM_CRESTMONT	0xB6 /* Grand Ridge */
 
+#define INTEL_FAM6_ATOM_DARKMONT_X	0xDD /* Clearwater Forest */
+
 /* Xeon Phi */
 
 #define INTEL_FAM6_XEON_PHI_KNL		0x57 /* Knights Landing */
-- 
2.43.0



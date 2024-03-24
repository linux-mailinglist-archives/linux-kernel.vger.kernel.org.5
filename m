Return-Path: <linux-kernel+bounces-114174-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F6B58888E4
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:39:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08FE2287E18
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:39:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8743156976;
	Sun, 24 Mar 2024 23:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rr9CGd7I"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF05C2062E4;
	Sun, 24 Mar 2024 23:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321497; cv=none; b=Zef7mh+NQORqin8nlYV5xTMM9Ef0QQ1JFCOFr38XEdCcRT7Ttiou70YGaq1eJhA4HInaG7+8fogiH6hpCC/K/TfkHG5BMHGpOxjKpXhZDaNIiuAe/ExlYDA1QbBichTudkPxGC/e6K7FS6z3csATkXDwmzLt72Arnu3Z1J7+CEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321497; c=relaxed/simple;
	bh=ejgvvjlYrP0ggQ6p2mT2a42/l5zIDdfBEPIknr/GpMc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JfppluXirH0JIVlRSQelcdgCr9iWlSjGMkSiiqDaRE9NtIHIi5z3ASp8FC0A7ddRH/nr7rnujJDP9hzRHuduozm27qLkBocIZ6nWEFIwCqEP8Oy4KviWCCGoihZ1jWd6OqSd06NR0s8ccnMheavX/HeuQuehKJ9oxsr4juixfok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rr9CGd7I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 742C2C43394;
	Sun, 24 Mar 2024 23:04:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321496;
	bh=ejgvvjlYrP0ggQ6p2mT2a42/l5zIDdfBEPIknr/GpMc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Rr9CGd7IF9ZoIqk83gMNh0XVNl8k2svhMgvs8vKcdbuQv1PM2O5mBfCuQ/I3vCrXE
	 VcwEeOcD8BUki7VWHm7WNepXbWSBd0413beNyGTWp5T565G9pzF4FHPYk21BLj0cqi
	 8Z+QRcmHgAyqtGZPEKhQBx4vuBQMZ02WwXX64o6jJ7pwnZnt+z31tiIK+tpvrqmM/c
	 ATOP5kdUWjfRaQTN+b3mjBUVVqUDNyfm6TLeDhXnEJsjOxZtWhYAbZcF0gDwAA2sCO
	 KZi8Gz/5HQb5RLxcl26JZYlRAjCcYhEjKMqS/B7R9r3tuSrzrQ/xNR6WtNSAyAmgJb
	 bv3BOMl8HkvKg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Craig Tatlor <ctatlor97@gmail.com>,
	Luca Weiss <luca@z3ntu.xyz>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 221/638] ARM: dts: qcom: msm8974: correct qfprom node size
Date: Sun, 24 Mar 2024 18:54:18 -0400
Message-ID: <20240324230116.1348576-222-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324230116.1348576-1-sashal@kernel.org>
References: <20240324230116.1348576-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Craig Tatlor <ctatlor97@gmail.com>

[ Upstream commit 724c4bf0e4bf81dba77736afb93964c986c3c123 ]

The qfprom actually is bigger than 0x1000, so adjust the reg.

Note that the non-ECC-corrected qfprom can be found at 0xfc4b8000
(-0x4000). The current reg points to the ECC-corrected qfprom block
which should have equivalent values at all offsets compared to the
non-corrected version.

[luca@z3ntu.xyz: extract to standalone patch and adjust for review
comments]

Fixes: c59ffb519357 ("arm: dts: msm8974: Add thermal zones, tsens and qfprom nodes")
Signed-off-by: Craig Tatlor <ctatlor97@gmail.com>
Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Link: https://lore.kernel.org/r/20240210-msm8974-qfprom-v3-1-26c424160334@z3ntu.xyz
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/qcom/qcom-msm8974.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/qcom/qcom-msm8974.dtsi b/arch/arm/boot/dts/qcom/qcom-msm8974.dtsi
index 706fef53767e1..4a8eb8b423290 100644
--- a/arch/arm/boot/dts/qcom/qcom-msm8974.dtsi
+++ b/arch/arm/boot/dts/qcom/qcom-msm8974.dtsi
@@ -1194,7 +1194,7 @@ restart@fc4ab000 {
 
 		qfprom: qfprom@fc4bc000 {
 			compatible = "qcom,msm8974-qfprom", "qcom,qfprom";
-			reg = <0xfc4bc000 0x1000>;
+			reg = <0xfc4bc000 0x2100>;
 			#address-cells = <1>;
 			#size-cells = <1>;
 
-- 
2.43.0



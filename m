Return-Path: <linux-kernel+bounces-113064-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9D2288812D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:14:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 565CEB227F9
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 23:14:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A9371487CF;
	Sun, 24 Mar 2024 22:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BNkCe2Jy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FAEF148316;
	Sun, 24 Mar 2024 22:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711319872; cv=none; b=nw186C+hu4MPF5X/cwShW6pHyQ3YNqN2DgqUF/m8VakIC8mv35LAMQ5mHaY1T9486ixjboPlsrV8VuuKKEJBscgZh4twJiBHTaVBiNzJASfm0oU1tiae7UaQ4NQu9cIXEqF2yYdvC0BcpAVjvF0Zpe4uxZ9gPW8ixsBuS456eis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711319872; c=relaxed/simple;
	bh=/oBBgZrQ+FEexfLW/rIq/NTI4BG3br/QSuJ8X/PmO1I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CFM3+kQ5FKJqdB+w/wHRH5nGldW5hd+TLdIC30oM+ZZQ8UtoFMFNDGGHZ/PVjkPi9EnUcIfGtYGrTEbhBYNl2F39aooMZ7/qwCK/VP24wg5pW8owVVqcnXiya9kNGNbyI3RPHPFxXdr2XRdS1yiebBVvRtekpf9U/lonnxqsWnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BNkCe2Jy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A228DC43399;
	Sun, 24 Mar 2024 22:37:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711319872;
	bh=/oBBgZrQ+FEexfLW/rIq/NTI4BG3br/QSuJ8X/PmO1I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BNkCe2Jyobb7x+lkHh1TfWPz4uDllJ4Svwbz2R3NrYXK7y+0JiPB2uQi/8BnK7Jqy
	 IKMiPkBMUsIcOWlEIMcDAgT8GUxf+Z0KCjRS2lk++VfbJf/rVjpqo/w3rsAaqxcpbi
	 K0Mg2UNwORskaCuRVkaiWSL1BGV/CvRjQgF5oHlNmKyiTbRahcZgIo2LL8k6hvudvr
	 Ul9x8B4op6MutBFYvHkd1lh+XCGWySxbLpyWyyvq6Eechs7boknflQcw8W/yvIP4a8
	 FRrO/MwFFtbAa1EDmOFn9/mZlWCK/zWCCjvOcAtR3lT+Hw+6CSRjfB3QBgmX7yYEoU
	 95ezz+jgvIAEg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Komal Bajaj <quic_kbajaj@quicinc.com>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 177/715] arm64: dts: qcom: qcs6490-rb3gen2: Correct the voltage setting for vph_pwr
Date: Sun, 24 Mar 2024 18:25:56 -0400
Message-ID: <20240324223455.1342824-178-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324223455.1342824-1-sashal@kernel.org>
References: <20240324223455.1342824-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Komal Bajaj <quic_kbajaj@quicinc.com>

[ Upstream commit 05f439c0e64b877c1f9cc7f0bed894b6df45d43d ]

Min and max voltages for vph_pwr should be same, otherwise rpmh
will not probe, so correcting the min and max voltages for vph_pwr.

Fixes: 04cf333afc75 ("arm64: dts: qcom: Add base qcs6490-rb3gen2 board dts")
Signed-off-by: Komal Bajaj <quic_kbajaj@quicinc.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Link: https://lore.kernel.org/r/20231220110015.25378-3-quic_kbajaj@quicinc.com
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts b/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
index 8bb7d13d85f66..ae1632182d7c1 100644
--- a/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
+++ b/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
@@ -124,8 +124,8 @@ debug_vm_mem: debug-vm@d0600000 {
 	vph_pwr: vph-pwr-regulator {
 		compatible = "regulator-fixed";
 		regulator-name = "vph_pwr";
-		regulator-min-microvolt = <2500000>;
-		regulator-max-microvolt = <4350000>;
+		regulator-min-microvolt = <3700000>;
+		regulator-max-microvolt = <3700000>;
 	};
 };
 
-- 
2.43.0



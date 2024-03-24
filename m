Return-Path: <linux-kernel+bounces-115884-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 67B55889874
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 10:39:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 00D031F37B05
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 09:39:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4150227510;
	Mon, 25 Mar 2024 03:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aSSGIo/f"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 446541474A1;
	Sun, 24 Mar 2024 23:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711322078; cv=none; b=S1bHT+x0NabxeiNnY5+oLkMf8NcVPPIPDQARL8JrdeazNsNwUuVfRifbzvQ5ht+5S57tmnNdZCT80Kq0fuNGksk/D8ayMvgUAAxxxLUgMFugrZczDPE1huslxMrpyXzPl83rkQYBGCqTbA5Yw/wte0khEWGoAsRfcqWop0g4S10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711322078; c=relaxed/simple;
	bh=MkHeuYPfm8H1z1LvwOuNlx605FgXwk1O8AIFLcsCsuM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eQgogpIyrg3xLq5KjP31pR2uajUhS6BDkijvJBcHhG7rEXwADm0Aq2NI1L0q9Y3+8mmU/pIx18QodhdrCgTmsp27I7fWRGuZfvCMqSNz/vilg0HNQwRiUfSPBH4uVb/w7dW92mIbLgOakgjWkb67yj28RZ36il6KIL9txVbHXGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aSSGIo/f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51885C433F1;
	Sun, 24 Mar 2024 23:14:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711322078;
	bh=MkHeuYPfm8H1z1LvwOuNlx605FgXwk1O8AIFLcsCsuM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aSSGIo/fNbSWi5Q5v5m6LjctZWqedFZCa8GbfvUi3auo0m/7bgmXqYDAbnLEBaSbC
	 NuBkH2wjk0hOFQNqFrjrkAcd5UyEG4zhCXAANx7KfYoHS9hqGgEdXfqouUMtDDXfaT
	 cQz2oy0eVGQcQqU6xHeUHX4xKFmRjVuvBnFfQJ4pVy9yw+8LLXUl++popXe8EISjxg
	 dQNfmC8F1a6b3uq4vqCRu+JHUQ16AWYPiy7HN/rEH0/Gw0oZcbvP9u/31OFoaf+nsK
	 xqz0S49flUtrl4BwXcZ9okRXMk9jdaVeQkme46oBQsRYFbJQl0pg8tGCMv0eDuZefT
	 AqPryWvVKVOaA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Craig Tatlor <ctatlor97@gmail.com>,
	Luca Weiss <luca@z3ntu.xyz>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 151/451] ARM: dts: qcom: msm8974: correct qfprom node size
Date: Sun, 24 Mar 2024 19:07:07 -0400
Message-ID: <20240324231207.1351418-152-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324231207.1351418-1-sashal@kernel.org>
References: <20240324231207.1351418-1-sashal@kernel.org>
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
 arch/arm/boot/dts/qcom-msm8974.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/qcom-msm8974.dtsi b/arch/arm/boot/dts/qcom-msm8974.dtsi
index c4b2e9ac24940..5ea45e486ed54 100644
--- a/arch/arm/boot/dts/qcom-msm8974.dtsi
+++ b/arch/arm/boot/dts/qcom-msm8974.dtsi
@@ -1134,7 +1134,7 @@ restart@fc4ab000 {
 
 		qfprom: qfprom@fc4bc000 {
 			compatible = "qcom,msm8974-qfprom", "qcom,qfprom";
-			reg = <0xfc4bc000 0x1000>;
+			reg = <0xfc4bc000 0x2100>;
 			#address-cells = <1>;
 			#size-cells = <1>;
 			tsens_calib: calib@d0 {
-- 
2.43.0



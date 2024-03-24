Return-Path: <linux-kernel+bounces-113086-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51AB588815A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:19:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 805701C21750
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 23:19:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE9671509A5;
	Sun, 24 Mar 2024 22:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sMagzXjB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB3CA150990;
	Sun, 24 Mar 2024 22:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711319895; cv=none; b=hveICqaqWBY4+G7iyPVMxqMiMhs90cV5ZmEMTF3reKRWpG07D68ek7cPNKmR1nBzrrw3PXh3nYes80SxrkbjbkIh0uoGIvIASShM99AXY6L5UNLu0gi8BJ3NSVuiGd4cF2NJ8120YzDImn0xrfdBPovStlzckKrhfRKZSNZZcmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711319895; c=relaxed/simple;
	bh=gEgFcLLDiBB0JVgk2uIkggn1J6MoZu+KA+98Ajlgd48=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UZrftRhCQXz+9fJwlqh1B/zmfMlak3Hpwn/xRTkKs/i57JGgJHAsd6YBMi00LIP0W6hgO4FEjnnwNZymH9aepZW8b5C4VMb3Q9Z1aWFNvpDrfURtsolkG3NY7SR27S9DjjLged9hptgj3q5tH05zlC6SWcMkN6bV/qCns+I0cCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sMagzXjB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B94A0C43390;
	Sun, 24 Mar 2024 22:38:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711319894;
	bh=gEgFcLLDiBB0JVgk2uIkggn1J6MoZu+KA+98Ajlgd48=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sMagzXjB3s/QvWZleOk5ThrR2IQoHBohJLP/BR/LpSl63oa8aaZKbPbT9LumQU7fd
	 YvlzJmvez257TRbY/i6kxpA3SoMANg/0eGiCewFebD2cXQM5zWdRXvKCCf4SVa3M8R
	 8dFDdX+5eVPPNpkoG1nfb9EW024L84U+Ibga+Lg8vvKb6jKgdcPivjQ+rlcEVwvQvX
	 Bbv50xHdZ4Bp4fadFGTe7UrT2/qFmpGH5H9jEWZuV8+JrRPoOiM4tCqTEwqPnMBmh2
	 IqH+pV3Y40LRss/P7SHSuvHs/JM3kxCx8x6FFMOrxGGE4fULRhLueFYiTZX+PJRp4W
	 lkHp0Ymga5yAg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Craig Tatlor <ctatlor97@gmail.com>,
	Luca Weiss <luca@z3ntu.xyz>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 199/715] ARM: dts: qcom: msm8974: correct qfprom node size
Date: Sun, 24 Mar 2024 18:26:18 -0400
Message-ID: <20240324223455.1342824-200-sashal@kernel.org>
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
index b1413983787c2..083ab780ab7e4 100644
--- a/arch/arm/boot/dts/qcom/qcom-msm8974.dtsi
+++ b/arch/arm/boot/dts/qcom/qcom-msm8974.dtsi
@@ -1234,7 +1234,7 @@ restart@fc4ab000 {
 
 		qfprom: qfprom@fc4bc000 {
 			compatible = "qcom,msm8974-qfprom", "qcom,qfprom";
-			reg = <0xfc4bc000 0x1000>;
+			reg = <0xfc4bc000 0x2100>;
 			#address-cells = <1>;
 			#size-cells = <1>;
 
-- 
2.43.0



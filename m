Return-Path: <linux-kernel+bounces-112984-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F59D888044
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 23:58:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A07081C20803
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 22:58:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69D9A12BE94;
	Sun, 24 Mar 2024 22:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tR60MWxl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98CA812CDA6;
	Sun, 24 Mar 2024 22:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711319796; cv=none; b=OtyuODrnjs5cJz8JqkCeG5WNI2N6Jq/mlZ3cQh6Mvxdenr2P4/ts7Gv7QQGFGs9DNvc2oKgWVST6X2XeCMUjjiEtJs01uKl8NNP64E/gFzrRR0ONgs0v0wGR0GI6yMx8AzBcyhYbdKXmq7qzRfGIkyBPoJ5V9lTr8Mxz4BaowJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711319796; c=relaxed/simple;
	bh=RBVPrMoX2IbuTed5Qqc5/hGraWjdBztCcc693+RJwvU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OaEOQnH8BROClMlsrHpkwJV+PMZiMbDHvFPDv0tK0ftiAShKgj9QxGjfg4nouJZ76DVHYC2QnhYBc9Hk8CxndBwPXpNZmKxTCvrWNfK7lySPgkyQq1AzTUJ0LxyA36w+Df/z3076C2P5mqnwwCj4kJ+HfRwmOKRQCIkzhc3wudc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tR60MWxl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D68CEC43394;
	Sun, 24 Mar 2024 22:36:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711319796;
	bh=RBVPrMoX2IbuTed5Qqc5/hGraWjdBztCcc693+RJwvU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tR60MWxlq0foMvpyADuoqyZ889GTWU9c4iWbVvAl6mpHS4dzRzCpVsB/+crRiQKsd
	 gq4rmMZniWFViOnVWRQqAO2mvJ1t1whRvKOGlE+bNidISyoVrFaECr13dVcjPYapTX
	 nxQchKfJZtFkjxvAc/HBy2HjlB14ETJH7ooESM+ueSkHhGeZuvf8ePSO52UbuKudFh
	 OLzFrvrMBm/jii9SEQMRFBUUlBlp/agKpdzjvNeMCONpb1bki2DeXuRf3NGmpHPwrJ
	 rms/jfuHCoGGgNDd4/xLhhZ2LVKisxem8D1B+ViGlm3Lu/30TtFLa5jxwM7DxjGOJm
	 YumI4DVSuyQaw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Luca Weiss <luca.weiss@fairphone.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 097/715] arm64: dts: qcom: sc7280: Add static properties to cryptobam
Date: Sun, 24 Mar 2024 18:24:36 -0400
Message-ID: <20240324223455.1342824-98-sashal@kernel.org>
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

From: Luca Weiss <luca.weiss@fairphone.com>

[ Upstream commit 40ec6a2817d927367461fb0335b42b0d494ff927 ]

When the properties num-channels & qcom,num-ees are not specified, the
driver tries to read the values from registers, but this read fails and
resets the device if the interconnect from the qcom,qce node is not
already active when that happens.

Add the static properties to not touch any registers during probe, the
rest of the time when the BAM is used by QCE then the interconnect will
be active already.

Fixes: d488f903a860 ("arm64: dts: qcom: sc7280: add QCrypto nodes")
Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
Link: https://lore.kernel.org/r/20231229-sc7280-cryptobam-fixup-v1-1-bd8f68589b80@fairphone.com
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/qcom/sc7280.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
index 83b5b76ba1794..ce0d24ee7eedb 100644
--- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
@@ -2345,6 +2345,8 @@ cryptobam: dma-controller@1dc4000 {
 				 <&apps_smmu 0x4e6 0x0011>;
 			qcom,ee = <0>;
 			qcom,controlled-remotely;
+			num-channels = <16>;
+			qcom,num-ees = <4>;
 		};
 
 		crypto: crypto@1dfa000 {
-- 
2.43.0



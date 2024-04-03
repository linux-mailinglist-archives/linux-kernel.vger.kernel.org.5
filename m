Return-Path: <linux-kernel+bounces-129448-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E691896B0B
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 11:49:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3EC77B23B13
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 09:44:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FA2C1350FA;
	Wed,  3 Apr 2024 09:44:28 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34ACD13443A;
	Wed,  3 Apr 2024 09:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712137468; cv=none; b=V8rgfa41j2lt+QvM8ejp2sAbTRXw6N95brg21sShdOoHDZVMItLVbPqgSHzqprhB4yLEgTGTeG8DSur8aue3Aeexi9Rs85KW3bi1Twj5b+VmS6CNDdeZYR/kWHTP9XtyA8S9JAODEFmql05YLXVeBeGFS8Wc4G2lFqy9b1+bh0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712137468; c=relaxed/simple;
	bh=tjjs/J6QmalVAsNKAMmXjzvkGPTMvte6QNF55d9wNfk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HhSc0oPmquRIb4Mrhct+dYkldqO1bXFkPtyg+B3l4LS0zekBsk+S3azgkVFM+GcxlOvl3A4HMAxelIY1LkY2wrHzofaHt4PnrMWKH6MDTQcickiytRmRz6PZgSRqRzVY8ctpEn5NsNN44yhy+Oyj9goIAGnZpx3k0twqCxhN6VY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EBDEC433F1;
	Wed,  3 Apr 2024 09:44:25 +0000 (UTC)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH RESEND] arm64: defconfig: qcom: enable X1E80100 sound card
Date: Wed,  3 Apr 2024 11:44:22 +0200
Message-Id: <20240403094422.15140-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Enable the sound machine driver for Qualcomm X1E80100 sound card, used
on several boards with X1E80100 (e.g. X1E80100 CRD).

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

The driver and bindings were posted here:
https://lore.kernel.org/alsa-devel/20231204100116.211898-1-krzysztof.kozlowski@linaro.org/T/#t

Resending because I did not Cc Bjorn/Konrad/MSM.
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 94e677800899..4df6a724349f 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -956,6 +956,7 @@ CONFIG_SND_SOC_SM8250=m
 CONFIG_SND_SOC_SC8280XP=m
 CONFIG_SND_SOC_SC7180=m
 CONFIG_SND_SOC_SC7280=m
+CONFIG_SND_SOC_X1E80100=m
 CONFIG_SND_SOC_ROCKCHIP=m
 CONFIG_SND_SOC_ROCKCHIP_I2S_TDM=m
 CONFIG_SND_SOC_ROCKCHIP_SPDIF=m
-- 
2.34.1



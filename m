Return-Path: <linux-kernel+bounces-48875-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 562AD846298
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 22:27:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89B2C1C21E51
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 21:27:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE69D3EA89;
	Thu,  1 Feb 2024 21:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BtS0Ov1+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B80F3BB43;
	Thu,  1 Feb 2024 21:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706822810; cv=none; b=n0DI+Pf/jSStpnSfTkvfO7GWfpkPcHIDG4FiGhYOG4omujkQUffx1A2P4gkifmrYP2BqHOCVBlk77AV21hBS5mqLGEBVLLN0tbi1D0klvKiyYhtnQl18ealixMq3Wgb/KJadWeUZTZ27vQh4brLN1LcEhPQZTLDY1np78d/6NUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706822810; c=relaxed/simple;
	bh=VR/a8iPw20/aKaajgHIqiK8JjLNzC/p31Ouefl5Ivf4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=eL8Dpk7rGjIxKespS9z4zZ3wU8dY/oDOLdnCr4dHu7YYqWSLH4kaH5iiICqL1eaR679vmntbS5ld8i0n/Hey1QeyQwikvObMLQ1gVHNR63MEnkFLXw+PAmtQkWHUA/MqRMUcHL/twJ5/f4+jFr7D1i5HkxeKeZ3OqG97kEy8i+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BtS0Ov1+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A1F73C433C7;
	Thu,  1 Feb 2024 21:26:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706822809;
	bh=VR/a8iPw20/aKaajgHIqiK8JjLNzC/p31Ouefl5Ivf4=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=BtS0Ov1+1n+xvhX3KKNy3PGrDN4AN36h2uDo8s7rAav3imdzYMX6hRv/7sPDNtHhm
	 JLS/ALKNre5XLmxInWzUbB0pqABgk9ILP0pvP9F6qhhqoNlsKyodtdgi6n1SZxF28J
	 iDzaww089UYYy70BCDRV/eWO7QVBMv5katAFqSxATPCXdrmkCTsrBcREjOoJELKYwk
	 DlkTldw8n8u0icffmLBqwMtcUx+s02YyknNSicAIiJPflOYZJxk9NaUZtf7eXHLhAj
	 XndIkJITGuw1s3Vl4cuIgM++o737FRBuG3CS3/djQZH4O1xs4PiWrzVs4uwR7fQ5mG
	 Am8JXDXY31YAw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88AEDC4828D;
	Thu,  1 Feb 2024 21:26:49 +0000 (UTC)
From:
 Bjorn Andersson via B4 Relay <devnull+quic_bjorande.quicinc.com@kernel.org>
Date: Thu, 01 Feb 2024 13:31:19 -0800
Subject: [PATCH] arm64: defconfig: Enable Qualcomm interconnect providers
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240201-enable-icc-8250-2290-v1-1-8ded02750521@quicinc.com>
X-B4-Tracking: v=1; b=H4sIAKYNvGUC/x2MSQqAMAwAvyI5G4ih4vIV8dAlakCqtCCC+HeLx
 xmYeSBLUskwVg8kuTTrEQs0dQV+s3EV1FAYmNgQU4MSrduL9R57bgmZB0JnFtsF37khCJT0TLL
 o/W+n+X0/dim61WYAAAA=
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Will Deacon <will@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, Bjorn Andersson <quic_bjorande@quicinc.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=1606;
 i=quic_bjorande@quicinc.com; h=from:subject:message-id;
 bh=PrRvWI3v6LUZy5gGPJMmYHZxgRkosEui53nfZHHVYmI=;
 b=owEBgwJ8/ZANAwAIAQsfOT8Nma3FAcsmYgBlvA2xeaQWX56SHdES03wVrRhZc5n1qzqikkpUs
 3iffg/eBJaJAkkEAAEIADMWIQQF3gPMXzXqTwlm1SULHzk/DZmtxQUCZbwNsRUcYW5kZXJzc29u
 QGtlcm5lbC5vcmcACgkQCx85Pw2ZrcXURBAAp2ZEzZ5VHTUvPh2jGmshtNoJ3rw3667luu9Wa7O
 +zTrJzuPVMYydm7VBER85Vvz2NSgXfE4M3syN8q4856+zE81uXPERay+k9J/7NTCyZpWLdvWYT+
 y9O0EpDD3hRPYagegaM0kj3saPdlPwIP/pMiwkG0gwcwWceSdxbLu0aSIumtNSwLkeJfWm9iFbN
 mvBvbtnNg50DmZ1IH0LFv0uNJ5h3Btb9gWD+ceuvD0BpQ8ivkggeXN74faBQteo4/VGrYqKFVKU
 BQNu7dQKtsKGAKw8VAriuqbRds/2fQTJbofvuMYoZA4eOeObgVKytdazSZmWfMrHIaQ58ei2WqJ
 I/JBxirh5Xf5daHQHseUSdljmdjF38naBdAgBtTG2/jA5T3eJjsDXkL5tiru9j/K+RHm1p00L29
 weMqHbyBtPrngyzUCu2jAZOhM8aJ4ByZu1LVyWYykMy+PUC31N0jq/kHLMXFIRGA50W47zMaI2N
 Zx3WH8eL9pxWag2AmJy3exSm0Jcbs3EYlz7TZDoVI3A36KSmAkBVSnhe1nd9llOocQ8hTdp3igs
 HgqkaqO9uXaKi2Uze3EgOB4evzb6FUXiVBZ8BB32sGmuwhsnO49WM4IP8gdTDntR1YDJalAGmRU
 F7UTvz0iCJqNPSCKaKu4QmwlBL2xQ71ia7Af6tfUV0RA=
X-Developer-Key: i=quic_bjorande@quicinc.com; a=openpgp;
 fpr=05DE03CC5F35EA4F0966D5250B1F393F0D99ADC5
X-Endpoint-Received:
 by B4 Relay for quic_bjorande@quicinc.com/default with auth_id=118
X-Original-From: Bjorn Andersson <quic_bjorande@quicinc.com>
Reply-To: <quic_bjorande@quicinc.com>

From: Bjorn Andersson <quic_bjorande@quicinc.com>

With interconnect providers built as modules Qualcomm SM8250 and QCM2290
platforms launches init without /dev/console being backed by the debug
UART.

Build there drivers into the kernel, to make sure the dependencies for
the UART driver are available and thereby give userspace access to the
UART without having to re-open the console, once the deferred UART
driver has probed.

Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
---
 arch/arm64/configs/defconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index e6cf3e5d63c3..0463db563215 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -1550,7 +1550,7 @@ CONFIG_INTERCONNECT_QCOM=y
 CONFIG_INTERCONNECT_QCOM_MSM8916=m
 CONFIG_INTERCONNECT_QCOM_MSM8996=m
 CONFIG_INTERCONNECT_QCOM_OSM_L3=m
-CONFIG_INTERCONNECT_QCOM_QCM2290=m
+CONFIG_INTERCONNECT_QCOM_QCM2290=y
 CONFIG_INTERCONNECT_QCOM_QCS404=m
 CONFIG_INTERCONNECT_QCOM_SA8775P=y
 CONFIG_INTERCONNECT_QCOM_SC7180=y
@@ -1560,7 +1560,7 @@ CONFIG_INTERCONNECT_QCOM_SC8280XP=y
 CONFIG_INTERCONNECT_QCOM_SDM845=y
 CONFIG_INTERCONNECT_QCOM_SDX75=y
 CONFIG_INTERCONNECT_QCOM_SM8150=m
-CONFIG_INTERCONNECT_QCOM_SM8250=m
+CONFIG_INTERCONNECT_QCOM_SM8250=y
 CONFIG_INTERCONNECT_QCOM_SM8350=m
 CONFIG_INTERCONNECT_QCOM_SM8450=y
 CONFIG_INTERCONNECT_QCOM_SM8550=y

---
base-commit: 06f658aadff0e483ee4f807b0b46c9e5cba62bfa
change-id: 20240201-enable-icc-8250-2290-b4fa7dc7b9de

Best regards,
-- 
Bjorn Andersson <quic_bjorande@quicinc.com>



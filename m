Return-Path: <linux-kernel+bounces-124510-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DE0E5891918
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 13:35:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6DE9DB24381
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 12:35:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B99112D74F;
	Fri, 29 Mar 2024 12:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ek7Ve/lD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74C9812DD92;
	Fri, 29 Mar 2024 12:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711715270; cv=none; b=gyyKQJrTOz4iwVAsNkMhzP1GC827tVr2jnjsbqNQUrE9mq31jNWHv3gMxx9UixxRLU65UuCfQsfBnjpQ1C4ZdpP2jDUYGkNCziq3h23trP0+9Nqud1YClIOrIgNDSQhDEjh2B2gPEQbfniXE8FYjUiYxBgS6or+OVcOKrY51xYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711715270; c=relaxed/simple;
	bh=gp+qQNDIXBTr3j2Cxv3o0dcbn3KSps6lPF3MT/eFmrI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XlPzUCSxDAznLuE58tz6/t5PZnCTgu6e1CdeJLSWVV6K7ZGIcTdjY60sdPF0OdleHTaerRPz5K+oxMQSe91FQkcm8f1oO116/q8b7JV9fgkmOcYNiYY4MyYY9tt2tMYa/D6t7c6ciQjJEc8aTv6TC+7Z1K8d1pcVbufubDiSgnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ek7Ve/lD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE92CC43399;
	Fri, 29 Mar 2024 12:27:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711715270;
	bh=gp+qQNDIXBTr3j2Cxv3o0dcbn3KSps6lPF3MT/eFmrI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ek7Ve/lDZHRy2GihJpX+szc82zAVeL5MJhyyEZKkr0XC6SmNyv7F8JgTw234QKUSW
	 NF/gr3nmYz0DRWe6tqHaTV+DfYqjctdgMoK1AQatM11aujZX3vaGbRcKAku7+ZIziy
	 Hj8LHC68AE3oPDfSy+inY1tMyF6R4j44lYZN5OUpEtYhcjn59otuZkCWoTw0J74R60
	 HCQGivM8+6xRfwagTNGHnCWHmAwiMXhHTkGp7W5vg8WYCQzjfxrLz1YSpezVjHTcfQ
	 q+QEDirTs+9GLWkz+P/HPgBDZbwL6ud45JwF24KSGifkAW9ifAg+UbnEtlv5kfb9Dp
	 BD6U+8AlUhOCQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Bjorn Andersson <quic_bjorande@quicinc.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Luca Weiss <luca.weiss@fairphone.com>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH AUTOSEL 6.8 29/68] arm64: dts: qcom: qcs6490-rb3gen2: Declare GCC clocks protected
Date: Fri, 29 Mar 2024 08:25:25 -0400
Message-ID: <20240329122652.3082296-29-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329122652.3082296-1-sashal@kernel.org>
References: <20240329122652.3082296-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.8.2
Content-Transfer-Encoding: 8bit

From: Bjorn Andersson <quic_bjorande@quicinc.com>

[ Upstream commit 7c6bef576a8891abce08d448165b53328032aa5f ]

The SC7280 GCC binding describes clocks which, due to the difference in
security model, are not accessible on the RB3gen2 - in the same way seen
on QCM6490.

Mark these clocks as protected, to allow the board to boot. In contrast
to the present QCM6490 boards GCC_EDP_CLKREF_EN is left out, as this
does not need to be "protected" and is used on the RB3Gen2 board.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Reviewed-by: Luca Weiss <luca.weiss@fairphone.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
Link: https://lore.kernel.org/r/20240209-qcm6490-gcc-protected-clocks-v2-1-11cd5fc13bd0@quicinc.com
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts b/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
index 8bb7d13d85f66..ebbe2c1123f6e 100644
--- a/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
+++ b/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
@@ -413,6 +413,23 @@ vreg_bob_3p296: bob {
 	};
 };
 
+&gcc {
+	protected-clocks = <GCC_CFG_NOC_LPASS_CLK>,
+			   <GCC_MSS_CFG_AHB_CLK>,
+			   <GCC_MSS_GPLL0_MAIN_DIV_CLK_SRC>,
+			   <GCC_MSS_OFFLINE_AXI_CLK>,
+			   <GCC_MSS_Q6SS_BOOT_CLK_SRC>,
+			   <GCC_MSS_Q6_MEMNOC_AXI_CLK>,
+			   <GCC_MSS_SNOC_AXI_CLK>,
+			   <GCC_QSPI_CNOC_PERIPH_AHB_CLK>,
+			   <GCC_QSPI_CORE_CLK>,
+			   <GCC_QSPI_CORE_CLK_SRC>,
+			   <GCC_SEC_CTRL_CLK_SRC>,
+			   <GCC_WPSS_AHB_BDG_MST_CLK>,
+			   <GCC_WPSS_AHB_CLK>,
+			   <GCC_WPSS_RSCP_CLK>;
+};
+
 &qupv3_id_0 {
 	status = "okay";
 };
-- 
2.43.0



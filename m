Return-Path: <linux-kernel+bounces-99393-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B4D668787C3
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 19:42:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 548281F24A64
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 18:42:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 655B44084A;
	Mon, 11 Mar 2024 18:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZH/G0zQT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A8A856B8F;
	Mon, 11 Mar 2024 18:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710182278; cv=none; b=LG+87U4jUfGnhLBasX8v4mZ6qzWT22YHLn5Zk6BQou5HAFg4zI6abt8JovKawZx8PXpQnY4axvx1yzG2Dwf2q5tKg1REJKfiqo3A9pLgSSWQzQAYixNPuoxVKXqoQjTOK4CWa+LoKSGHRc6mWRNmbtZUChk6DSMf9CRy1KHgdPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710182278; c=relaxed/simple;
	bh=TrTV18yl4VRw9q2qnX3Xx3k96Du1jyisaNz4ZlqRnRU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uqvR58h1c2K9tvbU/tlO8vTmRtuW9clbCl7g7ttgI5lFMAYRlEx403nFsHGY4sUY11qiU5VJYSdctBJi3kfy7UwBtnEaQYg/JKiDkJsvG9mXFFOzpKmC/pn25up2scpjWKavG4ulsNMxlWuf2Ei6jpwaMbelFpKVEq5KM4PXDFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZH/G0zQT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88F46C433C7;
	Mon, 11 Mar 2024 18:37:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710182278;
	bh=TrTV18yl4VRw9q2qnX3Xx3k96Du1jyisaNz4ZlqRnRU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZH/G0zQT0MsCqaG3lXV49awkEYO0f4UJjV3fZfcnZQ1yERVHTIHqFQpOd/5FVo6He
	 BDs3QHOC/uX+hM0EJAEb2QmgJdJZeZfrFfhh8se+j4KEAq/gaAdAvwDJSATZ9EdKDZ
	 +u69lHgmpC8MaVDQs4ahgtAiL++QptwbKUbHpKVt3fAQ1rfomQxODDHYa7ZqnQ9IJP
	 W7Qh5eMfSI4i9KVsrkVgdXYIk1mCre1HSiP+Dn+zxT+WQOO7lLI0Nxe67C9UzdeyFL
	 iQwcqk02gWNkBbWVEQPV4lU/rbhdhNEdX454uSH5bVEkS9m1PxVMIH7Ju3+XWXM5c9
	 9ulyA2dsxZ57Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Johan Hovold <johan+linaro@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	andy.gross@linaro.org,
	david.brown@linaro.org,
	robh+dt@kernel.org,
	mark.rutland@arm.com,
	linux-arm-msm@vger.kernel.org,
	linux-soc@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 05/12] arm64: dts: qcom: sc8280xp-crd: limit pcie4 link speed
Date: Mon, 11 Mar 2024 14:37:19 -0400
Message-ID: <20240311183727.328187-5-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240311183727.328187-1-sashal@kernel.org>
References: <20240311183727.328187-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.21
Content-Transfer-Encoding: 8bit

From: Johan Hovold <johan+linaro@kernel.org>

[ Upstream commit db8138845cebcdd0c709570b8217bd052757b8df ]

Limit the WiFi PCIe link speed to Gen2 speed (500 MB/s), which is the
speed that Windows uses.

Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Link: https://lore.kernel.org/r/20240223152124.20042-7-johan+linaro@kernel.org
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/qcom/sc8280xp-crd.dts | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts b/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts
index ffc4406422ae2..41215567b3aed 100644
--- a/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts
+++ b/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts
@@ -563,6 +563,8 @@
 };
 
 &pcie4 {
+	max-link-speed = <2>;
+
 	perst-gpios = <&tlmm 141 GPIO_ACTIVE_LOW>;
 	wake-gpios = <&tlmm 139 GPIO_ACTIVE_LOW>;
 
-- 
2.43.0



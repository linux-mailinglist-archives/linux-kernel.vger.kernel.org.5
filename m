Return-Path: <linux-kernel+bounces-112985-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9F78888046
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 23:58:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F291280F7F
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 22:58:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C65012D1FE;
	Sun, 24 Mar 2024 22:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Eqg9wvrO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 916C112D1E1;
	Sun, 24 Mar 2024 22:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711319797; cv=none; b=M+QARm18X0w2LeqtthG8CB5Wg89Fnflr120/8ri4Jd/lP3UyrgUFK2FbkhvCMjr5CflD3z6rXXe1ZWI7pygoGVPrABDnMrL8hJ3wl3/Rpmt4FOlEsxLVWPDz/unL+lbRtoDxxoCm3YIR6VzFsaOvYZ77j0zDx0jnPoSQCqtVjRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711319797; c=relaxed/simple;
	bh=lVhF2tyAdyjMo5qbbEvNAsIr+Sohc3Mo7jrDyWXP6mc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CBZAnDYbba2CtP1FMVsSHseHwHFG3BHcNNqss/hYHRZtmc+vi4uP1e0Gl1EFgUnz2n312YNZ+FuzwAkHOLlBK1fEc7sSHpRSdlclMPm75sQ7pCYxNltXfLO/E24bWN5gaQEmZja1OC24Sp4uLVF4Yd7uqPWd+MUR9/pDxxk5lXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Eqg9wvrO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD84CC433C7;
	Sun, 24 Mar 2024 22:36:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711319797;
	bh=lVhF2tyAdyjMo5qbbEvNAsIr+Sohc3Mo7jrDyWXP6mc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Eqg9wvrOFj4nlko8v/CmXgy2A33p3d0Ro8ZcQOr7euT2/5vhXumBbd3OxDmPh+8AV
	 qbSW0Ei2R35l9zwijsTi3xKAc4kvr4EFzTsqDBBMCbXitQXUR2+hDFko+U9T/CCD5E
	 4SkjfsY1HSpyDeG66qCdqcELE2+G6brrYl2l7I27PuLafdT2SNGEb1+fTS0I421H+/
	 DiXsTGttvjgoxaDL/2rqcFdGQDKdkO3nb1jgPISattp9H9/K93sKEdL8gDkwYDBmHc
	 MRNo54ffW76eUSRsRp2u4u4OVw+SOLa0zpJL+4FwK5YCLyGtmTbzQxZRp26i45qORs
	 Jnc8spwUa19tw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Luca Weiss <luca.weiss@fairphone.com>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 098/715] arm64: dts: qcom: qcm6490-fairphone-fp5: Add missing reserved-memory
Date: Sun, 24 Mar 2024 18:24:37 -0400
Message-ID: <20240324223455.1342824-99-sashal@kernel.org>
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

[ Upstream commit 5dbbe7e0a2b91ac5901ee188724a997004759171 ]

It seems we also need to reserve a region of 81 MiB called "removed_mem"
otherwise we can easily hit the following error with higher RAM usage:

  [ 1467.809274] Internal error: synchronous external abort: 0000000096000010 [#2] SMP

Fixes: eee9602ad649 ("arm64: dts: qcom: qcm6490: Add device-tree for Fairphone 5")
Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Link: https://lore.kernel.org/r/20231229-fp5-reserved-mem-v1-1-87bb818f1397@fairphone.com
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts b/arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts
index 176898c9dbbd7..1e85c43a6fd14 100644
--- a/arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts
+++ b/arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts
@@ -82,6 +82,11 @@ cdsp_mem: cdsp@88f00000 {
 			no-map;
 		};
 
+		removed_mem: removed@c0000000 {
+			reg = <0x0 0xc0000000 0x0 0x5100000>;
+			no-map;
+		};
+
 		rmtfs_mem: memory@f8500000 {
 			compatible = "qcom,rmtfs-mem";
 			reg = <0x0 0xf8500000 0x0 0x600000>;
-- 
2.43.0



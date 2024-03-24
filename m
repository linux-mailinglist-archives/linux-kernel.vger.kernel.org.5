Return-Path: <linux-kernel+bounces-115404-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C64B8893E6
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 08:41:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 94207B29923
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:38:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DE6613443B;
	Mon, 25 Mar 2024 02:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u1yt5nKK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09FB71D793D;
	Sun, 24 Mar 2024 22:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320611; cv=none; b=INxRn4GqxKLsvqtvyg41Pn8n+u/8k7mYlOk19QOLvtbljn+4IU2MuCJq8friBut/kxiUuyrCHspEaI5pKXMI3NuQfKmJU/jMTIc/kgAHKTW39+k51qGdUME2xSZmsHmJr/3nvE7H2J0TE3rhmkPHIlttgifQazpmx8DCR0+8osU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320611; c=relaxed/simple;
	bh=UcRpu7p1jKQyG+pfEXtk4kRecvA2V6BI+5dODNtRxC4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eUCFAWbce6rk4CkmyYPjB9gd4amxRpnxhIUcMtYo0XheAI9ZzWiIF/kvMPR5WTfqNVRTVCZvitLH6xFz8KVic0CKaXOuIR+hJPgR29Qpdpklszt0AUq4MBqgl19pIptq7uUsQhl0TFrD9jk4CG6Jl9BjMN8O6+huMnEVNKGndH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u1yt5nKK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14440C43390;
	Sun, 24 Mar 2024 22:50:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320609;
	bh=UcRpu7p1jKQyG+pfEXtk4kRecvA2V6BI+5dODNtRxC4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=u1yt5nKKcltx8qKOxuLCkkUPwU+5UKUlk+SS2jQwNK0LG2+jw5I6TOv47BkR0htMf
	 m9ryvDV20sJDWLq46Q/cCefmBbGo9J/JCnDaQmQ5pau+NwHqXzq39ynJTPWomTvGu3
	 tfmx3b/RCLUA7AQRQdiPdjIOKAJbhkRgb8VuE/1ZCGjgjcDC9BSBa9QrgqXU2PZCzt
	 NSDsKesf0Sgd7RvMaBcMYc4oxThzOzbZ8+zuRV2oeeYu7bR2IisAl+JwX2i7olJecc
	 HlSP48P6toa8Kxu87w0uHGq0fv6QtwTngDiE5GLHwUDIhuxCoXCDPTh8ZO7h9HWRRO
	 aru/0a2fhKmaw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Bjorn Andersson <quic_bjorande@quicinc.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 170/713] arm64: dts: qcom: sa8540p: Drop gfx.lvl as power-domain for gpucc
Date: Sun, 24 Mar 2024 18:38:16 -0400
Message-ID: <20240324224720.1345309-171-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324224720.1345309-1-sashal@kernel.org>
References: <20240324224720.1345309-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Bjorn Andersson <quic_bjorande@quicinc.com>

[ Upstream commit fd5821a1a83c969ed2dcc72fef885f3a82c1d978 ]

The SA8295P and SA8540P uses an external regulator (max20411), and
gfx.lvl is not provided by rpmh. Drop the power-domains property of the
gpucc node to reflect this.

Fixes: eec51ab2fd6f ("arm64: dts: qcom: sc8280xp: Add GPU related nodes")
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
Link: https://lore.kernel.org/r/20240125-sa8295p-gpu-v4-5-7011c2a63037@quicinc.com
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/qcom/sa8540p.dtsi | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sa8540p.dtsi b/arch/arm64/boot/dts/qcom/sa8540p.dtsi
index 96b2c59ad02b4..23888029cc117 100644
--- a/arch/arm64/boot/dts/qcom/sa8540p.dtsi
+++ b/arch/arm64/boot/dts/qcom/sa8540p.dtsi
@@ -168,6 +168,9 @@ opp-2592000000 {
 };
 
 &gpucc {
+	/* SA8295P and SA8540P doesn't provide gfx.lvl */
+	/delete-property/ power-domains;
+
 	status = "disabled";
 };
 
-- 
2.43.0



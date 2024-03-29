Return-Path: <linux-kernel+bounces-124515-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19061891930
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 13:37:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A3F71C24BFE
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 12:37:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B981A1448C3;
	Fri, 29 Mar 2024 12:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UIECqaRV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0CE713342F;
	Fri, 29 Mar 2024 12:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711715279; cv=none; b=Yfr5w2nuP7NUpFWCAWaDlQ7alvBgsMiCs7HegI0nb67Yt/hj8WTh/vSwIJUb+2IVvZ7B39xZvVyaBeZ6LTkXKkH0JDqkYQT+3mQ98ja0dge3igy0XBDFAWv8rNz0v5JpJYNlK54IzQiEQRnbbCeQZG/r9aKrcdQT0pQdqazixmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711715279; c=relaxed/simple;
	bh=Kps7FkLHl15XxPJabm+dtUCA7YF7PfDf7FI2VXBD8Ps=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YWXM2yifJDCEkQK1XVQeu8SqDzKU4t+vd3nnmAI0zOAipuseC6RVn1SsumMDdDBpnb/A9fgB5yi3Rqh9lfePOh/C7EOuKh7pm9IdgeFwDwPILBkXJ6pjZiMSeWOUvq46U/U1W6GfvDKrgPOWx9wV6yPNinxJ7/FiVKivKXe6IwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UIECqaRV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D43AC433F1;
	Fri, 29 Mar 2024 12:27:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711715279;
	bh=Kps7FkLHl15XxPJabm+dtUCA7YF7PfDf7FI2VXBD8Ps=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UIECqaRVmPdcX7JUnUxIsh+5MreHWoTVA9JlZkLMi9IGDYC+/fFiwHMRblS4JRzGs
	 N8OJsY9cSSeNNLfIuU9cHZa14ozvuJJ9KHYK3UOji0C73Fs9FhU/RQjCqoRkLwRVv/
	 p7sEJkDABNz8DZuiXkuRFXewG91dqjSXq/jNxUpbAHmPxfqFXtN4wqsgvPXF6aIlkr
	 qSJrChbcWMpewsQUElFIaWxQyqvJLJhbSDOywZ6JoG5aNjJ7L8fe+ucrBQ8lwoc5eY
	 650srB6MddVY4HJB0XKd/uC/pdp0kPml7XCBu2wLbudVfYWdyofDcM9Tj8uWNAFZ8b
	 R32JllQgy+MzA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	konrad.dybcio@linaro.org,
	robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH AUTOSEL 6.8 34/68] arm64: dts: sm8550: correct DMIC2 and DMIC3 pin config node names
Date: Fri, 29 Mar 2024 08:25:30 -0400
Message-ID: <20240329122652.3082296-34-sashal@kernel.org>
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

From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

[ Upstream commit c6e5bf9278749eaa094dc944add747f10a15dceb ]

Correct the TLMM pin configuration and muxing node names used for DMIC2
and DMIC3 (dmic01 -> dmic23).  This has no functional impact, but
improves code readability and avoids any confusion when reading the DTS.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Link: https://lore.kernel.org/r/20240212172335.124845-3-krzysztof.kozlowski@linaro.org
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/qcom/sm8550.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8550.dtsi b/arch/arm64/boot/dts/qcom/sm8550.dtsi
index ee1ba5a8c8fc2..a6663eefd3a30 100644
--- a/arch/arm64/boot/dts/qcom/sm8550.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8550.dtsi
@@ -2507,7 +2507,7 @@ data-pins {
 				};
 			};
 
-			dmic02_default: dmic02-default-state {
+			dmic23_default: dmic23-default-state {
 				clk-pins {
 					pins = "gpio8";
 					function = "dmic2_clk";
-- 
2.43.0



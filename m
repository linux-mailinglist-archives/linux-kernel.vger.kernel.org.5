Return-Path: <linux-kernel+bounces-115696-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6420E889672
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 09:51:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 19279B22290
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:58:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64DB225927B;
	Mon, 25 Mar 2024 02:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PrEU9NZf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D889B20F227;
	Sun, 24 Mar 2024 23:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321672; cv=none; b=rdZPteAtE/lc2zFrjIOz2B7zb6DzwoBwXC3VNesCNQxfOr2Od05xOgciID4QKgP5STVim4w1SMwCeQqhYfkvkAlqNHKJAvaMcw+5AtIkP+/n+sf/JMD10N05Ahb6aM7pMDRb2wVBXbXGq+PzKpT53yAnfYnhhYtSzdaBeGrdsCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321672; c=relaxed/simple;
	bh=dNSXUR4F0PInX+6if0T8q039HcQHl4ObxNFwJQJpwJI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tgjkonuYg73LN/7qU9GOCs/KaUSoybecYvnjfuQuleWR+AX95WR/s1z6DCo4e4g1UqRKBxt/Y+gBmQcItil/SkzxUssoy8jeRVpN1DUStKsqztcbBZP1lrlWv2aYmbmH81SiVFXBU2mhogbnTpJjl9EW0CWW51GhLWBcEyCk/7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PrEU9NZf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D091C433F1;
	Sun, 24 Mar 2024 23:07:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321671;
	bh=dNSXUR4F0PInX+6if0T8q039HcQHl4ObxNFwJQJpwJI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PrEU9NZf+Kj/QOpeSfAj+uP7Bpf9Q/EnMIdJGp+ncoeV3Q8JLyTHpftck+CaASUrN
	 8sAEBoOJLpHJvobj+D5OFPpZCgPVu1WxWvnUejSjAP6uU7jW1c/ck3HGTeG6xRU7bJ
	 vK791ExkW69UXTvKt/lLa8KT7i0MHxukhjXablNGmTdsHu90Pzyxa6cHCmGR5+fmOo
	 oevZYeKt7GclD+8Tj5h3AEPRrUzhQPC71H134jmfNXDXWj84DLeJXj27PVMaWy0Jos
	 vs/wduOSvaWBMCYEZ1qFZJwiexuH/oFx0EmZs87A8zqcOA28fGwLKextuMH82uvhdR
	 J4kD+VE4zCTRw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Adam Skladowski <a39.skl@gmail.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 400/638] dt-bindings: msm: qcom, mdss: Include ommited fam-b compatible
Date: Sun, 24 Mar 2024 18:57:17 -0400
Message-ID: <20240324230116.1348576-401-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324230116.1348576-1-sashal@kernel.org>
References: <20240324230116.1348576-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Adam Skladowski <a39.skl@gmail.com>

[ Upstream commit 3b63880de42bd3cb79c2a99949135a8f2441c088 ]

During conversion 28nm-hpm-fam-b compat got lost, add it.

Signed-off-by: Adam Skladowski <a39.skl@gmail.com>
Fixes: f7d46c5efee2 ("dt-bindings: display/msm: split qcom, mdss bindings")
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Patchwork: https://patchwork.freedesktop.org/patch/575290/
Link: https://lore.kernel.org/r/20240121194221.13513-4-a39.skl@gmail.com
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 Documentation/devicetree/bindings/display/msm/qcom,mdss.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/display/msm/qcom,mdss.yaml b/Documentation/devicetree/bindings/display/msm/qcom,mdss.yaml
index 0999ea07f47bb..e4576546bf0db 100644
--- a/Documentation/devicetree/bindings/display/msm/qcom,mdss.yaml
+++ b/Documentation/devicetree/bindings/display/msm/qcom,mdss.yaml
@@ -127,6 +127,7 @@ patternProperties:
           - qcom,dsi-phy-20nm
           - qcom,dsi-phy-28nm-8226
           - qcom,dsi-phy-28nm-hpm
+          - qcom,dsi-phy-28nm-hpm-fam-b
           - qcom,dsi-phy-28nm-lp
           - qcom,hdmi-phy-8084
           - qcom,hdmi-phy-8660
-- 
2.43.0



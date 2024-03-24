Return-Path: <linux-kernel+bounces-113844-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBEB28886EE
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:46:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85118286F9F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:46:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52FC72046CC;
	Sun, 24 Mar 2024 23:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n9jnRJ8D"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD0D01E85D9;
	Sun, 24 Mar 2024 22:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320884; cv=none; b=JYxjMWWn4VXQIZZCSVfJv/fhUiYpxwXumDRgFMboAXRStdnUOYIz1GN8+UgAgSqc1KzPXki4pAWjKTvZjNd2m6SP71UJsvJ35m/tdkId4iJj9hj/MsEAfUmuzywslpjZrorsDwQdNSCPCo41XJcDSgHGw767FyEK4n5lXxLWBIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320884; c=relaxed/simple;
	bh=dNSXUR4F0PInX+6if0T8q039HcQHl4ObxNFwJQJpwJI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=odAQ/Nkcor15pQQwwoppeTbtm9zHpKD+7uce8EYjKAsI/1izqEIrJwxF6OFK5A9fK89+G3Z/lJNVyNvfzlB1SL0i6bPoEPGLK5vq0wSYHELGtrm6KuHnf7zNaeS18ESjp/YcEZeGxRD80V2fw9pJ/G2Le8l0Q0m/rBzYf9RzWmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n9jnRJ8D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02619C43394;
	Sun, 24 Mar 2024 22:54:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320883;
	bh=dNSXUR4F0PInX+6if0T8q039HcQHl4ObxNFwJQJpwJI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=n9jnRJ8DsMV1fvWG2b3FSek9GpSxKurLN2hsNVbyA9VSictXL7bli5MjS2QugQJzD
	 jkqsg9okdH8rYqoSA2RIThvkQC8l7GmKPAolMxQpJHCcd08k0VIyB0Qy/ow/gdriai
	 zYB/GIE8N6Btsx54shpN3sdmwBXmLTFoomHXBERQc/6rBo/Q7ZOei2a9WTykFcp+CX
	 YdRuyQPM7PGecvwVC7bMtagEakzBSKJ6OK8C7EcLzCjCsw/TnOfgyM1+wk8AgR1DzT
	 wTcsaj+32B4rLD1DVeOaf5JtX5uCmQlE6Oq5TqsOqd461FxtVIugNakl1oz+yXOxej
	 PDNLYFpfXUPsg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Adam Skladowski <a39.skl@gmail.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 447/713] dt-bindings: msm: qcom, mdss: Include ommited fam-b compatible
Date: Sun, 24 Mar 2024 18:42:53 -0400
Message-ID: <20240324224720.1345309-448-sashal@kernel.org>
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



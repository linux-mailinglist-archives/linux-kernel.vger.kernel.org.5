Return-Path: <linux-kernel+bounces-113306-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ED96888346
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:05:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 804EA1C2360A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:05:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98AE0191EB0;
	Sun, 24 Mar 2024 22:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RXtD7YZh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAD44191E95;
	Sun, 24 Mar 2024 22:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320107; cv=none; b=gRCmcQXusgKbB0lVSeGgD8SGGTnNGtGsdml/yjjIUccLfh7wBkSybCSKYhTFqldhfGYq7YPSAuNZoEFLdw1WrdruDli9ypICbLZzRjEDNKx2le2XE94L6JZ7nXCsk/qtHqP6s2/ex3KuLOwOCZf5Joym8KKROZNSqceqwDEGHTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320107; c=relaxed/simple;
	bh=dNSXUR4F0PInX+6if0T8q039HcQHl4ObxNFwJQJpwJI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Khz+EY80BhlJ9H0UgjTttrD24vJWEhzvBuYObSPS20vMjRG1iKWnw5zwCpHv5p7Fje6s3PS6zBAZmZT02bLDTOw8+rfwmBmwcFpESCvqDrZJRHRNkHUIlQbSqmMCOIQueWAbNpA4vW9wPCvb6FG5bvGZ4aG6W5KEnrVKVQ8Krw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RXtD7YZh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA5DDC433B1;
	Sun, 24 Mar 2024 22:41:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320107;
	bh=dNSXUR4F0PInX+6if0T8q039HcQHl4ObxNFwJQJpwJI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RXtD7YZhQuiyVyqp/wQ1QgjW2+7YmIh3hBvST1PmNBouwZxPHLoWjerC4fMQKHK/r
	 83GHu861ucnxkzH68lH3uboBnXAe2pahyRi76pzekWTpcIW8yCuF5ELmyjHw9CISNi
	 ael03MvcqKujqC5EHE3X6sk5nw217Ay8M5RWBpI5pcadgrFq1eHt3F/uHQE4oiZhBb
	 iUK8gyUOwQEBycSlhdLiPE3K1xX9CSM2gNcQgFm2d+2inwxuuSlCXR2hcO0ZgTPC3e
	 SR4rBtgmvt8MLGZNpWc0lwm90q7I0+UPf1AsMr5HB/CqmfSz0IU9mZKmOHZzckTeoy
	 edtnYqyBBEWbQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Adam Skladowski <a39.skl@gmail.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 415/715] dt-bindings: msm: qcom, mdss: Include ommited fam-b compatible
Date: Sun, 24 Mar 2024 18:29:54 -0400
Message-ID: <20240324223455.1342824-416-sashal@kernel.org>
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



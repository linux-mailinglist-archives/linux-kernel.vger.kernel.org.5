Return-Path: <linux-kernel+bounces-165008-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C225D8B8669
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 09:51:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E34FBB21FF1
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 07:51:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 011884E1CB;
	Wed,  1 May 2024 07:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y4qFAx58"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C4684E1CE;
	Wed,  1 May 2024 07:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714549860; cv=none; b=AxLOlTyLywGfTYUJi6cGSG6pWQRknqUqsyTANyA7imZ+d94Di9+qbpwmZ0CJzF4BT7dmMRIhumFWLGxqzYIByoykYkV8F23uZQ4JLdal2KWQ+hdU7aywkxF4mM3ts4WuZpyNFUbztX4DApv0ZzLSJhrHip3nFTjiSVXwD2jEG4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714549860; c=relaxed/simple;
	bh=PuomMsnDC/+v0wckS019MPx5+S2jUMgw0Wzxv4Tf6sI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=I6BmWOXj6KhvyrWNd4lhHYYPsc6Xyb2eDgZ8/Ik1R2bu5tsYRNZ8hOQNd9GjZd/G593mubSR8E3S6Epdkyg8cZZEzMSRGtqUxy4J6kshhKknDKKPtAcljADSKP1Hd+MGMc+vTmyxjyEUvFbFvaKpC1d+DbPZw6y4Fz7Nv8bPTCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y4qFAx58; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6FAEC4AF14;
	Wed,  1 May 2024 07:50:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714549859;
	bh=PuomMsnDC/+v0wckS019MPx5+S2jUMgw0Wzxv4Tf6sI=;
	h=From:To:Cc:Subject:Date:From;
	b=Y4qFAx58w+Ryv1rc+De0MRndV5pVfFBoo0B/ygSqAteErX+IpZOaxPIr4VavTXtvq
	 rxVaHBk0EBMylTACRqNUX5e9bjxb1a2tNTuI+8k+LOTLngAZLUWxtuzdjlFMZ2Eub3
	 WTuQQSEXzCEXlFEq5xhjZUb39UbjXLcQUkgnwVSElY9KWlMtVzgbS817w7JDLmrh9w
	 RrekrJJ5AVfv8rZycgg/QBgALz58sFxyR+uzHZI4BC2l425v6ntBV+q97SDaeonYCJ
	 kqy7PNxdroat551e9EPnYYjMfZeeteK95uNgSozhFVeDa8NbAKAe6xPQKZ/j15v5ti
	 EzMAi5D/84ZAA==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan+linaro@kernel.org>)
	id 1s24k1-000000001Co-0GG7;
	Wed, 01 May 2024 09:51:01 +0200
From: Johan Hovold <johan+linaro@kernel.org>
To: Bjorn Andersson <andersson@kernel.org>
Cc: Konrad Dybcio <konrad.dybcio@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH] dt-bindings: soc: qcom,wcnss: fix bluetooth address example
Date: Wed,  1 May 2024 09:50:05 +0200
Message-ID: <20240501075005.4588-1-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The 'local-bd-address' property is used to pass a unique Bluetooth
device address from the boot firmware to the kernel and should otherwise
be left unset.

Update the example to reduce the risk that a non-zero address will be
used by default in some devicetree.

Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 Documentation/devicetree/bindings/soc/qcom/qcom,wcnss.yaml | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,wcnss.yaml b/Documentation/devicetree/bindings/soc/qcom/qcom,wcnss.yaml
index 74bb92e31554..fd6db0ca98eb 100644
--- a/Documentation/devicetree/bindings/soc/qcom/qcom,wcnss.yaml
+++ b/Documentation/devicetree/bindings/soc/qcom/qcom,wcnss.yaml
@@ -116,8 +116,8 @@ examples:
 
             bluetooth {
                 compatible = "qcom,wcnss-bt";
-                /* BD address 00:11:22:33:44:55 */
-                local-bd-address = [ 55 44 33 22 11 00 ];
+                /* Updated by boot firmware (little-endian order) */
+                local-bd-address = [ 00 00 00 00 00 00 ];
             };
 
             wifi {
-- 
2.43.2



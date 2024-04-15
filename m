Return-Path: <linux-kernel+bounces-145025-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C94DE8A4E6F
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 14:04:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84F6828114F
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 12:04:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B1DA69946;
	Mon, 15 Apr 2024 12:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=herrie.org header.i=@herrie.org header.b="Vjofp4AR"
Received: from outbound9.mail.transip.nl (outbound9.mail.transip.nl [136.144.136.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD1196BB39;
	Mon, 15 Apr 2024 12:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=136.144.136.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713182676; cv=none; b=eAne1aqBnxvRYd0IpI1eqzeVLCAgCejIwJuiTnE/KjWRg/WvPDvUd5wuse+FYOgj7P3dsqaJd79WP9xAHE3FdojwMCqlpmH1rkwl1Tnivb/Z9spwLk5Z7sI0Dmc2Wz01iwyNEo7aQMfVmu0nLhzpKT2lgu/lKJV7vseDRop0SgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713182676; c=relaxed/simple;
	bh=nie7cPNROHKZ5ttu20WSAASaT3lPTeH5P0IxePoJuPs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZgOZaVZPRUAeG421GbAWOdm46JCUQ/BIL+nwNUqyMjfzHYiW5kpRWXRTnXNTHte1NzYT8u6qcJj6C+VACHJHcehkaXCCfX4H4F+L3J8apUlm9VhRucz8SXlUEpCihThf2WvWmy5ZXCZ5ZP3CNC4owl4hqK8TPbC+x5+c1O79Ark=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=herrie.org; spf=pass smtp.mailfrom=herrie.org; dkim=pass (2048-bit key) header.d=herrie.org header.i=@herrie.org header.b=Vjofp4AR; arc=none smtp.client-ip=136.144.136.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=herrie.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=herrie.org
Received: from submission4.mail.transip.nl (unknown [10.103.8.155])
	by outbound9.mail.transip.nl (Postfix) with ESMTP id 4VJ5HH0gFPzTPNkM;
	Mon, 15 Apr 2024 13:56:27 +0200 (CEST)
Received: from herrie-desktop.. (110-31-146-85.ftth.glasoperator.nl [85.146.31.110])
	by submission4.mail.transip.nl (Postfix) with ESMTPA id 4VJ5HG1N88znTZy;
	Mon, 15 Apr 2024 13:56:26 +0200 (CEST)
From: Herman van Hazendonk <github.com@herrie.org>
To: "Bjorn Andersson " <andersson@kernel.org>
Cc: benwolsieffer@gmail.com,
	chris.chapuis@gmail.com,
	Herman van Hazendonk <me@herrie.org>,
	Herman van Hazendonk <github.com@herrie.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-arm-msm@vger.kernel.org,
	linux-phy@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: phy: qcom,usb-hs-phy: Add compatible
Date: Mon, 15 Apr 2024 13:56:02 +0200
Message-Id: <20240415115603.1523974-1-github.com@herrie.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <>
References: <>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: ClueGetter at submission4.mail.transip.nl
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=transip-a; d=herrie.org; t=1713182186; h=from:subject:to:cc:
 references:in-reply-to:date:mime-version;
 bh=GCn4MctOklijAimZP/GbpYzFdmp5YzqVGKFzoeYARW0=;
 b=Vjofp4ARu7vEEvDbcNyEoCL/dQsfhTCVynR0GjMy995c1BTda0A0qwFeC6rJh5XY/EqUPl
 Y1bMvUvc42SZhIojymAIKKFqCODLHnSh5zF79tOhUmA/GVH3yfOlwQ6miFfCCvDw4GQeDm
 0DNXbVbnijWj+ZNDbbPhSdG4jEl7hacn7QmMqy/P9etW4MDxtQ03gs3VLQaAkAqbgq1MiY
 RtRewzoHiWZqOwml5n4LkhK8Xr8WF2xdG2LwJ/IrxUHGFdSCVru7f08lSfV/dxoWO14GMb
 N3F/3WKQOT7UQDcCF2tfM58QGxCEmEsjSCPMfT4AFhmCd8k1JjzAbaXsgF+x3Q==
X-Report-Abuse-To: abuse@transip.nl

From: Herman van Hazendonk <me@herrie.org>

Adds qcom,usb-hs-phy-msm8660 compatible

Used by HP Touchpad (tenderloin) for example.

Signed-off-by: Herman van Hazendonk <github.com@herrie.org>
---
 Documentation/devicetree/bindings/phy/qcom,usb-hs-phy.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/phy/qcom,usb-hs-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,usb-hs-phy.yaml
index f042d6af1594..1faf1da9f583 100644
--- a/Documentation/devicetree/bindings/phy/qcom,usb-hs-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/qcom,usb-hs-phy.yaml
@@ -15,6 +15,7 @@ if:
       contains:
         enum:
           - qcom,usb-hs-phy-apq8064
+          - qcom,usb-hs-phy-msm8660
           - qcom,usb-hs-phy-msm8960
 then:
   properties:
@@ -42,6 +43,7 @@ properties:
           - qcom,usb-hs-phy-apq8064
           - qcom,usb-hs-phy-msm8226
           - qcom,usb-hs-phy-msm8916
+          - qcom,usb-hs-phy-msm8660
           - qcom,usb-hs-phy-msm8960
           - qcom,usb-hs-phy-msm8974
       - const: qcom,usb-hs-phy
-- 
2.40.1



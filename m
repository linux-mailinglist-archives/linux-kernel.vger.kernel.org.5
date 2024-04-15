Return-Path: <linux-kernel+bounces-145075-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6357D8A4F2B
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 14:36:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E23C1C211DF
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 12:36:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF9AC6F505;
	Mon, 15 Apr 2024 12:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=herrie.org header.i=@herrie.org header.b="vq/1QqC3"
Received: from outbound6.mail.transip.nl (outbound6.mail.transip.nl [136.144.136.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C7A66EB75;
	Mon, 15 Apr 2024 12:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=136.144.136.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713184594; cv=none; b=I4rImYyG3y8bI8HjYJgtwRU7CST+vxtQPQs1jaCiLcMZwYpSAJ1/aByMrIq1vu+/j4F1U/LBySLOlxhiBGX16C/o/o8vcSLSWw6EB+1VBQxwXsWPBGDuI5kuPdmg4nOIqpDCkrBuK61sD4KDrdY767ORNzP1T6Io74d3/k0JKtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713184594; c=relaxed/simple;
	bh=jNxeHg+oTTWWtYZWMUwMdJnwrZpUbPV9n1Ea3y9Gocw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=BIFI5fpOS/KSrkDpeNIsrXIzTcXhJvFnHCpUsTOd2SwRSGScx3DaX/zvURhi8qiyr1QShoIfz/CY4h42CgSL24vLr3ytQmr2DRcosohPjfuS1npYg7Qswd5/VqY7l5kYH2FV27jLfKe7cqYCFN2EHw+9gtd9i5FDhx+6Qgbl1jI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=herrie.org; spf=pass smtp.mailfrom=herrie.org; dkim=pass (2048-bit key) header.d=herrie.org header.i=@herrie.org header.b=vq/1QqC3; arc=none smtp.client-ip=136.144.136.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=herrie.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=herrie.org
Received: from submission5.mail.transip.nl (unknown [10.103.8.156])
	by outbound6.mail.transip.nl (Postfix) with ESMTP id 4VJ62p2xxXzwLJDv;
	Mon, 15 Apr 2024 14:30:42 +0200 (CEST)
Received: from herrie-desktop.. (110-31-146-85.ftth.glasoperator.nl [85.146.31.110])
	by submission5.mail.transip.nl (Postfix) with ESMTPA id 4VJ62n1SBpz7tDD;
	Mon, 15 Apr 2024 14:30:41 +0200 (CEST)
From: Herman van Hazendonk <github.com@herrie.org>
To: andersson@kernel.org
Cc: benwolsieffer@gmail.com,
	chris.chapuis@gmail.com,
	Herman van Hazendonk <github.com@herrie.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Lee Jones <lee@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Satya Priya <quic_c_skakit@quicinc.com>,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: mfd: qcom: pm8xxx: Add pm8901 compatible
Date: Mon, 15 Apr 2024 14:30:38 +0200
Message-Id: <20240415123038.1526386-1-github.com@herrie.org>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: ClueGetter at submission5.mail.transip.nl
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=transip-a; d=herrie.org; t=1713184241; h=from:subject:to:cc:date:
 mime-version; bh=24iK7R241bVwFtU8XHYOGUwB4N3mqV9EFuOa+luzOCQ=;
 b=vq/1QqC3uNBHJv9T1gt6ln2doJiUzUwtffkGWloOt25ywaYIPxseX33IZBCPHElbJh4jOb
 FC/WgR5Y/Xgia8yJ3zIwzDMdSPuWvPKT9lSmJTlnGTcCdBV6hPPgv3BHpCj/+p6y/KyLlf
 5iQG3/09vuSLwlfTVIGXYhxnXSR1HSekut/0/jOK1+nYEP1FwG8qiFYrWZQ2feK1nZGM4E
 bVFqsEKF+biVxar2FHLq8XETY1ua54y3lrh+TktARkYPXW84qJ3Gx/oz8rAQeAIvUzHHHm
 6TtmHVA+cYk3/paxIW06CUMqMjmBP8xBC5ud/w44o2Ve+II1C5OkxDM6Ck+9ew==
X-Report-Abuse-To: abuse@transip.nl

Add missing compatible for the pm8901 model used in msm8660
such as (HP TouchPad (tenderloin).

Signed-off-by: Herman van Hazendonk <github.com@herrie.org>
---
 Documentation/devicetree/bindings/mfd/qcom-pm8xxx.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/mfd/qcom-pm8xxx.yaml b/Documentation/devicetree/bindings/mfd/qcom-pm8xxx.yaml
index 7fe3875a5996..63e18d6a9c21 100644
--- a/Documentation/devicetree/bindings/mfd/qcom-pm8xxx.yaml
+++ b/Documentation/devicetree/bindings/mfd/qcom-pm8xxx.yaml
@@ -19,6 +19,7 @@ properties:
       - enum:
           - qcom,pm8058
           - qcom,pm8821
+          - qcom,pm8901
           - qcom,pm8921
       - items:
           - enum:
-- 
2.40.1



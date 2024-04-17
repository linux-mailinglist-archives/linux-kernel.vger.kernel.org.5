Return-Path: <linux-kernel+bounces-147935-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B15A78A7B96
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 06:52:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C83D21C2129A
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 04:52:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18C0E44C60;
	Wed, 17 Apr 2024 04:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=herrie.org header.i=@herrie.org header.b="YnKe5vYw"
Received: from outbound9.mail.transip.nl (outbound9.mail.transip.nl [136.144.136.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 086A4BE4E;
	Wed, 17 Apr 2024 04:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=136.144.136.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713329545; cv=none; b=mXqwzBgSBqmwAgiIdB78l6czeN5DXutUrbzW1sQRvhi0C6iC265f+u4Q0QV5uiMErqNoa1o0UvFakxHXa4oo+uQho2/zE5Xme5SUljg/vR4wXnVPWRiRS7oJ+sjRLZYM1k+FE9bNkCYIt/MjCXYfvIIDmJLA7EHX0eVDQDUGUzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713329545; c=relaxed/simple;
	bh=RsNmmksocaUHd5jF/DJhTq8Xf2uynyEKdVh2S3aGhqE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=W6RMO9xwMai3hVa33dzJPAHk0X6BINDWRSQphaxLLIGlt85NJUQ1iG1xaGWASaCo9h7svlYb7tpXY6di4cfFGvenzhauptOB+rmb28pGNLAO3LUAzQYMA+ksXB+EPrUrmIf7J5LxbYExiGsChffUlsqBZ//AmPbeq7x0UJEMIdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=herrie.org; spf=pass smtp.mailfrom=herrie.org; dkim=pass (2048-bit key) header.d=herrie.org header.i=@herrie.org header.b=YnKe5vYw; arc=none smtp.client-ip=136.144.136.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=herrie.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=herrie.org
Received: from submission1.mail.transip.nl (unknown [10.100.4.70])
	by outbound9.mail.transip.nl (Postfix) with ESMTP id 4VK7mp4KnRzTPNDc;
	Wed, 17 Apr 2024 06:52:10 +0200 (CEST)
Received: from herrie-desktop.. (110-31-146-85.ftth.glasoperator.nl [85.146.31.110])
	by submission1.mail.transip.nl (Postfix) with ESMTPA id 4VK7mn5xCzz1nsPv;
	Wed, 17 Apr 2024 06:52:09 +0200 (CEST)
From: Herman van Hazendonk <github.com@herrie.org>
To: github.com@herrie.org
Cc: andersson@kernel.org,
	benwolsieffer@gmail.com,
	chris.chapuis@gmail.com,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	kishon@kernel.org,
	konrad.dybcio@linaro.org,
	krzk+dt@kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-phy@lists.infradead.org,
	me@herrie.org,
	robh@kernel.org,
	vkoul@kernel.org
Subject: [PATCH v2] dt-bindings: phy: qcom,usb-hs-phy: Add compatible
Date: Wed, 17 Apr 2024 06:52:07 +0200
Message-Id: <20240417045207.3594931-1-github.com@herrie.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240415115603.1523974-1-github.com@herrie.org>
References: <20240415115603.1523974-1-github.com@herrie.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: ClueGetter at submission1.mail.transip.nl
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=transip-a; d=herrie.org; t=1713329530; h=from:subject:to:cc:
 references:in-reply-to:date:mime-version;
 bh=ozEXOanBkuPb3pLYR7X9fOyvv86uTWm4XhOrIbW4kLU=;
 b=YnKe5vYwIKSu3CqiydaIVwZH6V+iKwQCGmyoTDaoKvamMJcSxfiYQOJ7dNPCGXU0tejJDT
 Ek2NThMe+9MV7S+niVKHseAaQzouvF02ThOuPwLPc3/+W73/rz0LNWSZikJyoLyQIwrl4D
 PYQgq6TTgq0cY2Bia09X8wQr6SiJXmRgc4k8MyJzZqfrW6m7x+aGBZ0NyE2wtWSlcgoX54
 g+USocZpS5Os23xxbgPbklOhdFxlyy8OI3bkdsKQOcpU7syKFepBfwJ4q6ogL/rZe1yxao
 /04KihqM+bpXF4WrFRwnpDwzG3fnq7x+Y3NlGU1yMePlrRC7qE/9V1ftr7B+kw==
X-Report-Abuse-To: abuse@transip.nl

Adds qcom,usb-hs-phy-msm8660 compatible

Used by HP Touchpad (tenderloin) for example.

Signed-off-by: Herman van Hazendonk <github.com@herrie.org>
---
 Documentation/devicetree/bindings/phy/qcom,usb-hs-phy.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/phy/qcom,usb-hs-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,usb-hs-phy.yaml
index f042d6af1594..ccf23170cd17 100644
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
@@ -41,6 +42,7 @@ properties:
       - enum:
           - qcom,usb-hs-phy-apq8064
           - qcom,usb-hs-phy-msm8226
+          - qcom,usb-hs-phy-msm8960
           - qcom,usb-hs-phy-msm8916
           - qcom,usb-hs-phy-msm8960
           - qcom,usb-hs-phy-msm8974


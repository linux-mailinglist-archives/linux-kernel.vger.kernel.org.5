Return-Path: <linux-kernel+bounces-63392-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE2A3852EB5
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 12:03:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52D13284164
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 11:03:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2719383B4;
	Tue, 13 Feb 2024 11:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rong.moe header.i=i@rong.moe header.b="CW6Mg/0I"
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1869374FC;
	Tue, 13 Feb 2024 11:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707822131; cv=pass; b=TA6cihc2N87wHNlRfOJLr8Q91SxVaUm55xrGnS8KBMLErFAbzCuKj4m53tQiZ4u5UzRyVGfbdKOswBhcHAOthYrl7aBkwrwz2bnL89wmbYjdNmflXiyUEzT4EcqrkPNenTNP+/AUOz8UKi8eyGsxDIh4AwT0MNQxpLKnSrmss6k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707822131; c=relaxed/simple;
	bh=UPViyWZq7mqy4tdrjNLfKxnbaoTqYOR4V9N2hlor1Is=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eHEe7NaTpuhE6xZfyjRcg/+ybw/edx1RjlvlwRMgN0qCFaDuRTH4Pk4rhVRu/KrlTsUww0Fle3XFe73yZ5Sw60nUV6ZEDoREhYA0nfq/tndaF9rT4cJp3TlPEs9hGpSHo+AtFkCdawrtD97aOWHN7LG5BzF2X4LXhNhYPAsv7cs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rong.moe; spf=pass smtp.mailfrom=rong.moe; dkim=pass (1024-bit key) header.d=rong.moe header.i=i@rong.moe header.b=CW6Mg/0I; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rong.moe
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rong.moe
Delivered-To: i@rong.moe
ARC-Seal: i=1; a=rsa-sha256; t=1707822124; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=JwUr1gWXasy7OM+ySswDQOQv9W8pr46Qa0xCJrsaa6nevkxsyi69tl5KjAZXOU8ARqRVdbe8XPNWeY8GaE6GpwNa8jAz6Td9YpOt0h5hB95xIas6H20GmYRKbW4cQM3ufQfDq5Iv8yoCc2WZce1eU9dAmdZ3zuHYz2yhfyzxGhk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1707822124; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=mRFSyOG/P156sVZjTag+xT8d/0ChLv7uzEHsNaqh/xw=; 
	b=iOE8Ql9Xj0Y3YKDuJ091xiIXHwJFvMLbCYxbVDKD0lLhYuo0c6WEPwA/N1LIXu+5vMPMMY57p1BOky1KZac9zcpDmFRLkmbW5qNB7NfP1xtM23p3dxJf2Dh9MCQ/SvqoEV6myOiO/IAHwQGRhuYMfIsTUnXelanUyq9oYjnFDkE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=rong.moe;
	spf=pass  smtp.mailfrom=i@rong.moe;
	dmarc=pass header.from=<i@rong.moe>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1707822124;
	s=zmail; d=rong.moe; i=i@rong.moe;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=mRFSyOG/P156sVZjTag+xT8d/0ChLv7uzEHsNaqh/xw=;
	b=CW6Mg/0IoHX6eqnkrgY8j4dxmheY83WAthpEczksTJn82qQnyd3k4JNm7lyAa3+8
	FAJECj8FrUYS2vc8WX/xrZPRz5VyKTsmgOme1L2xnu1IMzKTcQk2Xe8OU923H/EZcCP
	6Ng1+SN3gP6DfQkvVgov8K3qxB4UfRwIxoclc3ww=
Received: from localhost.localdomain (163.142.242.182 [163.142.242.182]) by mx.zohomail.com
	with SMTPS id 1707822122858920.6100136629509; Tue, 13 Feb 2024 03:02:02 -0800 (PST)
From: Rong Zhang <i@rong.moe>
To: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Rong Zhang <i@rong.moe>,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Icenowy Zheng <uwu@icenowy.me>
Subject: [PATCH v3 3/4] dt-bindings: arm: qcom: Add Samsung Galaxy S5 China (kltechn)
Date: Tue, 13 Feb 2024 18:58:38 +0800
Message-ID: <20240213110137.122737-4-i@rong.moe>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240213110137.122737-1-i@rong.moe>
References: <20240213110137.122737-1-i@rong.moe>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Document Samsung Galaxy S5 China (kltechn) as a klte variant based on
msm8974pro. Also including "samsung,klte" in the compatible chain as
kltechn works fine with the klte DTB except for LEDs and WiFi missing.

Signed-off-by: Rong Zhang <i@rong.moe>
---
 Documentation/devicetree/bindings/arm/qcom.yaml | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
index 1a5fb889a444..4979ccae2b64 100644
--- a/Documentation/devicetree/bindings/arm/qcom.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -227,6 +227,13 @@ properties:
           - const: qcom,msm8974pro
           - const: qcom,msm8974
 
+      - items:
+          - enum:
+              - samsung,kltechn
+          - const: samsung,klte
+          - const: qcom,msm8974pro
+          - const: qcom,msm8974
+
       - items:
           - const: qcom,msm8916-mtp
           - const: qcom,msm8916-mtp/1
-- 
2.43.0



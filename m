Return-Path: <linux-kernel+bounces-41340-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5918683EF10
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 18:24:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EDEA01F2298B
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 17:24:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90C782D051;
	Sat, 27 Jan 2024 17:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rong.moe header.i=i@rong.moe header.b="xlzbwqwx"
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 550F02E410;
	Sat, 27 Jan 2024 17:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706376235; cv=pass; b=DpZWHnnbKhM5pXkjf5Et26/m2pM6ugw0kRbcVEZvTjNeeSIaOGRJeX9V682jRSdc1O6O0PDUbkuMMNd2DOEoiK0JP4ukHDvAnMTRENOiHl5nnu1wZbzK+G2ftFC0gOmj2lmYzAMoWPKXgQUEauYSatKIcB9n3JrnRyD5ZTZot/U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706376235; c=relaxed/simple;
	bh=UPViyWZq7mqy4tdrjNLfKxnbaoTqYOR4V9N2hlor1Is=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A/vK3v8/84zCIFk2pgPxgmJgcwHUmjGkeVfBNcNQc58qNpxNd6u+oDw1uBhkHLRH26WECBEVVOcy1AAK3iRxmKPE+3vLs4s/T+VjM2bxuULkojvD157+sMQp+IKBtuy5ATEr+wgsHXcHOyr+fMrhxGP2dh6whX6dhtH2mnk+0mc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rong.moe; spf=pass smtp.mailfrom=rong.moe; dkim=pass (1024-bit key) header.d=rong.moe header.i=i@rong.moe header.b=xlzbwqwx; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rong.moe
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rong.moe
Delivered-To: i@rong.moe
ARC-Seal: i=1; a=rsa-sha256; t=1706376230; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=LWjnEh9psFzmWWqnLmKHMmUPJg4ocHh0XOIzzqWZxpDWQvY0Cvij0i20OXXP2m58TeRR3lhv2dxtHF6bGKNqnWX+6eDzQN5suF9z1ZY4a1fPE/gg6hMjrnBzCHqo62A4ZuQnqVkX3JwPiF1RJWIOWGIo+kyPAhHWn0uLhyT3+u0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1706376230; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=mRFSyOG/P156sVZjTag+xT8d/0ChLv7uzEHsNaqh/xw=; 
	b=BgFQQCxRVl6Xq70v5cDb1gMLOtVg7dRjxQ+0y+NE0QwGRF3FNm/80mY8MhGKniHHipwsGPoaHukgCtU0CdFHaGhuaKp/tAlKiR527x1HzfC9YOXZp/wXI0CW8+bO9qzXbuvrQg7GYN2JUPWusvI8zZw2I2iYShxM3jUu9DBXxvs=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=rong.moe;
	spf=pass  smtp.mailfrom=i@rong.moe;
	dmarc=pass header.from=<i@rong.moe>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1706376230;
	s=zmail; d=rong.moe; i=i@rong.moe;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=mRFSyOG/P156sVZjTag+xT8d/0ChLv7uzEHsNaqh/xw=;
	b=xlzbwqwxvo1LWtu5MTWFC8Q1iS3sn3O9ES24hFBuM3BBa1xIlck+fXpBo8cVYrp4
	VxRTeYJLZKKFeSZqKnuArZsIuSXCqWxdVWIDjYXPqpTB1OAtWm0rqgBLCUKVrqLiSh2
	x2CP95fxxHk1Rwu0U+jcuI5KaxLj+11YmVN/BVU8=
Received: from tb.lan (182.118.239.249 [182.118.239.249]) by mx.zohomail.com
	with SMTPS id 1706376229046718.1701707480975; Sat, 27 Jan 2024 09:23:49 -0800 (PST)
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
Subject: [PATCH v2 3/4] dt-bindings: arm: qcom: Add Samsung Galaxy S5 China (kltechn)
Date: Sun, 28 Jan 2024 01:21:52 +0800
Message-ID: <20240127172155.63624-4-i@rong.moe>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240127172155.63624-1-i@rong.moe>
References: <20240127172155.63624-1-i@rong.moe>
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



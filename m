Return-Path: <linux-kernel+bounces-45263-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A5F8842DD7
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 21:29:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD3951C24B58
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 20:29:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62E777AE61;
	Tue, 30 Jan 2024 20:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=postmarketos.org header.i=@postmarketos.org header.b="LsPAcHKh"
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3474762FC
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 20:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706646489; cv=none; b=VsiFO2FaI8CNP9ACsMBnXMgTtysnoiW+cfy47+qRKPJ2+jIu9fexGS8MHWYqqV2V6EkWOMlRmiSY1rg4sqPeZU89mbfCYJu8M1rnpy4voGYYsbJ6iLRZkjnmEtRRr+KijwzFrOcke0/ArZr2ANoeTxxEDZeVgOhMTH0vWKolBKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706646489; c=relaxed/simple;
	bh=tIshaH/wG7+F7fysCqp2VwCqah3ZG8cEyzEYuEn46tM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WhRZUIRjJ4x4xUVbQBlOk6qYMafbMStAT7G8TKZH613zMwoDkKTy2bDPRAVBgITG9pfFwjyXrr5Kgwdhu6boOL1nOoL/qq/SkBMNXhiGK2e9dkjmxvpgdnYwCSx0fsS2Hrxl4U8mcuNt6kPrPCHklXOeB799ddVg17+uZYFOXHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=postmarketos.org; spf=pass smtp.mailfrom=postmarketos.org; dkim=pass (2048-bit key) header.d=postmarketos.org header.i=@postmarketos.org header.b=LsPAcHKh; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=postmarketos.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=postmarketos.org
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=postmarketos.org;
	s=key1; t=1706646485;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=l3vOiuOqt9TDvwN9BP7L45s+X6J46YstAyZSD8xBADQ=;
	b=LsPAcHKhksYkMmT6BWwaWod3g582fH7CnOV253HRADRG7nN3TUqg3PYfkbWFDy8K356Tvc
	yS+iCjRuOqMCu5Gvqie9cd87EgAfZYcYAp8ILXHyDuKPbJCTghRWaPk6yi/nG5CAYvEk/n
	jRAA5EyCxOf+gwMf4GS8smbzKMya5uaNj4KLWBXUHdgQW3okrIWa3TDIADT9kJLIc4kIXe
	+lXFKBCAqNrPNvEyqsX0Mgq1I5vFOd/pxf4GrK59Vkb8nUagt0q2LKNkiQUQgO8AGl6nbX
	1FyomSh7Iq/ohApuxJ10yQ/1hwTDRmlRNow00tv7aGDPdpPLV3llqEWdZv9NEw==
From: Anton Bambura <jenneron@postmarketos.org>
To: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 4/5] arm64: dts: qcom: sc8180x-lenovo-flex-5g: set touchpad i2c frequency to 10 kHz
Date: Tue, 30 Jan 2024 22:27:54 +0200
Message-ID: <20240130202755.2289952-5-jenneron@postmarketos.org>
In-Reply-To: <20240130202755.2289952-1-jenneron@postmarketos.org>
References: <20240130202755.2289952-1-jenneron@postmarketos.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

This solves the issue when touchpad gets stuck on right or middle
click. This also makes touchpad working smoother.

Signed-off-by: Anton Bambura <jenneron@postmarketos.org>
---
 arch/arm64/boot/dts/qcom/sc8180x-lenovo-flex-5g.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sc8180x-lenovo-flex-5g.dts b/arch/arm64/boot/dts/qcom/sc8180x-lenovo-flex-5g.dts
index 8e8e1fca11c0..a8816ff0ba51 100644
--- a/arch/arm64/boot/dts/qcom/sc8180x-lenovo-flex-5g.dts
+++ b/arch/arm64/boot/dts/qcom/sc8180x-lenovo-flex-5g.dts
@@ -392,7 +392,7 @@ touchscreen@10 {
 };
 
 &i2c7 {
-	clock-frequency = <100000>;
+	clock-frequency = <1000000>;
 
 	pinctrl-0 = <&i2c7_active>, <&i2c7_hid_active>;
 	pinctrl-names = "default";
-- 
2.42.0



Return-Path: <linux-kernel+bounces-51262-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B1AB84886E
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 20:14:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC8A1281EF1
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 19:14:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 411A461662;
	Sat,  3 Feb 2024 19:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=postmarketos.org header.i=@postmarketos.org header.b="afDYVkmV"
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6362F5FF19
	for <linux-kernel@vger.kernel.org>; Sat,  3 Feb 2024 19:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706987553; cv=none; b=QTJoPDgmcCWJGkm+ynrVH3YjQA93+JQh8XbHAH3Un29+3+QYag2gQdHaJ8rBSf6EspEU8v3FebltOojKKn9X/0wUdBJp9w2daT5e1QESiYGMcZwSinyQoVURvz8Zo0SjrC50IqHQSNRwtD/N9/2h9QdzjmOxa7ZGuJ+YuTo+VyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706987553; c=relaxed/simple;
	bh=tw40LbD/9SOm06FTl+3KTgIgnIp1jgGuZPZaojk1IsA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qkYpg1McPv/Huj0MMWd5gmAnHnm0rbE0ESgZlhq42O+S+idFtWxPTM4Qvm+Qbqies194hELBBnfO48qybV2tVlNYpFmMNTHAthrUWDa5E+USZve1jNr76rSIQscUcXnaWYQk1XdlITN3J5YkIA8VKfDxgRVPQKCHSWeXTX+W7Ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=postmarketos.org; spf=pass smtp.mailfrom=postmarketos.org; dkim=pass (2048-bit key) header.d=postmarketos.org header.i=@postmarketos.org header.b=afDYVkmV; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=postmarketos.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=postmarketos.org
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=postmarketos.org;
	s=key1; t=1706987548;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=N97OQKuFnBwc0GBASpKpOKnWTYzMr5KBGcwXadZbmy0=;
	b=afDYVkmVJhHippA4saeNjIm/zbdfirmXqrfs6S6nBgcixmhnT6tGlIlmPvAF+NCcd4p6mi
	on4I2tp5Yaohva6PLYAM65XqIyenzmwnxg11RMc4PsVMZ6Vyd2JfiUZt/YP32vvN3zh4Hl
	hrz5+xkycP1eKc012NcPWf1KusCFvPI7Q2tkJcTkJQsF+wOqgoe9caV5ZzDC7JjcBrHmEQ
	OGUsTsld+6Zm8bVBEMukmTeG0v07BBhVKDfF2zF0XxOVzarpCVjG+NtjIuba5vC1gru3Td
	xAEpDVMJJEBAqCmIa+B/tI0RW60dgRFRyrTDte9stHxZwuMr8/woa9WOcC5DzQ==
From: Anton Bambura <jenneron@postmarketos.org>
To: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 5/6] arm64: dts: qcom: sc8180x-lenovo-flex-5g: set touchpad i2c frequency to 1 MHz
Date: Sat,  3 Feb 2024 21:11:59 +0200
Message-ID: <20240203191200.99185-6-jenneron@postmarketos.org>
In-Reply-To: <20240203191200.99185-1-jenneron@postmarketos.org>
References: <20240203191200.99185-1-jenneron@postmarketos.org>
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
index 5bf6285f905f..0bfc655e9a31 100644
--- a/arch/arm64/boot/dts/qcom/sc8180x-lenovo-flex-5g.dts
+++ b/arch/arm64/boot/dts/qcom/sc8180x-lenovo-flex-5g.dts
@@ -395,7 +395,7 @@ touchscreen@10 {
 };
 
 &i2c7 {
-	clock-frequency = <100000>;
+	clock-frequency = <1000000>;
 
 	pinctrl-0 = <&i2c7_active>;
 	pinctrl-names = "default";
-- 
2.42.0



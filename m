Return-Path: <linux-kernel+bounces-45262-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D46F7842DD1
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 21:28:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 130CF1C24AC9
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 20:28:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D35C378B78;
	Tue, 30 Jan 2024 20:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=postmarketos.org header.i=@postmarketos.org header.b="S4iB3nDX"
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16A9C762D6
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 20:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706646487; cv=none; b=frQYZPiA0dcK6EE1V6ztUwWx7izbBQYSQNP5/c1OtOZHPdJvk165gb4qXB4YrB5HgLGSpDe2BZYi7L167rULidvrbSLaudVd5iIe5IkBoJmqw/EB2zVPeU3rKbe/G7cvtTlWNlMJ64n40PbVxSPKM/nkv21Krwlh5jgkYtd9FG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706646487; c=relaxed/simple;
	bh=Q7ic03v6VHuiP/aRPG6jSBwO/tENYk51lrKm6ckZSQs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gIKNMEfkhvjt/xxp5UYwPTVxAmZd/Wo+CsT7jXNqUL/TxJFPCit6jkEyZcFule9uGJx5LAuTbslgGtEUm7iMwQaTA9R2DNrzZmvuXCy3sjwPVUHmqKAD2PfCgJJiRM8JeWMAK7mipXOkjy3dxxCv5b99yAGktmqNcgoQXdwHVDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=postmarketos.org; spf=pass smtp.mailfrom=postmarketos.org; dkim=pass (2048-bit key) header.d=postmarketos.org header.i=@postmarketos.org header.b=S4iB3nDX; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=postmarketos.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=postmarketos.org
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=postmarketos.org;
	s=key1; t=1706646483;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WieXiP6jVeaikwGFs5GYfcOQ5pozF8PL5Bu9LGVOFGQ=;
	b=S4iB3nDXplv8yBGTkl/ieJySLopMfXUX0msq0il16ZJVQv5RQzfR4eDyY2Jcst4jWNVE/e
	5RSRbmO6gzNDGbZnlkILPWjOmNRkrQRfGFfFwI+zW+HkWn+4GVksEgtnIfEqzxfpXeSmU/
	HexPxAqUo51R+GJnRztzSqlu4V7DZBx6LI0765Ysdlgm7icgI9iKKzAGx21popa6qCCbAl
	Ay7CoSdScO9tvxOJ5P9egTW9Ee9GWyis+iYCkdPkd836QtOgwGovTS5R9rdC7PhKrb0ebQ
	y0VzbVOnG07tYMGPRYsfaQsxuBioCPidXl0Q6++Hd+qndRdxqjzBNpfheX7RVA==
From: Anton Bambura <jenneron@postmarketos.org>
To: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 2/5] arm64: dts: qcom: sc8180x-lenovo-flex-5g: set names for i2c hid nodes
Date: Tue, 30 Jan 2024 22:27:52 +0200
Message-ID: <20240130202755.2289952-3-jenneron@postmarketos.org>
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

Set names, so they correspond to devices connected to these interfaces.

Signed-off-by: Anton Bambura <jenneron@postmarketos.org>
---
 arch/arm64/boot/dts/qcom/sc8180x-lenovo-flex-5g.dts | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sc8180x-lenovo-flex-5g.dts b/arch/arm64/boot/dts/qcom/sc8180x-lenovo-flex-5g.dts
index 49b740c54674..af61acf58d68 100644
--- a/arch/arm64/boot/dts/qcom/sc8180x-lenovo-flex-5g.dts
+++ b/arch/arm64/boot/dts/qcom/sc8180x-lenovo-flex-5g.dts
@@ -362,7 +362,7 @@ &i2c1 {
 
 	status = "okay";
 
-	hid@10 {
+	touchscreen@10 {
 		compatible = "hid-over-i2c";
 		reg = <0x10>;
 		hid-descr-addr = <0x1>;
@@ -379,7 +379,7 @@ &i2c7 {
 
 	status = "okay";
 
-	hid@5 {
+	keyboard@5 {
 		compatible = "hid-over-i2c";
 		reg = <0x5>;
 		hid-descr-addr = <0x20>;
@@ -387,7 +387,7 @@ hid@5 {
 		interrupts-extended = <&tlmm 37 IRQ_TYPE_LEVEL_LOW>;
 	};
 
-	hid@2c {
+	touchpad@2c {
 		compatible = "hid-over-i2c";
 		reg = <0x2c>;
 		hid-descr-addr = <0x20>;
-- 
2.42.0



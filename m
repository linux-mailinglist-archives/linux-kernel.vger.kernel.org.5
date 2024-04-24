Return-Path: <linux-kernel+bounces-157308-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 816508B0FA2
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 18:24:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B310E1C2426C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 16:24:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06AEF16ABE8;
	Wed, 24 Apr 2024 16:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=z3ntu.xyz header.i=@z3ntu.xyz header.b="hWf87drk"
Received: from ahti.lucaweiss.eu (ahti.lucaweiss.eu [128.199.32.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3C39159576;
	Wed, 24 Apr 2024 16:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=128.199.32.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713975875; cv=none; b=p85qfAsesuxrUmqEY9gQq/lfJeVSrhq9Kk8CxMQGRNahUlIBzb+ksyVuFm0fDdsqM84hoYchfcCPHfvvw1fVvw7zgOORgJ8mxpmeWn3WK74nZ71WfbcGpRoiZ8X+LbMyLyrbTOGYA80YjJdLTXX30meGkSbwVsnoheNfTN2Alq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713975875; c=relaxed/simple;
	bh=oX04eyGErTHRKLRur7Q5Tg7x7vhHJ8z9GyzxxFQ0iuo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VCLoctU/xos1wwYliJ8yolM8JXBNG3JGKqpcC2dTs526j6VniBpvm40S+uoUSRpGExiF6tquNdqDFRex8iX+KKIMhQeBKuhkgtLNw+vnhKUFShQVYliVK0pIoPTcBQNY4JwiuyFz6WKTE4t+OLL43loZpJlnHPhMGoBFhazkbjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=z3ntu.xyz; spf=pass smtp.mailfrom=z3ntu.xyz; dkim=pass (1024-bit key) header.d=z3ntu.xyz header.i=@z3ntu.xyz header.b=hWf87drk; arc=none smtp.client-ip=128.199.32.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=z3ntu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=z3ntu.xyz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=z3ntu.xyz; s=s1;
	t=1713975866; bh=oX04eyGErTHRKLRur7Q5Tg7x7vhHJ8z9GyzxxFQ0iuo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=hWf87drkeD2wI6cruZ7feSx2INRquwT38zBrjEI4UpNtEkHiLl9WF7dGwQfakfSJ/
	 HtTYGlyUUNjwxBE631TBmi02Flz2OzvAqNVx8JB8J5PqZ4WgsJ7YxPPcZjQhPat9Rb
	 rHp89xqFg64j3/KDRslOpqoQMmmF4BRd2zWoGVFM=
From: Luca Weiss <luca@z3ntu.xyz>
Date: Wed, 24 Apr 2024 18:24:00 +0200
Subject: [PATCH 7/7] arm64: dts: qcom: msm8994: Use mboxes properties for
 APCS
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240424-apcs-mboxes-v1-7-6556c47cb501@z3ntu.xyz>
References: <20240424-apcs-mboxes-v1-0-6556c47cb501@z3ntu.xyz>
In-Reply-To: <20240424-apcs-mboxes-v1-0-6556c47cb501@z3ntu.xyz>
To: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
 Bjorn Andersson <andersson@kernel.org>, 
 Mathieu Poirier <mathieu.poirier@linaro.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 Luca Weiss <luca@z3ntu.xyz>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1155; i=luca@z3ntu.xyz;
 h=from:subject:message-id; bh=oX04eyGErTHRKLRur7Q5Tg7x7vhHJ8z9GyzxxFQ0iuo=;
 b=owEBbQKS/ZANAwAIAXLYQ7idTddWAcsmYgBmKTI2E/+v0OEhDxT1CwZbo1Vh0lx+xECLqQE5E
 Nf5DIqqXLWJAjMEAAEIAB0WIQQ5utIvCCzakboVj/py2EO4nU3XVgUCZikyNgAKCRBy2EO4nU3X
 Vo91EADDMu543O5Imvlf6dlmSzSqFbE3C3NXz7IW/OPLCqJnlU8i3u/k3uO192GgmoEJdhd6Wtw
 yNqI0JWAmQfc2ljSlIob45tnbuevuA996qPWIH6KgSj+Tmnrfx1B/H+dQl3irFtzO0CAmpYfN0X
 Fvn3SjuxyYjUE/rRkOfgnu28EnHqio+zRvKzvfh0SMmvYRLkxSxb2FZcCk4Goru2XfV5q7AAqLR
 jf/RjzBJNrG9J8M2dIWPx+KN4TdGijmvPcrR8og0JDJBYchYPDRNhNE986lqNuZhAydSioarl2L
 NRbS+BHjZ4BvyfGLz6LXdEFkdtaQ6Oh0mmW6I/xpUCqfM3zJDfbvrqIEEnd2pMV4HeZTUNIQrsz
 +moCDlkGdGI+3yvPFq/bch78rooj8VjmW/ld6D3j6T6aEs5/c1ZfOzj8f4Eo8z1+171NMmTZHLW
 YaIHtcCgQEFJb75JSpl+BS128inIS/velVscecR2NVk93pKYZ4KYIgKDyZNXr7cEGQ0S761Jzn1
 e9M13W8drNR8ctdUHPLSSkITXarNKi1DVB9WWJEoG6Iogus1QfLRoK9xVzb7vQ0XmxVZ/wjO0rD
 3sguBhXXLZR3fh19R3j+24yPoPuwW26IDUllEt1kFAD8BOsy9mO1/myvWTSZbz4PKUOCzYNh1UO
 zQMS3OmuUL+CP+A==
X-Developer-Key: i=luca@z3ntu.xyz; a=openpgp;
 fpr=BD04DA24C971B8D587B2B8D7FAF69CF6CD2D02CD

Instead of passing the syscon to the various nodes, use the mbox
interface using the mboxes property.

Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
---
 arch/arm64/boot/dts/qcom/msm8994.dtsi | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8994.dtsi b/arch/arm64/boot/dts/qcom/msm8994.dtsi
index 695e541832ad..9949d2cd23d8 100644
--- a/arch/arm64/boot/dts/qcom/msm8994.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8994.dtsi
@@ -183,7 +183,7 @@ rpm: remoteproc {
 
 		smd-edge {
 			interrupts = <GIC_SPI 168 IRQ_TYPE_EDGE_RISING>;
-			qcom,ipc = <&apcs 8 0>;
+			mboxes = <&apcs 0>;
 			qcom,smd-edge = <15>;
 			qcom,remote-pid = <6>;
 
@@ -300,7 +300,7 @@ smp2p-lpass {
 
 		interrupts = <GIC_SPI 158 IRQ_TYPE_EDGE_RISING>;
 
-		qcom,ipc = <&apcs 8 10>;
+		mboxes = <&apcs 10>;
 
 		qcom,local-pid = <0>;
 		qcom,remote-pid = <2>;
@@ -325,7 +325,7 @@ smp2p-modem {
 		interrupt-parent = <&intc>;
 		interrupts = <GIC_SPI 27 IRQ_TYPE_EDGE_RISING>;
 
-		qcom,ipc = <&apcs 8 14>;
+		mboxes = <&apcs 14>;
 
 		qcom,local-pid = <0>;
 		qcom,remote-pid = <1>;

-- 
2.44.0



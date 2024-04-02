Return-Path: <linux-kernel+bounces-128575-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AEC5895C9D
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 21:32:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC1DF1C22227
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 19:32:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3540415B96C;
	Tue,  2 Apr 2024 19:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qJdpRFys"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71F1115CD79;
	Tue,  2 Apr 2024 19:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712086326; cv=none; b=AeBLLGiwzRMBoCvMG8xkFspRZA46qtNjmYP3v8g0AWLwGCygLzQiNvqRz/WK8raCynfMt1lmRhKHQuOwivjWXtS/1a3/ZToGeuHNNJbzYH7AKAQrwjxUo6IU+3IpU8jVQjV2wnFnCs0nAhRZ4YNbnHqs5FPoIdNhrt53N1D+3Ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712086326; c=relaxed/simple;
	bh=ha+lVfAYKkTa0Tg4xqRkyqMvY3+USeV2HW0cKY+ibno=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UAS0a7wNMF0b0XAroGwBMP7PReqwxhOviqXiGfkIKd8Nr3pDzRRoVlRZ8LwTbsvlZ4cUUyun414kJ3G04LoUfTJoq0kpya26GuyG4Z34IUbvza0ODRsn4Xvx7n4AoZCAP1j9oxTDyJoKdt+nuBx0jcciuOYJEcRITzQah3f3CGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qJdpRFys; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B424C433A6;
	Tue,  2 Apr 2024 19:32:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712086326;
	bh=ha+lVfAYKkTa0Tg4xqRkyqMvY3+USeV2HW0cKY+ibno=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qJdpRFys7wjAJUbLRsEUmnrwbgFhG6PG0uVEYzry3JaPobLz7SEpfr024uT0Nr3TZ
	 zWLCdklayNkVNYRqQMBl8Ihj/JMFqDpm/Si6NKWiKSQSU+68qoiqbH/bDJKP+HvJ/h
	 lVY382KfCMD8RgEhmy3qqgRh3RnMnlWde0ahh9uP1dy3Ja2IKBrmX8NaLiwSjT4avP
	 imnOg+InzWvzfj/uiYv9Tfe+baDqbLSr7WTiV/xnX0wdnYoHwTo0FJTCcA/vNFWb1g
	 PYErYBNv3EqrFEtNcuTGdcI1gotMPYbxtWo5j9vnBF0lHpHtBQOLr4iRtzk6TOWQT4
	 oiAWmW53OXZHQ==
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Wei Xu <xuwei5@hisilicon.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH 4/9] arm64: dts: hisilicon: hip06: correct unit addresses
Date: Tue,  2 Apr 2024 21:31:43 +0200
Message-Id: <20240402193148.62323-4-krzk@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240402193148.62323-1-krzk@kernel.org>
References: <20240402193148.62323-1-krzk@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Correct dsa and pcie unit addresses to fix dtc W=1 warnings:

  hip06.dtsi:439.23-571.5: Warning (simple_bus_reg): /soc/dsa@c7000000: simple-bus unit address format error, expected "c5000000"

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm64/boot/dts/hisilicon/hip06.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/hisilicon/hip06.dtsi b/arch/arm64/boot/dts/hisilicon/hip06.dtsi
index 249ca3b4b703..3d7285e6700e 100644
--- a/arch/arm64/boot/dts/hisilicon/hip06.dtsi
+++ b/arch/arm64/boot/dts/hisilicon/hip06.dtsi
@@ -472,7 +472,7 @@ phy1: ethernet-phy@1 {
 			};
 		};
 
-		dsaf0: dsa@c7000000 {
+		dsaf0: dsa@c5000000 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			compatible = "hisilicon,hns-dsaf-v2";
@@ -733,7 +733,7 @@ sas2: sas@a3000000 {
 			status = "disabled";
 		};
 
-		pcie0: pcie@a0090000 {
+		pcie0: pcie@b0000000 {
 			compatible = "hisilicon,hip06-pcie-ecam";
 			reg = <0 0xb0000000 0 0x2000000>,
 			      <0 0xa0090000 0 0x10000>;
-- 
2.34.1



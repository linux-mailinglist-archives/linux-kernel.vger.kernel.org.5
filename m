Return-Path: <linux-kernel+bounces-93092-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6F1E872AFE
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 00:27:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB3BA1C245B7
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 23:27:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C045B12DD91;
	Tue,  5 Mar 2024 23:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=z3ntu.xyz header.i=@z3ntu.xyz header.b="sbaTKvBm"
Received: from ahti.lucaweiss.eu (ahti.lucaweiss.eu [128.199.32.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DEEB128374;
	Tue,  5 Mar 2024 23:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=128.199.32.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709681208; cv=none; b=bmnMPzHfBd0eOE5oVm+G1Whg59KKmI7I7CQf4QNkkvzbjG8higx1C+7bBBBSPlLsmuPKbLzWLmW3ApWGzO3OAhvzugqNf8a1ri0a1FFIKPu7Tbgx9Rlqlip0O9Ke5DHHN08v+ieE2H6OPdkWWINfFi3VFA1CjAgEz6MuNfg94a8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709681208; c=relaxed/simple;
	bh=2BAC8prJg5yf1usqspCzk9cPk0M5L7xBiL4UcGSLCPs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VKZZgl8wxFFR3vF5H4/MrglLPKaIjja2uA/+chv8/ORkZMHy6SgrbR2jfr5VxV6Lo7vt25OLEiorQLBiNdbBzNkbhpZmy/XZ+0i93n6MVUWIaeH1r9Tdp3hPy4HEbB19Gul9pmYP28K74CbvRa6GcFNn4GR9XzrtAfRxUks59UE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=z3ntu.xyz; spf=pass smtp.mailfrom=z3ntu.xyz; dkim=pass (1024-bit key) header.d=z3ntu.xyz header.i=@z3ntu.xyz header.b=sbaTKvBm; arc=none smtp.client-ip=128.199.32.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=z3ntu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=z3ntu.xyz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=z3ntu.xyz; s=s1;
	t=1709680706; bh=2BAC8prJg5yf1usqspCzk9cPk0M5L7xBiL4UcGSLCPs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=sbaTKvBmDiFRC5opqIOvKpWJEWQSUiwSeIMvhetcVaIdepjIH6TA/Vdo2EqnubMPo
	 m2FNfte4jkS/BskyLsU+Q6adePa3/EHQRg95hOemrYsd4wF47i1x7GhklAObAlNNtK
	 B6Y2A3C0nChgdPbH/gPmhGZFM5+tkART1I8PRxC0=
From: Luca Weiss <luca@z3ntu.xyz>
Date: Wed, 06 Mar 2024 00:18:07 +0100
Subject: [PATCH 4/5] ARM: dts: qcom: msm8974pro-castor: Add
 debounce-interval for keys
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240306-castor-changes-v1-4-2286eaf85fff@z3ntu.xyz>
References: <20240306-castor-changes-v1-0-2286eaf85fff@z3ntu.xyz>
In-Reply-To: <20240306-castor-changes-v1-0-2286eaf85fff@z3ntu.xyz>
To: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Andy Gross <andy.gross@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Luca Weiss <luca@z3ntu.xyz>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=945; i=luca@z3ntu.xyz;
 h=from:subject:message-id; bh=2BAC8prJg5yf1usqspCzk9cPk0M5L7xBiL4UcGSLCPs=;
 b=owEBbQKS/ZANAwAIAXLYQ7idTddWAcsmYgBl56g+F6B1hXGnRxC7F7HnYyGoBzsyRRhWlb1u6
 j+kcTJVZOGJAjMEAAEIAB0WIQQ5utIvCCzakboVj/py2EO4nU3XVgUCZeeoPgAKCRBy2EO4nU3X
 VpTxEACPdpFe1qyZ6hvdzwvq40zADoUQCaSgjW2AFeriE0Sabq2gduhNdxczGm/jEM0rCfh7eR1
 w1/LxUk5MMquVTQYCwc5JujKb6eYxptuNPFCTjHS+JbbO7/NroKbSScOb4lIPav+h0ATnThUTwK
 RxdydhhrCr0nQwomrn84gLHwwNg45LI0SO260XEIrhhUKAJmggX7iJuspI/xSDzwyz0JSFe8TWG
 8oh+qZifqWd6bcTX6acon4ShWItv/KqYWOvphPWzxtTglAwb4/VnIYtIa0wXtLeUhJFQmCf7jkp
 e3ToZnBdrdTILi16CycuxcjYbPM6oM28145MdQwnE1zNzQkg5jY4cHsLsHC4EopAYadl/7P5ggm
 GwwYPqFeGvT8pwS7hWdUtR4pJmmLcJxzNtn2p8WkX/6gI8ZxhUZbqO33AJLzfwHMClvin4VPm5D
 xDnO5dgALY3mjukmqOvRfnUv/8fo5aAyzjvqivCVVbd/gt2v7LBlK+nRcVvSsxITARvH+rOW1Qf
 2Zv3uxbtx9dwYqk764oboqCqtdNopCcSa5nk6aQsRVGkfBD1fDPEvyZGXsH14EE8GkFzJIcQUEl
 8mVremH+dxIdkG8vvR8FJPTOX1uoyCyZFjimV5eYxrkbJweobmwmrk3WKd+tEyrkhBotQ0Fbzvv
 RItRR2nP2WsnKaw==
X-Developer-Key: i=luca@z3ntu.xyz; a=openpgp;
 fpr=BD04DA24C971B8D587B2B8D7FAF69CF6CD2D02CD

Set the debounce-interval for the GPIO keys.

Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
---
 arch/arm/boot/dts/qcom/qcom-msm8974pro-sony-xperia-shinano-castor.dts | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/qcom/qcom-msm8974pro-sony-xperia-shinano-castor.dts b/arch/arm/boot/dts/qcom/qcom-msm8974pro-sony-xperia-shinano-castor.dts
index 97b55bda9189..c9f74bf2f8bd 100644
--- a/arch/arm/boot/dts/qcom/qcom-msm8974pro-sony-xperia-shinano-castor.dts
+++ b/arch/arm/boot/dts/qcom/qcom-msm8974pro-sony-xperia-shinano-castor.dts
@@ -32,12 +32,14 @@ key-volume-down {
 			label = "volume_down";
 			gpios = <&pm8941_gpios 2 GPIO_ACTIVE_LOW>;
 			linux,code = <KEY_VOLUMEDOWN>;
+			debounce-interval = <15>;
 		};
 
 		key-volume-up {
 			label = "volume_up";
 			gpios = <&pm8941_gpios 5 GPIO_ACTIVE_LOW>;
 			linux,code = <KEY_VOLUMEUP>;
+			debounce-interval = <15>;
 		};
 	};
 

-- 
2.44.0



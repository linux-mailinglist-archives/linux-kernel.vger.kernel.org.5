Return-Path: <linux-kernel+bounces-105864-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A82A87E5AF
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 10:26:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4635B280E6E
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 09:25:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45EBF2C1B6;
	Mon, 18 Mar 2024 09:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=z3ntu.xyz header.i=@z3ntu.xyz header.b="PW0zMHeJ"
Received: from ahti.lucaweiss.eu (ahti.lucaweiss.eu [128.199.32.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 691CB2C19C;
	Mon, 18 Mar 2024 09:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=128.199.32.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710753951; cv=none; b=A9WWklx/2+2YDdsBYc+6Cxr/sgPhxmjk9/YjaS55bncEK8IZMWMrGbNsecqdx1/dlRq31TWdb2cVvlu37ziHmXiFSa/b5Q7yO345sLR6a3hHNcM2QwQ4VzYpn6RVPOTrW1j95CXBXhWXKMPEUbUuebnp7+pp+nq+a5bwg9gVHX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710753951; c=relaxed/simple;
	bh=wOmnMpLWk8IZd8z0AR1b7cEr1xRkYhWpObjhZzG7CXo=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=HCVk0BIbYExsuQSB3amRPNcgRsAF2qI/PzpA/h733mInhgbwBJl1oPaGiL6ywHHxS/jmsnPPE7WYvDDj2FNeD4hwe7Mu8u2KAa75KaFF5r2HrwSFzf5en/JtuvnOSMVmezfl73HwEg8S8g0Cmq5d0FmgseIc3BRb1jUgFnQuHHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=z3ntu.xyz; spf=pass smtp.mailfrom=z3ntu.xyz; dkim=pass (1024-bit key) header.d=z3ntu.xyz header.i=@z3ntu.xyz header.b=PW0zMHeJ; arc=none smtp.client-ip=128.199.32.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=z3ntu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=z3ntu.xyz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=z3ntu.xyz; s=s1;
	t=1710753942; bh=wOmnMpLWk8IZd8z0AR1b7cEr1xRkYhWpObjhZzG7CXo=;
	h=From:Subject:Date:To:Cc;
	b=PW0zMHeJI/NcVHrP3oj0GYqVO9Qa44c5rmpGvKexPYum8hjxBfbdMvdzUrhLT+xdm
	 mdGx0CoxKXjXrI0RG3l8nRO/u6/q7JISXjpO2axuJkKHZxjPcnP6s9ln19Kucn8BLt
	 oCYwTvKzKy1XwlvEGSOoDFmhbjkU5hhoQtF3ox3E=
From: Luca Weiss <luca@z3ntu.xyz>
Subject: [PATCH 0/2] Small fixes for MSM8974 SoC dtsi
Date: Mon, 18 Mar 2024 10:24:40 +0100
Message-Id: <20240318-msm8974-misc2-v1-0-f71668a2b8cd@z3ntu.xyz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFgI+GUC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDY0ML3dziXAtLcxPd3MziZCNdw7QkS6PEVLOklDRjJaCegqLUtMwKsHn
 RsbW1ALukxIJfAAAA
To: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Luca Weiss <luca@z3ntu.xyz>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=504; i=luca@z3ntu.xyz;
 h=from:subject:message-id; bh=wOmnMpLWk8IZd8z0AR1b7cEr1xRkYhWpObjhZzG7CXo=;
 b=owEBbQKS/ZANAwAIAXLYQ7idTddWAcsmYgBl+AhiT58rMPy+cJQgdMGrNFmibJO+WhDx7WVg3
 mkeAnERrGOJAjMEAAEIAB0WIQQ5utIvCCzakboVj/py2EO4nU3XVgUCZfgIYgAKCRBy2EO4nU3X
 VuyED/9nu28g/TK0G94SPIhNyFOH3hjvJTmX1L5NArlpeiP0+/EXwrCBI4QWX32zMUFHLcbntkx
 YXs9sszX22SSSXuy+ieUlK2mHf7YavbZCX12/E2mVdu16sn7T7ExtewGuNG3yfZlEarqMDXnfGu
 bMpHfPRa4bKGXP8KI10wSPbB/YboqqKTmGSfhvRV7+3y9g9PcX7K14HFN8ltbyHz7uSI7m0C/bL
 MMAO8/41RnbNuwSA58vgZeYVuROFyZE/mluyqhcIXdi8nvrz2RCIvy5BMwhjUahZoej/Oea5+2W
 DJx0ii32lIiOPVoJVs76ugXAq4hWSZqsmwKTONc04DvnwMXxHdll0VE78eLAueVMFkkbjvMOZbr
 BQoVoCJXR+Znb9NP8X/N97j1Bf1BlZk3IwLvhQ9ZpWUxtOP5mi9QDTpYo94xxrswEq8ph07hopg
 4iNwmByPDVwMgVc3iAXMe67oQmMBQ+IvUA7EmTOU9LIJVJ1Pxsw85Xlk9tltAzGqch0g0mB+Prc
 1PNSj4qm7Ir65ozu9+nhRGM7WIEI3yagzuz+gIvzorh7+hpJ2S8bVy+XxHVQIoRR/iEe1R5pCR7
 BxAWdAQgMC+swvOMJJYjNBIe8IlYrccxFK+qGTfQvZmcjZeMTSW4N8kanKx4gU71B9g/HsylsEX
 697xx1zB21GdSiA==
X-Developer-Key: i=luca@z3ntu.xyz; a=openpgp;
 fpr=BD04DA24C971B8D587B2B8D7FAF69CF6CD2D02CD

One fix for dt schema validation, one for the /chosen node.

Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
---
Luca Weiss (2):
      ARM: dts: qcom: msm8974: Add @0 to memory node name
      ARM: dts: qcom: msm8974: Add empty chosen node

 arch/arm/boot/dts/qcom/qcom-msm8974.dtsi | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)
---
base-commit: f6cef5f8c37f58a3bc95b3754c3ae98e086631ca
change-id: 20240318-msm8974-misc2-1fb92ae6bdf3

Best regards,
-- 
Luca Weiss <luca@z3ntu.xyz>



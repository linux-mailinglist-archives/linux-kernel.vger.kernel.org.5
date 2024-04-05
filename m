Return-Path: <linux-kernel+bounces-133113-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D647D899F04
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 16:07:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A6541F216FA
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 14:07:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4046816F0F4;
	Fri,  5 Apr 2024 14:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=trvn.ru header.i=@trvn.ru header.b="B+hOcwM2"
Received: from box.trvn.ru (box.trvn.ru [194.87.146.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F05C416D9CB;
	Fri,  5 Apr 2024 14:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.87.146.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712326019; cv=none; b=Y/mb0vvlD8MiiUqMk3TpF+unnbrRvR9Gc4dS8pNBrDoLH/EP/HuzZVizhUAL/l4DzIfHvNWrBgOLwD1mb5NKhNniiYwgbRiHOTc/ulP0asOA1+w+79++3tV8a4KY8njc62OD2KPVhkOV2v64SI0zfQkQUem7Sd8pMS8GvD2blB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712326019; c=relaxed/simple;
	bh=ljFXSCtasOGq1//X99BIfPejSn+STQIt0CQ4uzp4o/I=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=SMKplPMsdiDGLblHHsryCEViKKTJllGeF2CLeg06g9OJPPoXkcu2qGsX5vwRBUXA855aE2evU3FcQG7QYEEjZFzRNNzWfp0xNQ06DnBWdSLPst8bHXIyH3DMt9qjJwla7YXe4DVvOOVv7oE00J7mGSeTexL0pfnl4WyNCMe3bkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=trvn.ru; spf=pass smtp.mailfrom=trvn.ru; dkim=pass (2048-bit key) header.d=trvn.ru header.i=@trvn.ru header.b=B+hOcwM2; arc=none smtp.client-ip=194.87.146.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=trvn.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trvn.ru
Received: from authenticated-user (box.trvn.ru [194.87.146.52])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by box.trvn.ru (Postfix) with ESMTPSA id D8D0F4192D;
	Fri,  5 Apr 2024 19:06:44 +0500 (+05)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=trvn.ru; s=mail;
	t=1712326005; bh=ljFXSCtasOGq1//X99BIfPejSn+STQIt0CQ4uzp4o/I=;
	h=From:Subject:Date:To:Cc:From;
	b=B+hOcwM2xz2aWwm/SyUJSgg1eonDjodoAaLih63ypRhrfLsT9paRLv5jo7+T7RDXU
	 +glOKYN0UB/ACwZI6JW0cCXoqbejeROvkJtn6T4mhgo6d1RR6DSPPSshTnVc1NGmj5
	 ftNnbhdIDAJVP37GktE5W2tJKOzJ74YNV4UZ6r+ylWERfTg606VpYJcCBf6ncxrUqw
	 /1uhgmUFFaw2QF81B8CFGWHmCkeV2Y/tMi1XyWpR0weqkJT+gCveorkSLeNj5+axnE
	 3CFQmNuenyjX3IlTGY1SbJn6mQrPIQH2AfUCKYiL9aJvf7lYOS5XWh74HmBXjZkU1I
	 H6TACM4bWpPBg==
From: Nikita Travkin <nikita@trvn.ru>
Subject: [PATCH 0/4] Introduce msm8916 based Motorola devices
Date: Fri, 05 Apr 2024 19:06:09 +0500
Message-Id: <20240405-msm8916-moto-init-v1-0-502b58176d34@trvn.ru>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAFIFEGYC/x3MTQqAIBBA4avErBswMbOuEi36GWsWamhEIN09a
 fkt3suQKDIlGKoMkW5OHHxBU1ewHrPfCXkrBimkEkq06JIzfaPRhSsge75QK2G0XIxtuxVKd0a
 y/PzPcXrfD89dwTNjAAAA
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Nikita Travkin <nikita@trvn.ru>, 
 Ruby Iris Juric <ruby@srxl.me>, Stephan Gerhold <stephan@gerhold.net>, 
 =?utf-8?q?Wiktor_Strz=C4=99ba=C5=82a?= <wiktorek140@gmail.com>, 
 =?utf-8?q?Val=C3=A9rie_Roux?= <undev@unixgirl.xyz>, 
 Martijn Braam <martijn@brixit.nl>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1506; i=nikita@trvn.ru;
 h=from:subject:message-id; bh=ljFXSCtasOGq1//X99BIfPejSn+STQIt0CQ4uzp4o/I=;
 b=owEBbQKS/ZANAwAIAUMc7O4oGb91AcsmYgBmEAVwvrr8qJnHXp6ir6v+TDAidrYgzN0N8goOq
 Sjq2BHHIICJAjMEAAEIAB0WIQTAhK9UUj+qg34uxUdDHOzuKBm/dQUCZhAFcAAKCRBDHOzuKBm/
 dfq0D/9z7P0ftGQmrHuMXtIhXOAf0Gu0GFeMYfmXFREKXY5aMv6bM7lzFGpD3EXJ8Szg9LPIwyX
 rgzlfgMDi3Tl9CXtgGiqk17h4tH8wljsEsQBPmf2itAML3zyzODuUScfDdfFQGMLHje+sjFe1Kc
 /xhQuRFcA2h8dGrQ5+/RWFtPpm7lRVfiaYH/7lsChXv19GADUtSe53LGuBvqaYAc6rJRqsvE4qe
 V2MGcWowLvB0NMGNYvZNBDvQL9wA0O/GUJNWAsI56tcNWukPjcSL+9SIhu8/wE8CHxh7lWsWbad
 478fNVWSGdgXEI86BsmDRzH3eRtt21xJIFxehNprobqitiXFAqcLC+vCboms1ARC4ehVO53Fs6B
 Tcem8Aja9NUiIzEgRJuM8ov41+dbjpjOVtqK9TgdiFiejZKfLqBkeFwnTbToOGuVSF2PxIur3RR
 i4nVG8Rk6ltJmy6NHGuP3pKYCq3BRf/H5topTpz9PH0DhzsECVJrleauoPxsNk74qdgC01ylSNx
 pbdsdLhE6QR/ELZQNyyvLD5L2K2LBpG7q/4orc9Cb6i0/iQfh/m2C1cKJzP38bVCp0p5V95im81
 zbmy56JPEVkKIwKv64dxtwF4LxwfStc3bmhfUfNKFXe629L4fEHvYcXJ/BMt92j0F5SrEsSPyjh
 xfX4g2u44A3BAWg==
X-Developer-Key: i=nikita@trvn.ru; a=openpgp;
 fpr=C084AF54523FAA837E2EC547431CECEE2819BF75

This series introduces a set of msm8916 bsed Motorola devices:

- Moto G4 Play (harpia)
- Moto G 2015 (osprey)
- Moto E 2015 LTE (surnia)

The submission brings up the following features:

- eMMC and SD;
- Buttons;
- Touchscreen;
- USB;
- Fuel Gauge;
- Sound;
- Accelerometer (harpia only).

Since the devices share a lot of similarities, the common parts of the
DT are separated out into a dedicated dtsi, introduced with the first
device.

Signed-off-by: Nikita Travkin <nikita@trvn.ru>
---
Martijn Braam (1):
      arm64: dts: qcom: Add Motorola Moto G 2015 (osprey)

Nikita Travkin (1):
      dt-bindings: arm: qcom: Add msm8916 based Motorola devices

Ruby Iris Juric (1):
      arm64: dts: qcom: Add device tree for Motorola Moto G4 Play (harpia)

Wiktor Strzębała (1):
      arm64: dts: qcom: Add Motorola Moto E 2015 LTE (surnia)

 Documentation/devicetree/bindings/arm/qcom.yaml    |   3 +
 arch/arm64/boot/dts/qcom/Makefile                  |   3 +
 .../boot/dts/qcom/msm8916-motorola-common.dtsi     | 161 +++++++++++++++++++++
 .../boot/dts/qcom/msm8916-motorola-harpia.dts      | 147 +++++++++++++++++++
 .../boot/dts/qcom/msm8916-motorola-osprey.dts      | 105 ++++++++++++++
 .../boot/dts/qcom/msm8916-motorola-surnia.dts      |  83 +++++++++++
 6 files changed, 502 insertions(+)
---
base-commit: 29493ca7d6b1d3fdc224467c422ac9bdf6d7a252
change-id: 20240405-msm8916-moto-init-640862b8f57c

Best regards,
-- 
Nikita Travkin <nikita@trvn.ru>



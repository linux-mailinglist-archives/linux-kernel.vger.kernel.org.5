Return-Path: <linux-kernel+bounces-60416-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 08E55850498
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 15:13:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BEF8B2837E6
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 14:13:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AC8A53E2C;
	Sat, 10 Feb 2024 14:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=z3ntu.xyz header.i=@z3ntu.xyz header.b="rjd1A5Yw"
Received: from ahti.lucaweiss.eu (ahti.lucaweiss.eu [128.199.32.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DADD753E03;
	Sat, 10 Feb 2024 14:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=128.199.32.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707574408; cv=none; b=a3Ltp+T+vvzWLeRIqVvDznObLynDKu8+CrMxz762fqnRvlv1b7GCF3kJzN6tybHBarMX9Ibv+SrSEDMkGybVgwUDAg9Ya6u6wy0fytZ/wzCu3EcB8UOcLZ9zF2djS08MM0aYfn/0xW5Fmqoz15f3qR8ozbE/aAN6FNj74jBpYU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707574408; c=relaxed/simple;
	bh=k0BTFLmUwPs99wnDROHreAYsJESy48xS/LYqqLEr4a0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=f0MTfX8G/AbtQ1Cx7UNqQlpJULgaoqAe9S4dyqVSO6fBz3xqekAoLpifdnC/Px438zRqCNpkeh1HBaQB+8uUHT8eE2tKiEsYmBv/bgANGDZKHR0UMYyXJn8z6TFxaZXxtvTB+FfTKHb6mBCKLvLk4lEqGNdfqNKrkJzbG4UG1p8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=z3ntu.xyz; spf=pass smtp.mailfrom=z3ntu.xyz; dkim=pass (1024-bit key) header.d=z3ntu.xyz header.i=@z3ntu.xyz header.b=rjd1A5Yw; arc=none smtp.client-ip=128.199.32.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=z3ntu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=z3ntu.xyz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=z3ntu.xyz; s=s1;
	t=1707574398; bh=k0BTFLmUwPs99wnDROHreAYsJESy48xS/LYqqLEr4a0=;
	h=From:Subject:Date:To:Cc;
	b=rjd1A5Ywu7n7HM2uIpGlOd2FuSo1hIcY+at2qg9wwmb97ARaCTRuJvX4bVOtXgvD/
	 x0g7dWFSVPL07Qzxc8oMgswMk84AzKnMY/czwoHX4Jwnaz5wvgRYMX/6n4CDSAGs4m
	 srb1pRa5fxcSGgVf2Rcxu0AhJBUzdUayJsOLLVHY=
From: Luca Weiss <luca@z3ntu.xyz>
Subject: [PATCH 0/3] Add RPMPD support for MSM8974
Date: Sat, 10 Feb 2024 15:12:54 +0100
Message-Id: <20240210-msm8974-rpmpd-v1-0-de9355e6842a@z3ntu.xyz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGaEx2UC/x3MQQqAIBBA0avErBPULK2rRIvIsWahiUIE4t2Tl
 m/xf4GMiTDD0hVI+FCmOzSIvoPj2sOJjGwzSC4Vl4Izn72ZtWIp+mjZhMo4HLSSeoTWxISO3v+
 3brV+DaNGL18AAAA=
To: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, 
 Stephan Gerhold <stephan@gerhold.net>, 
 =?utf-8?q?Matti_Lehtim=C3=A4ki?= <matti.lehtimaki@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
 Luca Weiss <luca@z3ntu.xyz>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=1021; i=luca@z3ntu.xyz;
 h=from:subject:message-id; bh=k0BTFLmUwPs99wnDROHreAYsJESy48xS/LYqqLEr4a0=;
 b=owEBbQKS/ZANAwAIAXLYQ7idTddWAcsmYgBlx4RpGyQjD6B2c76jO4pelr2m8P6IQkQZtJdLu
 kvN5P3NSJaJAjMEAAEIAB0WIQQ5utIvCCzakboVj/py2EO4nU3XVgUCZceEaQAKCRBy2EO4nU3X
 VjF2D/wO52RLi/5TYtuH1Zdr8fA7quTFv0SyiHlxH3UNVddW5sIJArMzGUokxqtQEwF2Yrcu+JA
 8Fl5+bRyONjbzvdUvfAIAQPrZrrWSDD5VZoE/XOdI4+/QuQikfr8VQItU1nYpPMG8Bx/N/MdEQj
 sG8LIP4W/mGWoTpl/OnRKtBeia9zoOKPYFtSwqmtTFV/I47HOdoY+5m1XwM7vRAMqpLVgRnuXbV
 0Mfi8GDM6zpgOU73Zk/XmdX2TTP3ozB2rOQO5mDO7m904+BNA6RmqUm8tfLLdXaCYZLlZpKHOTM
 XX9WA2r+Kdcm8U1c+sFZHQnK2qTZ/Vx0mNN923FUmTicXOQ5d/ipoX56s13N8+ri/3tffj3HwFV
 cnqnM4dQUZ3uNjPUuDRD0TuA76o61vNp+x17muC4dpXLgHwzKi7E067uWaeBk8S21bJxzLKZA+z
 0dlQ6x+wpEG4xR/9F98xUGY9fJSvEqwlaWOd7HyTeTN1mWLPevOr15ObG296x+7Rqhv+Cm28Tmq
 8HiiBXxR/fl/bQV39YdzVv49u/STVbfM/n+5ku0EfOkuEehOgPCzOfekVe2c/aedPBiXod1ukSV
 nyo9NTMNt4oLt0K0xdx3LDfreg4nyz+ttJcSIBqQ7hIThtIpVeqn8GbWmU5D1bts+8mm/XzHwuH
 UVJMCyP4oOnwqGQ==
X-Developer-Key: i=luca@z3ntu.xyz; a=openpgp;
 fpr=BD04DA24C971B8D587B2B8D7FAF69CF6CD2D02CD

Add driver support for the RPM power domains found on the different
MSM8974 devices.

Devicetree integration will come at a later point since also some
mostly remoteproc drivers need to be adjusted.

Also the MX power domains on this SoC seems to work quite a bit
differently, we'd need to send raw voltages to it, so these are ignored
in this series.

Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
---
Luca Weiss (3):
      dt-bindings: power: rpmpd: Add MSM8974 power domains
      pmdomain: qcom: rpmpd: Add MSM8974+PM8841 power domains
      pmdomain: qcom: rpmpd: Add MSM8974PRO+PMA8084 power domains

 .../devicetree/bindings/power/qcom,rpmpd.yaml      |   2 +
 drivers/pmdomain/qcom/rpmpd.c                      | 107 +++++++++++++++++++++
 include/dt-bindings/power/qcom-rpmpd.h             |   8 ++
 3 files changed, 117 insertions(+)
---
base-commit: 6e3fa474051f3d276ea708bdb8e8e1f66d1d3ee5
change-id: 20240210-msm8974-rpmpd-6e48fe374275

Best regards,
-- 
Luca Weiss <luca@z3ntu.xyz>



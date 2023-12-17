Return-Path: <linux-kernel+bounces-2665-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BF87781602B
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 16:34:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B5FF281B06
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 15:34:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CD9F45BED;
	Sun, 17 Dec 2023 15:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=z3ntu.xyz header.i=@z3ntu.xyz header.b="eC+oae7O"
X-Original-To: linux-kernel@vger.kernel.org
Received: from ahti.lucaweiss.eu (ahti.lucaweiss.eu [128.199.32.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E95AF328D8;
	Sun, 17 Dec 2023 15:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=z3ntu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=z3ntu.xyz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=z3ntu.xyz; s=s1;
	t=1702826610; bh=1qTrHHazQEMLaXCU3zsLP84Kqg9GTIgZYgOj0bYFXjU=;
	h=From:Subject:Date:To:Cc;
	b=eC+oae7Oso2GlL+oecm+gIgcB2vCRN02VcvtOkToxRJpAYvBhUnjuL+G5n+xQQIiN
	 3dRanNUMFS7CzJKj9x/x79CIV5nWtmmAN/HTvsbh57NWnVjhq68Zkz6pHRvH1JYpb3
	 WMY+eePaLFCMjUO1tRcjF+ZBXcTmogLktgACRk9s=
From: Luca Weiss <luca@z3ntu.xyz>
Subject: [PATCH 0/3] Several smaller msm8974 fixes
Date: Sun, 17 Dec 2023 16:22:52 +0100
Message-Id: <20231217-msm8974-misc-v1-0-bece1ba2667d@z3ntu.xyz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEwSf2UC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI2NDI0Nz3dziXAtLcxPd3MziZF3TFFMLM0NTI6PEFEMloJaCotS0zAqwcdG
 xtbUAWmiQGF4AAAA=
To: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
 Andy Gross <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Samuel Pascua <pascua.samuel.14@gmail.com>, Iskren Chernev <me@iskren.info>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Konrad Dybcio <konrad.dybcio@somainline.org>, 
 Alexey Minnekhanov <alexeymin@postmarketos.org>, 
 Luca Weiss <luca@z3ntu.xyz>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=966; i=luca@z3ntu.xyz;
 h=from:subject:message-id; bh=1qTrHHazQEMLaXCU3zsLP84Kqg9GTIgZYgOj0bYFXjU=;
 b=owEBbQKS/ZANAwAIAXLYQ7idTddWAcsmYgBlfxJZPyTALCN1nMz9iyBgmUAkIu92eM21O94CS
 v3Jf0f01zaJAjMEAAEIAB0WIQQ5utIvCCzakboVj/py2EO4nU3XVgUCZX8SWQAKCRBy2EO4nU3X
 VssHEAC4sSQ0hKcSTbUGjLzrtQJzPakIUCghs0yH9aEz2FoI2qp3r659M71tAsQYYqdesuVoHM5
 jugA7KBzuyYpCUHyjt4SHR88Pp6slI7x/8PLlWO1WCJHLN0Q9odxddYAyoUUlwOs8k+GQbmG6md
 O+F7oaeXCrebPA7yrR+NhRfy8YUskr1vvtlq50/opk/59yplQcs4bY3rpa3Psxb/82d1IHmo4+R
 0ctgm+pjpIYLw32LNf1bQNte47A5XhWej4meGw6wbRcVQbJ8I02m+LFrfzS/mbqCk6c+CblxhFv
 RE34NlOwlMapZRO4iYKxooPd5Ib7uHABC6OO6x/U0oYMpz+17c0AE39dHMN0mA5ga0DCMJ4hJge
 gdPFhOXBoPR1Vv6XlThpRAWxh21FK7urATxtfmKlLwTWDDetSiIXlwdGjDjQgF90rTHp87KkG1h
 NhEHU4Mh98ZVe43Ke8U9neiCJYjVauJXdpObd2n6PpRk3fsSlwe7XPyLorUunb3sUYv8gEHPS8Q
 cv17i66uL7oCofwJysTK+agraMF63iM5lktAl5mKaznNYmNusH0zM0cG+SyDsc8jT6soZJovBej
 kEf4PqNcD2xd/eCSka8IPPyh5RPfWW1OQFQU2k2GJw+gBDAmV+koKWnYY5815ahj5DInyo5o1jo
 zbq4LGVdMbTsZmg==
X-Developer-Key: i=luca@z3ntu.xyz; a=openpgp;
 fpr=BD04DA24C971B8D587B2B8D7FAF69CF6CD2D02CD

Send some smaller fixes that have been sitting around in my tree for
some time.

Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
---
Alexey Minnekhanov (1):
      ARM: dts: qcom: msm8974-klte: Remove unused property

Luca Weiss (2):
      ARM: dts: qcom: msm8974: Remove bogus cd-gpio pinctrl
      ARM: dts: qcom: msm8974*: Re-enable remoteprocs on various boards

 arch/arm/boot/dts/qcom/qcom-msm8974-lge-nexus5-hammerhead.dts      | 2 ++
 arch/arm/boot/dts/qcom/qcom-msm8974-sony-xperia-rhine.dtsi         | 2 ++
 arch/arm/boot/dts/qcom/qcom-msm8974.dtsi                           | 7 -------
 arch/arm/boot/dts/qcom/qcom-msm8974pro-samsung-klte.dts            | 1 -
 .../boot/dts/qcom/qcom-msm8974pro-sony-xperia-shinano-castor.dts   | 2 ++
 5 files changed, 6 insertions(+), 8 deletions(-)
---
base-commit: de06a4144d8e2c0923d08cab7c24958c28ddf17f
change-id: 20231217-msm8974-misc-5d5861522ad1

Best regards,
-- 
Luca Weiss <luca@z3ntu.xyz>



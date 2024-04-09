Return-Path: <linux-kernel+bounces-137475-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A272F89E2A7
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 20:37:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5CE5F283E55
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 18:37:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2E7F156F4E;
	Tue,  9 Apr 2024 18:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=z3ntu.xyz header.i=@z3ntu.xyz header.b="XHJ57bpL"
Received: from ahti.lucaweiss.eu (ahti.lucaweiss.eu [128.199.32.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96A97156863;
	Tue,  9 Apr 2024 18:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=128.199.32.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712687816; cv=none; b=lsZObHQ2CNZnVvUkTgPjxLzQgzeZzFrH1pFYeL0Dk410e1vz28DaGxV66S5m6sbVxYZ1svPaReWg9ybgU5uA9rOlgxIm8rdAHCz3MhV262txr824OsvpWxlMs5F0LZnrra2O0K8xbljpWbYb+EIjR9hwPBCNlP+8fv8PvVYDl78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712687816; c=relaxed/simple;
	bh=rHZbSTbfYXgHTDhJr9jRwzMsCYeJg2OgLGQ+5ogbYsw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=gqEE8zuDbGTOTES5CErfiPk+HLSiLiNzzyCz0D/ahNCHJb0mgTzir+lHLmghKbC6bqH9cXE0Ay+2DfW1ZLeBmOYkfXhda71MVvZu2auyEcgxZ1/m844qhPwbD4ZjDBrs4E2iFGQQM6PwVfLJdGE/Z/hW90/A6SMAJb7iLFxiNWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=z3ntu.xyz; spf=pass smtp.mailfrom=z3ntu.xyz; dkim=pass (1024-bit key) header.d=z3ntu.xyz header.i=@z3ntu.xyz header.b=XHJ57bpL; arc=none smtp.client-ip=128.199.32.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=z3ntu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=z3ntu.xyz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=z3ntu.xyz; s=s1;
	t=1712687812; bh=rHZbSTbfYXgHTDhJr9jRwzMsCYeJg2OgLGQ+5ogbYsw=;
	h=From:Subject:Date:To:Cc;
	b=XHJ57bpLQoR/aqryvWnVeoAny928eJdNCr+f9UrjxYy8voxJIK08DMxK5U6Aa1nLz
	 H1EUrmL/dbe80jN47M7hlcRRM0L1Eilf3nNzvPCFL6WU0u8du6KGGqogK6q0J2neiy
	 wJETIKwEWh+o0F69MqxSbSusoRGJERxBjhJwP//g=
From: Luca Weiss <luca@z3ntu.xyz>
Subject: [PATCH v2 0/2] Allow gpio-hog nodes in qcom,pmic-gpio bindings (&
 dt fixup)
Date: Tue, 09 Apr 2024 20:36:35 +0200
Message-Id: <20240409-qcom-pmic-gpio-hog-v2-0-5ff812d2baed@z3ntu.xyz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALSKFWYC/32NTQ7CIBBGr9LM2jEM0Ma48h6mC0VoZ9FSoZL+h
 LuLPYDL95LvfTtEG9hGuFY7BJs4sh8LyFMFpn+MnUV+FQYppBZaXPBt/IDTwAa7iT32vkP51KZ
 2JBTJBspwCtbxckTvbeGe4+zDenwk+tm/uUQo0DXkTK2kIhK3TY3z57ysG7Q55y+1IMEitAAAA
 A==
To: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
 Bjorn Andersson <andersson@kernel.org>, 
 Linus Walleij <linus.walleij@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Luca Weiss <luca@z3ntu.xyz>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=791; i=luca@z3ntu.xyz;
 h=from:subject:message-id; bh=rHZbSTbfYXgHTDhJr9jRwzMsCYeJg2OgLGQ+5ogbYsw=;
 b=owEBbQKS/ZANAwAIAXLYQ7idTddWAcsmYgBmFYq/kttYH9CI/Y8ue4hlGZYTq3MO9tu+dSTsp
 NicZk2yXsKJAjMEAAEIAB0WIQQ5utIvCCzakboVj/py2EO4nU3XVgUCZhWKvwAKCRBy2EO4nU3X
 Vs5yD/41MhuQujprVoWFe/mAsJoluZ504qQFZQBUzGHo1yd47g62NNv9UaNQEem4+5UxMCabA+y
 3oH43dT2kFK4N11nBgEwTtyzJA32ZvsOhfVFwIEjNR7yH2Kk1zfIULQ54IdpW+KcebvjiEBAq/P
 AIAbZK/SN4nv1Stes47DduIOO2hjcCkb5G6Ow1r2vktmR4TLTSb3mrHic5eh1h+3vKz2Eq+9zmS
 zfBKiGQ42A+/nI87kZu/whP6+lFVlnzwO63p9/BJnvgnSpRTlfD5WiIhlhH3N+Po0AMkVYYHEW7
 IGWOgjZ0K9Z/8Pc6SeFUPLdAAx5UBhq0Ftkf/cYH5TKK8exRm3phqvi3SAsb/axdh7FLqF1YDbP
 bre60qJQC8HLm+7HPrvFX75qVvBYG9+3PpZP5gz5Axwqltey2ZgGyoVj/JnK7NkolGS9J68CiLi
 3LjTnjUtlsf0SumfegQBvGn3GAZudSg5ZaPO8uRFgEketHE0uNIgl7byWtCfHfBD3YtqZPVnZ+z
 81vmaRZAiYEuWW+Mht5Oxf3mew8dtvx7Y8rICxFns6DhmnxkIqY1B84+QWTkYBy22HTwCEkz9Yq
 11zQULyaTlqXQdXt38JsX6MHt41p4xbRE3lvo6RJW+0JIKXKfnug+/WjDCjmcx4YUslCHJdJ3hm
 NQev3PF4YdkZpzw==
X-Developer-Key: i=luca@z3ntu.xyz; a=openpgp;
 fpr=BD04DA24C971B8D587B2B8D7FAF69CF6CD2D02CD

Resolve the dt validation failure on Nexus 5.

Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
---
Changes in v2:
- Use simpler regex from tlmm bindings (Krzysztof)
- Link to v1: https://lore.kernel.org/r/20240408-qcom-pmic-gpio-hog-v1-0-f61fc5323110@z3ntu.xyz

---
Luca Weiss (2):
      dt-bindings: pinctrl: qcom,pmic-gpio: Allow gpio-hog nodes
      ARM: dts: qcom: msm8974-hammerhead: Update gpio hog node name

 .../devicetree/bindings/pinctrl/qcom,pmic-gpio.yaml          | 12 ++++++++++++
 .../arm/boot/dts/qcom/qcom-msm8974-lge-nexus5-hammerhead.dts |  2 +-
 2 files changed, 13 insertions(+), 1 deletion(-)
---
base-commit: 8568bb2ccc278f344e6ac44af6ed010a90aa88dc
change-id: 20240408-qcom-pmic-gpio-hog-2b4c5f103126

Best regards,
-- 
Luca Weiss <luca@z3ntu.xyz>



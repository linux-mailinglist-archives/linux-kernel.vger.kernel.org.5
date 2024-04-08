Return-Path: <linux-kernel+bounces-135694-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F5D189C9DB
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 18:40:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B4CB01F21B78
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 16:40:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA431142E64;
	Mon,  8 Apr 2024 16:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=z3ntu.xyz header.i=@z3ntu.xyz header.b="FiCu9vjF"
Received: from ahti.lucaweiss.eu (ahti.lucaweiss.eu [128.199.32.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56A6113A258;
	Mon,  8 Apr 2024 16:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=128.199.32.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712594397; cv=none; b=j4baIyAW2+37liqFqbtJeJAoS0ZfWEN3DiHI4ZUCNXsJ4nWQYSZ9J/xi8xvW2efNTlpoYaGdR9y93apCrm8ZAi4/19g89oJCpv3c55i0bspIeV6InLiMmo7E8RbUwK2N7lvs36I1Iu9E34xtsBrMl4bbZS41/kLyZau/6tuJJAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712594397; c=relaxed/simple;
	bh=UgqILHngj6Gyw5PQr/uALS4Jpv9WIiH3QtFphCP3HAA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=I8/Xv3C8v4Mcw3XDtylQTNVH0gNWd6ImcZp+yiGRTFGVXFDSU7tks6fos0U5vpT5obtsOAsfLJTsroBAulAY39I1dsAcKeJfl64gH1X1egNifvQGgPVCdiGovjYu6+xCNRTSdXLwlJirDBzegs+LtlGutyevh1D70QOBqJMvjfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=z3ntu.xyz; spf=pass smtp.mailfrom=z3ntu.xyz; dkim=pass (1024-bit key) header.d=z3ntu.xyz header.i=@z3ntu.xyz header.b=FiCu9vjF; arc=none smtp.client-ip=128.199.32.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=z3ntu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=z3ntu.xyz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=z3ntu.xyz; s=s1;
	t=1712594393; bh=UgqILHngj6Gyw5PQr/uALS4Jpv9WIiH3QtFphCP3HAA=;
	h=From:Subject:Date:To:Cc;
	b=FiCu9vjF3qnliNr6J7kDXTVgw4ZUjuyxet11KkcsoxK006s+4Cl/3UDaXdND+UAx2
	 OrFo1up+S+LqQPu5j2CSR1EzcGyQ6HiAvBc/iU3j4Kg/CFkiKipQxgtEjbIX9s+fiX
	 MTiu34V2k1NmUMiffVs2vM9w31hPaeZ23990sFDk=
From: Luca Weiss <luca@z3ntu.xyz>
Subject: [PATCH 0/2] Allow gpio-hog nodes in qcom,pmic-gpio bindings (& dt
 fixup)
Date: Mon, 08 Apr 2024 18:39:46 +0200
Message-Id: <20240408-qcom-pmic-gpio-hog-v1-0-f61fc5323110@z3ntu.xyz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANIdFGYC/x3MQQqAIBBA0avErBtQs4iuEi3KJp2FaQoRSHdPW
 r7F/wUyJaYMU1Mg0c2Zw1kh2waMW09LyHs1KKG00GLEywSP0bNBGzmgCxbVpk1/SNFJNUANY6K
 Dn386L+/7ATEtFuZkAAAA
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=619; i=luca@z3ntu.xyz;
 h=from:subject:message-id; bh=UgqILHngj6Gyw5PQr/uALS4Jpv9WIiH3QtFphCP3HAA=;
 b=owEBbQKS/ZANAwAIAXLYQ7idTddWAcsmYgBmFB3WpBhApA+Bhim0b2gEEMYkGswaVpLvw7sZl
 DxKiS3Z4vSJAjMEAAEIAB0WIQQ5utIvCCzakboVj/py2EO4nU3XVgUCZhQd1gAKCRBy2EO4nU3X
 VnQBD/9g+/Uuv1wZPvIkIaFcDmxaE+/dARx7wyPgzaWfRPB/99QqnEhgbfsGZvLof9AMCTL4A2L
 VLYEBykzCR1QVCPUhYjlVEXHmZ54oNNTuO6gZKVIbwaBsHcWpM6dpyHrxdgGzvWW0gp8pxy3DiL
 RaWrx9rixRiYD9uMB5PVBeF7WYbuguNvAGqRiOy7Vp2OlHDpMkvMptI5M/lFqqPbrEQlvXfvVQq
 aMuhC0VKJ7hKKnx9jO+cbyMWwLWE6gXvWGTshTmX4uM+iOjDQy4XHB19b2gDpv8o/6LzUs5GC0F
 ON1qBfx4ZUjmg7/+8h50HGjlAgnKpofY9o6CIXq2AlBg4b/guPJg5XwKl21Ll11xpdviR25rfn1
 72h2Q8DiFsP7KznV4F6lpJBE1S/shScVsc2Z+SC8UhWcaMgVuMAbNevTyJWj9HrZIbC+E5J1wm4
 KioIpL4n+yxapp84PUF/qL3sf55faDyhzKgr8no/fo1E6pTRSIgqU4FGucaGVEKOoieyiGgaHWv
 Ba8fjXtmT4wRgvb2XzqgrO3du7uYd/PAg9Fopc1X+Smp5fVF1R0GNiurlcP4scARo2klqxwHK7k
 aerv/MzVEGq5U0ppJ7xvnTTMl2iPKBGg2NyR/eGJFZPof29CZlMWNd1l2652PubsCTWqbJjD9Tj
 xRsFkbo5g6nmedg==
X-Developer-Key: i=luca@z3ntu.xyz; a=openpgp;
 fpr=BD04DA24C971B8D587B2B8D7FAF69CF6CD2D02CD

Resolve the dt validation failure on Nexus 5.

Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
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



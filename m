Return-Path: <linux-kernel+bounces-36056-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F1D2A839ACE
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 22:05:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 81413B2499C
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 21:05:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3605B47793;
	Tue, 23 Jan 2024 21:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=z3ntu.xyz header.i=@z3ntu.xyz header.b="Ve4vV3h8"
Received: from ahti.lucaweiss.eu (ahti.lucaweiss.eu [128.199.32.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4B8D12E7B;
	Tue, 23 Jan 2024 21:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=128.199.32.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706043877; cv=none; b=U0jRS9uNs8TYjLFaJgWGqJxTjHaVqHY2j92sEU7G+BLZos5doD9Mf4xTMu5aSZPTrbzCwA4XUnc8+v5Kb4dvVKguxCV0wkRPrbqUPvoQWqUErzaqyCVWt+tpZOmkI+pFszPEbb0NLuVwjnUOuF8WC7n34tLbrB+EeOHCCLk968A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706043877; c=relaxed/simple;
	bh=CKtMfO6Bfzyox+5EUVJ1yI9kA2uCj8V8lQP91cG1mvA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=eJ74qBBhz2uBoZbJqIAcLTp61CvhJMQ+IT+toVYKeFAOoQUdClRpUBndoFRVJYDCpd1UQKcSYLj53x2Fjal1ThY2u23X+xBbhOCwaZiIpW77K/e2OgLYgBX3bV+W0vYwceiblxhwIBlRmBIkJFr8sA0FGTDXvihRv2CsPtcxYDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=z3ntu.xyz; spf=pass smtp.mailfrom=z3ntu.xyz; dkim=pass (1024-bit key) header.d=z3ntu.xyz header.i=@z3ntu.xyz header.b=Ve4vV3h8; arc=none smtp.client-ip=128.199.32.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=z3ntu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=z3ntu.xyz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=z3ntu.xyz; s=s1;
	t=1706043866; bh=CKtMfO6Bfzyox+5EUVJ1yI9kA2uCj8V8lQP91cG1mvA=;
	h=From:Subject:Date:To:Cc;
	b=Ve4vV3h83HsNyUHx0wDQAQrD/AtjaoMoh+H+4DnOVWwYZFSHaPUhfvPGh1nrM87cn
	 WwMYzpdGemNdpcw2sgM/Wcjz1TdImDZUjdJ5FmMYe22+NT6cwKi8YRNSMGj6tHqzol
	 S+5g0UDvr/W+VEYXIOSpoUoSGde7REYzYPF1UcUg=
From: Luca Weiss <luca@z3ntu.xyz>
Subject: [PATCH 0/3] Add MDSS_BCR reset for MSM8953
Date: Tue, 23 Jan 2024 22:03:54 +0100
Message-Id: <20240123-msm8953-mdss-reset-v1-0-bb8c6d3ce897@z3ntu.xyz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALopsGUC/x2MQQqAIBAAvxJ7TjDNsL4SHSTX2oMWbkQg/T3pN
 MxhpgBjJmSYmgIZb2I6UpWubWDdXdpQkK8OSqpedkqLyNGOptIzi4yMlxisltZJHUIwUMMzY6D
 nn87L+35ar2NRZAAAAA==
To: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Luca Weiss <luca@z3ntu.xyz>, Vladimir Lypak <vladimir.lypak@gmail.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=758; i=luca@z3ntu.xyz;
 h=from:subject:message-id; bh=CKtMfO6Bfzyox+5EUVJ1yI9kA2uCj8V8lQP91cG1mvA=;
 b=owEBbQKS/ZANAwAIAXLYQ7idTddWAcsmYgBlsCnVCCHHoC3NJac8mzXQRwG4STJPMvdCDV3LN
 BKhPFfN5m6JAjMEAAEIAB0WIQQ5utIvCCzakboVj/py2EO4nU3XVgUCZbAp1QAKCRBy2EO4nU3X
 VkkxD/48FVfzjdGeBTusDywMmrPM+JjWI6YgcN9Ys473zlgjt7DtSuYr4mM/l7229VHt3LT7/zx
 MJQG5e+XQPCXa/wYqZ3izEkygl/anbiCglAkCNQu4uoc2ET8KGUyx5qZVbwie+61jMjNG0Gj4C0
 W5uCWYprbt8Wpi92P2rqVuUPdh/LnSbNL2wIXjuvDMoCIgJKUdAcoyORzIUD6YlETVnRDgP/+3K
 v/zdH3dfXl+I4OaxXFHpBPIxhIJyR5H1bWX1+maD4wxk1eWyvVVfHgoVlmkrIpNqoIRWM43Uq0O
 NVbZkME+23RnEOwxetPnuScaxk6GqzvYPlWVk6Oh92xltAqdBSC1fWJqyl1C5HTUqfcaLLJSU3F
 JS+q4hxku2Kcyt4/f0bXvoTS/WcCLj/9jpCeUPtmQFqgWuHmXUakIuy2bkZ+zSA0xcGa2iHhtHz
 77tXDnc4BdaGPdxqJXX373I6HuGkT35er34XYx0RiFpTlkuSJzxK+iuxYE1wHG0q+UJRXqR2Bo4
 p+6EeDLTY4WYJ/Fp0dPC1g+T7H0C0uyJO/PH5kFeiahlsIU/+dV4WY4UsGxth1YyF914GJfnj2B
 VYd390Qk0jf55wKU3O/ThS+3dOEPX8YhWV3ZFyQvUtU9XatZ+eQ5n0sy9yto5UahLpeRXCH6yhu
 HJ+En5+GQYB7f2A==
X-Developer-Key: i=luca@z3ntu.xyz; a=openpgp;
 fpr=BD04DA24C971B8D587B2B8D7FAF69CF6CD2D02CD

Add the MDSS_BCR reset that is found in the GCC of MSM8953 so we can
make sure the MDSS gets properly reset before Linux starts using it.

Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
---
Vladimir Lypak (3):
      dt-bindings: clock: gcc-msm8953: add reset for MDSS subsystem
      clk: qcom: gcc-msm8953: add MDSS_BCR reset
      arm64: dts: qcom: msm8953: add reset for display subsystem

 arch/arm64/boot/dts/qcom/msm8953.dtsi        | 2 ++
 drivers/clk/qcom/gcc-msm8953.c               | 1 +
 include/dt-bindings/clock/qcom,gcc-msm8953.h | 1 +
 3 files changed, 4 insertions(+)
---
base-commit: 6613476e225e090cc9aad49be7fa504e290dd33d
change-id: 20240123-msm8953-mdss-reset-68308a03fff5

Best regards,
-- 
Luca Weiss <luca@z3ntu.xyz>



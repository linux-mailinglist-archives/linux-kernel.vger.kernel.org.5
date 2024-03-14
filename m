Return-Path: <linux-kernel+bounces-103704-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 13ED987C32C
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 19:57:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 92D4C1F25B44
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 18:57:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F7C976042;
	Thu, 14 Mar 2024 18:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=z3ntu.xyz header.i=@z3ntu.xyz header.b="mrAspwOU"
Received: from ahti.lucaweiss.eu (ahti.lucaweiss.eu [128.199.32.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E04274E0C;
	Thu, 14 Mar 2024 18:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=128.199.32.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710442611; cv=none; b=fr2ryWaq5Ag/em/2DZehANLtI/HriBsOXEO0gCglfTIwlxeyT9ZRiw9fAyKrSs385QeC9I6V/j1L45CZ4PIWfs5ZTavnwgpyzaDGIlejRtesixNBeFlJwO+KMIfoC+RpJ5flHBAYeU2DAMNzgyceexcCGRv3/97VUasre1khjnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710442611; c=relaxed/simple;
	bh=FUaI4RqMLQO3rkMJlSD7LNcWgRqyRFsb7AwhBmCJQis=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=jKmf99XhOnDNxvnKPh8WSyvJkn3qqoU5Fs3AnEuvtdaKwfamK8h11CGEXPl+9vPp5Yr7yUcoNVP3pmiaC6VdiB8FaW+MOH8+PeazH86bVur0kHzU5J4OP0kT0BOrNVRoHouo+C5bajt3JYn+Se5+QhXGQ2ub3VKRaHGdGuw5lBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=z3ntu.xyz; spf=pass smtp.mailfrom=z3ntu.xyz; dkim=pass (1024-bit key) header.d=z3ntu.xyz header.i=@z3ntu.xyz header.b=mrAspwOU; arc=none smtp.client-ip=128.199.32.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=z3ntu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=z3ntu.xyz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=z3ntu.xyz; s=s1;
	t=1710442601; bh=FUaI4RqMLQO3rkMJlSD7LNcWgRqyRFsb7AwhBmCJQis=;
	h=From:Subject:Date:To:Cc;
	b=mrAspwOULfmL+6viDSOeA3tjxcvSVbMbH2IEyXvVvGvRDs6+5cas4TSXsiCf5F20m
	 7dTaN0FmZg71T5A23cSul/mM75FYfnrMpIZDu4iZx7udUV1y8YqpreqWSRfq6Lmkz/
	 5k16kYfWJxHfOprH9KM5ick7iXUf6YMLh+G13Sag=
From: Luca Weiss <luca@z3ntu.xyz>
Subject: [PATCH v2 0/3] Split sony-castor into shinano-common and add Sony
 Xperia Z3
Date: Thu, 14 Mar 2024 19:56:21 +0100
Message-Id: <20240314-shinano-common-v2-0-a0fce1c72c74@z3ntu.xyz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFVI82UC/3XMSw7CIBSF4a00dyyGRzXRkftoOkC4yB0UDFTSR
 9i72LnD/yTn2yFjIsxw73ZIWChTDC3kqQPjdXghI9saJJc9V4Kz7CnoEJmJ0xQD4zflUF4cKi2
 gnd4JHS0HOIytPeU5pvXwi/itf6kiGGf22hurpMSn0Y9NhflzXtYNxlrrF4qJnBKsAAAA
To: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Luca Weiss <luca@z3ntu.xyz>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1257; i=luca@z3ntu.xyz;
 h=from:subject:message-id; bh=FUaI4RqMLQO3rkMJlSD7LNcWgRqyRFsb7AwhBmCJQis=;
 b=owEBbQKS/ZANAwAIAXLYQ7idTddWAcsmYgBl80hhmZr6N6GqTb2VF4Rv3OEgEY/CcSQDc9tFg
 sqV4eK9Bq2JAjMEAAEIAB0WIQQ5utIvCCzakboVj/py2EO4nU3XVgUCZfNIYQAKCRBy2EO4nU3X
 Vnw2EAC0/1yrGasKuYSE4aQcjgSBSK/maOwW0fb+HX8qH2EcV2NvRYsgDCaItIJnRjc56UU3ZFF
 82LTvsPzgMyCUdFEgervjumxtbbnPceTQ0rpq6iORLvNOaxoa/QkuGy4hqlRz5y+8Y+en8J96m6
 zDInkYtT0qHfuhJrZcGI2GT/OZoca+gbwxmrUUcnqcJMnofcIjtfeNRpRrwYWCrSomK0u/s89+r
 rh9RvFDmBH3OVBLwUN7wlhzDahzjnhzm31fs9DIaZORXA0ls3aCgo8Wp4LM7IJi1CWFSR1WBK91
 QIeBMQbcVJeZkc4W6n0qFSZNneisrhfanx1ewi3aFaZvFv8X33T5SvODDBTgsYIf2EEh5Toe9wr
 xZMEMQ7Uvc+GIYX6wrr5be5Z3giTln/ePXN98XrgpZUV0szQWJ2cdSWK9WpsOmxMUnUxLcl7YQ9
 WI3Rh5TeDiOLmkY7Ww0OoCwtjcRCD0ByJOhPnItV+cHojgKnkjip1pfarXz6HOZWAlMc0LrNnK5
 BpAGgydD79WD6mCpTHGIyMCILMNF+UnxZP7GyklcdnOdcwnc1NJdBAvJZIsZk2IHG4B8CYlel7b
 fJYVssMrHeMnncBtWIwqYDN/VdErGHfIPVngrmYMxUm1/z4XTvthvgSi6n8FuiKc67+sXWcxXTq
 N/WzS1AAZltacTg==
X-Developer-Key: i=luca@z3ntu.xyz; a=openpgp;
 fpr=BD04DA24C971B8D587B2B8D7FAF69CF6CD2D02CD

Prepare for adding sony-leo dts by splitting common parts into a
separate dtsi file.

Then add the dts for Sony Xperia Z3.

Depends on:
https://lore.kernel.org/linux-arm-msm/20240306-castor-changes-v1-0-2286eaf85fff@z3ntu.xyz/T/

Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
---
Changes in v2:
- Add leo dtb to Makefile
- Add newlines between the subnodes in the backlight node
- Pick up tags
- Link to v1: https://lore.kernel.org/r/20240310-shinano-common-v1-0-d64cd322ebca@z3ntu.xyz

---
Luca Weiss (3):
      ARM: dts: qcom: msm8974-sony-castor: Split into shinano-common
      dt-bindings: arm: qcom: Add Sony Xperia Z3
      ARM: dts: qcom: Add Sony Xperia Z3 smartphone

 Documentation/devicetree/bindings/arm/qcom.yaml    |   1 +
 arch/arm/boot/dts/qcom/Makefile                    |   1 +
 .../qcom-msm8974pro-sony-xperia-shinano-castor.dts | 551 +--------------------
 ...qcom-msm8974pro-sony-xperia-shinano-common.dtsi | 535 ++++++++++++++++++++
 .../qcom-msm8974pro-sony-xperia-shinano-leo.dts    |  44 ++
 5 files changed, 602 insertions(+), 530 deletions(-)
---
base-commit: bee52eeb37d8124a07711657d1650bf3b467e7dd
change-id: 20240310-shinano-common-093fe25fe3a1

Best regards,
-- 
Luca Weiss <luca@z3ntu.xyz>



Return-Path: <linux-kernel+bounces-32217-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B2EBA835851
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 23:42:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D85941C212F8
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 22:42:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A5783987A;
	Sun, 21 Jan 2024 22:41:44 +0000 (UTC)
Received: from relay01.th.seeweb.it (relay01.th.seeweb.it [5.144.164.162])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 964BF38392
	for <linux-kernel@vger.kernel.org>; Sun, 21 Jan 2024 22:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.144.164.162
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705876903; cv=none; b=R9vWYYkKlbuzXyFBpUULGg+38M4kdBElxPr8FoSKSRvCQ+QubKW9MBIyOmi945VMHMHX/7Z+wkEnt69s0P76whMyi8Dju+Yh4YbNfMc86N61XJDaRdm36Onh/2Bh+eeQUxXJIs6rnupPiCXSY4AhmnMONuYo12/YvTLraUi8Q3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705876903; c=relaxed/simple;
	bh=ZjsDfBtfx+AfvdgrvEbs+TSdw0CqYDKGBl6lNghc0SU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=HV+oZ6RUXwktBEU+uEyRfDmhPuvh8wDqjjDxWg7EE/M9AO5gzui+7GaDTY08Y4BaHrEGnYE+resJFJxGDz2Wl2DjWqGxsFL6ywWHOJSWdLK2LU/mIQFktXV8+x3fI0+JS4Qc4ClasEwE/aG+CmdCDYLo2vzqmrckpBWLKAdApDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=somainline.org; spf=pass smtp.mailfrom=somainline.org; arc=none smtp.client-ip=5.144.164.162
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=somainline.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=somainline.org
Received: from Marijn-Arch-PC.localdomain (94-211-6-86.cable.dynamic.v4.ziggo.nl [94.211.6.86])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by m-r1.th.seeweb.it (Postfix) with ESMTPSA id 42C1520313;
	Sun, 21 Jan 2024 23:33:39 +0100 (CET)
From: Marijn Suijten <marijn.suijten@somainline.org>
Subject: [PATCH v2 0/6] arm64: dts: qcom: msm8956-loire: SDCard and USB
 support
Date: Sun, 21 Jan 2024 23:33:37 +0100
Message-Id: <20240121-msm8976-dt-v2-0-7b186a02dc72@somainline.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMKbrWUC/zXMQQ6CMBBA0auQWVtSpo2AK+9hXFSYwhDbkikaE
 8LdbUxc/sV/O2QSpgyXagehN2dOsQSeKhhmFydSPJYG1Gh1g40KOXR9e1bjplrjLRKRbx4DlGE
 V8vz5Ybd7aS8pqG0Wcn8Ci2DRoLZ93WpjO6uK6ISXWOcXLxvFa07BcXxypDrJBMfxBYT8DoKkA
 AAA
To: Bjorn Andersson <andersson@kernel.org>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: ~postmarketos/upstreaming@lists.sr.ht, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Luca Weiss <luca@z3ntu.xyz>, Adam Skladowski <a39.skl@gmail.com>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, 
 Martin Botka <martin.botka@somainline.org>, 
 Jami Kettunen <jami.kettunen@somainline.org>, linux-arm-msm@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>
X-Mailer: b4 0.12.4

Add pinctrl nodes to enable SD Cards to work on the Sony Loire platform,
and define extcon nodes in PMI8950 to feed into the ci-hdrc driver as it
cannot figure out the presence of a USB cable (nor the desired role
based on the ID pin) on its own.  While at it, extend PMI8950 with some
more channels with now-available VADC_ register constants.

Depends on:
- dt-bindings: iio: qcom-spmi-vadc: Add definitions for USB DP/DM VADCs:
  https://lore.kernel.org/linux-arm-msm/20221111120156.48040-2-angelogioacchino.delregno@collabora.com/

Changes since v1:
- Moved pinctrl-names before pinctrl-N (Konrad);
- Keep status=okay last in OTG node (Konrad);
- Rename `adc-chan@` node names to `channel@` (my own patch from a long
  time ago).

v1: https://lore.kernel.org/linux-arm-msm/60a40ace-d4e9-df74-88f9-4354d80efaac@linaro.org/

Marijn Suijten (6):
  arm64: dts: qcom: pmi8950: Add USB vbus and id sensing nodes
  arm64: dts: qcom: msm8956-loire: Add usb vbus and id extcons to
    ci-hdrc
  arm64: dts: qcom: pmi8950: Add missing ADC channels
  arm64: dts: qcom: msm8976: Declare and use SDC1 pins
  arm64: dts: qcom: msm8976: Declare and use SDC2 pins
  arm64: dts: qcom: msm8956-loire: Add SD Card Detect to SDC2 pin states

 .../qcom/msm8956-sony-xperia-loire-kugo.dts   |   6 ++
 .../dts/qcom/msm8956-sony-xperia-loire.dtsi   |  25 +++++
 arch/arm64/boot/dts/qcom/msm8976.dtsi         | 100 ++++++++++++++++++
 arch/arm64/boot/dts/qcom/pmi8950.dtsi         |  38 +++++++
 4 files changed, 169 insertions(+)

--
2.39.0

---
Marijn Suijten (6):
      arm64: dts: qcom: pmi8950: Add USB vbus and id sensing nodes
      arm64: dts: qcom: msm8956-loire: Add usb vbus and id extcons to ci-hdrc
      arm64: dts: qcom: pmi8950: Add missing ADC channels
      arm64: dts: qcom: msm8976: Declare and use SDC1 pins
      arm64: dts: qcom: msm8976: Declare and use SDC2 pins
      arm64: dts: qcom: msm8956-loire: Add SD Card Detect to SDC2 pin states

 .../dts/qcom/msm8956-sony-xperia-loire-kugo.dts    |   6 ++
 .../boot/dts/qcom/msm8956-sony-xperia-loire.dtsi   |  25 ++++++
 arch/arm64/boot/dts/qcom/msm8976.dtsi              | 100 +++++++++++++++++++++
 arch/arm64/boot/dts/qcom/pmi8950.dtsi              |  38 ++++++++
 4 files changed, 169 insertions(+)
---
base-commit: ad5c60d66016e544c51ed98635a74073f761f45d
change-id: 20240121-msm8976-dt-73f42eeef1bc

Best regards,
-- 
Marijn Suijten <marijn.suijten@somainline.org>



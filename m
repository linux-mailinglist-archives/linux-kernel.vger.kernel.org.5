Return-Path: <linux-kernel+bounces-126586-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 158C6893A11
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 12:11:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 810A91F2229A
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 10:11:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7387168DF;
	Mon,  1 Apr 2024 10:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JqZVze4S"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F211AFC17;
	Mon,  1 Apr 2024 10:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711966255; cv=none; b=IU4YCGugK8qPwrUH40AG2FICpA51eCsMFGJiO2debTNru9lDPNyge1HkTbtKBHboMHnNQYkI3eGRC7jDg79VXY2PUwceEGv7J+t58UHw3J7371FevCgZN+BverbEzkN/p1ekb4wUUQ2jSNPzFSF2ggG7/p0BNMvcyCmrSAoEePM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711966255; c=relaxed/simple;
	bh=N5wbw2MnTKS/5RK9ZX2lKvMkhhY+eswYx65v4Ex7yME=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=O/26c6ZCMzCIKMQffgIl95grqTRnG3p1hmhMsXrnFXVKNb9KInfGAK7KpFdol3RCy/vVe72ImsWbD8lY92Hr91kRmXA1++YQyyBv5w/q3NjKvYhlL8lrMTvMrrZY3Agy/63CyyzTJn+TSPE/HHK4anuTCJTDjX7hB7mg26yoOZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JqZVze4S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id BC495C433F1;
	Mon,  1 Apr 2024 10:10:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711966254;
	bh=N5wbw2MnTKS/5RK9ZX2lKvMkhhY+eswYx65v4Ex7yME=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=JqZVze4Sf9kDR70QfYPtILbk+0ghgXLLKUbEFUyumrEKnQMxb8IQjvf36WqkxzZMD
	 6hzSb2twRKbs9P++P+nHyp33GUkgRyW3UizQmbT/MkObV4hpPIfEekNimvYXFvA6Is
	 IqcHUDHIHTbxS0p620y8UhWWAdTSdFDDqq6HqvTxfVDLsNOmaTRM0kVIhqPrLwq2Xl
	 ztXC6FhtrvjbB0KEMAvBYS52gumewKpLg4mUvVEf8yzciF5y0YBHGfMlIAt0zZ76YM
	 btxmzu0ch42KBc1nASTPzhJVQRsGbTQa3BZk+Rtv/zlKoCiGs6DAHib8crhnOpzqd9
	 6CTFAMQhYSemg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6DF3CD1288;
	Mon,  1 Apr 2024 10:10:54 +0000 (UTC)
From: Xianwei Zhao via B4 Relay <devnull+xianwei.zhao.amlogic.com@kernel.org>
Subject: [PATCH v3 0/5] Baisc devicetree support for Amlogic A4 and A5
Date: Mon, 01 Apr 2024 18:10:48 +0800
Message-Id: <20240401-basic_dt-v3-0-cb29ae1c16da@amlogic.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACmICmYC/22MywqDMBBFf0Wybkpm4quu+h+llBgTHaimJBJax
 H9vdGWhy3O55ywsGE8msCZbmDeRArkpgTxlTA9q6g2nLjFDgbmQgLxVgfSjmzkUJq8KLFQOkqX
 7yxtL7z11uyceKMzOf/ZyhG39E4nABa8sQGelEvWlvKrx6XrSZ+1GtmUiHlQUBxWTWtZgtG1Rt
 sr+quu6fgHmGofN3QAAAA==
To: Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 Jerome Brunet <jbrunet@baylibre.com>, Kevin Hilman <khilman@baylibre.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org, 
 linux-serial@vger.kernel.org, Xianwei Zhao <xianwei.zhao@amlogic.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1711966252; l=2281;
 i=xianwei.zhao@amlogic.com; s=20231208; h=from:subject:message-id;
 bh=N5wbw2MnTKS/5RK9ZX2lKvMkhhY+eswYx65v4Ex7yME=;
 b=HJ4Y6rVs3Ko4rtxCb2S3YncOGcj95WtddZ5a28tWO5DhOf4QZsNzBblo93y0AcDmkm0MIG44a
 oizL5JSYrk5ClFUJCFY8afUZbCqUms1epCd5QivqZcogc7AIatuK3iC
X-Developer-Key: i=xianwei.zhao@amlogic.com; a=ed25519;
 pk=o4fDH8ZXL6xQg5h17eNzRljf6pwZHWWjqcOSsj3dW24=
X-Endpoint-Received: by B4 Relay for xianwei.zhao@amlogic.com/20231208 with
 auth_id=107
X-Original-From: Xianwei Zhao <xianwei.zhao@amlogic.com>
Reply-To: xianwei.zhao@amlogic.com

Amlogic A4 and A5 are application processors designed for smart audio
and IoT applications.

Add the new A4 SoC/board device tree bindings.

Add the new A5 SoC/board device tree bindings.

Add A4 UART compatible line for documentation.

Add basic support for the A4 based Amlogic AV400 board, which describes
the following components: CPU, GIC, IRQ, Timer and UART. These are capable of
booting up into the serial console.

Add basic support for the A5 based Amlogic AV400 board, which describes
the following components: CPU, GIC, IRQ, Timer and UART. These are capable of
booting up into the serial console.

Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
---
Changes in v3:
- Keep alphabetical order.
- Add the necessary spaces.
- Link to v2: https://lore.kernel.org/r/20240320-basic_dt-v2-0-681ecfb23baf@amlogic.com

Changes in v2:
- Delete bindings for uncommitted boards.
- Add A4 UART compatible line for documentation.
- Use common dtsi for a4 and a5.
- Fix psci version 1.0, and fix some formats.
- Modify secmon reserved memory size 10M(actual using).
- Link to v1: https://lore.kernel.org/r/20240312-basic_dt-v1-0-7f11df3a0896@amlogic.com

---
Xianwei Zhao (5):
      dt-bindings: arm: amlogic: add A4 support
      dt-bindings: arm: amlogic: add A5 support
      dt-bindings: serial: amlogic,meson-uart: Add compatible string for A4
      arm64: dts: add support for A4 based Amlogic BA400
      arm64: dts: add support for A5 based Amlogic AV400

 Documentation/devicetree/bindings/arm/amlogic.yaml | 12 ++++
 .../bindings/serial/amlogic,meson-uart.yaml        |  4 +-
 arch/arm64/boot/dts/amlogic/Makefile               |  2 +
 .../boot/dts/amlogic/amlogic-a4-a113l2-ba400.dts   | 42 ++++++++++++++
 arch/arm64/boot/dts/amlogic/amlogic-a4-common.dtsi | 66 ++++++++++++++++++++++
 arch/arm64/boot/dts/amlogic/amlogic-a4.dtsi        | 40 +++++++++++++
 .../boot/dts/amlogic/amlogic-a5-a113x2-av400.dts   | 42 ++++++++++++++
 arch/arm64/boot/dts/amlogic/amlogic-a5.dtsi        | 40 +++++++++++++
 8 files changed, 247 insertions(+), 1 deletion(-)
---
base-commit: 7092cfae086f0bc235baca413d0bd904f182670c
change-id: 20240312-basic_dt-15e47525a413

Best regards,
-- 
Xianwei Zhao <xianwei.zhao@amlogic.com>




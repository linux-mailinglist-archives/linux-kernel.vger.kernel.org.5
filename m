Return-Path: <linux-kernel+bounces-155304-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2849D8AE88E
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 15:48:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD2D81F24E98
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 13:48:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 876C413BAE7;
	Tue, 23 Apr 2024 13:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n1YofQiA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B32831369BE;
	Tue, 23 Apr 2024 13:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713880012; cv=none; b=HS/KxlOTRJM5dimZLLfUebBvEKas7XGw8TyGfqgyA4VchHJlbHcuJekAgm3r1NpUGXE0IHzq/7ZP50kd3YDRe4V0eVIIPWBFmyjRbca1qhuvyCaOmDMSCiiwa3Ch4LX/1N8I9qNlIM4NTSGbBEw9+0r8o4rmKkpU47BQ/4cS1gI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713880012; c=relaxed/simple;
	bh=Wm1xdrgosT91TDDq0rbWVizXhaR6E3LE+4BSaV+vb6A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QQTbnA4t5zPcw16ck6Pjcl2IYaLfx7HV2laUlKcMKbJaSea3+UjH75So/YGCdxHVrWYdDmA/2XRkoQdTBsewPNaJY3brrwUbInraFT2y2KBUsUz5an1IwUPnrEyID3y5R7ykpXFmlhvjky0ylA3w/LhbN/IaDpDWbS99IwkD9fY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n1YofQiA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DEE8C4AF07;
	Tue, 23 Apr 2024 13:46:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713880012;
	bh=Wm1xdrgosT91TDDq0rbWVizXhaR6E3LE+4BSaV+vb6A=;
	h=From:To:Cc:Subject:Date:From;
	b=n1YofQiAQSaaW+Ph9p5+IdGwbdhbsdJuuaWlpJp0P8IxtxOY0UdutduFzvWdMvCpp
	 EMXcZJ9rSO2IuqjeRgM8qKfvW7c46pPvQt+NlDKhXK3ibVtf9kQ6fphCXOvmgEaxDi
	 LMrPMXgXjxLqIUqKnTjbjudUl2DOmqlh1ILzJu3lwMb85XaHgjfrGmvZFo7jbA68OM
	 qdFFrekPyvUDj/Wu3EJEYWU9Q0v8PzZ1Sqi00kus+a3mXpxv0pnn82qLai0jw5PSEW
	 eafiFqCxKX9hJqcDTq1NsGe6C6vzaxm3oraGlstudxGm0c+REiQNn/4/1S7Lywxrq6
	 X9vqv5Eya3hVQ==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan+linaro@kernel.org>)
	id 1rzGTx-000000008Ke-405K;
	Tue, 23 Apr 2024 15:46:50 +0200
From: Johan Hovold <johan+linaro@kernel.org>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Douglas Anderson <dianders@chromium.org>,
	linux-input@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH 0/6] HID/arm64: dts: qcom: sc8280xp-x13s: fix touchscreen power on
Date: Tue, 23 Apr 2024 15:46:05 +0200
Message-ID: <20240423134611.31979-1-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Elan eKTH5015M touch controller on the X13s requires a 300 ms delay
before sending commands after having deasserted reset during power on.

This series switches the X13s devicetree to use the Elan specific
binding so that the OS can determine the required power-on sequence and
make sure that the controller is always detected during boot. [1]

The Elan hid-i2c driver currently asserts reset unconditionally during
suspend, which does not work on the X13s where the touch controller
supply is shared with other peripherals that may remain powered. Holding
the controller in reset can increase power consumption and also leaks
current through the reset circuitry pull ups.

Note that the latter also affects X13s variants where the touchscreen is
not populated as the driver also exits probe() with reset asserted.

Fix this by adding a new 'no-reset-on-power-off' devicetree property
which can be used by the OS to determine when reset needs to be asserted
on power down and when it safe and desirable to leave it deasserted.

I tried to look for drivers that had already addressed this but it was
only after I finished implementing this that I noticed Doug's reference
to commit 18eeef46d359 ("HID: i2c-hid: goodix: Tie the reset line to
true state of the regulator"), which tried to solve a related problem.

That commit has since been reverted but ultimately resulted in commit
7607f12ba735 ("HID: i2c-hid: goodix: Add support for
"goodix,no-reset-during-suspend" property") being merged to handle the
related case where the touch controller supply is always on.

The implementation is very similar, but I decided to use the slightly
more generic 'no-reset-on-power-off' property name after considering a
number of alternatives (including trying to describe the hardware
configuration in the name). (And as this is not vendor specific, I left
out the prefix.)

Note that my X13s does not have a touchscreen, but I have done partial
verification of the implementation using that machine and the sc8280xp
CRD reference design. Bjorn has promised to help out with final
verification on an X13s with a touchscreen.

The devicetree changes are expected to go in through the Qualcomm tree
once the binding and driver updates have been merged.

Johan


[1] The reset signal is currently deasserted using the pin configuration
    and the controller would be detected if probe is deferred or if user
    space triggers a reprobe through sysfs.


Johan Hovold (6):
  dt-bindings: HID: i2c-hid: add dedicated Ilitek ILI2901 schema
  dt-bindings: HID: i2c-hid: elan: add Elan eKTH5015M
  dt-bindings: HID: i2c-hid: elan: add 'no-reset-on-power-off' property
  HID: i2c-hid: elan: fix reset suspend current leakage
  arm64: dts: qcom: sc8280xp-x13s: fix touchscreen power on
  arm64: dts: qcom: sc8280xp-crd: use external pull up for touch reset

 .../bindings/input/elan,ekth6915.yaml         | 20 ++++--
 .../bindings/input/ilitek,ili2901.yaml        | 66 +++++++++++++++++++
 arch/arm64/boot/dts/qcom/sc8280xp-crd.dts     |  3 +-
 .../qcom/sc8280xp-lenovo-thinkpad-x13s.dts    | 15 +++--
 drivers/hid/i2c-hid/i2c-hid-of-elan.c         | 37 ++++++++---
 5 files changed, 118 insertions(+), 23 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/input/ilitek,ili2901.yaml

-- 
2.43.2



Return-Path: <linux-kernel+bounces-100012-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45BD68790BE
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 10:23:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 774F71C21DEE
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 09:23:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D461779B79;
	Tue, 12 Mar 2024 09:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pcT3fxne"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18BFF78276;
	Tue, 12 Mar 2024 09:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710235141; cv=none; b=kNX1S7J/VDSJRhLP6PmRMmLsg0aPANOFv/JcHoZdZnX0OmCVWxI3CagwydEJU/rMx+kz0i6KWN3R/AlrcFgeEkX+6xcuNxfyoNNRQTa33hDJbqgKrYdb+feUyiBKpfc/NiUSZpre+c+vZKiKWSz8ncPukL1xd4T7PhM/rNrZVTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710235141; c=relaxed/simple;
	bh=ONSKZevXZXWm3KM1dZDImJLLhqOmgtyms2pTuZbvaa4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=PGZAuhsoHqU/wu8EvyduAeR7lODH25MAbUHc1bi7A2UlqBFn3QzxYjuXKoXk9tJwpTT5VSAqdj+MAPNG8esobfHs2RauEDhIuW//RoQglvLYW/gCTVqXU8XmQH6SLHlAORQ69iIIM+8SCnHYrlKhoE93IBVYIoI7Hgm1gsbxjZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pcT3fxne; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A2F44C433F1;
	Tue, 12 Mar 2024 09:19:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710235140;
	bh=ONSKZevXZXWm3KM1dZDImJLLhqOmgtyms2pTuZbvaa4=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=pcT3fxnekgvKqQr1S1HusTZOS/3i9nJcVXJMHIDXsAOjpaQs6K3PVAhZgh/d/UO1U
	 No7Tul3U/e/PSHEz/nUXQ+FLRkDRVZMepVfWs5jsdDPQrQN58cFeviTnXAAhN411Z8
	 tIoSaJYqSBp9c1xp3YGSwA+iLgjF2ZEWIQIlPNEXyH+jtE6lAMeuxILM4LHfZkPZV9
	 XXPNSerxTxcZE1zBVy6suq0lmHXw6AUWHma+tvPS2lMoJ6TwbyANfY7GLnrcjPFxsi
	 CUnYlCzolq6xvkyUW/JsOn1LS/GOx7zR/SB/Nimt+1RFOpSOvSIqg5Xt2IlwgDB2n3
	 U9C2Wm7k8Huvg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F516C54E66;
	Tue, 12 Mar 2024 09:19:00 +0000 (UTC)
From: Xianwei Zhao via B4 Relay <devnull+xianwei.zhao.amlogic.com@kernel.org>
Subject: [PATCH 0/4] Baisc devicetree support for Amlogic A4 and A5
Date: Tue, 12 Mar 2024 17:18:56 +0800
Message-Id: <20240312-basic_dt-v1-0-7f11df3a0896@amlogic.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAe8GUC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDY0Mj3aTE4szk+JQSXUPTVBNzUyPTRBNDYyWg8oKi1LTMCrBR0bG1tQD
 9l7CDWgAAAA==
To: Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 Jerome Brunet <jbrunet@baylibre.com>, Kevin Hilman <khilman@baylibre.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org, 
 Xianwei Zhao <xianwei.zhao@amlogic.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1710235139; l=1498;
 i=xianwei.zhao@amlogic.com; s=20231208; h=from:subject:message-id;
 bh=ONSKZevXZXWm3KM1dZDImJLLhqOmgtyms2pTuZbvaa4=;
 b=NtWxuy6gf1pgFYthLf35jwwWmhxqf3Rc0BnrsfAJOvKu/qcXl2lPXRnWSoHgfOP4hVqqZLIwJ
 orWfLOsqpzKC9niMb7l9jtB6dB6XMBEZMH1dA7m6nxhmeTZ78cpXxDF
X-Developer-Key: i=xianwei.zhao@amlogic.com; a=ed25519;
 pk=o4fDH8ZXL6xQg5h17eNzRljf6pwZHWWjqcOSsj3dW24=
X-Endpoint-Received:
 by B4 Relay for xianwei.zhao@amlogic.com/20231208 with auth_id=107
X-Original-From: Xianwei Zhao <xianwei.zhao@amlogic.com>
Reply-To: <xianwei.zhao@amlogic.com>

Amlogic A4 and A5 are application processors designed for smart audio
and IoT applications.

Add the new A4 SoC/board device tree bindings.

Add the new A5 SoC/board device tree bindings.

Add basic support for the A4 based Amlogic AV400 board, which describes
the following components: CPU, GIC, IRQ, Timer and UART. These are capable of
booting up into the serial console.

Add basic support for the A5 based Amlogic AV400 board, which describes
the following components: CPU, GIC, IRQ, Timer and UART. These are capable of
booting up into the serial console.

Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
---
Xianwei Zhao (4):
      dt-bindings: arm: amlogic: add A4 support
      dt-bindings: arm: amlogic: add A5 support
      arm64: dts: add support for A4 based Amlogic BA400
      arm64: dts: add support for A5 based Amlogic AV400

 Documentation/devicetree/bindings/arm/amlogic.yaml | 15 ++++
 arch/arm64/boot/dts/amlogic/Makefile               |  2 +
 .../boot/dts/amlogic/amlogic-a4-a113l2-ba400.dts   | 43 ++++++++++
 arch/arm64/boot/dts/amlogic/amlogic-a4.dtsi        | 99 ++++++++++++++++++++++
 .../boot/dts/amlogic/amlogic-a5-a113x2-av400.dts   | 43 ++++++++++
 arch/arm64/boot/dts/amlogic/amlogic-a5.dtsi        | 94 ++++++++++++++++++++
 6 files changed, 296 insertions(+)
---
base-commit: 7092cfae086f0bc235baca413d0bd904f182670c
change-id: 20240312-basic_dt-15e47525a413

Best regards,
-- 
Xianwei Zhao <xianwei.zhao@amlogic.com>



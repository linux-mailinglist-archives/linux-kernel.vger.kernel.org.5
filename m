Return-Path: <linux-kernel+bounces-108705-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 57ABE880EF0
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 10:44:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0BB8F1F227FF
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 09:44:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB2E73BBDD;
	Wed, 20 Mar 2024 09:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IiQ/KxHj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDCC73B791;
	Wed, 20 Mar 2024 09:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710927869; cv=none; b=NkJHRuIwCIOP0xmMBBcrXGwGqDht1mqB3bQ3sbDDHTyTXgYNAVa5JDVrJlMhvWjBqhFo7A/VNjqc9mCptLWsyYIL9e6v5jJGtRLNKhs7u8pxaYbcnLj5pyyFjPdhGuSrYFZ6PYtgXrtABkzX7bZ4rG84hYH8/hdtbGGDbCLMSEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710927869; c=relaxed/simple;
	bh=57GTWlJ10xHsfYL6870kURGURrNt5JlLAOfaQw5P9Mw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=VXj7HSJ+LcbrwSsz5gTvR7kOLT/VZyK/l6/crvBuGB/g/35C17/RB/k9LY1QBGnYXx5M+YviwPuYWxfXgeFS3Bugp7pc5woUkmGtBs3LqF2A/L7Ea2SH59Sq0k6jBJfUAjLvlRPXNgk2OHmyo/BETHtrv6TuqY4cQH3J5UO4/1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IiQ/KxHj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7F8BBC433F1;
	Wed, 20 Mar 2024 09:44:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710927868;
	bh=57GTWlJ10xHsfYL6870kURGURrNt5JlLAOfaQw5P9Mw=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=IiQ/KxHjF8Wd5+l6cmnn0tVi1X74aXKgNlUIjiSCypFX/Vo4d4HGRUFOzIhj6LhXi
	 KGMNXYfdkatHKKiklOBSpvpSlLYaev+Jtb2JOFstH3tEMS6jd2GCLBLeBA4Dqby1Pq
	 Ch0U46U7VrckcTloNs3lHlWNuYTvbXreBw9JfRitoWnOi7Nccx8S7KtBzEdNx62Tcy
	 XSNdihlGJ2xFIdfsHFN2/DSBu1Vl8rHODiINu8/iMEChOZVz+v+9pyfWYywp1LFDkO
	 Brm+GDyFENOxAQGtsR+ODQvfr/DP12LxZiNNXLxQnsNJU9G2ear/WQ6qNOXn8nv/t7
	 oD9MLlf5zONyg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C0B8CD11C2;
	Wed, 20 Mar 2024 09:44:28 +0000 (UTC)
From: Xianwei Zhao via B4 Relay <devnull+xianwei.zhao.amlogic.com@kernel.org>
Subject: [PATCH v2 0/5] Baisc devicetree support for Amlogic A4 and A5
Date: Wed, 20 Mar 2024 17:44:12 +0800
Message-Id: <20240320-basic_dt-v2-0-681ecfb23baf@amlogic.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOyv+mUC/23MSwrCMBSF4a2UOzaSmyZWO3IfUiTm0V6wjSQlK
 CV7N3bs8D8cvg2Si+QS9M0G0WVKFJYa4tCAmfQyOka2NgguJG9RsIdOZO52Zaic7JRQWmIL9f6
 KztN7p25D7YnSGuJnlzP+1j9IRsZZ5xGtbzU/X05XPT/DSOZowgxDKeULHOVI+qIAAAA=
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1710927866; l=2117;
 i=xianwei.zhao@amlogic.com; s=20231208; h=from:subject:message-id;
 bh=57GTWlJ10xHsfYL6870kURGURrNt5JlLAOfaQw5P9Mw=;
 b=jK6abUosSrr17IwEhUIrG13N7aYIqvBJbqHa/G/LMGiennQnD2whXlY0q+l/D6h/ZnyOdLZ5Y
 pNQOW88O1UfBKE2djyM09f5JDJ3fXPmBlJvlqA9saYln1HnkZzV7BBn
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




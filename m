Return-Path: <linux-kernel+bounces-76042-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CFD7485F24E
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 09:02:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 813B51F22245
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 08:02:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21DBA17BBA;
	Thu, 22 Feb 2024 08:02:29 +0000 (UTC)
Received: from mail-sh.amlogic.com (mail-sh.amlogic.com [58.32.228.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2411117752;
	Thu, 22 Feb 2024 08:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=58.32.228.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708588948; cv=none; b=hRR7Ov7nd84thtv7n+3CYhYEtH2xk0yiQq9jmM6tQjoIJJJXkB/JdZq4Cbl60zad3IFdfiTs4plYpDHzPkQ8nlrTUnzjJbi0JcbTheISZUrKx61dCNRC3XGedKUZs6w2f5qTBpL0eqmGgVaLdneISrbaGi5NV5JsNS9PTiQG3CU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708588948; c=relaxed/simple;
	bh=IvjVizbHXOdzpVxvvI2LRbBUB7ynmTTo1AJA9R+lU0g=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=YSXuXZqSjVUWYQmcOnbDfKwdaoMXwcfPk6JDXRhfrQ0lU4GDufdoxDPXply0PMNwVPyXc8CKIgRMkxFsjoGcampWAMYJU2q0Wl/N346U0/v/JDxMBRd4MdKfCGSYGRo0nN5JJQnXdGyjHLNI5TiHfbgwCOAWqhTOz02uT7esWGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com; spf=pass smtp.mailfrom=amlogic.com; arc=none smtp.client-ip=58.32.228.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amlogic.com
Received: from rd02-sz.amlogic.software (10.28.11.83) by mail-sh.amlogic.com
 (10.18.11.5) with Microsoft SMTP Server id 15.1.2507.6; Thu, 22 Feb 2024
 15:47:16 +0800
From: Huqiang Qin <huqiang.qin@amlogic.com>
To: <tglx@linutronix.de>, <robh+dt@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
	<neil.armstrong@linaro.org>, <khilman@baylibre.com>, <jbrunet@baylibre.com>,
	<martin.blumenstingl@googlemail.com>, <hkallweit1@gmail.com>
CC: <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-amlogic@lists.infradead.org>,
	Huqiang Qin <huqiang.qin@amlogic.com>
Subject: [RESEND PATCH 0/3] Add GPIO interrupt support for Amlogic-T7 SoCs
Date: Thu, 22 Feb 2024 15:46:36 +0800
Message-ID: <20240222074640.1866284-1-huqiang.qin@amlogic.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

This patch adds GPIO interrupt support for Amloigc-T7 SoC (A311D2)

Huqiang Qin (3):
  dt-bindings: interrupt-controller: Add support for Amlogic-T7 SoCs
  irqchip: Add support for Amlogic-T7 SoCs
  arm64: dts: Add gpio_intc node for Amlogic-T7 SoCs

 .../interrupt-controller/amlogic,meson-gpio-intc.yaml  |  1 +
 arch/arm64/boot/dts/amlogic/amlogic-t7.dtsi            | 10 ++++++++++
 drivers/irqchip/irq-meson-gpio.c                       |  5 +++++
 3 files changed, 16 insertions(+)

-- 
2.42.0



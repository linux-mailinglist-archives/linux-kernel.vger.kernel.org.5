Return-Path: <linux-kernel+bounces-144012-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E5A2F8A40CA
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 08:57:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 84F721F21258
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 06:57:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7E171CD3B;
	Sun, 14 Apr 2024 06:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sirabella.org header.i=@sirabella.org header.b="gEiq5i92"
Received: from sirabella.org (sirabella.org [207.246.81.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 987E66AA1;
	Sun, 14 Apr 2024 06:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.246.81.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713077818; cv=none; b=rwmzjCVdvUguWwHNtPunBF5gw6+WUiMFpUuxf4nIQrqZE/Eq5nmzz/c7w3g7FDzMBlAXNGoYCOuRPnpaHZPUAycwWJizkywaaMRe34KlYA8aqsYJCg+498wqhNNKBEH2yPWcLOu4IZfRuVRLtuSMTE2/bOlHUxoKsOEXfmjNcY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713077818; c=relaxed/simple;
	bh=9TKWLiX+ZGAnP/e+QhJf41rNF9FnSG7Nawm+9D7GiDg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EKwxdzlsSJAWM4CeVFtFVvM3v+M58QYx4Hnve+sHO77vtVIuMcxwSYNoEb6nPw6PXhDvaY3SPo19XV5SVQseR8KV8CVmFFGaUnf7Ef/WC1JvfpMu9HaDqVkBs4H1ZjwIBmLGKtzinx6gTQsVURYVeyv81h4Zmd8GbZkT1gc0Nyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sirabella.org; spf=pass smtp.mailfrom=sirabella.org; dkim=pass (1024-bit key) header.d=sirabella.org header.i=@sirabella.org header.b=gEiq5i92; arc=none smtp.client-ip=207.246.81.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sirabella.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sirabella.org
From: Marco Sirabella <marco@sirabella.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sirabella.org;
	s=mail; t=1713077492;
	bh=l2H2ron2dMTeEoHZug+m+sVYP7hGlm0Wh9o8YAcI908=;
	h=From:To:Cc:Subject:Date;
	b=gEiq5i923kkJQGIKlOR5GCtkmbUjYpe6gHM7sfoSk+yW0LBZLvyoZN0s0nFtdL7e6
	 iK9l2NNRF0gGgmDbS/xeTQptfFjArXCZ5H2VcJbu2AeEDA1UgoQavrtK+8ejNrzFCR
	 6QL0JfolwZLDgu8k0WMpJ0rpcus6CwQPHZ4TtX0s=
To: linux-kernel@vger.kernel.org
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-gpio@vger.kernel.org,
	linux-doc@vger.kernel.org,
	Marco Sirabella <marco@sirabella.org>
Subject: [PATCH] Documentation: Add additional missing arg to dev_gpiod_get examples
Date: Sun, 14 Apr 2024 02:50:49 -0400
Message-ID: <20240414065049.28981-1-marco@sirabella.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

in 39b2bbe3d715 (gpio: add flags argument to gpiod_get*() functions) a
third argument was added to the function, apply that to examples found
in the tree with a simple regex: gpiod_get\([^(,]*,[^(,]*\)

Signed-off-by: Marco Sirabella <marco@sirabella.org>
---
 Documentation/driver-api/pin-control.rst          | 2 +-
 Documentation/firmware-guide/acpi/enumeration.rst | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/driver-api/pin-control.rst b/Documentation/driver-api/pin-control.rst
index 4639912dc9cc..bdb0a17d092b 100644
--- a/Documentation/driver-api/pin-control.rst
+++ b/Documentation/driver-api/pin-control.rst
@@ -1293,7 +1293,7 @@ So say that your driver is fetching its resources like this:
 	struct gpio_desc *gpio;
 
 	pinctrl = devm_pinctrl_get_select_default(&dev);
-	gpio = devm_gpiod_get(&dev, "foo");
+	gpio = devm_gpiod_get(&dev, "foo", GPIOD_ASIS);
 
 Here we first request a certain pin state and then request GPIO "foo" to be
 used. If you're using the subsystems orthogonally like this, you should
diff --git a/Documentation/firmware-guide/acpi/enumeration.rst b/Documentation/firmware-guide/acpi/enumeration.rst
index 0165b09c0957..f9dcf15f7346 100644
--- a/Documentation/firmware-guide/acpi/enumeration.rst
+++ b/Documentation/firmware-guide/acpi/enumeration.rst
@@ -416,11 +416,11 @@ a code like this::
 
 	struct gpio_desc *irq_desc, *power_desc;
 
-	irq_desc = gpiod_get(dev, "irq");
+	irq_desc = gpiod_get(dev, "irq", GPIOD_IN);
 	if (IS_ERR(irq_desc))
 		/* handle error */
 
-	power_desc = gpiod_get(dev, "power");
+	power_desc = gpiod_get(dev, "power", GPIOD_IN);
 	if (IS_ERR(power_desc))
 		/* handle error */
 
-- 
2.43.2



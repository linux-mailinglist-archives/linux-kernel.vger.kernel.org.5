Return-Path: <linux-kernel+bounces-76043-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F8B585F250
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 09:02:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C021628505A
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 08:02:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7FF017C6E;
	Thu, 22 Feb 2024 08:02:30 +0000 (UTC)
Received: from mail-sh.amlogic.com (mail-sh.amlogic.com [58.32.228.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E790717BB2;
	Thu, 22 Feb 2024 08:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=58.32.228.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708588950; cv=none; b=rrc+GyqDczjq8iAQ0Tl5sH+H/S7o+zkpbF2OSjs2JkMA1p0cmMseEm07152iK6d3H0XZmNXsDJxy02KlNQDDC61R0lGyYKLe72nB3k2Mp1hqjCNZvSIYOiPpt+8MMWodRR5GdzIreSbaxYonU0kcne9ZLH6VeJxw25+SlI/yVU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708588950; c=relaxed/simple;
	bh=uluG5OOemdaFNa5SLIMXMDmGgd9Epf0ejwjb8q7ceu4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JoGAmzrg+SjVi4ovioF6+7kXhCPozY45hUuOy3BQ23yrdBpsDNqtTadRwmdu/6o1RLd20pb7v6CQbvqUPpxgt0OQ1i9113QMy3Rh4vGXw5PsI0RJ6Vxkrqi0MKC7D5UgEnO3oeS3ytxCP8FiFvCuS2o7Tm1OEgkGLLpc6cufgdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com; spf=pass smtp.mailfrom=amlogic.com; arc=none smtp.client-ip=58.32.228.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amlogic.com
Received: from rd02-sz.amlogic.software (10.28.11.83) by mail-sh.amlogic.com
 (10.18.11.5) with Microsoft SMTP Server id 15.1.2507.6; Thu, 22 Feb 2024
 15:47:17 +0800
From: Huqiang Qin <huqiang.qin@amlogic.com>
To: <tglx@linutronix.de>, <robh+dt@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
	<neil.armstrong@linaro.org>, <khilman@baylibre.com>, <jbrunet@baylibre.com>,
	<martin.blumenstingl@googlemail.com>, <hkallweit1@gmail.com>
CC: <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-amlogic@lists.infradead.org>,
	Huqiang Qin <huqiang.qin@amlogic.com>, Conor Dooley
	<conor.dooley@microchip.com>
Subject: [RESEND PATCH 1/3] dt-bindings: interrupt-controller: Add support for Amlogic-T7 SoCs
Date: Thu, 22 Feb 2024 15:46:37 +0800
Message-ID: <20240222074640.1866284-2-huqiang.qin@amlogic.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240222074640.1866284-1-huqiang.qin@amlogic.com>
References: <20240222074640.1866284-1-huqiang.qin@amlogic.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Update dt-binding document for GPIO interrupt controller
of Amlogic-T7 SoCs.

Signed-off-by: Huqiang Qin <huqiang.qin@amlogic.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
---
 .../bindings/interrupt-controller/amlogic,meson-gpio-intc.yaml   | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/amlogic,meson-gpio-intc.yaml b/Documentation/devicetree/bindings/interrupt-controller/amlogic,meson-gpio-intc.yaml
index 3d06db98e978..a93744763787 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/amlogic,meson-gpio-intc.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/amlogic,meson-gpio-intc.yaml
@@ -36,6 +36,7 @@ properties:
               - amlogic,meson-a1-gpio-intc
               - amlogic,meson-s4-gpio-intc
               - amlogic,c3-gpio-intc
+              - amlogic,t7-gpio-intc
           - const: amlogic,meson-gpio-intc
 
   reg:
-- 
2.42.0



Return-Path: <linux-kernel+bounces-101219-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A43187A42A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 09:39:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 341832831CB
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 08:39:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A70A1AAD9;
	Wed, 13 Mar 2024 08:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="funzoX5C"
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A52C413ADD;
	Wed, 13 Mar 2024 08:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710319190; cv=none; b=HKgUC+ERcC2NePVTt2iYKZraV8bXLLL4bPDwYLYmD2Ue6nxt5U8+iHj3CFJxqgFkOs9LBdyx4mzta3EiWhxg6tDdP+WTHU4irYekFSbQfhuugJBdHnligTbnkiiJ7aMPiqHbLsbp0DZ8BPkx1svHnCTISaeLId8yomGsZxQXEY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710319190; c=relaxed/simple;
	bh=I2NCH+zKF63t3KPZsMZfwHRCe1Y8bXSB5tUDGjh7SW8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=GsVsFCpGY8NiFi717DA0c6W9gkTR6nrKyqr+x8ThfOELUnwN6znfU3RX7DCQvz8z4FNcyj9sH4F+RZaV3vbjMl7dHAtYL++yf/xPd8Ax2PyvgMsm9VieQAe15MOceN0o54w1O1oPGTmo2YlLbTXmYw3VemkYnoOqma6gtMgS6wI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=funzoX5C; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2d41f33eb05so61425281fa.0;
        Wed, 13 Mar 2024 01:39:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710319187; x=1710923987; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pQs0TYroIRAKJfQVvy3/z7gpqyxuwupZYCxDuQ5VaZ0=;
        b=funzoX5CVryyPpAekrYv6vv6e4frWsk87MU3/g8oe14YdsldpSW2oQ43eMbqdIL8fr
         5Q3htXfkfPP0szYY/cJlSvQ52v0GhCVle2MDMdK3NPltk1kebZXBjgmTuLcLdbcFyLPA
         JMD3Y54Htd4dfxBbiA+ltrOgy2DBG993hfuB60rj+s+M/xLIYsbBMjYQ0EJFgbgJZq7Q
         rc/h9+sRtmJXixjne5DTuHunYoV97D+3PZ9AYGwCJJ8UrQwlfHVx2cNiYaiLUZQa2BP2
         6dRuXnWPBVTrOL8d4nNKvfP0VranodTaz+BNb7AbE6P79JudCfbz2sPOwrVFZgs8BLtI
         ipHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710319187; x=1710923987;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pQs0TYroIRAKJfQVvy3/z7gpqyxuwupZYCxDuQ5VaZ0=;
        b=spBfXktmyVgi+/NxptphIDuOUhGItStGg3qu+V15hAIIjP1ST1jmHOcKqPHO5FGCGg
         /oDnaB34PRRa0QdpzB1gvVoivFFFbgIC/PaVGHKkHYVJ+FUfKvrrdsRCJwzr0haAO0ur
         Yj7XgL41x9C8t/XqrfgOSvMisY774Wi61FJ4lRwxD2ZSppu3g33A6ec60hrJhMezHwD/
         DusCpdHDGhEB2r4F7+OGGRpKooRSXg7PI9UkVgSV76hxOjs4IrJ8Nz3WaJNKOuB1I1O1
         9+Ku5kVxvVfDafCg5Pjo6bahuufQFVr6wi1j/mY4ynnR1DGoMj2yuirGo5b8Nug9dAWD
         QdNA==
X-Forwarded-Encrypted: i=1; AJvYcCXRfDLnejDuKg2d9SuFnKngGI+I2rpo4dONe0ubyFB/nu107niCwk01LFxmd9BbiMwrcaxDNBP3YQ8t0kERJKPsaZXXcccQJqIgXq1rEFdyNvVKJW6IdVKbiSkRhhA/XbGhAjUi9RvJ4cS8Qk4TF/Ny4xfpMrZztjFiACVi3Dc6vSvNs4w=
X-Gm-Message-State: AOJu0YwN1p73Q4xQN70mQP5Hm/HG/JE00yT8zLfOCv9PwFxTb4ef6Yh2
	SJ7YC9C8SYIKavstSZeha2ytxCnOpwvu96/0p2d6w8gHv+5hHjQrKfNtrGqZ
X-Google-Smtp-Source: AGHT+IHolASeiquwxy9Reloq3RP2YtrrrqjBtLXBwCY1R4Ftihh0fH3w5HBV9HjakLdgEs7nok0aCA==
X-Received: by 2002:a05:6512:10d5:b0:513:ca36:83a6 with SMTP id k21-20020a05651210d500b00513ca3683a6mr604668lfg.23.1710319186144;
        Wed, 13 Mar 2024 01:39:46 -0700 (PDT)
Received: from prasmi.home ([2a00:23c8:2500:a01:dda3:1e7a:f5b7:e10f])
        by smtp.gmail.com with ESMTPSA id n7-20020a05600c3b8700b00413ea3db648sm1138863wms.26.2024.03.13.01.39.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Mar 2024 01:39:45 -0700 (PDT)
From: Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Geert Uytterhoeven <geert+renesas@glider.be>,
	Linus Walleij <linus.walleij@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Magnus Damm <magnus.damm@gmail.com>
Cc: linux-renesas-soc@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Prabhakar <prabhakar.csengg@gmail.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH] dt-bindings: pinctrl: renesas,rzg2l-pinctrl: Allow 'input' and 'output-enable' properties
Date: Wed, 13 Mar 2024 08:38:28 +0000
Message-Id: <20240313083828.5048-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

On the RZ/G3S SMARC platform, the 'input' property is utilized in gpio-hog
nodes, and the 'output-enable' property is used for ETH0/1 TXC pins. Update
the binding documentation to include these properties, addressing the
following dtbs_check warnings:

arch/arm64/boot/dts/renesas/r9a08g045s33-smarc.dtb: pinctrl@11030000: key-1-gpio-hog: 'anyOf' conditional failed, one must be fixed:
	'input' does not match any of the regexes: 'pinctrl-[0-9]+'
	True is not of type 'object'
	[[144, 1]] is not of type 'object'
	['key-1-gpio-irq'] is not of type 'object'
	from schema $id: http://devicetree.org/schemas/pinctrl/renesas,rzg2l-pinctrl.yaml#

arch/arm64/boot/dts/renesas/r9a08g045s33-smarc.dtb: pinctrl@11030000: eth0: 'anyOf' conditional failed, one must be fixed:
	'mux', 'tx_ctl', 'txc' do not match any of the regexes: 'pinctrl-[0-9]+'
	'output-enable' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/pinctrl/renesas,rzg2l-pinctrl.yaml#

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 .../devicetree/bindings/pinctrl/renesas,rzg2l-pinctrl.yaml      | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/pinctrl/renesas,rzg2l-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/renesas,rzg2l-pinctrl.yaml
index d476de82e5c3..4d5a957fa232 100644
--- a/Documentation/devicetree/bindings/pinctrl/renesas,rzg2l-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/renesas,rzg2l-pinctrl.yaml
@@ -120,7 +120,9 @@ additionalProperties:
         slew-rate: true
         gpio-hog: true
         gpios: true
+        input: true
         input-enable: true
+        output-enable: true
         output-high: true
         output-low: true
         line-name: true
-- 
2.34.1



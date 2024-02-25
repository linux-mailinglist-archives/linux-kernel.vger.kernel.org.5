Return-Path: <linux-kernel+bounces-80309-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AFE3862D35
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 22:35:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 41AF0B20B4D
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 21:35:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 816391B960;
	Sun, 25 Feb 2024 21:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="CfAjxxKF"
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D813611C94
	for <linux-kernel@vger.kernel.org>; Sun, 25 Feb 2024 21:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.36.163.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708896886; cv=none; b=PgaUJhwGz1XAweIM2XRfQTUljZCLhvwtMiTQ1MSQ2m2L7jzMiqAUkBmYU8h18ZWv8JTR+cOjHwsnDuvPTAVzad+o/JGpWrcvtdAOVu6+8daw6M3XzROCZusCGhMUAX+dyu8XOe67/zmWjjTalbkEnJjWoSMQ2HWTJBnwr6n0+j0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708896886; c=relaxed/simple;
	bh=WbvVZmdU3+eP8zNMjRLoI4NeeV/7Y/bTDGFIQh4snkc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u/SfCV1xv8oQ8qDGHcPzcckoNv/C3L7DQK/Ka2gj1sHTyE/B+Z03jzxGwu4+ooo2LwHiQt5GFP2xUUfC36KnvC65MudNWIjUaBnyv4rS3M0iGBAKC4phhu12ryavZJcSkV3IvBsOFjwDKZUZdzps8rydLm9YEkv3yyDbWYV4cos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz; spf=pass smtp.mailfrom=alliedtelesis.co.nz; dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b=CfAjxxKF; arc=none smtp.client-ip=202.36.163.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alliedtelesis.co.nz
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id D79B82C0652;
	Mon, 26 Feb 2024 10:34:35 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
	s=mail181024; t=1708896875;
	bh=4gqEtwn93Tho3LTT9o6arNrvbLMX9cEVnx0SJH0vyvo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CfAjxxKF/WKDYBR0a3zpbCxjXNNCzQCfi9GFC5uApYSnQlqw6QEB7+PtAvzGxhPzN
	 CtIFVeZgUTaxaB+5h5b6wSX+mWzt+4XwUavrGFVzDvRfG1Kb0MQ3F6OI7Mqur2wAPG
	 4QulCGr3zYPA7lWDDy2mkKl7Hco07jGWU/qNP2GdwewuNBDGGZBuYfGsj0Q2iezazf
	 IU8j+nNFnWTbOXNKuEB8F/YsbLYe46E1mgZ3AQ8LANR9FNhEQGU3CAXrZanjKQbRWv
	 9Un9Jbf7OlFhX/TAUHLcviVR0LeqdzpYBrqI8cJrQwgzvboPubSNABBnwuEupgUPjd
	 P7IBgNBaEteiQ==
Received: from pat.atlnz.lc (Not Verified[10.32.16.33]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
	id <B65dbb26b0002>; Mon, 26 Feb 2024 10:34:35 +1300
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.30])
	by pat.atlnz.lc (Postfix) with ESMTP id 9EB2E13EE85;
	Mon, 26 Feb 2024 10:34:35 +1300 (NZDT)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
	id 99FF628092F; Mon, 26 Feb 2024 10:34:35 +1300 (NZDT)
From: Chris Packham <chris.packham@alliedtelesis.co.nz>
To: ojeda@kernel.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	andrew@lunn.ch,
	gregory.clement@bootlin.com,
	sebastian.hesselbarth@gmail.com,
	andy.shevchenko@gmail.com,
	geert@linux-m68k.org,
	pavel@ucw.cz,
	lee@kernel.org
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-leds@vger.kernel.org,
	Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: [PATCH 2/3] dt-bindings: auxdisplay: Add bindings for generic 7 segment LED
Date: Mon, 26 Feb 2024 10:34:22 +1300
Message-ID: <20240225213423.690561-3-chris.packham@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240225213423.690561-1-chris.packham@alliedtelesis.co.nz>
References: <20240225213423.690561-1-chris.packham@alliedtelesis.co.nz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-SEG-SpamProfiler-Analysis: v=2.4 cv=BKkQr0QG c=1 sm=1 tr=0 ts=65dbb26b a=KLBiSEs5mFS1a/PbTCJxuA==:117 a=k7vzHIieQBIA:10 a=gEfo2CItAAAA:8 a=wDxYY4ZP0rUsokw9mtgA:9 a=3ZKOabzyN94A:10 a=sptkURWiP4Gy88Gu7hUp:22
X-SEG-SpamProfiler-Score: 0
x-atlnz-ls: pat

Add bindings for a generic 7 segment LED display using GPIOs.

Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
---
 .../auxdisplay/generic,gpio-7seg.yaml         | 40 +++++++++++++++++++
 1 file changed, 40 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/auxdisplay/generic,=
gpio-7seg.yaml

diff --git a/Documentation/devicetree/bindings/auxdisplay/generic,gpio-7s=
eg.yaml b/Documentation/devicetree/bindings/auxdisplay/generic,gpio-7seg.=
yaml
new file mode 100644
index 000000000000..238da2ede740
--- /dev/null
+++ b/Documentation/devicetree/bindings/auxdisplay/generic,gpio-7seg.yaml
@@ -0,0 +1,40 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/auxdisplay/generic,gpio-7seg.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: GPIO based LED segment display
+
+maintainers:
+  - Chris Packham <chris.packham@alliedtelesis.co.nz>
+
+properties:
+  compatible:
+    const: generic,gpio-7seg
+
+  segment-gpios:
+    description:
+      An array of GPIOs one per segment.
+    minItems: 7
+
+required:
+  - segment-gpios
+
+additionalProperties: false
+
+examples:
+  - |
+
+    #include <dt-bindings/gpio/gpio.h>
+
+    led-7seg {
+        compatible =3D "generic,gpio-7seg";
+        segment-gpios =3D <&gpio 0 GPIO_ACTIVE_LOW
+                         &gpio 1 GPIO_ACTIVE_LOW
+                         &gpio 2 GPIO_ACTIVE_LOW
+                         &gpio 3 GPIO_ACTIVE_LOW
+                         &gpio 4 GPIO_ACTIVE_LOW
+                         &gpio 5 GPIO_ACTIVE_LOW
+                         &gpio 6 GPIO_ACTIVE_LOW>;
+    };
--=20
2.43.2



Return-Path: <linux-kernel+bounces-91446-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 36DBB87119B
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 01:23:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DDB5E28290D
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 00:23:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68F0117EF;
	Tue,  5 Mar 2024 00:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bewilderbeest.net header.i=@bewilderbeest.net header.b="GAbZ7jfk"
Received: from thorn.bewilderbeest.net (thorn.bewilderbeest.net [71.19.156.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E6BD647;
	Tue,  5 Mar 2024 00:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=71.19.156.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709598179; cv=none; b=rkNC3xlGGypEThAjytuhqh6jjOmO1JsFJdj+BVpBOf5+yQ7zaKrdBYLyYRWSJanVHCMdk0UIKqetlfdFzd+Ok+JJeKAG6AHCKz+uSjsd73CesGmAs7zjA1khrjnQv0xJkeP0aCT+yTdf/sleCEi9HcDWCBYSWHtSPAX0BrhjIXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709598179; c=relaxed/simple;
	bh=PbPf8iVhZgCvtTgBgmwshmfHi11z8JKWC1tSyaO6mfo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o+6TLILOrBivmD/JS33M2z3WniInwvJnvteDKpNjwCzTmHhnlq9f3DNaCXu7RTeEeKsqfxudhFl42aq1TPSaWna3DHSLkAnXeZVvkjlvtDXZvKc21n0BKkoLgBDpZ1KLoqDVND2+MHfGa7yTGl1QLuRU261tT/uWGHNckbqvQDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bewilderbeest.net; spf=pass smtp.mailfrom=bewilderbeest.net; dkim=pass (1024-bit key) header.d=bewilderbeest.net header.i=@bewilderbeest.net header.b=GAbZ7jfk; arc=none smtp.client-ip=71.19.156.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bewilderbeest.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bewilderbeest.net
Received: from hatter.bewilderbeest.net (unknown [IPv6:2602:61:712b:6300::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: zev)
	by thorn.bewilderbeest.net (Postfix) with ESMTPSA id 69C4FA10;
	Mon,  4 Mar 2024 16:22:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bewilderbeest.net;
	s=thorn; t=1709598170;
	bh=Hp1IA638kbZr0ad+eDcqEs+oUJWCsqexDOh7fw0VWOQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GAbZ7jfkt8p4Wx1NZoOTD6k2ehRMXklDayuIPryAHzKjIITfW/5zV8RgIM9nd6hA/
	 i09uyDhkFAqN7mechLbiyyH0EqwsDOcd5hntFwxDAgUyKY1FeZENGGlz6uAkm3nFQp
	 f03Luow+FWEAEPgbr4TzKPmRvBlSNMtzacji3YaQ=
Date: Mon, 4 Mar 2024 16:22:49 -0800
From: Zev Weiss <zev@bewilderbeest.net>
To: baneric926@gmail.com
Cc: jdelvare@suse.com, linux@roeck-us.net, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	corbet@lwn.net, linux-hwmon@vger.kernel.org,
	devicetree@vger.kernel.org, kcfeng0@nuvoton.com, kwliu@nuvoton.com,
	openbmc@lists.ozlabs.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, DELPHINE_CHIU@wiwynn.com,
	naresh.solanki@9elements.com, billy_tsai@aspeedtech.com,
	Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v4 1/3] dt-bindings: hwmon: fan: Add fan binding to schema
Message-ID: <1cf69d3e-a8b4-49f6-ac4d-550b525e45e2@hatter.bewilderbeest.net>
References: <20240227005606.1107203-1-kcfeng0@nuvoton.com>
 <20240227005606.1107203-2-kcfeng0@nuvoton.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20240227005606.1107203-2-kcfeng0@nuvoton.com>

On Mon, Feb 26, 2024 at 04:56:04PM PST, baneric926@gmail.com wrote:
>From: Naresh Solanki <naresh.solanki@9elements.com>
>
>Add common fan properties bindings to a schema.
>
>Bindings for fan controllers can reference the common schema for the
>fan
>
>child nodes:
>
>  patternProperties:
>    "^fan@[0-2]":
>      type: object
>      $ref: fan-common.yaml#
>      unevaluatedProperties: false
>
>Reviewed-by: Rob Herring <robh@kernel.org>
>Signed-off-by: Naresh Solanki <naresh.solanki@9elements.com>
>Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
>Signed-off-by: Ban Feng <kcfeng0@nuvoton.com>
>---
> .../devicetree/bindings/hwmon/fan-common.yaml | 78 +++++++++++++++++++
> 1 file changed, 78 insertions(+)
> create mode 100644 Documentation/devicetree/bindings/hwmon/fan-common.yaml
>
>diff --git a/Documentation/devicetree/bindings/hwmon/fan-common.yaml b/Documentation/devicetree/bindings/hwmon/fan-common.yaml
>new file mode 100644
>index 000000000000..15c591c74545
>--- /dev/null
>+++ b/Documentation/devicetree/bindings/hwmon/fan-common.yaml
>@@ -0,0 +1,78 @@
>+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
>+%YAML 1.2
>+---
>+$id: http://devicetree.org/schemas/hwmon/fan-common.yaml#
>+$schema: http://devicetree.org/meta-schemas/core.yaml#
>+
>+title: Common Fan Properties
>+
>+maintainers:
>+  - Naresh Solanki <naresh.solanki@9elements.com>
>+  - Billy Tsai <billy_tsai@aspeedtech.com>
>+
>+properties:
>+  max-rpm:
>+    description:
>+      Max RPM supported by fan.
>+    $ref: /schemas/types.yaml#/definitions/uint32
>+    maximum: 100000
>+
>+  min-rpm:
>+    description:
>+      Min RPM supported by fan.
>+    $ref: /schemas/types.yaml#/definitions/uint32
>+    maximum: 1000

I can't say with certainty that it's not, but are we sure 1000 is low 
enough?  Looking at just what I've got on hand, an 80mm fan I have will 
run steadily at about 1500RPM, and I'd assume larger ones (e.g. 120mm) 
could potentially go significantly lower...

>+
>+  pulses-per-revolution:
>+    description:
>+      The number of pulse from fan sensor per revolution.
>+    $ref: /schemas/types.yaml#/definitions/uint32
>+    maximum: 4

Might we want 'default: 2' here?

>+
>+  tach-div:
>+    description:
>+      Divisor for the tach sampling clock, which determines the sensitivity of the tach pin.
>+    $ref: /schemas/types.yaml#/definitions/uint32
>+
>+  target-rpm:
>+    description:
>+      The default desired fan speed in RPM.
>+    $ref: /schemas/types.yaml#/definitions/uint32
>+
>+  fan-driving-mode:
>+    description:
>+      Select the driving mode of the fan.(DC, PWM and so on)

Nit: could use a space before the parenthetical.

>+    $ref: /schemas/types.yaml#/definitions/string
>+    enum: [ dc, pwm ]
>+
>+  pwms:
>+    description:
>+      PWM provider.
>+    maxItems: 1
>+
>+  "#cooling-cells":
>+    const: 2
>+
>+  cooling-levels:
>+    description:
>+      The control value which correspond to thermal cooling states.
>+    $ref: /schemas/types.yaml#/definitions/uint32-array
>+
>+  tach-ch:
>+    description:
>+      The tach channel used for the fan.
>+    $ref: /schemas/types.yaml#/definitions/uint8-array

Nit: s/channel/channels/ given that it's an array?

>+
>+  label:
>+    description:
>+      Optional fan label
>+
>+  fan-supply:
>+    description:
>+      Power supply for fan.
>+
>+  reg:
>+    maxItems: 1
>+
>+additionalProperties: true
>+
>-- 
>2.34.1
>
>


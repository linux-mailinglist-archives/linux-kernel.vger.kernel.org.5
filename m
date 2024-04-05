Return-Path: <linux-kernel+bounces-133191-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 31CFE89A026
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 16:48:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DCA9B287649
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 14:48:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E4A916F849;
	Fri,  5 Apr 2024 14:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rp1M/0Gy"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA27916F829;
	Fri,  5 Apr 2024 14:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712328513; cv=none; b=YrQwbDC7Sfte2PbVzA5A/SRNKqlOvTzh8MC5Vh8LmRnkYheobdizBxgen9213uIqlkDU4LZuVelZ5H258v8KpfIkkStQ1WWGbAafmq6n5ISvJumWLhpLCcNnFmFJsYfd0F0MSFcu2cM6eSb5Cs1S8c+myMezCh2GYyAUxW02ztE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712328513; c=relaxed/simple;
	bh=CDrhixP9RtkKB6cb9jrr6trJZJQjmdYcESp6DiI4FUo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WWrBSw+l3aAQQ3A/8hI9Gq3OEFBfNTySZL5UTSjdSIh3oMatElYfzSkMJ5JFI3wq4X/4D39wzjVs3Q47IJ/xPAfPxUH6o6WVX8G1uPq2Ea6clZMZ33xtZA2/5y6kd/KuzNsGQOsVeyhhxm5hkrBpfr4pvgHP57lt3vkrQESLPa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rp1M/0Gy; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2d80baf621eso24168631fa.1;
        Fri, 05 Apr 2024 07:48:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712328510; x=1712933310; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cFpu1whkh1nSy8kvvx+5UzrJKjw0DqYLany6m12D6u0=;
        b=Rp1M/0Gy+e35iEdcsJpov+7Q1sM7JpFK2bhZbzi/7AJgqLa1iRYjBmtTUUQpuvvamj
         Lno8Y7QOhS0cNqAke6+oggbbiUbLILwgozYC9d0mw00dUuWh0X5P2UdGY1cZbbFLvLSc
         BHyJtMRGVjG/5siJfDmKWFu9CplLWvt4S99kcgFSSZj3UuEq2ibCCnN5sQmZ8hc/UO92
         c7ahFDgwjXRwCxpiZFjyuqhzNBpZ0VG7b2FjfIHEVzLLl++blYpw1Z7meMu3NKhsjyD6
         500ce8adeJBeL/IjwKQFc5hBvtt/c10vGJazo5vHilhpRhB9x6w8uJS7WCUdpsBT81OV
         T0Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712328510; x=1712933310;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cFpu1whkh1nSy8kvvx+5UzrJKjw0DqYLany6m12D6u0=;
        b=Wx9BVlW2n3Ms7UYILwLnMIco7iiMZ6LlJcUF175LIdnTTY5pj00PMcgeqDKF+yZIjc
         biaqI2jq3RYxm2G0FA22PjFGQ0M5SsQXQi9uIGUpde6+i6uGnkCcBAOh5PO15iReyOaP
         4zv61MYdWpB/hwir32giNIr165gkSeZberGFpjRi/B4OMHXPzDmRVWFrCq1+Wk0RcT+z
         Vf1dIyxw6dfMUX+MZCqMiHMD37JQ3TKHAzPBJ3KOtRS6xDvCDrxjAxBuOoMqM7oiDEbN
         etpr2CQuBCo+OYQ0zVUBGVQ926l5T2jLMVJuIvLwmanXDKL2jzC8fvoTZIkbLytWFyl/
         J97w==
X-Forwarded-Encrypted: i=1; AJvYcCWoJuX6DhnGe5RbH/1eSm0JY/+86uVSWvTuMNwWNWFCsRzz4qW4eUQH9ckGXOX/a4lPwatvXt2xmdmfSCBoHCKXFyWM/6v7Pl7LooxS6X/pOcrjIycs1AOsbqbnSKGpG96stpbU+Aohxg==
X-Gm-Message-State: AOJu0Yy9APpDD7RHyEgv/DnjzTpFC2deQDMM3P4pfOYSlJmpgr0l/opd
	FUqakOC+YY6UyrKdcy5a58WN/MHJRv6fJhOlugJ0UKC4RGDAYWg88aC76mexO/JnCo+E5VQvpu/
	GOfesPffl9obH9Af97Bd+BNOTY9Y=
X-Google-Smtp-Source: AGHT+IGrg/lFBS2AMqv3GmFvVcFL6woTGN8IKlxDkSWiTeKdq9HfiE5kNbCsRxC8SlKmB2gQiyBs2NPA5UHos4n1BAQ=
X-Received: by 2002:a2e:a3d2:0:b0:2d6:c4ec:782 with SMTP id
 w18-20020a2ea3d2000000b002d6c4ec0782mr1273383lje.49.1712328509495; Fri, 05
 Apr 2024 07:48:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240404160649.967-1-bavishimithil@gmail.com> <78091796-fd0a-42dd-a4da-f7bed3025bf9@linaro.org>
In-Reply-To: <78091796-fd0a-42dd-a4da-f7bed3025bf9@linaro.org>
From: Mithil <bavishimithil@gmail.com>
Date: Fri, 5 Apr 2024 20:18:17 +0530
Message-ID: <CAGzNGRnuG_gLUrH1N57WvpKbpiNtFrcsG6nJcacQNJB_yMYNrA@mail.gmail.com>
Subject: Re: [PATCH v2] dt-bindings: omap-mcpdm: Convert to DT schema
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	alsa-devel@alsa-project.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

So sorry about the 2nd patch being sent as a new mail, here is a new
patch with the changes as suggested

> Please use subject prefixes matching the subsystem
Changed the patch name to match the folder history.

> Is it your full name?
Fixed it, my apologies.

> Filename like compatible.
Fixed.

> Please open existing bindings and look how it is done there.
Changed it, is it fine now?

> Same problem. Drop useless description but provide maxItems.
Removed descriptions for interrupts and hwmods.

> It does not look like you tested the bindings, at least after quick
> look. Please run `make dt_binding_check`
I did run it and it didnt produce any errors henceforth i submitted
the patch.

> Node names should be generic
Changed as said.

From c24a42724e870822d50ac6857ba9f32d0dce02ae Mon Sep 17 00:00:00 2001
From: Mithil Bavishi <bavishimithil@gmail.com>
Date: Mon, 1 Apr 2024 21:10:15 +0530
Subject: [PATCH v2] dt-bindings: omap-mcpdm: Convert to DT schema

Convert the OMAP4+ McPDM bindings to DT schema.

Signed-off-by: Mithil Bavishi <bavishimithil@gmail.com>
---
 .../devicetree/bindings/sound/omap-mcpdm.txt  | 30 ----------
 .../bindings/sound/ti,omap-mcpdm.yaml         | 59 +++++++++++++++++++
 2 files changed, 59 insertions(+), 30 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/sound/omap-mcpdm.txt
 create mode 100644 Documentation/devicetree/bindings/sound/ti,omap-mcpdm.y=
aml

diff --git a/Documentation/devicetree/bindings/sound/omap-mcpdm.txt
b/Documentation/devicetree/bindings/sound/omap-mcpdm.txt
deleted file mode 100644
index ff98a0cb5..000000000
--- a/Documentation/devicetree/bindings/sound/omap-mcpdm.txt
+++ /dev/null
@@ -1,30 +0,0 @@
-* Texas Instruments OMAP4+ McPDM
-
-Required properties:
-- compatible: "ti,omap4-mcpdm"
-- reg: Register location and size as an array:
-       <MPU access base address, size>,
-       <L3 interconnect address, size>;
-- interrupts: Interrupt number for McPDM
-- ti,hwmods: Name of the hwmod associated to the McPDM
-- clocks:  phandle for the pdmclk provider, likely <&twl6040>
-- clock-names: Must be "pdmclk"
-
-Example:
-
-mcpdm: mcpdm@40132000 {
-       compatible =3D "ti,omap4-mcpdm";
-       reg =3D <0x40132000 0x7f>, /* MPU private access */
-             <0x49032000 0x7f>; /* L3 Interconnect */
-       interrupts =3D <0 112 0x4>;
-       interrupt-parent =3D <&gic>;
-       ti,hwmods =3D "mcpdm";
-};
-
-In board DTS file the pdmclk needs to be added:
-
-&mcpdm {
-       clocks =3D <&twl6040>;
-       clock-names =3D "pdmclk";
-       status =3D "okay";
-};
diff --git a/Documentation/devicetree/bindings/sound/ti,omap-mcpdm.yaml
b/Documentation/devicetree/bindings/sound/ti,omap-mcpdm.yaml
new file mode 100644
index 000000000..4d5d37e98
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/ti,omap-mcpdm.yaml
@@ -0,0 +1,59 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/ti,omap-mcpdm.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: OMAP McPDM
+
+maintainers:
+  - Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
+
+description:
+  OMAP ALSA SoC DAI driver using McPDM port used by TWL6040
+
+properties:
+  compatible:
+    const: ti,omap4-mcpdm
+
+  reg:
+    description:
+      Register location and size as an array
+      <MPU access base address, size>,
+      <L3 interconnect address, size>;
+
+  interrupts:
+    maxItems: 1
+
+  ti,hwmods:
+    maxItems: 1
+
+  clocks:
+    description: phandle for the pdmclk provider, likely <&twl6040>
+
+  clock-names:
+    description: Must be "pdmclk"
+
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - ti,hwmods
+  - clocks
+  - clock-names
+
+additionalProperties: false
+
+examples:
+  - |
+    mcpdm@0 {
+      compatible =3D "ti,omap4-mcpdm";
+      reg =3D <0x40132000 0x7f>, /* MPU private access */
+            <0x49032000 0x7f>; /* L3 Interconnect */
+      interrupts =3D <0 112 0x4>;
+      interrupt-parent =3D <&gic>;
+      ti,hwmods =3D "mcpdm";
+      clocks =3D <&twl6040>;
+      clock-names =3D "pdmclk";
+    };
--
2.34.1

Best regards,
Mithil



On Fri, Apr 5, 2024 at 12:28=E2=80=AFPM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 04/04/2024 18:06, Mighty wrote:
> > From: Mithil Bavishi <bavishimithil@gmail.com>
> >
> > Convert the OMAP4+ McPDM bindings to DT schema.
> >
> > Signed-off-by: Mighty <bavishimithil@gmail.com>
>
> This does not match SoB. Can you respond to comments you receive?
>
> Subject: nothing improved.
>
> Rest... also did not improve. so you ignored entire feedback?
>
> This is a friendly reminder during the review process.
>
> It seems my or other reviewer's previous comments were not fully
> addressed. Maybe the feedback got lost between the quotes, maybe you
> just forgot to apply it. Please go back to the previous discussion and
> either implement all requested changes or keep discussing them.
>
> Thank you.
>
> Best regards,
> Krzysztof
>


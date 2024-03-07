Return-Path: <linux-kernel+bounces-95072-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E35F8748F0
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 08:42:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 81CD31C21993
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 07:42:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68B7E6311F;
	Thu,  7 Mar 2024 07:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LTzJOf8s"
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EA8F63105;
	Thu,  7 Mar 2024 07:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709797324; cv=none; b=RuMrO8f1VVvmMhP63acMtAvMX3K/oFT1Imk37e7im+tQozp60VAPKf/kAXLrGDID4OJ1iSY18LFgDkqNuLEBLi/6+K5dI0Hii5LY4pi23Rm6bOv0Dw9efPgGaW/nkS9m1L0ec3tqWZTGAHn/vTcur4rcOSWSwThFU6tM0wn0rEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709797324; c=relaxed/simple;
	bh=8zkoTHrhHGCWjkGdamTPQWEi1mXkY2fTJs3Wy3G48yU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OisakHqxR1FZP774z0dCoJ3O9Swf7jJcw2jU9LpptM9MM6A77mXg4n1SKSxNOlGu3WcN/MtLw2/f07HG+f1FBBzPI/fI2SdGjHApDsMZ+VHy/tGZZDX1cg5+fyNmaxR4Sc8G+Dd0ibsWRWJalBfcG9kbjxilpVSo9j92PVZhAbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LTzJOf8s; arc=none smtp.client-ip=209.85.166.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-7c872002187so21154839f.2;
        Wed, 06 Mar 2024 23:42:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709797322; x=1710402122; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B5+2SLHKHSCrTFwVgpGe2p6pLgJMincwPJKbEHmHkEw=;
        b=LTzJOf8sQDv63ZaORfJfmgipNJpyCs4RcebQDY6KFnky51sDvrHSeNI327ZAQC/0OT
         RTh4gqQaAReSsSLCXnFEHJ5cg7XhFBpLfHb45GCC6/6H4tsc7k2/oFDbSKingCiyEM9P
         5j6Oo8SxB83I+kijOK7JjmBB7ICRfG3E2pBBwGZ+ti6ZXvUmT7oO3wjv7kStotDnE58T
         gcvi0gx5kHI0V5XSbKgmZo/aelSJ1msVcyCF6XnCSU/Spp6Bd5RvV/2xvTU2mujat1a5
         Ego13ka47YvpJ0Ea8Li9yT4602+wUnfgLF3edGfUuAvZJ6XWXnsfVk8u+Unm253qVaSa
         dylQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709797322; x=1710402122;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B5+2SLHKHSCrTFwVgpGe2p6pLgJMincwPJKbEHmHkEw=;
        b=MwIeAb7KLL1uMyJCwU/k3yHHaF4CBk8DA0Q4gObbYc0Seh/v9L670/xv0OJN5JW7J+
         X0T+XJPZFIvWQ8aqhCHriV3xMguppU3JK549OPlaOOeRjQ5e9hBDuDcUbCjcqlH+G732
         GJzaLLtPMEQE4tzjxEAVKori5emAck6SH5w0sf5BFlP4DlAETaVM/tv1yIv5WWqVdulA
         yvgGUzeza7FZ/Bm0ufuu6bVCy/tDu+FBa/2gNyX47paFHHZAvj0Kob16W+8Ce6uLtOjc
         7DNTJNLFL9veUDBsfvtZPCOCZI/ytK4YR3ME8B3DngJm1ohRa5qiwnqgoMjtWGxQT4Tr
         s04g==
X-Forwarded-Encrypted: i=1; AJvYcCUchEW+Xqq2iXJ/iBtXfb5Vecf/BZ/i7Ej7d4mxN8jvmqryEnqeMUc/pnsLXOYiutwiyKI7liJQ11UrFc4WI2AyF8/ESFTgqDsDzY5iK5rSdSfQyKdt2TSc9/AKgN364HO5Qeb0goIhi90zLBtl36KjR3rpfhWiqMH+/AIeaQVYMlU5Fb0fueSGJ1iCuCOz2NVCgPGZKFhpP8Lz9joRBlr2
X-Gm-Message-State: AOJu0YztYxw2acHSGFSYi8GV1kLuHEyfU+AR5Qtx/6jzjCliv1T4GKxU
	ss1ZRZIixoKhv/4WhYaqdHGouFelMV19qBt7+Uqzf78oYFg4eF9++qvVzcdsOKv1f11y7WIhUE/
	mSzPTMj7Tdp8nShhBBIjhrGCKg2I=
X-Google-Smtp-Source: AGHT+IEeBR2EPDEPGv0wdG0jF+0ybHRLIfCHqc8xs55MboJMGn1dQvKiGrjW/JtCbl+vnDXrSMS9zxUAZJEr7pMVv/c=
X-Received: by 2002:a6b:dc0d:0:b0:7c8:63dc:e9cd with SMTP id
 s13-20020a6bdc0d000000b007c863dce9cdmr9211980ioc.19.1709797322307; Wed, 06
 Mar 2024 23:42:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240227005606.1107203-1-kcfeng0@nuvoton.com> <20240227005606.1107203-2-kcfeng0@nuvoton.com>
 <1cf69d3e-a8b4-49f6-ac4d-550b525e45e2@hatter.bewilderbeest.net>
In-Reply-To: <1cf69d3e-a8b4-49f6-ac4d-550b525e45e2@hatter.bewilderbeest.net>
From: Ban Feng <baneric926@gmail.com>
Date: Thu, 7 Mar 2024 15:41:51 +0800
Message-ID: <CALz278b_bbFB77TsVZLMKaK7kwqjjS1PzBbsB==r08R1Zkju8A@mail.gmail.com>
Subject: Re: [PATCH v4 1/3] dt-bindings: hwmon: fan: Add fan binding to schema
To: Zev Weiss <zev@bewilderbeest.net>
Cc: jdelvare@suse.com, linux@roeck-us.net, robh+dt@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, corbet@lwn.net, 
	linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org, kcfeng0@nuvoton.com, 
	kwliu@nuvoton.com, openbmc@lists.ozlabs.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, DELPHINE_CHIU@wiwynn.com, 
	naresh.solanki@9elements.com, billy_tsai@aspeedtech.com, 
	Rob Herring <robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Zev,

This patch was suggested by reviewer and I cherry-pick from below link:
https://patchwork.kernel.org/project/linux-hwmon/patch/20240221104025.13062=
27-2-billy_tsai@aspeedtech.com/

Because I don't know the rule about the patch with cherry-pick, maybe
we should discuss it there?

Thanks,
Ban

On Tue, Mar 5, 2024 at 8:22=E2=80=AFAM Zev Weiss <zev@bewilderbeest.net> wr=
ote:
>
> On Mon, Feb 26, 2024 at 04:56:04PM PST, baneric926@gmail.com wrote:
> >From: Naresh Solanki <naresh.solanki@9elements.com>
> >
> >Add common fan properties bindings to a schema.
> >
> >Bindings for fan controllers can reference the common schema for the
> >fan
> >
> >child nodes:
> >
> >  patternProperties:
> >    "^fan@[0-2]":
> >      type: object
> >      $ref: fan-common.yaml#
> >      unevaluatedProperties: false
> >
> >Reviewed-by: Rob Herring <robh@kernel.org>
> >Signed-off-by: Naresh Solanki <naresh.solanki@9elements.com>
> >Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
> >Signed-off-by: Ban Feng <kcfeng0@nuvoton.com>
> >---
> > .../devicetree/bindings/hwmon/fan-common.yaml | 78 +++++++++++++++++++
> > 1 file changed, 78 insertions(+)
> > create mode 100644 Documentation/devicetree/bindings/hwmon/fan-common.y=
aml
> >
> >diff --git a/Documentation/devicetree/bindings/hwmon/fan-common.yaml b/D=
ocumentation/devicetree/bindings/hwmon/fan-common.yaml
> >new file mode 100644
> >index 000000000000..15c591c74545
> >--- /dev/null
> >+++ b/Documentation/devicetree/bindings/hwmon/fan-common.yaml
> >@@ -0,0 +1,78 @@
> >+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> >+%YAML 1.2
> >+---
> >+$id: http://devicetree.org/schemas/hwmon/fan-common.yaml#
> >+$schema: http://devicetree.org/meta-schemas/core.yaml#
> >+
> >+title: Common Fan Properties
> >+
> >+maintainers:
> >+  - Naresh Solanki <naresh.solanki@9elements.com>
> >+  - Billy Tsai <billy_tsai@aspeedtech.com>
> >+
> >+properties:
> >+  max-rpm:
> >+    description:
> >+      Max RPM supported by fan.
> >+    $ref: /schemas/types.yaml#/definitions/uint32
> >+    maximum: 100000
> >+
> >+  min-rpm:
> >+    description:
> >+      Min RPM supported by fan.
> >+    $ref: /schemas/types.yaml#/definitions/uint32
> >+    maximum: 1000
>
> I can't say with certainty that it's not, but are we sure 1000 is low
> enough?  Looking at just what I've got on hand, an 80mm fan I have will
> run steadily at about 1500RPM, and I'd assume larger ones (e.g. 120mm)
> could potentially go significantly lower...
>
> >+
> >+  pulses-per-revolution:
> >+    description:
> >+      The number of pulse from fan sensor per revolution.
> >+    $ref: /schemas/types.yaml#/definitions/uint32
> >+    maximum: 4
>
> Might we want 'default: 2' here?
>
> >+
> >+  tach-div:
> >+    description:
> >+      Divisor for the tach sampling clock, which determines the sensiti=
vity of the tach pin.
> >+    $ref: /schemas/types.yaml#/definitions/uint32
> >+
> >+  target-rpm:
> >+    description:
> >+      The default desired fan speed in RPM.
> >+    $ref: /schemas/types.yaml#/definitions/uint32
> >+
> >+  fan-driving-mode:
> >+    description:
> >+      Select the driving mode of the fan.(DC, PWM and so on)
>
> Nit: could use a space before the parenthetical.
>
> >+    $ref: /schemas/types.yaml#/definitions/string
> >+    enum: [ dc, pwm ]
> >+
> >+  pwms:
> >+    description:
> >+      PWM provider.
> >+    maxItems: 1
> >+
> >+  "#cooling-cells":
> >+    const: 2
> >+
> >+  cooling-levels:
> >+    description:
> >+      The control value which correspond to thermal cooling states.
> >+    $ref: /schemas/types.yaml#/definitions/uint32-array
> >+
> >+  tach-ch:
> >+    description:
> >+      The tach channel used for the fan.
> >+    $ref: /schemas/types.yaml#/definitions/uint8-array
>
> Nit: s/channel/channels/ given that it's an array?
>
> >+
> >+  label:
> >+    description:
> >+      Optional fan label
> >+
> >+  fan-supply:
> >+    description:
> >+      Power supply for fan.
> >+
> >+  reg:
> >+    maxItems: 1
> >+
> >+additionalProperties: true
> >+
> >--
> >2.34.1
> >
> >


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3C1E7A0F3D
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 22:47:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229905AbjINUra (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 16:47:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbjINUr3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 16:47:29 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D5FC2120;
        Thu, 14 Sep 2023 13:47:25 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id 41be03b00d2f7-53482b44007so1047080a12.2;
        Thu, 14 Sep 2023 13:47:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694724445; x=1695329245; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V+vcKKBW7m4dimFQCqOQ/FSEh/1OFmvKpug97OFECsw=;
        b=NBs3c42Uj7z2Bln8/oHxtFGfuzfj6PFjetfkYnywUw4Arf5a7DjULPuTbkMJMUbcmG
         EOJhssZR9XpoiFimYT+rCrG82hgsXjU/ZrVuR55PGQLiV9Voa/QsyJROp3BaYg2lOtMj
         tqTX/gnv4kKoD0nJ9zHLiGbNAhWSnZUB4TpUDUKx+zspcfw4KgvygvKKsD57snJ40rVw
         2X7xaeIy7nnxH/9n/1NXQ4tUgGlRTtJ4IgNv9OLINlq1TD73d3AdtYe9KF1OT/csKIT1
         Bzsk63FWdZYgjrTCkmL6aK69vA9vFj46Ep2nyD084hw8hOfpZnu5kuEBsv6HAIJUmVHu
         6vpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694724445; x=1695329245;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V+vcKKBW7m4dimFQCqOQ/FSEh/1OFmvKpug97OFECsw=;
        b=c7cuHRAWUHjKnkHup8iiyPdDPSwPEpw2NhkbZT6wkqiBfqRJ2gk7ze10Diqk0WN/4p
         zscuyzU4MYFqOTNxuDU6Rw2tGOHcV7A15o2GCffFA5Yiggo3UL8+L6NG4pFoawcx7CWR
         7HvB5jWzRra+RJzB4j2sshpXHJYpQjp0FP9h8R0PyQfj8EMYxivGop3OoZ/MecUJ0UPb
         9p5IUm03B+4ZuB4cr60mO/tZmiizvpnPl0reuszN4yBU8BXeETgNU/Llh/WvJYCWtiXo
         0d4CR/mjHixDrCQ9J0VfgAlYBiBg/jjyu63RzG9XNXjM7/CEceuq+990AtjTfOLsUi8B
         C8wQ==
X-Gm-Message-State: AOJu0YzUJbHOF2V+lp9jWm2ckDa8xfzup5xh6p2PlwiAM6H9aKVXKf9d
        sF4Bjzc/nbJqEQZ9xN+1ZYoKMQQxFDXuwdetulf4gMui+e0=
X-Google-Smtp-Source: AGHT+IEYq3Ge99GvmTYyrwRhMv5Siqo9GkcGQyZgtksJ6lYipoYwXo09EZ4kCTqZIkp1e/A/33VpAXMFKiv3xnGL9tY=
X-Received: by 2002:a17:90b:709:b0:274:6135:8363 with SMTP id
 s9-20020a17090b070900b0027461358363mr3424523pjz.33.1694724444919; Thu, 14 Sep
 2023 13:47:24 -0700 (PDT)
MIME-Version: 1.0
References: <20230913211449.668796-1-jcmvbkbc@gmail.com> <20230913211449.668796-4-jcmvbkbc@gmail.com>
 <196fb9ac-53b7-51a6-6ce4-9f980215fde4@linaro.org>
In-Reply-To: <196fb9ac-53b7-51a6-6ce4-9f980215fde4@linaro.org>
From:   Max Filippov <jcmvbkbc@gmail.com>
Date:   Thu, 14 Sep 2023 13:47:13 -0700
Message-ID: <CAMo8Bf+u3hkk8zW6EQUtQcAC5t-hUJ5+HoE8JDskBj4KyFK7xA@mail.gmail.com>
Subject: Re: [PATCH 3/4] dt-bindings: serial: document esp32s3-acm bindings
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        devicetree@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 13, 2023 at 10:57=E2=80=AFPM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 13/09/2023 23:14, Max Filippov wrote:
> > Add documentation for the ESP32S3 ACM controller.
>
> A nit, subject: drop second/last, redundant "bindings". The
> "dt-bindings" prefix is already stating that these are bindings.

Ok.

> > Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
> > ---
> >  .../bindings/serial/esp,esp32-acm.yaml        | 40 +++++++++++++++++++
> >  1 file changed, 40 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/serial/esp,esp32-=
acm.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/serial/esp,esp32-acm.yam=
l b/Documentation/devicetree/bindings/serial/esp,esp32-acm.yaml
> > new file mode 100644
> > index 000000000000..dafbae38aa64
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/serial/esp,esp32-acm.yaml
> > @@ -0,0 +1,40 @@
> > +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> > +
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/serial/esp,esp32-acm.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: ESP32S3 ACM controller
> > +
> > +maintainers:
> > +  - Max Filippov <jcmvbkbc@gmail.com>
> > +
> > +description: |
>
> Do not need '|' unless you need to preserve formatting.

Ok.

> > +  ESP32S3 ACM controller is a communication device found in the ESP32S=
3
>
> What is "ACM"?

It's an 'Abstract Control Model' as in USB CDC-ACM: 'Communication Device C=
lass
- Abstract Control Model'.

> Why is this in serial? Only serial controllers are in serial.

Because it's a serial communication device. The SoC TRM calls this peripher=
al
'USB Serial', but the USB part is fixed and is not controllable on the SoC =
side.
When you plug it into a host USB socket you get a serial port called ttyACM=
 on
the host.

> The description is very vague, way too vague.

Is the following better?

  Fixed function USB CDC-ACM device controller of the Espressif ESP32S3 SoC=
.

> > +  SoC that is connected to one of its USB controllers.
>
> Same comments as previous patch.
>
> > +
> > +properties:
> > +  compatible:
> > +    const: esp,esp32s3-acm
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  interrupts:
> > +    maxItems: 1
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - interrupts
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    acm@60038000 {
> > +            compatible =3D "esp,esp32s3-acm";
>
> Use 4 spaces for example indentation.

Ok.

> > +            reg =3D <0x60038000 0x1000>;
> > +            interrupts =3D <96 3 0>;
>
> Same comments as previous patch.

These are not IRQ flags. In any case the contents of the IRQ
specification cells is not relevant here, right?

--=20
Thanks.
-- Max

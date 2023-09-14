Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E06E7A0EA1
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 22:00:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229874AbjINUAW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 16:00:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbjINUAW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 16:00:22 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FBBC26B8;
        Thu, 14 Sep 2023 13:00:18 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-69042d398b1so80494b3a.0;
        Thu, 14 Sep 2023 13:00:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694721617; x=1695326417; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B23YuAv6dhYvSN5C36lVW/kvrfHC6KB7exZefOVxwtg=;
        b=o0dQYoQeVLZFjIDy3B8RMR6rtTIW6AbN60YpA1T+ChDCVh7+NkbuC6PSa10Km+u/L0
         Eks8uuUxiKO5hJBiwZHDuePukkSEjHDxn+OGg/9F7Wr1uY4SdTPsDmZwGQVyMiwfbdE8
         2PPpoPjvvJQME2umWSakEZjDbnsy2tWHpiTQW+BPcK1Y3FlZHgKk6ypH4l86L68q42Tb
         W1laKe35QVTnON3AJU5gG0HpQCBGndxKXo3lvRd/UHuz+8tGI1i5Buhjwaq6aKh2v6FC
         YmmuhL0WUV+fRvfIwcyKfA28E3k70XEDOvT0VgfsOrYemUPSaqsMQ6I+5Egzd3wnG1di
         aozw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694721617; x=1695326417;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B23YuAv6dhYvSN5C36lVW/kvrfHC6KB7exZefOVxwtg=;
        b=s2Iv0is6xSf/aC34sug9mWGPKHFi2OwOkJrPS/Zps8epkR75slJ3Ryeqi/5XArfUbg
         GXmBDIJS3g7qV9uTlC76FMb0zeXq6rlQV39cMP7EOsF1BJ9f+HrD3kw7hd1foOBve68d
         tWxD2phwphisGK3oHDVFKtF/zL6Cs4AtAMfXhG9nqKrTPGtYYZgXPrOXpM7ip9lf54+o
         a3v8D8HqRDVdHPXhDqZ4y7tuI4+ESyk+g6syPCGgh+YFCcco1gV/Usz0stLS5u3yy3qO
         1QEl/jOLdOoLFJkGS017FkiojqGRZWOvKmLcer3LULVTFV+CHRJgk2tGz+FhPd54Z/IX
         2wyQ==
X-Gm-Message-State: AOJu0Yzpu/Wl4sghbXhzNqIIYA/AliXEc4LwnkMabnQbuDpoNweQ5N6b
        bkLuZiDB7iuygv4otmRz9gyt+6tW6bAh7kCHyBc=
X-Google-Smtp-Source: AGHT+IEGZcYWfFuWw2dQfPhJ0OBpPROolNoIo/obh/jVO4iBsP9rJYT+1Flp4m7jWHC+Q8uaRg2HlWmd1gmt2gpXj3A=
X-Received: by 2002:a05:6a00:1d10:b0:690:15c7:60bf with SMTP id
 a16-20020a056a001d1000b0069015c760bfmr5463233pfx.20.1694721617453; Thu, 14
 Sep 2023 13:00:17 -0700 (PDT)
MIME-Version: 1.0
References: <20230913211449.668796-1-jcmvbkbc@gmail.com> <20230913211449.668796-2-jcmvbkbc@gmail.com>
 <465dc390-a5ff-547a-2bd3-54b29e1b6c43@linaro.org>
In-Reply-To: <465dc390-a5ff-547a-2bd3-54b29e1b6c43@linaro.org>
From:   Max Filippov <jcmvbkbc@gmail.com>
Date:   Thu, 14 Sep 2023 13:00:06 -0700
Message-ID: <CAMo8Bf+5EOjOrusD7bHanxcrQm445b=wOq4xDGXVeij0tYY3XA@mail.gmail.com>
Subject: Re: [PATCH 1/4] dt-bindings: serial: document esp32-uart bindings
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

On Wed, Sep 13, 2023 at 10:54=E2=80=AFPM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 13/09/2023 23:14, Max Filippov wrote:
> > Add documentation for the ESP32xx UART controllers.
> >
> > Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
> > ---
> >  .../bindings/serial/esp,esp32-uart.yaml       | 48 +++++++++++++++++++
> >  1 file changed, 48 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/serial/esp,esp32-=
uart.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/serial/esp,esp32-uart.ya=
ml b/Documentation/devicetree/bindings/serial/esp,esp32-uart.yaml
> > new file mode 100644
> > index 000000000000..8b45ef808107
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/serial/esp,esp32-uart.yaml
> > @@ -0,0 +1,48 @@
> > +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> > +
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/serial/esp,esp32-uart.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: ESP32 UART controller
> > +
> > +maintainers:
> > +  - Max Filippov <jcmvbkbc@gmail.com>
> > +
> > +description: |
>
> Do not need '|' unless you need to preserve formatting.

Ok.

> > +  ESP32 UART controller is a part of ESP32 SoC series.
> > +
> > +properties:
> > +  compatible:
> > +    oneOf:
>
> That's just enum. Your descriptions are useless - tell nothing - so drop
> them.

Ok.

> > +      - description: UART controller for the ESP32 SoC
> > +        const: esp,esp32-uart
>
> Looks quite generic, so just to be sure? This is not a family name,
> right? Neither family names nor wildcards are allowed.

ESP32 is the official name of a specific SoC. More recent SoC models of
that family are named ESP32-S2 and ESP32-S3, sometimes they are
collectively referred to as the 'ESP32 series'. In this binding 'esp32' is =
used
for the ESP32 SoC and 'esp32s3' is used for the ESP32-S3.

> > +      - description: UART controller for the ESP32S3 SoC
> > +        const: esp,esp32s3-uart
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  interrupts:
> > +    maxItems: 1
> > +
> > +  clocks:
> > +    maxItems: 1
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - interrupts
> > +  - clocks
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    serial0: serial@60000000 {
>
> Drop unused label.

Ok.

> > +            compatible =3D "esp,esp32s3-uart";
>
> Use 4 spaces for example indentation.

Ok.

> > +            reg =3D <0x60000000 0x80>;
> > +            interrupts =3D <27 1 0>;
>
> Use proper define for IRQ flags.

These are not IRQ flags. 1 and 0 are the routing parts
of the IRQ specification.

--=20
Thanks.
-- Max

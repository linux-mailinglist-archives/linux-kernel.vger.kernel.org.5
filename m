Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 516667A02AB
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 13:32:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233919AbjINLcG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 07:32:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229992AbjINLcF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 07:32:05 -0400
Received: from mail-vk1-xa30.google.com (mail-vk1-xa30.google.com [IPv6:2607:f8b0:4864:20::a30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D5DF1FC4;
        Thu, 14 Sep 2023 04:32:01 -0700 (PDT)
Received: by mail-vk1-xa30.google.com with SMTP id 71dfb90a1353d-490e78ae83bso423592e0c.0;
        Thu, 14 Sep 2023 04:32:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694691120; x=1695295920; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NsttBv8HKlL9XAEyJGK+M8jti8yQoZtbn/MGaMyCekw=;
        b=TdJU3jalD3qyOayvf/YLrkImlzps/ADP/hszeQenkAEC0mReTVzThsXBWkRk5gnrgR
         pDIbtrtel+j7pJsmpYGAEdv2N6Igy6+wuiP5wDuUyxVuCBA2ZP9k4XIcYNZStxJd8NGR
         46uhk7WRrpVOGkwhq72v6UXU80mAo6/4MOi7ySdENRwURcc7jvVYgoi493KUANFDAR1B
         CjI4ma8waMZfcEoQno6XIDReRvaNCMCpgjY4kx1MmJw0mSEa2FiLyMHuKpf1z3g8HAtN
         ktdGzX5+w/KjaR3GlIM0mJvNJpGvqNKJQGUzbHDSIjG1mP0B1dm0L58T+4fma+43f1Zq
         S98w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694691120; x=1695295920;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NsttBv8HKlL9XAEyJGK+M8jti8yQoZtbn/MGaMyCekw=;
        b=cSmaHbOP4VRRFdUcgykYY0aK54IAwB/3Nie2JQ2Ecrt+F6fcnKmiMSALYqx35VF0+U
         ohVM1HkOmiOHmgDpunk9+5H2OQb2CHMeDtNrQwbnx2fW7zESFJEBnFrX8KJYtPRSG9Sx
         Dooev2C6c26qKdLIQqI2NReAVQTfRXf6sa7UkidsnbmS6HHfGKjGfTeqmKSVO+Z9fGL5
         PzX8ROwJyH79p80RRRPzpyO30Cs5HwDhl+S4SD+LjEpCvmVwljaSszS3K3tBePDwGMY+
         DPJYk45ZN+tldM2hw9aN6iu+AEM5QgXnXhLamCB/FRyfw1LpsTa9lrzARG/ZMk9PqW3l
         Qlyg==
X-Gm-Message-State: AOJu0YyUrUozqAQCR6AH7ukN+vlcSXR9lOT4DOH1btUeTppE4XNt3PW9
        6Pl10GsJWV5eyHQA+SvbSXxUneR19JQNmg0jmnc=
X-Google-Smtp-Source: AGHT+IESWsHYz9G4ymkwNCpggjjEBLUHskGcC8fJ9HmW6kkuQ5lRxsApyTLayB9kCoZHd0z9GkE5FQCSjpKzSZ+9bS0=
X-Received: by 2002:a1f:dd82:0:b0:48f:c07e:433a with SMTP id
 u124-20020a1fdd82000000b0048fc07e433amr5030783vkg.11.1694691120138; Thu, 14
 Sep 2023 04:32:00 -0700 (PDT)
MIME-Version: 1.0
References: <20230913151606.69494-1-romain.perier@gmail.com>
 <20230913151606.69494-3-romain.perier@gmail.com> <20230913-depress-bootlace-6b88bfd83966@spud>
 <CABgxDoK2T3xkKYDVeqRuDXMHfVEJcRkkBOBBkMJ5=XUv9Y5MsQ@mail.gmail.com> <20230914-coagulant-unbroken-2461d32274a1@wendy>
In-Reply-To: <20230914-coagulant-unbroken-2461d32274a1@wendy>
From:   Romain Perier <romain.perier@gmail.com>
Date:   Thu, 14 Sep 2023 13:31:49 +0200
Message-ID: <CABgxDo+SddJkBUHgQ+s5x2g_j-7M7DK24_=pLO8=fCksX5jwbw@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] dt-bindings: rtc: Add Mstar SSD202D RTC
To:     Conor Dooley <conor.dooley@microchip.com>
Cc:     Conor Dooley <conor@kernel.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Daniel Palmer <daniel@0x0f.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-rtc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le jeu. 14 sept. 2023 =C3=A0 10:28, Conor Dooley
<conor.dooley@microchip.com> a =C3=A9crit :
>
> On Thu, Sep 14, 2023 at 09:08:52AM +0200, Romain Perier wrote:
> > Le mer. 13 sept. 2023 =C3=A0 20:30, Conor Dooley <conor@kernel.org> a =
=C3=A9crit :
> > >
> > > On Wed, Sep 13, 2023 at 05:16:05PM +0200, Romain Perier wrote:
> > > > Add YAML bindings for Mstar SSD202D RTC.
> > > >
> > > > Signed-off-by: Romain Perier <romain.perier@gmail.com>
> > > > ---
> > > >  .../bindings/rtc/mstar,ssd202d-rtc.yaml       | 35 +++++++++++++++=
++++
> > > >  1 file changed, 35 insertions(+)
> > > >  create mode 100644 Documentation/devicetree/bindings/rtc/mstar,ssd=
202d-rtc.yaml
> > > >
> > > > diff --git a/Documentation/devicetree/bindings/rtc/mstar,ssd202d-rt=
c.yaml b/Documentation/devicetree/bindings/rtc/mstar,ssd202d-rtc.yaml
> > > > new file mode 100644
> > > > index 000000000000..4c1f22ef5a2c
> > > > --- /dev/null
> > > > +++ b/Documentation/devicetree/bindings/rtc/mstar,ssd202d-rtc.yaml
> > > > @@ -0,0 +1,35 @@
> > > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > > +%YAML 1.2
> > > > +---
> > > > +$id: http://devicetree.org/schemas/rtc/mstar,ssd202d-rtc.yaml#
> > > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > > +
> > > > +title: Mstar SSD202D Real Time Clock
> > > > +
> > > > +maintainers:
> > > > +  - Daniel Palmer <daniel@0x0f.com>
> > > > +  - Romain Perier <romain.perier@gmail.com>
> > > > +
> > > > +allOf:
> > > > +  - $ref: rtc.yaml#
> > > > +
> > > > +properties:
> > > > +  compatible:
> > > > +    enum:
> > > > +      - mstar,ssd202d-rtc
> > > > +  reg:
> > > > +    maxItems: 1
> > > > +
> > > > +required:
> > > > +  - compatible
> > > > +  - reg
> > >
> >
> > Hi,
> >
> > > So, this seems fine to me in isolation, but isn't this now the sort o=
f
> > > thing that can be documented in trivial-rtc.yaml?
> > > Its only got compatible & reg, which seems to fit the bill for that.
> > >
> >
> > With the current state, it might make sense. However, currently, the
> > RTC hw block is mostly
> > reverse-engineered, the driver is not complete yet, things like
> > external irq or wakeup irq might arrive later (once we know how it is
> > wired up and used).
> > So the content of the dt-bindings might change and differ from a
> > simple "compatible & reg" requirement.
>
> It's always possible to move from that to a fully fledged binding at a
> later date. re: interrupts, trivial-rtc permits a single interrupt, so
> it'd still be suitable if the device only has one.

I agree, good point. Yes, we can make the change later, sure. I will
fix it in the next patch series.

Thanks,
Romain

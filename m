Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBB517E57F9
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 14:27:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344686AbjKHN1y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 08:27:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344673AbjKHN1v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 08:27:51 -0500
Received: from mail-vs1-xe35.google.com (mail-vs1-xe35.google.com [IPv6:2607:f8b0:4864:20::e35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B94F1BFC;
        Wed,  8 Nov 2023 05:27:49 -0800 (PST)
Received: by mail-vs1-xe35.google.com with SMTP id ada2fe7eead31-45ef8c21e8aso1572649137.1;
        Wed, 08 Nov 2023 05:27:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699450068; x=1700054868; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2aO1ctuOAgiwaAMkZHyV4dmKWIc2NuQImrqw1sRY6dY=;
        b=PKKwar93s6vd61HowxYoZfR1gmNzmuc1bVoglgqUDA90OK0MzwAM5rT1p3HwhHP9my
         WaNMK6kERrJ90VDzVjI7iritgUsiQ3R2nkCOhLqgYQ53uCuEm6f/4BJT6ts5YldUUZla
         KPHFTuIQtYAov1SY/5OPW7MtDxrpRDoyGxJqNh/WP1XxqfSc+OcwjpxxGbcYgIh4aePK
         nv03hSO8QCGVkaAHapF4OgXKy13JYwbpISjm9sGUCHcKxB8uAxd0iZhOgRUJcmhIhQ4r
         Mu10eLNP3ORmhMNditag0HjUQ/YtT18LWiw+md01ktPrtpeZES7p4gVk7EwRUjVR+74j
         JcBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699450068; x=1700054868;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2aO1ctuOAgiwaAMkZHyV4dmKWIc2NuQImrqw1sRY6dY=;
        b=wk7OXFeywWzCNgptmwVlGishpNQydjOzDll8/RpspftBbLvjzhZDUsitaEQkxpeM5l
         T3rFeWrsBO80cigysHzA1inZ9MZ7NuK7k8kAlqDPh7clc3zAYoTWNfG8K3rCd42XeXxL
         CNWGqAVIY9wzbvNfqDw+PXYC+n/6VkKzogy5UYA1pNYoE6pYOT4R72gyUOLTmGHXJeMG
         NObctOZPPJQspJAlyiUnFP0oHoXsqDsbjagy0am+zjeAb+g+egbPPPrHzoW9TQxgQ227
         AGXUwir1oEukAatN15MgGlVjchs2G72poebGWOGA2NWXvkrkzkUkPLv5uuckOA32Kbty
         +aAA==
X-Gm-Message-State: AOJu0YyJLf8hmZhx4arBVlM/LHS30P+UyZlJj/DXarupfBQ2UiCSmXNY
        U49jV5pCYehegEUXTwmcbuzYN7M/9Q6NrhV9b/4=
X-Google-Smtp-Source: AGHT+IECittYtjWU1L+BZtshd86+NTZrnIQlq2JL7WzMlisn5WjMLgavfIgIQtmfP45xuDoRkfOSP47k4ChEuBNw2Qg=
X-Received: by 2002:a67:ef43:0:b0:45f:18:b2d6 with SMTP id k3-20020a67ef43000000b0045f0018b2d6mr1588218vsr.5.1699450068584;
 Wed, 08 Nov 2023 05:27:48 -0800 (PST)
MIME-Version: 1.0
References: <20230913151606.69494-1-romain.perier@gmail.com>
 <20230913151606.69494-3-romain.perier@gmail.com> <20230913-depress-bootlace-6b88bfd83966@spud>
 <CABgxDoK2T3xkKYDVeqRuDXMHfVEJcRkkBOBBkMJ5=XUv9Y5MsQ@mail.gmail.com> <20230914-coagulant-unbroken-2461d32274a1@wendy>
In-Reply-To: <20230914-coagulant-unbroken-2461d32274a1@wendy>
From:   Romain Perier <romain.perier@gmail.com>
Date:   Wed, 8 Nov 2023 14:27:37 +0100
Message-ID: <CABgxDoJhfKQesDtV3WJ=C-DPB8P+0LDmzbY9Zy909yr3v1FQKQ@mail.gmail.com>
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

Hi,

Alexandre seems to be okay with the current (merged) dt-binding, what
do I do ? I can send a v3 for trivial-rtc.yaml that's not a problem
for me but both of you seem to
be disagree :)

Regards,
Romain


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
>
> Thanks,
> Conor.

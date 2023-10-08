Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B49997BCC95
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Oct 2023 08:25:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344444AbjJHGY4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Oct 2023 02:24:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344392AbjJHGYy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Oct 2023 02:24:54 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 609C3DB;
        Sat,  7 Oct 2023 23:24:53 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-533d31a8523so6306207a12.1;
        Sat, 07 Oct 2023 23:24:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696746292; x=1697351092; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1Gr1mZ9X2KUB6a5Sl+O5P/cpeRCH0c3VVAkt2QKr4ZE=;
        b=BBDRmsqJOAnasq9ZuKjuoRdzjrRXVJHDplYsP+LOLckjMW1OZE+GfZekdUz0fLkAhG
         Qv19WnGVIw4p/VNPL7mISYy+u7/Wt/tqIgjGAKvF3kFbeYm1tvCDTiZ7+L4a8OV1161T
         p6UXbiyuLPiS5KxtuRg7dnGQokfhUdQdkIJ4U7cbZr/XEmBxNom98wW2cRLQJ9i9g3tb
         h23pem2q2TZdHiC3VCrLuccsNFNX/LSwSiMfBFKr1OmUGv8Cb6hzaUmfxR+G9RfhXDMR
         4KMZT4SKuk9C0yhgWtavPb1ErwjgAl0Uy+WbzBWcg4mWxduDW8MyniDoXd+jCFns9b41
         +MdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696746292; x=1697351092;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1Gr1mZ9X2KUB6a5Sl+O5P/cpeRCH0c3VVAkt2QKr4ZE=;
        b=PN3IlrlLwrfGpmsxpEksfvyfDDB3SFbnN91J2JmYB7UDbhcZxy5H8oFmAm3kSurq/N
         dId3rEKGAF/8RrQUNtdeTaE6heQ+BQanWCTj7NSOGMMg1IdvuatjDKo0i4V54f/lG7Zy
         VwFcPo7VbobcBVyEr2W1ALawt353YAYroxXdVUoMCMfKaVpvXcaRfGnhwhFMBMZnycpu
         qmC4tyzw4zx2deEcD6aZVUFIdRI2nB4pP2Ki+7A/VXoD1flxSD4qjB1F0/A3AYHqmjMI
         ph5W59OX/4J+TPCui/G2ZIt4VYrgKu7lHnPqkr7Svb84zaqi+CBWeHSH2ezuu3dy4VOj
         +tWA==
X-Gm-Message-State: AOJu0Yz4O+Kmv8hwCNnQhKp3jjUKXRoNZd5wbJQ4fjO40AbnZv9WMAmz
        vEKfilqBC4iRXQJVwfQM72WAuou7/CmtHyd6znk=
X-Google-Smtp-Source: AGHT+IH9Gb9RAQ2BgfE14DySOC1H+JtldrMhgrqfxEHOxMwvhkBoCb0651Eun/jDINVlj3TFQLKj+fR9W0caCzEaMlI=
X-Received: by 2002:aa7:da83:0:b0:533:d81b:36d5 with SMTP id
 q3-20020aa7da83000000b00533d81b36d5mr10401183eds.15.1696746291581; Sat, 07
 Oct 2023 23:24:51 -0700 (PDT)
MIME-Version: 1.0
References: <20230918080314.11959-1-jagathjog1996@gmail.com>
 <20230918080314.11959-2-jagathjog1996@gmail.com> <20230924143710.7c6edc4a@jic23-huawei>
 <CAM+2EuJ8o5X2ucph8gic2=03bbLQmUCX=j3SFLrqD4Y6rwXs9A@mail.gmail.com> <20230930170530.0b8f185c@jic23-huawei>
In-Reply-To: <20230930170530.0b8f185c@jic23-huawei>
From:   Jagath Jog J <jagathjog1996@gmail.com>
Date:   Sun, 8 Oct 2023 11:54:39 +0530
Message-ID: <CAM+2EuKzBVbTF2SrpYEYfzap1wrONboFV-QuTU9Fz7sVjqJLeA@mail.gmail.com>
Subject: Re: [RFC 1/2] dt-bindings: iio: imu: Add DT binding doc for BMI323
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     andriy.shevchenko@linux.intel.com, lars@metafoo.de,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jonathan,

Few more questions before sending the next series.

On Sat, Sep 30, 2023 at 9:35=E2=80=AFPM Jonathan Cameron <jic23@kernel.org>=
 wrote:
>
> On Thu, 28 Sep 2023 03:07:22 +0530
> Jagath Jog J <jagathjog1996@gmail.com> wrote:
>
> > HI Jonathan,
> >
> > On Sun, Sep 24, 2023 at 7:07=E2=80=AFPM Jonathan Cameron <jic23@kernel.=
org> wrote:
> > >
> > > On Mon, 18 Sep 2023 13:33:13 +0530
> > > Jagath Jog J <jagathjog1996@gmail.com> wrote:
> > >
> > > > Add devicetree description document for Bosch BMI323, a 6-Axis IMU.
> > > >
> > > > Signed-off-by: Jagath Jog J <jagathjog1996@gmail.com>

> > > > +  interrupts:
> > > > +    maxItems: 1
> > > > +
> > > > +  interrupt-names:
> > > > +    enum:
> > > > +      - INT1
> > > > +      - INT2
> > > > +    description: |
> > > > +      set to "INT1" if INT1 pin should be used as interrupt input,=
 set
> > > > +      to "INT2" if INT2 pin should be used instead
> > >
> > > Why not both?  Sure driver might elect to use only one, but the bindi=
ng
> > > describes the hardware not the driver and both might be wired.
> >
> > If both interrupt pins are wired, should the DTS file need to define
> > both of the pins?
>
> Yes it should. + we need the names to know which is which.
> You could rely on order, but it's more flexible to not do so, particularl=
y
> when you also need to support case where only one is wired.

In the driver, I currently prioritize INT1 over INT2 when checking
(bmi323_trigger_probe(..)) based on the interrupt-names defined
in the device tree. However, I'm open to suggestions on the best
way to ensure that the order doesn't affect the selection process
when both interrupts are defined in the device tree.

Each feature, such as data-ready, watermark, tap, and others, supports
either INT1 or INT2. Based on the interrupt pin defined in the device tree,
I configure the all the features accordingly.

Regarding your earlier suggestion to have two different controls for
drive-open-drain, do I need to define sensor-specific drive controls
in bindings for both interrupt pins?
for ex: bosch,irq{1,2}-open-drain

Regards
Jagath
>
>
> Jonathan
>
>

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DA377B0E2C
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 23:37:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229893AbjI0Vhi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 17:37:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229746AbjI0Vhh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 17:37:37 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 643FC11F;
        Wed, 27 Sep 2023 14:37:35 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-504a7f9204eso1480037e87.3;
        Wed, 27 Sep 2023 14:37:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695850653; x=1696455453; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CYLc3HDZug2/Yd29NYOTkdZgvZmGgRReX54Dn37yNTg=;
        b=kL//kzkUd8to1zWPEMatFMfKLbPhT7dBR+a7ejtoFxbzj7AVgOXVif9qc3dQt6iypE
         yxQLvtrqkZHnzv9NIE1kmjukgsztO+gQNjRGtH9pKF7tGjv9MO0oYajiDjNy4KjKs8S4
         EGRZJszbg0O0WfBNzS+nsBivBLlxIj36bL4/louKVri7r89GHruJCagHd6glPAXjnAs9
         kM04Ws0yfWz3svrieHbd9lS/Wfg9tiue5rf6yHQq/LdfiNSUOU1HdLqKjZo3MY1iYyuF
         SBMJUTQojom05OpplMx9uacI82r+WsSYqmwHS/xKW0h0bjaaW6+LBWOA0njD14bkSTAP
         m09w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695850653; x=1696455453;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CYLc3HDZug2/Yd29NYOTkdZgvZmGgRReX54Dn37yNTg=;
        b=Zue6j0AcCoC/YkqXDHHYzsShot9cOctzzyMfBbHbGciB+djZS++xfwOxbSp70sZtD8
         tL4fZEsDVfZGBlqIkY9ySfQs/b/f5Wjbltwm1eys5uVyW86J4Gjd67weqycozAoZv7Z3
         RBhMuvlXNteQj3/Ocshlx979X4wyJMEyml3sPfg9nddoBG0B9TLuSkxrU1tqX7w+O6tm
         UV8wiRIfsfX8HqGso5z+SoesIjWz6aTph+mj7WvDPnkbg8lTMOdfvDC/Hour5vduJR5t
         fudbtKpcJbz8CVcxIAnVmNqq152xh8H2xl0GINZsP01VvHe6gHCG8Idc90eG12y03eP+
         XZWw==
X-Gm-Message-State: AOJu0YwgurFd4DxfU3X77XcXsBnGfJG2gGMEvBDKCxP5I0Qqt7l1Fcj/
        d/06grzeOKpuWAcXKUGXAg55k6UfRSjA8RSbYcHi+L9wSfOXjg==
X-Google-Smtp-Source: AGHT+IGQyluJO+6YgJLtmKSvQEEjzaXAl86/D2dgg8PJECZK7gCuTBZx0ZbDDeqsKae5cFBtHXHVxy8G/uFfSZnZAN0=
X-Received: by 2002:a05:6512:39d2:b0:500:c589:95fb with SMTP id
 k18-20020a05651239d200b00500c58995fbmr3118553lfu.55.1695850653252; Wed, 27
 Sep 2023 14:37:33 -0700 (PDT)
MIME-Version: 1.0
References: <20230918080314.11959-1-jagathjog1996@gmail.com>
 <20230918080314.11959-2-jagathjog1996@gmail.com> <20230924143710.7c6edc4a@jic23-huawei>
In-Reply-To: <20230924143710.7c6edc4a@jic23-huawei>
From:   Jagath Jog J <jagathjog1996@gmail.com>
Date:   Thu, 28 Sep 2023 03:07:22 +0530
Message-ID: <CAM+2EuJ8o5X2ucph8gic2=03bbLQmUCX=j3SFLrqD4Y6rwXs9A@mail.gmail.com>
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
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

HI Jonathan,

On Sun, Sep 24, 2023 at 7:07=E2=80=AFPM Jonathan Cameron <jic23@kernel.org>=
 wrote:
>
> On Mon, 18 Sep 2023 13:33:13 +0530
> Jagath Jog J <jagathjog1996@gmail.com> wrote:
>
> > Add devicetree description document for Bosch BMI323, a 6-Axis IMU.
> >
> > Signed-off-by: Jagath Jog J <jagathjog1996@gmail.com>
> > ---
> >  .../bindings/iio/imu/bosch,bmi323.yaml        | 81 +++++++++++++++++++
> >  1 file changed, 81 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/iio/imu/bosch,bmi=
323.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/iio/imu/bosch,bmi323.yam=
l b/Documentation/devicetree/bindings/iio/imu/bosch,bmi323.yaml
> > new file mode 100644
> > index 000000000000..9c08988103c5
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/iio/imu/bosch,bmi323.yaml
> > @@ -0,0 +1,81 @@
> > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/iio/imu/bosch,bmi323.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Bosch BMI323 6-Axis IMU
> > +
> > +maintainers:
> > +  - Jagath Jog J <jagathjog1996@gmail.com>
> > +
> > +description:
> > +  BMI323 is a 6-axis inertial measurement unit that supports accelerat=
ion and
> > +  gyroscopic measurements with hardware fifo buffering. Sensor also pr=
ovides
> > +  events information such as motion, steps, orientation, single and do=
uble
> > +  tap detection.
> > +
> > +properties:
> > +  compatible:
> > +    const: bosch,bmi323
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  interrupts:
> > +    maxItems: 1
> > +
> > +  interrupt-names:
> > +    enum:
> > +      - INT1
> > +      - INT2
> > +    description: |
> > +      set to "INT1" if INT1 pin should be used as interrupt input, set
> > +      to "INT2" if INT2 pin should be used instead
>
> Why not both?  Sure driver might elect to use only one, but the binding
> describes the hardware not the driver and both might be wired.

If both interrupt pins are wired, should the DTS file need to define
both of the pins?

>
> Lots of different sources of interrupts so might be advantageous
> to split them up across two wires.   A simple case being to route
> errors to one and everything 'good' to the other.  No obligation to
> support that in the Linux driver though if you don't need to.

Sure I will split into two different wires in bindings.

>
> > +
> > +  drive-open-drain:
> > +    description: |
> > +      set if the specified interrupt pin should be configured as
> > +      open drain. If not set, defaults to push-pull.
>
> Two pins.  Might be different so you need two controls.

Sure, In bindings I will add two different drive controls.
If both interrupt pins are wired with different drive options
should the DTS file still define both of the pins?

>
> > +
> > +required:
> > +  - compatible
> > +  - reg
>
> As mentioned, need power supplies specified and marked as required
> (though they may be provided via always on regulators and rely on stubs
> being created by the regulator subsystem on a given board).
> Looks like there are at least 2 supplies.

Sure, I will add 2 power supplies in the next series.

Regards
Jagath

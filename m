Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5DE27B41F6
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Sep 2023 18:05:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234475AbjI3QFd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Sep 2023 12:05:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234460AbjI3QFc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Sep 2023 12:05:32 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDEB6BE;
        Sat, 30 Sep 2023 09:05:29 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E349C433C9;
        Sat, 30 Sep 2023 16:05:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696089929;
        bh=B8HApJopjsGysG9kMK09Fn76dse5FPqZB8+iLH4XQ9k=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=MW/xi37n3fWl9V2XhRxzTzTA9IlsIcZ+hZ026aJlzXomNzVUAsKiWgwE1q/WfuGXC
         R+1+DrB6tq2irZbtOQ4u6A7mUa14uvPb6z8Atthbuw2Xw4ga/L2e35oFDD+aIuwhwE
         LojBMWQXl0xYTtCJ0vc1XkgMdW83wpSA3TUrEYDoaoCKXiTWF27BMC0h5Bss1qAvfI
         IEtPriVDRafde9CQNjeWMYN0KTwK62YNjESG9Sq7N6FA5JQMLF9p98g5rJugoq4Nvm
         uHHKYln4Fxo6pwuCBNF7UG6ERcAXCLoLAGnVWvye4ydzg8R/q1/bR4XyTKqljdvubA
         FCpSOqurrF7ig==
Date:   Sat, 30 Sep 2023 17:05:30 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Jagath Jog J <jagathjog1996@gmail.com>
Cc:     andriy.shevchenko@linux.intel.com, lars@metafoo.de,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC 1/2] dt-bindings: iio: imu: Add DT binding doc for BMI323
Message-ID: <20230930170530.0b8f185c@jic23-huawei>
In-Reply-To: <CAM+2EuJ8o5X2ucph8gic2=03bbLQmUCX=j3SFLrqD4Y6rwXs9A@mail.gmail.com>
References: <20230918080314.11959-1-jagathjog1996@gmail.com>
        <20230918080314.11959-2-jagathjog1996@gmail.com>
        <20230924143710.7c6edc4a@jic23-huawei>
        <CAM+2EuJ8o5X2ucph8gic2=03bbLQmUCX=j3SFLrqD4Y6rwXs9A@mail.gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Sep 2023 03:07:22 +0530
Jagath Jog J <jagathjog1996@gmail.com> wrote:

> HI Jonathan,
>=20
> On Sun, Sep 24, 2023 at 7:07=E2=80=AFPM Jonathan Cameron <jic23@kernel.or=
g> wrote:
> >
> > On Mon, 18 Sep 2023 13:33:13 +0530
> > Jagath Jog J <jagathjog1996@gmail.com> wrote:
> > =20
> > > Add devicetree description document for Bosch BMI323, a 6-Axis IMU.
> > >
> > > Signed-off-by: Jagath Jog J <jagathjog1996@gmail.com>
> > > ---
> > >  .../bindings/iio/imu/bosch,bmi323.yaml        | 81 +++++++++++++++++=
++
> > >  1 file changed, 81 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/iio/imu/bosch,b=
mi323.yaml
> > >
> > > diff --git a/Documentation/devicetree/bindings/iio/imu/bosch,bmi323.y=
aml b/Documentation/devicetree/bindings/iio/imu/bosch,bmi323.yaml
> > > new file mode 100644
> > > index 000000000000..9c08988103c5
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/iio/imu/bosch,bmi323.yaml
> > > @@ -0,0 +1,81 @@
> > > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/iio/imu/bosch,bmi323.yaml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: Bosch BMI323 6-Axis IMU
> > > +
> > > +maintainers:
> > > +  - Jagath Jog J <jagathjog1996@gmail.com>
> > > +
> > > +description:
> > > +  BMI323 is a 6-axis inertial measurement unit that supports acceler=
ation and
> > > +  gyroscopic measurements with hardware fifo buffering. Sensor also =
provides
> > > +  events information such as motion, steps, orientation, single and =
double
> > > +  tap detection.
> > > +
> > > +properties:
> > > +  compatible:
> > > +    const: bosch,bmi323
> > > +
> > > +  reg:
> > > +    maxItems: 1
> > > +
> > > +  interrupts:
> > > +    maxItems: 1
> > > +
> > > +  interrupt-names:
> > > +    enum:
> > > +      - INT1
> > > +      - INT2
> > > +    description: |
> > > +      set to "INT1" if INT1 pin should be used as interrupt input, s=
et
> > > +      to "INT2" if INT2 pin should be used instead =20
> >
> > Why not both?  Sure driver might elect to use only one, but the binding
> > describes the hardware not the driver and both might be wired. =20
>=20
> If both interrupt pins are wired, should the DTS file need to define
> both of the pins?

Yes it should. + we need the names to know which is which.
You could rely on order, but it's more flexible to not do so, particularly
when you also need to support case where only one is wired.


Jonathan



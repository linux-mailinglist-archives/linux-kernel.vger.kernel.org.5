Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C04C37A9B70
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 21:01:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230527AbjIUTBe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 15:01:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230047AbjIUTBH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 15:01:07 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F2B97B951
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 10:36:59 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19B80C4E67A;
        Thu, 21 Sep 2023 12:18:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695298694;
        bh=qmymxn57s6y/C3HqE3FJehRFkoes3QzpalkGevYvvUY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ICCPYTi5A8rrVEfseGvXpOnv3WdinCsEQeA7NPK+S2/PtCnKGOP7UtJKUx1HdLjMQ
         S2cYMQwPkPbKoOOWzaVakoR9wmV8gIrHn4tBxsztg8dwupb5OFCoQfle6GIX88JpCk
         ltUvwNVyLKOBhJHiq8TRD45FoDMAzU8goBvhTHqZq3pJJ530PWT4nEg6F9Q9AiBdUa
         Xj5hcoLoXANxaSOUmIbyf7A4kMzvgqqTtq3LlAPRnmT9VNVXz71yMiSgFBB4+xHC1K
         aC9mxbJwVpZ45a0/zT/J2WA3N2lgQ9rVVhw63Ln4hNXEuM6oqdFDrTt2vwzoHvQI3/
         XQFaHAPUUbGGw==
Date:   Thu, 21 Sep 2023 13:18:08 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Chen Wang <unicornxw@gmail.com>
Cc:     Conor Dooley <conor.dooley@microchip.com>, aou@eecs.berkeley.edu,
        chao.wei@sophgo.com, devicetree@vger.kernel.org,
        emil.renner.berthing@canonical.com, guoren@kernel.org,
        jszhang@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        palmer@dabbelt.com, paul.walmsley@sifive.com, robh+dt@kernel.org,
        xiaoguang.xing@sophgo.com, Chen Wang <wangchen20@iscas.ac.cn>
Subject: Re: [PATCH v2 03/11] dt-bindings: riscv: add sophgo sg2042 bindings
Message-ID: <20230921-1ae70cfdbf983e011d5b6754@fedora>
References: <cover.1695189879.git.wangchen20@iscas.ac.cn>
 <c6aea83bb1df563b1f2a66c5f230c3861aed1e15.1695189879.git.wangchen20@iscas.ac.cn>
 <20230920-arrival-bonanza-e335686420f4@wendy>
 <CAHAQgRDh72FLQPOFzn2rhsWmOOaLUO0sKyJwJQBG0Z7qZN_YLw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="8Cc4R56bUloFLm3Z"
Content-Disposition: inline
In-Reply-To: <CAHAQgRDh72FLQPOFzn2rhsWmOOaLUO0sKyJwJQBG0Z7qZN_YLw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--8Cc4R56bUloFLm3Z
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 21, 2023 at 06:21:08PM +0800, Chen Wang wrote:
> Conor Dooley <conor.dooley@microchip.com> =E4=BA=8E2023=E5=B9=B49=E6=9C=
=8820=E6=97=A5=E5=91=A8=E4=B8=89 16:29=E5=86=99=E9=81=93=EF=BC=9A
> > On Wed, Sep 20, 2023 at 02:37:51PM +0800, Chen Wang wrote:
> > > Add DT binding documentation for the Sophgo SG2042 Soc [1] and the
> > > Milk-V Pioneer board [2].
> > >
> > > [1]: https://en.sophgo.com/product/introduce/sg2042.html
> > > [2]: https://milkv.io/pioneer
> >
> > Again, link tags please.
> >
> > > Acked-by: Chao Wei <chao.wei@sophgo.com>
> > > Acked-by: Xiaoguang Xing <xiaoguang.xing@sophgo.com>
> > > Signed-off-by: Chen Wang <wangchen20@iscas.ac.cn>
> > > ---
> > >  .../devicetree/bindings/riscv/sophgo.yaml     | 28 +++++++++++++++++=
++
> > >  MAINTAINERS                                   |  7 +++++
> > >  2 files changed, 35 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/riscv/sophgo.ya=
ml
> > >
> > > diff --git a/Documentation/devicetree/bindings/riscv/sophgo.yaml b/Do=
cumentation/devicetree/bindings/riscv/sophgo.yaml
> > > new file mode 100644
> > > index 000000000000..82468ae915db
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/riscv/sophgo.yaml
> > > @@ -0,0 +1,28 @@
> > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/riscv/sophgo.yaml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: Sophgo SoC-based boards
> > > +
> > > +maintainers:
> > > +  - Chao Wei <chao.wei@sophgo.com>
> > > +  - Xiaoguang Xing <xiaoguang.xing@sophgo.com>
> > > +
> > > +description:
> > > +  Sophgo SoC-based boards
> > > +
> > > +properties:
> > > +  $nodename:
> > > +    const: '/'
> > > +  compatible:
> > > +    oneOf:
> > > +      - items:
> > > +          - enum:
> > > +              - milkv,pioneer
> > > +          - const: sophgo,sg2042
> > > +
> > > +additionalProperties: true
> > > +
> > > +...
> > > diff --git a/MAINTAINERS b/MAINTAINERS
> > > index 90f13281d297..b74d505003e2 100644
> > > --- a/MAINTAINERS
> > > +++ b/MAINTAINERS
> > > @@ -20063,6 +20063,13 @@ F:   drivers/char/sonypi.c
> > >  F:   drivers/platform/x86/sony-laptop.c
> > >  F:   include/linux/sony-laptop.h
> > >
> > > +SOPHGO DEVICETREES
> > > +M:   Xiaoguang Xing <xiaoguang.xing@sophgo.com>
> > > +M:   Chao Wei <chao.wei@sophgo.com>
> > > +S:   Maintained
> > > +F:   Documentation/devicetree/bindings/riscv/sophgo.yaml
> >
> > > +F:   arch/riscv/boot/dts/sophgo/
> >
> > Firstly, this directory does not exist at the time of this patch, so it
> > should not be added here, but rather at the time that you create it.
> >
> > Secondly, are Xiaoguang Xing and Chao Wei going to monitor the lists &
> > apply patches for these files? If so, you should add a git tree here
> > that they will apply patches to & add to linux-next. Also, I'd really
> > like to see some on-list signs of life from these people, otherwise
> > I'd rather see your name here instead of theirs.
> >
> > If they don't intend reviewing/testing/applying patches, I can do it as
> > a last resort but I would rather that someone who specifically cares for
> > this hardware does it.
>=20
> Please allow me to explain first. As a community volunteer, I actually
> had full discussions and testing with Sophgo people when submitting
> patches, so I added tag such "Acked-by: Xiaoguang Xing ..." to the
> signature part of most patches. Also if you think a formal email is
> required, I will talk them to send it.

No, I'm okay with the acks that are on these patches. I just want to
make sure that those who are acking know why they are & am wondering why
your name is not there, seeing as you're the one who has submitted these
patches.

> As for the issue of MAINTAINERS, I discussed it with the people from
> Sophgo. They (including me also) feel that we are not very familiar
> with the community process (especially as maintainer, and actually I
> modify the file MAINTAINERS is just to suppress warning information
> when running checkpatch.pl), so we sincerely hope to invite you, Mr.
> Conor,

Oh god, there's no need to call me "Mr. Conor". Conor will do perfectly
fine!

> to help us for a period of time on maintenance work, including
> checking relevant patches, merging and submitting PRs, we will learn
> together with you for a while, and then take over this part of the
> work when we become familiar with it. We know that you are also very
> busy at work, especially if you don't have the hardware at hand. I
> have the hardware here and I can take the responsibility to run
> testing. What do you think? I'm waiting for your reply. Thanks in
> advance.

That seems fine to me. In that case, you should add yourself to the
MAINTAINERS entry.

Thanks,
Conor.

--8Cc4R56bUloFLm3Z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZQw0egAKCRB4tDGHoIJi
0upuAP9e+4b7yDD+8RNRpdlOF0A7E6AxHPx60+aInTMSpqizJwD/e0DeVwI5xEEG
zzLkCk94IyNRVLe4jIQ/I/2+sJmTHQA=
=fSpa
-----END PGP SIGNATURE-----

--8Cc4R56bUloFLm3Z--

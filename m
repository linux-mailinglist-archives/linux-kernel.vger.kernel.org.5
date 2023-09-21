Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAF167AA217
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 23:12:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232026AbjIUVMZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 17:12:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230304AbjIUVK7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 17:10:59 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CABDACD2D;
        Thu, 21 Sep 2023 11:02:54 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id 41be03b00d2f7-578d78ffdbcso837585a12.2;
        Thu, 21 Sep 2023 11:02:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695319373; x=1695924173; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g0QwFnxPqdBvVaar0AtuCTvYbRR1x/XZq77ioNk3ptM=;
        b=WrNaQHTLQCiu3iXjRRVNEXCYU42RPcJHakh5k800hfOoPHqXe8ma3sK7HA9YqrrCKl
         CR61D0qXxy5MQ/on3vGANPBZ/FP3CQmNd07CaSrDgkEB08xl2BltSIEXIrQdJ/M+9pqk
         85EIs+K8SuVNZ5Ay2YknftXo3hvdAv0tIDQTeS1uKdKZ0igZojb5jvKFicQF8DN+sXYc
         FVHuh6FHyJnuz3vvKVMAXeqq46Bvu7YyYzaNXiTTl92pXwwyBN7lJVX7NTWEYbKWKyRC
         ex+19xnTqfVMEF/4NnISGLoS7I+1CV+UzilGkkdk8DeVTcM4ZBOozKbGhvIXRjPoCgTL
         G5zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695319373; x=1695924173;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g0QwFnxPqdBvVaar0AtuCTvYbRR1x/XZq77ioNk3ptM=;
        b=gXZN7p0NvzQNLy90cfYYq1+Pp/5Ulo6nX6tENfRjSIL+TcN5pEMqe+1pslIOOLOMpE
         SY6s7Ki6SRm3HQbVTql5BHiufP6lbGQX8+hbVi2tGlVJcZIqjB5i781pCOhqNboxBouJ
         cZT504DggDfkWTz78f9/OElQ87hH9M91y/yQYVO+9JK8XlN8HmAOrFlIz0x+QV5+lsZ3
         pMjxAkvW0cuB7dvCX+/+JawUVCdH1qVaKDW0t7Ls0DUPBeSfMxJ1HQEKyGYLbGzR9Jbf
         vayLRoBZiJy6mXKgxx0CHcaT2JZtAfWawMy2BXeUnBr5KcHv4FFbF/nl7aajglgTebSh
         CAkg==
X-Gm-Message-State: AOJu0YwzrbQrZ4qnn1ZfHdg1dj8nue6qkBQkONXx+vj8eIWDxf9UUebl
        Sn/ZFLwC37xCPZ7ZMjmVpXKpVRD76sMXNU5o1Y8pDz/g
X-Google-Smtp-Source: AGHT+IH57JUHuzOh+vpq91EaewPD02Z80+hZjRFdizwKopdaWk/DGZPX4W6wwSfiGD/Edr4Sx0iI4SOAXukTILHCsgE=
X-Received: by 2002:a0c:b256:0:b0:655:71df:4c7d with SMTP id
 k22-20020a0cb256000000b0065571df4c7dmr5367941qve.56.1695304329735; Thu, 21
 Sep 2023 06:52:09 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1695189879.git.wangchen20@iscas.ac.cn> <c6aea83bb1df563b1f2a66c5f230c3861aed1e15.1695189879.git.wangchen20@iscas.ac.cn>
 <20230920-arrival-bonanza-e335686420f4@wendy> <CAHAQgRDh72FLQPOFzn2rhsWmOOaLUO0sKyJwJQBG0Z7qZN_YLw@mail.gmail.com>
 <20230921-1ae70cfdbf983e011d5b6754@fedora>
In-Reply-To: <20230921-1ae70cfdbf983e011d5b6754@fedora>
From:   Chen Wang <unicornxw@gmail.com>
Date:   Thu, 21 Sep 2023 21:51:58 +0800
Message-ID: <CAHAQgRBFje4mdhE3dZZH=HxED0bUauXBD4yNfQzEnpPSWG5HiA@mail.gmail.com>
Subject: Re: [PATCH v2 03/11] dt-bindings: riscv: add sophgo sg2042 bindings
To:     Conor Dooley <conor@kernel.org>
Cc:     Conor Dooley <conor.dooley@microchip.com>, aou@eecs.berkeley.edu,
        chao.wei@sophgo.com, devicetree@vger.kernel.org,
        emil.renner.berthing@canonical.com, guoren@kernel.org,
        jszhang@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        palmer@dabbelt.com, paul.walmsley@sifive.com, robh+dt@kernel.org,
        xiaoguang.xing@sophgo.com, Chen Wang <wangchen20@iscas.ac.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Regards,

unicornx

Conor Dooley <conor@kernel.org> =E4=BA=8E2023=E5=B9=B49=E6=9C=8821=E6=97=A5=
=E5=91=A8=E5=9B=9B 20:18=E5=86=99=E9=81=93=EF=BC=9A
>
> On Thu, Sep 21, 2023 at 06:21:08PM +0800, Chen Wang wrote:
> > Conor Dooley <conor.dooley@microchip.com> =E4=BA=8E2023=E5=B9=B49=E6=9C=
=8820=E6=97=A5=E5=91=A8=E4=B8=89 16:29=E5=86=99=E9=81=93=EF=BC=9A
> > > On Wed, Sep 20, 2023 at 02:37:51PM +0800, Chen Wang wrote:
> > > > Add DT binding documentation for the Sophgo SG2042 Soc [1] and the
> > > > Milk-V Pioneer board [2].
> > > >
> > > > [1]: https://en.sophgo.com/product/introduce/sg2042.html
> > > > [2]: https://milkv.io/pioneer
> > >
> > > Again, link tags please.
> > >
> > > > Acked-by: Chao Wei <chao.wei@sophgo.com>
> > > > Acked-by: Xiaoguang Xing <xiaoguang.xing@sophgo.com>
> > > > Signed-off-by: Chen Wang <wangchen20@iscas.ac.cn>
> > > > ---
> > > >  .../devicetree/bindings/riscv/sophgo.yaml     | 28 +++++++++++++++=
++++
> > > >  MAINTAINERS                                   |  7 +++++
> > > >  2 files changed, 35 insertions(+)
> > > >  create mode 100644 Documentation/devicetree/bindings/riscv/sophgo.=
yaml
> > > >
> > > > diff --git a/Documentation/devicetree/bindings/riscv/sophgo.yaml b/=
Documentation/devicetree/bindings/riscv/sophgo.yaml
> > > > new file mode 100644
> > > > index 000000000000..82468ae915db
> > > > --- /dev/null
> > > > +++ b/Documentation/devicetree/bindings/riscv/sophgo.yaml
> > > > @@ -0,0 +1,28 @@
> > > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > > +%YAML 1.2
> > > > +---
> > > > +$id: http://devicetree.org/schemas/riscv/sophgo.yaml#
> > > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > > +
> > > > +title: Sophgo SoC-based boards
> > > > +
> > > > +maintainers:
> > > > +  - Chao Wei <chao.wei@sophgo.com>
> > > > +  - Xiaoguang Xing <xiaoguang.xing@sophgo.com>
> > > > +
> > > > +description:
> > > > +  Sophgo SoC-based boards
> > > > +
> > > > +properties:
> > > > +  $nodename:
> > > > +    const: '/'
> > > > +  compatible:
> > > > +    oneOf:
> > > > +      - items:
> > > > +          - enum:
> > > > +              - milkv,pioneer
> > > > +          - const: sophgo,sg2042
> > > > +
> > > > +additionalProperties: true
> > > > +
> > > > +...
> > > > diff --git a/MAINTAINERS b/MAINTAINERS
> > > > index 90f13281d297..b74d505003e2 100644
> > > > --- a/MAINTAINERS
> > > > +++ b/MAINTAINERS
> > > > @@ -20063,6 +20063,13 @@ F:   drivers/char/sonypi.c
> > > >  F:   drivers/platform/x86/sony-laptop.c
> > > >  F:   include/linux/sony-laptop.h
> > > >
> > > > +SOPHGO DEVICETREES
> > > > +M:   Xiaoguang Xing <xiaoguang.xing@sophgo.com>
> > > > +M:   Chao Wei <chao.wei@sophgo.com>
> > > > +S:   Maintained
> > > > +F:   Documentation/devicetree/bindings/riscv/sophgo.yaml
> > >
> > > > +F:   arch/riscv/boot/dts/sophgo/
> > >
> > > Firstly, this directory does not exist at the time of this patch, so =
it
> > > should not be added here, but rather at the time that you create it.
> > >
> > > Secondly, are Xiaoguang Xing and Chao Wei going to monitor the lists =
&
> > > apply patches for these files? If so, you should add a git tree here
> > > that they will apply patches to & add to linux-next. Also, I'd really
> > > like to see some on-list signs of life from these people, otherwise
> > > I'd rather see your name here instead of theirs.
> > >
> > > If they don't intend reviewing/testing/applying patches, I can do it =
as
> > > a last resort but I would rather that someone who specifically cares =
for
> > > this hardware does it.
> >
> > Please allow me to explain first. As a community volunteer, I actually
> > had full discussions and testing with Sophgo people when submitting
> > patches, so I added tag such "Acked-by: Xiaoguang Xing ..." to the
> > signature part of most patches. Also if you think a formal email is
> > required, I will talk them to send it.
>
> No, I'm okay with the acks that are on these patches. I just want to
> make sure that those who are acking know why they are & am wondering why
> your name is not there, seeing as you're the one who has submitted these
> patches.
>
> > As for the issue of MAINTAINERS, I discussed it with the people from
> > Sophgo. They (including me also) feel that we are not very familiar
> > with the community process (especially as maintainer, and actually I
> > modify the file MAINTAINERS is just to suppress warning information
> > when running checkpatch.pl), so we sincerely hope to invite you, Mr.
> > Conor,
>
> Oh god, there's no need to call me "Mr. Conor". Conor will do perfectly
> fine!
>
> > to help us for a period of time on maintenance work, including
> > checking relevant patches, merging and submitting PRs, we will learn
> > together with you for a while, and then take over this part of the
> > work when we become familiar with it. We know that you are also very
> > busy at work, especially if you don't have the hardware at hand. I
> > have the hardware here and I can take the responsibility to run
> > testing. What do you think? I'm waiting for your reply. Thanks in
> > advance.
>
> That seems fine to me. In that case, you should add yourself to the
> MAINTAINERS entry.
>
> Thanks,
> Conor.

Conor, do you want me to add you to the MAINTAINERS entry too?

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1B727AA1DC
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 23:07:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229783AbjIUVHZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 17:07:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232577AbjIUVF7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 17:05:59 -0400
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF75B72D43;
        Thu, 21 Sep 2023 10:32:58 -0700 (PDT)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-59c0b9ad491so15172187b3.1;
        Thu, 21 Sep 2023 10:32:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695317572; x=1695922372; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/rpm5+JLYJmdv53YiNxNC9Ky9+Imr89A4Evb+6bL1iE=;
        b=Flx5EW7wFBjZUe1NhWFh+LImbCdTDbFcuzsXq79Jf8xW1byqhHIaw0kK0z7+7QjeGF
         g+x15/vREBN5YW18KdE1mP9fbpOAmtodCKc6407EyW2Va3qmGJnFfAxM+4NLRqqPocd3
         jxIX17DsEMYBR2cuTyi2gVUWDaAhe1GrSAnKclgmbvvrSuFW4ZeAw5SHV94CJZ0vsV9d
         2Gyih907SOL9CponoCo4/H6AQvHiMIzzyyzBUS8MPZeNqZocUYFF8qqiKrBh+WAV8wWx
         q5vWR9fHV0NrXIiyoBpEFwgUO6ZBissYY0DvKwqed5Q2Rtzx+wKeBzhG3wkPy7720ZtE
         GJHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695317572; x=1695922372;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/rpm5+JLYJmdv53YiNxNC9Ky9+Imr89A4Evb+6bL1iE=;
        b=TYJk+acLKVAn9x0YtOdtVd7/iyp5ZypRIF0RDaR3atLWu79dAprhQx78Z9yTmzpL0W
         3YjuG6V5xSqh2mFr/ZyKUv7VixxG+szYwVYesuuh6TMkI55AiB5/mVZ53Cod/w4+NvC8
         SfTe7gLr1h2B/tzV+YU+2CdpQkmdmADFQ+lQNhP32efUqHMX1N+ExnXK5M5DGOEmBqcN
         H6Wf7kzcn1JI2/WpDK6ep5Oul/91RX1QCOFK+bSf253H9rlGc5cg3qxNJC+8IH0EXNfP
         gz9M5G5tIjD6vjPBDfoc8XvUj9NDusOVgfJ+to3PA+XtJDTp35g7hqylv0Lqc0cGWlZd
         lEpQ==
X-Gm-Message-State: AOJu0Yx3NOGDLcm7242ock28MGkdO7hXUwocvVf+xIkoupP8KMVGwepu
        hDBvYQvksy1TFw7cnWyWRIDSE6xoq1RklsPVxWH/fNSP
X-Google-Smtp-Source: AGHT+IGIIZWD7Q1hxOFFNiQrY1guGCVYQP0GsAOt+m86LmLPjHCrGLS7jwLW+qpsBYUIZB1XkJ4C92WYSDgjdG9MBZc=
X-Received: by 2002:a05:6870:1481:b0:1c0:f8a7:ec14 with SMTP id
 k1-20020a056870148100b001c0f8a7ec14mr5497639oab.57.1695303666009; Thu, 21 Sep
 2023 06:41:06 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1695189879.git.wangchen20@iscas.ac.cn> <c6aea83bb1df563b1f2a66c5f230c3861aed1e15.1695189879.git.wangchen20@iscas.ac.cn>
 <20230920-arrival-bonanza-e335686420f4@wendy> <CAHAQgRDh72FLQPOFzn2rhsWmOOaLUO0sKyJwJQBG0Z7qZN_YLw@mail.gmail.com>
 <20230921-1ae70cfdbf983e011d5b6754@fedora>
In-Reply-To: <20230921-1ae70cfdbf983e011d5b6754@fedora>
From:   Chen Wang <unicornxw@gmail.com>
Date:   Thu, 21 Sep 2023 21:40:55 +0800
Message-ID: <CAHAQgRAmO6-aoCM6LALO5+B5N=_=-jD-JrJ0X50avc0_dJy3TQ@mail.gmail.com>
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

Okay=EF=BC=8CI will add it in next revision, thank you again.

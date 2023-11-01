Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 684E97DDAA9
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 02:42:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377027AbjKABm2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 21:42:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345060AbjKABm1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 21:42:27 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA09D119;
        Tue, 31 Oct 2023 18:42:23 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id 3f1490d57ef6-da0359751dbso411245276.1;
        Tue, 31 Oct 2023 18:42:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698802943; x=1699407743; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EqP28swEoFqFBpOsPvURB6Dcv19Cyas9Sj5n5k9cRsM=;
        b=NrmGem361rCdWpysmkJeD7d2pRTvDa//3MbgBE99zw/y7kH+4NNFlz0B9ykGqZ8AGE
         fI90sAxBfDL1N98NCYkscRvl0miTjLfW63WTHfYSlJ5cOGKW91+b+k0/6DfLVIK6v8VM
         im4amIZxsOiS95bNs9+65FVkD1z+GWK5cqsFxbD0lJvQu4+tsm7ckY2iLixCVpKCk1yT
         Lr7K2s7P7mp7UQyumYw0advBWnwzqIIcr0goJjoNK0MG8IGu7cXFcfjRUouLrSi/5Ph7
         EJI8P7h8eOWCly3Uy417xrlrR8N9p3g9mfG3oroigd9UmxTpDwcCoV2umGYaEyx7Q3Eg
         lp5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698802943; x=1699407743;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EqP28swEoFqFBpOsPvURB6Dcv19Cyas9Sj5n5k9cRsM=;
        b=vU9K4Sbw0aREZ7J8tPwpCY7D6U9+0LUD07+slkVRHj9Wlv59LJEFtNrjyiui3trKJ1
         4E0GtJDP4d/ZRmU1m1+p5Dqgql5+U6fzDAdVO2get632wlu2vhmUNRgU0jdcEFZLsTGS
         5X2sUwRokAInPenFxzGg811N6KJt11jvosW4dtJJl+kIbrjEYIxW42XOyeRLXnL+vf3M
         Zi7zmQhBbRS4EjyHvJ4ffX70kMltZtzqKQvYqcChJEx1s8kD2U7O6O6fTfJDb71PEJo1
         EnKEeOqj2kElUSWOl3BHIuUb9zbNMv7VMoeOagleRStaTASll8DmtdyruchPGT6WqlUH
         XdxQ==
X-Gm-Message-State: AOJu0YxuQA5+uWPEuQEB2o4dhzDbpBp1nhKfup3xZP89mbM6wrbv9lf5
        scxu0T0T5yXBMWWz27/S5t05fH81YXgoAeyoC4s=
X-Google-Smtp-Source: AGHT+IFa2JpmHdGFDcAM1sUzLsses6Qgyt8fsVsUd3nY2L/J+jzVc7x7mSCYmF8QOruW6ygQIYO6W7vsbej/b/cnyd4=
X-Received: by 2002:a25:9307:0:b0:da0:7fe0:dc6 with SMTP id
 f7-20020a259307000000b00da07fe00dc6mr3496481ybo.14.1698802942978; Tue, 31 Oct
 2023 18:42:22 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1698717154.git.zhoubinbin@loongson.cn> <fd5efc8a21b94e044e4e225255655fc92beb0c63.1698717154.git.zhoubinbin@loongson.cn>
 <20231031175205.GA1803813-robh@kernel.org>
In-Reply-To: <20231031175205.GA1803813-robh@kernel.org>
From:   Binbin Zhou <zhoubb.aaron@gmail.com>
Date:   Wed, 1 Nov 2023 07:42:11 +0600
Message-ID: <CAMpQs4+4bSKC+nUGoD=HpwcSfQ7AUZWm-N_moRZN7kc_q_SrAQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/5] dt-bindings: interrupt-controller:
 loongson,liointc: Fix dtbs_check warning for reg-names
To:     Rob Herring <robh@kernel.org>
Cc:     Binbin Zhou <zhoubinbin@loongson.cn>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Thomas Gleixner <tglx@linutronix.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Huacai Chen <chenhuacai@kernel.org>,
        loongson-kernel@lists.loongnix.cn, devicetree@vger.kernel.org,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        linux-mips@vger.kernel.org, lvjianmin@loongson.cn,
        WANG Xuerui <git@xen0n.name>, loongarch@lists.linux.dev,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 31, 2023 at 11:52=E2=80=AFPM Rob Herring <robh@kernel.org> wrot=
e:
>
> On Tue, Oct 31, 2023 at 10:36:37AM +0800, Binbin Zhou wrote:
> > As we know, the Loongson-2K0500 is a single-core CPU, and the
> > core1-related register (isr1) does not exist, and we need a separate
> > declaration.
> >
> > This fixes dtbs_check warning:
> >
> > DTC_CHK arch/loongarch/boot/dts/loongson-2k0500-ref.dtb
> > arch/loongarch/boot/dts/loongson-2k0500-ref.dtb: interrupt-controller@1=
fe11400: reg-names: ['main', 'isr0'] is too short
> >         From schema: Documentation/devicetree/bindings/interrupt-contro=
ller/loongson,liointc.yaml
> > arch/loongarch/boot/dts/loongson-2k0500-ref.dtb: interrupt-controller@1=
fe11400: Unevaluated properties are not allowed ('reg-names' was unexpected=
)
> >         From schema: Documentation/devicetree/bindings/interrupt-contro=
ller/loongson,liointc.yaml
> > arch/loongarch/boot/dts/loongson-2k0500-ref.dtb: interrupt-controller@1=
fe11400: reg: [[0, 534844416, 0, 64], [0, 534843456, 0, 8]] is too short
> >         From schema: Documentation/devicetree/bindings/interrupt-contro=
ller/loongson,liointc.yaml
> > arch/loongarch/boot/dts/loongson-2k0500-ref.dtb: interrupt-controller@1=
fe11440: reg-names: ['main', 'isr0'] is too short
> >         From schema: Documentation/devicetree/bindings/interrupt-contro=
ller/loongson,liointc.yaml
> >
> > Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
> > ---
> >  .../loongson,liointc.yaml                     | 22 ++++++++++++++-----
> >  1 file changed, 16 insertions(+), 6 deletions(-)
> >
> > diff --git a/Documentation/devicetree/bindings/interrupt-controller/loo=
ngson,liointc.yaml b/Documentation/devicetree/bindings/interrupt-controller=
/loongson,liointc.yaml
> > index 0d9511b8a792..7393d7dfbe82 100644
> > --- a/Documentation/devicetree/bindings/interrupt-controller/loongson,l=
iointc.yaml
> > +++ b/Documentation/devicetree/bindings/interrupt-controller/loongson,l=
iointc.yaml
> > @@ -11,8 +11,13 @@ maintainers:
> >
> >  description: |
> >    This interrupt controller is found in the Loongson-3 family of chips=
 and
> > -  Loongson-2K1000 chip, as the primary package interrupt controller wh=
ich
> > +  Loongson-2K series chips, as the primary package interrupt controlle=
r which
> >    can route local I/O interrupt to interrupt lines of cores.
> > +  Be aware of the following points.
> > +  1.The Loongson-2K0500 is a single core CPU, the isr1 register could =
not be defined;
> > +  2.The Loongson-2K0500/2K1000 has 64 device interrupt sources as inpu=
ts, so we
> > +    need to define two nodes in dts{i} to describe the "0-31" and "32-=
61" interrupt
> > +    sources respectively.
> >
> >  allOf:
> >    - $ref: /schemas/interrupt-controller.yaml#
> > @@ -29,10 +34,14 @@ properties:
> >      maxItems: 3
> >
> >    reg-names:
> > -    items:
> > -      - const: main
> > -      - const: isr0
> > -      - const: isr1
> > +    oneOf:
> > +      - items:
> > +          - const: main
> > +          - const: isr0
> > +      - items:
> > +          - const: main
> > +          - const: isr0
> > +          - const: isr1
>
> Just adding 'minItems: 2' accomplishes the same thing without
> duplicating the list.

OK, I will do it.

Thanks.
Binbin
>
> >
> >    interrupt-controller: true
> >
> > @@ -94,7 +103,8 @@ if:
> >  then:
> >    properties:
> >      reg:
> > -      minItems: 3
> > +      minItems: 2
> > +      maxItems: 3
> >
> >    required:
> >      - reg-names
> > --
> > 2.39.3
> >

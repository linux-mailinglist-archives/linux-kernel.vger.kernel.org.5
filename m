Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 871C07CFF53
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 18:20:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233090AbjJSQUg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 12:20:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232815AbjJSQUb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 12:20:31 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8185A126
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 09:20:28 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id 38308e7fff4ca-2c515527310so77433921fa.2
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 09:20:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1697732427; x=1698337227; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qrm2o2CouYl5YLE22rhN3Rv3HCs9/q81TyWZQXS7LNY=;
        b=rgIYVI0YzUrZFRsTOXtETtc+0scSLXuX4kKixp9RQ5l3akUvciWnZWIVUOys3BcXWr
         NeY08K+o9LoRBt6DBrTZufhB6JmXa778VSqjMHHhDM7dwZOJTWeSwR585UhlM07wMvqn
         YFfcDj3Dt06Cgu191TI3GvRfOa+Rw2Wibdk6V6aNmM0J5sKq5tAGJI4uFXm2ixaCsQnh
         3N7LDyykUGg2b+AP3ENezy4kwKZ9CBSZQxcEDEIZZYoz5ZHrRwg36sfqLzdL/Gea8dYD
         0tEML5K6OykE9bp0TU+PoYiPfgWbJ0bC1BpU0vRHaSPOGStb8Nj/XQQYry9lC1icwvJa
         Sibg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697732427; x=1698337227;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qrm2o2CouYl5YLE22rhN3Rv3HCs9/q81TyWZQXS7LNY=;
        b=TFSAL8yx9R+qlrH38lkCJ6SC+OOF6izmqiprMcCrHQ6mCSDkjDmNQOoS0RyyLaZ/v/
         yMcjgbCnpsaYnspPE+50FfOV9EmRAOmIVzvvuF8xFEiVbgSfO4JI2S8p15BWxZS0Oiye
         HYDoy4r2PlzG7PC/FwRPdXEKrnHf0Gx03Ga+Zm+iFOMKV//pzstJAuJzBw2d+qKqNwVF
         AEO5aNmbEmYcVsTpb1tZCLipfjtB6hIUfYKWT0/5F9SolGdu6Ucc2dMb+8gkBQ47HyfA
         bE3DQET9QNH9WmY00eRYP+NqJ9vt+XyFWPpdO1GupLL7k5Q8IMN8RgtJFPW/vpQEDHyJ
         FLiQ==
X-Gm-Message-State: AOJu0YyaW5WqBWW0HwHG8yv5mI07QbkE5DMivER7Ve/l/VIaxvW51t26
        ec84AFLuCRfqYeqRQmTMQHPlvz3id3HaO9eLgwyz5g==
X-Google-Smtp-Source: AGHT+IFeGNG5q6szxOX/FPqL0Y3ufmTudG0k4yvHQ1DfND20U12w+mTgZpBmFwRnmFqy/K+L4mODOLYtPEbzy6qWDHo=
X-Received: by 2002:a2e:9d0c:0:b0:2bc:b557:cee9 with SMTP id
 t12-20020a2e9d0c000000b002bcb557cee9mr1761152lji.43.1697732426653; Thu, 19
 Oct 2023 09:20:26 -0700 (PDT)
MIME-Version: 1.0
References: <20231017131456.2053396-1-cleger@rivosinc.com> <20231017131456.2053396-6-cleger@rivosinc.com>
 <DA8B4610-D514-4733-B875-C247FFCCC7AA@sifive.com> <af785f0f-9de7-4548-9cdb-f392cde1cc2b@rivosinc.com>
 <CALs-HstEBt-ntCcETa9YwS6On3nGyoEc2p7R-gaBLG9+aFJL5w@mail.gmail.com>
 <7626f978-e9ea-4f8f-b814-aeac02bd3712@rivosinc.com> <20231019-nuclear-vista-ef3e0b9bef71@spud>
In-Reply-To: <20231019-nuclear-vista-ef3e0b9bef71@spud>
From:   Evan Green <evan@rivosinc.com>
Date:   Thu, 19 Oct 2023 09:19:50 -0700
Message-ID: <CALs-HssWZyhnbo=ErH+LEfMi4m04i39Cw3PGXP1WhCFfSP8G=A@mail.gmail.com>
Subject: Re: [PATCH v2 05/19] riscv: add ISA extension parsing for vector
 crypto extensions
To:     Conor Dooley <conor@kernel.org>
Cc:     =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>,
        Jerry Shih <jerry.shih@sifive.com>,
        linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Jonathan Corbet <corbet@lwn.net>,
        Andrew Jones <ajones@ventanamicro.com>,
        Samuel Ortiz <sameo@rivosinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 19, 2023 at 8:33=E2=80=AFAM Conor Dooley <conor@kernel.org> wro=
te:
>
> On Thu, Oct 19, 2023 at 11:35:59AM +0200, Cl=C3=A9ment L=C3=A9ger wrote:
> >
> >
> > On 18/10/2023 19:26, Evan Green wrote:
> > > On Wed, Oct 18, 2023 at 5:53=E2=80=AFAM Cl=C3=A9ment L=C3=A9ger <cleg=
er@rivosinc.com> wrote:
> > >>
> > >>
> > >>
> > >> On 18/10/2023 03:45, Jerry Shih wrote:
> > >>> On Oct 17, 2023, at 21:14, Cl=C3=A9ment L=C3=A9ger <cleger@rivosinc=
.com> wrote:
> > >>>> @@ -221,6 +261,22 @@ const struct riscv_isa_ext_data riscv_isa_ext=
[] =3D {
> > >>>>      __RISCV_ISA_EXT_DATA(zkt, RISCV_ISA_EXT_ZKT),
> > >>>>      __RISCV_ISA_EXT_DATA(zksed, RISCV_ISA_EXT_ZKSED),
> > >>>>      __RISCV_ISA_EXT_DATA(zksh, RISCV_ISA_EXT_ZKSH),
> > >>>> +    __RISCV_ISA_EXT_DATA(zvbb, RISCV_ISA_EXT_ZVBB),
> > >>>> +    __RISCV_ISA_EXT_DATA(zvbc, RISCV_ISA_EXT_ZVBC),
> > >>>> +    __RISCV_ISA_EXT_DATA(zvkb, RISCV_ISA_EXT_ZVKB),
> > >>>
> > >>> The `Zvkb` is the subset of `Zvbb`[1]. So, the `Zvkb` should be bun=
dled with `Zvbb`.
> > >>
> > >> Hi Jerry,
> > >>
> > >> Thanks for catching this, I think some other extensions will fall in
> > >> this category as well then (Zvknha/Zvknhb). I will verify that.
> > >
> > > The bundling mechanism works well when an extension is a pure lasso
> > > around other extensions. We'd have to tweak that code if we wanted to
> > > support cases like this, where the extension is a superset of others,
> > > but also contains loose change not present anywhere else (and
> > > therefore also needs to stand as a separate bit).
> >
> > For Zvbb and Zvknhb, I used the following code:
> >
> > static const unsigned int riscv_zvbb_bundled_exts[] =3D {
> >       RISCV_ISA_EXT_ZVKB,
> >       RISCV_ISA_EXT_ZVBB
> > };
> >
> > static const unsigned int riscv_zvknhb_bundled_exts[] =3D {
> >       RISCV_ISA_EXT_ZVKNHA,
> >       RISCV_ISA_EXT_ZVKNHB
> > };
> >
> > Which correctly results in both extension (superset + base set) being
> > enabled when only one is set. Is there something that I'm missing ?
> >
> > >
> > > IMO, decomposing "pure" bundles makes sense since otherwise usermode
> > > would have to query multiple distinct bitmaps that meant the same
> > > thing (eg check the Zk bit, or maybe check the Zkn/Zkr/Zkt bits, or
> > > maybe check the Zbkb/Zbkc... bits, and they're all equivalent). But
> > > when an extension is a superset that also contains loose change, ther=
e
> > > really aren't two equivalent bitmasks, each bit adds something new.
> >
> > Agreed but if a system only report ZVBB for instance and the user wants
> > ZVKB, then it is clear that ZVKB should be reported as well I guess. So
> > in the end, it works much like "bundle" extension, just that the bundle
> > is actually a "real" ISA extension by itself.
> >
> > Cl=C3=A9ment
> >
> > >
> > > There's an argument to be made for still turning on the containing
> > > extensions to cover for silly ISA strings (eg ISA strings that
> > > advertise the superset but fail to advertise the containing
> > > extensions). We can decide if we want to work that hard to cover
> > > hypothetical broken ISA strings now, or wait until they show up.
> > > Personally I would wait until something broken shows up. But others
> > > may feel differently.
>
> I'm not really sure that those are "silly" ISA strings. People are going
> to do it that way because it is much easier than spelling out 5 dozen
> sub-components, and it is pretty inevitable that subsets will be
> introduced in the future for extensions we currently have.
>
> IMO, it's perfectly valid to say you have the supersets and not spell
> out all the subcomponents.

Hm, ok. If ISA strings are likely to be written that way, then I agree
having the kernel flip on all the contained extensions is a good idea.
We can tweak patch 2 to support the parsing of struct
riscv_isa_ext_data with both .id and .bundle_size set (instead of only
one or the other as it is now). Looking back at that patch, it looks
quite doable. Alright!

-Evan

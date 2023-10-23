Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 258FE7D3C2A
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 18:19:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233768AbjJWQTd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 12:19:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233734AbjJWQTU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 12:19:20 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEE8D10EF
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 09:18:52 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2c51f5a1ecdso51245911fa.0
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 09:18:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1698077931; x=1698682731; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XRXdY69ZBlfM0xKWt8N1W/8lTqIPJNkG639XQiTfSsI=;
        b=tYo/n7OTaZleiNSLBs2Dk0pH/LSlpQUT4dIxMSkFy73ttBnLaHfPCg+Y+PrKH8z2SP
         YpLHhTRkzt0FF6Pi42k0ahQBasdTR/XG0+ZWWkkvkG7pw3tV9xF5OJeyjOrBUxzAwFRy
         PQhlSO0nQMLm/xP/gE+Kr6Z3VRmb3Qftmn1rN3ZBzIyEgX0z1cfe9qVANZfouV3PThBC
         LBs9cjwvXU1g8NOI0YWlDnEBXsEXhjWW8ec1oyJq1KE2VMHW5HvaHb1SnCby8vFw+nuu
         ihvzXFvaWNATidtMDwkBRnMGzz0Tlch5/lB5/SVQ5DzDlZ0FURwxcUpka0jGtMnBIDNG
         psWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698077931; x=1698682731;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XRXdY69ZBlfM0xKWt8N1W/8lTqIPJNkG639XQiTfSsI=;
        b=cREA0w5u1/mFCz2go87jaqDMfZtEreHmRa43uzLkUzAOwjoxvtRXdvwFeDtpwHjgHF
         e7kHEfm9cOWQYRCb6ORqKh1spCVxvRVHsdVfiZ7Bf60AuwSUy7QoNwqn40GTBH+Y2Rzp
         PlA04hS833HQD8kYDGnXQqebm1evoOUyueLnYWTtI4YPimjWRvRLQWxykvM710w2C6Gh
         sK7KIrlLIHvIzZMAhMQPdV2nfG4AJDwJOvo55Ih8nMrpmjo0k549sIgKX3hCncoupY5S
         j2wBnxZLW3IIcVtKicJXV2wZkhXIESZ5wnoSjkisy+/v4SmIvXh6DVM5fZxuibE9meCb
         nG7Q==
X-Gm-Message-State: AOJu0YwUERPBGyPOXskpXK6haXrUe906OTXVAqkYXsUA9i36/cxG5zCM
        VVB+qDdOPMy0ZqRZLfyeHVJER6EvhOSd8zVvDk+RCuy5LcnboF0hyKE=
X-Google-Smtp-Source: AGHT+IEQR4YyAihsj0DrI81eI6lmsjNopJ/6ZLCkXxPzRN7txe0u78/wppiLGpoIGQM4MFyMzlNW6OWJW9jSotoMnbY=
X-Received: by 2002:a2e:7e03:0:b0:2c4:fdfa:41c with SMTP id
 z3-20020a2e7e03000000b002c4fdfa041cmr4091293ljc.0.1698077930651; Mon, 23 Oct
 2023 09:18:50 -0700 (PDT)
MIME-Version: 1.0
References: <20231017131456.2053396-1-cleger@rivosinc.com> <20231017131456.2053396-6-cleger@rivosinc.com>
 <DA8B4610-D514-4733-B875-C247FFCCC7AA@sifive.com> <af785f0f-9de7-4548-9cdb-f392cde1cc2b@rivosinc.com>
 <CALs-HstEBt-ntCcETa9YwS6On3nGyoEc2p7R-gaBLG9+aFJL5w@mail.gmail.com>
 <7626f978-e9ea-4f8f-b814-aeac02bd3712@rivosinc.com> <20231019-nuclear-vista-ef3e0b9bef71@spud>
 <CALs-HssWZyhnbo=ErH+LEfMi4m04i39Cw3PGXP1WhCFfSP8G=A@mail.gmail.com> <3f383b96-87ae-4580-a23d-0196bbd8ec91@rivosinc.com>
In-Reply-To: <3f383b96-87ae-4580-a23d-0196bbd8ec91@rivosinc.com>
From:   Evan Green <evan@rivosinc.com>
Date:   Mon, 23 Oct 2023 09:18:14 -0700
Message-ID: <CALs-Hst8NLeD649+-Za=U7Awx+=SuELz--rSGqyqHpn8gzAQrg@mail.gmail.com>
Subject: Re: [PATCH v2 05/19] riscv: add ISA extension parsing for vector
 crypto extensions
To:     =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>
Cc:     Conor Dooley <conor@kernel.org>,
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
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 23, 2023 at 12:24=E2=80=AFAM Cl=C3=A9ment L=C3=A9ger <cleger@ri=
vosinc.com> wrote:
>
>
>
> On 19/10/2023 18:19, Evan Green wrote:
> > On Thu, Oct 19, 2023 at 8:33=E2=80=AFAM Conor Dooley <conor@kernel.org>=
 wrote:
> >>
> >> On Thu, Oct 19, 2023 at 11:35:59AM +0200, Cl=C3=A9ment L=C3=A9ger wrot=
e:
> >>>
> >>>
> >>> On 18/10/2023 19:26, Evan Green wrote:
> >>>> On Wed, Oct 18, 2023 at 5:53=E2=80=AFAM Cl=C3=A9ment L=C3=A9ger <cle=
ger@rivosinc.com> wrote:
> >>>>>
> >>>>>
> >>>>>
> >>>>> On 18/10/2023 03:45, Jerry Shih wrote:
> >>>>>> On Oct 17, 2023, at 21:14, Cl=C3=A9ment L=C3=A9ger <cleger@rivosin=
c.com> wrote:
> >>>>>>> @@ -221,6 +261,22 @@ const struct riscv_isa_ext_data riscv_isa_ex=
t[] =3D {
> >>>>>>>      __RISCV_ISA_EXT_DATA(zkt, RISCV_ISA_EXT_ZKT),
> >>>>>>>      __RISCV_ISA_EXT_DATA(zksed, RISCV_ISA_EXT_ZKSED),
> >>>>>>>      __RISCV_ISA_EXT_DATA(zksh, RISCV_ISA_EXT_ZKSH),
> >>>>>>> +    __RISCV_ISA_EXT_DATA(zvbb, RISCV_ISA_EXT_ZVBB),
> >>>>>>> +    __RISCV_ISA_EXT_DATA(zvbc, RISCV_ISA_EXT_ZVBC),
> >>>>>>> +    __RISCV_ISA_EXT_DATA(zvkb, RISCV_ISA_EXT_ZVKB),
> >>>>>>
> >>>>>> The `Zvkb` is the subset of `Zvbb`[1]. So, the `Zvkb` should be bu=
ndled with `Zvbb`.
> >>>>>
> >>>>> Hi Jerry,
> >>>>>
> >>>>> Thanks for catching this, I think some other extensions will fall i=
n
> >>>>> this category as well then (Zvknha/Zvknhb). I will verify that.
> >>>>
> >>>> The bundling mechanism works well when an extension is a pure lasso
> >>>> around other extensions. We'd have to tweak that code if we wanted t=
o
> >>>> support cases like this, where the extension is a superset of others=
,
> >>>> but also contains loose change not present anywhere else (and
> >>>> therefore also needs to stand as a separate bit).
> >>>
> >>> For Zvbb and Zvknhb, I used the following code:
> >>>
> >>> static const unsigned int riscv_zvbb_bundled_exts[] =3D {
> >>>       RISCV_ISA_EXT_ZVKB,
> >>>       RISCV_ISA_EXT_ZVBB
> >>> };
> >>>
> >>> static const unsigned int riscv_zvknhb_bundled_exts[] =3D {
> >>>       RISCV_ISA_EXT_ZVKNHA,
> >>>       RISCV_ISA_EXT_ZVKNHB
> >>> };
> >>>
> >>> Which correctly results in both extension (superset + base set) being
> >>> enabled when only one is set. Is there something that I'm missing ?
> >>>
> >>>>
> >>>> IMO, decomposing "pure" bundles makes sense since otherwise usermode
> >>>> would have to query multiple distinct bitmaps that meant the same
> >>>> thing (eg check the Zk bit, or maybe check the Zkn/Zkr/Zkt bits, or
> >>>> maybe check the Zbkb/Zbkc... bits, and they're all equivalent). But
> >>>> when an extension is a superset that also contains loose change, the=
re
> >>>> really aren't two equivalent bitmasks, each bit adds something new.
> >>>
> >>> Agreed but if a system only report ZVBB for instance and the user wan=
ts
> >>> ZVKB, then it is clear that ZVKB should be reported as well I guess. =
So
> >>> in the end, it works much like "bundle" extension, just that the bund=
le
> >>> is actually a "real" ISA extension by itself.
> >>>
> >>> Cl=C3=A9ment
> >>>
> >>>>
> >>>> There's an argument to be made for still turning on the containing
> >>>> extensions to cover for silly ISA strings (eg ISA strings that
> >>>> advertise the superset but fail to advertise the containing
> >>>> extensions). We can decide if we want to work that hard to cover
> >>>> hypothetical broken ISA strings now, or wait until they show up.
> >>>> Personally I would wait until something broken shows up. But others
> >>>> may feel differently.
> >>
> >> I'm not really sure that those are "silly" ISA strings. People are goi=
ng
> >> to do it that way because it is much easier than spelling out 5 dozen
> >> sub-components, and it is pretty inevitable that subsets will be
> >> introduced in the future for extensions we currently have.
> >>
> >> IMO, it's perfectly valid to say you have the supersets and not spell
> >> out all the subcomponents.
> >
> > Hm, ok. If ISA strings are likely to be written that way, then I agree
> > having the kernel flip on all the contained extensions is a good idea.
> > We can tweak patch 2 to support the parsing of struct
> > riscv_isa_ext_data with both .id and .bundle_size set (instead of only
> > one or the other as it is now). Looking back at that patch, it looks
> > quite doable. Alright!
>
> Hey Evan,
>
> do you have anything against using this code:
>
> static const unsigned int riscv_zvbb_bundled_exts[] =3D {
>         RISCV_ISA_EXT_ZVKB,
>         RISCV_ISA_EXT_ZVBB
> };
>
> ...
>
> Then declaring zvbb like that:
>
> __RISCV_ISA_EXT_BUNDLE(zvbb, riscv_zvbb_bundled_exts),
>
> I agree that it is *not* a bundled extension but it actually already
> works with Conor's code. Not sure that adding more code is needed to
> handle that case.

Ah, I had missed that Zvbb was in Zvbb's own bundle. I see now that it
works, but it also feels a bit like we're working around our own code.

An alternate way, which you can decide if you like better, would be a
new macro (something like __RISCV_ISA_EXT_DATA_BUNDLE(), but better
names welcome) that allows setting both .id and .bundle_size. Then the
else-if in match_isa_ext() could just turn into two independent ifs.
You'd have to define an "invalid" value for .id, since 0 is 'a', but
that should be straightforward. Or maybe jiggle things around a bit so
0 is invalid and 'a' is 1.

-Evan

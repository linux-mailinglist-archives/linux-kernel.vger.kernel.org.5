Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88D487CF011
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 08:27:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232676AbjJSG1e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 02:27:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229894AbjJSG1b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 02:27:31 -0400
Received: from mail-oo1-xc36.google.com (mail-oo1-xc36.google.com [IPv6:2607:f8b0:4864:20::c36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77465BE
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 23:27:29 -0700 (PDT)
Received: by mail-oo1-xc36.google.com with SMTP id 006d021491bc7-57b5f0d658dso4442877eaf.0
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 23:27:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697696849; x=1698301649; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y+5ze7EgUmEoyOeU1Hr4G9W5HRmWQeRvGRnsz9mRHI8=;
        b=Y1T3lq8LfGBKDVIhobIboKPeE05t+a8Ui5JTnlF7VgMa1tjZxkm8/KacwYvTUAgwgY
         dxo7ZErv8OIDemy5+4+J585owI4lLpPRZ7Q5j0axc02w+YmvkCUiimhAR0lR/3zPVzWI
         LmRoq6hXCpoD+7qB6eRNqlI/imV3DMf2+9rBEU2a7uf5m/2I6RY3iTIrYlZaur683i4Z
         n6ydfqUVHZAHIx2TZmRSjOHSTUR13wEK5JFNef+oAOsT5QVSJUBsguw+4T8HECK0Xkab
         2vYj3Ix2doWgr6+vGQW8SYIxwBX51zqsJgv4fTdlT0MgWZMVj46FivZaM6rNK1JOOPI3
         w3fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697696849; x=1698301649;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y+5ze7EgUmEoyOeU1Hr4G9W5HRmWQeRvGRnsz9mRHI8=;
        b=cxqRjQEWnbh/W6Np/Qlw0AwNf47ZMHqYNk5Fb+JCPklxGJtHcvQvrLEwZ26Ji87hkK
         SN59c/QPHzNyvcA7Ao33/dE4OGLtyHUNaa8Q7P6ZVfB8sq3E+uamwrR+ToC1NiKcuUy1
         qecuwYPs/C2nftLMMDdiccmQ/SMuogA4/bWouZBIjLiCVJDkRzhlavMKuMuKzRxNN3Am
         t4R9lnHS3WM8ha8dQk4aTCiMlsumbhZSbWMSQ6fmelnkZ3vLBFgk9/9SjYK7Q7LT5zOO
         ZwaKHVeywYKSfxw2zRMuDaXxd5RgXSuH85Ab6l1Kul2Ht3pV+KcFcUG6b/uSGdf2lryx
         t/uA==
X-Gm-Message-State: AOJu0YwTKzDHLQPfRG3QxF3wXD51DnW2vHSVU6bvxFrB5F7Cz4Sdf0bO
        ivQsw1Ixh+0akfUTUZzzenzfyIpD0+JcHYHvHM0=
X-Google-Smtp-Source: AGHT+IEGy8I/zxrKECMqzHdVNgbQn02aN0QYgQK2POOraxlrYumj3TO2k7y/hknwuydp7D6I5lIhg5458b6LVoLSUcw=
X-Received: by 2002:a05:6870:7908:b0:1ea:2162:a898 with SMTP id
 hg8-20020a056870790800b001ea2162a898mr1655139oab.16.1697696848643; Wed, 18
 Oct 2023 23:27:28 -0700 (PDT)
MIME-Version: 1.0
References: <20230925131720.7672-1-mark-pk.tsai@mediatek.com> <7e68377e780a2f4312a69ce8afda0cda8ad84568.camel@mediatek.com>
In-Reply-To: <7e68377e780a2f4312a69ce8afda0cda8ad84568.camel@mediatek.com>
From:   Xuewen Yan <xuewen.yan94@gmail.com>
Date:   Thu, 19 Oct 2023 14:27:17 +0800
Message-ID: <CAB8ipk8ELiSYc7z-wyrnD68UnfF6uQe=XDG5BYsXYPDrR2Z08Q@mail.gmail.com>
Subject: Re: [PATCH v2] ARM: vfp: Add missing VFP instructions to neon_support_hook
To:     =?UTF-8?B?TWFyay1QSyBUc2FpICjolKHmspvliZsp?= 
        <Mark-PK.Tsai@mediatek.com>
Cc:     "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "xuewen.yan@unisoc.com" <xuewen.yan@unisoc.com>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        =?UTF-8?B?WUogQ2hpYW5nICjmsZ/oi7HmnbAp?= <yj.chiang@mediatek.com>,
        =?UTF-8?B?546L56eRIChLZSBXYW5nKQ==?= <Ke.Wang@unisoc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 11, 2023 at 10:51=E2=80=AFAM Mark-PK Tsai (=E8=94=A1=E6=B2=9B=
=E5=89=9B)
<Mark-PK.Tsai@mediatek.com> wrote:
>
> On Mon, 2023-09-25 at 21:17 +0800, Mark-PK Tsai wrote:
> > Add the missing "Unconditional Advanced SIMD and floating-point
> > instructions" in [1] to the VFP undef hook.
> >
> > This commit addresses the issue reported in [2], where
> > executing the vudot instruction on a platform with FEAT_DotProd
> > support resulted in an undefined instruction error.
> >
> > Link:
> > https://developer.arm.com/documentation/ddi0597/2023-06/?lang=3Den [1]
> > Link:
> > https://lore.kernel.org/lkml/20230920083907.30479-1-mark-pk.tsai@mediat=
ek.com/
> >  [2]
> > Signed-off-by: Mark-PK Tsai <mark-pk.tsai@mediatek.com>
> > ---
> >  arch/arm/vfp/vfpmodule.c | 18 ++++++++++++++++++
> >  1 file changed, 18 insertions(+)
> >
> > diff --git a/arch/arm/vfp/vfpmodule.c b/arch/arm/vfp/vfpmodule.c
> > index 7e8773a2d99d..b68efe643a12 100644
> > --- a/arch/arm/vfp/vfpmodule.c
> > +++ b/arch/arm/vfp/vfpmodule.c
> > @@ -800,6 +800,24 @@ static struct undef_hook neon_support_hook[] =3D
> > {{
> >       .cpsr_mask      =3D PSR_T_BIT,
> >       .cpsr_val       =3D PSR_T_BIT,
> >       .fn             =3D vfp_support_entry,
> > +}, {
> > +     .instr_mask     =3D 0xff000800,
> > +     .instr_val      =3D 0xfc000800,
> > +     .cpsr_mask      =3D 0,
> > +     .cpsr_val       =3D 0,
> > +     .fn             =3D vfp_support_entry,
> > +}, {
> > +     .instr_mask     =3D 0xff000800,
> > +     .instr_val      =3D 0xfd000800,
> > +     .cpsr_mask      =3D 0,
> > +     .cpsr_val       =3D 0,
> > +     .fn             =3D vfp_support_entry,
> > +}, {
> > +     .instr_mask     =3D 0xff000800,
> > +     .instr_val      =3D 0xfe000800,
> > +     .cpsr_mask      =3D 0,
> > +     .cpsr_val       =3D 0,
> > +     .fn             =3D vfp_support_entry,
> >  }};
>
> Could someone please kindly review this patch?
> Thanks.

I tested on unisoc sharkl3 platform, and no problems occurred.

Tested-by: Xuewen Yan <xuewen.yan@unisoc.com>

Thanks!

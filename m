Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 559E4804BD8
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 09:08:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344725AbjLEIIC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 03:08:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231722AbjLEIIB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 03:08:01 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98D11183
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 00:08:06 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CAFAC433C9
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 08:08:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701763686;
        bh=1SaNPcpTvqhPELifdtDbm5KjpDsvdHexEdnN4bNkT1w=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=WVB0txdlB/PII8u+JWwqWohe+Xdo2Xd4fO3GiWSrdL3JHWvjfQWZH3kl1chOH9YSX
         oD20tH/4Ket2SFItDrH3/B2kWWvOUcdW6LlOIijU6QZlk7C4ncZ3LJDaeMzBnuJ7uy
         W4z0cQJSauySwz/J9kA4iNKMMH3EgYtnNh/qoCff8VSU0J5AXK7in71nRdKBCTrGTS
         KfpK4RpkdAS2gQt/CaRF9JcneTt8UzHPaCYITRPWOvTpAkoFG5YrTiCm70QUMvKkXL
         GUn1G4QOhwgd/GN8JfZvPwdJnNa7Yq16Nzy5qQz6KhXEpBI4PSBwcynrW+KSSh4yfq
         BVEvYv82682Ng==
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a1b68ae40f0so189922466b.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Dec 2023 00:08:06 -0800 (PST)
X-Gm-Message-State: AOJu0YzifdT6tzOaYKXrdTij39hpQ/SNjdpDHcHjDNLO/PRVEBTfrOsl
        HbTy6Zk/1NKFQupdtYuRalYUEUsdZ41yo59/xVg=
X-Google-Smtp-Source: AGHT+IF5h7sOY+PGcWGXM2uE3+7k55Wx3WpqxitMeMg7B30Raz3zx6W51g+pEY5WgMg4wzBsoPETTuvtXHChDweVXnk=
X-Received: by 2002:a17:906:b39a:b0:9da:ee00:a023 with SMTP id
 uh26-20020a170906b39a00b009daee00a023mr225917ejc.30.1701763684594; Tue, 05
 Dec 2023 00:08:04 -0800 (PST)
MIME-Version: 1.0
References: <20231126121727.47303-2-xry111@xry111.site> <369bce8101f2db6685c0e2446976eb7ea16510eb.camel@xry111.site>
In-Reply-To: <369bce8101f2db6685c0e2446976eb7ea16510eb.camel@xry111.site>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Tue, 5 Dec 2023 16:07:52 +0800
X-Gmail-Original-Message-ID: <CAAhV-H4ELPjUgNOGQiU8o6zBAcE4=9JRLyoFcQprhGMrTBhd-A@mail.gmail.com>
Message-ID: <CAAhV-H4ELPjUgNOGQiU8o6zBAcE4=9JRLyoFcQprhGMrTBhd-A@mail.gmail.com>
Subject: Re: Ping: [PATCH] LoongArch: Slightly clean up drdtime
To:     Xi Ruoyao <xry111@xry111.site>
Cc:     WANG Xuerui <kernel@xen0n.name>, loongarch@lists.linux.dev,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Queued, thanks.

Huacai

On Tue, Dec 5, 2023 at 4:01=E2=80=AFPM Xi Ruoyao <xry111@xry111.site> wrote=
:
>
> Ping.
>
> On Sun, 2023-11-26 at 20:17 +0800, Xi Ruoyao wrote:
> > As we are just discarding the stable clock ID, simply write it into
> > $zero instead of allocating a temporary register.
> >
> > Signed-off-by: Xi Ruoyao <xry111@xry111.site>
> > ---
> >  arch/loongarch/include/asm/loongarch.h | 5 ++---
> >  1 file changed, 2 insertions(+), 3 deletions(-)
> >
> > diff --git a/arch/loongarch/include/asm/loongarch.h b/arch/loongarch/in=
clude/asm/loongarch.h
> > index 9b4957cefa8a..46366e783c84 100644
> > --- a/arch/loongarch/include/asm/loongarch.h
> > +++ b/arch/loongarch/include/asm/loongarch.h
> > @@ -1098,12 +1098,11 @@
> >
> >  static __always_inline u64 drdtime(void)
> >  {
> > -     int rID =3D 0;
> >       u64 val =3D 0;
> >
> >       __asm__ __volatile__(
> > -             "rdtime.d %0, %1 \n\t"
> > -             : "=3Dr"(val), "=3Dr"(rID)
> > +             "rdtime.d %0, $zero\n\t"
> > +             : "=3Dr"(val)
> >               :
> >               );
> >       return val;
>
> --
> Xi Ruoyao <xry111@xry111.site>
> School of Aerospace Science and Technology, Xidian University

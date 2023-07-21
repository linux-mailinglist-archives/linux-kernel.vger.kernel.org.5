Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBA3075C6CE
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 14:20:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229887AbjGUMUv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 08:20:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbjGUMUu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 08:20:50 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AFDC172A;
        Fri, 21 Jul 2023 05:20:48 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-51f7fb9a944so2631216a12.3;
        Fri, 21 Jul 2023 05:20:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689942047; x=1690546847;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GhutenQMqQXRKvlycCuev0WyjWyoJHPkw6hmgTsPeaU=;
        b=bzBI9LhEsvYKVapzRLbcZ4+OQHAOroIvvBL6jwI/E0l9G33N01mIX5iwX+nPmDaALm
         qY1kpqgjGacFeDuIkKaY4b8VEbv86y4PLN79Ng3rzjeRB+PPbj5ezxVE50SzNt60iiUp
         0tQvXk5uSdMQrrRejEAhrh4BmdNl+xxkFA3jWsUH2fEOLt7ZVV0ZxaO+R02CSZ0Q0SFn
         H0ag8UENgWLzKZuHXHBiJ1g6OJ3gP/KTR5P17SgLjOTKsC+8SDeB9WYsLNou15xeaMS+
         UD4VSTxFM9nzEMc3AwhZsyjeSNTRHIiBKnLg2b1TuJQYdVfXswIadCXuY8XQtlQOkvrm
         PWpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689942047; x=1690546847;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GhutenQMqQXRKvlycCuev0WyjWyoJHPkw6hmgTsPeaU=;
        b=etRZqyDG3w2+2kPBAghT+k7PGJNMm24FR6YvucSqPGkOjRIZsgO8iZFiCRtcHKvQ8H
         CL8EXNsV4PL/a+JIGBsSGLX0cE6inFinJTokwBNidUih6wA6KJUq49Xz94aOPo1fSNcI
         /JzhHceeDkqHXX0rRXWo5sioqiuf30zBvMgD1mf4HU9zVd2W5XtqPPIqfwB6hET41KFq
         0uFGhRpHv8AS1B5BCvbZivkF5tIkAb1QLagKRU/Bo3KfZug0rHYI6KkbL184n/fFkMOx
         hGu/jhSG60U/tFtI8Lquazr3wf18ydUe0n1ASuv87yLy+p6v/JCYljfb1K+vgA1NSqcp
         Z9Mg==
X-Gm-Message-State: ABy/qLbZrfVSUtAmRuneYI7AIRhljXwK/PUIrx6155LXToBIS6MmpRt0
        I5dUjd7ssbm4+FzM8hYL/98=
X-Google-Smtp-Source: APBJJlGQAAFcby9zYkQelrjbstvhZTVwHFKUPWV90xlctOVdzmio0HgLdbFiI8HMbn5+O3IOKV/jwQ==
X-Received: by 2002:a05:6402:887:b0:51d:d2b9:54a0 with SMTP id e7-20020a056402088700b0051dd2b954a0mr1385265edy.2.1689942046817;
        Fri, 21 Jul 2023 05:20:46 -0700 (PDT)
Received: from orome (p200300e41f1bd600f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f1b:d600:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id l23-20020a056402345700b00521d2cf5f3bsm2040009edc.96.2023.07.21.05.20.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jul 2023 05:20:46 -0700 (PDT)
Date:   Fri, 21 Jul 2023 14:20:44 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Lee Jones <lee@kernel.org>
Cc:     Arnd Bergmann <arnd@kernel.org>,
        William Breathitt Gray <william.gray@linaro.org>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Peter Robinson <pbrobinson@gmail.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pwm@vger.kernel.org
Subject: Re: [PATCH] mfd: rz-mtu3: link time dependencies
Message-ID: <ZLp4HPwcDxcKHAwj@orome>
References: <20230719090430.1925182-1-arnd@kernel.org>
 <ZLlMAZPzEmSlzlbV@orome>
 <20230721080055.GB1908841@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="+OUlY8rAj1w6C2U+"
Content-Disposition: inline
In-Reply-To: <20230721080055.GB1908841@google.com>
User-Agent: Mutt/2.2.10 (2023-03-25)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--+OUlY8rAj1w6C2U+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 21, 2023 at 09:00:55AM +0100, Lee Jones wrote:
> On Thu, 20 Jul 2023, Thierry Reding wrote:
>=20
> > On Wed, Jul 19, 2023 at 11:02:23AM +0200, Arnd Bergmann wrote:
> > > From: Arnd Bergmann <arnd@arndb.de>
> > >=20
> > > The new set of drivers for RZ/G2L MTU3a tries to enable compile-testi=
ng the
> > > individual client drivers even when the MFD portion is disabled but g=
ets it
> > > wrong, causing a link failure when the core is in a loadable module b=
ut the
> > > other drivers are built-in:
> > >=20
> > > x86_64-linux-ld: drivers/pwm/pwm-rz-mtu3.o: in function `rz_mtu3_pwm_=
apply':
> > > pwm-rz-mtu3.c:(.text+0x4bf): undefined reference to `rz_mtu3_8bit_ch_=
write'
> > > x86_64-linux-ld: pwm-rz-mtu3.c:(.text+0x509): undefined reference to =
`rz_mtu3_disable'
> > >=20
> > > arm-linux-gnueabi-ld: drivers/counter/rz-mtu3-cnt.o: in function `rz_=
mtu3_cascade_counts_enable_get':
> > > rz-mtu3-cnt.c:(.text+0xbec): undefined reference to `rz_mtu3_shared_r=
eg_read'
> > >=20
> > > It seems better not to add the extra complexity here but instead just=
 use
> > > a normal hard dependency, so remove the #else portion in the header a=
long
> > > with the "|| COMPILE_TEST". This could also be fixed by having slight=
ly more
> > > elaborate Kconfig dependencies or using the cursed 'IS_REACHABLE()' h=
elper,
> > > but in practice it's already possible to compile-test all these drive=
rs
> > > by enabling the mtd portion.
> > >=20
> > > Fixes: 254d3a727421c ("pwm: Add Renesas RZ/G2L MTU3a PWM driver")
> > > Fixes: 0be8907359df4 ("counter: Add Renesas RZ/G2L MTU3a counter driv=
er")
> > > Fixes: 654c293e1687b ("mfd: Add Renesas RZ/G2L MTU3a core driver")
> > > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > > ---
> > >  drivers/counter/Kconfig     |  2 +-
> > >  drivers/pwm/Kconfig         |  2 +-
> > >  include/linux/mfd/rz-mtu3.h | 66 -----------------------------------=
--
> > >  3 files changed, 2 insertions(+), 68 deletions(-)
> >=20
> > Assuming that Lee will pick this up:
> >=20
> > Acked-by: Thierry Reding <thierry.reding@gmail.com>
>=20
> Happy to.  Can you do without a pull-request?

Yeah, I don't think a PR will be necessary.

Thierry

--+OUlY8rAj1w6C2U+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmS6eBkACgkQ3SOs138+
s6GBrhAAngOgSPqJgj9r/xBFsagBuifgLM/cGHmnJ6s8YfMI06dUmw1qxd6EvDE3
RpmEKA0NceA9lB17XZyH5kyaoowHumWgQA+sG5CzhwPnWnCywo3spfBZf7k4EZH2
3BNIUDt4Ix+06pdkNKd7QVPqUU6Vr/vXc/kfqs78E4IdA3C6oj8duLK3ex/sk2ih
f+cHedeIujBVONaBj/Pz6q9x6iBTpCh4QAhVoGSMwBjyIVJ6g9cVuxKi9BoVcJ/D
4eIOsp6HSxF/DB9YfnS4dRQ16eGZTqtImkLDg9EjRWBNCvtKwrBVwq3rXdKniiyl
v1aXjCvZpMJqY6OqAKNoBBKpHIb2SYjR2r+TmyYN9OOkhp7xnfuHDcpi4A+HTOaS
tzoLrVNDeyrmtP72syZ7C750EP6QDrCihmKy9MOJWEq6H8yX4EetwDOyX3WHLfMJ
dyA78V3E8aLHmoBplf2m5WpB0zMzLw8uewlFtNY0yCFW1L3OZcA09skMInHokh82
/kJY1TnAdhNIs03KMxFu++wTymv4F3rD0FJyDFmKIWBRiijuMh7qQfstd4rVOybg
uGDiyNOzM+pPHqdA5e7ldNgSJar3pPaw7Q6qeVRUvxiL2lE4F6Cfe7TO7HyUFtZF
UJ84byyhi9v4vpvt7PJ0ui2q7Ly5TXqM9olgWuYSshvxi2zQxFY=
=fYsf
-----END PGP SIGNATURE-----

--+OUlY8rAj1w6C2U+--

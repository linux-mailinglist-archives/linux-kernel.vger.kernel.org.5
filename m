Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40CC07E0109
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 11:30:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235360AbjKCILs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 04:11:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230094AbjKCILq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 04:11:46 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97AA7123;
        Fri,  3 Nov 2023 01:11:40 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1cc2575dfc7so14999775ad.1;
        Fri, 03 Nov 2023 01:11:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698999100; x=1699603900; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=P1zG46v3yYULs6HTAoiydnarKk6Z7cvMgep7Y/bVUSA=;
        b=hrsRW9/PnUPMA4BcyAKt1FAPndCrlOExvQpO7pxoSbAgNUmDPv9XchtTGPoVojUlGA
         +2IuLNY2HYd1Lyg/La8SSgac4X0ltkOSAiDjpJZzADOdGqaII2AUM0FLKVwkA2lgvPKU
         WiNgiUwSNYTs+WXFmvdz3a1WBa8CT3SaCl67wC8gL5ALabFa/438vRCX75+a0qnqj7p9
         s7nTuz7WOpIr1Qy/cK4UgdKwtTyPHWZj0LxytEdzJHeygcISumxNwU6UQ03G+8Uplq0U
         Y0DS6w1BHZUvgv601jQKUhoIKfdBcAJeSeQrUs+Qb2o66/qQYoHtV5F48ucUxCddUjCo
         YZpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698999100; x=1699603900;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P1zG46v3yYULs6HTAoiydnarKk6Z7cvMgep7Y/bVUSA=;
        b=vDVQCyOoedBAhcqryPOZiGDVKLftTv0VNAPg2W2SYTrpcA4z1PfJFSORo7nqQghtwV
         lC6IMialJ3pfsEP7nAJns8FQNiHnldcwuIvuGSGlqlDy/rpokN+ZBvqynN9c77vyrt+R
         97aBQZSrnOs2jrAKMfrRK9A+1bop9W/gkvldsbWia2LpSKowgDov77rYs9mTqkevcn+5
         RnO5xBDISrjS37XB5bnamFkhciaLzYsWHdwUTPg8F+OSuyCMgmhPBY+csZpqwa3V4bHs
         /5bfMT+rgT6SBMxwOU50onGpc42uBcIwim7L7S0jv3g17pKzhNUPgl0nLcQJTyDfO7Cb
         qqsw==
X-Gm-Message-State: AOJu0YzQcCooaJkrjvfjo8Aua/Omp8JTmufgR91sfpwYwfoFI70o/d8u
        ANZiv65HQEwpeQbijK23eNA=
X-Google-Smtp-Source: AGHT+IGQXuw4znO2Dw4M5l6O2Es9a8zUyaadJePmeZgfYhLn8RpT4NdGcAeG8yODYjMgcMtPTfKFvg==
X-Received: by 2002:a17:902:e0d4:b0:1ca:200b:8dce with SMTP id e20-20020a170902e0d400b001ca200b8dcemr14134555pla.41.1698999099934;
        Fri, 03 Nov 2023 01:11:39 -0700 (PDT)
Received: from debian.me ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id jf6-20020a170903268600b001b03a1a3151sm882657plb.70.2023.11.03.01.11.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Nov 2023 01:11:38 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 7E0EC91C7163; Fri,  3 Nov 2023 15:11:36 +0700 (WIB)
Date:   Fri, 3 Nov 2023 15:11:36 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Documentation <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Akira Yokosawa <akiyks@gmail.com>,
        Stanislav Fomichev <sdf@google.com>,
        David Vernet <void@manifault.com>,
        Miguel Ojeda <ojeda@kernel.org>, James Seo <james@equiv.tech>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Federico Vaga <federico.vaga@vaga.pv.it>,
        Carlos Bilbao <carlos.bilbao@amd.com>,
        linux-spdx@vger.kernel.org, Richard Fontana <rfontana@redhat.com>
Subject: Re: [PATCH RFC 1/4] LICENSES: Add SIL Open Font License 1.1
Message-ID: <ZUSrOKDuvcSL6gOH@debian.me>
References: <20231102120053.30630-1-bagasdotme@gmail.com>
 <20231102120053.30630-2-bagasdotme@gmail.com>
 <2023110222-renewed-monologue-008e@gregkh>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="/KWzKcdL50ByjLLA"
Content-Disposition: inline
In-Reply-To: <2023110222-renewed-monologue-008e@gregkh>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--/KWzKcdL50ByjLLA
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 02, 2023 at 03:06:19PM +0100, Greg Kroah-Hartman wrote:
> On Thu, Nov 02, 2023 at 07:00:43PM +0700, Bagas Sanjaya wrote:
> > Add the license text along with appropriate tags for reference and
> > tooling. The text is taken from the text as distributed in Google
> > Fonts's zip files.
> >=20
> > As the license itself may or may note be compatible with GPLv2,
> > let's take on the err side and require combining it with
> > GPL-compatible licenses when using the license.
> >=20
> > Cc: linux-spdx@vger.kernel.org
> > Cc: Richard Fontana <rfontana@redhat.com>
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
> > ---
> >  LICENSES/dual/OFL-1.1 | 107 ++++++++++++++++++++++++++++++++++++++++++
>=20
> You add this license, but then never actually reference it in the later
> changes, so it's going to be very confusing as to why it is here.  Any
> way to add it to the font files themselves so our checker tools can
> handle this properly?

There is TTF name string ID called "License". For example, on IBM Plex Sans,
the string value is:

```
This Font Software is licensed under the SIL Open Font License, Version 1.1=
=2E This license is available with a FAQ at: http://scripts.sil.org/OFL
```

Checking that string requires scripting fontforge, and since the string val=
ue
may differ (but has the same license) across different fonts, scripting it
can be non-trivial.

>=20
> And, it's not going to work as a dual-license, you can't just suddenly
> dual-license those font files, right?

I was thinking of putting OFL in LICENSES/exceptions instead due to this
nature.

>=20
> >  1 file changed, 107 insertions(+)
> >  create mode 100644 LICENSES/dual/OFL-1.1
> >=20
> > diff --git a/LICENSES/dual/OFL-1.1 b/LICENSES/dual/OFL-1.1
> > new file mode 100644
> > index 00000000000000..00b8db08bd0e54
> > --- /dev/null
> > +++ b/LICENSES/dual/OFL-1.1
> > @@ -0,0 +1,107 @@
> > +Valid-License-Identifier: OFL-1.1
> > +SPDX-URL: https://spdx.org/licenses/OFL-1.1
> > +Usage-Guide:
> > +  Do NOT use this license for code, but it's acceptable for fonts (whe=
re the
> > +  license is specifically written for them). It's best to use it toget=
her
> > +  with a GPL2 compatible license using "OR", as OFL-1.1 texts processe=
d by
> > +  the kernel's build system might combine it with content taken from m=
ore
> > +  restrictive licenses.
> > +  To use the SIL Open Font License 1.1, put the following SPDX tag/val=
ue pair
> > +  into a comment according to the placement guidelines in the licensin=
g rules
> > +  documentation:
> > +    SPDX-License-Identifier: OFL-1.1
>=20
> Where did this Usage-Guide from?

Adapted from LICENSES/dual/CC-BY-4.0.

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--/KWzKcdL50ByjLLA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZUSrNAAKCRD2uYlJVVFO
owOVAQDfc6tg3jOz4yW4hs8/7Tdj2N5B9WFJcdKKBu41RNyd5AEAmor1Fmesa51e
GupVUCytz7URedQA/dvn3osN4cGy0ww=
=tuOf
-----END PGP SIGNATURE-----

--/KWzKcdL50ByjLLA--

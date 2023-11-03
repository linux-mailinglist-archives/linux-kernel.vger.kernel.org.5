Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29A2D7E0166
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 11:31:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235781AbjKCIUr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 04:20:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232184AbjKCIUp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 04:20:45 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3F2C123;
        Fri,  3 Nov 2023 01:20:42 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1cc330e8f58so14953955ad.3;
        Fri, 03 Nov 2023 01:20:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698999642; x=1699604442; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hzIuuzO3uYHLPMAhKmKgXl6SVxtXUKy5EFHDGv0rKEs=;
        b=fRbU1EaYSZQxiSWNORlvfdLactCu4AIqfWQQh+Ms6ma1Cm28m1JCtc/jcyKv9AcZl0
         uHEQ8DJdSksJJnwPHb+7gxmlZX2ic3US89T8x4QeaSgI4TDfFSfehj5r6bOGCF94poOR
         YDQewlsEnYkz90fL6WCk5Ts+pzZaE2hJSskgsZ7vCok4yVCunplRHeQa5BNs3ye9DvVu
         +NIMTOmPYOBiQL8c5eODoreE73wsSJGAyhbq/UFK7JvQnQhMHOJJ3M/IsnLFRUsuKqjo
         mRKFlsD9YIP5+Ufs7QKOVbzMFe9jikNbKcDjyHO8S6DfJZEFTP3sK2ItdNdn4FiB5mQm
         udoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698999642; x=1699604442;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hzIuuzO3uYHLPMAhKmKgXl6SVxtXUKy5EFHDGv0rKEs=;
        b=IvWMLRBzJa/UvNnvPAiEMMDBfTU79aHQmG6xmcArHX2PNQoT5sbN51I7YgvBbnCCsz
         YMu6KAAvPV+KQJmx/vNVpv2hrRW45vmqepD4Khd4NETl34PLkKOybDrJNrlWrN2L63jK
         x8R5TA4bG0uyvuIFSkzhq4Wpa2n6cc1OsRT9SDsMfleywtC1QaBqUnE5HLKkaf/MqZYt
         xwF/yqSz8PhkN1yl7laICsgTlPIYtJsaBaUBJh0mKoo4NVuaV9Zh/9NWjIyd+NSzmyO8
         STu2qhgKr7bAYSBEPk8pIW157tfr+LOKv3j49+JPC9/jjXYx49ffIDcOgMbM5mal0nL4
         58Nw==
X-Gm-Message-State: AOJu0Ywem8udj/ib1RBkAzl03THIIlPO2Mb26vG7gOSj3VEW9cztu/kO
        u9CdAOzZMWXAUFKIcTJXgss=
X-Google-Smtp-Source: AGHT+IFbupEpJpBE+fPw+rFY6GrjPvAE08fDttD7Zs0YqYx0aVVq4X1zOCepX4KqV49KntGdn8jXvA==
X-Received: by 2002:a17:902:ea02:b0:1cc:5648:f15c with SMTP id s2-20020a170902ea0200b001cc5648f15cmr14620023plg.48.1698999641966;
        Fri, 03 Nov 2023 01:20:41 -0700 (PDT)
Received: from debian.me ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id a17-20020a170902ee9100b001bb99e188fcsm889447pld.194.2023.11.03.01.20.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Nov 2023 01:20:41 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 6407591D6704; Fri,  3 Nov 2023 15:20:36 +0700 (WIB)
Date:   Fri, 3 Nov 2023 15:20:36 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Richard Fontana <rfontana@redhat.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Documentation <linux-doc@ger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Akira Yokosawa <akiyks@gmail.com>,
        Stanislav Fomichev <sdf@google.com>,
        David Vernet <void@manifault.com>,
        Miguel Ojeda <ojeda@kernel.org>, James Seo <james@equiv.tech>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Federico Vaga <federico.vaga@vaga.pv.it>,
        Carlos Bilbao <carlos.bilbao@amd.com>,
        linux-spdx@vger.kernel.org
Subject: Re: [PATCH RFC 1/4] LICENSES: Add SIL Open Font License 1.1
Message-ID: <ZUStVO0VSJ6CN_xe@debian.me>
References: <20231102120053.30630-1-bagasdotme@gmail.com>
 <20231102120053.30630-2-bagasdotme@gmail.com>
 <CAC1cPGyLGEwMBRGhwoGmGBeM8qTbuuUsbeZTiiMNUvk4MT75Gw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="mQMlOV5B+hEL++/T"
Content-Disposition: inline
In-Reply-To: <CAC1cPGyLGEwMBRGhwoGmGBeM8qTbuuUsbeZTiiMNUvk4MT75Gw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--mQMlOV5B+hEL++/T
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 02, 2023 at 10:09:57AM -0400, Richard Fontana wrote:
> On Thu, Nov 2, 2023 at 8:01=E2=80=AFAM Bagas Sanjaya <bagasdotme@gmail.co=
m> wrote:
> >
> > Add the license text along with appropriate tags for reference and
> > tooling. The text is taken from the text as distributed in Google
> > Fonts's zip files.
> >
> > As the license itself may or may note be compatible with GPLv2,
> > let's take on the err side and require combining it with
> > GPL-compatible licenses when using the license.
>=20
> I don't really  understand this, though maybe it doesn't practically matt=
er -
> "It's best to use it together
> +  with a GPL2 compatible license using "OR", as OFL-1.1 texts processed =
by
> +  the kernel's build system might combine it with content taken from more
> +  restrictive licenses."
>=20
> I didn't check if this text is just copied from that in other license fil=
es.

Yes, indeed I adapted it from LICENSES/dual/CC-BY-4.0.

>=20
> I'm not sure how this would actually come up in practice for OFL-1.1.
> I assume that typically the way OFL-1.1 can cover stuff in the kernel
> is through font files, and that therefore it would be unlikely for a
> source file to include any code covered by OFL-1.1. Indeed, as you
> say:
>=20
> > +  Do NOT use this license for code, but it's acceptable for fonts (whe=
re the
> > +  license is specifically written for them). It's best to use it toget=
her
>=20
> Even if that did occur, the use of `OR` is only appropriate if the
> stuff covered by OFL-1.1 is actually dual-licensed.
>=20

Another alternative is to put license notice on CSS code that includes
the font. In this case, in Documentation/sphinx-static/fonts.css, the top
of the file should've been written as:

```
/* SPDX-License-Identifier: GPL-2.0 */
/* IBM Plex Sans, IBM Plex Mono, and Newsreader is licensed under the SIL O=
pen
 * Font License, version 1.1. See OFL.txt in the same directory as this file
 * for details. */
<actual stylesheet>
=2E..
```

Is above acceptable?

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--mQMlOV5B+hEL++/T
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZUStVAAKCRD2uYlJVVFO
o9gLAQDXh5KuHQXosius1a/fheR87htYw1ghwPHEieWn7c3wCwEA845XRPFLf/07
dW6DDLQVWuFKmhu7qx9KDrsNapzPXQA=
=T3vu
-----END PGP SIGNATURE-----

--mQMlOV5B+hEL++/T--

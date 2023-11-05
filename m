Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BCF57E180A
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 00:40:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230022AbjKEXk1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Nov 2023 18:40:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229968AbjKEXkZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Nov 2023 18:40:25 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBFD0C0;
        Sun,  5 Nov 2023 15:40:21 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1cc316ccc38so31463605ad.1;
        Sun, 05 Nov 2023 15:40:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699227621; x=1699832421; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IGp8rvzkcPPiqKT5FmB0CXCZA+kRyYzwNKLHcMnlQkc=;
        b=Y8BfcZAfLIiCgHVmN4CIzZs+nUVL9jW2mizF+fYY7mHmU3NLn2mWy+zrBr2EzahwJl
         iK+ar2DQrhGV4M/sWxEPgnOhcMXoOWCDgnIV7rAYdmuvwmR1xfQJFAiR8R7W3zMa2yeW
         myrO5hOuPcWmdRpRUZGJVYZQ8qnkxF8pTbRD0OA9lzN8nef4HaXkyasGcGRuWKb4mJMa
         Oq26/T6DtEzvSvHh6wOb+xvt5wYnoi2F8Ur6a7jJdBBr32G9nL12/RHA7hPBwsRDCeDy
         phDDbdfbZxOYIwYx0Sm323CFfLpZB2lq7GkMJpO5lfmhdbR35zdLjW8GWaGYyYJIstEF
         wSTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699227621; x=1699832421;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IGp8rvzkcPPiqKT5FmB0CXCZA+kRyYzwNKLHcMnlQkc=;
        b=bg+g6DsTv16a4dLxNZVQp0wu42wNz4XPPSVl7F0P5xq1y25QH5yQaSi0v0j4rH181F
         AecG7QYQu3X7K1mrLJRfWnhKiBiMW2UUt05pii8BtUx+6HxggicInINOdfzV+RmkZMBI
         j85RJ3mDrG7S1P+r9i2/HrATDmYBdq7KJOAUZ+yzoAuPHCDZ1K82GMPvZ6LMFDXSHLBb
         vEiHuaI68M6aHWh5DOAX8kfYK5/sRwQmTZa3NREavlKTKspPxG3TYGNv+gzyNCbauV1q
         1ePbZRId0fClEElmnthydwIB0V03FtZWxjb80vO9wIYujeh1d7tw8kbi9L7QScQLZTjK
         rYUQ==
X-Gm-Message-State: AOJu0YxAVbEpdBOYBs3gZrle9vGq392I/SAd3BFEajvZ4LpTaVtGhUVI
        /LD7v/riajcmgjEoS8gL4FA=
X-Google-Smtp-Source: AGHT+IFWdGStEYPGByny1nNKDw6QhrH9HfbF/E1SocS+q6N29lTQcgYKQH40yYknV4SXW7uizWGkPQ==
X-Received: by 2002:a17:902:c412:b0:1cc:c273:603 with SMTP id k18-20020a170902c41200b001ccc2730603mr2185293plk.42.1699227621197;
        Sun, 05 Nov 2023 15:40:21 -0800 (PST)
Received: from debian.me ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id e6-20020a17090301c600b001ab39cd875csm4595719plh.133.2023.11.05.15.40.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Nov 2023 15:40:20 -0800 (PST)
Received: by debian.me (Postfix, from userid 1000)
        id 2480A8167A4D; Mon,  6 Nov 2023 06:40:18 +0700 (WIB)
Date:   Mon, 6 Nov 2023 06:40:18 +0700
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
Message-ID: <ZUgn4r182L57jRgs@debian.me>
References: <20231102120053.30630-1-bagasdotme@gmail.com>
 <20231102120053.30630-2-bagasdotme@gmail.com>
 <2023110222-renewed-monologue-008e@gregkh>
 <ZUSrOKDuvcSL6gOH@debian.me>
 <2023110317-unhealthy-playable-d5d6@gregkh>
 <ZUWV88wRf9suUQfH@debian.me>
 <2023110450-overview-charbroil-5101@gregkh>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="EqQct6nULlqsJlUU"
Content-Disposition: inline
In-Reply-To: <2023110450-overview-charbroil-5101@gregkh>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--EqQct6nULlqsJlUU
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 04, 2023 at 10:52:06AM +0100, Greg Kroah-Hartman wrote:
> On Sat, Nov 04, 2023 at 07:53:07AM +0700, Bagas Sanjaya wrote:
> > On Fri, Nov 03, 2023 at 09:49:54AM +0100, Greg Kroah-Hartman wrote:
> > > On Fri, Nov 03, 2023 at 03:11:36PM +0700, Bagas Sanjaya wrote:
> > > > On Thu, Nov 02, 2023 at 03:06:19PM +0100, Greg Kroah-Hartman wrote:
> > > > > On Thu, Nov 02, 2023 at 07:00:43PM +0700, Bagas Sanjaya wrote:
> > > > > >  LICENSES/dual/OFL-1.1 | 107 ++++++++++++++++++++++++++++++++++=
++++++++
> > > > >=20
> > > > > You add this license, but then never actually reference it in the=
 later
> > > > > changes, so it's going to be very confusing as to why it is here.=
  Any
> > > > > way to add it to the font files themselves so our checker tools c=
an
> > > > > handle this properly?
> > > >=20
> > > > There is TTF name string ID called "License". For example, on IBM P=
lex Sans,
> > > > the string value is:
> > > >=20
> > > > ```
> > > > This Font Software is licensed under the SIL Open Font License, Ver=
sion 1.1. This license is available with a FAQ at: http://scripts.sil.org/O=
FL
> > > > ```
> > > >=20
> > > > Checking that string requires scripting fontforge, and since the st=
ring value
> > > > may differ (but has the same license) across different fonts, scrip=
ting it
> > > > can be non-trivial.
> > >=20
> > > And is that in the files you added?  They are binary so it's hard to
> > > determine this :(
> >=20
> > Yes.
> >=20
> > >=20
> > > > >=20
> > > > > And, it's not going to work as a dual-license, you can't just sud=
denly
> > > > > dual-license those font files, right?
> > > >=20
> > > > I was thinking of putting OFL in LICENSES/exceptions instead due to=
 this
> > > > nature.
> > >=20
> > > Yes, it can not be a dual one.
> >=20
> > That's right!
> >=20
> > What about just saying below in the CSS file that includes the fonts?
> >=20
> > ```
> > ...
> > /* Some cool fonts are licensed under OFL 1.1, see
> >  * LICENSES/exceptions/OFL-1.1 for more information. */
> > ...
> > ```
>=20
> That's not in SPDX format :)

Yes, without it (CSS files of course should already have SPDX line); but I
highlight importing webfonts above, where due to binary nature of font file=
s,
we have to resort to simple license notice above (pre-SPDX) whenever about
to use them.

>=20
> Anyway, I think the meta-comment so far is "do we want to include fonts
> in the kernel source", right?  For that, I would argue "no, let's not
> deal with that mess for now".
>=20

So far I'm only concerned about including OFL fonts. In the cover letter,
I also considered non-free, paid fonts (like S=C3=B6hne), which IMO looks b=
etter
than IBM Plex. Of course, if someone submits a version of this series but
with S=C3=B6hne instead (hey because many other sites do use that font), Gr=
eg will
instantly reject it, right?

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--EqQct6nULlqsJlUU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZUgn3AAKCRD2uYlJVVFO
o8ciAP9kH4RHvlmygSiGDHPGweVMR8cbIwKe1QszfT+QZBMp9QEA6mnjglHnpCDD
kMmnGWXVfyfkQeGY4DP/MvWXak1vNA4=
=7bhi
-----END PGP SIGNATURE-----

--EqQct6nULlqsJlUU--

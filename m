Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FA897CEE7B
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 05:40:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232463AbjJSDkK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 23:40:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230297AbjJSDkI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 23:40:08 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D392F119
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 20:40:06 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id 41be03b00d2f7-5ac88d2cfaaso4461912a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 20:40:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697686806; x=1698291606; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wsofs2k6zHeKQD5ybugu7TrRiu+zkH9j5tthfb8AQqg=;
        b=gk5/ewUeoCBNp21HAlbcgzuLj6YaB5kWjUAWTdsf1nTf0BETZmcz0MLtjJF6Iy38zL
         gJu9Bgiy81VG1XQtrWGHAcplhy19ZVa/uGRaQFcrriXJe0Yclq8t8ArBHaDo2iHbpbC/
         L6YaudLdzncPKn2n83c3XVBW16CzmjImJnGmDRbd7dBKSIJTTDy7gcEjpQplYT7GZ5Ep
         odCvk11GpDtbihWyaLyoDiBhidTwazupFdE2kSQPR3QlrVJWg5aAGaJpezC8v3ow5zBs
         COkYO1IdV3ujojNvZPvDc79hIvxgPtBlUOuvmIwlxQobDLsUhqxt5CFFr+/TV8/nuNiY
         WwoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697686806; x=1698291606;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wsofs2k6zHeKQD5ybugu7TrRiu+zkH9j5tthfb8AQqg=;
        b=FdAFTyAY6Xv8CFjjcmtw85aO7UGoZkIdMgF2Smbyd40/4x4u3WuJxKqWxZ/IK+58Pg
         F/DAqjZpsWIn26wlquW4UdknXofLr7P/kzZBRkYApesza5EmcLHZKBssAnidbMPivPfn
         /ZEg6MHwh8DZfumprLLgQm6x8vVD3Njyxo3kDHagWey8iUD+GZ1fW4WkkQM3dmCsZVLb
         7CJmWaG5rYPKL2RuR8NEtBQ+aibS1ZbGNCH5shaalcWs/EkhkpKKuIA+NQXdx1qXqLKy
         7mkHnQe9kPi4iVTYXUe6/wRO/FpRSNMFdORYaUH1OkwYElGDh9aEtDzZ9TARVYVHq5nY
         CAFg==
X-Gm-Message-State: AOJu0YzOTpijYl5MfQ/Hvh94x6NKMzTADmQAYrAtQs7NdB2Sq1x/qiJj
        qa4yuo+lK2DMlf4ua4GNx1s=
X-Google-Smtp-Source: AGHT+IEunCYOYptFzVz1AXznXSzgFQhTOcRtr+jKC9P7HYaV3Dv5vu0wSFCjNiy5+MhCxEMzSpdSgg==
X-Received: by 2002:a05:6a21:99a9:b0:14c:daa9:5e22 with SMTP id ve41-20020a056a2199a900b0014cdaa95e22mr1122944pzb.45.1697686806137;
        Wed, 18 Oct 2023 20:40:06 -0700 (PDT)
Received: from debian.me ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id p17-20020a170902ead100b001c9db5e2929sm702972pld.93.2023.10.18.20.40.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Oct 2023 20:40:05 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id A9A108B8EDC7; Thu, 19 Oct 2023 10:40:02 +0700 (WIB)
Date:   Thu, 19 Oct 2023 10:40:02 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Kees Cook <keescook@chromium.org>,
        Randy Dunlap <rdunlap@infradead.org>
Cc:     James Dutton <james.dutton@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Justin Stitt <justinstitt@google.com>,
        Calvince Otieno <calvncce@gmail.com>,
        Azeem Shaikh <azeemshaikh38@gmail.com>,
        Andy Shevchenko <andy@kernel.org>
Subject: Re: Is strncpy really less secure than strscpy ?
Message-ID: <ZTClEi_X9-SbiPFU@debian.me>
References: <CAAMvbhG40h6pqSf91BurDHQqeoKfP30bwnpvSDRHBN4Hoygqew@mail.gmail.com>
 <ZTCLLinnaqIILXsJ@debian.me>
 <cf6950bc-32c8-459c-a4b1-ca0a291fc2f8@infradead.org>
 <202310181929.BCC265C@keescook>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="cr65md8gz4E8Td9w"
Content-Disposition: inline
In-Reply-To: <202310181929.BCC265C@keescook>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--cr65md8gz4E8Td9w
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 18, 2023 at 07:56:36PM -0700, Kees Cook wrote:
> On Wed, Oct 18, 2023 at 07:27:20PM -0700, Randy Dunlap wrote:
> >=20
> >=20
> > On 10/18/23 18:49, Bagas Sanjaya wrote:
> > > [Disclaimer: I have little to no knowledge of C, so things may be wro=
ng.
> > >  Please correct me if it is the case. Also Cc: recent people who work=
 on
> > >  strscpy() conversion.]
>=20
> Here are the current docs on the deprecated use of strncpy:
> https://docs.kernel.org/process/deprecated.html#strncpy-on-nul-terminated=
-strings
> which could probably be improved.
>=20
> > Also Cc: the STRING maintainers.
> >=20
> > > On Thu, Oct 19, 2023 at 12:22:33AM +0100, James Dutton wrote:
> > >> Is strncpy really less secure than strscpy ?
>=20
> Very. :)
>=20
> > >> If one uses strncpy and thus put a limit on the buffer size during t=
he
> > >> copy, it is safe. There are no writes outside of the buffer.
> > >> If one uses strscpy and thus put a limit on the buffer size during t=
he
> > >> copy, it is safe. There are no writes outside of the buffer.
> > >=20
> > > Well, assuming that the string is NUL-terminated, the end result shou=
ld
> > > be the same.
>=20
> Note the use of "If" in the above sentences. :) This is what makes
> strncpy so dangerous -- it's only "correct" if the length argument is
> less than the size of the _source_ buffer. And by "correct", I mean
> that only then will strncpy produce a C-string. If not, it's a memcpy
> and leaves the buffer unterminated. This lack of %NUL-termination leads
> to all kinds of potential "downstream" problems with reading past the
> end of the buffer, etc.

Oh, that's what I mean by the same results.

>=20
> One of the easiest ways to avoid bugs is to remove ambiguity, and
> strncpy is full of it. :P
>=20
> Almost more important than the potential lack of %NUL-termination is
> the fact that strncpy() doesn't tell other maintainers _why_ it was used
> because it has several "effects" that aren't always intended:
>=20
> - is the destination supposed to be %NUL terminated? (We covered this)
> - is the destination supposed to be %NUL padded?
>=20
> strncpy pads the destination -- is this needed? Is it a waste of CPU
> time?
>=20
> > >=20
> > >> But, one can fit more characters in strncpy than strscpy because
> > >> strscpy enforces the final \0 on the end.
> > >> One could argue that strncpy is better because it might save the spa=
ce
> > >> of one char at the end of a string array.
>=20
> At the cost of creating non-C-strings. And this is a completely bonkers
> result for the "C String API" to produce. :P
>=20
> > >> There are cases where strncpy might be unsafe. For example copying
> > >> between arrays of different sizes, and that is a case where strscpy
> > >> might be safer, but strncpy can be made safe if one ensures that the
> > >> size used in strncpy is the smallest of the two different array size=
s.
>=20
> The CONFIG_FORTIFY_SOURCE option in the kernel adds a bunch of
> sanity-checking to the APIs (some of which can be determined at compile
> time), but it doesn't remove the ambiguity of using strncpy. We want the
> kernel to have maintainable code, and when it's not clear which of a
> handful of side-effects are _intended_ from an API, that's a bad API. :)
>=20
> > >=20
> > > Code example on both cases?
> > >=20
> > >>
> > >> If one blindly replaces strncpy with strscpy across all uses, one
> > >> could unintentionally be truncating the results and introduce new
> > >> bugs.
>=20
> Yes, of course. That's why we're not blindly replacing them. :) And the
> diagnostic criteria has been carefully described:
> https://github.com/KSPP/linux/issues/90
>=20

Thanks for the explanation!

--=20
An old man doll... just what I always wanted! - Clara

--cr65md8gz4E8Td9w
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZTClDgAKCRD2uYlJVVFO
o7xeAP489Ie/HoB+vWO6ImArSb4o4Vg0dLOeod7/BazTDazfAQEA7pI79ussFSjl
3dGEio/J7sGz7YNEDOwQhJ1JtnLZgwQ=
=0Hki
-----END PGP SIGNATURE-----

--cr65md8gz4E8Td9w--

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E0F97C5747
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 16:47:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232642AbjJKOr0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 10:47:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232246AbjJKOrY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 10:47:24 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D347F92;
        Wed, 11 Oct 2023 07:47:22 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 319B4C433C8;
        Wed, 11 Oct 2023 14:47:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697035642;
        bh=BMQGQuGOk1bRt9Ojd/wD0CnedQUQzSa4KgfQLAsWg7A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qwyf9LKUEepAh6Yi6DM8pSAf+id1588Lcrj55U/8UWjpcmBcdXxaV2RZDsqNoJjEi
         kEdcDhoM0c5MB96j/vC/Sm1nJh/g5EbEiLTALAsiFDeCZlpYuU8/fspAKqVky2fehl
         QsyBVBWF3Ndor3/NelJu3ruLHf78Ie4MxQR0o6Dw1//yWBrMWdgwcBxibw1B+eEuT9
         pYqoPk4eJrcL0hDj58hNVfQiNNwaxkDdIAzRg8RmOWbxjD0BGi1ESwDX7gzvazSx7P
         GZJ7lhQ+GNfeTSXfWUaYDnTtKw+Q5mIYApz/MQJYrdUpcnNLeGtdFKXYoYXv2iMPp2
         NzMpy11knHJhQ==
Date:   Wed, 11 Oct 2023 16:47:18 +0200
From:   Alejandro Colomar <alx@kernel.org>
To:     Matthew House <mattlloydhouse@gmail.com>
Cc:     Rik van Riel <riel@surriel.com>, linux-man@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>, kernel-team@meta.com,
        Eric Biederman <ebiederm@xmission.com>
Subject: Re: [PATCH] execve.2: execve also returns E2BIG if a string is too
 long
Message-ID: <ZSa1duEmIvCb0-_w@debian>
References: <20231010234153.021826b1@imladris.surriel.com>
 <ZSZ7yXwYAg-xPC7P@debian>
 <60b4d916663ea31ae05a958b6dea8aa5bf740d0a.camel@surriel.com>
 <20231011134437.750422-1-mattlloydhouse@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="RNvJy2BpPkE+9lAd"
Content-Disposition: inline
In-Reply-To: <20231011134437.750422-1-mattlloydhouse@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--RNvJy2BpPkE+9lAd
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Oct 2023 16:47:18 +0200
From: Alejandro Colomar <alx@kernel.org>
To: Matthew House <mattlloydhouse@gmail.com>
Cc: Rik van Riel <riel@surriel.com>, linux-man@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>, kernel-team@meta.com,
	Eric Biederman <ebiederm@xmission.com>
Subject: Re: [PATCH] execve.2: execve also returns E2BIG if a string is too
 long

On Wed, Oct 11, 2023 at 09:44:29AM -0400, Matthew House wrote:
> On Wed, Oct 11, 2023 at 9:21 AM Rik van Riel <riel@surriel.com> wrote:
> > On Wed, 2023-10-11 at 12:41 +0200, Alejandro Colomar wrote:
> > > Hi Rik,
> > >
> > > On Tue, Oct 10, 2023 at 11:41:53PM -0400, Rik van Riel wrote:
> > > > Document that if a command line or environment string is too long
> > > > (> MAX_ARG_STRLEN), execve will also return E2BIG.
> > >
> > > That's already implied by the current text:
> > >
> > >        E2BIG  The total number of bytes in the environment (envp) and
> > > argument
> > >               list (argv) is too large.
> > >
> > > That means that
> > >
> > > size_t  bytes;
> > >
> > > bytes =3D 0;
> > > for (char *e =3D envp; e !=3D NULL; e++)
> > >         bytes +=3D strlen(e) + 1;  // I have doubts about the +1
> > > for (char *a =3D argv; a !=3D NULL; a++)
> > >         bytes +=3D strlen(a) + 1;  // Same doubts
> > >
> > > if (bytes > MAX_ARG_STRLEN)  // Maybe >=3D ?
> > >         return -E2BIG;
> >
> > The code in fs/exec.c enforces MAX_ARG_STRLEN against
> > each individual string, not against the total.
> >
> > If any string, either argument or environment, is larger
> > than 32 * PAGE_SIZE, the kernel will return -E2BIG.
> >
> > do_execveat_common() has this code, which uses copy_strings
> > to copy both the strings from the environment, and from
> > the command line arguments:
> >
> >         retval =3D copy_strings(bprm->envc, envp, bprm);
> >         if (retval < 0)
> >                 goto out_free;
> >
> >         retval =3D copy_strings(bprm->argc, argv, bprm);
> >         if (retval < 0)
> >                 goto out_free;
> >
> > Inside copy_strings() we have this code:
> >
> >
> >         while (argc-- > 0) {
> > ...
> >                 len =3D strnlen_user(str, MAX_ARG_STRLEN);
> >                 if (!len)
> >                         goto out;
> >
> >                 ret =3D -E2BIG;
> >                 if (!valid_arg_len(bprm, len))
> >                         goto out;
> >
> > The valid_arg_len() function does not need explanation:
> >
> > static bool valid_arg_len(struct linux_binprm *bprm, long len)
> > {
> >         return len <=3D MAX_ARG_STRLEN;
> > }
> >
> >
> > The current man page wording is very clear about the total
> > length being enforced, but IMHO not as clear about the limit
> > that gets enforced on each individual string.
> >
> > The total length limit of environment & commandline arguments
> > is enforced by bprm_stack_limits(), and is checked against
> > either 1/4 of the maximum stack size, or 3/4 of _STK_LIM, whichever
> > is smaller. The MAX_ARG_STRLEN value does not come into play when
> > enforcing the total.
>=20
> To expand on this, there are basically two separate byte limits in
> fs/exec.c, one for each individual argv/envp string, and another for all
> strings and all pointers to them as a whole. To put the whole thing in
> pseudocode, the checks work effectively like this, assuming I haven't made
> any errors:
>=20
> int argc, envc;
> unsigned long bytes, limit;
>=20
> /* assume that argv has already been adjusted to add an empty argv[0] */
> argc =3D 0, envc =3D 0, bytes =3D 0;
> for (char **a =3D argv; *a !=3D NULL; a++, argc++) {
>     if (strlen(*a) >=3D MAX_ARG_STRLEN)

Are you sure this is >=3D and not > ?

>         return -E2BIG;
>     bytes +=3D strlen(*a) + 1;
> }
> for (char **e =3D envp; *e !=3D NULL; e++, envc++) {
>     if (strlen(*e) >=3D MAX_ARG_STRLEN)
>         return -E2BIG;
>     bytes +=3D strlen(*e) + 1;
> }
>=20
> if (argc > MAX_ARG_STRINGS || envc > MAX_ARG_STRINGS)
>     return -E2BIG;
> bytes +=3D (argc + envc) * sizeof(void *);
>=20
> limit =3D max(min(_STK_LIM / 4 * 3, rlim_stack.rlim_cur / 4), ARG_MAX);
> if (bytes > limit)
>     return -E2BIG;
>=20
> Thank you,
> Matthew House

--=20
<https://www.alejandro-colomar.es/>

--RNvJy2BpPkE+9lAd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE6jqH8KTroDDkXfJAnowa+77/2zIFAmUmtXYACgkQnowa+77/
2zJKiA//RNn68yyfZcJU6JKGdryqYa3VG40zgJpkqbUPb3BahbEu4cXG+f8odY9l
emITNraHQ8gEmlVD9NQCOHNKHWw0vR2RLO3VhzuA/8Oar0KBkOk2tdASrHeGYf5H
HrqEQiSGvPwBgNZ3iU/TFuLRSL7DrcTF6L46bAiGbFRmGPcEi/U7EToepb0EUhp5
vrp0t2dcsj+vMkGn6Hmd/56dV6QBYaKAMYcik8KRZUL40LbXqES0iTIur/UO8vMQ
YKaQLKmHCEGwshaRsBTc9VbRGKdQC5EYQE8XJ3rlbe3BWsqPvxiNwcOU8qCksODu
o+3xwk4X6OpYYTwesPsItPELMDdakiRKUVFaiSL4+J/kNTcMDRqdAt1kEmD+3nfZ
sqQDxg77VSXtTy2Kw/9/uAzkwPTpp/MjwARdJE1qKH7AbiIksVJWBZxauQwcvDdy
fHEDT8P8YxqyMkaDSV27fRsxbcSw50vKsdDukbbuqXmdnGUKWw9/3Zi4xx1lh3/h
J0ye+eI6VQCxdrw2P3YRXQtg7d8Ai74eBGCcdXD2XwGjrxZhq/Whc0Lo5YM4jcUn
atNIomIzmY/q5DaRauw0DplifZQQkVi2b1/24MvlQg7CqqjeauNUK/nLdvpLMLj6
o/0tVg0kBCtUOuo+yGU/vx0w6ubClcKcLV84rSfiODJvW3o0nTA=
=YyaR
-----END PGP SIGNATURE-----

--RNvJy2BpPkE+9lAd--

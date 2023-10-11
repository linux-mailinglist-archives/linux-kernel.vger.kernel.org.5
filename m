Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC0107C572D
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 16:42:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346435AbjJKOmx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 10:42:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232262AbjJKOmv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 10:42:51 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9931792;
        Wed, 11 Oct 2023 07:42:50 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1233DC433C8;
        Wed, 11 Oct 2023 14:42:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697035370;
        bh=+yor+QJevRkMNm3azh0UEdgKbf5j81wLK/um8WHiX2g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UIyRfRTpHYPlXkGh0wzxIUy6L6TQZfDHHUaP2t+5yqF4PnuRgw86VUoZpndfOKQ4F
         8Xf7PwElmK9s7VRHoDIPr2uHlcT3dXOIYK5B8L45bvCVUr25KXCfVoQX3U0Vys93s9
         f1Q4tXEVLisShQZSbDoTr13bPxH7dGCepMcJC+MwEJwwLmQpjzca1Py0L9JX3avoAW
         8zQKCovOM4o0ivIlXOEf9A0HGFf8COX1ji9+YF0q8FKmJtPmZHDkxDKuGTMbYXzwdV
         R5MW0w+k/i1cGz06Cb5A8/Z5s5dhNcXw+EFd83hqUI0NZob6MIwKeyWAh8Yolz8ukV
         d2IZXVu8LzhkQ==
Date:   Wed, 11 Oct 2023 16:42:46 +0200
From:   Alejandro Colomar <alx@kernel.org>
To:     Rik van Riel <riel@surriel.com>
Cc:     linux-man@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        kernel-team@meta.com, Eric Biederman <ebiederm@xmission.com>
Subject: Re: [PATCH] execve.2: execve also returns E2BIG if a string is too
 long
Message-ID: <ZSa0ZotvTRCe88OQ@debian>
References: <20231010234153.021826b1@imladris.surriel.com>
 <ZSZ7yXwYAg-xPC7P@debian>
 <60b4d916663ea31ae05a958b6dea8aa5bf740d0a.camel@surriel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Z5NGJvTGoO5ndKl9"
Content-Disposition: inline
In-Reply-To: <60b4d916663ea31ae05a958b6dea8aa5bf740d0a.camel@surriel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Z5NGJvTGoO5ndKl9
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Oct 2023 16:42:46 +0200
From: Alejandro Colomar <alx@kernel.org>
To: Rik van Riel <riel@surriel.com>
Cc: linux-man@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
	kernel-team@meta.com, Eric Biederman <ebiederm@xmission.com>
Subject: Re: [PATCH] execve.2: execve also returns E2BIG if a string is too
 long

Hi Rik,

On Wed, Oct 11, 2023 at 09:21:28AM -0400, Rik van Riel wrote:
> On Wed, 2023-10-11 at 12:41 +0200, Alejandro Colomar wrote:
> > Hi Rik,
> >=20
> > On Tue, Oct 10, 2023 at 11:41:53PM -0400, Rik van Riel wrote:
> > > Document that if a command line or environment string is too long
> > > (> MAX_ARG_STRLEN), execve will also return E2BIG.
> >=20
> > That's already implied by the current text:
> >=20
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 E2BIG=C2=A0 The total number of by=
tes in the environment (envp) and
> > argument
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 list (argv) is too large.
> >=20
> > That means that
> >=20
> > size_t=C2=A0 bytes;
> >=20
> > bytes =3D 0;
> > for (char *e =3D envp; e !=3D NULL; e++)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0bytes +=3D strlen(e) + =
1;=C2=A0 // I have doubts about the +1
> > for (char *a =3D argv; a !=3D NULL; a++)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0bytes +=3D strlen(a) + =
1;=C2=A0 // Same doubts
> >=20
> > if (bytes > MAX_ARG_STRLEN)=C2=A0 // Maybe >=3D ?
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return -E2BIG;
>=20
> The code in fs/exec.c enforces MAX_ARG_STRLEN against
> each individual string, not against the total.
>=20
> If any string, either argument or environment, is larger
> than 32 * PAGE_SIZE, the kernel will return -E2BIG.
>=20
> do_execveat_common() has this code, which uses copy_strings
> to copy both the strings from the environment, and from
> the command line arguments:
>=20
>         retval =3D copy_strings(bprm->envc, envp, bprm);
>         if (retval < 0)
>                 goto out_free;
>=20
>         retval =3D copy_strings(bprm->argc, argv, bprm);
>         if (retval < 0)
>                 goto out_free;
>=20
> Inside copy_strings() we have this code:
>=20
>=20
>         while (argc-- > 0) {
> ...
>                 len =3D strnlen_user(str, MAX_ARG_STRLEN);
>                 if (!len)
>                         goto out;
>=20
>                 ret =3D -E2BIG;
>                 if (!valid_arg_len(bprm, len))
>                         goto out;
>=20
> The valid_arg_len() function does not need explanation:
>=20
> static bool valid_arg_len(struct linux_binprm *bprm, long len)
> {
>         return len <=3D MAX_ARG_STRLEN;
> }
>=20
>=20
> The current man page wording is very clear about the total
> length being enforced, but IMHO not as clear about the limit
> that gets enforced on each individual string.
>=20
> The total length limit of environment & commandline arguments
> is enforced by bprm_stack_limits(), and is checked against
> either 1/4 of the maximum stack size, or 3/4 of _STK_LIM, whichever
> is smaller. The MAX_ARG_STRLEN value does not come into play when
> enforcing the total.

Ahh, so the limit for each string is different than the limit for the
total.  That makes sense.  Sorry for the noise.

Cheers,
Alex

>=20
> --=20
> All Rights Reversed.

--=20
<https://www.alejandro-colomar.es/>

--Z5NGJvTGoO5ndKl9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE6jqH8KTroDDkXfJAnowa+77/2zIFAmUmtGYACgkQnowa+77/
2zJpGg//U4u7Sgy2OYVFdn5egq3wW7UwGoFwj4X+PKezVKAJYMHf6HhfycWLIpUI
lcq72qibpT3Snl8XuWWUdACRXTOHt4pU/oLBQYVQn/5ScMEny6dpBpyCcUhseOUs
YWnMLpKEhEeSWY+LJ3qxmtl+aACPsZ4d8ANSpXz6ktlkJpfL5M2YGDutOfcVzMgq
ISePl9aNCm+JpdjE6L2ud8Z5sT0r6x5Foklq9CzxFrnCY3t0jCv9X5/ARt4otQJ/
kYMfQlI1Q20kdhcyjZD1j+9KloRE5TxC+dZL9r61v4Esdwseo0hGBiznLaSxBhy2
GcIJF6QJCex6bUZZS3F1i7vujLT145W4+I9lCfv9JPlN+D1LK7V4Uk03p/CfEPPF
9dieB74znFDhzYfldWsl6uf0627vOT5LCLCZbfkot6aV+vgAIrdL8fEpNRimqUqO
5bNCZugbOExnrQErgcTwvgam78GeApKvU/+CF6k0i7u+2eODOn03fexB5JlR73Ot
jo/dhnh3pWXSWmyFHfXz+Ltj7bSB8O93+AaWv1B/sdYefR/PbyuEOxIFUKasCBKI
Dn73DdxqiyBxlVowZOHlNpPM1mS63R8GpXHN8FIv5UNvYyl5Wa76M6JNgUZKQOzU
WzDrfD58vITfHaUiRBKew70B2az19y03hTxwx7JKuere0u8KrOc=
=0/Uk
-----END PGP SIGNATURE-----

--Z5NGJvTGoO5ndKl9--

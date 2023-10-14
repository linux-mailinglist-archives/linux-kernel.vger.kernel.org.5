Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D47897C9741
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Oct 2023 01:20:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233337AbjJNXUt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Oct 2023 19:20:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229733AbjJNXUs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Oct 2023 19:20:48 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F12C3A9;
        Sat, 14 Oct 2023 16:20:46 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FFDDC433C8;
        Sat, 14 Oct 2023 23:20:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697325646;
        bh=pZByRqicRE3aNH8i7QtO2qzFZjBI0dEQxI30C4vTcFM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JsO3biSddsSf/3of9SNqflvn9NwMYaIVb1GWLx8DyxtCghQnqIQRp9oFJvz8jsn2C
         qXPQdapZoCvEHn+RzeltXOBRvdK0WhgFTaxCE22N/oCBRjiVGhMmTmEtZxFmTaQnym
         5hBZgjrjjf8ZWY78xHwQIj+bB5x8f681olw5pmoFAxMhBm5eXltn3Ti8hYhiBbm5uk
         S3fMNdpect2CNOtkiXy3oxoTL12BU98kjPt/R5RlK8fahNTF9FYy3SlBRfZPcMCEJ6
         b6Ouf6gBvNqX8HtRdwE7A9ChjvnVwGQKuJHHdP7jZzOQmLb+4Dd5+rrnW8QiKmozuB
         G8lVJsgUF0qcw==
Date:   Sun, 15 Oct 2023 01:20:42 +0200
From:   Alejandro Colomar <alx@kernel.org>
To:     Guo Ren <guoren@kernel.org>
Cc:     linux-man <linux-man@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-csky@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Subject: Re: set_thread_area.2: csky architecture undocumented
Message-ID: <ZSsiSlJC5sHAyUk-@debian>
References: <014e670b-2a11-3deb-4e7e-bfe9defd8597@gmail.com>
 <c669c780-f6e8-bd2a-e6ec-0a5960b7d7d8@gmail.com>
 <CAJF2gTQPai9k6XqqStbvk0waF+tmMQm9PMMZe3T8m6ioAjdTFA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="+7sKm7wLEzKNfm8V"
Content-Disposition: inline
In-Reply-To: <CAJF2gTQPai9k6XqqStbvk0waF+tmMQm9PMMZe3T8m6ioAjdTFA@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--+7sKm7wLEzKNfm8V
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Date: Sun, 15 Oct 2023 01:20:42 +0200
From: Alejandro Colomar <alx@kernel.org>
To: Guo Ren <guoren@kernel.org>
Cc: linux-man <linux-man@vger.kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	linux-csky@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Subject: Re: set_thread_area.2: csky architecture undocumented

Hi Guo,

On Tue, Nov 24, 2020 at 08:07:07PM +0800, Guo Ren wrote:

Huh, 3 years already!  I've had this in my head for all this time; just
didn't find the energy to act on it.

> Thx Michael & Alejandro,
>=20
> Yes, the man page has no csky's.

I've applied a patch to add initial documentation for it:
<https://www.alejandro-colomar.es/src/alx/linux/man-pages/man-pages.git/com=
mit/?h=3Dcontrib&id=3Da63979eb24aaf73f4be5799cc9579f84a3874b7d>

>=20
> C-SKY have abiv1 and abiv2
> For abiv1: There is no register for tls saving, We use trap 3 to got
> tls and use set_thread_area to init ti->tp_value.
> For abiv2: The r31 is the tls register. We could directly read r31 to
> got r31 and use set_thread_area to init reg->tls value.
>=20
> In glibc:
> # ifdef __CSKYABIV2__
> /* Define r31 as thread pointer register.  */
> #  define READ_THREAD_POINTER() \
>         mov r0, r31;
> # else
> #  define READ_THREAD_POINTER() \
>         trap 3;
> # endif
>=20
> /* Code to initially initialize the thread pointer.  This might need
>    special attention since 'errno' is not yet available and if the
>    operation can cause a failure 'errno' must not be touched.  */
> # define TLS_INIT_TP(tcbp) \
>   ({ INTERNAL_SYSCALL_DECL (err);                                       \
>      long result_var;                                                   \
>      result_var =3D INTERNAL_SYSCALL (set_thread_area, err, 1,           =
 \
>                     (char *) (tcbp) + TLS_TCB_OFFSET);                  \
>      INTERNAL_SYSCALL_ERROR_P (result_var, err)                         \
>        ? "unknown error" : NULL; })
>=20
> In kernel:
> SYSCALL_DEFINE1(set_thread_area, unsigned long, addr)
> {
>         struct thread_info *ti =3D task_thread_info(current);
>         struct pt_regs *reg =3D current_pt_regs();
>=20
>         reg->tls =3D addr;
>         ti->tp_value =3D addr;
>=20
>         return 0;
> }
>=20
> Any comments are welcome :)

I'm sorry, but I have little understanding of this syscall, and that
shounds like gibberish to me :)

Feel free to send a patch to improve the documentation for csky.

Cheers,
Alex

>=20
>=20
> On Tue, Nov 24, 2020 at 5:51 PM Michael Kerrisk (man-pages)
> <mtk.manpages@gmail.com> wrote:
> >
> > Hi Alex,
> >
> > On 11/23/20 10:31 PM, Alejandro Colomar (man-pages) wrote:
> > > Hi Michael,
> > >
> > > SYNOPSIS
> > >        #include <linux/unistd.h>
> > >
> > >        #if defined __i386__ || defined __x86_64__
> > >        # include <asm/ldt.h>
> > >
> > >        int get_thread_area(struct user_desc *u_info);
> > >        int set_thread_area(struct user_desc *u_info);
> > >
> > >        #elif defined __m68k__
> > >
> > >        int get_thread_area(void);
> > >        int set_thread_area(unsigned long tp);
> > >
> > >        #elif defined __mips__
> > >
> > >        int set_thread_area(unsigned long addr);
> > >
> > >        #endif
> > >
> > >        Note: There are no glibc wrappers for these system  calls;  see
> > >        NOTES.
> > >
> > >
> > > $ grep -rn 'SYSCALL_DEFINE.*et_thread_area'
> > > arch/csky/kernel/syscall.c:6:
> > > SYSCALL_DEFINE1(set_thread_area, unsigned long, addr)
> > > arch/mips/kernel/syscall.c:86:
> > > SYSCALL_DEFINE1(set_thread_area, unsigned long, addr)
> > > arch/x86/kernel/tls.c:191:
> > > SYSCALL_DEFINE1(set_thread_area, struct user_desc __user *, u_info)
> > > arch/x86/kernel/tls.c:243:
> > > SYSCALL_DEFINE1(get_thread_area, struct user_desc __user *, u_info)
> > > arch/x86/um/tls_32.c:277:
> > > SYSCALL_DEFINE1(set_thread_area, struct user_desc __user *, user_desc)
> > > arch/x86/um/tls_32.c:325:
> > > SYSCALL_DEFINE1(get_thread_area, struct user_desc __user *, user_desc)
> > >
> > >
> > > See kernel commit 4859bfca11c7d63d55175bcd85a75d6cee4b7184
> > >
> > >
> > > I'd change
> > > -      #elif defined __mips__
> > > +      #elif defined(__mips__ || __csky__)
> > >
> > > and then change the rest of the text to add csky when appropriate.
> > > Am I correct?
> >
> > AFAICT, you are correct. I think the reason that csky is missing is
> > that the architecture was added after this manual pages was added.
> >
> > Thanks,
> >
> > Michael
> >
> >
> > --
> > Michael Kerrisk
> > Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
> > Linux/UNIX System Programming Training: http://man7.org/training/
>=20
>=20
>=20
> --
> Best Regards
>  Guo Ren
>=20
> ML: https://lore.kernel.org/linux-csky/

--=20
<https://www.alejandro-colomar.es/>

--+7sKm7wLEzKNfm8V
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE6jqH8KTroDDkXfJAnowa+77/2zIFAmUrIkoACgkQnowa+77/
2zJBLQ//XczzypNTi/1rlE2DDav7YKOaYkSEV4zNIYOD7QRlFeu5bZloPNIpMm2i
dvwoKgQv+Jkex+diXoab4qDLD7oj8H+Ykrg4yEshEOP0f4BULBG6sV2/FieDIuoj
fWauz5kls3qTCUNa3omyFAa7IbbQ01Lrn89JzMBxw8mo7MSMYv/WObWsc/BsPEAU
gVPdVjCNwKJHajBIPAkSSnMBl83fqfGEsahdC1BrGe6NiDgAnCptcIOnGv8Qkgsn
ElV1vwLGN3OESajN3fJz5iWhBB6xkgoCI1E9iYCYfj44AZDzpfnFD9M9yQHuEOsg
TkEWkY5HdsJ/PhIcWn9Renwl/0rFvpV+2VYOY4Zm0P967uTP3Tbi+6fOy2g+VHgE
6Cn7IxBoQ4gdH/NuLHfgbNPu5ZfS7vAKWTB7HRAu7tmLHWIUy50nZ6Q7zRCvgy9T
4SCkFgPJsUB0IVhxCrgqgzlVB+ihk/Cr434z6GIZjZUE0bxTzHYtbMgTs44N2HpQ
0l0lpaA8RDEwUIDXLZhzk62EjnYZcBGNeziOY4gYahru2uTOMg3K6qYBfKMzdYva
79KWKO0VeVXIQN2zuVwi6mQa5biUQGDjxk3io/lgsIU64PN1FczV9EYoxSWQnoM4
+44LIov8C3BiswxLN+XVJE1ZWPq7Nk6CBnoNy1ofMdPdr9jbHSg=
=QgYa
-----END PGP SIGNATURE-----

--+7sKm7wLEzKNfm8V--

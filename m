Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C21A7FDF46
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 19:23:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232448AbjK2SXp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 13:23:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231428AbjK2SXm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 13:23:42 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B545E12A
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 10:23:48 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E80CC433CB;
        Wed, 29 Nov 2023 18:23:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701282228;
        bh=rQBbpPpwgkqyq02vVDCoz1F9Bje9DaaDDlqruT7zs/w=;
        h=References:In-Reply-To:From:Date:Subject:To:From;
        b=H1tWOUAKKWOATwxnfbA2gJ7/X8LBCV/Ycjmr9yEYlfUkqG7/02UifPKJwoPxfRIuL
         Sx02euI6LTeF9J8XJvnB8AUQHTgbrsdaQtW4/rx6L4l2SFNNcjSKgO+uw03hn5k8IH
         CZIg5Pg+gKGHzLUXibQX79vWyi97y06w+6Oh7C5dVWjeadOwnZ+UctG+v1gh8zuLxJ
         USgOsPPsxccIkFuk+ys6BiTxL/hexCuU8+O7mgR3nDybOg6xbQrqbc29sLfzxIEBJA
         Dx1tYgcCcxVC6rsO3Muw5i2q3Ftqq9ymWQP4MQztIR80Zm1CFM45VlDHN9v7mMh1R3
         gEy6IUlkHT81A==
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-1eb39505ba4so4354174fac.0;
        Wed, 29 Nov 2023 10:23:48 -0800 (PST)
X-Gm-Message-State: AOJu0YyQVTwYuX1Oda5XeCuXh/1/w5eIyJ2JtsKomOT79kE71MWSrgxe
        eP0NbxviQm9bMtApp4UvXsON7hKYbYxiSMcKqBQ=
X-Google-Smtp-Source: AGHT+IHBdK7/V2e3SlXkEhnbXfbbJxtkIyHNbsMTU5Mq7ZEWFbWQcg+P7MWG+NW73gjJnz/nRLE7TXKvTx+1J6IziO4=
X-Received: by 2002:a05:6871:a90b:b0:1f9:fa57:f72a with SMTP id
 wn11-20020a056871a90b00b001f9fa57f72amr19106030oab.38.1701282227552; Wed, 29
 Nov 2023 10:23:47 -0800 (PST)
MIME-Version: 1.0
References: <20231128235356.527642-1-masahiroy@kernel.org> <ZWaqQeR8Rcx-0b4Y@thunder.hadrons.org>
In-Reply-To: <ZWaqQeR8Rcx-0b4Y@thunder.hadrons.org>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Thu, 30 Nov 2023 03:23:11 +0900
X-Gmail-Original-Message-ID: <CAK7LNATvziJ8EvnZ1mBMhG7Vs-9_9--4+UQnW4H2GQvuZseUgw@mail.gmail.com>
Message-ID: <CAK7LNATvziJ8EvnZ1mBMhG7Vs-9_9--4+UQnW4H2GQvuZseUgw@mail.gmail.com>
Subject: Re: [PATCH v3] kbuild: deb-pkg: remove the fakeroot builds support
To:     Guillem Jover <guillem@debian.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        linux-kbuild@vger.kernel.org, Ben Hutchings <ben@decadent.org.uk>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 29, 2023 at 12:04=E2=80=AFPM Guillem Jover <guillem@debian.org>=
 wrote:
>
> Hi!
>
> On Wed, 2023-11-29 at 08:53:56 +0900, Masahiro Yamada wrote:
> > In 2017, the dpkg suite introduced the rootless builds support with the
> > following commits:
> >
> >   - 2436807c87b0 ("dpkg-deb: Add support for rootless builds")
> >   - fca1bfe84068 ("dpkg-buildpackage: Add support for rootless builds")
> >
> > This feature is available in the default dpkg on Debian 10 and Ubuntu
> > 20.04.
> >
> > Remove the old method.
> >
> > Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> > ---
> >
> > Changes in v3:
> >   - Remove DEB_RULES_REQUIRES_ROOT=3Dno again
> >     (resent in order to clarify which one should be applied)
>
> Thanks, as this variable is supposed to be defined by the build driver
> (such as dpkg-buildpackage) that calls debian/rules, as covered in the
> rootless-builds.txt spec.
>
> > diff --git a/scripts/Makefile.package b/scripts/Makefile.package
> > index 0c3adc48dfe8..a81dfb1f5181 100644
> > --- a/scripts/Makefile.package
> > +++ b/scripts/Makefile.package
> > @@ -109,8 +109,6 @@ debian-orig: linux.tar$(debian-orig-suffix) debian
> >               cp $< ../$(orig-name); \
> >       fi
> >
> > -KBUILD_PKG_ROOTCMD ?=3D 'fakeroot -u'
> > -
> >  PHONY +=3D deb-pkg srcdeb-pkg bindeb-pkg
> >
> >  deb-pkg:    private build-type :=3D source,binary
> > @@ -125,7 +123,7 @@ deb-pkg srcdeb-pkg bindeb-pkg:
> >       $(if $(findstring source, $(build-type)), \
> >               --unsigned-source --compression=3D$(KDEB_SOURCE_COMPRESS)=
) \
> >       $(if $(findstring binary, $(build-type)), \
> > -             -R'$(MAKE) -f debian/rules' -j1 -r$(KBUILD_PKG_ROOTCMD) -=
a$$(cat debian/arch), \
> > +             -R'$(MAKE) -f debian/rules' -j1 -a$$(cat debian/arch), \
>
> Since dpkg 1.14.7, dpkg-buildpackage uses fakeroot if available, so
> regardless of anything else this removal seems safe.


You are right.

Even without the explicit -r option, fakeroot will be used
when dpkg-buildpackage determines it is necessary.


Only a use-case I can come up with is,
the fakeroot command is not installed on the system, and a user
may want to do  "make bindeb-pkg KBUILD_PKG_ROOTCMD=3Dsudo"
as a backup plan.


Anyway, now we always assume "--root-command=3Dnone" should work,
so -r$(KBUILD_PKG_ROOTCMD) is unneeded.




> >               --no-check-builddeps) \
> >       $(DPKG_FLAGS))
> >
> > diff --git a/scripts/package/builddeb b/scripts/package/builddeb
> > index d7dd0d04c70c..2fe51e6919da 100755
> > --- a/scripts/package/builddeb
> > +++ b/scripts/package/builddeb
> > @@ -36,19 +36,13 @@ create_package() {
> >       sh -c "cd '$pdir'; find . -type f ! -path './DEBIAN/*' -printf '%=
P\0' \
> >               | xargs -r0 md5sum > DEBIAN/md5sums"
> >
> > -     # Fix ownership and permissions
> > -     if [ "$DEB_RULES_REQUIRES_ROOT" =3D "no" ]; then
> > -             dpkg_deb_opts=3D"--root-owner-group"
> > -     else
> > -             chown -R root:root "$pdir"
> > -     fi
> >       # a+rX in case we are in a restrictive umask environment like 007=
7
> >       # ug-s in case we build in a setuid/setgid directory
> >       chmod -R go-w,a+rX,ug-s "$pdir"
> >
> >       # Create the package
> >       dpkg-gencontrol -p$pname -P"$pdir"
> > -     dpkg-deb $dpkg_deb_opts ${KDEB_COMPRESS:+-Z$KDEB_COMPRESS} --buil=
d "$pdir" ..
> > +     dpkg-deb --root-owner-group ${KDEB_COMPRESS:+-Z$KDEB_COMPRESS} --=
build "$pdir" ..
>
> If you want to make sure dpkg-deb supports that option, perhaps add
> =C2=ABdpkg (>=3D 1.19.0)=C2=BB to the package Build-Depends? If that vers=
ion seems
> old enough to be assumed to be present, then unconditionally using it
> seems fine.



Personally, I do not want to list an essential tool
in the dependency.

The Debian kernel does not do it either.

Anyway, thank you for your comments.



> >  }
> >
> >  install_linux_image () {
>
> Otherwise, the change LGTM.
>
> Thanks,
> Guillem



--=20
Best Regards
Masahiro Yamada

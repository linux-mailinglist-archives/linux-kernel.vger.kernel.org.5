Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E30D676613E
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 03:31:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230385AbjG1Bb1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 21:31:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231925AbjG1BbZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 21:31:25 -0400
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com [IPv6:2001:4860:4864:20::2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56C893592;
        Thu, 27 Jul 2023 18:31:20 -0700 (PDT)
Received: by mail-oa1-x2a.google.com with SMTP id 586e51a60fabf-1bb954414e8so1314053fac.0;
        Thu, 27 Jul 2023 18:31:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690507879; x=1691112679;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CaeqowdeOpwWPJ2yfhz53Af/U8Nhz+fo4LgseG11w/A=;
        b=P4K6qoMuMhq6C6yWBuCUCE00krcPYf8yqhCMOyug99B1Jtfp8gjt92BJKmxPxjuibL
         1gAIULQLPIwEfX2hVRDX5cfa8r4eAukgh3zTf2kyd8Gxa97KA1PHodPyp6v1lqkx83VP
         bdeJN2kTO0hWhwJ1s5Jeqh9OuGkwL5en7iTIFr4jfUaLv+FUEVGKTnlmpHHIIEj8TEFv
         wYIhLNA9+KMLlDta0hT5WrjoYxIKeP2XXmosZXui77g9YalvKsnkQrfkOVZ9cfbYMu57
         ePgO8daG45522zquxoBvzLuw67LN0JRKnjpBpxXspr4Hq6PQelsWEmxYTV9WuBL9aFgg
         x+MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690507879; x=1691112679;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CaeqowdeOpwWPJ2yfhz53Af/U8Nhz+fo4LgseG11w/A=;
        b=iRTAEQXVlGxuo3B3JAPMF9A4D9NqXPrzICH6hZ6smgz5dTffn9A6C1mR3IRfYyNsNc
         yBBKClhfUzRR0R2mgCEW9F2XHf6KzRNY3Dvxgg0zp3aFcjMB8XWC8bzrCTd0yryoEP0p
         VP5X98tfVrqLl5ovMREBnd/VfTr15R8/KkcHjDOYGRMpfI/K/3qqRNu8YdLCWoEkaaQm
         8VymudEEfXGVdnryqp+8vjoxyDLXucIPpWvKB1tXCxhk9OYYBSI3msBb76qYPsBNuVLT
         XROxnAoPXspDNbthiVNdYerxbOQgSKPqqqX5nDNqUFULMPq8VNr1zYoFu1ex8tOPu20x
         jq4w==
X-Gm-Message-State: ABy/qLZWmB7W1+Yx95IC0p59wtyB5Me62j1kN8YhcWrOXm4dgFxHtcKy
        /jK9V7aDIyqh96NifUv0w23DpvUklwbAaQ==
X-Google-Smtp-Source: APBJJlHNeu9e49iEMNIcqQ76ytZayikn4InUU2c9+/sqhYfU43fLY2rYJiyKvPHR2Cbt6/0J/sYyJw==
X-Received: by 2002:a05:6870:ac0d:b0:1b0:2f63:4ff6 with SMTP id kw13-20020a056870ac0d00b001b02f634ff6mr1488579oab.1.1690507879500;
        Thu, 27 Jul 2023 18:31:19 -0700 (PDT)
Received: from debian.me ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id i3-20020a63bf43000000b0055fead55e81sm2021813pgo.57.2023.07.27.18.31.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jul 2023 18:31:18 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 7275A8C50BB8; Fri, 28 Jul 2023 08:31:13 +0700 (WIB)
Date:   Fri, 28 Jul 2023 08:31:12 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Amit Daniel Kachhap <amit.kachhap@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Goran <goran.brkuljan@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>,
        Linux Power Management <linux-pm@vger.kernel.org>
Subject: Re: Fwd: XPS 17 9730 runs significantly warmer on Kernel 6.5-rc3
 compared to Kernel 6.4.3
Message-ID: <ZMMaYLcc5G4KSVyf@debian.me>
References: <4aaf1d3d-2ab7-2d3a-f597-a1741bf699d6@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="/DdscD0f0vtkCtCd"
Content-Disposition: inline
In-Reply-To: <4aaf1d3d-2ab7-2d3a-f597-a1741bf699d6@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--/DdscD0f0vtkCtCd
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 27, 2023 at 09:25:19PM +0700, Bagas Sanjaya wrote:
> Hi,
>=20
> I notice a regression report on Bugzilla [1]. Quoting from it:
>=20
> > On my new XPS 17 9730 laptop, I recently installed the Kernel 6.5-rc3. =
I noticed, however, that during its operation, the laptop was getting signi=
ficantly warmer than before. I did some analysis using the 'stress' tool to=
 measure and compare the difference in CPU temperatures between Kernel 6.4.=
3 and Kernel 6.5-rc3. Here are my results:
> >=20
> > OS: Ubuntu 23.10
> > CPU: i7-13700H
> >=20
> > kernel 6.4.3:
> >                                                                        =
                                                                           =
                                     =20
> > Initial CPU temperature:
> > coretemp-isa-0000
> > Core 0:        +47.0=C2=B0C  (high =3D +100.0=C2=B0C, crit =3D +100.0=
=C2=B0C)
> > Core 4:        +45.0=C2=B0C  (high =3D +100.0=C2=B0C, crit =3D +100.0=
=C2=B0C)
> > Core 8:        +46.0=C2=B0C  (high =3D +100.0=C2=B0C, crit =3D +100.0=
=C2=B0C)
> > Core 12:       +46.0=C2=B0C  (high =3D +100.0=C2=B0C, crit =3D +100.0=
=C2=B0C)
> > Core 16:       +45.0=C2=B0C  (high =3D +100.0=C2=B0C, crit =3D +100.0=
=C2=B0C)
> > Core 20:       +44.0=C2=B0C  (high =3D +100.0=C2=B0C, crit =3D +100.0=
=C2=B0C)
> > Core 24:       +44.0=C2=B0C  (high =3D +100.0=C2=B0C, crit =3D +100.0=
=C2=B0C)
> > Core 25:       +44.0=C2=B0C  (high =3D +100.0=C2=B0C, crit =3D +100.0=
=C2=B0C)
> > Core 26:       +44.0=C2=B0C  (high =3D +100.0=C2=B0C, crit =3D +100.0=
=C2=B0C)
> > Core 27:       +44.0=C2=B0C  (high =3D +100.0=C2=B0C, crit =3D +100.0=
=C2=B0C)
> > Core 28:       +45.0=C2=B0C  (high =3D +100.0=C2=B0C, crit =3D +100.0=
=C2=B0C)
> > Core 29:       +45.0=C2=B0C  (high =3D +100.0=C2=B0C, crit =3D +100.0=
=C2=B0C)
> > Core 30:       +45.0=C2=B0C  (high =3D +100.0=C2=B0C, crit =3D +100.0=
=C2=B0C)
> > Core 31:       +45.0=C2=B0C  (high =3D +100.0=C2=B0C, crit =3D +100.0=
=C2=B0C)
> > Stressing CPU for 30 seconds...
> > stress: info: [4858] dispatching hogs: 14 cpu, 0 io, 0 vm, 0 hdd
> > stress: info: [4858] successful run completed in 30s
> > CPU temperature immediately after stress test:
> > coretemp-isa-0000
> > Core 0:        +67.0=C2=B0C  (high =3D +100.0=C2=B0C, crit =3D +100.0=
=C2=B0C)
> > Core 4:        +76.0=C2=B0C  (high =3D +100.0=C2=B0C, crit =3D +100.0=
=C2=B0C)
> > Core 8:        +69.0=C2=B0C  (high =3D +100.0=C2=B0C, crit =3D +100.0=
=C2=B0C)
> > Core 12:       +77.0=C2=B0C  (high =3D +100.0=C2=B0C, crit =3D +100.0=
=C2=B0C)
> > Core 16:       +69.0=C2=B0C  (high =3D +100.0=C2=B0C, crit =3D +100.0=
=C2=B0C)
> > Core 20:       +76.0=C2=B0C  (high =3D +100.0=C2=B0C, crit =3D +100.0=
=C2=B0C)
> > Core 24:       +68.0=C2=B0C  (high =3D +100.0=C2=B0C, crit =3D +100.0=
=C2=B0C)
> > Core 25:       +68.0=C2=B0C  (high =3D +100.0=C2=B0C, crit =3D +100.0=
=C2=B0C)
> > Core 26:       +68.0=C2=B0C  (high =3D +100.0=C2=B0C, crit =3D +100.0=
=C2=B0C)
> > Core 27:       +68.0=C2=B0C  (high =3D +100.0=C2=B0C, crit =3D +100.0=
=C2=B0C)
> > Core 28:       +71.0=C2=B0C  (high =3D +100.0=C2=B0C, crit =3D +100.0=
=C2=B0C)
> > Core 29:       +71.0=C2=B0C  (high =3D +100.0=C2=B0C, crit =3D +100.0=
=C2=B0C)
> > Core 30:       +71.0=C2=B0C  (high =3D +100.0=C2=B0C, crit =3D +100.0=
=C2=B0C)
> > Core 31:       +71.0=C2=B0C  (high =3D +100.0=C2=B0C, crit =3D +100.0=
=C2=B0C)
> > Test ended at: Tue Jul 25 01:10:16 PM CEST 2023
> >=20
> >=20
> > kernel 6.5-rc-3:
> >=20
> > Initial CPU temperature:
> > coretemp-isa-0000
> > Core 0:        +46.0=C2=B0C  (high =3D +100.0=C2=B0C, crit =3D +100.0=
=C2=B0C)
> > Core 4:        +46.0=C2=B0C  (high =3D +100.0=C2=B0C, crit =3D +100.0=
=C2=B0C)
> > Core 8:        +46.0=C2=B0C  (high =3D +100.0=C2=B0C, crit =3D +100.0=
=C2=B0C)
> > Core 12:       +46.0=C2=B0C  (high =3D +100.0=C2=B0C, crit =3D +100.0=
=C2=B0C)
> > Core 16:       +44.0=C2=B0C  (high =3D +100.0=C2=B0C, crit =3D +100.0=
=C2=B0C)
> > Core 20:       +44.0=C2=B0C  (high =3D +100.0=C2=B0C, crit =3D +100.0=
=C2=B0C)
> > Core 24:       +45.0=C2=B0C  (high =3D +100.0=C2=B0C, crit =3D +100.0=
=C2=B0C)
> > Core 25:       +45.0=C2=B0C  (high =3D +100.0=C2=B0C, crit =3D +100.0=
=C2=B0C)
> > Core 26:       +45.0=C2=B0C  (high =3D +100.0=C2=B0C, crit =3D +100.0=
=C2=B0C)
> > Core 27:       +45.0=C2=B0C  (high =3D +100.0=C2=B0C, crit =3D +100.0=
=C2=B0C)
> > Core 28:       +45.0=C2=B0C  (high =3D +100.0=C2=B0C, crit =3D +100.0=
=C2=B0C)
> > Core 29:       +45.0=C2=B0C  (high =3D +100.0=C2=B0C, crit =3D +100.0=
=C2=B0C)
> > Core 30:       +45.0=C2=B0C  (high =3D +100.0=C2=B0C, crit =3D +100.0=
=C2=B0C)
> > Core 31:       +45.0=C2=B0C  (high =3D +100.0=C2=B0C, crit =3D +100.0=
=C2=B0C)
> > Stressing CPU for 30 seconds...
> > stress: info: [11146] dispatching hogs: 14 cpu, 0 io, 0 vm, 0 hdd
> > stress: info: [11146] successful run completed in 30s
> > CPU temperature immediately after stress test:
> > coretemp-isa-0000
> > Core 0:        +84.0=C2=B0C  (high =3D +100.0=C2=B0C, crit =3D +100.0=
=C2=B0C)
> > Core 4:        +97.0=C2=B0C  (high =3D +100.0=C2=B0C, crit =3D +100.0=
=C2=B0C)
> > Core 8:        +87.0=C2=B0C  (high =3D +100.0=C2=B0C, crit =3D +100.0=
=C2=B0C)
> > Core 12:      +100.0=C2=B0C  (high =3D +100.0=C2=B0C, crit =3D +100.0=
=C2=B0C)
> > Core 16:       +86.0=C2=B0C  (high =3D +100.0=C2=B0C, crit =3D +100.0=
=C2=B0C)
> > Core 20:       +99.0=C2=B0C  (high =3D +100.0=C2=B0C, crit =3D +100.0=
=C2=B0C)
> > Core 24:       +83.0=C2=B0C  (high =3D +100.0=C2=B0C, crit =3D +100.0=
=C2=B0C)
> > Core 25:       +83.0=C2=B0C  (high =3D +100.0=C2=B0C, crit =3D +100.0=
=C2=B0C)
> > Core 26:       +83.0=C2=B0C  (high =3D +100.0=C2=B0C, crit =3D +100.0=
=C2=B0C)
> > Core 27:       +83.0=C2=B0C  (high =3D +100.0=C2=B0C, crit =3D +100.0=
=C2=B0C)
> > Core 28:       +89.0=C2=B0C  (high =3D +100.0=C2=B0C, crit =3D +100.0=
=C2=B0C)
> > Core 29:       +89.0=C2=B0C  (high =3D +100.0=C2=B0C, crit =3D +100.0=
=C2=B0C)
> > Core 30:       +89.0=C2=B0C  (high =3D +100.0=C2=B0C, crit =3D +100.0=
=C2=B0C)
> > Core 31:       +89.0=C2=B0C  (high =3D +100.0=C2=B0C, crit =3D +100.0=
=C2=B0C)
> > Test ended at: Tue Jul 25 01:05:42 PM CEST 2023
> >=20
> > I tested few times with different setup and CPU temp on 6.5-rc3 is alwa=
ys higher especially when stressing with fewer cores.
>=20
> See Bugzilla for the full thread.
>=20
> Goran: On Tuesday, I asked you to perform bisection. Any update on it?
>=20
> Anyway, I'm adding this regression to regzbot:
>=20
> #regzbot introduced: v6.4..v6.5-rc3 https://bugzilla.kernel.org/show_bug.=
cgi?id=3D217703
> #regzbot title: significant temperature increase on XPS 17 9730
>=20
> Thanks.
>=20
> [1]: https://bugzilla.kernel.org/show_bug.cgi?id=3D217703
>=20

Oops, I accidentally duped this. My email client was stuck sending it
(but got delivered anyway), thus:

#regzbot dup-of: https://lore.kernel.org/regressions/107f05b8-0104-501c-130=
c-4f89f3f8a628@gmail.com/

--=20
An old man doll... just what I always wanted! - Clara

--/DdscD0f0vtkCtCd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZMMaWAAKCRD2uYlJVVFO
o8lkAQDq0eSlsqzoVPJxeOlMs2nUyvfWCbEBU6N3l/pwi+1EnwEAgrcp/MXnsG+s
/ouqV6PjFLS9NzE/m7jeCkW/eyv8BQQ=
=qz+4
-----END PGP SIGNATURE-----

--/DdscD0f0vtkCtCd--

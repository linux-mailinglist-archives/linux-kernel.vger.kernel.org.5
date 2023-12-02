Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81A68801D02
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Dec 2023 14:21:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232759AbjLBNSF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Dec 2023 08:18:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjLBNSD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Dec 2023 08:18:03 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B03B512D
        for <linux-kernel@vger.kernel.org>; Sat,  2 Dec 2023 05:18:09 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id 98e67ed59e1d1-2860f7942b0so2888241a91.2
        for <linux-kernel@vger.kernel.org>; Sat, 02 Dec 2023 05:18:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701523089; x=1702127889; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jNVEJdsKmtNdAZNQabZKbCjHnVndczD1cYDvKeqA9lU=;
        b=kQ+yekkqyyQ/F7nqbj0C6HqKvw0Tup0vVuQiicGgP4IC/ANGEkujayhNxdFdSwsyxy
         TkysHUsjJDwGqz3u0GIXHoMbTPZPHZarGygKGO0Rx6pZb/O4/PgU0utBzwzNK/V3K2M5
         BrhjFZZ/9kthEzTvr0gtuaEa8ZwT0CrCjOG1anI4URNp8l62sGHHO8wKHzZWvqR+0RGC
         fbsfHqnmrDkQoh6oe7SX8YQvYC9YuRkone5zvPeeWnlpSbvWbFuUSP5+/vcxhgUjrebM
         mpmdP0PrjHd8y70uLer18ihGAt9xdbH/W3GwdYR+jeRdfihRWcKE48O4kSlPPZNIli0p
         dvng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701523089; x=1702127889;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jNVEJdsKmtNdAZNQabZKbCjHnVndczD1cYDvKeqA9lU=;
        b=BwYiwHx8VQ4sa7GaiLxUNFODLyG2dHF15T8bGqL+Zx7muwi6hCgVAeF3uxJKIANgxm
         Yz4fN+obHMmtnW1aD/2plOOBkWsbvt3TVUSc+LSgYwnqdbFbjsf4P54UTiIZDqcgcTzM
         TihNa+SV+TKH6udpQ/0ta2W7wr79EO5qrRTCLtFf9gI50TM4CVEzQSZuE0IK5laEkbVe
         dsajC6+nu1oVIv9ClMIkAKS6WOsYXTgTT3bpcF9Pjsv8baqmthghyltVmsUdoHBvHaLV
         +TiY3Gu5S34L7844IvWAJw7/WBQ72tgXbbMdfUpm0rClegCeO08WBcATWmoNa9DUiBAj
         Jcgw==
X-Gm-Message-State: AOJu0Yyj+l5SdpQ/gtf7IEBweTf/I0iESkzDOC8ua326MCfMhb8Raquo
        hs/PByaExkE2pfXAeE8TKicrNsIiAu4+Dw==
X-Google-Smtp-Source: AGHT+IFOq0d0LRMXn8YCPuRoNoCReXQ3iXZt40M5xeNoz63J9Dvc2qGv1phScVe1QzgEMsvzDh1eKw==
X-Received: by 2002:a17:90b:314b:b0:285:bc16:6135 with SMTP id ip11-20020a17090b314b00b00285bc166135mr786807pjb.30.1701523089140;
        Sat, 02 Dec 2023 05:18:09 -0800 (PST)
Received: from archie.me ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id ei11-20020a17090ae54b00b002864f7464a0sm3583519pjb.31.2023.12.02.05.18.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Dec 2023 05:18:08 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
        id 10BD61033DCD7; Sat,  2 Dec 2023 20:18:02 +0700 (WIB)
Date:   Sat, 2 Dec 2023 20:18:02 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Gert Vanhaerents <gert.vanhaerents@hotmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux DRI Development <dri-devel@lists.freedesktop.org>,
        Linux Nouveau <nouveau@lists.freedesktop.org>
Cc:     Karol Herbst <kherbst@redhat.com>, Lyude Paul <lyude@redhat.com>,
        Danilo Krummrich <dakr@redhat.com>
Subject: Re: Kernel problem with multiseat on one card
Message-ID: <ZWsuiq7zrYS-pDli@archie.me>
References: <AM7PR10MB39235DD53D163910E88FDB938E82A@AM7PR10MB3923.EURPRD10.PROD.OUTLOOK.COM>
 <AM7PR10MB3923E07D6024434077E95EBA8E82A@AM7PR10MB3923.EURPRD10.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="dTlN31Mink/VwRIe"
Content-Disposition: inline
In-Reply-To: <AM7PR10MB3923E07D6024434077E95EBA8E82A@AM7PR10MB3923.EURPRD10.PROD.OUTLOOK.COM>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--dTlN31Mink/VwRIe
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 30, 2023 at 11:48:24AM +0100, Gert Vanhaerents wrote:
> Hi Kernel list,
> I'm the IT person of a school, earlier we used multiseatcomputers for the
> school, i have maded with a XGL implementation and it works fine but not =
so
> fantastic. The school wants that i build new computers but the XGL project
> is too outdated so i can't use it anymore.
>=20
> How can i make a multiseatcomputer with more then one user on one card wi=
th
> systemd? I have asked already to the makers of systemd but they said it's=
 a
> kernel problem.
>=20
> With Systemd loginctl and the nouveau drivers you have this:
>=20
> =E2=94=80/sys/devices/pci0000:00/0000:00:03.1/0000:08:00.0/drm/card0
> =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0 =E2=94=82 [MASTER] drm:card0
> =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0 =E2=94=82
> =E2=94=9C=E2=94=80/sys/devices/pci0000:00/0000:00:03.1/0000:08:00.0/drm/c=
ard0/card0-DVI-D-1
> =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0 =E2=94=82 =E2=94=82 [MASTER]=
 drm:card0-DVI-D-1
> =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0 =E2=94=82
> =E2=94=9C=E2=94=80/sys/devices/pci0000:00/0000:00:03.1/0000:08:00.0/drm/c=
ard0/card0-HDMI-A-1
> =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0 =E2=94=82 =E2=94=82 [MASTER]=
 drm:card0-HDMI-A-1
> =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0 =E2=94=82
> =E2=94=94=E2=94=80/sys/devices/pci0000:00/0000:00:03.1/0000:08:00.0/drm/c=
ard0/card0-VGA-1
> =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0 =E2=94=82=C2=A0=C2=A0 [MASTE=
R] drm:card0-VGA-1
> =E2=94=9C=E2=94=80/sys/devices/pci0000:00/0000:00:03.1/0000:08:00.0/drm/r=
enderD128
> =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0 =E2=94=82 drm:renderD128
> =E2=94=9C=E2=94=80/sys/devices/pci0000:00/0000:00:03.1/0000:08:00.0/graph=
ics/fb0
> =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0 =E2=94=82 graphics:fb0 "nouv=
eaudrmfb"
>=20
> So it will be:
>=20
> loginctl attach seat1 /sys/devices/pci0000:00/0000:00:03.1/0000:08:00.0/d=
rm/card0/card0-VGA-1
>=20
> For the seat1 (the VGA d-sub output for seat1 and the other HDMI output f=
or
> seat0) and of course the mouse and keyboard.
>=20
> When you do this, all the graphics outputs are on the second seat (seat1)
> and not anymore on the first seat. So i need to move only the VGA output =
to
> seat1 and not all the outputs.

Do you expect that GUI output is on both seats?

>=20
>=20
> When i install the proprietary Nvidia drivers, i have the following:
>=20
> [MASTER] pci:0000:08:00.0
> =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0 =E2=94=82 =E2=94=9C=E2=94=80=
/sys/devices/pci0000:00/0000:00:03.1/0000:08:00.0/drm/card0
> =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0 =E2=94=82 =E2=94=82 [MASTER]=
 drm:card0
> =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0 =E2=94=82
> =E2=94=94=E2=94=80/sys/devices/pci0000:00/0000:00:03.1/0000:08:00.0/drm/r=
enderD128
> =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0 =E2=94=82=C2=A0=C2=A0 drm:re=
nderD128
>=20
> =E2=94=80/sys/devices/platform/efi-framebuffer.0/graphics/fb0
> =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0 =E2=94=82 graphics:fb0 "EFI =
VGA"
>=20
> So no VGA, DVI or HDMI items.

Then report to the GitHub tracker [1].

Thanks.

[1]: https://github.com/NVIDIA/open-gpu-kernel-modules/issues

--=20
An old man doll... just what I always wanted! - Clara

--dTlN31Mink/VwRIe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZWsugwAKCRD2uYlJVVFO
o8SXAP40JF/AVn0kN+P4FxuS8TLOMzBdftMsgeJceZxUMDf1owD9HKB78T3Y1KDl
oR6PGTObbun/lktLQhn3njU9pKzoWAs=
=mBNE
-----END PGP SIGNATURE-----

--dTlN31Mink/VwRIe--

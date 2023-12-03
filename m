Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4692B802074
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Dec 2023 03:49:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231410AbjLCCrQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Dec 2023 21:47:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjLCCrO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Dec 2023 21:47:14 -0500
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58B0E11A
        for <linux-kernel@vger.kernel.org>; Sat,  2 Dec 2023 18:47:20 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id 41be03b00d2f7-5bcfc508d14so1463980a12.3
        for <linux-kernel@vger.kernel.org>; Sat, 02 Dec 2023 18:47:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701571640; x=1702176440; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hwi4CkSiHiuyV9keGcRs+cQrmHpIxi0CgRaI9b36kXc=;
        b=UJFvjJq+ShCQdTjg81ruBW9QuhvMuPrfP9fs/JdB/iwV0LqZWaseBT1RvNq9b+aC4X
         iCpDuEXEypG4hJ5owgs87dykLnLAwHLXuWJm/o55hrho+zVo7om0KAEzqt9RsRWbD7pn
         dNAPVFxEE+e/6YFYB7Pevng0J0eDuEoQxW+H0Bw7KFCCR2WmOhG2UUC5/R86Qx6Xbry9
         CQ4HDkpYEJqacRDzTjG/B/8ToHtUg0/niGEGc1FcZ+O6WGPa5PuYRNMhf5Q9TYAru1pN
         9dLkQ/va+3yxy6CzUpQTYq03y4jQ1dKrZca4xe8/HtppwRNvF0YKjDGThhU43JWLrXTq
         BXIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701571640; x=1702176440;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hwi4CkSiHiuyV9keGcRs+cQrmHpIxi0CgRaI9b36kXc=;
        b=UIAPNDVCY9dDiABvrCr830AI7dprdw+szAY7vUrjEbGHghVmqaYJSDJ06gOpK3IJFD
         jVjXVW75cnn1fQ2kWRDelRZMJClOhaDkHo03G/7JksmQ31f0+r8c7Sg/XarYaXv5lm4y
         2QpvFfRiDctguBcE5Lmd9aYpqk6kvKw5ooVg5VYe22vwFFLYHpA3zSX7rbOTPAsCmM1+
         I4/VhC92auYfVczRK5XUtvJLNx9I1ldJKLVU25scd5cYWO+GNrGWbcT9n2UKe0vd+rLw
         B8jGeD7KO6ba/ojUkWjFlYiPo/gcWVeN/gZb7C0Nb5LxraFtpZNwApO/qF9gUfd9hoNF
         eZWQ==
X-Gm-Message-State: AOJu0YyXPqtEuclDjR1SFjzFgbks5+nZfKtFfoBFXh4tII59O23xKM7c
        WHdHBRhsIj2dCXysd2Moc/0=
X-Google-Smtp-Source: AGHT+IGIXMzatFr8BevACKg6pkv/MY315sB+5R85kFeOtEyUxFZmmJ5AtiWsRRxreZOPKdonOMUgYw==
X-Received: by 2002:a17:902:dacd:b0:1d0:6b95:9c0d with SMTP id q13-20020a170902dacd00b001d06b959c0dmr2339798plx.65.1701571639739;
        Sat, 02 Dec 2023 18:47:19 -0800 (PST)
Received: from archie.me ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id ip1-20020a17090b314100b00285d330ae8bsm7273256pjb.57.2023.12.02.18.47.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Dec 2023 18:47:19 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
        id 64344102894F8; Sun,  3 Dec 2023 09:47:16 +0700 (WIB)
Date:   Sun, 3 Dec 2023 09:47:16 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Timur Tabi <ttabi@nvidia.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "nouveau@lists.freedesktop.org" <nouveau@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "gert.vanhaerents@hotmail.com" <gert.vanhaerents@hotmail.com>
Subject: Re: [Nouveau] Kernel problem with multiseat on one card
Message-ID: <ZWvsNOMjONfYGeUF@archie.me>
References: <AM7PR10MB39235DD53D163910E88FDB938E82A@AM7PR10MB3923.EURPRD10.PROD.OUTLOOK.COM>
 <AM7PR10MB3923E07D6024434077E95EBA8E82A@AM7PR10MB3923.EURPRD10.PROD.OUTLOOK.COM>
 <ZWsuiq7zrYS-pDli@archie.me>
 <655a02097e9b49c2da7a2be60d7c154a48a916f4.camel@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="OZ2h1VyjMrmlXfbI"
Content-Disposition: inline
In-Reply-To: <655a02097e9b49c2da7a2be60d7c154a48a916f4.camel@nvidia.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--OZ2h1VyjMrmlXfbI
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 02, 2023 at 03:28:25PM +0000, Timur Tabi wrote:
> On Sat, 2023-12-02 at 20:18 +0700, Bagas Sanjaya wrote:
> >=20
>=20
> > > When i install the proprietary Nvidia drivers, i have the following:
> > >=20
> > > [MASTER] pci:0000:08:00.0
> > > =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0 =E2=94=82 =E2=94=9C=E2=
=94=80/sys/devices/pci0000:00/0000:00:03.1/0000:08:00.0/drm/card0
> > > =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0 =E2=94=82 =E2=94=82 [MAS=
TER] drm:card0
> > > =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0 =E2=94=82
> > > =E2=94=94=E2=94=80/sys/devices/pci0000:00/0000:00:03.1/0000:08:00.0/d=
rm/renderD128
> > > =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0 =E2=94=82=C2=A0=C2=A0 dr=
m:renderD128
> > >=20
> > > =E2=94=80/sys/devices/platform/efi-framebuffer.0/graphics/fb0
> > > =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0 =E2=94=82 graphics:fb0 "=
EFI VGA"
> > >=20
> > > So no VGA, DVI or HDMI items.
> >=20
> > Then report to the GitHub tracker [1].
> >=20
> > Thanks.
> >=20
> > [1]: https://github.com/NVIDIA/open-gpu-kernel-modules/issues
> >=20
>=20
> No, do NOT report this on the Github tracker!
>=20
> That github tracker is ONLY for bugs that occur with OpenRM (the "Open GPU
> Kernel Module") but not with the the proprietary driver.  If you have a b=
ug
> with the the Nvidia proprietary driver, that must be reported on the Nvid=
ia
> forum instead:=20
>=20
> https://forums.developer.nvidia.com/c/gpu-graphics/linux/148
>=20

Thanks for the correct pointer!

Sorry for inconvenience.

--=20
An old man doll... just what I always wanted! - Clara

--OZ2h1VyjMrmlXfbI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZWvsLwAKCRD2uYlJVVFO
oxtcAP4u3ez3E31bsckuQz8FiVqspKTnc2sOAd+RVV7YAVfXPgEA8h3/OoMBej3D
APZPK5cv/DozHoLIuoOTGBY+IfCdkAc=
=kWBj
-----END PGP SIGNATURE-----

--OZ2h1VyjMrmlXfbI--

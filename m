Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2258280B1ED
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Dec 2023 04:45:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234249AbjLIDop (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 22:44:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229731AbjLIDoo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 22:44:44 -0500
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1799410E6;
        Fri,  8 Dec 2023 19:44:51 -0800 (PST)
Received: by mail-pg1-x52d.google.com with SMTP id 41be03b00d2f7-5c21e185df5so2334731a12.1;
        Fri, 08 Dec 2023 19:44:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702093490; x=1702698290; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CCZE7SzFJ+E9PoYCMO1v9KaDTbP1QB2IF1PQTRe+p5A=;
        b=mNcnR6xqhcCVaDpOJSqpr1gv9Dsd+HXhFEjwA1F1OU/n/k4GXn4cJrtygejYlsNZ7i
         lLBi+2mlEQkzSA3LsqxQGezXXifCrc/85Wj6+sjqZ+FbaP9e2M8QzDsFVU8NoqquVfsX
         n7j8D+4t/pHJaBMIvMC7kmTMIZbAn4MZALE9ZVFwJt6DSbihy3pT2Yyw3cgfP33nxOpB
         kW+CE33Ygtqg3r92kCmJvjlvl7RSN8r4fZMD/IX0F0Is4YlrLHCp3hSfss8RlSCw0iMf
         lXu1i8K7Q0QlxXXyUCdXAqo5ppZmWiXcloVuJC0aIMgASKo0hCknUHmKWpCbjpFp4EHD
         LnrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702093490; x=1702698290;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CCZE7SzFJ+E9PoYCMO1v9KaDTbP1QB2IF1PQTRe+p5A=;
        b=Ld4jBhqS/1wjv3IAHUIJSkdTgX9XbN8y0qI3HUOtIlo9xj0srGVqfyfzc2OL9uGO6C
         4jFDGnCGFGUkx/lelJdjBhmmE7jUp6piJb0ecJlKF5MZXXCSgJw8p2Caei76GXJU/Dz8
         NdAz+kwa82gQQ2W8MfbEvZFzQkOFY1M/9Oq5DU1yt+ZbfOx7q84IMhTV7Nwot6axNWVk
         zfPwdBowl+sFad+HGRqE+rS+04q/blrLdFP37I13elJV7YilKbAqHzNcXLtLS3373JYo
         f0xIDb4Oop+Ud8ruTK54+azbCxvsio8u74ExHCTKGGSWfp1/PFZBRePMXz3Op4PU/uEe
         NIgg==
X-Gm-Message-State: AOJu0YysWrzFkkx9pzIHaD+aPrLBD9X8rKYVfe6fIGJAKAU5lGi8Ku16
        jFAHBJ0gsvwkPksd6gqyl0o=
X-Google-Smtp-Source: AGHT+IFJnoJ5OP9o0L4RyOunrxsffxNyjlr4z+xHc/ojxybr21CalbOHload/ZeP0TH7/HqUoz72AA==
X-Received: by 2002:a05:6a21:328b:b0:18c:ad4d:3469 with SMTP id yt11-20020a056a21328b00b0018cad4d3469mr1451440pzb.53.1702093490469;
        Fri, 08 Dec 2023 19:44:50 -0800 (PST)
Received: from archie.me ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id t14-20020a63eb0e000000b005ac384b71cbsm2291065pgh.60.2023.12.08.19.44.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Dec 2023 19:44:49 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
        id 9332E10211A57; Sat,  9 Dec 2023 10:44:45 +0700 (WIB)
Date:   Sat, 9 Dec 2023 10:44:45 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Alexander Graf <graf@amazon.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     Linux Documentation <linux-doc@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jan =?utf-8?Q?H=2E_Sch=C3=B6nherr?= <jschoenh@amazon.de>,
        James Gowans <jgowans@amazon.com>
Subject: Re: [PATCH v2] initramfs: Expose retained initrd as sysfs file
Message-ID: <ZXPiregue0FkxDEs@archie.me>
References: <20231206213323.78233-1-graf@amazon.com>
 <ZXG8nEEMqorxeM3E@archie.me>
 <2a86a7f2-bbf3-43fb-82b9-40d3397d5578@amazon.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="kzQn8eZ18UIMUIWi"
Content-Disposition: inline
In-Reply-To: <2a86a7f2-bbf3-43fb-82b9-40d3397d5578@amazon.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--kzQn8eZ18UIMUIWi
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 08, 2023 at 12:54:18AM +0100, Alexander Graf wrote:
> Hi Bagas,
>=20
> On 07.12.23 13:37, Bagas Sanjaya wrote:
> > On my Arch Linux system, /sys/firmware/initrd is not same as initramfs =
image
> > from /boot partition that is uncompressed. `ls -l` listing shows
> > (with /tmp/initramfs-boot is unzstd'ed initramfs of the same kernel boo=
ted):
> >=20
> > ```
> > -r--r----- 1 root root 22967535 Dec  7 19:32 /sys/firmware/initrd
> > -rw------- 1 root root 40960000 Dec  7 19:26 /tmp/initramfs-boot
> > ```
> >=20
> > And thus, `cpio -i -v` listing differs. While in uncompressed initramfs,
> > I got expected initramfs contents (early userpace for booting), doing t=
he same
> > to /sys/firmware/initrd only shows Intel microcode.
> >=20
> > Regardless, exposing initramfs as advertised in the patch description w=
orks for
> > me.
>=20
>=20
> Thanks a bunch for testing the patch!
>=20
> The reason you're seeing microcode is that something in your boot chain
> (grub maybe? sd-boot?) sends multiple initrd blobs to Linux: One that
> contains microcode and another that contains the real initrd. Linux
> continues extracting past the first cpio archive.
>=20

Yes, I use grub on my setup.

Ciao!

--=20
An old man doll... just what I always wanted! - Clara

--kzQn8eZ18UIMUIWi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZXPiqAAKCRD2uYlJVVFO
oynsAQC7FChpsaleO80bxpjwR1pE+W8E2XDPGkJkN90E2ibLBQD8CfRWfCLhx27V
+pMyktVR4EzB5FZROQG5/iNQsrGdjAg=
=CASx
-----END PGP SIGNATURE-----

--kzQn8eZ18UIMUIWi--

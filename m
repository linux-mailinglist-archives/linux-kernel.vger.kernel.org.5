Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B7C77DA564
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Oct 2023 09:02:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229566AbjJ1HCr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Oct 2023 03:02:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbjJ1HCp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Oct 2023 03:02:45 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93E80CA;
        Sat, 28 Oct 2023 00:02:43 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1c77449a6daso24439875ad.0;
        Sat, 28 Oct 2023 00:02:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698476563; x=1699081363; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3swEum9c3xS2G6bitOJ9Q/SoUIKvRIQ+YpGFc6w8sw4=;
        b=Hp0RzgGa6AYU/aLycpwXyKUvQFzDi9YQNouTZ0mVdtAJgS0qqmxNPaS3Usq1cLVyoa
         AA3IM7rGFD/54uQIzvT0YBkOsVwLO1Uub9RGP96tnta0HYrc7lwrZ6iN1CzC4ZwMSkOU
         OsDMTD65jqSkvn527q10RXiw0nFlqsE1rLTC8Pg9bkRZxwLJnNZ71bmbXcNr+VUXLUjM
         DH8WzGJPGWV3l8+H5FrLS/1i8WBR71U9owUGNYhqeE6w5tTqnAB5WzHvKZjhM6VgHfCS
         2dMjzuxc8YJQ8zkisvLlEG35DWFdOygD5pJ+g8oXC0tgabSbOFzW/KrqH+p621bHf5hx
         7M6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698476563; x=1699081363;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3swEum9c3xS2G6bitOJ9Q/SoUIKvRIQ+YpGFc6w8sw4=;
        b=Wl5bJh76DorryO6AIlpdDrrQ6LyoxQlUpzc2j0rKPhcMLn9gDEnTggRwVHCBD0vZn2
         bRcSyYL9FHCWagDyvcCIPe9hGet0/Rm8pDZW2NUhtKyDh8vT5uhsBDDDpA0eEaQo9lmV
         bFS2AUWkaNEEsKHBZuDR1FiRQ3/jXAR1z7EJADMN3GOggk34tjh3P01A93m2xTajTDk2
         YfAdkDbOz387ktMYpGVDqlXe5zKbMXin6azMlm6ruBU2qa43dGumADGAFbsPJ4kDAnJD
         FG3sLhqOErSdegYvOUkk26upMAC7L0PS/uH15au3GNU5zlLllf5GbPcK4ARg9C46yhex
         U2sg==
X-Gm-Message-State: AOJu0YyeaME39zvfW59rKSwcC4rM4zG9vPTppwCeDiWaT7qEgFRTECET
        UvgXYQWFTvUJC8JIyAl3fTNA2lr74wU=
X-Google-Smtp-Source: AGHT+IGa7VL+bQV7Heatz+nnpWDo71U1XmVWXXl+KEQuoET9YsFzFqty1C66Z4w1e6HE943/DXvhqg==
X-Received: by 2002:a17:903:2301:b0:1c9:d940:78ea with SMTP id d1-20020a170903230100b001c9d94078eamr5581884plh.22.1698476562930;
        Sat, 28 Oct 2023 00:02:42 -0700 (PDT)
Received: from debian.me ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id l9-20020a170902d34900b001c55db80b14sm958148plk.221.2023.10.28.00.02.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Oct 2023 00:02:42 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 4BB61819CFF3; Sat, 28 Oct 2023 14:02:38 +0700 (WIB)
Date:   Sat, 28 Oct 2023 14:02:37 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     LihaSika <lihasika@gmail.com>,
        Linux USB <linux-usb@vger.kernel.org>,
        Linux USB Storage <usb-storage@lists.one-eyed-alien.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Milan Svoboda <milan.svoboda@centrum.cz>,
        Matthieu Castet <castet.matthieu@free.fr>
Subject: Re: [PATCH] usb: storage: set 1.50 as the lower bcdDevice for older
 "Super Top" compatibility
Message-ID: <ZTyyDXYR4f6WKdLM@debian.me>
References: <ZTsR-RhhjxSpqrsz@debian.me>
 <055de764-c422-4c22-a79b-dd4db56122ce@gmail.com>
 <2023102704-stable-lid-c86a@gregkh>
 <7484f7c8-a49c-4111-83f0-bb6db2906fae@gmail.com>
 <2023102729-spent-ninja-7e39@gregkh>
 <037e5af2-3afd-4a37-a4d7-6dc87af605c7@gmail.com>
 <21c2b8ee-7753-413e-98f9-d1401edf5c73@gmail.com>
 <2023102720-emotion-overlying-9bb4@gregkh>
 <ccf7d12a-8362-4916-b3e0-f4150f54affd@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="LBqHn0zx6pxC/YW3"
Content-Disposition: inline
In-Reply-To: <ccf7d12a-8362-4916-b3e0-f4150f54affd@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--LBqHn0zx6pxC/YW3
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 27, 2023 at 08:28:04PM +0300, LihaSika wrote:
> Change lower bcdDevice value for "Super Top USB 2.0  SATA BRIDGE" to match
> 1.50. I have such an older device with bcdDevice=3D1.50 and it will not w=
ork
> otherwise.

What about below description?

```
Some old USB hard drives using Super Top USB 2.0 SATA bridge have lower
minimum bcdDevice value than currently allowed (1.60). Such devices
cannot be used by ums-cypress driver since their bcdDevice is out of range.

Lower minimum bcdDevice to fix that.=20
```

>=20
> Cc: stable@vger.kernel.org
> Signed-off-by: Liha Sikanen <lihasika@gmail.com>

Is your intended author name in your From: header or Signed-off-by: trailer?

Also, don't forget to add Fixes: tag; that is:

Fixes: a9c143c82608 ("usb-storage: restrict bcdDevice range for Super Top i=
n Cypress ATACB")

When above reviews are addressed, resend as v2. Make sure that the patch
subject begins with `[PATCH v2]`.

> ---
>=20
> diff --git a/drivers/usb/storage/unusual_cypress.h b/drivers/usb/storage/=
unusual_cypress.h
> index 0547daf..5df4075 100644
> --- a/drivers/usb/storage/unusual_cypress.h
> +++ b/drivers/usb/storage/unusual_cypress.h
> @@ -19,7 +19,7 @@ UNUSUAL_DEV(  0x04b4, 0x6831, 0x0000, 0x9999,
>  		"Cypress ISD-300LP",
>  		USB_SC_CYP_ATACB, USB_PR_DEVICE, NULL, 0),
> =20
> -UNUSUAL_DEV( 0x14cd, 0x6116, 0x0160, 0x0160,
> +UNUSUAL_DEV( 0x14cd, 0x6116, 0x0150, 0x0160,
>  		"Super Top",
>  		"USB 2.0  SATA BRIDGE",
>  		USB_SC_CYP_ATACB, USB_PR_DEVICE, NULL, 0),
>=20

The diff itself is LGTM.

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--LBqHn0zx6pxC/YW3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZTyyCQAKCRD2uYlJVVFO
o5dIAQDECVFDQwsCIiuYkCORuUPpHseb/kWe2suzrMmWG0ohGAD+OjIHq9yEOFzd
R2wA63Yr4JeUOyk4cEwGK5v0lrL98Ac=
=3N1E
-----END PGP SIGNATURE-----

--LBqHn0zx6pxC/YW3--

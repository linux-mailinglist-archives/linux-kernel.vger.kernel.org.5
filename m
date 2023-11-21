Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D35037F2FFC
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 14:59:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233939AbjKUN7P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 08:59:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231174AbjKUN7L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 08:59:11 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CBB7D6F;
        Tue, 21 Nov 2023 05:59:07 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-6cb749044a2so2644813b3a.0;
        Tue, 21 Nov 2023 05:59:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700575147; x=1701179947; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PsIFDbkq3IQrnabPVFzja7nATUUvNefVFfGOvv4NrZM=;
        b=KOV0edLJh69lFqIVsaZ2VLzKcWZpZ7C76ihYYbGdH1LMwNIhBbkGhS/80Ufq9J5L6V
         AiRUsUVrcLaQcpIEMzDFZnZof45Tuor5xK7a9J2DXP4NW8qG/vPJ5U5kW3jdddB9oib5
         y6rSLucuyIMJYFnSo5+lcZPczgRZzRWC2G+rou2aj7wC9RSKlrSvdTI6FDoSgF7x4Al8
         RhmIQ61kRZWIkmM/uaEFUKHWcG0cH3ADhYUuGcxOpPGkQWvLkMoEVASkrxpzrQ1/PnaD
         GtaKxSlSXWNlXz5QjL7wQw2fKlzBZiSiBbexxO7vwjwQe58jM8sW4c+XEksxra8X22+L
         xJzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700575147; x=1701179947;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PsIFDbkq3IQrnabPVFzja7nATUUvNefVFfGOvv4NrZM=;
        b=cPHFJKsprMZRwPNuR/s3zqVVY2mupRWJrwJgdgkRABJvVO7+4/3ze/KG3c3RZ8jB11
         dLyZVKrvRtHmukuDw6FvvKcgbTJVy8zdQMp9dXwwJVF4NDBImFIDrIvSOeWp2XDDLf0Y
         XJmSoIw7gMV/6kHqT5Di8/bkvGKhSPOSvvLj4yoQiQVprS+Ge8PzBp5K1G6AbHdxm2/M
         Dr82L3la+YR1udvTHy9BO9Jr6ia1Li2mPGCIm69Rgrstjhya6pl4hUc5vQwHaiscLoSD
         iEzxJVK2CGGFLoeTIX+mtKuHm/0rRyGhCH/1u+d4VUDaDpkcP+J5ttAuWzKLzwvrPP/Y
         pxaQ==
X-Gm-Message-State: AOJu0YzvRPHOVwS86GGoup2UDkBbPzd9AnrgDXT9GNPjGPJmTVhg/0Nv
        Y0gT50maxQeyVUFIgnKpEnuMZXURzAbF/Q==
X-Google-Smtp-Source: AGHT+IEz/HdgXgzT0A3WPEOgDPLCKejKgnhzpEZ4iI1Bb+mN9GJZ/8LvzCRD0T9hv81gJnp38UbgHQ==
X-Received: by 2002:aa7:8885:0:b0:6cb:a2f7:83d with SMTP id z5-20020aa78885000000b006cba2f7083dmr6605030pfe.19.1700575146957;
        Tue, 21 Nov 2023 05:59:06 -0800 (PST)
Received: from archie.me ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id p11-20020a056a000a0b00b0068fb8e18971sm7905605pfh.130.2023.11.21.05.59.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Nov 2023 05:59:06 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
        id 6535110207143; Tue, 21 Nov 2023 20:58:59 +0700 (WIB)
Date:   Tue, 21 Nov 2023 20:58:59 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Jiri Kosina <jikos@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>,
        Linux Input Devices <linux-input@vger.kernel.org>,
        Thorsten Leemhuis <regressions@leemhuis.info>,
        Mavroudis Chatzilazaridis <mavchatz@protonmail.com>,
        Filipe =?utf-8?B?TGHDrW5z?= <lains@riseup.net>,
        Bastien Nocera <hadess@hadess.net>,
        LinuxCat <masch77.linuxcat@gmail.com>,
        Marcelo <mmbossoni@gmail.com>, Takashi Iwai <tiwai@suse.de>,
        Hans de Goede <hdegoede@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Fwd: Logitech G915 Wireless Keyboard acts weird on 6.6.0
Message-ID: <ZVy3o99Q2UEN-pCa@archie.me>
References: <6929ebbf-f2e0-4cd4-addc-1e33ecf3277f@gmail.com>
 <ZVyr-of1X4RudpWG@archie.me>
 <nycvar.YFH.7.76.2311211435050.29220@cbobk.fhfr.pm>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="XsWrEpNz9+GQI+SZ"
Content-Disposition: inline
In-Reply-To: <nycvar.YFH.7.76.2311211435050.29220@cbobk.fhfr.pm>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--XsWrEpNz9+GQI+SZ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 21, 2023 at 02:37:52PM +0100, Jiri Kosina wrote:
> On Tue, 21 Nov 2023, Bagas Sanjaya wrote:
>=20
> > Hi Thorsten and all,
> >=20
> > <snip>...
> > There's no reply from culprit author nor linux-input people (did they m=
iss
> > this regression?). And on Bugzilla, other reporters replied that revert=
ing
> > the culprit fixed the regression.
> >=20
> > FYI, there's similar Bugzilla report on [1].
>=20
> As there was no reaction from Mavroudis in order to figure out why he is=
=20
> not observing the issues the other reporters do and what to do to fix=20
> those, I already do have revert in my queue for -rc3.
>=20
> My first guess would be that the extra buttons in the extended report are=
=20
> not properly reflected in the emulated report descriptor, but that=20
> wouldn't explain why it worked for the author of the commit.
>=20
> So revert it is, and once Marvoudis resurfaces, we can try again for some=
=20
> of later releases.
>=20

Thanks for letting us know!

--=20
An old man doll... just what I always wanted! - Clara

--XsWrEpNz9+GQI+SZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZVy3owAKCRD2uYlJVVFO
o4YwAP496ZbAfetrOX9nDZcCIHlwT53CUmvi8B2NQfkkVKIwtgD8DrAw8lE9SaOm
XQDAYeme07KJMLvNgKaz8nXTVNGQegE=
=73dj
-----END PGP SIGNATURE-----

--XsWrEpNz9+GQI+SZ--

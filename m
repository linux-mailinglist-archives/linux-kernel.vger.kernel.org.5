Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 322067EEED5
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 10:39:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345722AbjKQJje (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 04:39:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229952AbjKQJjc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 04:39:32 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91F11B7
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 01:39:29 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1ce611682f6so1761085ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 01:39:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700213969; x=1700818769; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sjYIebSJkP9e1/mTJ8eYq0dj0uvlLQm1sCo0VBP76wk=;
        b=BmAoUX59vMc4Wol7s4nJ1PGfcOXyYeCr14XaHsYlP8S7mIQkbyGKwalS2jMrm70fWx
         JGBWlATvNt7tMQoos9sLYYhcVLAroEwVbBu1DPnlLjv41lwh6S2SOcRYywZSrmOys0Ut
         Inxm3K6G5L5nESAugemMC09Xld9n9M5RwLZ3zjMjClLn48mezE4S4FBOn4Ez1FlPcgfy
         YvEj99RHY6R+mrbcirmssVB0WUu5dfjrc2D2ijEBfxU0PM5NSe94qQXMkpgVaZwY8ODb
         klUQrghgUetqbqpNDv5X0CXiyM0hXEBgaysMrNBH1QtzLLz7ESKeHVi9+MFF8NBxfiIg
         /rAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700213969; x=1700818769;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sjYIebSJkP9e1/mTJ8eYq0dj0uvlLQm1sCo0VBP76wk=;
        b=FAr+7GLgrtmQPPiniQZaWIOmbAb6u7D8jFiRPDzEnCBccYAF8QOSqOHwfiSc0s98af
         MgcPPn0aE5n8ipzVs5sE4hjNRLoub/Co/c1QeJJRQe9qSsEWA/cSsvxsRZ0edtDRGefJ
         BhoSEGEFjkEZKqnwXcE8VLuzblkwuGsCMp9j86kzBuq929VA2smO7ogkgSl+hr0WVVNn
         rWS8QCdx+EH5TPaXMQ/v+rrOkBHiRLS74G2ZeZyARFq/DkvdgCesiFSpUdus/wlcJ3TT
         pYl83iK9ykvlBGl+H5ZalEHd9DARQxkJrbJ/u1ithZgVlRpvVKPQXflyA4dIszxGWPhz
         XkKw==
X-Gm-Message-State: AOJu0YxPYR6zLlcvGjRqG8FTllkAQyAsMSBK7VEhutWr6IXIrxmleHHM
        sgXG1PPmhfe4EHPkrlsr6japr3Ohx98Ypw==
X-Google-Smtp-Source: AGHT+IHoW5HRd1WwvEMIQ4H+ZEahnDGhytTgbVLpCmyqxooVD0GQVS1M1CySHtWzYrURV0YbPD/B+w==
X-Received: by 2002:a17:903:249:b0:1bd:c7e2:462 with SMTP id j9-20020a170903024900b001bdc7e20462mr11918357plh.11.1700213968966;
        Fri, 17 Nov 2023 01:39:28 -0800 (PST)
Received: from archie.me ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id j8-20020a170902690800b001c76fcccee8sm988111plk.156.2023.11.17.01.39.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Nov 2023 01:39:28 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
        id 2C149102A8300; Fri, 17 Nov 2023 16:39:26 +0700 (WIB)
Date:   Fri, 17 Nov 2023 16:39:25 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Turritopsis Dohrnii Teo En Ming <teo.en.ming@protonmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     ceo@teo-en-ming-corp.com
Subject: Re: Teo En Ming has just discovered that the latest Sophos Firewall
 SFOS version 20.0.0 GA-Build222 is running on Linux kernel 4.14.302
Message-ID: <ZVc0zQHbfdBOQAZ0@archie.me>
References: <rjsYjj5lRT_rd91lLJ0DutYwgag5By6ghI92s1AFP5asT4IDtTlKhkt56KrcNBGKEKMWQYn430H-bs3-IS4GjEFQjKd79ZHv9iRDd1EVQiU=@protonmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="eXblP7j5LObTY+Ne"
Content-Disposition: inline
In-Reply-To: <rjsYjj5lRT_rd91lLJ0DutYwgag5By6ghI92s1AFP5asT4IDtTlKhkt56KrcNBGKEKMWQYn430H-bs3-IS4GjEFQjKd79ZHv9iRDd1EVQiU=@protonmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--eXblP7j5LObTY+Ne
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 16, 2023 at 02:19:47PM +0000, Turritopsis Dohrnii Teo En Ming w=
rote:
> Subject: Teo En Ming has just discovered that the latest Sophos Firewall =
SFOS version 20.0.0 GA-Build222 is running on Linux kernel 4.14.302
>=20
> Good day from Singapore,
>=20
> I have just discovered that the latest Sophos Firewall SFOS version 20.0.=
0 GA-Build222 is running on Linux kernel 4.14.302.
>=20
> # uname -a
> Linux localhost 4.14.302 #2 SMP Wed Nov 1 07:16:58 UTC 2023 x86_64 GNU/Li=
nux
>=20
> However, I do not know which Linux distro Sophos Firewall is based on. Wh=
en I run the Linux command "cat /etc/lsb-release", the output is
> DISTRIB_ID=3DSophos Firewall
>=20
> Hence I do not know which Linux distro the Sophos Firewall is based on.

Most likely your vendor build their own custom distro (maybe Yocto
Project-based or anything between). Hence, if you have any problems with
it, please contact the support channel provided by your vendor (in your
case, [1]).

Bye!

[1]: https://support.sophos.com/support

--=20
An old man doll... just what I always wanted! - Clara

--eXblP7j5LObTY+Ne
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHQEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZVc0yQAKCRD2uYlJVVFO
owfcAQC5Sm8nu5VqtG9YZogqmeaJJgu241rgj++w0OnbGsBeLAD2Jj6iDPrNaW9q
OH+kRwKNeLYCn7h7iC1D+aTX2d1UDA==
=Scju
-----END PGP SIGNATURE-----

--eXblP7j5LObTY+Ne--

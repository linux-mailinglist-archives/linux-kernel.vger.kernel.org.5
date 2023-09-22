Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70EFA7AA639
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 02:51:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229637AbjIVAvr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 20:51:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjIVAvq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 20:51:46 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4693118F
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 17:51:40 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1c44a25bd0bso20364025ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 17:51:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695343900; x=1695948700; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3O9qqdgcpqsYrAZT3dHjm6k0/DWwMV6qxt+NZA6a0Io=;
        b=WTV2LcEgICsXumwLxO+EPVK2loWr59SXDDyDiKxOWElbSCAn1dPAsPGRB9wFHSVLvq
         q9QKowjMw7gO3+8bxqmpN3NkRWxJrDX9fHoEApOJg6laOJ48Yo1LV/iPsHnOpuAHmVLg
         eNJm8h6rofvXDYIfFy8dSYWFkY+WxvmXfLrymRoekqUO7Z/t7woY4wihhmHZ+0Ppt31O
         UbpDfWRb9DPiCwF75jdiSP10AvfSJbM9i1l5+4R9+EsNyM6o0AHCbZVWWx7Wn6nnItke
         omgF6h8dXDExj37o2mBg8J1Z+5uYBrXPFxROr4kbUDaSZfvyGoejKzPAL+RABE48gQt0
         hqLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695343900; x=1695948700;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3O9qqdgcpqsYrAZT3dHjm6k0/DWwMV6qxt+NZA6a0Io=;
        b=Q01GHCMjGWIcq/7KG9klQS5RoZoutnDtNFyhlit2anmuZ/w9Q8KMzoIxmJP9wrSGa5
         MBQtzY1Jpm1r1U392Ps50Dyq7QDe6/S+qAZ5A30zqfQwMXI06CAic7teX/Kyznix0bWE
         trG0NCnqvUFJ63SsmEb0FbFY1snIK/MClpu8K44BK8dcDnvxvYTrIeNRuR+tsxK96XBx
         e6ZEixmqtyY7qWiHmCAIA1VwDLefTgmLlbJl6rxmBC1zFhNGD8hM+qW7upu2wm/5jgx+
         PpC/FJq+TzYve5Y5wdaInzW6nv0mZKNK30nHtuISSUmAPx/oYXTYU6iY4Tfu2V7bC0Ii
         HQsg==
X-Gm-Message-State: AOJu0YyNPQeZKrkc/StOuhQ23O6O+g8Ub0YlHkuKvnm7a9cusomLS1Qp
        JSR6YDFR8h4xp4PDnPTwr1H3diK3krg=
X-Google-Smtp-Source: AGHT+IF8OaBATs+5ZQTrgBIdtagHMKLd5mfqMaeVbDaWbmCZKyTX93NyRt9CGjbMIXn2AigpvJzdAw==
X-Received: by 2002:a17:902:d483:b0:1b8:a67f:1c15 with SMTP id c3-20020a170902d48300b001b8a67f1c15mr1790222plg.25.1695343899625;
        Thu, 21 Sep 2023 17:51:39 -0700 (PDT)
Received: from debian.me ([103.124.138.83])
        by smtp.gmail.com with ESMTPSA id c8-20020a170903234800b001b8b07bc600sm2173173plh.186.2023.09.21.17.51.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Sep 2023 17:51:39 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 837FC81B96D3; Fri, 22 Sep 2023 07:51:35 +0700 (WIB)
Date:   Fri, 22 Sep 2023 07:51:34 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Turritopsis Dohrnii Teo En Ming <teo.en.ming@protonmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     <ceo@teo-en-ming-corp.com>
Subject: Re: My brand new vivo V25 Pro 5G Android mobile phone is running on
 Linux kernel 4.19.191+
Message-ID: <ZQzlFgJTZzTVkKeN@debian.me>
References: <P8CgyFkx_9MPXgwLiaVhdarl-IlxfJVH1voL4ttdXP0yJcLyE5nw9y537LZceOC6BkXVxzuwXjQHmeGGUDI_VbPgfDXengI-5A9ua9csUqc=@protonmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="e3FWOJ55CWHjw/gI"
Content-Disposition: inline
In-Reply-To: <P8CgyFkx_9MPXgwLiaVhdarl-IlxfJVH1voL4ttdXP0yJcLyE5nw9y537LZceOC6BkXVxzuwXjQHmeGGUDI_VbPgfDXengI-5A9ua9csUqc=@protonmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--e3FWOJ55CWHjw/gI
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

[trimming personal and obvious *political* info]

On Thu, Sep 21, 2023 at 04:20:06PM +0000, Turritopsis Dohrnii Teo En Ming w=
rote:
> My brand new vivo V25 Pro 5G Android mobile phone is running on Linux ker=
nel 4.19.191+. Are there any severe/critical security vulnerabilities in Li=
nux kernel 4.19.191+ that will allow government-sponsored or state-backed h=
ackers or Advanced Persistent Threats (APTs) to take over absolute control =
of my brand new vivo mobile phone? Can I download, compile and install the =
latest Linux kernel 6.5.4 from sources on my brand new vivo mobile phone by=
 myself? I would like to know how I can do it.
>=20

There are Android Security Bulletin listings on [1], with vivo-specific
bulletins can be found at [2].

For building kernels, you can follow official Android guide [3]. Or
you can also visit XDA forums [4] where people posted their own custom
kernels. But usually your vendor (vivo) takes care of kernel updates
anyway.


> I have decided to buy this vivo mobile phone because my Samsung Galaxy A3=
2 5G mobile phone has now become extremely slow in performance and lags lik=
e hell. Maybe too many apps were installed.

What are these apps besides built-in ones?

> Opening and using apps is now a slow and painful experience. The phone ca=
mera is even worse. Taking a photo or selfie takes 2-3 seconds. If you move=
 the phone by a bit before the 3 seconds is up, your photo or selfie will t=
urn out very blur. So you need to set a timer of 2 seconds when you take a =
selfie or photo. Taking videos with the phone camera is also very laggy and=
 choppy. The recorded video will turn out to be choppy.
>=20

What is your Samsung phone specification then?

Thanks.

[1]: https://source.android.com/docs/security/bulletin/asb-overview
[2]: https://www.vivo.com/en/security
[3]: https://source.android.com/docs/setup/build/building-kernels
[4]: https://forum.xda-developers.com

--=20
An old man doll... just what I always wanted! - Clara

--e3FWOJ55CWHjw/gI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZQzlEgAKCRD2uYlJVVFO
o3u3AQC/7ajETLU1Dpa5sFWKmibnDfc+1Ri6gSj8IKqWKdlSPAD9GQZsZ6TlBNNX
GM84n6W3xbHHjiKEO+ZPaD3a46EdtAk=
=vv7+
-----END PGP SIGNATURE-----

--e3FWOJ55CWHjw/gI--

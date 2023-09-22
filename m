Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCBF87AAA39
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 09:27:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231232AbjIVH1a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 03:27:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231341AbjIVH1X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 03:27:23 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D9171AB;
        Fri, 22 Sep 2023 00:27:17 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id 41be03b00d2f7-578cc95db68so1098283a12.1;
        Fri, 22 Sep 2023 00:27:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695367636; x=1695972436; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0JwtvcMX0Vd+Xc7guGazpkfS0KLQ5uU83L1DMPcX7c0=;
        b=TyTvhvxxuwRNqM/Rph87+4tLo5evjFQi5MGEgDJ9qeq+sOUWSzPha8rnN+EeRf6WYX
         R0XDpZUwqV05JYeFftjreIRQKT3YZBCl5NEevljGty9sqSj/cKqKXnC05ucS5qb3JZhF
         QE7nobBvTS1TvB/rVzvs8BSeheou4MqAqTKyXcVhzfDM5dMdkmf4DNTThkMASsQAd4Qy
         lpuafkTczBiM3Np3RRhzrppQGlz11kwL4wp5mHlka1wlrqzYA0oMiSElmKmeF+0c0kAU
         Uy2uenWf1I+vvPRJyP/dVQajPatdYQbspv0mUlzE6T8+ofojhxHuFj/T1qtInpR5bTJk
         oziw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695367636; x=1695972436;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0JwtvcMX0Vd+Xc7guGazpkfS0KLQ5uU83L1DMPcX7c0=;
        b=wxH6w1USulOb/y987XaVJqtPz0BLF60yArQEQkb4tMR7ptC897zH3jjknuhM3nyhKy
         UOWZSBXh0aM9yqFj6nSxHN//t7iuN/fNeH9uAn8RdZvyF7jXp/osgM94TrLnDvMaiIa5
         Pq6uBup2xSU25ftrDrOXG3Zk6TJCmx/sW4cXaRgm8p6yYZ9kUWPq0miIShVlTy8SmA3J
         W+iNNLKn2JQ5f06V+te+62c6UayrrqErJLc/qmkG0JhqpjHCyxNSOoNY1aZaW4XNapB2
         HOxhGf88W8c9EnKZU7tLtvHfZFWhApbYlPqU3mSGI79uUVm15XizH6xawXWh/YZ9AETI
         I1Bg==
X-Gm-Message-State: AOJu0YxkM+AwPGmqRnFTSivMmcKuwySGUA0H99Dltl8bmNPqj6z5HzEZ
        8stOJ+c4QCuMOtq0q/V0UyM=
X-Google-Smtp-Source: AGHT+IFbYG6pVjqpMpgJyBCuwhUS40Y/AbHgpCrvrwP3q5cCTs2qJY5nAHnR9EEHahteB8WiHojLRA==
X-Received: by 2002:a17:90a:ec12:b0:276:86e0:2e45 with SMTP id l18-20020a17090aec1200b0027686e02e45mr7722483pjy.43.1695367636179;
        Fri, 22 Sep 2023 00:27:16 -0700 (PDT)
Received: from debian.me ([103.124.138.83])
        by smtp.gmail.com with ESMTPSA id 9-20020a17090a190900b0026fa1931f66sm2826648pjg.9.2023.09.22.00.27.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Sep 2023 00:27:14 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id EF58F81B96CF; Fri, 22 Sep 2023 14:18:18 +0700 (WIB)
Date:   Fri, 22 Sep 2023 14:18:18 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Johan Hovold <johan@kernel.org>,
        primalmotion <primalmotion@pm.me>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux USB <linux-usb@vger.kernel.org>
Subject: Re: Fwd: unable to boot when monitor is attached
Message-ID: <ZQ0_upwsFTIduIRQ@debian.me>
References: <5eb57bfe-94a4-136b-497e-deeb31846db1@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="5zNn6a6lC8WX+A05"
Content-Disposition: inline
In-Reply-To: <5eb57bfe-94a4-136b-497e-deeb31846db1@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--5zNn6a6lC8WX+A05
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 07, 2023 at 07:10:13AM +0700, Bagas Sanjaya wrote:
> Hi,
>=20
> I notice a regression report on Bugzilla [1]. Quoting from it:
>=20
> >=20
> > In the latest 6.3 and 6.4, it is impossible for me to boot my laptop if=
 my DELL U2720Q monitor is plugged in (USB-C). I have to unplug it, then bo=
ot. As soon as the first second of boot went through, I can plug in my moni=
tor and there is no issue afterward. There is no issue waking up after susp=
end. Only when it boots.
> >=20
> > See the attached pictures of the trace. The trace itself seems random (=
at least to me :)). I tried several things, like removing any attached USB =
devices from the monitor built-in USB-hub, but that does not change anythin=
g. (there is a keyboard and trackpad attached).
>=20
> See Bugzilla for the full thread.
>=20
> Unfortunately, the reporter can only provide photos of kernel trace
> (as he doesn't have any other means to extract kernel logs, maybe
> connecting over serial helps; see Bugzilla for these attachments).
>=20
> Anyway, I'm adding it to regzbot so that it doesn't fall through
> cracks unnoticed:
>=20
> #regzbot introduced: v6.1..v6.3 https://bugzilla.kernel.org/show_bug.cgi?=
id=3D217637
> #regzbot title: unable to boot with Dell U2720Q monitor attached
>=20

A PureBoot developer noted that this regression is firmware bug
(see Bugzilla), thus:

#regzbot inconclusive: firmware bug, fixing the kernel only workarounds bug=
gy firmware

Thanks.


--=20
An old man doll... just what I always wanted! - Clara

--5zNn6a6lC8WX+A05
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZQ0/tAAKCRD2uYlJVVFO
oytiAQDhMFXIMa+wDyLn9PG9q2fzQL4Vy+IYfbh3qAPSVGCrVAD8CbahBPeHB79o
TJQTY3QecxcTIqJMtI7lVcfRLbYCQAQ=
=DCBu
-----END PGP SIGNATURE-----

--5zNn6a6lC8WX+A05--

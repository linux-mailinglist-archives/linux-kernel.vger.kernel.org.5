Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E06C7AEE39
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 15:54:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234841AbjIZNld (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 09:41:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbjIZNla (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 09:41:30 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0085795;
        Tue, 26 Sep 2023 06:41:23 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-2bffd6c1460so137833251fa.3;
        Tue, 26 Sep 2023 06:41:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695735682; x=1696340482; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bNLkBZL0rptK8jKeUGKxByFO6I6oW3HmWWY23t4bNw0=;
        b=kuWYwtj0rz3tUaWSIjdHZs2/hGTo8XWoeC/n7Ym4A7x1cZ52rnfsWhhEitZfNRUFIu
         7zmeB42XSraj3a1sf3hJe3oNehmstFhQ/uei039kCreu1nVmREluWbo/O1sFwj+h3PTl
         T0sIgmICsr7QTfA6iTeFy7nnFD+etZa0luP8AQC+km9n3DPqoohTiNp+iuVJxQBgTOPi
         m3YBWnZWTaJk2T/SxlUXFRbGZmlHB33R5w3SA1aGcwrgLPg/ExIgRiQFg7m1U1Gl/D/2
         ht8Zm/Nr+RdKD635ckxXrISjdORhamBD6IoQRDgksUJhS78OT3ulbRoYKx57VfMeeyO6
         F9nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695735682; x=1696340482;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bNLkBZL0rptK8jKeUGKxByFO6I6oW3HmWWY23t4bNw0=;
        b=L3Axd4TB6RY9tUIWEOb7Xsi0zJ6K9+mNGmCkIHCftUs7eHTEtv8q+8hhGwtKmn9GfC
         nyqrYANx62nfrkFYrLEEDD+sQYpwjv+irbsFk3uoCDm5HovHR3/FaN67BTCIyEiX1Gia
         eu1G1EoA4NMvWihcs6tQkPFdT8gd8ZPL7/dj3KHnrTA3VXSVSReE2DehTvrx9b2YNudR
         MejpA9u5iX3ggfACV9skUW1nxuJf09sbnhMCHLpKbpi1RgevyG6obxW5QfOy+NlrLKvZ
         1RZLzNqF6B7VorZ75S/c7/WZQRiEcjPGu3PXMXzSSV1MxnM1j+NUq6ijVaZ2DoZtBT6D
         ZMMQ==
X-Gm-Message-State: AOJu0Ywx6HqSVEel7e+nhEH1Ulh6Qw2uYeSv/J+v8TgtaT+IfhZrnlDA
        KJVB7HjiHCF+XVJthevYqaA=
X-Google-Smtp-Source: AGHT+IFpzA175jENXwY647KdaoVZvXZq0i04+ef7ayW8jsXSkPkooCJWUorQVuRxt8AGPA/TgmYOdQ==
X-Received: by 2002:a2e:9510:0:b0:2b9:f13b:6139 with SMTP id f16-20020a2e9510000000b002b9f13b6139mr8395537ljh.20.1695735681806;
        Tue, 26 Sep 2023 06:41:21 -0700 (PDT)
Received: from orome.fritz.box (p200300e41f3f4900f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f3f:4900:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id d19-20020a17090692d300b009ae69c303aasm7290247ejx.137.2023.09.26.06.41.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Sep 2023 06:41:21 -0700 (PDT)
Date:   Tue, 26 Sep 2023 15:41:19 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc:     linux-tegra@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Prathamesh Shete <pshete@nvidia.com>,
        Thierry Reding <treding@nvidia.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH] pinctrl: tegra: add OF node when logging OF parsing
 errors
Message-ID: <ZRLff1v-dta7EZGO@orome.fritz.box>
References: <20230926103938.334055-1-luca.ceresoli@bootlin.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="MAiZd4Qo4mVreNpi"
Content-Disposition: inline
In-Reply-To: <20230926103938.334055-1-luca.ceresoli@bootlin.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--MAiZd4Qo4mVreNpi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 26, 2023 at 12:39:38PM +0200, Luca Ceresoli wrote:
> These errors are not quite clear without also logging they device tree no=
de
> being parsed, especially when the pinmux node has lots of subnodes. Adding
> the node name helps a lot in finding the node that triggers the error.
>=20
> Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
> ---
>  drivers/pinctrl/tegra/pinctrl-tegra.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

Acked-by: Thierry Reding <treding@nvidia.com>

--MAiZd4Qo4mVreNpi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmUS33wACgkQ3SOs138+
s6GNvRAAp9rjy7ooTlvjwNMO8jUufTQ1wCgDALf+JRz9TY2bD31vmfEBuxkRkLJ1
io3HK9mwE5nc/2bhprhxOxMS3JgXbEXJ8vhYDjowL8UhNBKMW7iR+9UWzhAmGyKe
+g8Sjhhmsk4o538F6buVpJsy8D7j0EtMTWE0MYYiA9ImFi5jsyAVPW7++he3ytl7
iDFxcUWWh+DxGjIwBwu7qEy1x24tZ1d1PT4lC/NdauJrKzNpjUabtCgTsDcteHQu
BHe+RVyNE3rOA2HjVDKwHpcxGtZ5kAhX2/Nd8wMF5biytuTkym3Y8r6ngvjRUQLP
ab/3vMojTpgVP8vU84dk87fBlsqOKjvCE4YgKUgPVxF9wrTx00VJw0eNr3RITQ0B
G8YdwyEElr4J3cY5M5jZS24QByCjDx6y+1MB9F6jxnXdD9HgEvv7/D0GCnGi36MT
RY3YOzC/fhNIfb+RhV3yIiIEf2LjRzgrBaLr7w7SRff9pJbZb4K6mLExf8mUPYwu
gJFwcvN5I36QcW5TL7aTcX48IzqdOlnUnhW3AVB7uNXzfKowKt3fVFdfbbvF2pjI
zpKyB9sRb57mO93MhwRRAg0M3vMGlw0v2XatSJLl4UhrDYAJWVTapJOG/6UNuv/+
FHauMsHzkZbGnwuVGskmlLhSBb34QC7w4K2QciAw68HZZJnhO6E=
=Pd1B
-----END PGP SIGNATURE-----

--MAiZd4Qo4mVreNpi--

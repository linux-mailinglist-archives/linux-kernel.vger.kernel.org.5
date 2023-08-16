Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1B5277E677
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 18:34:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344728AbjHPQdg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 12:33:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344724AbjHPQdb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 12:33:31 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1E4310EC;
        Wed, 16 Aug 2023 09:33:30 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-3fea0640d7aso27037485e9.0;
        Wed, 16 Aug 2023 09:33:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692203609; x=1692808409;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SJiIlHMyQfQBxg1cQn+zdj6Ql8K07Mh0YWe2mQONyeY=;
        b=HGtjfdNoLqTLOk0xezZfmS/VtqcwNWuYLrD1NxJhfsUpGrErobTkis/lWs5b3aBu5z
         EVhgfnKEguvBfyRmWETL9HLdfN63Hg9YjTKJxHcmbZ9VEiRI5W0EWOOa55ghYv8vlXcI
         UrjdKQLi6I856L7MXM8+YwsPfnf3mQ2ivLmleRW6TGfb4EEqHI0Bh1BVeXWb80OFNINt
         /cMnr6FSZxx25BpFMN6UccvIL7JjPUR7kDaLhmCmdqax4gMKOBIJ9VGaet/4qGXE1+OE
         yaAgFDb32bL9l+xi1zEnFW8cTWAKdvasaoUqfGajzG1BbnJtGhOm6b4CkSb/gxQnHxiU
         Xqfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692203609; x=1692808409;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SJiIlHMyQfQBxg1cQn+zdj6Ql8K07Mh0YWe2mQONyeY=;
        b=ObEfIWk0UoX8o5S8FsGyc/K0vET4dfsR5TZmlCOBJ6HmJC1iUHEo5c2D+66N0pQCZ1
         gS4xfPU/jdGcglogUjtfTM7DbuFfluCbG+5mOdceAljdZDy7cldNUlADvRshbYs6Vt2A
         UwXN5X6IlvilibwikqJcN/eWKSJZS9IuW6jIbuRZiim8ZAINYxTxOTEnuz/m+MIecTIp
         IKuW9rWtfZ2m6U4kyUbfUO76VR5VA2mZMCkRY0sKtgkcOpKfSgs7D/QOllqlQi+gi8YD
         /AZhkyfnF6joD7vzi5R/oxBd3sukUPnId8NbzSGAE27P42Oz8uvFzt/6MLjuNf2BoPHp
         ESFw==
X-Gm-Message-State: AOJu0Yz22hq39ayAH8bHPBp5a6M8L3GVUDxov+bSeva3DEgqmKHWdckS
        G6uomEZ3bW8BZ3dMyp5J5eg=
X-Google-Smtp-Source: AGHT+IHEpWpfZ1DHgdMXnjReXK4pTFA+kdNsij/sWEtkA+1duw8Cdve7xYI3f3KOoy8g61gydwYUrw==
X-Received: by 2002:a7b:c445:0:b0:3f9:70f:8b99 with SMTP id l5-20020a7bc445000000b003f9070f8b99mr1870969wmi.7.1692203609014;
        Wed, 16 Aug 2023 09:33:29 -0700 (PDT)
Received: from orome (p200300e41f1bd600f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f1b:d600:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id o13-20020a05600c378d00b003fe2de3f94fsm21665509wmr.12.2023.08.16.09.33.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Aug 2023 09:33:28 -0700 (PDT)
Date:   Wed, 16 Aug 2023 18:33:27 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Svyatoslav Ryhel <clamor95@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/1] ARM: tegra: transformer: use labels for mmc in
 aliases
Message-ID: <ZNz6VyWASDV2Srie@orome>
References: <20230730125150.4716-1-clamor95@gmail.com>
 <20230730125150.4716-2-clamor95@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ny3DNPUHaADqAo+m"
Content-Disposition: inline
In-Reply-To: <20230730125150.4716-2-clamor95@gmail.com>
User-Agent: Mutt/2.2.10 (2023-03-25)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ny3DNPUHaADqAo+m
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 30, 2023 at 03:51:50PM +0300, Svyatoslav Ryhel wrote:
> Use phandle references for mmc instead of path in aliases.
>=20
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> ---
>  arch/arm/boot/dts/tegra114-asus-tf701t.dts           | 12 ++++++------
>  .../boot/dts/tegra30-asus-transformer-common.dtsi    | 12 ++++++------
>  2 files changed, 12 insertions(+), 12 deletions(-)

The commit message doesn't describe why this is useful and without any
clarification I don't see any benefit in doing this.

Thierry

--ny3DNPUHaADqAo+m
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmTc+lYACgkQ3SOs138+
s6Ea9g//Si9Hn5wMkV/kg3fuFRiYST1VVeW3vWe/P9gvqeQ0H9leDW+hw90YmVHw
a349WWe4UFuxGNzz/+CyEYjwLiHWJD4SxjzIzUQSm7qhYs8iJLrTNzVaB43KQH5L
KF62VIQWDQbCbmoqdnrbvXTeVadv+F988sG3Zc4A3P43mQgqgIaOEMZvFQ0xrWTm
zA9CrTA1TyQTlZ5uG1PC4dBMOY3YqQQT2nwsA4nKNDF2X6xG3gTZ5FZ8ss0qQ4lX
m8bzFUKSoSTQApvs1f0eDmarSIdRFeL9WAKIR3K6bG3irO/JNbizM5iEcL/s55JV
5YBCnuNOxqADZtUD79NdnWYJACCftJAf4qX8HxJINLjpnWVaEPcXFvbEP0yni/b3
QLErRQkVIZditEkhJtlsNUHW8+RlPj2oKvJ7FOf9WzlZZLSqAE0myipN1i7xkLPX
mrj/zPw9KcJ2oqpqUGSS/QPf4vxxsat61OzfnUHP0oqlMAweDGSbGdSr4C03dRvH
W44XTemR05OyQfoXXUHwLrtds7HIA0FO5ux3m8mJTWSOWek0v5VGY7ygGkZxIsC+
St9eZ5pasvwo5Ow6pbZwYacm0HlKLdHyiiYqCUwngowix2Ko2SPxziMw0pE5JZNe
XCi3tcdi/JybCUL+nvKXXlsH3iSEfD4UHL7mCxQffl5AUzWTGIg=
=x+rY
-----END PGP SIGNATURE-----

--ny3DNPUHaADqAo+m--

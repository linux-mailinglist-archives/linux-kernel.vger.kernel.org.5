Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E60680661A
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 05:20:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229920AbjLFESx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 23:18:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjLFESv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 23:18:51 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1827D1A5;
        Tue,  5 Dec 2023 20:18:58 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1d06d42a58aso37437355ad.0;
        Tue, 05 Dec 2023 20:18:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701836337; x=1702441137; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EnOakwJSZEMXurMo6+U/wHyOLz0a7/wLe2qMpZ+kN+c=;
        b=GInYH8oaf1TAoIwr/GsQ4PFAhPKpkU9saqwjD24WV399r0f8x7WDNsadwv6E6++k5y
         DwsrIWgsPSvHIk+Xd3m/3KXX5QiZmmOizdl3Ri9U9f+wpH0aCGeUaITho0VFfnoIh3/v
         0EkwUsP8JZEfAyEnTM+fJwjY1TkEbgPDE4tXIWQ2DxqfMsaqYTcpcgb2ZKNO9BJO66Xt
         yDIglY30HRy2VYDF6vMe9nrVG6Vpxg5J/edtPMltRPxd8JoW1iJ1wlXTCV+WBvRIIyjK
         k3hEjQBc3TVXZzjnqt7Db7eEFvkg/ksnoonJI2OtLgclGuIPoMQJ1H6GX7YEFG+8mtaK
         G85w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701836337; x=1702441137;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EnOakwJSZEMXurMo6+U/wHyOLz0a7/wLe2qMpZ+kN+c=;
        b=BZIZaxy/aLnaf4j+Dye8AI1kgb4Ae78aMal2tHHxaICK1ISAOKWHC/iwHMYVIlWAxR
         WmyUJ9pRjANn16dSRPVHu3LmBFES5Edj+dquqNwIxSmYcDUIvqaDq60CsPEFWk2rB2tM
         SnyPJBM2RzgMsr5LL0v7u/fKzEhUAvl2/6WfJnU4Q2/z+s6vVODTfiGOGpYfmc3UAmHz
         HjCAQ8lJvIZxoIoYU5g+YpHCkNVvyKo4wJZ09fkjtdHTLYMTEtiTWAGw76KRz/6BigXD
         7Fwl7KtDaQBwJMuc50slFoJNH2LyrjIzbc9X+tqXA0eMz9xepu0PoCTcGLPGDoYZWGyf
         DBdQ==
X-Gm-Message-State: AOJu0Yxrz1WcGDwgxvNQUgbPoo+k/ltCPLpdwfuFx6LwR30E6U5WTjlG
        ushy9zfnQVH/KfSYRIf2KIo=
X-Google-Smtp-Source: AGHT+IGwYMwuuHOFLKK7EM7JZmxdLjMb1fz7JcZN3Fcul6VqK0lzJh/7yid2Msc0YJDeb44O5XIa9w==
X-Received: by 2002:a17:902:bb89:b0:1d0:8cbf:39db with SMTP id m9-20020a170902bb8900b001d08cbf39dbmr278668pls.88.1701836337416;
        Tue, 05 Dec 2023 20:18:57 -0800 (PST)
Received: from archie.me ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id jh9-20020a170903328900b001d087610dbbsm5749697plb.55.2023.12.05.20.18.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Dec 2023 20:18:56 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
        id 2BF6C10211A57; Wed,  6 Dec 2023 11:18:55 +0700 (WIB)
Date:   Wed, 6 Dec 2023 11:18:55 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Kory Maincent <kory.maincent@bootlin.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Russ Weight <russ.weight@linux.dev>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Oleksij Rempel <o.rempel@pengutronix.de>,
        attreyee-muk <tintinm2017@gmail.com>
Cc:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Linux Networking <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Documentation <linux-doc@vger.kernel.org>,
        Linux Devicetree <devicetree@vger.kernel.org>,
        Dent Project <dentproject@linuxfoundation.org>
Subject: Re: [PATCH net-next v2 4/8] net: ethtool: pse-pd: Expand pse
 commands with the PSE PoE interface
Message-ID: <ZW_2L8CXE3EvWZkF@archie.me>
References: <20231201-feature_poe-v2-0-56d8cac607fa@bootlin.com>
 <20231201-feature_poe-v2-4-56d8cac607fa@bootlin.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="zldVynBk0CTsfgMg"
Content-Disposition: inline
In-Reply-To: <20231201-feature_poe-v2-4-56d8cac607fa@bootlin.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--zldVynBk0CTsfgMg
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 01, 2023 at 06:10:26PM +0100, Kory Maincent wrote:
> @@ -1741,6 +1757,7 @@ Request contents:
>    =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D  =3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
>    ``ETHTOOL_A_PSE_HEADER``                nested  request header
>    ``ETHTOOL_A_PODL_PSE_ADMIN_CONTROL``       u32  Control PoDL PSE Admin=
 state
> +  ``ETHTOOL_A_C33_PSE_ADMIN_CONTROL``            u32  Control PSE Admin =
state
>    =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D  =3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D

I get htmldocs warning:

```
Documentation/networking/ethtool-netlink.rst:1760: WARNING: Malformed table.
Text in column margin in table line 4.

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
``ETHTOOL_A_PSE_HEADER``                nested  request header
``ETHTOOL_A_PODL_PSE_ADMIN_CONTROL``       u32  Control PoDL PSE Admin state
``ETHTOOL_A_C33_PSE_ADMIN_CONTROL``            u32  Control PSE Admin state
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
```

I have to fix it up:

---- >8 ----
diff --git a/Documentation/networking/ethtool-netlink.rst b/Documentation/n=
etworking/ethtool-netlink.rst
index e02a7dabc673e2..8da5068105e3e9 100644
--- a/Documentation/networking/ethtool-netlink.rst
+++ b/Documentation/networking/ethtool-netlink.rst
@@ -1757,7 +1757,7 @@ Request contents:
   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D  =3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
   ``ETHTOOL_A_PSE_HEADER``                nested  request header
   ``ETHTOOL_A_PODL_PSE_ADMIN_CONTROL``       u32  Control PoDL PSE Admin s=
tate
-  ``ETHTOOL_A_C33_PSE_ADMIN_CONTROL``            u32  Control PSE Admin st=
ate
+  ``ETHTOOL_A_C33_PSE_ADMIN_CONTROL``        u32  Control PSE Admin state
   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D  =3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
=20
 When set, the optional ``ETHTOOL_A_PODL_PSE_ADMIN_CONTROL`` attribute is u=
sed

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--zldVynBk0CTsfgMg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZW/2LgAKCRD2uYlJVVFO
o2vsAQCrFvF27gWP2tiBdZgRzsDWD0JJJN6ujwKd0C74wxlu6QEA8D2ShfGQ/QS+
46V1jUgOAHlUqtbGjJXC0IyRqiey+Ak=
=HaEk
-----END PGP SIGNATURE-----

--zldVynBk0CTsfgMg--

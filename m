Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A32881375A
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 18:08:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443669AbjLNRIa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 12:08:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230314AbjLNRI1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 12:08:27 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2CBCA7;
        Thu, 14 Dec 2023 09:08:33 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id ffacd0b85a97d-3363aa1b7d2so1790258f8f.0;
        Thu, 14 Dec 2023 09:08:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702573712; x=1703178512; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8OE/8mXjrMU0VRAVo2/zTiAmO3H3nOr6wGjTnBkrh1Y=;
        b=NsDlk9J5olvYaC4Rh4NKLu8zhjr+AJus3QeUsLXhhG0S3CjYhfXaNB0FTvqFVuu0/h
         SaPe6Hu62u0meKlAAq+atGI9sWytsH9u9+LCSNe82gHHzt7tUOLaZYxU1mVsYGke0KEo
         tE8kZEfdlxL8xmdNwAC1dgGWRoivViEMHL4hcAcRHv3sg4vbxflF6M5VvYD0YV9MuIsp
         FFnty0g6Pc/v5kp1E1XfzrcBOLJrc5JStpCl70fZrn8lbrs1Z77uEeic+wCqU/ZIKVlV
         0OIGcbJCRVmPvbmKXAcdJz/Bs56ZYARMYVE/c02Oe8hOp7eIwBgdhkWaJ0/Pbet9NFF2
         +bWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702573712; x=1703178512;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8OE/8mXjrMU0VRAVo2/zTiAmO3H3nOr6wGjTnBkrh1Y=;
        b=wBPf2Alk1BzUmczD4IQqXSoLtNpLEDOuEHQ1dDW8y3GzSUj8R2KGP9OX5TavtqL2Ny
         0IHl+1Ad3+VikEFqMpjnd0vN4sfyypbWZf8a9WOl4wrVLyQJEdxgwzU8Vg3XpWIdQydZ
         YzgECigtDWmLRFdxoCbmzj3TJnKxkh2asE752ehjDNa4dYwk8Fy0OwzN0TgViunoL1N/
         f16cnh9IxZgEcwL80YORS7hBubjyxlmW8Hn9DMdmTo/iMOMlrewH0qVR+9KYHxAiUDSD
         HuLu1tqj7bZ5IDIfZ3PBxqoEX6fnP2VtbPBc4/wh4aFW6NpqGJf14+vhx4iyba2km6BE
         06jA==
X-Gm-Message-State: AOJu0YzMtAz3oAvNXjkx4LdV4O0m5wJEPZtTxciUoR0qOdMI/wRrsTiC
        yvRhuZ+R+Q1d6lqATB8VWt0=
X-Google-Smtp-Source: AGHT+IEAUYfOBXYYnc2yQqqz71wshDGUNQnukfsm5O9xbU1g8r/c72f5CCNKZoJCbdtbW9F8wDuiQg==
X-Received: by 2002:adf:cc92:0:b0:336:4c79:3236 with SMTP id p18-20020adfcc92000000b003364c793236mr156665wrj.38.1702573712021;
        Thu, 14 Dec 2023 09:08:32 -0800 (PST)
Received: from orome.fritz.box (p200300e41f0fa600f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f0f:a600:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id r8-20020a056000014800b003364360839esm3372357wrx.81.2023.12.14.09.08.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 09:08:31 -0800 (PST)
Date:   Thu, 14 Dec 2023 18:08:29 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Kartik <kkartik@nvidia.com>
Cc:     jonathanh@nvidia.com, keescook@chromium.org, andy@kernel.org,
        akpm@linux-foundation.org, arnd@arndb.de, ulf.hansson@linaro.org,
        linus.walleij@linaro.org, pshete@nvidia.com, petlozup@nvidia.com,
        frank.li@vivo.com, robh@kernel.org, stefank@nvidia.com,
        pdeschrijver@nvidia.com, christophe.jaillet@wanadoo.fr,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v7 0/8] soc/tegra: fuse: Add ACPI support
Message-ID: <ZXs2jVeQtzU7668I@orome.fritz.box>
References: <20231017052322.2636-1-kkartik@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="7ihAXFEyzJFczZOQ"
Content-Disposition: inline
In-Reply-To: <20231017052322.2636-1-kkartik@nvidia.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--7ihAXFEyzJFczZOQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 17, 2023 at 10:53:14AM +0530, Kartik wrote:
> This series of patches add ACPI support for Tegra194 and Tegra234 in
> Tegra fuse and apbmisc drivers. It also adds support for Tegra241
> which uses ACPI boot.
>=20
> Kartik (8):
>   mm/util: Introduce kmemdup_array()
>   soc/tegra: fuse: Use dev_err_probe for probe failures
>   soc/tegra: fuse: Refactor resource mapping
>   soc/tegra: fuse: Add tegra_acpi_init_apbmisc()
>   soc/tegra: fuse: Add function to add lookups
>   soc/tegra: fuse: Add function to print SKU info
>   soc/tegra: fuse: Add ACPI support for Tegra194 and Tegra234
>   soc/tegra: fuse: Add support for Tegra241
>=20
>  drivers/soc/tegra/Kconfig              |   5 ++
>  drivers/soc/tegra/fuse/fuse-tegra.c    | 112 ++++++++++++++++++-------
>  drivers/soc/tegra/fuse/fuse-tegra30.c  |  20 +++++
>  drivers/soc/tegra/fuse/fuse.h          |   5 ++
>  drivers/soc/tegra/fuse/tegra-apbmisc.c | 110 ++++++++++++++++++++----
>  include/linux/string.h                 |   1 +
>  include/soc/tegra/fuse.h               |   1 +
>  mm/util.c                              |  17 ++++
>  8 files changed, 227 insertions(+), 44 deletions(-)

Applied, thanks.

Thierry

--7ihAXFEyzJFczZOQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmV7No0ACgkQ3SOs138+
s6HdXg/9FA/vYnQmXMQe06CT1xhFNbKB6aJgVm5DTwnTHPo0dBQNy3x2dgMK5DT3
j+jmOJcl53GaKXKwUbA6u0nnebvP3kmLJWxbLnuAw3TcJdPJLzrzrRyynvwWAwM7
Nxi13gAVW/YV039w4As0c8IoTIfwcswNJzXjfPDnw5vokT6FkzKOx4YutiCWGfFo
QcxOD8PbxPAAHvsuJmP/BEBtpHxGS+Yl9pd/CTS42uRkaGvHJq/DflviF38aTcXE
6Qczt0rfVZRRncz5rc0RMNJT54eMrbKd2PVMu8VjFuKsCz29Hfk/A2CahJ0XZn5K
bbzWgMCTgyaBQu+1/L1tY++t6eeC8tVY0JUqs9vykJqOwukp6uOOZy2wv4hJ5i86
BZ106BkBaBUyA7uKz00cOBoxSTJwNRuyrQZ8kZ1+sb4aZAlQ5Hbsn8tKRij7yvBa
WmDngH/DwqjnHp3YHtegotb9pjwG2MBoPHuNFftT4xnaI+rWbDIsW1pOmxAx6lmp
r1oljZt8p0+g09O4iylPNGrDzebW5X0KdB1uZqa8t4TAwsjN/pEKDdx9SdoIhOA5
BGMHyXgIbVFv7xktVZcwHXu459g4yalCgq+GZrd/3OTt0rdwfY/iJwn6Lp5GiDvu
39Pb9kuWKwpUdW48lkCSIET6gzy6omQry42gAscqFTW7m2nxrA0=
=dqlZ
-----END PGP SIGNATURE-----

--7ihAXFEyzJFczZOQ--

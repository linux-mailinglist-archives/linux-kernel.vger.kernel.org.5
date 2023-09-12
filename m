Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D6E679C654
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 07:50:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229536AbjILFuY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 01:50:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjILFuX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 01:50:23 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8368FE73;
        Mon, 11 Sep 2023 22:50:19 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1c328b53aeaso45374765ad.2;
        Mon, 11 Sep 2023 22:50:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694497819; x=1695102619; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lazraD+tS7ehDHAyJoob9HogFn5ADIMObxGHBTJXXNI=;
        b=stmqlEux8hidCu4asMz/RQGP8L7TTTOMhYGaCq10Kc8vd8EOzdcotaoin+S14ECfTy
         x/HTqBCG0z7psa19wU5bw7FcHiIX0o/YAfKhK/LMHRiBGXK7/Nprf4y80kMpX4XISjq0
         QT8TyJSc58VS1Y2iuBcZv+CGgAEjRPbf556VOxrjqFmA6wkXmiXztTNcIEZusoZUDelm
         Vi9dlH+gKmYQ6FuS6PKiw9h3/oUkB4ryHFQQLlJ1s6vfTpnIzQyis+Hd6BQ7BlZFaDdP
         0xpHMlXmLBmSg+n7ss6JMuTpulpOl9Y4mpnmiFH4W21h64q1KcouxDyGAHQBElOzAxIp
         ITHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694497819; x=1695102619;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lazraD+tS7ehDHAyJoob9HogFn5ADIMObxGHBTJXXNI=;
        b=pNA9igucIaoef7FP1W2vm8PsJJq67Yj0G4FSNg7aOimjiJNpfppk5K2GJWrMpRy5OE
         Yf5R8ociWkZ5VOhBmLDG4IrOlkIJZJwtN3p65iy4lX/wwBJn2qRLA+8G2lD+Xgi3dHZj
         Z41GI/O9F+qfrdiUz9yZ2U9S3UXTE2XSBqx8m/6dwpdOwEW0M4PSq+k9mVfq+n/lSbrk
         xgsnJPrBLM4KF8WIOaZ2o2FahYzd6aBLbHJxIRLJblDEsiVjEiMaGOblF8txDvb45dFw
         GXZqCcV+XqXWW6zEPQf9DyufONMmfgpr1UGdd6BqCKXR2WI1ZgzXcSpuTZMtp0/APG0H
         fUKA==
X-Gm-Message-State: AOJu0YxBGd44U93YKQ4QFe/3dTYoadF2R079XjYpmZPZBzsasHLy/4hJ
        8G9R71zwYOuAM826dkBgsMQ=
X-Google-Smtp-Source: AGHT+IGNyfu3X+on74pMWLtm5ccnS7n0Z/2Dj0UAtyK0cisVt9CeCJ52wwVu7J8/evI8AxeX9DqqCA==
X-Received: by 2002:a17:90a:d157:b0:263:72fe:3ef7 with SMTP id t23-20020a17090ad15700b0026372fe3ef7mr9979941pjw.42.1694497818911;
        Mon, 11 Sep 2023 22:50:18 -0700 (PDT)
Received: from debian.me ([103.124.138.83])
        by smtp.gmail.com with ESMTPSA id j4-20020a17090a588400b0026b3773043dsm6572037pji.22.2023.09.11.22.50.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Sep 2023 22:50:18 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id C5B0D8A839D9; Tue, 12 Sep 2023 12:50:14 +0700 (WIB)
Date:   Tue, 12 Sep 2023 12:50:14 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
Subject: Re: [PATCH 6.1 000/600] 6.1.53-rc1 review
Message-ID: <ZP_8FkCGeAhFt97O@debian.me>
References: <20230911134633.619970489@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="bjTnUSYMRdXEbQd8"
Content-Disposition: inline
In-Reply-To: <20230911134633.619970489@linuxfoundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--bjTnUSYMRdXEbQd8
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 11, 2023 at 03:40:33PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.53 release.
> There are 600 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>=20

Successfully compiled and installed bindeb-pkgs on my computer (Acer
Aspire E15, Intel Core i3 Haswell). No noticeable regressions.

Tested-by: Bagas Sanjaya <bagasdotme@gmail.com>

--=20
An old man doll... just what I always wanted! - Clara

--bjTnUSYMRdXEbQd8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZP/8EQAKCRD2uYlJVVFO
o6+CAP9aTBAEIAs4k8JD9uCAyW7E2bhHWIRRajW/ejoPanvNxAEA0F4HkWdP/Z3V
sQDsFyQkqNUW7vkxogbt72ELQpmoAQg=
=OEsR
-----END PGP SIGNATURE-----

--bjTnUSYMRdXEbQd8--

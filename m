Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41C2179C7FC
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 09:18:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231512AbjILHSg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 03:18:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231477AbjILHSd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 03:18:33 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7096E10DE;
        Tue, 12 Sep 2023 00:18:27 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1bd9b4f8e0eso35439385ad.1;
        Tue, 12 Sep 2023 00:18:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694503106; x=1695107906; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=py9nFuvmEUQ+zP3nRmEje4+bypXTvMKZX3lUiFpTOCI=;
        b=a0S2YENrjbITprwxXpp289zlsQX7ytvkvYD/y2Zcy/1DORMZGl41Vxnwf/dLkujyX4
         gVS76O2js56kdve6CLujXtitSK1oaCLUnuujaAAQQZ4K5aO30IGgkegeVIpQRbTjoDMp
         XBJMKmWl6KvXCXyCTXIL++N/9tEvxcjTFG/uGEVTt9tUlNo6u2fEma25E6g2DvuteN1X
         xqMqREB2qeZdwABv+oc2vjZVgd270Ik9JSuPyh2vxv4FxPo+ADxzj/jqlG2fAQvLe3os
         npHOc36rAC60+i6eZKSUeP3shhXxersmDnk1pWXv2M2fCmxiXfARYZmxULX1qiJrAojJ
         za4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694503106; x=1695107906;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=py9nFuvmEUQ+zP3nRmEje4+bypXTvMKZX3lUiFpTOCI=;
        b=ACTmWW7leogapyBIsNoi746uxNcWs70evG5P9ZBzwdxXbl4mXcXWhGB8DzN4CpkqAQ
         r/EBJ4Wee2V68ZHHJE9PaHj843Av5IY/946OzGf4/PsyghZk53mwVcGS3PXRppNet0cD
         hcgH1MXs9TjB8avAXmZZnA07/TU3vALaX+OrEsoNyr2TIOb9upOgFugeUkKdP69h41nH
         zJbHXBeSVqD5GmgjLC7FMfZDxJV0HKVqTlimwDktGysu/mOn1+rGGZot6bZGvxkJ+A1y
         a5KSSEUNnHomFwnk/BqUtgCWSEyGsibcmZanRJMi5ve6t1F9+otXif3aZBbQRJyfbnUW
         Zkyg==
X-Gm-Message-State: AOJu0YyPmKJ8BJ4Qm4u+kvL3Ky3AMblzMdcTvdun7x2QwBtQtDNRXqm2
        AvzInIYqq/MLCu/2JVvHhnQ=
X-Google-Smtp-Source: AGHT+IFdRiretyQ1GLC4nVkoZnVQXsRf4ZGWCkA57gDwbbQpjyUOgVo2r7/HskBM9sPFmopIIC1J0Q==
X-Received: by 2002:a17:902:eccf:b0:1b8:b382:f6c3 with SMTP id a15-20020a170902eccf00b001b8b382f6c3mr12885013plh.13.1694503106567;
        Tue, 12 Sep 2023 00:18:26 -0700 (PDT)
Received: from debian.me ([103.124.138.83])
        by smtp.gmail.com with ESMTPSA id h2-20020a170902748200b001b9d8688956sm7642137pll.144.2023.09.12.00.18.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Sep 2023 00:18:25 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id D9F8C89F3BB3; Tue, 12 Sep 2023 14:18:21 +0700 (WIB)
Date:   Tue, 12 Sep 2023 14:18:21 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
Subject: Re: [PATCH 6.5 000/739] 6.5.3-rc1 review
Message-ID: <ZQAQvRmK9UfnyMxP@debian.me>
References: <20230911134650.921299741@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="bXeRTYoIFlIhUA3G"
Content-Disposition: inline
In-Reply-To: <20230911134650.921299741@linuxfoundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--bXeRTYoIFlIhUA3G
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 11, 2023 at 03:36:39PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.5.3 release.
> There are 739 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>=20

Successfully compiled and installed bindeb-pkgs on my computer (Acer
Aspire E15, Intel Core i3 Haswell). No noticeable regressions.

Tested-by: Bagas Sanjaya <bagasdotme@gmail.com>

--=20
An old man doll... just what I always wanted! - Clara

--bXeRTYoIFlIhUA3G
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZQAQrgAKCRD2uYlJVVFO
o+KcAP0SpWyjL29RPb71BbYJBR/nYBooxJWHXCU18IdF4rKebwEA9fHzwaIHTxTN
5kOGubcYpMYtmbblf0q+jDcmoJgilwc=
=pRu3
-----END PGP SIGNATURE-----

--bXeRTYoIFlIhUA3G--

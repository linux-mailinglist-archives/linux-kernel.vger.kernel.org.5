Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57F747EDB2D
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 06:26:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344792AbjKPF0E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 00:26:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjKPF0B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 00:26:01 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E66F19E;
        Wed, 15 Nov 2023 21:25:58 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id 98e67ed59e1d1-2800bdf888dso311297a91.1;
        Wed, 15 Nov 2023 21:25:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700112357; x=1700717157; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zMh/lVBezDPicasXps/0vs6nsdfTuHUrBfcS44Fj6bs=;
        b=lgZt+EHKTW4ckjVSBOqepk1YpdzUt1Pfz305ghFjfEg1DRDqPuo2FLRwBjdyQrMd0M
         UWlwG9VQsBYMCe/rUtyqYWYDiyse6v6Ak8HmKUifQ2sRh84B05OjAyq/LesSF1gn5EOh
         h/LfyqRM4pBaIBlI6cpZqYc4FqmJSiQGcjSV0ZC+mJLChkkVne6BGn0U2jORS1dExWBj
         sa7KHyn1OF2gXyTzMu+CuXtuflIvmhFgf7qvgtpWKu51Gqq6m8bMGTjDET5YAjnoT+l1
         4gXO6vDC3vsxsisL09oWNHM2UacQmHnXcIJljNMdeY43KMk1ng32YYKv5YLSLBMbW8l6
         Ut0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700112357; x=1700717157;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zMh/lVBezDPicasXps/0vs6nsdfTuHUrBfcS44Fj6bs=;
        b=fPA7Ny2NXwmfgE1uwtPZQK2muFOxqytEab3W94bba4rWMFcI8HGaCyVJFwashJ5Iog
         F+8Tr5C+LfrroEBBd2m5JksvC42txINAuHaChiveTH2VcGDwbYAoOhAq1KT8DgJSFPsB
         HrZ2LAzHJD3mA7t8AnWzO5+sJcNlh+dkQYuGay8AEuR0zPatXZUpPtJ32GfR2mQ4buEM
         0T6QGjAxh3ETW7uy29sOKt0O9Twv1ebxizfyjbpiEYBOz4cjQM0Y7ZT9yvkQx1+ibctI
         BwP+4DB9U6d+g3HJB+V8qihm3Ipux0NXNyxZJ0EBRTcjWD+8OlNpbCbCRNxN4jUs4cTn
         cyHQ==
X-Gm-Message-State: AOJu0YyrKFSDHZIAFU0modexR9Pbd4g+8aRebgPjVYecAfvpKhoHhmAd
        j8tZgn+wYFdwiTyCVeaWfwI=
X-Google-Smtp-Source: AGHT+IHYEk8PwRLlrmkqWfndJ2U9bHNdVP7j32XW5tD89oVwhdwC26pyul13q/4CEm9wgYrhB722xw==
X-Received: by 2002:a17:90b:3ece:b0:283:2805:7c7f with SMTP id rm14-20020a17090b3ece00b0028328057c7fmr1086552pjb.0.1700112357559;
        Wed, 15 Nov 2023 21:25:57 -0800 (PST)
Received: from archie.me ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id n31-20020a17090a2ca200b00263b9e75aecsm821288pjd.41.2023.11.15.21.25.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Nov 2023 21:25:56 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
        id 6A09510207107; Thu, 16 Nov 2023 12:25:53 +0700 (WIB)
Date:   Thu, 16 Nov 2023 12:25:53 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
Subject: Re: [PATCH 6.6 000/603] 6.6.2-rc1 review
Message-ID: <ZVWn4Xl5KMVI9EGa@archie.me>
References: <20231115191613.097702445@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="x03+QSjLz6tnmKJk"
Content-Disposition: inline
In-Reply-To: <20231115191613.097702445@linuxfoundation.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--x03+QSjLz6tnmKJk
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 15, 2023 at 02:09:05PM -0500, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.2 release.
> There are 603 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>=20

Successfully compiled and installed bindeb-pkgs on my computer (Acer
Aspire E15, Intel Core i3 Haswell). No noticeable regressions.

Tested-by: Bagas Sanjaya <bagasdotme@gmail.com>

--=20
An old man doll... just what I always wanted! - Clara

--x03+QSjLz6tnmKJk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZVWn3QAKCRD2uYlJVVFO
o2ApAP9xp46GWUVFHlQccB6Bg5jHFWQQ5e6c+oF0ef2UbFz3eAD/QkcZFhBOs8zf
ZS91V2xJIHt2/XD2d1BGYeaacJzmcA0=
=hOcO
-----END PGP SIGNATURE-----

--x03+QSjLz6tnmKJk--

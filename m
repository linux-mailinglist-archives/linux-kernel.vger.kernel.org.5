Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3555B776EEF
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 06:11:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232202AbjHJELo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 00:11:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229783AbjHJELm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 00:11:42 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BC99E7E;
        Wed,  9 Aug 2023 21:11:42 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id 5614622812f47-3a3373211a1so379700b6e.0;
        Wed, 09 Aug 2023 21:11:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691640701; x=1692245501;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=o+dip4Mwm48SH8KstKNswZHVM/1cq/fJ+7Qb/RetnO4=;
        b=KTGjm+5jSsiFQ+DlZOaKRZjnYq+4Qwvoh+IFUr8VINd7glHc3ZqVmiH8Ka1TG8JplX
         Xnet+c3lqrdrvUyEjEWkPVpJO3ye97AWwu6MLjFG2eK7+JlXea+AhjYLyXRU+INzN4J2
         bxT2CyorXqYtLhxLGEZo5MtRWFSewGRa7cFVlUbzqHkFOy/rfaefn6ujQQWQ9VrQ5meY
         zhYR2OT65Smgoy+Sk3goHK4eI0nvvlByvPFcuxa3oTJzKuI3DDabGFwZDJ4XzfiLfdo4
         N083j+XOvHjTOR+VKcSd3jZFRF9o4GD1rigCYlz7MI2i61NcF0ptyVaFtb0ZnI93DJOD
         G1NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691640701; x=1692245501;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o+dip4Mwm48SH8KstKNswZHVM/1cq/fJ+7Qb/RetnO4=;
        b=ah7Q5cZrcduL+/ZYMTXZbyeyNzLtFZbkQygimhA9EiqK7QW9oQeKS308nzds7iThtB
         ETUCCEE31W9HwQM3DW5Cr/5X64PWRX4LVboVMrloMakqlymPKI12V3OfZvRuF4PGIyov
         VxAuwoOOpT4rKu+Epr6dAxnppuMP0V24AOUxsPOm7vxB1gDBbBSllJ+DcFSE9rBVLNCG
         7qdGpjph5fenfY3TZu0zf/l8Xuz6Jzay/Ao2sKitQWhM6P2DmvmQmIxWwP7p9w+QG/CN
         sc3ouBfhTx+yPBuSZj5JPHqJM4ykuarxI+IXW2zkcIVZ/rnmL4Yz/z26VY6Vij8H/DFm
         ofbQ==
X-Gm-Message-State: AOJu0Yz3qMA16CbFOqYUTYAwFm4qlIhoVNjS2S//JQGg30d1SPIlAm4L
        RWQNQNGr1J5+ekMk4e9734w=
X-Google-Smtp-Source: AGHT+IEENb3xfBnVXoWRnAFlS+RjFMQNGEnye47af3gxdc9pzD6pP1qma2dHPwtc73tk/6lA0kTLgw==
X-Received: by 2002:a05:6808:1453:b0:3a7:6213:6898 with SMTP id x19-20020a056808145300b003a762136898mr1741989oiv.12.1691640701331;
        Wed, 09 Aug 2023 21:11:41 -0700 (PDT)
Received: from debian.me ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id 11-20020a17090a194b00b00268dac826d4sm457675pjh.0.2023.08.09.21.11.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Aug 2023 21:11:40 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 5BD418196A01; Thu, 10 Aug 2023 11:11:38 +0700 (WIB)
Date:   Thu, 10 Aug 2023 11:11:37 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
Subject: Re: [PATCH 6.4 000/165] 6.4.10-rc1 review
Message-ID: <ZNRjefQECCD23UbX@debian.me>
References: <20230809103642.720851262@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Mk1kwhsNNWCwZCAs"
Content-Disposition: inline
In-Reply-To: <20230809103642.720851262@linuxfoundation.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Mk1kwhsNNWCwZCAs
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 09, 2023 at 12:38:51PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.4.10 release.
> There are 165 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>=20

Successfully compiled and installed bindeb-pkgs on my computer (Acer
Aspire E15, Intel Core i3 Haswell). No noticeable regressions.

Tested-by: Bagas Sanjaya <bagasdotme@gmail.com>

--=20
An old man doll... just what I always wanted! - Clara

--Mk1kwhsNNWCwZCAs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZNRjawAKCRD2uYlJVVFO
o5Z8AQCx5BhfcBN2+PuI7lnalUDaqwS/pmXMzH3z97b8yWapBAD+IDLGx4j4/uzC
9ZqhcsgN9MMOkWXxFnNdSzZhdi9i5wc=
=y0Xr
-----END PGP SIGNATURE-----

--Mk1kwhsNNWCwZCAs--

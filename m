Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A1337BF280
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 07:53:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379418AbjJJFxn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 01:53:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378119AbjJJFxh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 01:53:37 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B18509D;
        Mon,  9 Oct 2023 22:53:33 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id 41be03b00d2f7-5859b2eaa67so2857447a12.0;
        Mon, 09 Oct 2023 22:53:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696917213; x=1697522013; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wfaCoodsVu7yZCYoYj9RudTaxQcfa8byTewGj6h2eNk=;
        b=UFyYZorxNQYUUyqjsd+oWBt7JnGoGeSfOZeRCdmEmynuZeZcsk4Yhc4rsxohTz7akB
         aEQDj1JUibSGprNYFpCZjSZ/fimpbrWxE3ZH/b5xlMQQnRW74xlMreeNPj+Z0Xcri43s
         dJWFHFjJkfhYwQMcWyfMVtK85W4x3Wi6JaHx6JyYP90E07Dtsn4B060xBSk5oX2H0Wlx
         B5t7IICe4q1NlUlMdZQg8l/ROwzH9y9WcrMO5+wUnEgsAUeUMHEXXqi77OW6Z+piMjVV
         uzPPmHR4Qv/VxJSJL/bGZ0FqoEZPDUyCCD60lby8JNujROrYDFeKLq9BDtXMhrO1Ez5P
         K/Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696917213; x=1697522013;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wfaCoodsVu7yZCYoYj9RudTaxQcfa8byTewGj6h2eNk=;
        b=F+2wxxaX31EiDYmU5/Tb7ucg2KkrMAq35ETyb1bWzjjpz8s45pmfv0YBtgmLI31lDj
         B6Pbc3blBSY/f6a0gfiM6ZzE5kp7Hh9QlfLCRlPHM/WIwNAycp8UXZNLh1MZOSL4367b
         qEK1ZiyEZFfowIs/OlHZ7LDVeD5XU57W/rC5MdQsHpB7zZe0Tmm28YqFnMPhJ327yC/G
         okF+TJ4lvyJFGZYcZmcTJP4mZuv76kCLemBFXSUL1Ujadhoc80nH6mz6rKocNCHz2qpe
         zPza2zz+srWBN39C28O6doKY0kFoejSfuhRJYN4+ombsgXNOnDbruokYXYtlWWtxGMu/
         pugA==
X-Gm-Message-State: AOJu0YwCznTNNrvxGH2aqYJRSzH4aQUFjSn3e7Q2JZE8xSfI1dVvKL6X
        +MZ0/F2sLbxPkby+3yhpGLI=
X-Google-Smtp-Source: AGHT+IEigtFwOymrwH6Yg8ON3n5dI4KocGorIBqftErLJBr7G1D/uGzvKWtM/Yc9wNUmDdGbbss6gA==
X-Received: by 2002:a17:902:c24c:b0:1c3:ea2a:9058 with SMTP id 12-20020a170902c24c00b001c3ea2a9058mr13388668plg.65.1696917212959;
        Mon, 09 Oct 2023 22:53:32 -0700 (PDT)
Received: from debian.me ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id l3-20020a170903244300b001c73f3a9b88sm10686340pls.110.2023.10.09.22.53.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Oct 2023 22:53:32 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id E13DF8154D9A; Tue, 10 Oct 2023 12:53:28 +0700 (WIB)
Date:   Tue, 10 Oct 2023 12:53:28 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
Subject: Re: [PATCH 6.1 000/162] 6.1.57-rc1 review
Message-ID: <ZSTm2EJ6RIQGJH3m@debian.me>
References: <20231009130122.946357448@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="B5/N2J/Pr/nfSCYq"
Content-Disposition: inline
In-Reply-To: <20231009130122.946357448@linuxfoundation.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--B5/N2J/Pr/nfSCYq
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 09, 2023 at 02:59:41PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.57 release.
> There are 162 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>=20

Successfully compiled and installed bindeb-pkgs on my computer (Acer
Aspire E15, Intel Core i3 Haswell). No noticeable regressions.

Tested-by: Bagas Sanjaya <bagasdotme@gmail.com>

--=20
An old man doll... just what I always wanted! - Clara

--B5/N2J/Pr/nfSCYq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZSTm0QAKCRD2uYlJVVFO
o6emAQDNApQG/SZmeJZarDbPBuGLFvJSpM3hlIMG6o7JNG7qUAD/cn91yQ+3PVeP
HZlyWhX9OJx07zlXpXCMHpATkUzW6Q8=
=OUoF
-----END PGP SIGNATURE-----

--B5/N2J/Pr/nfSCYq--

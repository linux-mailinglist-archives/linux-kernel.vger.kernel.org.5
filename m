Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E11478BEDF
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 08:56:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232040AbjH2G4J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 02:56:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232237AbjH2Gzr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 02:55:47 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A2E919A;
        Mon, 28 Aug 2023 23:55:45 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-68a3e943762so3483699b3a.1;
        Mon, 28 Aug 2023 23:55:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693292145; x=1693896945;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=W02y8XrQjvud6v+7f98ge7q339v9OrPI2ILVKTk592Y=;
        b=IHkqfVJfJLlaQoxskXqSr/rqoqlDNql8XjHY9A1oVae1zGvS/Uf/AzjJLDlJ++Q8aI
         wsbXPeBmrRdUK6WomZZlVZ0Z2AFi9vysNpWKn2E0j1EGQg07K8pVr4xY2a37qoXNfa3Y
         HhsQOz+/z5LOxjvbPsIQBDn9dyYvYP15Jrvp1Rv1RHQRY5oaMcsHtelxuKRvm5hFf0kA
         vtFdxZGvHZQfnpKvuVkCiujMjVCRmd47EF0eu1JRNyiUrzXgTlhwKHzvUygbiF50hzUB
         ncpAFNR/7T4EI9kLCTepPgEsT+ywCVJJN+QwLntL78xu0y9a6G8UCs6iXs3cTNCFOlQw
         /2Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693292145; x=1693896945;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W02y8XrQjvud6v+7f98ge7q339v9OrPI2ILVKTk592Y=;
        b=T0au69/krTc/BvwerBHfqfUwaRyqJXyx7ya1NVeSx4Cx7IUkGhyz/k/DD3LhYB43Do
         pDg/DDxjOVs57a+gpBrbCZXHkFQUkomuvFwZQXU9+QM83ZD44hpw57xZvHzwQMnZGIeZ
         JitrcvBnVpJxzKPxt+PEJB0oSrrg34PqPDou95NzZc3SY8f60DN7CY55pFjYTDcYpugG
         sQ2LjCV3ge/nG/A1FdAe/6oxOUdnv0flT5PILEIcNK15cTUTUdIHYCRpZ4+dAPSrHljY
         ekfWrkV9aS0DCipjW1Z+GvyBJ47OiG5FFjLlk592/nkCTzKHAIniYFe+mnwt68RusC38
         c9AA==
X-Gm-Message-State: AOJu0YxjA0ol9nP54BlB0ySx03B7mG4Txa4C/T9p0i8MXOfrJaiOh7Tj
        YUCy2t+U99/JDWd8kw691wE=
X-Google-Smtp-Source: AGHT+IHhVFS2lN873oXS3uZc7sQfu2xRTJ57A+h82Za47fLq1tvzxyYGfydXjEiKYXG8xBlYOThbWQ==
X-Received: by 2002:a05:6a20:7d9d:b0:14d:446f:7212 with SMTP id v29-20020a056a207d9d00b0014d446f7212mr8344211pzj.46.1693292144930;
        Mon, 28 Aug 2023 23:55:44 -0700 (PDT)
Received: from debian.me ([103.124.138.83])
        by smtp.gmail.com with ESMTPSA id j10-20020a170902690a00b001bdc66478c1sm8573405plk.309.2023.08.28.23.55.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Aug 2023 23:55:44 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 6014DA34B070; Tue, 29 Aug 2023 13:55:40 +0700 (WIB)
Date:   Tue, 29 Aug 2023 13:55:40 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
Subject: Re: [PATCH 6.1 000/122] 6.1.50-rc1 review
Message-ID: <ZO2WbJVZarbwh3Z6@debian.me>
References: <20230828101156.480754469@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="e0XUHzXKRuzzbCUq"
Content-Disposition: inline
In-Reply-To: <20230828101156.480754469@linuxfoundation.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--e0XUHzXKRuzzbCUq
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 28, 2023 at 12:11:55PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.50 release.
> There are 122 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>=20

Successfully compiled and installed bindeb-pkgs on my computer (Acer
Aspire E15, Intel Core i3 Haswell). No noticeable regressions.

Tested-by: Bagas Sanjaya <bagasdotme@gmail.com>

--=20
An old man doll... just what I always wanted! - Clara

--e0XUHzXKRuzzbCUq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZO2WZQAKCRD2uYlJVVFO
o9VuAQDy/APECAEj6LrID38hG+oYJy5QaBej7ftvualVeX4uPwD9HgWc/HpsnoMI
pBYbxODVZsaN9DU+RSFVGPHhjP8eeAY=
=KOyC
-----END PGP SIGNATURE-----

--e0XUHzXKRuzzbCUq--

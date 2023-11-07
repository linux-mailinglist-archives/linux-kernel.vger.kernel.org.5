Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6E6B7E346D
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 05:13:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232973AbjKGENB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 23:13:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230208AbjKGEM6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 23:12:58 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CE52FC;
        Mon,  6 Nov 2023 20:12:56 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-6bee11456baso4830391b3a.1;
        Mon, 06 Nov 2023 20:12:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699330376; x=1699935176; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VWGUdKDQwEZVxOi96ik3Okr5Oky1aXrKnY6m5jfCDbU=;
        b=JH6wuGPeqqaGBhT2SzJxQElfIgZt4AO8CsEI8KWDkvJCr9j30Df4pgzoSUNzAW4M+t
         PYxuqI/2bKHw48gDGjWXT56u8mWKTQNXIuJkJjGyfnz4XUWZyJ7x3U4xN/1d3nolUnaY
         EMxW8oEFC3NG+oWFhsxw7h9v/8CwmOEa5SKqUtgpiXMolL2bEWMjYQePkh4SfjtnNI+8
         mGjTneLj6Zr/L0NhRRefN+xAc0dbpbaZgkr39C6WUnQxP64jbT1RyMjALfwBBdVGj/8p
         bPlyiH0iAIT+pxMiN0z/nEqM5cFcX8Z710uUaEWebAK+oYI+rbvvRQ5vFYq/XAL7RHpf
         2O4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699330376; x=1699935176;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VWGUdKDQwEZVxOi96ik3Okr5Oky1aXrKnY6m5jfCDbU=;
        b=Ot/lhnYSCJm5B6I1VyosKmQMtKpVV1/1hYVHQNJyQdr1MT+hgWufXH3oXbq2tMhXxz
         73+mobmGI0Fe672lT2s6z0L5ZxM/ZTFB75j/i+Z56DctAOzxfatdupL4Bszum+y6WUPE
         rWKanKaC3uhtu9R97W+V7mKA8LwZjiNKZKHoNzLuJwzB0iW7OwGXCFwrJSj5EBuKdIc/
         hJQoMaASQgtH6V0Jt3F7GzrJ26ajmuXmO1pOFVGE7tFPoAMiEumIH8d9F5QbmGSZFAuS
         vyIOCO9o1C1pwprhyx5KQk+uE+P/eXnRJHHDyzwCpbccKawxBtRQj1/2D4iO8hSys+RU
         yTRw==
X-Gm-Message-State: AOJu0YxeK2jvwN9yzL85oDv1dCoyOZP/rwgIB+ZMG5w6AGCRCKKwqZu3
        Ox/7C+152Abwc4kZYJKtAkY=
X-Google-Smtp-Source: AGHT+IEZ0ZhcKKp3OemGzSLtlF0+XnYGGdXHz20rb7hANsuLl7T4TSR5HojatHRX/Ov7TliIu3jYSA==
X-Received: by 2002:a05:6a21:7885:b0:184:9f3d:f7ba with SMTP id bf5-20020a056a21788500b001849f3df7bamr1750803pzc.33.1699330375600;
        Mon, 06 Nov 2023 20:12:55 -0800 (PST)
Received: from debian.me ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id z20-20020a170902ee1400b001c735421215sm6554513plb.216.2023.11.06.20.12.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Nov 2023 20:12:55 -0800 (PST)
Received: by debian.me (Postfix, from userid 1000)
        id A5C9B812C340; Tue,  7 Nov 2023 11:12:51 +0700 (WIB)
Date:   Tue, 7 Nov 2023 11:12:51 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
Subject: Re: [PATCH 6.1 00/62] 6.1.62-rc1 review
Message-ID: <ZUm5Q89d2CzZyyPS@debian.me>
References: <20231106130301.807965064@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="iIlcz5nryRovASij"
Content-Disposition: inline
In-Reply-To: <20231106130301.807965064@linuxfoundation.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--iIlcz5nryRovASij
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 06, 2023 at 02:03:06PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.62 release.
> There are 62 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>=20

Successfully compiled and installed bindeb-pkgs on my computer (Acer
Aspire E15, Intel Core i3 Haswell). No noticeable regressions.

Tested-by: Bagas Sanjaya <bagasdotme@gmail.com>

--=20
An old man doll... just what I always wanted! - Clara

--iIlcz5nryRovASij
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZUm5PQAKCRD2uYlJVVFO
oxZFAP9rmhpJxcRFb4pA+uDWcG5qago+ia/kYFqeaHyYGWZkpwD+JA4rYo2uam9a
zIfp9ue4E3UlBsgvW8sZKZOwVR1HVww=
=78wO
-----END PGP SIGNATURE-----

--iIlcz5nryRovASij--

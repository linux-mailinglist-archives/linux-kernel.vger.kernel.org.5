Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB4577D4581
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 04:32:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232017AbjJXCcq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 22:32:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjJXCco (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 22:32:44 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 117CDF9;
        Mon, 23 Oct 2023 19:32:37 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id 41be03b00d2f7-517ab9a4a13so3147155a12.1;
        Mon, 23 Oct 2023 19:32:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698114756; x=1698719556; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zYbdw1OGHS+Hev8vQpJN9on6ARotJmO2svQ7g1yvwWY=;
        b=k1g+6/9DoZRA2xUAqEl799Dfv9FBQP3gAa4F4Zek9TosNOI4R6nDk/MtXChOMDw7kB
         OLWF0JakmRD5UH3fvhSqIeiWGT6pFjUW9Ecnhn7EVGBy3Qm1oMmLaoiDDPI/Qo6nU8hW
         W7e12KhfyliM0qYKRM6DlDxOyi+cZRns63CfnGYpYJPjGRGxRnaq+cQeqsy0z3yAI6Ad
         qEJjx7dRwR1VvA9oCkfi8ExEWRwquh6eKucvj8QvRbT44ZmJRZve/QDP4zIPD9fDT3xg
         9MJb10NBv0R5YF4CCe96nsff0Tg7cxd/ttmQmu8aekPv0f+x7LIEWebufN3z6fkRwPWh
         lK8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698114756; x=1698719556;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zYbdw1OGHS+Hev8vQpJN9on6ARotJmO2svQ7g1yvwWY=;
        b=ORLidlT2bw691oUdXYvZsKyRQpdUe0//to2XhlOBKSfTHU4P47Nhhd0VfmGBcHV3hk
         YSiw6EuKsROslrPfS0LpTfijp7TdRxfTaLSmW2hsUS6ooQ4+LS1vyuz0aJWw5IFMdF0e
         gEoLIfM8GVjf/CaeMuaCJLQLB9wj5+WAD/z6Vr8ez30wYw3q9MzilU6F+h2Du22WbXbV
         6J/uE9O5yVepQpj3DNK71xwebNP6a3zW3odbdm1lCERaWoPsjlIQIS53SIajSyi3PezP
         Wrsq9g24q5hY7iGkycc3G59wK3LKox1yYgbz0q0DyjGST/XEbfBuc/FV3dsVy++/Y09O
         Rkbg==
X-Gm-Message-State: AOJu0YwO7pSG2EYNFHj4ngLQorl30XdgcY3aCp1BUa2Ec81y5PZfmb7r
        yEidfWlZIfBmwVj7Zc6/r/JfRp6SFf8=
X-Google-Smtp-Source: AGHT+IEgGLoEe6xUiWhp6CGY6KR5dAZd7dazZc94bf2Wvrvn/dPZVonoKIIPf/n1xYRf0B1n4eJFxA==
X-Received: by 2002:a17:902:ec88:b0:1c7:733b:27c7 with SMTP id x8-20020a170902ec8800b001c7733b27c7mr12300723plg.56.1698114756391;
        Mon, 23 Oct 2023 19:32:36 -0700 (PDT)
Received: from debian.me ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id iy20-20020a170903131400b001c5fc11c085sm6611318plb.264.2023.10.23.19.32.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Oct 2023 19:32:36 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 8001F8155C30; Tue, 24 Oct 2023 09:32:33 +0700 (WIB)
Date:   Tue, 24 Oct 2023 09:32:32 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
Subject: Re: [PATCH 6.1 000/196] 6.1.60-rc1 review
Message-ID: <ZTcswG1m3hzdzz38@debian.me>
References: <20231023104828.488041585@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="UW5aPAKQ5y9VxUhj"
Content-Disposition: inline
In-Reply-To: <20231023104828.488041585@linuxfoundation.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--UW5aPAKQ5y9VxUhj
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 23, 2023 at 12:54:25PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.60 release.
> There are 196 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>=20

Successfully compiled and installed bindeb-pkgs on my computer (Acer
Aspire E15, Intel Core i3 Haswell). No noticeable regressions.

Tested-by: Bagas Sanjaya <bagasdotme@gmail.com>

--=20
An old man doll... just what I always wanted! - Clara

--UW5aPAKQ5y9VxUhj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZTcstgAKCRD2uYlJVVFO
o3jRAP0XqZesn2EP0Y3/mLCengEAvBjIWlbNyYAruaHRRsgipwD/bIpv0LPZ7GzF
1j/29mV0Zyk4E6FNrZT0LILkDVwptQI=
=To4G
-----END PGP SIGNATURE-----

--UW5aPAKQ5y9VxUhj--

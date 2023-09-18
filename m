Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70CA07A41A8
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 09:00:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239899AbjIRHA0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 03:00:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240009AbjIRHAY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 03:00:24 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 146B2E7;
        Mon, 18 Sep 2023 00:00:19 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id 46e09a7af769-6c07e122a78so2767455a34.2;
        Mon, 18 Sep 2023 00:00:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695020418; x=1695625218; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DGpnaX3U1wfpEzDRwXZ6otPXK5e+cQlH+xiQluuxq6M=;
        b=BDG2d3TtTGFHimANWjtmGJb+euZNunFTOPcsASBCM3bcyrVmeEhmFm42T/7AwSl2wD
         153YYlatPDzQOKmyAV0dRrWMWz8twtZu3YnfXNlC6GFgQ5fQkqFcFJKgkFaknrxjL0+G
         Cf1ylS1geXz8Gg9qagfVuWKs3d6/FPbE9Ii6VFOoWCuWa0GVDGrpH/ie1R219BkwkR8N
         qEzV8FNVJdJILEDYz9r9SQyihbqEjYUml7nXFB0npOhwxoDpT/ffJcBnbuWXshuceZZI
         u4dggtO3M+KmtEteHoFZdKxlLTcCcHN5c7TiH8qzfeoGC4a7eMFvCcZVMNYfuAUzHKJO
         0Crg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695020418; x=1695625218;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DGpnaX3U1wfpEzDRwXZ6otPXK5e+cQlH+xiQluuxq6M=;
        b=fm5TtgrW1KeXZHQUltd+l+1u/1yfVdAsCOsW2lTzlXzyzAFFqcsE3QHP8kDCKnmulY
         m12Ov7T91FWMEY8uoTr72fmUskBU8YeSKNhUSInSYMG+LTZq4Rbtkji9oTIx8o+TnPCx
         7OD6+fESPXIby8LDTKDCZ6UacAoT5V2b5dBgCdWJGYFKuI8whPZjdslLtR/UsP1+HxwJ
         KVhH0LQ699dtozvbglkkqckAgCtN37EidREnawghKs5GKclctJ22JVrZUfjWzIhPAAg0
         vmLVlWN3PEDYgkmsznpoxHXy1Ijo56s4Q5dBSEOMjGJX2g0rR7uEVLhIpypU9xW+5wIN
         FASw==
X-Gm-Message-State: AOJu0YxrrdPJknGynk2uimX5E/Ih8IKlAlqju+Kj5afRrKPzFY9GWQo+
        DEOa9jm9pLsAh+8dpqAydB8=
X-Google-Smtp-Source: AGHT+IFSSQ/r23fvP6vvpjDiNkt/wADBnfh277py/7ZTNYoQw+rQ2lOXF1Z59G9xq9gCCaRvEb1CRw==
X-Received: by 2002:a05:6358:c29:b0:134:c859:d32a with SMTP id f41-20020a0563580c2900b00134c859d32amr8800859rwj.25.1695020418206;
        Mon, 18 Sep 2023 00:00:18 -0700 (PDT)
Received: from debian.me ([103.124.138.83])
        by smtp.gmail.com with ESMTPSA id t20-20020a63b254000000b0057401997c22sm6222917pgo.11.2023.09.18.00.00.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Sep 2023 00:00:17 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id B2BEE8061F05; Mon, 18 Sep 2023 14:00:10 +0700 (WIB)
Date:   Mon, 18 Sep 2023 14:00:10 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
Subject: Re: [PATCH 6.5 000/285] 6.5.4-rc1 review
Message-ID: <ZQf1euO2Q49ELToH@debian.me>
References: <20230917191051.639202302@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="aFKtJh1eZuQwoNSP"
Content-Disposition: inline
In-Reply-To: <20230917191051.639202302@linuxfoundation.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--aFKtJh1eZuQwoNSP
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 17, 2023 at 09:10:00PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.5.4 release.
> There are 285 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>=20

Successfully compiled and installed bindeb-pkgs on my computer (Acer
Aspire E15, Intel Core i3 Haswell). No noticeable regressions.

Tested-by: Bagas Sanjaya <bagasdotme@gmail.com>

--=20
An old man doll... just what I always wanted! - Clara

--aFKtJh1eZuQwoNSP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZQf1ZQAKCRD2uYlJVVFO
o1PxAQCC3AuelFUwY6XoHM59dI9K5dK7w62l22V07hzSDgCkTgD+Izmeb9aVU5BY
8ybU9QBhB5rEdKR0b3gzXtu4pyAT1Q4=
=Xerm
-----END PGP SIGNATURE-----

--aFKtJh1eZuQwoNSP--

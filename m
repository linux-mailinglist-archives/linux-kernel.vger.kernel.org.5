Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 014F58055D2
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 14:26:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345439AbjLEN0A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 08:26:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345423AbjLENZ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 08:25:57 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5C86196;
        Tue,  5 Dec 2023 05:26:03 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id 98e67ed59e1d1-2851a2b30a2so3781798a91.3;
        Tue, 05 Dec 2023 05:26:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701782763; x=1702387563; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sjQ8FbYAEzFu8r4HsmvBApJRCHY6/m3K/5DU4Y50k/M=;
        b=EV9QHJtvGFTAU/vf21bKleYWgdoLGNa/WVYj1noiQ1MPgYDbR7Ja3QQS67ArkPBY42
         fhdJbt2r4nNDUM9owFhvzvbFGw7qaZV1fJ2OsE7WfuogagrRmumx4fQzGW7C7+gQFkey
         sr7t3seA+SKvEMRPgPyb4pGGnpI0HArlSNOigETWUNSjYdLmPvJ077E5IXsoZkViWceu
         oQqTA0zEpbINMZ7XXzGzKDp9GUh09e87qCH9DOktQp/OtJ7gOWbL4bNF51MtFjFNJlP/
         MHv/UDAGJCSbN4dsz0EteWC9FoZcIn5qMS1uV631uQz7TsT05wLBPmfs5E4bqdjE9ThK
         2pig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701782763; x=1702387563;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sjQ8FbYAEzFu8r4HsmvBApJRCHY6/m3K/5DU4Y50k/M=;
        b=D22+J7mtHASDZoZoBpbzCs73HBNil9nhz4MYdl4B48L+dBUkUaOOe3cMakCfVJwBfX
         lqx4RCIaHkj3tnG7W3G7gVgNmmDNROD4l69Bp19SIQMp+B/lqhjR/DutEYMk9y+XJtcI
         U/5WI4U67jQpmhk8mhtyOtscH89OW4OQH8MY+TswRKjVdly4ARWORIVRSAK6vQFG9ZTH
         JU3YeqOmOViT8uIeKyh9BfU36+3d5bRIojRU7y7fI4KnYvqDfhhmI2YfX6bIyRFzMj7M
         Ht1C9OUXjLVyJ/N3Q/8lBYRuXSh+EArGNdVOV6WHjp+GH7tD2MaB/cME2vHTZELMjEj0
         fEnA==
X-Gm-Message-State: AOJu0Yzhf5xi9QFfu4rgl6sukiFHuH3Mgqm1c9nM2XEIO/LPzfINdh0d
        aSRvh40Q7eHVJ6j0SPfDoLk=
X-Google-Smtp-Source: AGHT+IFp2Jj31O+0BXJBVxO8BaeSKJ7diLNOfgCRhO3xZpxPwleAwXdlIiF3KnJLTnUQGjThMvsqlw==
X-Received: by 2002:a17:90b:2685:b0:286:6cc0:8858 with SMTP id pl5-20020a17090b268500b002866cc08858mr901109pjb.69.1701782762886;
        Tue, 05 Dec 2023 05:26:02 -0800 (PST)
Received: from archie.me ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id 30-20020a17090a1a5e00b00280c6f35546sm3864062pjl.49.2023.12.05.05.26.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Dec 2023 05:26:02 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
        id 0A802102278D8; Tue,  5 Dec 2023 20:25:55 +0700 (WIB)
Date:   Tue, 5 Dec 2023 20:25:55 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
        allen.lkml@gmail.com
Subject: Re: [PATCH 6.6 000/134] 6.6.5-rc1 review
Message-ID: <ZW8k4xq-zVRSiBfi@archie.me>
References: <20231205031535.163661217@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="fWlXNSfIUeLq0awe"
Content-Disposition: inline
In-Reply-To: <20231205031535.163661217@linuxfoundation.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--fWlXNSfIUeLq0awe
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 05, 2023 at 12:14:32PM +0900, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.5 release.
> There are 134 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>=20

Successfully compiled and installed the kernel on my computer (Acer
Aspire E15, Intel Core i3 Haswell). No noticeable regressions.

Tested-by: Bagas Sanjaya <bagasdotme@gmail.com>

--=20
An old man doll... just what I always wanted! - Clara

--fWlXNSfIUeLq0awe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZW8k3wAKCRD2uYlJVVFO
o6mOAP0RMX7+rbnuDUG/AieS0bEk7A4zKiBbn/cxEuJoKjGZigEAjzdFmJIb/M01
IA/++F53PTz3U0rf0wED1lL+p48q2AU=
=OO4r
-----END PGP SIGNATURE-----

--fWlXNSfIUeLq0awe--

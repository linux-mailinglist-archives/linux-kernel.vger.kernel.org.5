Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29811807EF0
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 03:48:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443126AbjLGCsK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 21:48:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443152AbjLGCsH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 21:48:07 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FEBD10FA;
        Wed,  6 Dec 2023 18:39:26 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1d0a7b72203so3806375ad.2;
        Wed, 06 Dec 2023 18:39:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701916766; x=1702521566; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=elG8GlXQstrh+7SbheHvlM9Wbdhuu5GKD5vjQyxAHjA=;
        b=csIDZDuaVx9RPEC6Gwjoyk9cFIzTNQVEHNnwM+DYA+B7weYRmQcKqpZbFd3OiXweTO
         UfcjAjOH6tBbUO++Y7DAD3lL8slz1Dk8rk8teZFB92Nk6n20E1ElKDf0EvjB9L2jhZOG
         e9ccMg7VvcdQ2Fjrs2wpYgSRlUKZppxTRd73phvAuA4wHHBotBN3+QPwwTOCCRi76fH4
         oRETJVYVsBcXrnNJ6tUev4V6qOw2jAbxW0nYp5kZfuh2g9Ke8TFW1QyP04kS5QQYCoOP
         SW9HGOUI7NyTHcnpvftGjlWvB1/RkWWtU3bhju2adF/vIeiOMGPF13LQvholJcpl8+W/
         +CIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701916766; x=1702521566;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=elG8GlXQstrh+7SbheHvlM9Wbdhuu5GKD5vjQyxAHjA=;
        b=b3O1/Ayo72tcFJpOGkPWr7dG3YX9eawrH7XgmWtGGvFWrCyncYJWyShqscTARQkOpV
         WUVmqz+wVbw7Yh2Ff4BaZQJhy+ApL0jz3f9i/AqcUYJqwtvmh63/mDFhdd1r57VFmtn2
         PArtjHpheRVjktSi8FseVrf3DpguVG5BupA6jdAo/9RVG9nGpXiFP6iDnqaG05ac1xra
         WLotUj0emhU6+Sup5fP4CVZCFt5AtNd53um4zdXCLbVbyb+ZhZZh9rrDljDIhadxKWxp
         tlb2Kh0sn6nUxhIcOfAgkjByxIVcrhTjw+5lMi75+a1K7p3gAzUuhFBikFvjMEkT+29j
         /pGQ==
X-Gm-Message-State: AOJu0YyqmG//07aWVQqtdPI9D8R/WDMb6Lw5I1jR0X7nRetn4VRJcuc3
        fID15mZgatthpAhv1RuDqnxbj4ZbLYWBvg==
X-Google-Smtp-Source: AGHT+IEK+qI5y2AHtPi9fYvkLjo2GmFVrcscUkg3UWuixiW/+HC2JdXhLqGPHnNbolOnqpMcPBpTHA==
X-Received: by 2002:a17:902:dacf:b0:1cf:c42c:cfbd with SMTP id q15-20020a170902dacf00b001cfc42ccfbdmr2468303plx.0.1701916765692;
        Wed, 06 Dec 2023 18:39:25 -0800 (PST)
Received: from archie.me ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id m2-20020a170902768200b001cc3fae06a6sm149846pll.159.2023.12.06.18.39.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 18:39:25 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
        id E1D9B1143CC84; Thu,  7 Dec 2023 09:39:19 +0700 (WIB)
Date:   Thu, 7 Dec 2023 09:39:19 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Dianne Skoll <dianne@skoll.ca>,
        Linux Stable <stable@vger.kernel.org>
Cc:     Linux Regressions <regressions@lists.linux.dev>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux AMDGPU <amd-gfx@lists.freedesktop.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
        Pan@archie.me, Xinhui <Xinhui.Pan@amd.com>
Subject: Re: Regression: Radeon video card does not work with 6.6.4; works
 fine with 6.6.3
Message-ID: <ZXEwV_BRROeu84Zh@archie.me>
References: <20231206172220.37ff4df9@gato.skoll.ca>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="9mKsw2ilVY5K14MK"
Content-Disposition: inline
In-Reply-To: <20231206172220.37ff4df9@gato.skoll.ca>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--9mKsw2ilVY5K14MK
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

[Cc'ing also amdgpu people]

On Wed, Dec 06, 2023 at 05:22:20PM -0500, Dianne Skoll wrote:
> Hi,
>=20
> I had to go back to 6.6.3 because 6.6.4 seems to have broken my Radeon
> video setup.  The full bug report:
> https://bugzilla.kernel.org/show_bug.cgi?id=3D218238
>=20

Can you bisect to find the culprit commit? See
Documentation/admin-guide/bug-bisect.rst in the kernel sources for reference
if you have never done bisection.

Also, can you check if latest mainline (currently v6.7-rc4) still have this
regression?

Regardless, please also report on freedesktop tracker [1].

Thanks.

[1]: https://gitlab.freedesktop.org/drm/amd/-/issues

--=20
An old man doll... just what I always wanted! - Clara

--9mKsw2ilVY5K14MK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZXEwUgAKCRD2uYlJVVFO
o26uAP4pJSbOfEfKR0cpWObUfKDiW5fKckPa8tUO8ExaxMRvWgEAjV139d+uzj2c
9OyU7VsBGW31gkolGGzUhLp5YIce2QI=
=isDS
-----END PGP SIGNATURE-----

--9mKsw2ilVY5K14MK--

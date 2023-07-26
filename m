Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C301762A49
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 06:27:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230438AbjGZE1O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 00:27:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231300AbjGZE06 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 00:26:58 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2564135BC;
        Tue, 25 Jul 2023 21:23:35 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id af79cd13be357-76ad8892d49so561407885a.1;
        Tue, 25 Jul 2023 21:23:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690345414; x=1690950214;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Yi38VlQdcgh6JrRFXIjUZ2eky4uj6/eRY5AHeVHhEaw=;
        b=riofDQK966kREfzEc16UMVsmEb77ME6cqjeVOJr3+Yu0VQjHHFbyfabv7vDLoENP8+
         So6XyxLFmw4JN3kDGxNKLHETZjbdyoENJao0XUUfc14mrBCZJdJLrJcon1KkMWhMpebr
         YdOiNL0zajvmOJ8tZ0fo8bjf2X4tRxAkZ+oQ/zqpcPnod0v6fzZjFF97e5iEJaV3HYod
         XFyRvtxIauL5zx/p8/eHz4h9gtaYVDCHixIplSlory33dYrsK3qeHcjq3wkvPiKRIUQT
         5pw+TCNX7A4MtYnL0RvPuXTLOVAOfGj2Hth95lK35dZjUeQV87Lcn/nirOCiVJbh8ZDv
         cfsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690345414; x=1690950214;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yi38VlQdcgh6JrRFXIjUZ2eky4uj6/eRY5AHeVHhEaw=;
        b=SLpxJ/GlyQwe185RjhrNjkpegzG/VHcY/YysX/trLvn/HC9gMdmAReEvfBKV5xVvOT
         HkYgnfVEFlarnlSni+I0LseNZECh9sX2OAblAo+i0fhuvmNJ1/9oKYDpuVvhyCFxHlOL
         uzT9FfwKEpVd/u8BO9FZghNwcWR+cW8aKOCWjpPgOHvMblLTvdqtCj+KscB7lGKOaPFW
         l17CV3M/yiIG9KjnHyOXJoPPg3ZA5ib+AnFgOSCQ4kj1LJU575l9v0JzQJXfog8ZKL2w
         sRcKIA0xOmqYwKijMyUNEz+c+M04qQhYQrSYzh6FXINLBA2Gub/54vS4iwVEFPavr24c
         5HPQ==
X-Gm-Message-State: ABy/qLYfb27ZL42Kmak/TURMwGkuaJgkAmKl+b3gdClW2N3/93n4A6me
        gY+RPUB47oRvYU6Vy3nQqLc=
X-Google-Smtp-Source: APBJJlFuqgqfnFmRRiWY9ZiIaviqtZKRz9n8fCGStB+wq8/1hm//rVdWsQ2l7NcTivsYV+VWIZaUUg==
X-Received: by 2002:a05:620a:a9c:b0:75b:23a0:dec3 with SMTP id v28-20020a05620a0a9c00b0075b23a0dec3mr1034636qkg.65.1690345414214;
        Tue, 25 Jul 2023 21:23:34 -0700 (PDT)
Received: from debian.me ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id 8-20020a17090a018800b0026309d57724sm376568pjc.39.2023.07.25.21.23.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jul 2023 21:23:33 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 610AB8192284; Wed, 26 Jul 2023 11:23:30 +0700 (WIB)
Date:   Wed, 26 Jul 2023 11:23:29 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
Subject: Re: [PATCH 6.1 000/183] 6.1.42-rc1 review
Message-ID: <ZMCfwa5019Eil94D@debian.me>
References: <20230725104507.756981058@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ZGq6QzdxF2Ci/i0N"
Content-Disposition: inline
In-Reply-To: <20230725104507.756981058@linuxfoundation.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ZGq6QzdxF2Ci/i0N
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 25, 2023 at 12:43:48PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.42 release.
> There are 183 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>=20

Successfully compiled and installed bindeb-pkgs on my computer (Acer
Aspire E15, Intel Core i3 Haswell). No noticeable regressions.

Tested-by: Bagas Sanjaya <bagasdotme@gmail.com>

--=20
An old man doll... just what I always wanted! - Clara

--ZGq6QzdxF2Ci/i0N
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZMCfvAAKCRD2uYlJVVFO
o4l2APkBMv7/eQI3HHMsLmzvq6JmCJ3oitxoHdx3Vo7XZ+QVPgD/SAh277WpqUc2
Wi4Ux1JnYyBuN1hOx+5n4Fj7tZyrAQg=
=4pyv
-----END PGP SIGNATURE-----

--ZGq6QzdxF2Ci/i0N--

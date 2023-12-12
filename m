Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31D3580E3D0
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 06:29:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229640AbjLLF2b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 00:28:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbjLLF23 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 00:28:29 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9ADFE3;
        Mon, 11 Dec 2023 21:28:33 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-6ce939ecfc2so4571851b3a.2;
        Mon, 11 Dec 2023 21:28:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702358913; x=1702963713; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8eo6yjctVN7EWUi9qs5MkkJLw4hgrBMLP7fU3YS53r8=;
        b=UtollOdzkBcRU6dVErUbM9jdIZHccEmtp+J2tIASb6N3COoGiSaWD8lzH81BRvyy0/
         WNChL/zHZdJlk8I7ebYL/+JRl1XjbiwTbr+6VJYXSuGqiktfCRBL8QDCz66+TVJdGxZd
         yc/DIAW701Jc6IrId19X3ZtzS9BcbiyIQpY2fo/Z0dfXadDs+GW7ld7wSIHRHPPrRyZq
         F7QzNUmJwOX8bpfk6NCvD31t3LEpXtr7Eb1UxND6gqJms1yN2xowZDo/wlHGlkXZtCq/
         nP/VawhWOqmp5eA0K0NMOmJEjuKlZ5WkGx9PzfVrB7bML4Zb9iVhqJzQB7hvqYU/Nw2f
         f1WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702358913; x=1702963713;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8eo6yjctVN7EWUi9qs5MkkJLw4hgrBMLP7fU3YS53r8=;
        b=mJjxk9lr/QVXNb08MZYjcSaEELHg+0KuuFO2byuWRvGRSYwL7RMq4aEmamDNSs5QC+
         7VYvMIG9UPCRmdt3YEpWaKnSggpTxXc4Fc5hLy/0NCQVF7+px7nn5VAOIyt2Ckb65RVK
         rmuGSUBahyWEvOBeXYs8ASnmY/u0dT5KjBD4i9xZ9bZ87t2pHDUPimfkpPUGmkj50Cvp
         1j9Arl8PYHcaWYnQLuzYP7FBbvxJr82sqBLkwPhPBrruEBKnhA/RjGFbsq4Zq+vS2jwf
         xa0A0g6tVKafycE3IK+3KJlscQYUe9ZVegjlHUptRHrZgCYM6tPJSDNJPnT2gllGWG/I
         K0TA==
X-Gm-Message-State: AOJu0YyhIxTnwAW82qJm3RheC2J9fzIwb9ZIchZWVwnaWnKenqGt2YOY
        +VRVu/XErKFI+kt0K6LEoJY=
X-Google-Smtp-Source: AGHT+IF7UbX2/pPTwMPl1Hye6GIFCjFuSTaIWMIzOsQRGy1DF9a/LPHIs7w9Y1xC6zmxPm4U50S8cA==
X-Received: by 2002:a05:6a00:1701:b0:6cd:e063:3646 with SMTP id h1-20020a056a00170100b006cde0633646mr6629467pfc.28.1702358913261;
        Mon, 11 Dec 2023 21:28:33 -0800 (PST)
Received: from archie.me ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id fa24-20020a056a002d1800b006be0fb89ac2sm7200701pfb.197.2023.12.11.21.28.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 21:28:32 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
        id 4A6751020709A; Tue, 12 Dec 2023 12:28:26 +0700 (WIB)
Date:   Tue, 12 Dec 2023 12:28:25 +0700
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
Subject: Re: [PATCH 6.6 000/244] 6.6.7-rc1 review
Message-ID: <ZXfveTxvjE19BSvQ@archie.me>
References: <20231211182045.784881756@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="6RcIu9UoqRupJR7s"
Content-Disposition: inline
In-Reply-To: <20231211182045.784881756@linuxfoundation.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--6RcIu9UoqRupJR7s
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 11, 2023 at 07:18:13PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.7 release.
> There are 244 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>=20

Successfully compiled and installed the kernel on my computer (Acer
Aspire E15, Intel Core i3 Haswell). No noticeable regressions.

Tested-by: Bagas Sanjaya <bagasdotme@gmail.com>

--=20
An old man doll... just what I always wanted! - Clara

--6RcIu9UoqRupJR7s
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZXfvcgAKCRD2uYlJVVFO
o8NWAQDQ/rgFgLfFaAGHXyuEHNQLATd6HctOY09VHyjBt/C+ZgEAvFtShxLlS4/y
yxuoWeo0NkWQPpcIff8iYhAeYZftUQ4=
=M5xy
-----END PGP SIGNATURE-----

--6RcIu9UoqRupJR7s--

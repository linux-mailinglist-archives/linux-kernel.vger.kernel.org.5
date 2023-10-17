Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF05E7CB8D5
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 05:03:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234381AbjJQDD0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 23:03:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229666AbjJQDDX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 23:03:23 -0400
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7795B93;
        Mon, 16 Oct 2023 20:03:21 -0700 (PDT)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-5a7cc03dee5so64146107b3.3;
        Mon, 16 Oct 2023 20:03:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697511800; x=1698116600; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XGJ46Sxqz+oCWAzTdlW20vwJ0Pmh7MhaqNxDWygSSoM=;
        b=DduTUXCNT23X3UwXgCuWKYf1wbEyChZyskfwU/ardtGqEjrwxo4uxDgV+N4HJLNqjX
         2lwf6wh5uw8CPZQydaOPVzKr2VtrXBDPoH7/EsCwTmKhNEQG0Bg5zpEt3klj9B33sTCW
         2pB5hD4pvTSv0QWNkkQZZ7a3bxAliMC1eOZeW3dtbRHZqQh2qk4pO86BmjcLNy1YTm/H
         PFLEdRntdA9M431/bYvWMIcOeI2weCQYfGWRfwv1sMxDijlS1oB7KmOz0LtgBJTwYyhy
         oxlKE7hGgRJbDVkXWK5fPhLfiVN+vNzOn/R9IeTAakmnQhb471DMgz65ruQCghXe9Kak
         w3HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697511800; x=1698116600;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XGJ46Sxqz+oCWAzTdlW20vwJ0Pmh7MhaqNxDWygSSoM=;
        b=edB0mcZWjZ1HD57C3ZgLirDereSicol5JYSGwjwmwPS/3y1+xa+JHCtwaFCQ9zxAfs
         MSCW0LX8IQqRRcPYUq6Kyq2jeP9pEiU5m2HvmF3ZEzvEu8ShtOtsLfYtkolZWucQDPyv
         66UYB4dCsBSy71FTG2NTXWFbgdjT69+WbVvjUr3b9Jqo1YasoF8LhJ+Qd9AgPCnFJ2+6
         yQBG0KU6epLCN0Dzft91eD8kPjO6OkqtT2Q7Qz/cGd+OXELcfSdZ69b6c729wMFBhKnH
         wXyLv576+wA9xC70i8FNvtLrkU6CZ9X+CelEL3OTczuoSOiy9iJhanfcDNwn1ZcxxGSH
         gAuw==
X-Gm-Message-State: AOJu0Yzev0pcwLDw/kiioJxpeQ7QqD/KOtHzAIn9GWxpeT5RjjeZZpqy
        WlVDz4PalQdbFEvykN7bqTg=
X-Google-Smtp-Source: AGHT+IE3qls3ucSiKHuebUCCh6NxPHfeCNi0McQFh6VsAcRGGc88VSVdo677q6MCRNigqUeBRHS0kg==
X-Received: by 2002:a05:690c:ed1:b0:59c:678:7a32 with SMTP id cs17-20020a05690c0ed100b0059c06787a32mr1386436ywb.29.1697511800601;
        Mon, 16 Oct 2023 20:03:20 -0700 (PDT)
Received: from debian.me ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id jg1-20020a17090326c100b001c62b9a51c0sm322345plb.103.2023.10.16.20.03.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Oct 2023 20:03:19 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 7A45F819CFD4; Tue, 17 Oct 2023 10:03:15 +0700 (WIB)
Date:   Tue, 17 Oct 2023 10:03:14 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
Subject: Re: [PATCH 6.1 000/131] 6.1.59-rc1 review
Message-ID: <ZS35ckiWx0Zqqx4I@debian.me>
References: <20231016084000.050926073@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="4LwvL73jkubLOURz"
Content-Disposition: inline
In-Reply-To: <20231016084000.050926073@linuxfoundation.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--4LwvL73jkubLOURz
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 16, 2023 at 10:39:43AM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.59 release.
> There are 131 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>=20

Successfully compiled and installed bindeb-pkgs on my computer (Acer
Aspire E15, Intel Core i3 Haswell). No noticeable regressions.

Tested-by: Bagas Sanjaya <bagasdotme@gmail.com>

--=20
An old man doll... just what I always wanted! - Clara

--4LwvL73jkubLOURz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZS35ZAAKCRD2uYlJVVFO
o0hEAQD9V0N8nU9zFWIUPJ0WRVYnrDuv86YxXQOveNrq4P0ZyQD/dqu2x1uuIWpA
rQzsT+eEu6JOji+Hdsl+p9SIWDWEMAI=
=q/TI
-----END PGP SIGNATURE-----

--4LwvL73jkubLOURz--

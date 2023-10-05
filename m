Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E9B47B9DDA
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 15:56:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231346AbjJEN4V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 09:56:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243557AbjJENsp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 09:48:45 -0400
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com [IPv6:2607:f8b0:4864:20::c32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0324C2121;
        Wed,  4 Oct 2023 21:04:41 -0700 (PDT)
Received: by mail-oo1-xc32.google.com with SMTP id 006d021491bc7-57b5ef5b947so348656eaf.0;
        Wed, 04 Oct 2023 21:04:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696478680; x=1697083480; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RMXyEVE2i3k4dLTGe3l+U9bUqIsZ76xJBWfzrLVaQIU=;
        b=Wm1u5H4KnZ2BcGiNq5rxay7XPL2F2qcQX4SFZO10xeBaOvnb4y7nCnf08TE7Slhd/o
         i7pmoS6T1vqDcHaoCxVYkl0ZvFq9AC24oae+why40PoPKb8XYnIQ0IRqm64QsbWfDEqN
         yePEkk1q+AN9yEKKC7xk1SDekNByu7igp+IW1f1J66MGjkl1INT5rknTiQ+X+jgEBkYQ
         3QEV0frWbTo5fZdVNsu0dTvgM/WpTsMLiplpZzpJ8V6UMjp6VNoMTjsxP4ccapAWhOrE
         8spb4zB2G7pr4XeDyuDn/THNKFVhc2OjnJ+KIvAJtdz9CetDPdDNrS7+62G1l7+ineZM
         GL2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696478680; x=1697083480;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RMXyEVE2i3k4dLTGe3l+U9bUqIsZ76xJBWfzrLVaQIU=;
        b=XHIh/UlxEyYC/I+vTe46B6Cafm6MiG+PuzqeS9TfDFA5LIcMRGNnUyWhx7b7r7iAGT
         6jSEgvVm8VSeHGyRRgNkqdmqnaKvqGJzhEujN0+ogK5M8kp+COtmrDpMpxsqSjqt1rpy
         P4XSi1Nuu8dpWRIF9FQoWfBOwirQquJyPmDvmGrf8pMDtmuhzBNmG58O46Captypk/ah
         Q2VyHUOf6akQG/NaXlkSDlrjX2BC8Vv5D5e9E/0sOxMQEoZu7yX2JuC3BX2Wp+xpyGOe
         MszN6/2YIygaJOQMBs3Q/eOdogBdnPu/a37bfY5TcmVUHoware3jt0FB3qL3W9VM3nBX
         9Ajg==
X-Gm-Message-State: AOJu0Yw7czGpdjQuG43Cd0mHh7PPI52Qy/XNSIUM2SFsOj3xZMsjJETI
        CRqEvnzat1cF0jOIK23kUGQ=
X-Google-Smtp-Source: AGHT+IGSkWOYk4DqwbRQRHzJ3jU+JRLaveKGsN/Rmc1OJnWzSjkTWWfAwyvTJOtRG6XzehfYWnpG7g==
X-Received: by 2002:a05:6358:988d:b0:143:723:8f89 with SMTP id q13-20020a056358988d00b0014307238f89mr4897551rwa.4.1696478680192;
        Wed, 04 Oct 2023 21:04:40 -0700 (PDT)
Received: from debian.me ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id x6-20020a17090a9dc600b0026b12768e46sm412448pjv.42.2023.10.04.21.04.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Oct 2023 21:04:38 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 0786484462F3; Thu,  5 Oct 2023 11:04:33 +0700 (WIB)
Date:   Thu, 5 Oct 2023 11:04:33 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
Subject: Re: [PATCH 6.5 000/321] 6.5.6-rc1 review
Message-ID: <ZR410XeUZfIVaflc@debian.me>
References: <20231004175229.211487444@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="UsH318AZCdPlllMP"
Content-Disposition: inline
In-Reply-To: <20231004175229.211487444@linuxfoundation.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--UsH318AZCdPlllMP
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 04, 2023 at 07:52:25PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.5.6 release.
> There are 321 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>=20

Successfully compiled and installed bindeb-pkgs on my computer (Acer
Aspire E15, Intel Core i3 Haswell). No noticeable regressions.

Tested-by: Bagas Sanjaya <bagasdotme@gmail.com>

--=20
An old man doll... just what I always wanted! - Clara

--UsH318AZCdPlllMP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZR41yQAKCRD2uYlJVVFO
o2jLAQCcDpwnr/d3rHimS9StGzwJjBbtqH7B6sZCbbOZ+ywhIgD9FdAMSztvx21C
hdzoPWYfxAUqkWC9EpKQ1zrL2odaEww=
=lDbM
-----END PGP SIGNATURE-----

--UsH318AZCdPlllMP--

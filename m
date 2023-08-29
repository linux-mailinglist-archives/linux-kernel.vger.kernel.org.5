Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E21F78C03E
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 10:29:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233988AbjH2I2u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 04:28:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234223AbjH2I2h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 04:28:37 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C73CDA0;
        Tue, 29 Aug 2023 01:28:34 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-68c3b9f8333so2037251b3a.1;
        Tue, 29 Aug 2023 01:28:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693297714; x=1693902514;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5Ch/bdybWeqK+wujAQ6/Q8Kpla+lNmr0ZFWz+5nMEEo=;
        b=ShALYbUHGrr5oHEgxzb8usRbgwYZPW6TXnvYtXcQ+by71GJ4QMiDo3idzHjvsKBkyL
         KDE7gTfb4Q+UXDxdxV/ZF/46CoyZ2MGJHH5zkYXpqlJu7a5yGm4DuX3USETawAnUwXhs
         +gazwtoAHUNNLdMcjt4AeMc+hTxrVdrpyo7ncT9TLAne7DY24Roz/XoA6x8FtWjHzq1B
         6afJY9TwT3fgJGwzxpihBenSfe0cW4ImFmaxvPzOIrw860b3YtA3i2MoQNN/C7+w0kRG
         hQhv/HaYM3uRhKdGDAsX+mmue2byezX8w3V95dAxoKiakghbmn/jStqbYsrTMGGvL+QN
         O1oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693297714; x=1693902514;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5Ch/bdybWeqK+wujAQ6/Q8Kpla+lNmr0ZFWz+5nMEEo=;
        b=Giu4xF51lYQvdrf71pn1hMDuGiOm8bnLggXJYJxgg0MsBOIIXyyp4AdNU8D1dY4AJl
         qOwg4dMt/IAL0UwQTkaUbwL2wLlLN3kY3vQ8RwKMdmBldRMhtG5dT9meM4yDOeiL3bcP
         2nI3sqsip8i6c7LyY/Z365wqoQRLDoOz5STR6ngMJGT3cNj/GiaWOLG2NHgzlw3BFo2z
         nQyHKLNc1TyDDb9q7ruYm/eAMpplHtVxQtyx0B6X0cuSMX0ugAcL7rT4+CFWOrdvKvXd
         Od7qb0W7Sd8R8/+yhLEUfCQILBS9DDea1wLk9QiZYM2KdKtucYpZVQE5RU0f07de6kpB
         t+1g==
X-Gm-Message-State: AOJu0YxYEkovhWACQa9nfB3FIsO9JOEsj9NW4sFxAcUkJrEqTOOc58ho
        eSzu4/6BWPQC+A1rUxTbWz9NHVRLtXc=
X-Google-Smtp-Source: AGHT+IETiAb2yLZckVOsuxKWD8CbkSJZrZKvOM/ArjaAOgtnOe9VSbggbAkolUECZsjo/UEvKiNsWA==
X-Received: by 2002:a05:6a00:1510:b0:68a:45a1:c0f7 with SMTP id q16-20020a056a00151000b0068a45a1c0f7mr3582059pfu.8.1693297714144;
        Tue, 29 Aug 2023 01:28:34 -0700 (PDT)
Received: from debian.me ([103.124.138.83])
        by smtp.gmail.com with ESMTPSA id y17-20020aa78051000000b0068a3e7634d0sm7854879pfm.129.2023.08.29.01.28.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Aug 2023 01:28:33 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 9465F9CA10EB; Tue, 29 Aug 2023 15:28:31 +0700 (WIB)
Date:   Tue, 29 Aug 2023 15:28:31 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
Subject: Re: [PATCH 6.4 000/129] 6.4.13-rc1 review
Message-ID: <ZO2sL7OU_8A0na85@debian.me>
References: <20230828101157.383363777@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Tz8iKbeBP+5AVCqb"
Content-Disposition: inline
In-Reply-To: <20230828101157.383363777@linuxfoundation.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Tz8iKbeBP+5AVCqb
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 28, 2023 at 12:11:19PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.4.13 release.
> There are 129 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>=20

Successfully compiled and installed bindeb-pkgs on my computer (Acer
Aspire E15, Intel Core i3 Haswell). No noticeable regressions.

Tested-by: Bagas Sanjaya <bagasdotme@gmail.com>

--=20
An old man doll... just what I always wanted! - Clara

--Tz8iKbeBP+5AVCqb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZO2sLwAKCRD2uYlJVVFO
o/fdAP95c6912jjxLpl1KjfkjpfGbw+7vD1OImOnqOrRZ4QGmgEA5zmAGYI47L6H
FaQQMX0cbE5f7Hn8ri7HJ4frhX4ZjQM=
=CyTL
-----END PGP SIGNATURE-----

--Tz8iKbeBP+5AVCqb--

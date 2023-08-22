Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2ACB578383C
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 05:00:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232406AbjHVDAn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 23:00:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231126AbjHVDAl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 23:00:41 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B88C184;
        Mon, 21 Aug 2023 20:00:40 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-68a6cd7c6a6so254971b3a.1;
        Mon, 21 Aug 2023 20:00:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692673240; x=1693278040;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=V9rfUX1u4J49X94MB9ALqEh64ViMp1rzQu7h3fdjufc=;
        b=WbUmxXtLHsBzeFfjTvBbxz+tAqRHcV3W+q1fGCn04MOP2oOH7gu8NXS9fm5m0rctFH
         55MwZP2fB3apWah2GE0IhbmmaqdhoU3s9CGH4bgN7XSp1tGMG8wiwZ6E6xmGjDSDaJNB
         ovmsCyAvbQpCwrkeR+sMZvXnfmsuqsawvc/h4lLpYTNnmgF/KtN8ualZfvZMj3U6SSgn
         7wY1CckLUMd1cngGqfvBmP1c6HRv3ybLZlFNfnt/bASraLPB1kde5/0+0t25R5uLTxZT
         8Bm9jidqTEEMiVNO07Ka1/rFQnSsCI8L6XwoOtCeSJaJ+uPkcUJdWwNn3YdpssvbQKSA
         efpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692673240; x=1693278040;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V9rfUX1u4J49X94MB9ALqEh64ViMp1rzQu7h3fdjufc=;
        b=lswJIPvFFqxc5c1tedF36InpJy7/KrD64LyZvewZ6YOBfu2CwIixSQDVol4BBwMAup
         3IUWE39+kBLa8hXYAkKLW1uek4WpkILm3MOvXXOyxInfgacUmwVXNQcw8VRBEd7gylDv
         pdxECwvZB+CQrrBir8HppSigfPFSUhVUovEqJPBtpARjX06+WqYOkyrMRE7XhyxUOaTk
         H2mY3+/SMol/yjdI47vN2jeNPUap5nHccomDzGAtSUNLmGHgS8ps1hBLGtcndsBEYjvq
         6tsgAKEr4PNjjupImZtco1eAWEtjfij+z+r6biRSLK7sycjPNSLNk8ufRX1uFmASwajf
         N1bw==
X-Gm-Message-State: AOJu0Yz8PcfRSnYEMZpvlzMeNOL4kqVGKJLqqB9inlx6Sk4p/ialBKxw
        gRxdAxKlRiOWbZodQoVhMtU=
X-Google-Smtp-Source: AGHT+IEPUEaprDP/xtAgTBz3MFCvIwylRxhHji6XmYEcLC6SQBDdoIrJaM7ZgaMiruQBpHNqzWlcgA==
X-Received: by 2002:a05:6a20:7488:b0:133:7ad8:712b with SMTP id p8-20020a056a20748800b001337ad8712bmr7912837pzd.52.1692673239808;
        Mon, 21 Aug 2023 20:00:39 -0700 (PDT)
Received: from debian.me ([103.124.138.83])
        by smtp.gmail.com with ESMTPSA id c15-20020a170903234f00b001b9be3b94d3sm7744501plh.140.2023.08.21.20.00.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Aug 2023 20:00:39 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 5CFF080696E1; Tue, 22 Aug 2023 10:00:37 +0700 (WIB)
Date:   Tue, 22 Aug 2023 10:00:37 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
Subject: Re: [PATCH 6.1 000/194] 6.1.47-rc1 review
Message-ID: <ZOQk1ethQ8mDedes@debian.me>
References: <20230821194122.695845670@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="7uBiktEJ0pmNpR/L"
Content-Disposition: inline
In-Reply-To: <20230821194122.695845670@linuxfoundation.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--7uBiktEJ0pmNpR/L
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 21, 2023 at 09:39:39PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.47 release.
> There are 194 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>=20

Successfully compiled and installed bindeb-pkgs on my computer (Acer
Aspire E15, Intel Core i3 Haswell). No noticeable regressions.

Tested-by: Bagas Sanjaya <bagasdotme@gmail.com>

--=20
An old man doll... just what I always wanted! - Clara

--7uBiktEJ0pmNpR/L
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZOQk0AAKCRD2uYlJVVFO
ozXzAQCZI/bgzdBJ0CLOqilgxE+g8kjNqp1WL/59lwKhjPBzsQD/Xz4v+bTAUVZs
Tbg8aSt0obkISjlRGk5Oiupi++u5aA4=
=C27w
-----END PGP SIGNATURE-----

--7uBiktEJ0pmNpR/L--

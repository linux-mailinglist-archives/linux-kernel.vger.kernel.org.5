Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D12B175DA76
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jul 2023 08:50:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229681AbjGVGuM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jul 2023 02:50:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbjGVGuK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jul 2023 02:50:10 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9EEE270B;
        Fri, 21 Jul 2023 23:50:09 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id 46e09a7af769-6b9aadde448so2302744a34.0;
        Fri, 21 Jul 2023 23:50:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690008609; x=1690613409;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=X+Kej4FyV0ucQSrNXd8j+dCrf51e/JXrwmwjYYZs1ZM=;
        b=KdDRcm9TTX3hOcSxBhFlzzBBfEp2Ji6BdoTCMrZe1iyvOpyaShvJO4cXbr+RtTzt9X
         D5L5D2RZFsmbxc+8HFdkXMnxoVMO/xkPozmkvcNpwqQZqpB8rjXSiv6mzRJpTkV512ja
         rdChh7fxNSgrz+lTKp0LkRfKHRbp4S+Fq8vnP5Fb9cz7t03j0iZXgdAqqxXwyrSDJjN6
         IV121ooYqtr9quAHSdCE4eG4LAjTSDVax/3ZjBlgm4nu4+GLEieuZFUUzFPC03wqCwjA
         2EXVDqPqb0+O4lUktzufd2Gk7gkF8BbQyYi77GI/y3Ndros2BtNxiZw4zbSLCVHtMsD4
         2SIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690008609; x=1690613409;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X+Kej4FyV0ucQSrNXd8j+dCrf51e/JXrwmwjYYZs1ZM=;
        b=NJjwxQt1LOOJtrH5+drgtZ0fKyEZ1bxezbvtk+W7lqrC7F0USBJq6d6gu4sscm7Hng
         QP4AYESAr/j4xa5KH5mMTeeqCf9/Jp6LoBLyvx/bZ4CjouPzJ5cgMcaHwmxHegEUVQAq
         w9lamPmuP9+BOMmcF8NZWd/0dF0sqNb0eui5NKF/Ez6s372uyIKmnDIraUeryUeQatLR
         GR7A96KRhlencsn9O/S+duZ8wLSavXHwT+0qH2qIyAm0is+zK8xs5Z9GIZ32kuA4Ojrt
         YA3UBSmMQUk7j/ZeFaT6Axi86ht5zJVreCen79Cs1zi010zNPXVddRIDafE7uhWOGLMf
         jRTw==
X-Gm-Message-State: ABy/qLaQTFgRNFzeIryjaGjOSOSNbQLbnQTL2tEJj2VoN/he1ikuMwqO
        sZv4NFNr0PNb4gNuf4MzK+g=
X-Google-Smtp-Source: APBJJlFmjkOOHx66vsYbYfEXY8RTnXSQ0UuN4PX9e3GC4vpqh3AxP1/l0Tkguy+4rASp+R5eS/v02w==
X-Received: by 2002:a05:6358:6f1d:b0:134:c37f:4b63 with SMTP id r29-20020a0563586f1d00b00134c37f4b63mr2518810rwn.2.1690008608860;
        Fri, 21 Jul 2023 23:50:08 -0700 (PDT)
Received: from debian.me ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id h25-20020a633859000000b0053051d50a48sm4216628pgn.79.2023.07.21.23.50.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jul 2023 23:50:08 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id BA69C838FB64; Sat, 22 Jul 2023 13:50:03 +0700 (WIB)
Date:   Sat, 22 Jul 2023 13:50:03 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
Subject: Re: [PATCH 6.4 000/292] 6.4.5-rc1 review
Message-ID: <ZLt8G85Cqc7NcQQr@debian.me>
References: <20230721160528.800311148@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="I9WX4wvPI3bnPVfW"
Content-Disposition: inline
In-Reply-To: <20230721160528.800311148@linuxfoundation.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--I9WX4wvPI3bnPVfW
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 21, 2023 at 06:01:49PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.4.5 release.
> There are 292 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>=20

Successfully compiled and installed bindeb-pkgs on my computer (Acer
Aspire E15, Intel Core i3 Haswell). No noticeable regressions.

Tested-by: Bagas Sanjaya <bagasdotme@gmail.com>

--=20
An old man doll... just what I always wanted! - Clara

--I9WX4wvPI3bnPVfW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZLt8FQAKCRD2uYlJVVFO
owseAP0fUNb4K1XvER6JIhoMsiqFFW321L68YLtU4GjDwXKX0AD/dauOa16lv88k
WFeJyED+QKru9PDkvpBw8X3dJ0zDGQE=
=DG9/
-----END PGP SIGNATURE-----

--I9WX4wvPI3bnPVfW--

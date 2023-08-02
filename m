Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F64F76CB2F
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 12:45:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231176AbjHBKpT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 06:45:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230314AbjHBKpA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 06:45:00 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CECE335A2;
        Wed,  2 Aug 2023 03:44:29 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-686efdeabaeso4482900b3a.3;
        Wed, 02 Aug 2023 03:44:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690973069; x=1691577869;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PSfohqKv/ZinqsoF8vB1X8kqyFmbZl82QWhQosdrgX8=;
        b=l3hRtcrJ7G2P5VIn+bqZadfdxFpjOLNT0y/0b/jmTb0gb/JG5lH0KlzSjVZVBKUThR
         I4w2fms4o98/3WoMHb1PscyyrwPGutTGmGzhaIsrd+jMUdZW7X5ccskLSiiBnpOBusA4
         /yF8rNWPQon8oy+LpRoPnNJR6r37uzpDEB8Sy0KpGNkqL044ohYaCG+qV9nEFuNKLjf5
         a3bpVYSDDosAaTM3z5/N1UK2vjiY3H8TI+0J7s0haWjCOkCRlxqbG4sgSgbFPXHAwpX/
         vj95OiBWqvZZW9+xkRPRUqrHSN1CNFknGuLSJYzbciByGWDrt6HYUeTdJC4vJPadkS7V
         4lGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690973069; x=1691577869;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PSfohqKv/ZinqsoF8vB1X8kqyFmbZl82QWhQosdrgX8=;
        b=VFd5jrHHTmrX3YE5qUytewUL8dDKUgDeSan/GfanIFfT1C8UZQiaErkHncA3hwxlXL
         P2xPsaq09qHRZXCr7CIQgk91tUL+m0kwwEzvyUmCMEa38lBSzY2qWeMPc44lM1FzLXnV
         USo19cnALxsGjngwXgN8zhqWPtDkS4YxPS0ytgZvB2Q8hOAVtsFu+bDcDZX/POhOQzY6
         FK0dBpGw/1T2DEj5OhzLo1usxWOLmpqkpKHErKcT9HNo8hmrZb+en9feFQqkNp907QFi
         StFZtct4/hpzebpRTEnRnXrLEyEgbSL9GB6Tvde3+jhHlT9VGhRAEnvuUmnWKDe3shwf
         hghg==
X-Gm-Message-State: ABy/qLYrBiVqUCioP4WCB0MuYUFLZCdqX0i9CgoepUWcZRIpT85bOD2Y
        pAcc4U9nJWS+2J3s+3plRJw=
X-Google-Smtp-Source: APBJJlETmUOfP5RxhXg51IdrQj3IwWnz+XUBKZfvnwsOowUz5UxjDeZ5ea90MKIQIRBXLFuAGNt/XA==
X-Received: by 2002:a05:6a00:1a56:b0:687:4a3d:8fad with SMTP id h22-20020a056a001a5600b006874a3d8fadmr6285922pfv.16.1690973069147;
        Wed, 02 Aug 2023 03:44:29 -0700 (PDT)
Received: from debian.me ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id a15-20020a62e20f000000b006783ee5df8asm10791570pfi.189.2023.08.02.03.44.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Aug 2023 03:44:28 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id A0EE48197C37; Wed,  2 Aug 2023 17:44:25 +0700 (WIB)
Date:   Wed, 2 Aug 2023 17:44:25 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
Subject: Re: [PATCH 6.4 000/239] 6.4.8-rc1 review
Message-ID: <ZMoziaxnZljReMvR@debian.me>
References: <20230801091925.659598007@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="v90g9n7xpLHxyWn0"
Content-Disposition: inline
In-Reply-To: <20230801091925.659598007@linuxfoundation.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--v90g9n7xpLHxyWn0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 01, 2023 at 11:17:44AM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.4.8 release.
> There are 239 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>=20

Successfully compiled and installed bindeb-pkgs on my computer (Acer
Aspire E15, Intel Core i3 Haswell). No noticeable regressions.

Tested-by: Bagas Sanjaya <bagasdotme@gmail.com>

--=20
An old man doll... just what I always wanted! - Clara

--v90g9n7xpLHxyWn0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZMozggAKCRD2uYlJVVFO
o9ZoAP4u/SWwFLFLC5yO48Pk+fBL5p3stCXyBKptk/KrengdvQD8Ded+WjyKVAfI
0WJ4nq/YR2ek/hUEgo0q/6Fgzz8Rrgs=
=17DW
-----END PGP SIGNATURE-----

--v90g9n7xpLHxyWn0--

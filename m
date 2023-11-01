Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6129F7DDB37
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 03:56:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345869AbjKACz7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 22:55:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345180AbjKACz5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 22:55:57 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E9ACF3;
        Tue, 31 Oct 2023 19:55:54 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id 5614622812f47-3b2ec5ee2e4so3814219b6e.3;
        Tue, 31 Oct 2023 19:55:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698807354; x=1699412154; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=j0NzdQStEiGv9KFgnf7s7Dkfku/GDCcYtb+3dYJ4A6s=;
        b=RrYPXnt5MAn0qt07gXuvDPUD2Wme/ZkMqcDLp7VUiuQ4Z0BFPXzQo0D2T7A0Ww4URg
         qGPPvVYWiShJjaKmY+fYSVNvx6E/IZwmaGdcfWXL4r3jBo/sPSjVKSsEbc/THT4znwcr
         IjGYXkviwuVbtK6ONwUUqbBuGCYLxiTk//gK6j5zoZ0458PdT5a4gm7bytFPoRJQducX
         QmLwc6KWPiqBKUiNe4qiJteSpbA/i4ySTBGo8cFZ/vsFUfS7t96EVC3tlSkAlfDec2j9
         0TQiX5Dl6a263qfakUmVAaZMIneY51sx1Pm62GzwAwpazXHYs+VISYQl77WF8Wt1/n6B
         GuPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698807354; x=1699412154;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j0NzdQStEiGv9KFgnf7s7Dkfku/GDCcYtb+3dYJ4A6s=;
        b=muS/OKzlnDnUxJDbh7Y43yzviAO3FIb/kZzXmLCiLu6k4EVfOn/XNEOJchTcXFuxl6
         NdFC07Bftp7yCCnOd416U0C5EdLuRwu5SO4SjiG7JhaINMKiS25MKAFH826mJY7Pvtvs
         hna7nMv9gWG70E9lQOenWWhXGAVs2ORVDQ+x6Ngb7ClakxnDxadooSLkUDAJph1Fkvd9
         vgkaTdDuUlkkgnp6mo45xFZnmNJZNcbCrVp6/d1JXKCZ/dmgU48ks1mR06tWPCKq47Y2
         hLlG8+xyUGooC5QZoz+vu8vsQsew1V/VU/3uE55WoalvdjDzfMG9HojMcWLwiVoobIix
         7pnw==
X-Gm-Message-State: AOJu0YzyfDPUQ5dcA/FwnTk2hyl2aiTuKt+BUmgZxDVV0aZmIVVxiGNr
        Fx2xeUFzO/b+xeFlQR0a2Vo=
X-Google-Smtp-Source: AGHT+IEStQwsggjPSVxZK7H5JCYfLs39GZqsiwnTtQ+CObQ6899CyJph8hU23Brat08VnMaMx09eYw==
X-Received: by 2002:a05:6808:1491:b0:3b2:e9ab:68e6 with SMTP id e17-20020a056808149100b003b2e9ab68e6mr19602702oiw.0.1698807353830;
        Tue, 31 Oct 2023 19:55:53 -0700 (PDT)
Received: from debian.me ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id t14-20020a056a00138e00b00692cb1224casm282776pfg.183.2023.10.31.19.55.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Oct 2023 19:55:53 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id ED3FE80A7352; Wed,  1 Nov 2023 09:55:50 +0700 (WIB)
Date:   Wed, 1 Nov 2023 09:55:50 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
Subject: Re: [PATCH 6.5 000/112] 6.5.10-rc1 review
Message-ID: <ZUG-NpRAuu4XwwM3@debian.me>
References: <20231031165901.318222981@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Vle9uzRdIeXCXV/5"
Content-Disposition: inline
In-Reply-To: <20231031165901.318222981@linuxfoundation.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Vle9uzRdIeXCXV/5
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 31, 2023 at 06:00:01PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.5.10 release.
> There are 112 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>=20

Successfully compiled and installed bindeb-pkgs on my computer (Acer
Aspire E15, Intel Core i3 Haswell). No noticeable regressions.

Tested-by: Bagas Sanjaya <bagasdotme@gmail.com>

--=20
An old man doll... just what I always wanted! - Clara

--Vle9uzRdIeXCXV/5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZUG+MgAKCRD2uYlJVVFO
o6baAQD20q0IJ4WDIRVrIyup95Hfba4bvyoyagAZDcgcE5O89wD/YaDzNu69EkY6
BlW4dXfh2BCC8RntPiHO6JexD+7YHgY=
=ntj6
-----END PGP SIGNATURE-----

--Vle9uzRdIeXCXV/5--

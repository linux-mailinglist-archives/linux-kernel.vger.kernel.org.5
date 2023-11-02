Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DC2D7DEA57
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 02:46:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233018AbjKBBqS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 21:46:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232035AbjKBBqR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 21:46:17 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC5B4110;
        Wed,  1 Nov 2023 18:46:14 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-6b89ab5ddb7so517719b3a.0;
        Wed, 01 Nov 2023 18:46:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698889574; x=1699494374; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Gy/GVknEDM3F376D/bWf0Z1BlGJZY3l5y/EY0cLFHSg=;
        b=TWAyJLHtEzCrtE8BxLEihlp2juJcvdolRk8Vo+jvdlgkmW3kSAZkRjRPAAbp59Tywb
         ODEOrWvO2p2i7ob13s0sRTlCoY+LN+WTVSExOBWG7pXqcTt12mClCM+ss8JRnJQhO+Yn
         MzaqlAS1S0gBF8cWpUCau0g98g8xqJXCWC+Ln8q8wc9VR4i78XUYjFoh8URgQGl57rNN
         mL5g5b/J+DapOX2Btjsxt0aIDvK1TwgVRT+BOpvXr37kYCqmSutbW8tJtOjjmWXr3ERE
         yH1bbQfF9Y0L+4HEtvL48eSjB15yUQf9o4g2x7BT4o5aNnt6e0pqw/sbt/rixqscQuxy
         TAJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698889574; x=1699494374;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gy/GVknEDM3F376D/bWf0Z1BlGJZY3l5y/EY0cLFHSg=;
        b=FuFTk/0466vXLtd6j0Y/fVDJnzsj8CpcqHQn2QOGL5H6kWHbi91zEAEfv3+u3dKnOB
         dnreWvir9iaARM2BKKmRdawMr94E0v/V+/oZzLZ47fsAWzK+HFh6/ILsfk71ErKpTEz1
         oVdp4l1o7opeVU2lyYDBvTAu1707w0HYAeeIRq+EIE64KnfjjMCdDXcv0g/kNqBnyIrY
         KRGUBLMPk+YoN5kpcqI2Sf9VFqgSkqxFOmflUqDLX4cYQNmf3Gz+x/+usfa8nUIC7t0L
         mLC0DpbnTtyLWqZMEbz0y1h9AhEMH7+o7jlDCdgrRH8CubTfzzoCQUt20MSnO8/BpyCZ
         l0bQ==
X-Gm-Message-State: AOJu0YxMD0SzmIAUSO1KdQyigMeJaoLw7SAzKMhMxnGwvJ/OsX7c0HIc
        eB997CQUJpxmVBt7vlOFB+1Mi+QMM3c=
X-Google-Smtp-Source: AGHT+IE1CaL6tZHiXbUN1S+2Xw9nk5lTFyRUC9NtCsot0YT6JaNtGPJFTNVzNYU2iGIKcYNUusdGSQ==
X-Received: by 2002:a05:6a00:16d5:b0:6bb:def8:b0a7 with SMTP id l21-20020a056a0016d500b006bbdef8b0a7mr21606945pfc.3.1698889574218;
        Wed, 01 Nov 2023 18:46:14 -0700 (PDT)
Received: from debian.me ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id a17-20020a637051000000b005b3cc663c8csm436415pgn.21.2023.11.01.18.46.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Nov 2023 18:46:13 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 955DA80DFD3B; Thu,  2 Nov 2023 08:46:10 +0700 (WIB)
Date:   Thu, 2 Nov 2023 08:46:10 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
Subject: Re: [PATCH 6.5 000/111] 6.5.10-rc2 review
Message-ID: <ZUL_YkVgFnWQ9k-7@debian.me>
References: <20231101120147.190909952@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="7oM5a5ZDZL/pUZYV"
Content-Disposition: inline
In-Reply-To: <20231101120147.190909952@linuxfoundation.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--7oM5a5ZDZL/pUZYV
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 01, 2023 at 01:03:25PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.5.10 release.
> There are 111 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>=20

Successfully compiled and installed bindeb-pkgs on my computer (Acer
Aspire E15, Intel Core i3 Haswell). No noticeable regressions.

Tested-by: Bagas Sanjaya <bagasdotme@gmail.com>

--=20
An old man doll... just what I always wanted! - Clara

--7oM5a5ZDZL/pUZYV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZUL/XQAKCRD2uYlJVVFO
o+/CAP43RALYZT77HFB6VE70PhFjGfg1TfgPxT6QuqLkqzEGYQD8CXvInaHtI5wq
WaGUr7YyWPEzjjC5bkWLf993GkrrBg8=
=f0/W
-----END PGP SIGNATURE-----

--7oM5a5ZDZL/pUZYV--

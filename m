Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADE4F7B9F48
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 16:21:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232560AbjJEOTA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 10:19:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233303AbjJEOQg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 10:16:36 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB92B1985;
        Wed,  4 Oct 2023 20:41:48 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id 5614622812f47-3ae5ce4a4ceso367909b6e.1;
        Wed, 04 Oct 2023 20:41:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696477308; x=1697082108; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Sk95zFTEUxg4VjqgqYYBz24a5vuW35vcpYZ4u3hihIA=;
        b=bRsd4/1Mwzhz9yJGInmZt/jHSjOSAivNlYwzlNatu2WibkwWWEn3nIJ5LKqbYDXrDT
         hQoil8UpeCtl3x8NCxpaqgfMxsQMicUDOyuuwEc2bVc/rGFeNk4c0cTySpiP5dJxz1kn
         TpHtV77ZUzieukGlQwGOFf90TsAwwzjDJG0jptPNedIPq68eDAV6lLpSuRIVNmewvHtP
         HwTTonS9o4Ui+DcVUU65MXeuLjFCAIq+XMM7njMVs6JqClSE44ELvkTJrkiaoD9UwrQY
         6pS5Td1PXxJB7SYkRx+qayEgdm1Itet1V+cdMdmbjoZBOJ3ve1GrwI40zd2hbwoawXRd
         I/fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696477308; x=1697082108;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sk95zFTEUxg4VjqgqYYBz24a5vuW35vcpYZ4u3hihIA=;
        b=Y2Th3X/PPx8/aCrRlEvTTL/pzHevmJlI/HaflLx87ULvunBURzQE9qGQSPvEN5rPeS
         dTciyF1836+uHSlLcGV/3L2QbG/GUfYA1A+InAQxNwOgXSJ8BsZfQgioRpOgjwl4pPEF
         Dm7/tHGZY8hCm+0d4wSOf0F1Dy0uTaeKFAnssGZPlGLewzxbkVfEGvJ9WSWJSsg3imkh
         5DKMsS53JCK3XOW3JM6CIHFjxcHw15dGyda0VA03fmFcxHdFo6+EgTMhxlJvyyp+DCSo
         Zn3zdLOh0bDwwWzOfXIHNLK/uMcpo1FMcYakGi9mGTQt1kbNuZgiVz13QsCwJwdQoWQZ
         jOjw==
X-Gm-Message-State: AOJu0YxUFuzCE5/WdcLJT0CnDGVSTzfYN7dFE8nMLiV0hsxrxlxhvGK4
        gPnAHeaxPUvGRlouZGmeX9E=
X-Google-Smtp-Source: AGHT+IGVDo7JufNBKQ83S5yooQvJh8P01DU3SZTzTijKLEVf7t3x+8HdemVgB7X0KbSn4SsCM+FIsw==
X-Received: by 2002:a05:6808:2382:b0:3ad:f866:39bd with SMTP id bp2-20020a056808238200b003adf86639bdmr4665141oib.27.1696477308089;
        Wed, 04 Oct 2023 20:41:48 -0700 (PDT)
Received: from debian.me ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id a9-20020a63bd09000000b005891f3af36asm316522pgf.87.2023.10.04.20.41.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Oct 2023 20:41:47 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 81C2C80FCC18; Thu,  5 Oct 2023 10:41:41 +0700 (WIB)
Date:   Thu, 5 Oct 2023 10:41:40 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
Subject: Re: [PATCH 6.1 000/259] 6.1.56-rc1 review
Message-ID: <ZR4wdCFV9lT3XFKV@debian.me>
References: <20231004175217.404851126@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="2A/QDMh1jEjOPF+0"
Content-Disposition: inline
In-Reply-To: <20231004175217.404851126@linuxfoundation.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--2A/QDMh1jEjOPF+0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 04, 2023 at 07:52:53PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.56 release.
> There are 259 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>=20

Successfully compiled and installed bindeb-pkgs on my computer (Acer
Aspire E15, Intel Core i3 Haswell). No noticeable regressions.

Tested-by: Bagas Sanjaya <bagasdotme@gmail.com>

--=20
An old man doll... just what I always wanted! - Clara

--2A/QDMh1jEjOPF+0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZR4wbwAKCRD2uYlJVVFO
o25wAP486peTivssGitHaDW69OLp2joiFPR3ZIZ3MEPDmy3pYwD/bmNcEDqkqMEA
Gvfhbed2QiGCwwYAW3Aa9d6SzE/LHwE=
=/usy
-----END PGP SIGNATURE-----

--2A/QDMh1jEjOPF+0--

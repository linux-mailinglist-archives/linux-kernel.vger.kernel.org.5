Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C5FB78C409
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 14:16:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233302AbjH2MQF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 08:16:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235028AbjH2MPc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 08:15:32 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1F74CE6
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 05:15:05 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1bf1935f6c2so28754515ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 05:15:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693311305; x=1693916105; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Q9VkhPBVgMZOy2Ax+rf67UyJ3baIYOSj8VG/VoffI8E=;
        b=o5GM5ELlpaPZTknXMIMPp7u18fjy82iTTDC17m116bCIW7GJal6oLMPRx5fsxV5dOu
         x7MB6rPLu/9ffFzuSxBosRvqbDo7CXOagdflOKJfOOcqXfhIFcSkyh0GdaHs+L0L0Kvm
         5DYRAhPIJy2gCnrlfLTRfRKvDrYzOXNPLOG94vG5bAsTTqgeVmZbN6PZHnqFmYuOAkbq
         PdBCgge8o1uIfD0MrWFbByXfR1RxjynzQnmgEOxPSVK7LTMR2WaDBKs/u++gbG/MKiea
         3ZhUlVRL2UfqcT7sTVysmyGn2RFrzMTD8GeflsZa9wOVAvWn3xg60XIot1yM6P3dZC+5
         NZdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693311305; x=1693916105;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q9VkhPBVgMZOy2Ax+rf67UyJ3baIYOSj8VG/VoffI8E=;
        b=BS0djZn7xrQjLPqky4CeypbRq7Xs6+gU/m1M7gO78A7mpFTkxW09eVm/blyVFSXHyF
         mCKcBZTIRRbXyRFEM9yP/5BrM+REZIdSTDxMYz1WOBnH+/Yvk0TIjRidnkhvMPu268eR
         /6Ig+rjJJYSUawLP1p1vsNe1m6Ih8GsleSiipI9exLSdV/0UD+PBPB5PeuFD9dbiVX/E
         8LvKKp0JBW85ibGTwvcrXSi68NtbLWy5+urq/Ot4sLwf05FpDIX3p/+ffqWf1b+mjxxk
         59AZ+4rJaJ+3UbICDBEIbF4Vy4m6oC4NM12oesZKqSzdaL/FLuVA9ROPaQOxOeESZ06a
         G1kw==
X-Gm-Message-State: AOJu0YxD7NKtIKV79yGI+3Sz6SX3xl9ddwBuZ6GNpUf6ZaGOvOx9mbXy
        ySa/hLM463lAQ1bIdRSm6UYIhEdzZ00=
X-Google-Smtp-Source: AGHT+IEI3w5yoSQaEuzxGLi5JBdbn1FcwHogwtxRb11C5WK0Dzp8trZTEzG1gZcXRqr5W4AoEIsLEg==
X-Received: by 2002:a17:902:f693:b0:1b8:8682:62fb with SMTP id l19-20020a170902f69300b001b8868262fbmr3965311plg.4.1693311305022;
        Tue, 29 Aug 2023 05:15:05 -0700 (PDT)
Received: from debian.me ([103.124.138.83])
        by smtp.gmail.com with ESMTPSA id w5-20020a639345000000b00563df2ba23bsm8964862pgm.50.2023.08.29.05.15.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Aug 2023 05:15:04 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 38CB69DE91DC; Tue, 29 Aug 2023 19:14:59 +0700 (WIB)
Date:   Tue, 29 Aug 2023 19:14:59 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Aaron Lu <aaron.lu@intel.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Borislav Petkov (AMD) <bp@alien8.de>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>
Subject: Re: kexec reboot failed due to commit 75d090fd167ac
Message-ID: <ZO3hQ0rbr8QuUjVI@debian.me>
References: <20230829114816.GA508985@ziqianlu-dell>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="U/CzDxT/qgAVRNod"
Content-Disposition: inline
In-Reply-To: <20230829114816.GA508985@ziqianlu-dell>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--U/CzDxT/qgAVRNod
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 29, 2023 at 07:48:16PM +0800, Aaron Lu wrote:
> Hi Kirill,
>=20
> Ever since v6.5-rc1, I found that I can not use kexec to reboot an Intel
> SPR test machine. With git bisect, the first bad commit is 75d090fd167ac
> ("x86/tdx: Add unaccepted memory support").
>=20
> I have no idea why a tdx change would affect it, I'm not doing anything
> related to tdx.
>=20
> Any ideas?
>=20
> The kernel config is attached, let me know if you need any other info.

Can you provide system logs (e.g. journalctl output) when attempting to
reboot?

Anyway, thanks for the regression report. I'm adding it to regzbot:

#regzbot ^introduced: 75d090fd167aca
#regzbot title: unable to reboot with kexec due to TDX unaccepted memory su=
pport

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--U/CzDxT/qgAVRNod
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZO3hQAAKCRD2uYlJVVFO
owLYAQDWFvGC4cRy/LFARL3LkkawhtjEdwdaR2SPXy2yHSNYUAEAwxLDQPHM7aR0
rAhvatO4U9i0xIIAvgv1aqyGb2BdjQY=
=AcRo
-----END PGP SIGNATURE-----

--U/CzDxT/qgAVRNod--

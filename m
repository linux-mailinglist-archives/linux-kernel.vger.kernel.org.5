Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA792780413
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 05:00:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357383AbjHRC7c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 22:59:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357374AbjHRC7D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 22:59:03 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C2AA2D56;
        Thu, 17 Aug 2023 19:59:02 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1bf0b24d925so3505925ad.3;
        Thu, 17 Aug 2023 19:59:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692327542; x=1692932342;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OGM0P4QSsObJ2FynAssn0+Ri7H0h34gHse+URz3YiUs=;
        b=o9g/AkmUWqAmmvMO3YKtieHGnlnsJmw4U1DEX613KjcVYapP6WvqcTAZe36ws1SdRy
         vMWizAzVoTEajveP9yZStra8fzPYwaDcpJxBejxmQIvRf6XetnmyU0KIx7Md+9Fldtmm
         j7Cbt0wmCsYXp9P/6ovRU5UPihQgGVGUiO24qkQcc21egDX5EsOqzGd6OlLC1PMj+D6a
         nNhSHPoqp8RJGJYM+pQivU5WDy2A2oXB/y82V9j2k3xHHjSvqkgEajsnPCg3rWmSA4He
         lfCdlFbs4iLRORFmRE5I2VQdlMNWSPbyyW/qLVdyYeGRHuqfTbMlOFgc/9skffNUdP/h
         kgHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692327542; x=1692932342;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OGM0P4QSsObJ2FynAssn0+Ri7H0h34gHse+URz3YiUs=;
        b=cJGGcrfEt9I6Yol1V7wa84QDQgVQte47kbs3cTCS8DdoeFZzzXJD9rFR4TaEo1memU
         LmMHraBjJoEQx343sV5lWd4dAL1pGVrm8WE0WbW8sVFuf9fXQqqUv/KXQtnKSlXxct2l
         Isv8HawpmEiaojsS5O2Qkv1yFNSB9rHop4jS5+z6ErOMm82boJqgdmunDQYgyr8p3nyt
         rXAdUHc3ZcxE6pAIP8b0Hc/IzufxBliGmh2t5LV0KDQw9YHig4zpsACisdSX8tR3tDrj
         MYdfsEwsfrY4rboNMUOZ7tJaPUUaSzw3z7BoOYNXL0aqRyIaSOnS/N95nWYh6p54pHQZ
         tzEQ==
X-Gm-Message-State: AOJu0YxdDHd/vjiGy3JgHQBJo6lqYXtfelw+SRq6+ppG+5wqLOa9gwyR
        Pa3rm4V7F4Fljs7Gv6mcp6A=
X-Google-Smtp-Source: AGHT+IHxcnHf0GAe4XzEIZYdVkvMtF4MGhdv2wHY/5C242bmWDcf3qotQDs1jibApYYFaXMJvmemFA==
X-Received: by 2002:a17:903:18b:b0:1b6:9551:e297 with SMTP id z11-20020a170903018b00b001b69551e297mr1342825plg.44.1692327541998;
        Thu, 17 Aug 2023 19:59:01 -0700 (PDT)
Received: from debian.me ([103.124.138.83])
        by smtp.gmail.com with ESMTPSA id ix21-20020a170902f81500b001b9fef7f454sm500306plb.73.2023.08.17.19.59.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Aug 2023 19:59:01 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 428A682136C7; Fri, 18 Aug 2023 07:10:48 +0700 (WIB)
Date:   Fri, 18 Aug 2023 07:10:48 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Todd Brandt <todd.e.brandt@linux.intel.com>,
        mario.limonciello@amd.com, linux-integrity@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, len.brown@intel.com,
        charles.d.prestopine@intel.com, rafael.j.wysocki@intel.com,
        Linux Regressions <regressions@lists.linux.dev>
Subject: Re: REGRESSION WITH BISECT: v6.5-rc6 TPM patch breaks S3 on some
 Intel systems
Message-ID: <ZN63CG6d3d7ifq7U@debian.me>
References: <485e8740385239b56753ce01d8995f01f84a68e5.camel@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="P/mFKmnbvRv9okYG"
Content-Disposition: inline
In-Reply-To: <485e8740385239b56753ce01d8995f01f84a68e5.camel@linux.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--P/mFKmnbvRv9okYG
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 17, 2023 at 02:09:00PM -0700, Todd Brandt wrote:
> While testing S3 on 6.5.0-rc6 we've found that 5 systems are seeing a
> crash and reboot situation when S3 suspend is initiated. To reproduce
> it, this call is all that's required "sudo sleepgraph -m mem -rtcwake
> 15".
>=20
> I=C2=92ve created a Bugzilla to track this issue here:
> https://bugzilla.kernel.org/show_bug.cgi?id=3D217804
>=20
> I've bisected the issue to this patch:
>=20
> commit 554b841d470338a3b1d6335b14ee1cd0c8f5d754
> Author: Mario Limonciello <mario.limonciello@amd.com>
> Date:   Wed Aug 2 07:25:33 2023 -0500
>=20
>     tpm: Disable RNG for all AMD fTPMs
>    =20

Thanks for the regression report. I'm adding it to regzbot:

#regzbot ^introduced: 554b841d470338
#regzbot title: Disabling RNG for AMD fTPMs breaks S3 on some Intel systems

--=20
An old man doll... just what I always wanted! - Clara

--P/mFKmnbvRv9okYG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZN63AwAKCRD2uYlJVVFO
oxQkAP9UZxGZwQebUQ50E2Da9vqTal1MwQJ6QUxsAGEvvsKoFQD9H+tIT8Cus+og
u3lzHFUjRPPr8ytkpB6Y66h6cQo8DQQ=
=4tyF
-----END PGP SIGNATURE-----

--P/mFKmnbvRv9okYG--

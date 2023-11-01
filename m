Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C0607DDB14
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 03:40:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345128AbjKACkG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 22:40:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344638AbjKACkF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 22:40:05 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4504DBD;
        Tue, 31 Oct 2023 19:40:02 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id 41be03b00d2f7-5b9a7357553so1986711a12.0;
        Tue, 31 Oct 2023 19:40:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698806402; x=1699411202; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=smBpOYfhk/pfjcNNkpsnE2kzTUguhXJpDUnYBF4ouWA=;
        b=gVZNy98eMte01UeMX+tdRTTWSPZx2s6tjWDrG3h7qUuD7Zx+4gDNRb4Xw3v0vypQjm
         rADPqCTQSJwSgsZm/8EHNNr/c8GGFURGpHYV+nP8PdfiqxdMQkICnDRDmHP5LloVuK+c
         R3OkOM6AupcxNmC6sYwpEuQFmcQxSPFmilcGGCcHPSY19yIMOjg9/G3RxJuKfxA60NK0
         c8t817tQBoK1oi/MzHb5SaoIWUVUovnItCOxgtAkID+Qs890qsJKxxTuuOhCWWFckzFn
         CPUMiXj1ZFcINLiTr/DaSrBWAO6efvvNQD2ZF3lnmDZ8q4kmg3swBsF38wIASiDqC7cF
         od/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698806402; x=1699411202;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=smBpOYfhk/pfjcNNkpsnE2kzTUguhXJpDUnYBF4ouWA=;
        b=oQcZ6dUxB4W3kk4rOI5XIXrToqJmTTzZxYX97YphU2ssNN2pUUerIKJjEzViLzn5m3
         r+IzJ2bV+Sc/D92TAe+BfRY0E8YkzbxEqrXrCuV/blYcngkpHyFoiZHzAs67jqP2JkEC
         rTiD6+gafcBLvrqXHU5neODMxmyKv6fjxYtcFMxwAM1ueVV7l1nWqg89dRuCRVfE4kVg
         3eNyB8gWMgYAV8QMgRCju9JjjhE03KTmo8J2VQhZyc136LMVTFm4DcveNPPdYLhv+YRd
         Y4A/CZ16n6ew6VxFe8ONKHol5lBNpMFs+D4+kypv0HTSN8cipBaJZWbTs3bqLvT/RCcC
         1Ztw==
X-Gm-Message-State: AOJu0YzWUV0EkAHryRCJ882n9efEnlQzXg9pbTVAHeiimt5Hrl8jPG6S
        pa0qjxtpsKEYrmemsOv9mec=
X-Google-Smtp-Source: AGHT+IEU1DbHr8uTH1PfA/nWbS6KaF/gSC7AdcTayM0DEzrlfEMfGNN/X2pvFenfh7Zr12AsaZMV2w==
X-Received: by 2002:a05:6a20:3c8d:b0:17b:2e82:d4ba with SMTP id b13-20020a056a203c8d00b0017b2e82d4bamr19606806pzj.3.1698806401623;
        Tue, 31 Oct 2023 19:40:01 -0700 (PDT)
Received: from debian.me ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id gq9-20020a17090b104900b002609cadc56esm1691076pjb.11.2023.10.31.19.40.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Oct 2023 19:40:01 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id E3F9B8ABD28E; Wed,  1 Nov 2023 09:39:56 +0700 (WIB)
Date:   Wed, 1 Nov 2023 09:39:56 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
Subject: Re: [PATCH 6.1 00/86] 6.1.61-rc1 review
Message-ID: <ZUG6fHcNiIF_vAkX@debian.me>
References: <20231031165918.608547597@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="sxvVJTZMXxphBC11"
Content-Disposition: inline
In-Reply-To: <20231031165918.608547597@linuxfoundation.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--sxvVJTZMXxphBC11
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 31, 2023 at 06:00:25PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.61 release.
> There are 86 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>=20

Successfully compiled and installed bindeb-pkgs on my computer (Acer
Aspire E15, Intel Core i3 Haswell). No noticeable regressions.

Tested-by: Bagas Sanjaya <bagasdotme@gmail.com>

--=20
An old man doll... just what I always wanted! - Clara

--sxvVJTZMXxphBC11
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZUG6dgAKCRD2uYlJVVFO
o1ydAP9JXEBXa/ufoSY6E0MYe4XOtT56JzoWsdWn+qQ2D0Sx+AEAsZMqP7D7yBPL
+L5H8pMdGsO5VhGXyEjj2Otbu/R84wo=
=Pbts
-----END PGP SIGNATURE-----

--sxvVJTZMXxphBC11--

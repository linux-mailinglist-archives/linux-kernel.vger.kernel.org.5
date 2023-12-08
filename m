Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F7B680A2CB
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 13:06:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233391AbjLHMGG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 07:06:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233428AbjLHMGE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 07:06:04 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C890F173F;
        Fri,  8 Dec 2023 04:06:10 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-6ce6b62746dso1435881b3a.2;
        Fri, 08 Dec 2023 04:06:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702037170; x=1702641970; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=B3bI0QdiAHuPSa9H4aC+fl2+wXCouA4Rc/YcRLrnAcY=;
        b=nKnk5f0MWkoK4o3NAMEN34B5LmYbfrZQWsJZ+q/PdS5nQvdLTv6kiKh2wVs73qBEhC
         USQKxRUGMmPIuNvKZkG1LQ6FpnL37gqk4T9xxtfI0PBQE7HEm8nrmlgkvOWyU9CzCmhj
         qtAoZJW1GO4x5RL3CdXdUh3PTVONCl9baWh3yqNfuGt/mtEVIf9H5lBGpMN/AqI424lK
         DFCWHCKo473S8NV3zcDO6vpPpEc4po+Vfit/9Q5ybvp3xTiKc98JIx/OSv+4Brv4qYbe
         dTXK0iqc7VPoJ6HHH52PKZAYcQO98n3MwWCUkWdmOFSoHEPLjUhUpXeXKvbbQJtakO1B
         6J1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702037170; x=1702641970;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B3bI0QdiAHuPSa9H4aC+fl2+wXCouA4Rc/YcRLrnAcY=;
        b=MXVIkn/kTEY8AekmpkL9RudltW8JG5ZP3SI6vTRKQX3lZOWZ1t9DJqFUiUM5DsyNJR
         FB2EEmQzlUe3vTBHVHbTax9I26Y7MpYtWPxGxkL75Wh0C3i1yum08SbkZeNFoF0CpmDT
         V5SV7ZeXUnkQjyLSRBdmxTZA1ZvQbwDrF2yrxeuc7TPg4rK8zAO9KqIHiRAAuiMRF3XU
         drtcOESzotE2INytdiPDNVVvi5EfmePpFYUKq+SmX+/Xp+XIWJ/9yPuLPdziHa75ldJq
         y15myDYCXXi7EaR1qxBJbGaKqmAXU3Dd2UeUlbWVYDf4Ftzu2T7Eti13KkGIXwLANUwY
         /Zyg==
X-Gm-Message-State: AOJu0YymDBIuol7dmnp7eXsZ0sfnyN9Sf0UjTCiOXBFH6YnVManG12sj
        EhUIZZKioUlEW0K4jGUPhQw=
X-Google-Smtp-Source: AGHT+IGQSdM4C4EViY+s0Sn5W6g6FNtDH69DOstKuZ/C/eT7GACnBk1UtajaTbdCuvjJysMglaLF1w==
X-Received: by 2002:a05:6a00:2344:b0:6ce:379c:ced1 with SMTP id j4-20020a056a00234400b006ce379cced1mr4415425pfj.59.1702037170174;
        Fri, 08 Dec 2023 04:06:10 -0800 (PST)
Received: from archie.me ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id fa24-20020a056a002d1800b006be0fb89ac2sm1416837pfb.197.2023.12.08.04.06.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Dec 2023 04:06:09 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
        id 00684100829BE; Fri,  8 Dec 2023 19:06:02 +0700 (WIB)
Date:   Fri, 8 Dec 2023 19:06:02 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Tom Cook <tom.k.cook@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Kernel Build System <linux-kbuild@vger.kernel.org>,
        Linux Crypto API <linux-crypto@vger.kernel.org>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Nick Terrell <terrelln@fb.com>
Subject: Re: Building signed debs
Message-ID: <ZXMGqjm1466fQ3g2@archie.me>
References: <CAFSh4UwYYAOb0YpC=WAL6SD+8jTLuSkhgrgjh8JmogUb10V=zw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="6UtWxXAwR+spQlxA"
Content-Disposition: inline
In-Reply-To: <CAFSh4UwYYAOb0YpC=WAL6SD+8jTLuSkhgrgjh8JmogUb10V=zw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--6UtWxXAwR+spQlxA
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 08, 2023 at 11:14:35AM +0000, Tom Cook wrote:
> I'm trying to build a signed .deb kernel package of
> https://github.com/torvalds/linux/tree/v6.6.  I've copied
> certs/default_x509.genkey to certs/x509.genkey.  The .config is the
> one from Ubuntu 23.10's default kernel with all new options accepted
> at their default and CONFIG_SYSTEM_TRUSTED_KEYS=3D"" and
> CONFIG_SYSTEM_REVOCATION_KEYS=3D"".
>=20
> This builds the kernel and modules, signs the modules, compresses the
> modules and then attempts to sign the modules again.  That fails,
> because the .ko module files are now .ko.zst files and the file it's
> trying to sign isn't there.  Full failure is pasted below.
>=20
> Unsetting CONFIG_MODULE_COMPRESS_ZSTD is a workaround (ie disable
> module compression).
>=20

Seriously? Unrelated option becomes a workaround?

> Is there a way to build a .deb of a signed kernel with compressed modules?
>=20
> Thanks for any help,
> Tom
>=20
>   INSTALL debian/linux-libc-dev/usr/include
>   SIGN    debian/linux-image/lib/modules/6.6.0-local/kernel/arch/x86/even=
ts/amd/amd-uncore.ko
>   SIGN    debian/linux-image/lib/modules/6.6.0-local/kernel/arch/x86/even=
ts/intel/intel-cstate.ko
> At main.c:298:
> - SSL error:FFFFFFFF80000002:system library::No such file or
> directory: ../crypto/bio/bss_file.c:67

Above means that you don't have a valid certificate/keypair set in
CONFIG_MODULE_SIG_KEY. If you keep the option value on `certs/signing_key.p=
em`
(which is the default), the key should be automatically generated
(with your observation, only if `certs/x509.genkey` doesn't already exist).
After building the kernel with `make all`, you should check if the certific=
ate
pointed in CONFIG_MODULE_SIG_KEY is present or not. If it isn't the case,
you have to generate the certificate yourself. For more information, see
Documentation/admin-guide/module.signing.rst in the kernel sources.

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--6UtWxXAwR+spQlxA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZXMGpwAKCRD2uYlJVVFO
o/gzAP4njblK4gTTlE3jH60ksv9uyLbxlyEwMZPEpSwQpZPIhgD8CZu09C9h+Mqr
vzrIJsHunbR3/wMX+BYuJKtNv9O9xQs=
=2b3i
-----END PGP SIGNATURE-----

--6UtWxXAwR+spQlxA--

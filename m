Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 428CE7FE0C8
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 21:10:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233774AbjK2UKI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 15:10:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233750AbjK2UKG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 15:10:06 -0500
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD13C10C0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 12:10:12 -0800 (PST)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-59b5484fbe6so1511767b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 12:10:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1701288612; x=1701893412; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=++nm0NE1wjSFgfJ+oA6LI8x+PXXZkjba62AlX3Engxo=;
        b=Uf4W6wLfpoQmRdITdmVepuN9De9uvqzkZXgYvfzWsyxg+DZMh4lYl3GB84qyctmYzE
         LJRCM9u/lT80JIfFMVa3tzo8nly31TwAJpdatcMUpENB5OxOcI7HQC8aNj6HxDf25y5G
         YGMUQG+oJWISmxp2zVpbcugvEhT8Cpf5k3Bl8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701288612; x=1701893412;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=++nm0NE1wjSFgfJ+oA6LI8x+PXXZkjba62AlX3Engxo=;
        b=PsjmjbGTMav51kdGsFbzpxX0eoOJZ044OZnbhIlyXDGF/NL0GSGCPC6cVKObYLAWVO
         guKtbKQpJyC06D7l+QGjc+3kcPsXKCex1i9kWokOAUQSUuWIUv35D39SlLe3AuNiDJFg
         MhJLVUFFxFOmhCy4fElBLqlOzqtCzWHDS2ki/7gcvHUurwkTlSf4bF9vDli/mzhuvdab
         FbFB91F04BXExxtOC4I7YUwSmC9mjyJEC1UNutFAo6SoiY8mCF7/unUUfH6Kx/6fAoPt
         Lg62RwcTUK1Jl4enrayD6mdtB8eXKjvAVChsdw8gbaoWawDh/3xV4IC78uHX+LNuKcNu
         dFzg==
X-Gm-Message-State: AOJu0YzBry675HgiLRFdJreAaQQgoWWZc7bagd1sWmMheDjPFw6rPnvm
        geN4A9NMZbKNMVeuqSxO8Hx6wg==
X-Google-Smtp-Source: AGHT+IFxseesvFpRi3k+UKfPPDnFprQlo+h+861n40LNx6xdANz5B6cpkyPa8DLIZz9tSovcfjWG7A==
X-Received: by 2002:a81:b80b:0:b0:5d2:bb18:5834 with SMTP id v11-20020a81b80b000000b005d2bb185834mr1789550ywe.15.1701288611853;
        Wed, 29 Nov 2023 12:10:11 -0800 (PST)
Received: from bill-the-cat (2603-6081-7b00-6400-9fa4-b7c8-6a9a-173e.res6.spectrum.com. [2603:6081:7b00:6400:9fa4:b7c8:6a9a:173e])
        by smtp.gmail.com with ESMTPSA id u67-20020a0dd246000000b005a7d46770f2sm4747109ywd.83.2023.11.29.12.10.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Nov 2023 12:10:11 -0800 (PST)
Date:   Wed, 29 Nov 2023 15:10:09 -0500
From:   Tom Rini <trini@konsulko.com>
To:     Ahmad Fatoum <a.fatoum@pengutronix.de>
Cc:     Simon Glass <sjg@chromium.org>,
        linux-arm-kernel@lists.infradead.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        U-Boot Mailing List <u-boot@lists.denx.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Terrell <terrelln@fb.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Will Deacon <will@kernel.org>, linux-kbuild@vger.kernel.org,
        Pengutronix Kernel Team <kernel@pengutronix.de>
Subject: Re: [PATCH v7 2/2] arm64: boot: Support Flat Image Tree
Message-ID: <20231129201009.GO2513409@bill-the-cat>
References: <20231129172200.430674-1-sjg@chromium.org>
 <20231129172200.430674-3-sjg@chromium.org>
 <30f32467-51ea-47de-a272-38e074f4060b@pengutronix.de>
 <20231129190220.GN2513409@bill-the-cat>
 <62e767da-5e4f-4b92-a5c9-5d523896d68e@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="upRn5Ae3/4tCAJ9Z"
Content-Disposition: inline
In-Reply-To: <62e767da-5e4f-4b92-a5c9-5d523896d68e@pengutronix.de>
X-Clacks-Overhead: GNU Terry Pratchett
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--upRn5Ae3/4tCAJ9Z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 29, 2023 at 08:16:20PM +0100, Ahmad Fatoum wrote:
> Hello Tom,
>=20
> On 29.11.23 20:02, Tom Rini wrote:
> > On Wed, Nov 29, 2023 at 07:59:00PM +0100, Ahmad Fatoum wrote:
> >> Hi,
> >>
> >> a few more comments after decompiling the FIT image:
> >>
> >> On 29.11.23 18:21, Simon Glass wrote:
> >>> +    with fsw.add_node('kernel'):
> >>> +        fsw.property_string('description', args.name)
> >>> +        fsw.property_string('type', 'kernel_noload')
> >>
> >> The specification only says no loading done, but doesn't explain what =
it
> >> means for a bootloader to _not_ load an image. Looking into the U-Boot=
 commit
> >> b9b50e89d317 ("image: Implement IH_TYPE_KERNEL_NOLOAD") that introduce=
s this,
> >> apparently no loading means ignoring load and entry address?
> >>
> >> I presume missing load and entry is something older U-Boot versions
> >> were unhappy about? Please let me know if the semantics are as I under=
stood,
> >> so I can prepare a barebox patch supporting it.
> >=20
> > So the matching side for this series in U-Boot is:
> > https://patchwork.ozlabs.org/project/uboot/list/?series=3D382849&state=
=3D*
> >=20
> > And in short, for IH_TYPE_KERNEL_NOLOAD we do our best to use it
> > in-place. For decompression we allocate some space to decompress to.
>=20
> Thanks. I am still curious why "kernel" couldn't have been used back then
> with missing entry and load address to arrive at the same result?

Some level or another of historical oversight, yeah.

--=20
Tom

--upRn5Ae3/4tCAJ9Z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVnmpoACgkQFHw5/5Y0
tyzzPQv/T8LXUXPqwGoY3YrFdNeX1WZi9rMh14B6pOopoK3qGJJNFa4mnkbQVoh7
gqLKSw9504+kra8XSpnVgy4U0EDBw9f4YKceXrB4n+afk8Ekgt+Qlj4+Cc3MhxvE
VNB006Qxd2fitSUXrvskfyRbn9lEwY8yvKKccd9yEYWjouIK4VzERemejViQsFVY
chJrr1kYTMbys9VNx1a2d4dXfkzu+njkmeR6+SySeITyOyQQjvu8uYmijbG95cEd
hRZn7zbYy8uWO9h2lvtVRBzWWxwAip35RxgL//FWUib3Ge46h85T3SVLs48k6cSW
1BEesLSpxUqz6OllGSviBLPPkcmY2qXQVNDzKalpSSC2JJRtx1HRnGEqcugJpBRH
wGOxa0mmc7QZgFUFqjc5/i2E9X/pn4MBapWLIfecBvy8KdyGADKkWvUG7Y4lpIvz
7QytagHjDQs1bFr88tSgXITHYlLipkr5nGN6/KN0GI/gtlbTBYBYrxB+O+705BgR
h+03xQrY
=HJAr
-----END PGP SIGNATURE-----

--upRn5Ae3/4tCAJ9Z--

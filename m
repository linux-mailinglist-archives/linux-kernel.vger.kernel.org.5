Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22EFB7FE00E
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 20:03:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234545AbjK2TDF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 14:03:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234538AbjK2TCv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 14:02:51 -0500
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BD3D19B7
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 11:02:23 -0800 (PST)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-5cdc0b3526eso911007b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 11:02:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1701284542; x=1701889342; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PcBKeJsKt+Roasz0v1naRUxWIOpYBtLfQ5xNPiC6TzM=;
        b=WRYOue0LYBINaOhdiCni9ywvTheDnT9AJz8e8BfJCIHjWXBMKRPobgdxaEZxTf8Oo9
         aYPhedOUEIkfExb6ZooTfAVms6Jpc4at5dSRvHGHRHSkbsLESS+yEr/+Tv3UpvL1PUSo
         Yq+3RjXDFIj0c2TzQwUOPnyXZPUbf4v7r20Fs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701284542; x=1701889342;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PcBKeJsKt+Roasz0v1naRUxWIOpYBtLfQ5xNPiC6TzM=;
        b=c1elTQnxPhZYu39vUdN+BTz+6iCkV9xGStvvMpUj0cchSStOv6BiwPa/Uw2TfiVgYE
         SCUTmQeDGOuMH+CUlWqy2dYsyxmmLGw1F6S2YUcydMp0j9YTuvCv2bXtpmkCwFZNN3C6
         75WfK1eKSTjpQfHcM1dnTP9mhyM2JL7tYm2OCFNsCPz/Rl75XKglVyfRH/3njMd+iFqH
         oWE/mTjIhLuSN1hFPwrGUSm65bsyGpkRhtY6bBchkwkH0EBXNr6TNWzmA0YjxgsnprYg
         1/qiheVKC0ffE/sluqPelaCpqY01njqvSpUOxp3KtgJs1x90IuQkrijs9flwBCrASEn9
         diBA==
X-Gm-Message-State: AOJu0Yx+qdUv2U4IYTA6FWLtF72Njq54hL8L6BfmsnWYd1/l6KhcQosS
        oLRKX0GfTOMNr0bM5xWqqXm+NQ==
X-Google-Smtp-Source: AGHT+IHzHkSwEXPTpHD57NNGdkBTndkGP7v7ThfK3Xt/uxEh/1wuIb2yMo1BQbLzKgaGrors4qyDxw==
X-Received: by 2002:a0d:dd48:0:b0:5ca:befc:a40d with SMTP id g69-20020a0ddd48000000b005cabefca40dmr15747142ywe.24.1701284542439;
        Wed, 29 Nov 2023 11:02:22 -0800 (PST)
Received: from bill-the-cat (2603-6081-7b00-6400-9fa4-b7c8-6a9a-173e.res6.spectrum.com. [2603:6081:7b00:6400:9fa4:b7c8:6a9a:173e])
        by smtp.gmail.com with ESMTPSA id gb12-20020a05690c408c00b005cf2d42a7b2sm3225892ywb.93.2023.11.29.11.02.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Nov 2023 11:02:22 -0800 (PST)
Date:   Wed, 29 Nov 2023 14:02:20 -0500
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
Message-ID: <20231129190220.GN2513409@bill-the-cat>
References: <20231129172200.430674-1-sjg@chromium.org>
 <20231129172200.430674-3-sjg@chromium.org>
 <30f32467-51ea-47de-a272-38e074f4060b@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="vJJLzijI2B35z7R9"
Content-Disposition: inline
In-Reply-To: <30f32467-51ea-47de-a272-38e074f4060b@pengutronix.de>
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


--vJJLzijI2B35z7R9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 29, 2023 at 07:59:00PM +0100, Ahmad Fatoum wrote:
> Hi,
>=20
> a few more comments after decompiling the FIT image:
>=20
> On 29.11.23 18:21, Simon Glass wrote:
> > +    with fsw.add_node('kernel'):
> > +        fsw.property_string('description', args.name)
> > +        fsw.property_string('type', 'kernel_noload')
>=20
> The specification only says no loading done, but doesn't explain what it
> means for a bootloader to _not_ load an image. Looking into the U-Boot co=
mmit
> b9b50e89d317 ("image: Implement IH_TYPE_KERNEL_NOLOAD") that introduces t=
his,
> apparently no loading means ignoring load and entry address?
>=20
> I presume missing load and entry is something older U-Boot versions
> were unhappy about? Please let me know if the semantics are as I understo=
od,
> so I can prepare a barebox patch supporting it.

So the matching side for this series in U-Boot is:
https://patchwork.ozlabs.org/project/uboot/list/?series=3D382849&state=3D*

And in short, for IH_TYPE_KERNEL_NOLOAD we do our best to use it
in-place. For decompression we allocate some space to decompress to.

--=20
Tom

--vJJLzijI2B35z7R9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVnirIACgkQFHw5/5Y0
tywO/Qv/c1oNc+/ouJBT1KN2K5RbgEALOt+sPZhysWelxhSqkcPlCjb5gfuJ7ajV
Ul6k85FSpkGagwKzxfHCIxhuhNRgNTJ5CQZCZ5MwXV/H8oWad0dUVVbIbcWwe11/
y9nWedxeH0poGkNULDIDQZr6d76QRvZjl631Xsz/jgTYlCXtTCin55blEo4d1oqL
L203Zw/qoqem8gHc3UEUcVBfudB3hKE5NVKarLqcbW179w0tnKnCTunDWC8+Hseh
FgcJ5m+x4xn4bkNkEiPZnVwhWFLsu90PAUY7SCGt1dyilThXE2WYoYGLULi3OeLz
3EzdtJkMPqy65I95k1+fAYBHaKN/EecR7nytt7XxP/8SE/N/Qt4R72L5Uf/CCjVs
WbPx6LV02Ig8z4F5sH3JXgaw3W0xrYWH7F9rhSbxGiWi7OAFosfXFsGTSbShpBuC
rKD+0n8q2yqyuPBpOOV18L33WCapVyvWwjf24ozKiUiaitcXvQ5REdRVp20/bhq8
55QIYmgN
=y4fu
-----END PGP SIGNATURE-----

--vJJLzijI2B35z7R9--

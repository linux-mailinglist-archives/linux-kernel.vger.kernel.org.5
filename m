Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39FE97DDD5C
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 08:40:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231905AbjKAHkL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 03:40:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231587AbjKAHkG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 03:40:06 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 537E3110
        for <linux-kernel@vger.kernel.org>; Wed,  1 Nov 2023 00:39:59 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-6bb4abb8100so5914217b3a.2
        for <linux-kernel@vger.kernel.org>; Wed, 01 Nov 2023 00:39:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698824399; x=1699429199; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qaTfkXJcsWYh5uAYv4mhG+OfOpapi/f9ImTWYM58lNM=;
        b=JePA0cXMov8F2VPFksPc7DfqWIE03Xs24RjpdequRoXlDsGpvyb2txum4Vz0KpPNiz
         uLL1HargJwOAI64GjDCb1h9qVttQrwOJ4jWTh2dRNhlA1AnD8FxAoBmFPG0+u5xfma61
         Va/7BlDFjFlpUV0n1ghPcO1tswUOAUG+2L6hZE/xgre4CuNAZNO3KCoTApET+5cxkLSw
         6mUgfNy6olf3PGI2OsBTCiF60sRLENlvkdYTmlHSRVXJFdLecPD1tW69BGE1/RU8LPV5
         no+IhOOWObTdBuK5CpMj2BKpfCsrqvxSpuhYVFaZ0DAa48Mpftds9gb4OnkY8hHdry6O
         DuRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698824399; x=1699429199;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qaTfkXJcsWYh5uAYv4mhG+OfOpapi/f9ImTWYM58lNM=;
        b=QerwQR7NYzWUMQaQQ9ra0CL2R+VdP6RJ9impdFWsvjj9bN388a91JCFvrGw+ziqMI0
         1flLGet/MrMb4EEDp9TPefa9CRZaa3X0ll2o69+nwG4PtHc7STtReT4/lOz0P8f4DY9g
         6gTWz+Yfp9fIN0uenBmQirGsp+dUN82XQ1/0eemNb7wTCdbHz8CN3BoXafmhEkXC8o58
         zqSp2BGLSllxA0ckYq/mp3semfFgPUBkjrXZWPK8nJsHzUwCpN4+Ld2PhyFvmdOZM8c2
         3brtFDTIT97wiSFBaEeDJu/FLRztFgIaF9J2WJDOQG1/siSumxYt7zdX8/Wcly94fOa/
         x58g==
X-Gm-Message-State: AOJu0YyWBvLBferLZVTcx0MFQyFN0y7eakdeNNenMElL2QtFLghEKC1U
        mpbJrCgCETV9nHFYIKLStsfNoJ0FTrU=
X-Google-Smtp-Source: AGHT+IEJK9IqlBWln2yy8MTDkKAUjJX4cbHw4LlzZt41nQjEK0AZpfxOQ4Vtl74E5H+jxfuKAwW9fw==
X-Received: by 2002:a05:6a21:338b:b0:159:e0b9:bd02 with SMTP id yy11-20020a056a21338b00b00159e0b9bd02mr14538190pzb.40.1698824398648;
        Wed, 01 Nov 2023 00:39:58 -0700 (PDT)
Received: from debian.me ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id mu13-20020a17090b388d00b00274922d4b38sm332174pjb.27.2023.11.01.00.39.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Nov 2023 00:39:58 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id DD85280A734F; Wed,  1 Nov 2023 14:39:53 +0700 (WIB)
Date:   Wed, 1 Nov 2023 14:39:53 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Dorine Tipo <dorine.a.tipo@gmail.com>,
        Linux Outreachy <outreachy@lists.linux.dev>,
        Greg KH <gregkh@linuxfoundation.org>,
        Linux Staging Drivers <linux-staging@lists.linux.dev>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     Martyn Welch <martyn@welchs.me.uk>,
        Manohar Vanga <manohar.vanga@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Charles Han <hanchunchao@inspur.com>
Subject: Re: [PATCH] staging: vme: enhance the help paragraphs for clarity
Message-ID: <ZUIAyQGSfIKqK7AE@debian.me>
References: <20231029180346.8570-1-dorine.a.tipo@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ph4bCGRF0u6YYI3A"
Content-Disposition: inline
In-Reply-To: <20231029180346.8570-1-dorine.a.tipo@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ph4bCGRF0u6YYI3A
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

[Cc'ing driver contributors found via get_maintainer.pl. Also Cc: Charles f=
rom
linux-doc mailing list as wording patches like this one most likely suit hi=
m.]

On Sun, Oct 29, 2023 at 06:03:46PM +0000, Dorine Tipo wrote:
> diff --git a/drivers/staging/vme_user/Kconfig b/drivers/staging/vme_user/=
Kconfig
> index d65cc5510649..65a3e769090d 100644
> --- a/drivers/staging/vme_user/Kconfig
> +++ b/drivers/staging/vme_user/Kconfig
> @@ -4,6 +4,11 @@ menuconfig VME_BUS
>  	depends on PCI
>  	help
>  	  If you say Y here you get support for the VME bridge Framework.
> +          The VME Bridge Framework provides a set of tools and drivers
> +          for VMEbus systems, allowing seamless integration of VME devic=
es
> +          with your PCI-enabled hardware. Select 'Y' to enable this feat=
ure
> +          if you have VMEbus-based hardware or intend to use VME devices=
 in
> +          your system.
> =20
>  if VME_BUS
> =20
> @@ -14,7 +19,10 @@ config VME_TSI148
>  	depends on HAS_DMA
>  	help
>  	 If you say Y here you get support for the Tundra TSI148 VME bridge
> -	 chip.
> +	 chip. This bridge chip provides compatibility for VMEbus systems, allo=
wing
> +         communication with various VME devices. If you have hardware th=
at
> +         includes the Tundra TSI148 VME bridge, or if you plan to use VME
> +         devices with your system, choose 'Y' to enable this feature.

Dorine,

Are you sure that your description properly describes what these modules
are doing? And most importantly, when users select them as module (choose
M), what will the modules be named?

Confused...

--=20
An old man doll... just what I always wanted! - Clara

--ph4bCGRF0u6YYI3A
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZUIAxAAKCRD2uYlJVVFO
owJoAQC2v2Rw64vzjbVbztTMOUI/hXJ2aOgbdCacohfuzvYkZwD/ciCDXTleE1P8
GIh/Nsy2OZwTuZDFK26syy2LxMaRAA8=
=fXwj
-----END PGP SIGNATURE-----

--ph4bCGRF0u6YYI3A--

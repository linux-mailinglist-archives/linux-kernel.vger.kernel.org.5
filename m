Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F1FE80B1F2
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Dec 2023 04:53:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234238AbjLIDvM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 22:51:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229731AbjLIDvK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 22:51:10 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D24B10D7;
        Fri,  8 Dec 2023 19:51:16 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1cfb30ce241so24455585ad.0;
        Fri, 08 Dec 2023 19:51:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702093876; x=1702698676; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WO8EnlAvYoab/qWcCpLZUGAlqCqd0Kozwq+LnU4Q2sM=;
        b=CaNuCSAiWc+v58FsmYyWA6OvUhPp1/FxU4qB1A3WHdoy03FwKX58zAlo1MqjFEiuS6
         zkxKDR30IijQL5Zqnw81tr9yjjwB8rmbSToAP4GYktGx7LrOy/T3NF7q93/4rBExav6w
         /WwKuUYvF6NEe6smbFiCTfU7rDUj4v0jgZggQ+/BsVGTnuRkGt9Cid8Sa5kqfZWv457M
         Bc5qGkk3uqF3rBaXHch05fkn1npWk0s+rBWz4l2Vsa5mW8EnROnW2ur/0DBP/p88OC7+
         CR5mOIgVrqgFes3OuE6mbb5QyBTOFmep2hca3ld4XtI21dqgJsHAhAMTsAr7VKbQRDhL
         EbZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702093876; x=1702698676;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WO8EnlAvYoab/qWcCpLZUGAlqCqd0Kozwq+LnU4Q2sM=;
        b=WMJQ7u6Lksu7D+tsbI1cxDniOEb98NnlJRmSIz5EL6yEV2JA6UKAV4/1Wg7y9ZOEYo
         WwJxm3XWIvEUjfrIEIiIdNbuMWxtt+5p2fSefg8fJm80wkA7vHy3iRpF4Z5yeyt83p6M
         hgcdA0SbqfPEIT9d7MjcxSaL66ZIUl2TDb5uS98ndO97QUuQ8tkYPXOASwvndS1l0kL9
         kruO7SLmthjJbPduRGKeek4w7k4Z6siIKDxoYA9I3P9pFWIfvW7GwuWa42n2NKCffanx
         6TJTljqRd6aYnaDRjzjQexgG5phNpfxBGc/luHxf0OVgwnGrDzvJaPjTWKMfREyrvlzs
         KREw==
X-Gm-Message-State: AOJu0YyP19azAKjQMEnGBur9pE8g3VMnUvBpNeyVTQ+ZTsGCR+JTtPaD
        ke3nCjCIfbg991ovOqLhFYU=
X-Google-Smtp-Source: AGHT+IGuWuhSktyQmxa4f8CGiYcPGAeiBClMm6X2q+TfV7tyTdyUQBY++cFn6OyVz5zhgY7ErgKJNA==
X-Received: by 2002:a17:902:c942:b0:1d0:7c2a:581a with SMTP id i2-20020a170902c94200b001d07c2a581amr1055748pla.104.1702093875832;
        Fri, 08 Dec 2023 19:51:15 -0800 (PST)
Received: from archie.me ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id ge13-20020a17090b0e0d00b00286816715ccsm4100353pjb.54.2023.12.08.19.51.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Dec 2023 19:51:15 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
        id 1125210211A57; Sat,  9 Dec 2023 10:51:11 +0700 (WIB)
Date:   Sat, 9 Dec 2023 10:51:11 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Alexander Graf <graf@amazon.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     Linux Documentation <linux-doc@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jan H =?utf-8?B?LiBTY2jDtm5oZXJy?= <jschoenh@amazon.de>,
        James Gowans <jgowans@amazon.com>
Subject: Re: [PATCH v3] initramfs: Expose retained initrd as sysfs file
Message-ID: <ZXPkL1jyXwGH11gJ@archie.me>
References: <20231207235654.16622-1-graf@amazon.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="FEeb2quylvE884eW"
Content-Disposition: inline
In-Reply-To: <20231207235654.16622-1-graf@amazon.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--FEeb2quylvE884eW
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 07, 2023 at 11:56:54PM +0000, Alexander Graf wrote:
> When the kernel command line option "retain_initrd" is set, we do not
> free the initrd memory. However, we also don't expose it to anyone for
> consumption. That leaves us in a weird situation where the only user of
> this feature is ppc64 and arm64 specific kexec tooling.
>=20
> To make it more generally useful, this patch adds a kobject to the
> firmware object that contains the initrd context when "retain_initrd"
> is set. That way, we can access the initrd any time after boot from
> user space and for example hand it into kexec as --initrd parameter
> if we want to reboot the same initrd. Or inspect it directly locally.
>=20
> With this patch applied, there is a new /sys/firmware/initrd file when
> the kernel was booted with an initrd and "retain_initrd" command line
> option is set.
>=20
> Signed-off-by: Alexander Graf <graf@amazon.com>
> Tested-by: Bagas Sanjaya <bagasdotme@gmail.com>
>=20
> ---
>=20
> v1 -> v2:
>=20
>   - Reword commit message to explain the new file path
>   - Add a Documentation/ABI/testing/sysfs-firmware-initrd file
>=20
> v2 -> v3:
>=20
>   - Only expose file when initrd is present (James Gowans)
> ---
>  .../ABI/testing/sysfs-firmware-initrd          |  8 ++++++++
>  .../admin-guide/kernel-parameters.txt          |  5 +++--
>  init/initramfs.c                               | 18 +++++++++++++++++-
>  3 files changed, 28 insertions(+), 3 deletions(-)
>  create mode 100644 Documentation/ABI/testing/sysfs-firmware-initrd
>=20
> diff --git a/Documentation/ABI/testing/sysfs-firmware-initrd b/Documentat=
ion/ABI/testing/sysfs-firmware-initrd
> new file mode 100644
> index 000000000000..20bf7cf77a19
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-firmware-initrd
> @@ -0,0 +1,8 @@
> +What:		/sys/firmware/initrd
> +Date:		December 2023
> +Contact:	Alexander Graf <graf@amazon.com>
> +Description:
> +		When the kernel was booted with an initrd and the
> +		"retain_initrd" option is set on the kernel command
> +		line, /sys/firmware/initrd contains the contents of the
> +		initrd that the kernel was booted with.
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentat=
ion/admin-guide/kernel-parameters.txt
> index 65731b060e3f..51575cd31741 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -2438,7 +2438,7 @@
>  			between unregistering the boot console and initializing
>  			the real console.
> =20
> -	keepinitrd	[HW,ARM]
> +	keepinitrd	[HW,ARM] See retain_initrd.
> =20
>  	kernelcore=3D	[KNL,X86,IA-64,PPC]
>  			Format: nn[KMGTPE] | nn% | "mirror"
> @@ -5580,7 +5580,8 @@
>  			Useful for devices that are detected asynchronously
>  			(e.g. USB and MMC devices).
> =20
> -	retain_initrd	[RAM] Keep initrd memory after extraction
> +	retain_initrd	[RAM] Keep initrd memory after extraction. After boot, it=
 will
> +			be accessible via /sys/firmware/initrd.
> =20
>  	retbleed=3D	[X86] Control mitigation of RETBleed (Arbitrary
>  			Speculative Code Execution with Return Instructions)

You may want to adjust documentation to address my testing [1]. In summary,
only the first initrd blob that was passed to the kernel will be exposed
in /sys/firmware/initrd.

Thanks.

[1]: https://lore.kernel.org/linux-doc/2a86a7f2-bbf3-43fb-82b9-40d3397d5578=
@amazon.com/

--=20
An old man doll... just what I always wanted! - Clara

--FEeb2quylvE884eW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHQEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZXPkLwAKCRD2uYlJVVFO
o9Z1AQCrQWF83AwPizuC8FtE0SS3p1lFf+f38Wykxgk15JAF8gD4v/ytNV/onDNw
N7yfBdbLcPzFteCaq5ja89PggYOIDw==
=bnQr
-----END PGP SIGNATURE-----

--FEeb2quylvE884eW--

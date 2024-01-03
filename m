Return-Path: <linux-kernel+bounces-15512-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BC46822CF0
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 13:23:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE2A02859AE
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 12:23:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4B8B1944C;
	Wed,  3 Jan 2024 12:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mh72JUB1"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E5CC19440
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jan 2024 12:23:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB30FC433CC
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jan 2024 12:23:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704284581;
	bh=g3EasEFWBDztvGOMenjxWfrFYdfpFvT5fkzMoi0apYc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=mh72JUB1UQQTOjrGpuSqTKjE0KqJU5dz3vZL4R/Milqk4QYuTxW1juJX0oe3TxYy8
	 54PsL4R1FzLFvV6RKbBa3+1xYv8RBJVkb9lzSRAQ5KluGwh+D04P7vNgOfBPx4nKIu
	 Yc3Sw/PwCRNevJFDxP/RX/LnbRk3vPJDvBmmdabqMrfpSDtcQRaDcS9venlfyHRhkO
	 KO/+m+alEsn0VL8sCFjhFPyNKMjZ+lyp4JRuG5pHZcoxMTznjJ01V/ffZK0fkI0fVh
	 aDlLV/MzlXq4JNcS1za86pifkfYplD/nZIm6uQgkeksx42TxwGxLgPu+440Q1pqck4
	 eyhEPFnMAXFdA==
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-204f50f305cso3513274fac.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jan 2024 04:23:00 -0800 (PST)
X-Gm-Message-State: AOJu0YxtOWHWKj1jM7AaufkkOrLEL1UG6FYf07zR2laHmC4ml6hRcUEo
	GOKCGeT7fyV/5hir77I4cAc3GFLkh06aGE95XT4=
X-Google-Smtp-Source: AGHT+IGy58lmyIdeginvCrhn8pE7lMkcS1bzgd6ZIyxTfqgTgnbGY0+WEDxsFaeD5uEIBoYhkBNsWjNpijkeqkKfs7c=
X-Received: by 2002:a05:6871:b28:b0:204:f0e:167b with SMTP id
 fq40-20020a0568710b2800b002040f0e167bmr24870542oab.73.1704284580278; Wed, 03
 Jan 2024 04:23:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1703042081.git.kevinmbecause@gmail.com> <cd370037f8c21dc851a2a33a07250459c9c98708.1703042082.git.kevinmbecause@gmail.com>
In-Reply-To: <cd370037f8c21dc851a2a33a07250459c9c98708.1703042082.git.kevinmbecause@gmail.com>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Wed, 3 Jan 2024 21:22:23 +0900
X-Gmail-Original-Message-ID: <CAK7LNARP3oZu+H=vNjNx=1A3+eObnFK86rmcH7JubG9H6vF+8w@mail.gmail.com>
Message-ID: <CAK7LNARP3oZu+H=vNjNx=1A3+eObnFK86rmcH7JubG9H6vF+8w@mail.gmail.com>
Subject: Re: [PATCH 2/2] firmware_loader: Enable compressed files in EXTRA_FIRMWARE
To: Kevin Martin <kevinmbecause@gmail.com>
Cc: Luis Chamberlain <mcgrof@kernel.org>, Russ Weight <russ.weight@linux.dev>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 20, 2023 at 7:33=E2=80=AFPM Kevin Martin <kevinmbecause@gmail.c=
om> wrote:
>
> The linux-firmware packages on Gentoo, Fedora, Arch, and others compress
> the firmware files. This works well with CONFIG_FW_LOADER_COMPRESS, but
> does not work with CONFIG_EXTRA_FIRMWARE. This patch allows the build
> system to decompress firmware files specified by CONFIG_EXTRA_FIRMWARE.
> Uncompressed files are used first, then the compressed files are used.







>
> Signed-off-by: Kevin Martin <kevinmbecause@gmail.com>
> ---
>  drivers/base/firmware_loader/Kconfig          |  5 ++++-
>  drivers/base/firmware_loader/builtin/Makefile | 16 ++++++++++++----
>  2 files changed, 16 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/base/firmware_loader/Kconfig b/drivers/base/firmware=
_loader/Kconfig
> index 5ca00e02f..b7a908bff 100644
> --- a/drivers/base/firmware_loader/Kconfig
> +++ b/drivers/base/firmware_loader/Kconfig
> @@ -76,7 +76,10 @@ config EXTRA_FIRMWARE
>           image since it combines both GPL and non-GPL work. You should
>           consult a lawyer of your own before distributing such an image.
>
> -         NOTE: Compressed files are not supported in EXTRA_FIRMWARE.
> +         NOTE: Compressed files are supported by EXTRA_FIRMWARE. The bui=
ld
> +         system will look for uncompressed files first then fall back to
> +         searching for compressed files in a similar way to
> +         CONFIG_FW_LOADER_COMPRESS.
>
>  config EXTRA_FIRMWARE_DIR
>         string "Firmware blobs root directory"
> diff --git a/drivers/base/firmware_loader/builtin/Makefile b/drivers/base=
/firmware_loader/builtin/Makefile
> index 6c067dedc..cc60eb441 100644
> --- a/drivers/base/firmware_loader/builtin/Makefile
> +++ b/drivers/base/firmware_loader/builtin/Makefile
> @@ -20,7 +20,7 @@ filechk_fwbin =3D \
>         echo "    .section .rodata"                             ;\
>         echo "    .p2align 4"                                   ;\
>         echo "_fw_$(FWSTR)_bin:"                                ;\
> -       echo "    .incbin \"$(fwdir)/$(FWNAME)\""               ;\
> +       echo "    .incbin \"$(obj)/$(FWNAME)\""         ;\




Insert a tab to keep the alignment of ";\"




Also, please update the .gitignore because
any arbitrary firmware file might be copied to
this directory.
All files except the 3 check-in files must be
ignored.



@@ -1,2 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
-*.gen.S
+*
+!.gitignore
+!Makefile
+!main.c









--
Best Regards
Masahiro Yamada


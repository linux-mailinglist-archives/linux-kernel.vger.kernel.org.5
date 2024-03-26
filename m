Return-Path: <linux-kernel+bounces-119192-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0561088C553
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 15:39:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8FF9A1F3B77E
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 14:39:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A061113C3F7;
	Tue, 26 Mar 2024 14:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pjwfmNZ1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D49B613C3DB;
	Tue, 26 Mar 2024 14:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711463962; cv=none; b=QH5GfCddvh/CJdgv2HHYo2eZBVEmab21APzVSET279vBECmE7WKe6MQzk1yCcgq/kXTlMHFicqweB4zDxLq4eGuPmegNS9kqEnx5lzhvx2mSmDCNJETyxoRhR8XYnXugbK8GK0EBoczB/cElD3dpgT8Y1fsupTZ9vYuT2mRsHSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711463962; c=relaxed/simple;
	bh=694uUrQurged0DpiGcIKRXaR7f7IY1ihpJjxlFzcTmk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u9thdaV3hks+RekVD9pMZgNn6U5xUs/AQ/ig50vpXkn91BKYO6S1W13M0tPlQ9mijmfBPq7YpQjnuMBJ68L4LOxBSp6XLoYBYOvQJLFpDfqgCGVMtU9yu3be0HLdI8MniVSkUM24Sgj289Vi5XieSr9KX06f0NrHJUIN05ItZYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pjwfmNZ1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D684C433F1;
	Tue, 26 Mar 2024 14:39:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711463961;
	bh=694uUrQurged0DpiGcIKRXaR7f7IY1ihpJjxlFzcTmk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=pjwfmNZ1TweH9ISfP9b/Kmwt/5cyA42r1F1XKtie1SFE90bnSPsWUp9mgj5sz+wu5
	 9oR4383cI/j5IDxSLXpccKFuY1VW5mv4ekQIvXjMjaTRN6sUadwz5tnOFnUEoQ7Q90
	 SFFn0WTcQyUJ7PvU+q85kgC3ZL1jYp1f+QAl0CyaPZvhQbSNn2oPG0EwowtfaPih8s
	 FQMoex/0eXJdAaHxVcC+ygzwkQq9/URLvpyrRhbSj/CFbpcsp56k8G2EtuY457hP9z
	 i61md7kqXW1ZV7XJWmNRXkW8r71RDsG10R43ip/GT55jceOu/yLNSFwMxutiP9+i3z
	 fu3as+SmNMIAA==
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2d6c8d741e8so48994441fa.3;
        Tue, 26 Mar 2024 07:39:21 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXeT0BG2NVCKm0VqavueHPCRlBYAoNoSjbLFsnkwzvAXRp1JusySytZ5ji6EGPgVDfLw8pJHHfx32hzw0i/vgzUjewsH38KDVwXztWlK4r4dugo0cCsk2uAPXfFDq3xAW6QpU7zHYDFEuXRcEUeqCu2SOXqTXmhQ1yuRWVgBHyQ9KQs/3d7PcHTmONuwBs8u5ySW+xGzN86y3xA6enIl3ma
X-Gm-Message-State: AOJu0YxfjLQgy9PWFYjKfJP/9f5DarWrGtMq2iruwop4aOjWVLKT4bEW
	4PZ9EBp2Q9CpVatBYsnAUukmzFL35eNeY7MlYWxk9iP4Zsf1GJMHaUrGlH8//R6wxxB8CpMaWMG
	KyLFoZ2k3PvO6gZCjWETJ+yBZSQs=
X-Google-Smtp-Source: AGHT+IHRLtVwQBliK06CNyOkOnUVQC6pejo7AnQDeCYkZeCtaGd/3ULk5T8a2lopDISmhpKZBiypht1J7vGrFSjSdRI=
X-Received: by 2002:a2e:989a:0:b0:2d2:3fac:5fc7 with SMTP id
 b26-20020a2e989a000000b002d23fac5fc7mr5651686ljj.45.1711463960202; Tue, 26
 Mar 2024 07:39:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240314042659.232142-1-sjg@chromium.org> <20240314042659.232142-3-sjg@chromium.org>
In-Reply-To: <20240314042659.232142-3-sjg@chromium.org>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Tue, 26 Mar 2024 23:38:44 +0900
X-Gmail-Original-Message-ID: <CAK7LNASWKyTXuPwj0_xaD=8_WfbXhejCe_Z+2Os2MD+mU_D5Fg@mail.gmail.com>
Message-ID: <CAK7LNASWKyTXuPwj0_xaD=8_WfbXhejCe_Z+2Os2MD+mU_D5Fg@mail.gmail.com>
Subject: Re: [PATCH v11 2/2] arm64: boot: Support Flat Image Tree
To: Simon Glass <sjg@chromium.org>
Cc: linux-arm-kernel@lists.infradead.org, 
	Ahmad Fatoum <a.fatoum@pengutronix.de>, Nicolas Schier <nicolas@fjasle.eu>, 
	Catalin Marinas <catalin.marinas@arm.com>, Jonathan Corbet <corbet@lwn.net>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Terrell <terrelln@fb.com>, Will Deacon <will@kernel.org>, 
	linux-doc@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, workflows@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 14, 2024 at 1:28=E2=80=AFPM Simon Glass <sjg@chromium.org> wrot=
e:
>
> Add a script which produces a Flat Image Tree (FIT), a single file
> containing the built kernel and associated devicetree files.
> Compression defaults to gzip which gives a good balance of size and
> performance.
>
> The files compress from about 86MB to 24MB using this approach.
>
> The FIT can be used by bootloaders which support it, such as U-Boot
> and Linuxboot. It permits automatic selection of the correct
> devicetree, matching the compatible string of the running board with
> the closest compatible string in the FIT. There is no need for
> filenames or other workarounds.
>
> Add a 'make image.fit' build target for arm64, as well.
>
> The FIT can be examined using 'dumpimage -l'.
>
> This uses the 'dtbs-list' file but processes only .dtb files, ignoring
> the overlay .dtbo files.
>
> This features requires pylibfdt (use 'pip install libfdt'). It also
> requires compression utilities for the algorithm being used. Supported
> compression options are the same as the Image.xxx files. Use
> FIT_COMPRESSION to select an algorithm other than gzip.
>
> While FIT supports a ramdisk / initrd, no attempt is made to support
> this here, since it must be built separately from the Linux build.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>
> Changes in v11:
> - Use dtbslist file in image.fit rule
> - Update cmd_fit rule as per Masahiro
> - Don't mention ignoring files without a .dtb prefix
> - Use argparse fromfile_prefix_chars feature
> - Add a -v option and use it for output (with make V=3D1)
> - rename srcdir to dtbs
> - Use -o for the output file instead of -f
>




> --- a/scripts/Makefile.lib
> +++ b/scripts/Makefile.lib
> @@ -504,6 +504,21 @@ quiet_cmd_uimage =3D UIMAGE  $@
>                         -a $(UIMAGE_LOADADDR) -e $(UIMAGE_ENTRYADDR) \
>                         -n '$(UIMAGE_NAME)' -d $< $@
>
> +# Flat Image Tree (FIT)
> +# This allows for packaging of a kernel and all devicetrees files, using
> +# compression.
> +# ----------------------------------------------------------------------=
-----
> +
> +MAKE_FIT :=3D $(srctree)/scripts/make_fit.py
> +
> +# Use this to override the compression algorithm
> +FIT_COMPRESSION ?=3D gzip
> +
> +quiet_cmd_fit =3D FIT     $@
> +      cmd_fit =3D $(MAKE_FIT) -o $@ --arch $(UIMAGE_ARCH) --os linux \
> +               --name '$(UIMAGE_NAME)' $(if $(V),-v) \
> +               --compress $(FIT_COMPRESSION) -k $< @$(word 2,$^)
> +




A nit in your new code.


$(if $(V),-v) does not work for KBUILD_VERBOSE env variable.


It should be

    $(if $(findstring 1,$(KBUILD_VERBOSE)),-v)





--=20
Best Regards
Masahiro Yamada


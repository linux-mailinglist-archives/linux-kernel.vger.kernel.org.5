Return-Path: <linux-kernel+bounces-27272-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 45A1E82ED0D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 11:51:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE25C1F2431B
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 10:51:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 104B818ED8;
	Tue, 16 Jan 2024 10:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BsxJpqkm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A781134D6;
	Tue, 16 Jan 2024 10:50:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32F44C433C7;
	Tue, 16 Jan 2024 10:50:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705402254;
	bh=fg+u4GK6DKFx16CsnCP6JZlz9e2/T4cItts13457GWA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=BsxJpqkm2Jm1chIN21JxxYKKzI4VoGRAdHWfuacXisteLEN6RF9KLBF9yOidKbkiZ
	 nT+LFz3kbvO108MuvU8NQOh8hJN58b1xtcMy4DgkCr8K3PLxHqZ0UQ0j5MkIqhSQ4W
	 +qJK3scjugND5L4ujNCnvilC2LjJsPuHkL2As+D5pwxT57wqu5zIp+89n09wsljGg+
	 Mh5BNAjzJN6gyd4TRq7o7SNkzOuBxt61N+9/30H5wL4JngKp9N/bdIJOaxhUTXyGvS
	 d6KPs4vXKaXKBobup2mfOo1FZ44MJoJMKM55+7TbwFB3l28oz2Iygp11hqRaCoskxb
	 jfT8z4a+fKbeQ==
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-6dddf12f280so5370493a34.0;
        Tue, 16 Jan 2024 02:50:54 -0800 (PST)
X-Gm-Message-State: AOJu0Yyi5ZDjYAQ4ip+9FwehbSra1QEdgPkTQwXmtVnVZyn3Wl6woan6
	jEGV9C66p7IxJ3PWbq9/91jwLWrjrnypCGsnuRQ=
X-Google-Smtp-Source: AGHT+IH8NadaWc4/zirP3PWnCkUjkpGPSorQduwoY/EsVpWj+T2/XzHxRklsoREU0xX3+boxBb3/Mh7qawVIr21Mhto=
X-Received: by 2002:a05:6870:525:b0:206:74c9:c0e3 with SMTP id
 j37-20020a056870052500b0020674c9c0e3mr9062285oao.6.1705402253568; Tue, 16 Jan
 2024 02:50:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240116001514.214199-1-sashal@kernel.org> <20240116001514.214199-7-sashal@kernel.org>
In-Reply-To: <20240116001514.214199-7-sashal@kernel.org>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Tue, 16 Jan 2024 19:50:17 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQHRwqjLcjLoOm8SEn5wje6A7aKhbjBdyFpxU1jorhPcw@mail.gmail.com>
Message-ID: <CAK7LNAQHRwqjLcjLoOm8SEn5wje6A7aKhbjBdyFpxU1jorhPcw@mail.gmail.com>
Subject: Re: [PATCH AUTOSEL 5.4 7/7] selftests/nolibc: use EFI -bios for
 LoongArch qemu
To: Sasha Levin <sashal@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	=?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
	Willy Tarreau <w@1wt.eu>, linux-kbuild@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 16, 2024 at 9:15=E2=80=AFAM Sasha Levin <sashal@kernel.org> wro=
te:
>
> From: Thomas Wei=C3=9Fschuh <linux@weissschuh.net>
>
> [ Upstream commit bdeeeaba83682225a7bf5f100fe8652a59590d33 ]
>
> qemu for LoongArch does not work properly with direct kernel boot.
> The kernel will panic during initialization and hang without any output.
>
> When booting in EFI mode everything work correctly.
>
> While users most likely don't have the LoongArch EFI binary installed at
> least an explicit error about 'file not found' is better than a hanging
> test without output that can never succeed.
>
> Link: https://lore.kernel.org/loongarch/1738d60a-df3a-4102-b1da-d16a29b6e=
06a@t-8ch.de/
> Signed-off-by: Thomas Wei=C3=9Fschuh <linux@weissschuh.net>
> Acked-by: Willy Tarreau <w@1wt.eu>
> Link: https://lore.kernel.org/r/20231031-nolibc-out-of-tree-v1-1-47c92f73=
590a@weissschuh.net
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  Makefile | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)




This backport makes me upset.

The original commit, bdeeeaba83682225a7bf5f100fe8652a59590d33,
changed tools/testing/selftests/nolibc/Makefile.


However, this backport changes the top Makefile.


What is happening in the back-port logic?
















> diff --git a/Makefile b/Makefile
> index 500edb9d9f15..33d118fbb432 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -584,6 +584,13 @@ ifdef config-build
>  # *config targets only - make sure prerequisites are updated, and descen=
d
>  # in scripts/kconfig to make the *config target
>
> +QEMU_BIOS_DIR =3D /usr/share/edk2/
> +QEMU_BIOS_loongarch =3D $(QEMU_BIOS_DIR)/loongarch64/OVMF_CODE.fd
> +
> +ifneq ($(QEMU_BIOS_$(XARCH)),)
> +QEMU_ARGS_BIOS =3D -bios $(QEMU_BIOS_$(XARCH))
> +endif
> +
>  # Read arch specific Makefile to set KBUILD_DEFCONFIG as needed.
>  # KBUILD_DEFCONFIG may point out an alternative default configuration
>  # used for 'make defconfig'
> @@ -1375,7 +1382,7 @@ _modinst_:
>         @sed 's:^:kernel/:' modules.order > $(MODLIB)/modules.order
>         @sed 's:^:kernel/:' modules.builtin > $(MODLIB)/modules.builtin
>         @cp -f $(objtree)/modules.builtin.modinfo $(MODLIB)/
> -       $(Q)$(MAKE) -f $(srctree)/scripts/Makefile.modinst
> +       $(Q)$(MAKE) $(QEMU_ARGS_BIOS) -f $(srctree)/scripts/Makefile.modi=
nst
>
>  # This depmod is only for convenience to give the initial
>  # boot a modules.dep even before / is mounted read-write.  However the
> --
> 2.43.0
>


--=20
Best Regards
Masahiro Yamada


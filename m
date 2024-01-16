Return-Path: <linux-kernel+bounces-27274-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5604082ED1E
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 11:52:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C0301C231A0
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 10:52:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B793319454;
	Tue, 16 Jan 2024 10:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N1ma1vf+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 101F918ED8;
	Tue, 16 Jan 2024 10:51:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBDADC433B2;
	Tue, 16 Jan 2024 10:51:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705402314;
	bh=P8tqp8EC1bLMwSOm33OFhQamnUjYm2hce6stofe2tD8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=N1ma1vf+EDPxUMn8fN2JBsbhj0wxc+Sh4YHtqwguZnYvvHi6bGAyKX1wEBvVTdut4
	 gjkyffF7+2TM3nGN75eBQTw3gEqfUe4LlcXgYpGhHTCFERmNj79j85DZooJG6+jYw1
	 wdY6VbQIiRPKzTIt/VkvRlAmDff8gPxDl+ihaoDaupk5/Lnebow3UYxSjjHl2HcN9w
	 BK513gQf0TThSxNfT6TfVJoimghdbOuS+voSkmDX7QcmBSweV6dLuJu0OQenTSF2fA
	 CvVJR6deqwmQ5+3w+0Z61t60yd7TtTiw9QDYXxDN9lTrh3C79AfgnQxXWbjCMkW52H
	 lN1tnKG6cVtnA==
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-3bd813ff6ebso646985b6e.1;
        Tue, 16 Jan 2024 02:51:54 -0800 (PST)
X-Gm-Message-State: AOJu0YzqNjE76sEagJPU9OOdVhvbcjm3Oh5TurfLAdLmelaW40Z/ShFY
	WyDVSI5TgUfMh/gf/0VlajdRx0PgNJvMyGuLyuw=
X-Google-Smtp-Source: AGHT+IETFqwkJQIj4Ddyfoj46BZVi7zTxJO0Cq/ktw9PbRRnWq5ZRJp+1ptYev3sDy6DdHrpvhYT4cCXCdH0R1NlYw8=
X-Received: by 2002:a05:6870:6e10:b0:203:4b98:a239 with SMTP id
 qt16-20020a0568706e1000b002034b98a239mr4547545oab.89.1705402314238; Tue, 16
 Jan 2024 02:51:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240116001526.214354-1-sashal@kernel.org> <20240116001526.214354-5-sashal@kernel.org>
In-Reply-To: <20240116001526.214354-5-sashal@kernel.org>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Tue, 16 Jan 2024 19:51:18 +0900
X-Gmail-Original-Message-ID: <CAK7LNARFMD3HwQUDAcd4L12Je=XNKWUxiF=Ps_Mp28Vdv=TyKw@mail.gmail.com>
Message-ID: <CAK7LNARFMD3HwQUDAcd4L12Je=XNKWUxiF=Ps_Mp28Vdv=TyKw@mail.gmail.com>
Subject: Re: [PATCH AUTOSEL 4.19 5/5] selftests/nolibc: use EFI -bios for
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


Same for the AUTOSEL 5.4.






>  1 file changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/Makefile b/Makefile
> index fc7bc81130dc..40c860f1c0a3 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -548,6 +548,13 @@ ifeq ($(config-targets),1)
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
> @@ -1303,7 +1310,7 @@ _modinst_:
>         fi
>         @cp -f $(objtree)/modules.order $(MODLIB)/
>         @cp -f $(objtree)/modules.builtin $(MODLIB)/
> -       $(Q)$(MAKE) -f $(srctree)/scripts/Makefile.modinst
> +       $(Q)$(MAKE) $(QEMU_ARGS_BIOS) -f $(srctree)/scripts/Makefile.modi=
nst
>
>  # This depmod is only for convenience to give the initial
>  # boot a modules.dep even before / is mounted read-write.  However the
> --
> 2.43.0
>


--
Best Regards

Masahiro Yamada


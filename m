Return-Path: <linux-kernel+bounces-36613-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3001983A3C5
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 09:10:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C62041F2A94B
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 08:10:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D3FE1754D;
	Wed, 24 Jan 2024 08:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Be/4faaP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC04217543;
	Wed, 24 Jan 2024 08:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706083829; cv=none; b=RcNQHfVlTr2p93EpCf2NN69C9wVkt+pXEoHg/UWBYWEm3/cdvJZ8xOXuANJ26lkIqdBvMuIdORh4DG5AMw+El4kJL518nQQ/e2gz98u8GNEnF2or6Eg0to6RYY+ALTV6WN3PMA2TXGOXs2//I3USNFUJqv5rookPKBw72WwMgFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706083829; c=relaxed/simple;
	bh=+8JZzEIgT7bpfHtk9GT4g0y3Rz9s9vRremrPl4vsyUw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RVl+kRgKTbjTqSCFVKl6EdM+sO3OlP9ry6zfIC9jedY/23FHwAtKNp8gZt5OwMiKH883fNeGtcDF18JeW4c6updLpgwVukGx8fNdYxzTuHfE6pR3y6/GK9rxAF90vRQIUwXG03U2O8eVYa/sN5G21Kc8a0M1EHWKSuI99pmgaNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Be/4faaP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63E3CC433C7;
	Wed, 24 Jan 2024 08:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706083829;
	bh=+8JZzEIgT7bpfHtk9GT4g0y3Rz9s9vRremrPl4vsyUw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Be/4faaPcYI1OaNiCQxY+rhTxphHihPLon5EhImRKLMRXYiCgW+XdSuGI0MvFT9AJ
	 W7REz22h2JHp3pT6szGgbTb4/E4hr7ptDhkDUwOpekGvOEofB0OkTrM3qxZmIlhypM
	 g+5WtBofMns+EV6Xu7V7lXE7rqBhDlLZWSYrUsLV/Du4GbzSFl4c4q69uxapC0PP7V
	 pvK7MgPLjP2RsHwM3mAL1DAtThQ3aJw5F1hSvoTSdlQ1H60kuCnlrCAZHmpDEJqKEk
	 Z/3vo6fBr6Onbw5Bj3xssvDEYoRIXHZsDjkvdd2m+O/zcVSWFIe0v8OUHJ7ba9JCCp
	 kW1hcsG67EXyw==
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-6e0d86d4659so3653378a34.1;
        Wed, 24 Jan 2024 00:10:29 -0800 (PST)
X-Gm-Message-State: AOJu0YydmYtS/ckvdyJNittW3ZMHYxly/lMYVly6+9IonZfpvpn2D7MF
	z1VYh0vTtHwvI+iLC+lOknbyRoIwD7zVPTB8/n0llFst8lX5spLpzCo9ukqd8O4P3j+BSVFZ67e
	CYKR2zTq0OR/Q0j/Z9t3d5+qCYQ0=
X-Google-Smtp-Source: AGHT+IHTTkKqrs+IkNqEOi3lyaxdmLMLrhgnb3iJJ27TdTrmykRRTIdtFE+SsUl8KVUw/el35PmsfUb+fpLzduu+MSY=
X-Received: by 2002:a05:6870:2102:b0:210:b031:9b14 with SMTP id
 f2-20020a056870210200b00210b0319b14mr2971101oae.116.1706083828725; Wed, 24
 Jan 2024 00:10:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231125163559.824210-1-masahiroy@kernel.org> <CAMuHMdWm6u1wX7efZQf=2XUAHascps76YQac6rdnQGhc8nop_Q@mail.gmail.com>
 <d21298d9-fed6-4e08-9780-dbcb388b9ccc@smile.fr>
In-Reply-To: <d21298d9-fed6-4e08-9780-dbcb388b9ccc@smile.fr>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Wed, 24 Jan 2024 17:09:52 +0900
X-Gmail-Original-Message-ID: <CAK7LNASaG4DpHTb3YHMd8d8DJ5H3z0aiUcSqX+=7CZb99kRU8A@mail.gmail.com>
Message-ID: <CAK7LNASaG4DpHTb3YHMd8d8DJ5H3z0aiUcSqX+=7CZb99kRU8A@mail.gmail.com>
Subject: Re: [PATCH 1/2] kconfig: remove unneeded symbol_empty variable
To: Yoann Congal <yoann.congal@smile.fr>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Linux-Renesas <linux-renesas-soc@vger.kernel.org>, 
	Vegard Nossum <vegard.nossum@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 24, 2024 at 12:11=E2=80=AFAM Yoann Congal <yoann.congal@smile.f=
r> wrote:
>
> Le 23/01/2024 =C3=A0 13:54, Geert Uytterhoeven a =C3=A9crit :
> > Hi Yamada-san,
>
> Hello,
>
> > On Sat, Nov 25, 2023 at 5:36=E2=80=AFPM Masahiro Yamada <masahiroy@kern=
el.org> wrote:
> >> This is used only for initializing other variables.
> >>
> >> Use the empty string "".
> >>
> >> Please note newval.tri is unused for S_INT/HEX/STRING.
> >>
> >> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> >
> > Thanks for your patch, which is now commit 4e244c10eab345a7
> > ("kconfig: remove unneeded symbol_empty variable") in v6.8-rc1.
> >
> > When running "make <foo>_defconfig" with <foo>_defconfig an SMP
> > defconfig without explicit configuration of CONFIG_LOG_CPU_MAX_BUF_SHIF=
T,
> > the aforementioned commit causes a change in the generated .config:
> >
> > -CONFIG_LOG_CPU_MAX_BUF_SHIFT=3D12
> > +CONFIG_LOG_CPU_MAX_BUF_SHIFT=3D0
> >
> > It looks like CONFIG_BASE_SMALL=3D0 is treated as a string instead of
> > the integer number zero?
> >
> > init/Kconfig=3Dconfig LOG_CPU_MAX_BUF_SHIFT
> > init/Kconfig-   int "CPU kernel log buffer size contribution (13 =3D> 8
> > KB, 17 =3D> 128KB)"
> > init/Kconfig-   depends on SMP
> > init/Kconfig-   range 0 21
> > init/Kconfig:   default 12 if !BASE_SMALL
> > init/Kconfig:   default 0 if BASE_SMALL
> >
> > Note that reverting 4e244c10eab345a7 is not sufficient to fix the issue=
.
> > Also reverting commit 6262afa10ef7cc8f ("kconfig: default to zero if
> > int/hex symbol lacks default property") does fix it.
>
> (Since I'd really like 6262afa10ef7cc8f ("kconfig: default to zero if int=
/hex symbol lacks default property") to stay, allow me to try to help)
>
> The problem is quite easy to reproduce:
>   $ make x86_64_defconfig
>   $ grep 'LOG_CPU_MAX_BUF_SHIFT\|BASE_SMALL\|BASE_FULL' .config
>   CONFIG_LOG_CPU_MAX_BUF_SHIFT=3D0
>   CONFIG_BASE_FULL=3Dy
>   CONFIG_BASE_SMALL=3D0
> Here, CONFIG_LOG_CPU_MAX_BUF_SHIFT should be 12 not 0.



I could not produce it in this way.
I ran the same commands as yours.

CONFIG_LOG_CPU_MAX_BUF_SHIFT=3D12 for me.



masahiro@zoe:~/ref/linux(master)$ git describe
v6.8-rc1-29-g615d30064886
masahiro@zoe:~/ref/linux(master)$ git diff
masahiro@zoe:~/ref/linux(master)$ make  x86_64_defconfig
#
# No change to .config
#
masahiro@zoe:~/ref/linux(master)$ grep
'LOG_CPU_MAX_BUF_SHIFT\|BASE_SMALL\|BASE_FULL' .config
CONFIG_LOG_CPU_MAX_BUF_SHIFT=3D12
CONFIG_BASE_FULL=3Dy
CONFIG_BASE_SMALL=3D0
















>
> For what it is worth, CONFIG_BASE_SMALL is defined as an int but is only =
used as a bool :
>    $ git grep BASE_SMALL
>   arch/x86/include/asm/mpspec.h:#if CONFIG_BASE_SMALL =3D=3D 0
>   drivers/tty/vt/vc_screen.c:#define CON_BUF_SIZE (CONFIG_BASE_SMALL ? 25=
6 : PAGE_SIZE)
>   include/linux/threads.h:#define PID_MAX_DEFAULT (CONFIG_BASE_SMALL ? 0x=
1000 : 0x8000)
>   include/linux/threads.h:#define PID_MAX_LIMIT (CONFIG_BASE_SMALL ? PAGE=
_SIZE * 8 : \
>   include/linux/udp.h:#define UDP_HTABLE_SIZE_MIN         (CONFIG_BASE_SM=
ALL ? 128 : 256)
>   include/linux/xarray.h:#define XA_CHUNK_SHIFT           (CONFIG_BASE_SM=
ALL ? 4 : 6)
>   init/Kconfig:   default 12 if !BASE_SMALL
>   init/Kconfig:   default 0 if BASE_SMALL
>   init/Kconfig:config BASE_SMALL
>   kernel/futex/core.c:#if CONFIG_BASE_SMALL
>   kernel/user.c:#define UIDHASH_BITS      (CONFIG_BASE_SMALL ? 3 : 7)
>
> Maybe we should change CONFIG_BASE_SMALL to the bool type?
>
> I'll poke around to see if I can understand why a int=3D"0" is true for k=
config.
>
> Regards,
> --
> Yoann Congal
> Smile ECS - Tech Expert
>


--=20
Best Regards
Masahiro Yamada


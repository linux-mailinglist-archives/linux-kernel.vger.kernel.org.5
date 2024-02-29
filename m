Return-Path: <linux-kernel+bounces-86023-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3637086BEA8
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 02:59:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 681CD1C22F5A
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 01:59:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFDFC364B1;
	Thu, 29 Feb 2024 01:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RZ0pvQSl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2B2036AF2;
	Thu, 29 Feb 2024 01:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709171954; cv=none; b=X+Jk16v/hkQ+EpHeCzyiQXqaf4jA64wTiYr+IVGeJj3fBtCRRIjQaxcYB2hFsVWMaa9gEvI9KBKczf8vNhZ4e14gJ1RrQTgYOGvxtuHJenZlHCDEGh7oEMepyV1xRz7AeqIkXZuM+ojhPvmbX51SzY93QDJcGu4/mO+c9+OlIhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709171954; c=relaxed/simple;
	bh=qCUF4ZiJ/WUEdYewRqWljvO+xUTWXzcWRS3iZxX10/c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lrWsqNoKhs4VatD3qvdfALLRkdvbWKsvzw5EeZEcGDAW+Q3tCmfjTvTOj79F4+UtemMxmR6jQa9rKgTARLBImaQv6pVZgoqtBWx7Yi1jjUSwUmcoAk701L9DheRdWIs7/imiPrJYJbm2LjWLLi9xjrdU266ffW5TZ8b01r4GiXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RZ0pvQSl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86682C433F1;
	Thu, 29 Feb 2024 01:59:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709171953;
	bh=qCUF4ZiJ/WUEdYewRqWljvO+xUTWXzcWRS3iZxX10/c=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=RZ0pvQSlAPxwedBHuaikZ+HTmSfix/qT5zJS52KOPE3INtIoFKe+DKzBmIEojzsud
	 L7F/1LIYwEtucCYDTqmpVmuD1J4dpkvvNsYrmyLz+0iZ7UqG9WoAoGUFSlR3Hrj38H
	 repSzw+nJGOwH1nUeygy37F43qqx0+uu0vsm073j2uHXtsAxRf5hn+VE5e1W3sS0hl
	 vbwhAZDyzftr28d9Ib/8AReJbl03HvJtC+CY3tOfUUcXgnPGMFwHF1yhu4E3Yf4cmw
	 5qcpTmTptnyc/tC27QkAQ0IP+Z3qEG+j5bAL62xbbBYgyTFhqNSyyPdjMhP+h0ImPN
	 5Q9BE6W4haJrg==
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5131a9b3d5bso344093e87.0;
        Wed, 28 Feb 2024 17:59:13 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVgL8EJtI+2adPPpwZa5Q7PvGBotnkIXTkMRB3vatPjUvT0vzZQ2DQgv1q7lgWfc/wa6bDldADTVvkcnzXihAaqKk3kKNwk6JJyRl2e
X-Gm-Message-State: AOJu0YySFzY/ou9NuPNoWWN0Y6X81l9FyhSXbP41x8eBT1ZnbLPEfGdl
	H2kPrJq1Ee7s3vGTdY2CHCIE1kD8qrdHyugkOQFlYUNgTb3jrrN/HWMyzUxmhXlcvgV1gAepI3o
	zxFs0lleUNHDKjgpluLL74Q1m1no=
X-Google-Smtp-Source: AGHT+IGoAeg4nTUz5td/qqnZ3Wy3kX0L5UJIJyywFprzNK5dvnX0pLiYznRExSB/H6H7E4LE17Tp8oDd7b7P/8fpCT0=
X-Received: by 2002:ac2:5e2f:0:b0:513:2508:7b2d with SMTP id
 o15-20020ac25e2f000000b0051325087b2dmr266304lfg.42.1709171952095; Wed, 28 Feb
 2024 17:59:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240228060006.13274-1-tfiga@chromium.org>
In-Reply-To: <20240228060006.13274-1-tfiga@chromium.org>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Thu, 29 Feb 2024 10:58:35 +0900
X-Gmail-Original-Message-ID: <CAK7LNASjnwOcybuag62LkCQZGg73Dpa--jkfgtnB-r1Z=2Xqsw@mail.gmail.com>
Message-ID: <CAK7LNASjnwOcybuag62LkCQZGg73Dpa--jkfgtnB-r1Z=2Xqsw@mail.gmail.com>
Subject: Re: [PATCH v2] kconfig: menuconfig: Make hidden options show with
 different color
To: Tomasz Figa <tfiga@chromium.org>
Cc: linux-kbuild@vger.kernel.org, Nicolas Schier <n.schier@avm.de>, 
	linux-kernel@vger.kernel.org, Jesse Taube <Mr.Bossman075@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 28, 2024 at 3:00=E2=80=AFPM Tomasz Figa <tfiga@chromium.org> wr=
ote:
>
> When hidden options are toggled on (using 'z'), the number of options
> on the screen can be overwhelming and may make it hard to distinguish
> between available and hidden ones. Make them easier to distinguish by
> displaying the hidden one with a different color (COLOR_YELLOW for color
> themes and A_DIM for mono).
>
> Signed-off-by: Tomasz Figa <tfiga@chromium.org>
> ---


> diff --git a/scripts/kconfig/lxdialog/util.c b/scripts/kconfig/lxdialog/u=
til.c
> index 3f78fb265136..161224dd6fb5 100644
> --- a/scripts/kconfig/lxdialog/util.c
> +++ b/scripts/kconfig/lxdialog/util.c
> @@ -38,6 +38,8 @@ static void set_mono_theme(void)
>         dlg.menubox_border.atr =3D A_NORMAL;
>         dlg.item.atr =3D A_NORMAL;
>         dlg.item_selected.atr =3D A_REVERSE;
> +       dlg.item_hidden.atr =3D A_NORMAL | A_DIM;


Nit.


(A_NORMAL | A_DIM) should be A_DIM.


A_NORMAL is zero.

Other A_* attributes are bit flags that can be OR'ed.




--
Best Regards
Masahiro Yamada


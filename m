Return-Path: <linux-kernel+bounces-66315-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 832CC855A36
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 06:52:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B4CFD1C2356F
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 05:52:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 730CDBA29;
	Thu, 15 Feb 2024 05:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qRp36Rda"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A95B3B677;
	Thu, 15 Feb 2024 05:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707976358; cv=none; b=tXQBHAIvnu9XDBnAGRH3L4lduNAeadwgE2GT7X2TPW8ll2aB+ebB38JlQDe/vc6UePL0LACTrLIxp4IKcsCMv9MDN3wT/TIfrXzxWOk2JbXOMPfIOa6+n6IJ/UuvLGMdZ68A2AA1EXnnAP/jsByGe5eCgFz+T9sHa+zbXM4G0uY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707976358; c=relaxed/simple;
	bh=n7/pkPHlAktAexz8EdSTzeX/t4EOMrhXcrkbcT8DtGg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BeLa5/Bn5TIUPpI1li/VPgh+k5R32WDX2/Yqyg7aLutvPHO6xiRj2jb4WbfxkHn9ZsX4dKuQvsOhNJdBjorfNOzcRloLACP+vGJrnK8PUbK47Ud7CfkWekD92ASl4KoPFMNlL35wUTxrS+17jkTNk3jdclvZxCj9XhpQ9nGF0eU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qRp36Rda; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40FBEC43394;
	Thu, 15 Feb 2024 05:52:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707976358;
	bh=n7/pkPHlAktAexz8EdSTzeX/t4EOMrhXcrkbcT8DtGg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=qRp36RdaxGrN0NWcy/pMYOyLKVosFZrT7xo8T1uYFyKI2TiRw5Y6967U45DcwPrHZ
	 fsqJeORy7dMnqbSMOZAhIXoGtXop8zdxJshWLK8NG6o/joejsYJYk9aNnTBDkESMHK
	 MhGxoRVKIVXDLGHU+pNri1KX1cRJQCVPzit5Q43Amr5f/UyYT2Y+wKvNyOdn7EICEP
	 0vf+MS6sQufHQdxo2i31vmPb6CaA8IBckTJ22HfC94VxyhHX8aQJ+QvZe0Ki0GD09j
	 Ct9cHnvEKzxPQzGNclUrWT9XHc/txyRBQyrYm5+y/Wy8rVxzhJ3xabaOWuiMgvRwSu
	 6NsI0exTSayrg==
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-51182ece518so554498e87.3;
        Wed, 14 Feb 2024 21:52:38 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXseMfrAgmUUfW9qV0dBYY6u/Fib3iYJ7NnVOfaUnbKL91I09rF8Mpk1T/nA26vQSlzA9hKS5tlxKbZynPOvJ9gwfhNiV6cN6AvrUWTGhYobSnIdQJJqzRFMZg7JN6etsjnxP6c++c9lmGL
X-Gm-Message-State: AOJu0YysfcOpgK1nAIG5/9Hlg5lvrGmmpuzfgxpUfgQWPTalIOS9X6it
	x10ESscW3Mb0cFMT+MrXGw7TTPBZTBVbyFpfdyEF/jwHYOaZEF9lbB1xeLSseNJeBV3ID4+zXqa
	/kdb81G1B0JupzSILZZEXWU02sio=
X-Google-Smtp-Source: AGHT+IFsnITUjUlPBqJAXGrwbL+h3v+GNKltubY2PmV7QIkIgyN15+eO2xyQgoZ712n9C2lbvHJ/VS9IWSDMHnEeInA=
X-Received: by 2002:a05:6512:39c9:b0:511:5d0c:4abd with SMTP id
 k9-20020a05651239c900b005115d0c4abdmr847468lfu.38.1707976356875; Wed, 14 Feb
 2024 21:52:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240212-coreboot-mod-defconfig-v4-0-d14172676f6d@collabora.com> <Zc2HBmDPJnHt0WJC@google.com>
In-Reply-To: <Zc2HBmDPJnHt0WJC@google.com>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Thu, 15 Feb 2024 14:52:00 +0900
X-Gmail-Original-Message-ID: <CAK7LNATc0KkstjU8ErryV-GckvUKTsjR8naTRSifjw_TZYdSig@mail.gmail.com>
Message-ID: <CAK7LNATc0KkstjU8ErryV-GckvUKTsjR8naTRSifjw_TZYdSig@mail.gmail.com>
Subject: Re: [PATCH v4 0/4] Allow coreboot modules to autoload and enable
 cbmem in the arm64 defconfig
To: Tzung-Bi Shih <tzungbi@kernel.org>
Cc: =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= <nfraprado@collabora.com>, 
	Arnd Bergmann <arnd@arndb.de>, Brian Norris <briannorris@chromium.org>, 
	Julius Werner <jwerner@chromium.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nicolas Schier <nicolas@fjasle.eu>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, kernel@collabora.com, 
	chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-kbuild@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 15, 2024 at 12:37=E2=80=AFPM Tzung-Bi Shih <tzungbi@kernel.org>=
 wrote:
>
> On Mon, Feb 12, 2024 at 09:50:04AM -0500, N=C3=ADcolas F. R. A. Prado wro=
te:
> > This series adds the missing pieces to the coreboot bus and the module
> > alias generation to allow coreboot modules to be automatically loaded
> > when matching devices are detected.
> >
> > The configs for cbmem coreboot entries are then enabled in the arm64
> > defconfig, as modules, to allow reading logs from coreboot on arm64
> > Chromebooks, which is useful for debugging the boot process.
> >
> > [...]
> >
> > ---
> > N=C3=ADcolas F. R. A. Prado (4):
> >       firmware: coreboot: Generate modalias uevent for devices
> >       firmware: coreboot: Generate aliases for coreboot modules
> >       firmware: coreboot: Replace tag with id table in driver struct
> >       arm64: defconfig: Enable support for cbmem entries in the coreboo=
t table
> >
> >  arch/arm64/configs/defconfig                   |  3 +++
>
> Hi Catalin and Will,
>
> Is it OK to you if I pick the 4th patch (which touches the above files) t=
o
> chrome-platform-firmware tree for the next merge window?
>
> >  include/linux/mod_devicetable.h                | 10 ++++++++++
> >  scripts/mod/devicetable-offsets.c              |  3 +++
> >  scripts/mod/file2alias.c                       | 10 ++++++++++
>
> Hi Masahiro,
>
> Is it OK to you if I pick the 2nd patch (which touches the above files) t=
o
> chrome-platform-firmware tree for the next merge window?


Yes.


I gave Acked-by to 2/4 so it makes your life easier.




--=20
Best Regards
Masahiro Yamada


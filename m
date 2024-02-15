Return-Path: <linux-kernel+bounces-66313-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F52E855A33
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 06:51:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97FFF28F2E8
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 05:51:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DD56BA29;
	Thu, 15 Feb 2024 05:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FU11tw6x"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB77A8F4E;
	Thu, 15 Feb 2024 05:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707976286; cv=none; b=AoWUzkQ4ByJAcyGQDeY9Odl21wIvMqTVntVLpQq3gfsrUTkqs/sWd9+zGuuc8f7QQ3oGYUBcjMt6ME7gBQfb/f95TEeDvgmtXCYHaeMeYzKp2ooyty2fhwCN7aBkPhFIu7QetMFFDoQ5SatQ4PzFJIA8xB2n0n46UfPuhlkXoc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707976286; c=relaxed/simple;
	bh=vN7MCwTLwLnvk9WWo0RxU5cJ2q/qqz/7Vlw6seBKkdE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Pmak9sdOZ6R1qz4ltgOEC/2k8qi7p3dWn5aajPo56tvM6Zg9U1Ak2FrlfcnwvK6F+pKn1nF62V+kS9QIGOz4rv2oK0rVtP5KHvLCStEon/JpE25G2PLu+uhYqNeZAjlrtJd8xn20a5unBAfadccjUT8D1JUW7aJ7DAmxgvFz/aQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FU11tw6x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31B8DC43399;
	Thu, 15 Feb 2024 05:51:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707976286;
	bh=vN7MCwTLwLnvk9WWo0RxU5cJ2q/qqz/7Vlw6seBKkdE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=FU11tw6xpUmJvzSliH25LHi3P45mr19GUZt0TbBMNGO8+izHpAErH6Gh5ZeHUDW2y
	 Mxird2u9mgekexKkakNs8jmwreJqQX2aXl7gntbDRMF2D4v661SZ0+YuU5BQH1ymCq
	 e/GtRq4N+qgVmPwPdhQCz0NiWBAMaX9VRO/dNrtGvv9SRMAIMum6ZMa9CQWODcLnxA
	 aLJmKK80mbP/qpofrQr2Kd0mbWIKPsdug5lFFRThpBcwp/uP/dak6EnBwR5+GQFbJW
	 Vx5RrU6LODESeUgHgJVyAUWhEzWj1EVVyFiM4jFmEqI8n/UGNwbFWKkkOnYlaIl8d3
	 yhntSPKRg1Klg==
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-511a4a1c497so491261e87.3;
        Wed, 14 Feb 2024 21:51:26 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXU7W9RzxlwvnaxX+Y+wuPS+az/90SRYOFKbED5FECFQO3ODU6lDuF86NNCDPMppHXH4YpX9MHNDMQXBLD1pc7Dt8CJlNcCQws1JfKe/7oQ09r6dgv00x+YuuZUVgMmkHzjS5bf4t3lDr0C
X-Gm-Message-State: AOJu0Yw+DRQYyhZKSjBGlEDKZm3mM1IyBfrXbt/c96cSQnhkxQ+wacLB
	uoiS1DfsFPiB1fvbYkIIbhP+7iV+cDbhDIXWCh1F9gIC/mAP/PsItgV/3bIRrypDjLOIK+EMZ2D
	sqfPHHPePuYkQTtJ5WXmIEG046S0=
X-Google-Smtp-Source: AGHT+IFEpuM4TCTzRj2NftvgACtWzuJCwVaZkKN0LP3m7ajuCdc/KsIvF3vBgFAICFUvQ6QR+YuDq5mCqv2nvyAvovg=
X-Received: by 2002:ac2:43a7:0:b0:511:87eb:8dc4 with SMTP id
 t7-20020ac243a7000000b0051187eb8dc4mr617322lfl.32.1707976284715; Wed, 14 Feb
 2024 21:51:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240212-coreboot-mod-defconfig-v4-0-d14172676f6d@collabora.com> <20240212-coreboot-mod-defconfig-v4-2-d14172676f6d@collabora.com>
In-Reply-To: <20240212-coreboot-mod-defconfig-v4-2-d14172676f6d@collabora.com>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Thu, 15 Feb 2024 14:50:47 +0900
X-Gmail-Original-Message-ID: <CAK7LNASTG=xzodA6sAKTBaq09aDPZ9oqxcX2Q4iCuPrL+foQ8g@mail.gmail.com>
Message-ID: <CAK7LNASTG=xzodA6sAKTBaq09aDPZ9oqxcX2Q4iCuPrL+foQ8g@mail.gmail.com>
Subject: Re: [PATCH v4 2/4] firmware: coreboot: Generate aliases for coreboot modules
To: =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= <nfraprado@collabora.com>
Cc: Tzung-Bi Shih <tzungbi@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Brian Norris <briannorris@chromium.org>, Julius Werner <jwerner@chromium.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas@fjasle.eu>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, kernel@collabora.com, 
	chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-kbuild@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 12, 2024 at 11:51=E2=80=AFPM N=C3=ADcolas F. R. A. Prado
<nfraprado@collabora.com> wrote:
>
> Generate aliases for coreboot modules to allow automatic module probing.
>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collab=
ora.com>
> Reviewed-by: Brian Norris <briannorris@chromium.org>
> Signed-off-by: N=C3=ADcolas F. R. A. Prado <nfraprado@collabora.com>


Acked-by: Masahiro Yamada <masahiroy@kernel.org>



--=20
Best Regards
Masahiro Yamada


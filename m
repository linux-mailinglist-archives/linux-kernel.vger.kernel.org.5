Return-Path: <linux-kernel+bounces-120119-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A32E488D298
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 00:03:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 12094B2227E
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 23:03:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D27213DDCF;
	Tue, 26 Mar 2024 23:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="eIfMHGsP"
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7D976FE16;
	Tue, 26 Mar 2024 23:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711494193; cv=none; b=HJBu7tbEnrFPwaQPzVdzTKBmbWsi6f9tNkAEWFx/edOYNIdQ3AW3uGFaT7XYxCue17glmYoIiazHuYbf/8NTg7twzG959f2dkqPCjEUSVgRge7otOVEvmGYNCMpuoAAoMI06SrGBlnJN+p2C14Z+9RS1dtCwDODsMipNH/QdbCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711494193; c=relaxed/simple;
	bh=iTn6EPmsN8OMOA4hJKWthraMCB2c+E5xZHjJCKAza/I=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jA+ExowZtAYckGW/AgpMNmLpaQgoa1J2uf0idmOI9nnPxTckf1Ng6m4TXhBVWdecfpKFzQT94BPl+b+yMMPo6+4deh8hDEM4uSt4PQltEcxEAdsd3Yl6SLLsd9RDIt8YIYRdbCYxrfEZh85ZNIzfMAdV0ta1HL8wFJc7UxsdoDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=eIfMHGsP; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
Received: from [192.168.68.112] (ppp118-210-177-226.adl-adc-lon-bras34.tpg.internode.on.net [118.210.177.226])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id DC391200DB;
	Wed, 27 Mar 2024 07:02:56 +0800 (AWST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1711494183;
	bh=tz3fNHh1K/JnaN3rWzXOsduTzNNjTpy00qDhmUkVo8k=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=eIfMHGsPNwHmXwNNstH9IMj4w2lyPGURp6LMbwLrjHmlPyWfu99sWNZIhMk2gO6uz
	 RgeTjJOiQM0pv47zQxIswraW0rFx3ZPiwJSHKORRHDpqe3US9RXTYofm+LfhboiiTX
	 0/2nDinsXDMjMsSQxs2l6/VHxtwFkD9IKm5EvxniqkwLV0JMXkRE5RjbJG83+NbtCN
	 qcam/A+94EU+rkbVi8UIoPMWSMl+z844LZNWJnywiVy85Sxc2rC3fDh+0d1MeyeTmc
	 pAYFOzZm0LtzVIwBEgEJ5JYODCCsjCp/BnFptrq5B4iieSj8Tq3llCMFTW9l5/tOpw
	 Z5xqzSAoUof7Q==
Message-ID: <e0453eb8a2da206cf591c6a7c4d431c771cf5794.camel@codeconstruct.com.au>
Subject: Re: [PATCH 01/12] kbuild: make -Woverride-init warnings more
 consistent
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Arnd Bergmann <arnd@kernel.org>, linux-kbuild@vger.kernel.org, Masahiro
 Yamada <masahiroy@kernel.org>, Harry Wentland <harry.wentland@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, Christian
 =?ISO-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>, Jani Nikula
 <jani.nikula@linux.intel.com>, Lucas De Marchi <lucas.demarchi@intel.com>,
 Oded Gabbay <ogabbay@kernel.org>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Linus Walleij <linus.walleij@linaro.org>,
 Joel Stanley <joel@jms.id.au>, Alexei Starovoitov <ast@kernel.org>, Daniel
 Borkmann <daniel@iogearbox.net>, Andrew Morton <akpm@linux-foundation.org>,
 Nathan Chancellor <nathan@kernel.org>
Cc: Nicolas Schier <nicolas@fjasle.eu>, Arnd Bergmann <arnd@arndb.de>, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, linux-mm@kvack.org, llvm@lists.linux.dev
Date: Wed, 27 Mar 2024 09:32:36 +1030
In-Reply-To: <20240326144741.3094687-2-arnd@kernel.org>
References: <20240326144741.3094687-1-arnd@kernel.org>
	 <20240326144741.3094687-2-arnd@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-03-26 at 15:47 +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
>=20
> The -Woverride-init warn about code that may be intentional or not,
> but the inintentional ones tend to be real bugs, so there is a bit of
> disagreement on whether this warning option should be enabled by default
> and we have multiple settings in scripts/Makefile.extrawarn as well as
> individual subsystems.
>=20
> Older versions of clang only supported -Wno-initializer-overrides with
> the same meaning as gcc's -Woverride-init, though all supported versions
> now work with both. Because of this difference, an earlier cleanup of
> mine accidentally turned the clang warning off for W=3D1 builds and only
> left it on for W=3D2, while it's still enabled for gcc with W=3D1.
>=20
> There is also one driver that only turns the warning off for newer
> versions of gcc but not other compilers, and some but not all the
> Makefiles still use a cc-disable-warning conditional that is no
> longer needed with supported compilers here.
>=20
> Address all of the above by removing the special cases for clang
> and always turning the warning off unconditionally where it got
> in the way, using the syntax that is supported by both compilers.
>=20
> Fixes: 2cd3271b7a31 ("kbuild: avoid duplicate warning options")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/gpu/drm/amd/display/dc/dce110/Makefile |  2 +-
>  drivers/gpu/drm/amd/display/dc/dce112/Makefile |  2 +-
>  drivers/gpu/drm/amd/display/dc/dce120/Makefile |  2 +-
>  drivers/gpu/drm/amd/display/dc/dce60/Makefile  |  2 +-
>  drivers/gpu/drm/amd/display/dc/dce80/Makefile  |  2 +-
>  drivers/gpu/drm/i915/Makefile                  |  6 +++---
>  drivers/gpu/drm/xe/Makefile                    |  4 ++--
>  drivers/net/ethernet/renesas/sh_eth.c          |  2 +-
>  drivers/pinctrl/aspeed/Makefile                |  2 +-

For the Aspeed change:

Acked-by: Andrew Jeffery <andrew@codeconstruct.com.au>

Thanks!


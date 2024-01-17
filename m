Return-Path: <linux-kernel+bounces-29161-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BFCD8309DB
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 16:37:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5855B1C21A80
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 15:37:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AF3F21A0E;
	Wed, 17 Jan 2024 15:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="axyrveud"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 894CD1E4AD;
	Wed, 17 Jan 2024 15:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705505831; cv=none; b=Y20lxr2h+UMh8qnaUga/NJL/DXldH2M/ODb6IQbjbX6vhMk+ZSZIGzto0LuHyo0xRZbh4moo3/YN9QfxcHISPPhHUFlKZrFLXOhRmQhZwGdkfCQnZtWMYmNABodpLbFUH2BXuX6Mb74U2QOIEVab+rS2iN1H/3OU12+qkXdf3Zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705505831; c=relaxed/simple;
	bh=gvbgR1lPS4RRalskIGSwmmOuBLyvCrQvi5HwxvEJbmk=;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To; b=lIYVsjUOCjpaZGdB6UcsjEh6ONJvBr4XlMn7/lfF2UYr/kA5jdn1y9rdzvq4hDN0mGi4+iVp7qQu2lUhcHJIDGzHD3OoGFFTjqnS2+8lVxTFGfSKrEYrjkCbZSUStuhlgQPw0AW9WpdRiyomNY2/sG8bO95OJ9Yi8jryrq8LSu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=axyrveud; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A865C433F1;
	Wed, 17 Jan 2024 15:37:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705505830;
	bh=gvbgR1lPS4RRalskIGSwmmOuBLyvCrQvi5HwxvEJbmk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=axyrveudFjsNGFULZQ5BS2xEBkCCBwOEPKf+K6g3I/4oqWzn40woNA7iKoDhXkgNr
	 B7x1z3LLIvaREzIbvC5LPn/wk8dMCzj0ZFDKT9o5cAmrbVssazfViJqVZjpLI7ZiW8
	 5DpBZXq6EVb22P/SVDT2iefUdY51YO4YMIzj6RplDZ3cnB/wSg/UzGglfgNWMRHQsk
	 pp5HKp73YutVD2J5ZDdmR9RkCOD+Pstab6uUv2cb7u74vl04kZnoozGKBmqVlyck9r
	 pIa8gxd8UfXfgY2LU6U/sLWt8XNnS98T+JMS0e5uDZIpRA4u4mLvHHK0xktw/r8mXx
	 TMiJgqNPMe7fQ==
Date: Wed, 17 Jan 2024 09:37:08 -0600
From: Rob Herring <robh@kernel.org>
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: linux-kbuild@vger.kernel.org, devicetree@vger.kernel.org,
	Simon Glass <sjg@chromium.org>, Jonathan Corbet <corbet@lwn.net>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Nicolas Schier <nicolas@fjasle.eu>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] kbuild: allow 'make dtbs_install' to install
 primitive DTBs
Message-ID: <20240117153708.GB2296118-robh@kernel.org>
References: <20240109120738.346061-1-masahiroy@kernel.org>
 <20240109120738.346061-5-masahiroy@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240109120738.346061-5-masahiroy@kernel.org>

On Tue, Jan 09, 2024 at 09:07:37PM +0900, Masahiro Yamada wrote:
> Commit 15d16d6dadf6 ("kbuild: Add generic rule to apply fdtoverlay")
> introduced the -dtbs syntax to apply overlays during the build process.
> 
> However, scripts/Makefile.dtbinst is not aware of the -dtbs syntax,
> so 'make dtbs_install' installs the files directly added to dtb-y.
> (Presumably, it was intentional.)

Yes. The intent was the Makefile should define what's installed or not. 
There's 2 reasons to apply overlays in the build. The first is so a DTB 
can be refactored into a base plus overlay(s) and we keep the original 
full DTB. The second is to test that overlays actually apply because 
testing that at boot time in bootloader is a poor experience and we 
don't want overlays which don't apply to upstream DTs.

Whatever targets you want installed put in dtb-y. Whatever targets are 
just for testing, put in dtb-. The latter are then enabled with 
CONFIG_OF_ALL_DTBS.

> For example, consider this case:
> 
>     foo1-dtbs := foo_base.dtb foo_overlay1.dtbo
>     foo2-dtbs := foo_base.dtb foo_overlay2.dtbo
>     dtb-y := foo1.dtb foo2.dtb
> 
> 'make dtbs_install' only installs foo1.dtb and foo2.dtb. It is suitable
> when the boot image supports a single hardware configuration, or when
> the boot loader in use does not support applying overlays.
> 
> However, when creating a boot image with multiple board supports, it
> wastes storage space, as foo1.dtb and foo2.dtb have foo_base.dtb in
> common.
> 
> From a space perspective, a more optimal solution is to install
> foo_base.dtb, foo_overlay1.dtbo, and foo_overlay2.dtbo, then assemble
> the final dtb (either foo1.dtb or foo2.dtb) on the boot loader.
> 
> This commit adds a new flag, INSTALL_DTBS_PRIMITIVE.
> 
> With INSTALL_DTBS_PRIMITIVE=1, 'make dtbs_install' will install primitive
> files (such as foo_base.dtb, foo_overlay1.dtbo, and foo_overlay2.dtbo in
> this case).

And not install foo1.dtb and foo2.dtb, right? What if one wants to 
install everything? Seems like this needs to be a 3-way option.

I'm not really convinced we need this in the first place though.

> 
> Without INSTALL_DTBS_PRIMITIVE, the current behavior is maintained
> (foo1.dtb and foo2.dtb will be installed in this case).


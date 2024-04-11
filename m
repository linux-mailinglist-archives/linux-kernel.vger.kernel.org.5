Return-Path: <linux-kernel+bounces-140331-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CC7F98A12E0
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 13:22:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D1711F22CE6
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 11:22:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A0B3149C59;
	Thu, 11 Apr 2024 11:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EOG9CM45"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 995D613BC33;
	Thu, 11 Apr 2024 11:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712834547; cv=none; b=gYXBUT92NTzgpilN+fTjrA9qGQM08xyKXxeOYlnoKCzJbObf3CPyA9ajTJdafhwqjcTy1/eG9tRS2+OQ/Bfqx0m6B6oCEUdWH9k9j7h/LcTbzQJ/IIs0ejSItYx/jAaj/n8MzqlLjUee4/pxAIc21RhkauPk6vF5VTax9CYQ8Fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712834547; c=relaxed/simple;
	bh=AboIvwKEkvx2wl+siJ2bnUL5g+OOjP+I7jd8D6N6LZk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WfWByavvYUSamEptzfR1LrIEOOdMNkm3qakS7EYNQzvukT8CN+GFlJuPULoiwNooutuOvfKL0TxBWui2NV3gxezE0W+tPLsa2xa8KbaLePIoq/IniZSigxPxGj39xKyBcjHDf3T85GSy/27UpF+/A8tZk7wLA+PxKg5T4PU9iEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EOG9CM45; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5807BC433C7;
	Thu, 11 Apr 2024 11:22:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712834547;
	bh=AboIvwKEkvx2wl+siJ2bnUL5g+OOjP+I7jd8D6N6LZk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EOG9CM45kn9Q91tY3xRKqPCxlgj/yVlitdovvmOVUhRtYAkAafiVagsDb5/Cx6aNO
	 zDbeqdP9fS/dWGA230oszhssMMghOQ75t6bK0MbLxreVYGwmcDXv2ORVxcBo//kqMl
	 R/94ldLCIVgVh+o2yO5ACS+QmmUwHHAfoWBQ4Ow2UQgeh84rdHu+m/h4sGatqNkQ8y
	 MLG9LFNfaO/QNHN1TJaIxAKMV75xunq4mV8tLWdnYl1bufsKCOJz4Dr+GVxaah+GJu
	 c0trW4/vpsPTfKhPpnp+rD40mzViXjS57hQWL9IWVFjH3MCvIeYl2+G/OeCN/tMSlF
	 h552hEPGImvxA==
Date: Thu, 11 Apr 2024 12:22:21 +0100
From: Lee Jones <lee@kernel.org>
To: Andre Przywara <andre.przywara@arm.com>
Cc: Chen-Yu Tsai <wens@csie.org>, Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Ryan Walklin <ryan@testtoast.com>,
	Chris Morgan <macroalpha82@gmail.com>
Subject: Re: [PATCH 0/4] regulator: Fix AXP717 PMIC support
Message-ID: <20240411112221.GG1980182@google.com>
References: <20240329235033.25309-1-andre.przywara@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240329235033.25309-1-andre.przywara@arm.com>

On Fri, 29 Mar 2024, Andre Przywara wrote:

> Here are some fixes to the AXP717 PMIC support series. Lee put that in
> an immutable branch already, so these here go on top.
> Patch 1 contains fixes to the regulator descriptions: the LDOs had the
> wrong supply source, and two numbers were wrong. The datasheet describes
> the voltage ranges and register values differently from what our macros
> expect, in a way that literally begs for off-by-ones, so here you go.
> I don't know if that's still feasible, but it would be a good candidate
> to squash into the patch that it fixes.
> 
> The other three patches add the "boost" regulator, which is meant to
> provide the 5V USB VBUS power when operating from the battery. It's the
> usual trinity of binding/mfd/regulator patches.
> Again this could be squashed into the respective patches from the
> original series, if people agree.
> 
> Please have a look and test on a device, since I could not do this.
> 
> Based on mfd/ib-mfd-regulator-6.10, as detailed below.
> 
> Cheers,
> Andre
> 
> Andre Przywara (4):
>   regulator: axp20x: AXP717: fix LDO supply rails and off-by-ones
>   dt-bindings: mfd: x-powers,axp152: add boost regulator
>   mfd: axp20x: AXP717: Add support for boost regulator
>   regulator: axp20x: AXP717: Add boost regulator
> 
>  .../bindings/mfd/x-powers,axp152.yaml         |  2 +-
>  drivers/mfd/axp20x.c                          |  2 ++
>  drivers/regulator/axp20x-regulator.c          | 32 +++++++++++--------
>  include/linux/mfd/axp20x.h                    |  3 ++
>  4 files changed, 24 insertions(+), 15 deletions(-)

I need an Ack from Mark before I can process these.

-- 
Lee Jones [李琼斯]


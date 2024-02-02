Return-Path: <linux-kernel+bounces-50537-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 41220847A5E
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 21:17:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1E7F28E621
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 20:16:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BB6B8172E;
	Fri,  2 Feb 2024 20:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lCWRCC2A"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B83DB80606;
	Fri,  2 Feb 2024 20:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706905009; cv=none; b=i27tqPZnfQwnA/BiG3ImV9sGLQpcPTLdgV7bKlSxIUgpfmpEFbGdD9bs7FMn4kMtNEnRHDfMyuiasJJwi7K+CBDMU5vJWzD4rd9tK6hTLJ7kUK7YOV0y0gR+og57H6XIuhCTRlIJHscO/xM1ZhlveiWLRHeuQZq4WEzPNQVWVtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706905009; c=relaxed/simple;
	bh=u9yn+Xn2jWuc4HFEotKuyuzAo4KRtUgUurWyo7k1u0A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Uh9X15pz/SG61YDstahevd2Nxs9DA1bszLj1LC9ueJCjgyrqR9M5RtbeI2+tYRCrj4W2cgORDOEhWu5qdS8KNJagBJshk48QRLppLg7L38VKp/rJJsEF91/NY/1RbKFe+ojDQt1GQ7/dJ2mTnLBTaH0K23UIYyys2cojbKYbuwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lCWRCC2A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2836C433F1;
	Fri,  2 Feb 2024 20:16:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706905009;
	bh=u9yn+Xn2jWuc4HFEotKuyuzAo4KRtUgUurWyo7k1u0A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lCWRCC2Afb5/YYmBRFKSo9rzO9PfIGnr4WMvy6VFi2vXgiPB+LYnxMFFJ0LM3DAsn
	 3k/jCXH2SChtKAG/l1naSQzFldPPVMx0PaFoCu8tCPBO0NNjCwLK8r92Z9BSHPfXmr
	 5KO8iQd0hFPyYt1rZXZZnVrrjaE0uS8EeE0g9eaaFaS44LVXz2CX2p72JerW3rp96y
	 LTn1ZygkoD5Y5OXYXP8b3SyDvP2b2b40/PoDBub8IaGKkYoPSidXBDXDx4SdHZ4m0q
	 iHKI7sylOIsGnsJ+Jl7MLaDIPsYHEGWA629V6qhkVJaEWdOOhNr5pe6od9/LW/WWPZ
	 lNcszgErg44Jg==
Date: Fri, 2 Feb 2024 14:16:46 -0600
From: Rob Herring <robh@kernel.org>
To: Charles Perry <charles.perry@savoirfairelinux.com>
Cc: mdf@kernel.org, avandiver@markem-imaje.com, bcody@markem-imaje.com,
	Wu Hao <hao.wu@intel.com>, Xu Yilun <yilun.xu@intel.com>,
	Tom Rix <trix@redhat.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Michal Simek <michal.simek@amd.com>, linux-fpga@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 0/3] fpga: xilinx-selectmap: add new driver
Message-ID: <20240202201646.GA903809-robh@kernel.org>
References: <20240129225602.3832449-1-charles.perry@savoirfairelinux.com>
 <20240131230542.3993409-1-charles.perry@savoirfairelinux.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240131230542.3993409-1-charles.perry@savoirfairelinux.com>

On Wed, Jan 31, 2024 at 06:05:30PM -0500, Charles Perry wrote:
> Hello,
> 
> This patchset adds a new driver for the 7 series FPGA's SelectMAP
> interface.
> 
> The SelectMAP interface shares a common GPIO protocol with the SPI
> interface which is already in the kernel (drivers/fpga/xilinx-spi.c).
> The approach proposed in this patchset is to refactor xilinx-spi.c into
> xilinx-core.c which would handle the common GPIO protocol. This is then
> used to build two drivers, the already existing xilinx-spi.c driver and
> a newly added xilinx-selectmap.c driver.
> 
> The SelectMAP driver proposed only supports 8 bit mode. This is because
> the 16 and 32 bits mode have limitations with regards to compressed
> bitstream support as well as introducing endianness considerations.
> 
> I'm testing xilinx-selectmap.c on a custom i.MX6 board connected to an
> Artix 7 FPGA. Flashing a 913K bitstream takes 0.44 seconds.
> 
> v2: From Krzysztof Kozlowski review's:
>   * Use more conventional names for gpio DT bindings
>   * fix example in DT bindings
>   * add mc-peripheral-props.yaml to DT bindings
>   * fix various formatting mistakes
>   * Remove all occurences of the "slave" word.

Please label the series with the version number and don't send new 
versions as replies to the previous version.

Rob


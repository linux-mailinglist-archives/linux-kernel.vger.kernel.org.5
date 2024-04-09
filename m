Return-Path: <linux-kernel+bounces-136983-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C663389DAAE
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 15:42:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 037811C22FEE
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 13:42:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 653881332BA;
	Tue,  9 Apr 2024 13:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TB+Dgk6J"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A822C132810;
	Tue,  9 Apr 2024 13:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712669940; cv=none; b=O5E4P3/xms5joeDHhrJ1/G8N60mmTWqD84gVRvfyZhOdRtjIs4T/zocBJmT9RCr7xSRgMfYyMNtHn404TaqygpArEGrL3B6i2uOJoQe8SksFDUxIW6pnjNUg0hawusGCYQulyNimfjQFipTAJjranwir9AL+PvSV1wz84Ydv0GY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712669940; c=relaxed/simple;
	bh=pTH7BO4el6rKEVr/dq4/+cLXqiAhvAeRhttJp5b1JT8=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=p5Sd2FEMfwqD+tpg+Y7ys6jcYAucq/cfQajeSHUwpLIzuJ/6frmOlEkI3I4sDaghMVITvACX7tJKdXmb3qrhB1I7tXVrpFNcPxo9O3osLTdbnOaPLUgaAhwDorcu7fCJvhRe9YsyAltqVm/zP5sGxUlRiH+k3YMRvnu4JuotnJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TB+Dgk6J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58217C433C7;
	Tue,  9 Apr 2024 13:39:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712669940;
	bh=pTH7BO4el6rKEVr/dq4/+cLXqiAhvAeRhttJp5b1JT8=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=TB+Dgk6JrdxIOGEplVMcgrE8KE1fFozP5xR2R8hEJNB4vM2/WlHsEfTrKLe6GLrp8
	 8aepaDluNmT61/iczRzmiP3V3QMA8FJcURyeoi7D/ICl5MYEQSiO/ARcSK/V8AYMh6
	 nSmb/zFdx4gq3dhYBdATdBxoORqjvEAHDMHnT4oqeNFeaj9nLP3G1JVG6BfD3wsVjr
	 Up2LEga5g4BXqMGMocwhRoY02oZuJRe9TQCtleZKFhKHazjSfr5qEe79h5fbtmdgcW
	 ry8SqSwsRCapheez3cZYm6tt1g1VBZKmYis9mWPSeHarqqzphZ9OYD2N79alM8izKl
	 UqtNK1mYqWG0g==
Date: Tue, 09 Apr 2024 08:38:59 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Rob Herring <robh@kernel.org>
To: michael.opdenacker@bootlin.com
Cc: Paul Walmsley <paul.walmsley@sifive.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
 Chen Wang <unicorn_wang@outlook.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Inochi Amaoto <inochiama@outlook.com>
In-Reply-To: <20240409064504.4010353-1-michael.opdenacker@bootlin.com>
References: <20240409064504.4010353-1-michael.opdenacker@bootlin.com>
Message-Id: <171266958507.1032617.9460749136730849811.robh@kernel.org>
Subject: Re: [PATCH] riscv: dts: sophgo: add initial Milk-V Duo S board
 device tree


On Tue, 09 Apr 2024 08:45:04 +0200, michael.opdenacker@bootlin.com wrote:
> From: Michael Opdenacker <michael.opdenacker@bootlin.com>
> 
> This adds initial support for the Milk-V Duo S board
> (https://milkv.io/duo-s), enabling the serial port and
> read-only SD card support, allowing to boot Linux to the
> command line.
> 
> Signed-off-by: Michael Opdenacker <michael.opdenacker@bootlin.com>
> 
> ---
> 
> Tested with linux-next as of Apr 9, 2024,
> using the risc-v "defconfig" configuration.
> ---
>  arch/riscv/boot/dts/sophgo/Makefile           |  1 +
>  .../boot/dts/sophgo/sg2000-milkv-duos.dts     | 38 +++++++++++++++++++
>  2 files changed, 39 insertions(+)
>  create mode 100644 arch/riscv/boot/dts/sophgo/sg2000-milkv-duos.dts
> 


My bot found new DTB warnings on the .dts files added or changed in this
series.

Some warnings may be from an existing SoC .dtsi. Or perhaps the warnings
are fixed by another series. Ultimately, it is up to the platform
maintainer whether these warnings are acceptable or not. No need to reply
unless the platform maintainer has comments.

If you already ran DT checks and didn't see these error(s), then
make sure dt-schema is up to date:

  pip3 install dtschema --upgrade


New warnings running 'make CHECK_DTBS=y sophgo/sg2000-milkv-duos.dtb' for 20240409064504.4010353-1-michael.opdenacker@bootlin.com:

arch/riscv/boot/dts/sophgo/sg2000-milkv-duos.dtb: /: failed to match any schema with compatible: ['milkv,duos', 'sophgo,sg2000']
arch/riscv/boot/dts/sophgo/sg2000-milkv-duos.dtb: /: failed to match any schema with compatible: ['milkv,duos', 'sophgo,sg2000']







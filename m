Return-Path: <linux-kernel+bounces-66269-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 823DE855988
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 04:37:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B55B71C21301
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 03:37:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2269D6FB8;
	Thu, 15 Feb 2024 03:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fG4wDTPv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 591AF6107;
	Thu, 15 Feb 2024 03:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707968267; cv=none; b=MQdnvkTkmBHXMHNA7cI7L1KrXZGKOhSR+gS3S9FdcK9xc6vHPEu/UdRhFZhoYAyWuQfFbIqUTuqANObjoJqJPMPt+5eDILRuX5C5Z4bZy8oyWVVJB4W6nmwJ6nyMktp2ml8oNkL8i1VKw7V51Ns6MHk8zB7X3wIk5bMye2n7BPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707968267; c=relaxed/simple;
	bh=RJHn7Ly5U/f25LfzqZOi+nH7XZAa0NPMODFDLRz/l1M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WHB/CDQcO+UrMI/hxulcLIrhtr1XkmTGXii15BLH7IGLHhrtwqvpm0HuQFL2KlflkbKo1dUVo6gZGNpHIMuPjX9A2D60pssLCThPCGV3AWdnAjRZuNSja8aMkzqEGHtjgEfAfRm8s/FdV3QbZd4Qpj74E+ExdSr9rFcCyeJuTyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fG4wDTPv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43CDAC433F1;
	Thu, 15 Feb 2024 03:37:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707968266;
	bh=RJHn7Ly5U/f25LfzqZOi+nH7XZAa0NPMODFDLRz/l1M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fG4wDTPvk7DStsx7NpwPwtcVITPiEguqg3TwWhn+bT2+PhFLTqj1B44Xt0aoYB/7K
	 LNhjTPCPYvWcMKdtTwLm+TVebEbxnB83oy19Ih0usZKVAPq5NNBG+M5uN8EeAI/kZM
	 xsT1X60FbMoBraI44RolYCuOR+O5loEkPH3IBgwQ8LXNVUstmRG6pcIV9anHx6OQWJ
	 EYWKBGP/CuTwnvD1TCk+a/nssOeD1uGzjdUMOPh2OeVW/PBxGQvntSD7jnmBc/UxbJ
	 U7pI0D3kuysXtu70nAMDBQQK5dTjRyCJWPDohbvjWBMcJTtDULp9HWbFTqghpPKxlb
	 oGjhRDerpW0iw==
Date: Thu, 15 Feb 2024 11:37:42 +0800
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: =?iso-8859-1?Q?N=EDcolas_F=2E_R=2E_A=2E?= Prado <nfraprado@collabora.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Brian Norris <briannorris@chromium.org>,
	Julius Werner <jwerner@chromium.org>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nicolas@fjasle.eu>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	kernel@collabora.com, chrome-platform@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4 0/4] Allow coreboot modules to autoload and enable
 cbmem in the arm64 defconfig
Message-ID: <Zc2HBmDPJnHt0WJC@google.com>
References: <20240212-coreboot-mod-defconfig-v4-0-d14172676f6d@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240212-coreboot-mod-defconfig-v4-0-d14172676f6d@collabora.com>

On Mon, Feb 12, 2024 at 09:50:04AM -0500, Nícolas F. R. A. Prado wrote:
> This series adds the missing pieces to the coreboot bus and the module
> alias generation to allow coreboot modules to be automatically loaded
> when matching devices are detected.
> 
> The configs for cbmem coreboot entries are then enabled in the arm64
> defconfig, as modules, to allow reading logs from coreboot on arm64
> Chromebooks, which is useful for debugging the boot process.
> 
> [...]
> 
> ---
> Nícolas F. R. A. Prado (4):
>       firmware: coreboot: Generate modalias uevent for devices
>       firmware: coreboot: Generate aliases for coreboot modules
>       firmware: coreboot: Replace tag with id table in driver struct
>       arm64: defconfig: Enable support for cbmem entries in the coreboot table
> 
>  arch/arm64/configs/defconfig                   |  3 +++

Hi Catalin and Will,

Is it OK to you if I pick the 4th patch (which touches the above files) to
chrome-platform-firmware tree for the next merge window?

>  include/linux/mod_devicetable.h                | 10 ++++++++++
>  scripts/mod/devicetable-offsets.c              |  3 +++
>  scripts/mod/file2alias.c                       | 10 ++++++++++

Hi Masahiro,

Is it OK to you if I pick the 2nd patch (which touches the above files) to
chrome-platform-firmware tree for the next merge window?


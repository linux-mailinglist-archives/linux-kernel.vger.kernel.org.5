Return-Path: <linux-kernel+bounces-30707-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CD3DB83235E
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 03:39:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF8941C2302F
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 02:39:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B18215A7;
	Fri, 19 Jan 2024 02:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VEd8/wMq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 836A81111;
	Fri, 19 Jan 2024 02:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705631967; cv=none; b=lziDE5QOftOkdLr8r798gy/5SjcTWqG5gbVgQTMdp1uAG5z+55N3I0vWh1q9H7+eQFj/B70aPzaSMUfFn5sMzxT1DxzOIGU0g7ecloZDLsCURSmu7B4CgbARoOg3cLAWDMGns1yBh36jEEc2fRR2DGf6ugRnsllJMeP4Y3/di/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705631967; c=relaxed/simple;
	bh=biEcbkPpXZUhi2HqIA/oV6hzC390AeosW5+NQJPUKxk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iXVFzIDuDQpEunxKdX9kNR48WemZMN5x7y7yqDWw56DW5vrzhWkSVJOsngPJOvwwnmhiSILi0ko6A/wLL2cA1HoVD+hCgI1iXJu3CHp6cJ1hiZkvX1CdSSjEnS9sK0Qupk2EvAtH4AnfJXt9qi24+Xmb/4al1fmLWpLTEUM3uJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VEd8/wMq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D1D9C433F1;
	Fri, 19 Jan 2024 02:39:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705631967;
	bh=biEcbkPpXZUhi2HqIA/oV6hzC390AeosW5+NQJPUKxk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VEd8/wMqCtv7LKkoS0JBoyQU/DqOevBZmAmnlKQKUzqfqOwkRg5lKpTBe51kh5Z6s
	 Fh0pA9jNM35yTL4tZC/DtVzrfneLSSbxlwvirqaX3lRVD1I+oN5MhycbwnoTGirzKd
	 V6x5KjWcSHRDRykgnmYk81ZIRsG857jfGehCe/UngCRRlhhLG4ccSHt7TJGEtTOdh/
	 G64pmSGyevtSVZYlhI8KW/sTu6quqnbvf8+aYDqt6uxphEG0iKSH+5wCzOIbWuE+KK
	 0dOQYRUpmjP/7WS4D/U4hIlSF3P06VmqOAZluTaU6X9BvCcTpxA3jNi/014PqkWZVZ
	 eoc2qJJ0BLZsA==
Date: Fri, 19 Jan 2024 10:39:22 +0800
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
	kernel@collabora.com, chrome-platform@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 0/4] Allow coreboot modules to autoload and enable
 cbmem in the arm64 defconfig
Message-ID: <Zang2gq2wjPih792@google.com>
References: <20240117-coreboot-mod-defconfig-v3-0-049565a27bba@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240117-coreboot-mod-defconfig-v3-0-049565a27bba@collabora.com>

On Wed, Jan 17, 2024 at 04:03:21PM -0300, Nícolas F. R. A. Prado wrote:
> This series adds the missing pieces to the coreboot bus and the module
> alias generation to allow coreboot modules to be automatically loaded
> when matching devices are detected.
> 
> The configs for cbmem coreboot entries are then enabled in the arm64
> defconfig, as modules, to allow reading logs from coreboot on arm64
> Chromebooks, which is useful for debugging the boot process.
> 
> Changes in v3:
> - Merged all "add to module device table" commits into a single commit
>   which also changes the coreboot_driver struct to contain an id table
>   and avoid unused variable warnings for the id tables.
> 
> Changes in v2:
> - Added commits for vpd, memconsole and framebuffer drivers to add them
>   to the module device table
> 
> ---
> Nícolas F. R. A. Prado (4):
>       firmware: coreboot: Generate modalias uevent for devices
>       firmware: coreboot: Generate aliases for coreboot modules
>       firmware: coreboot: Replace tag with id table in driver struct
>       arm64: defconfig: Enable support for cbmem entries in the coreboot table

The series overall looks good to me.

I'm happy to queue all the patches into chrome-platform-firmware for the next
merge window (i.e. for v6.9-rc1).  Let's wait a bit for the maintainers for
the other subsystems if they are OK with that.


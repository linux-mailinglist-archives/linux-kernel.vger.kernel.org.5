Return-Path: <linux-kernel+bounces-69590-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CCF4A858C0F
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 01:58:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5013F282CD2
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 00:58:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAD00C8C7;
	Sat, 17 Feb 2024 00:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d2cNRsCX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 232BBEC4;
	Sat, 17 Feb 2024 00:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708131491; cv=none; b=khjOfwl9LdMm+ZnHpyYsK+Hzo9g4xwpA4vr2H4LVkAMqwL4CeUnu/KucIFeOMLaRWOldkQ9aEDwDe8wFdhXADECh6tqxOVeUvIjyQG0+c2BJin1kxB8nN8F2URZ6OfnkNal/OgMVthGob39meqLOS6DB5T1oc/1zl+0VdEDj4pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708131491; c=relaxed/simple;
	bh=st9IJTbuIeN6geAWo0rMLtW6KVa2BYhiVgsh8RSz23U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FlCmD285WqCR1WuoFvnEZ8URd+hc060+nJqSbEwUxBXZrcYsc53gWmYMVviEbgl8aOpZjeRclRuhnXsztaAfQpir0gF4MM8274JFwWyhxLshc7FWNhuU23LTTKGNJa3SaYs/zEBizp/hUXyz7QulWQG13afFIldL7KVGMjB+PoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d2cNRsCX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49501C433C7;
	Sat, 17 Feb 2024 00:58:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708131490;
	bh=st9IJTbuIeN6geAWo0rMLtW6KVa2BYhiVgsh8RSz23U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=d2cNRsCXD9uvuApuY0do1aoftfYTU2jRvbREhHqXc6xzvOVGT/ADD7YXMeXQWbtXd
	 YeEBcyBF2HPYgMLPt3zzrzUwEXlc1BP7nW7db08E1MJRdn5QwCeiSiAF7EI6gMm6fU
	 PhLVBUBrgUzYmcv4BH3UEQGeYAIQPS87CyMKBnrOVF1Y5Gxce4UhQh7UcSsTVOj5Td
	 WLtzduAMd6mcQ9rfmTLGgXb34cWHhA26PkOu1If2n3x0toqz6twOA3AysSbn3zR3DT
	 CW983RkEqg9lKR/MdFECIhE6xtH3jy2gb4OmgAjyfSA4mX1rrtSTl2WvyWR7RdRE55
	 OT9w61bJck4XA==
Date: Sat, 17 Feb 2024 08:58:06 +0800
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
Message-ID: <ZdAEno9gIwjmI0lN@google.com>
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

Applied, thanks!

[1/4] firmware: coreboot: Generate modalias uevent for devices
      commit: c2b28f6806d2a26a8d46c0f02d4852bf9904929d
[2/4] firmware: coreboot: Generate aliases for coreboot modules
      commit: f1cebae1dbf85f9de65c13a2d9f5cc3be7e51dc4
[3/4] firmware: coreboot: Replace tag with id table in driver struct
      commit: 8a0a62941a042612f7487f6c4ff291f9054ff214


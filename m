Return-Path: <linux-kernel+bounces-135791-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AD7A889CB52
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 19:57:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F1F51F23400
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 17:57:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56EA91442F8;
	Mon,  8 Apr 2024 17:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kvbLmrdO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A8DF1E489;
	Mon,  8 Apr 2024 17:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712599064; cv=none; b=CcW2EOSVPa9Xw8KYIyeRVMNq7Bli5tt5sXITVzx329Jb/KRKwvZuaHHB8ejU3IJUYccEjwXaztwkr4iMyJza9GKY2IgKlzbCT22BvJUwF2hRMrOCoXp9Bj7e1WQw/ywsWWdXe3GuIpCoaLTqw+6V8oqEWkgsJS+VtW18yegS7lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712599064; c=relaxed/simple;
	bh=38xl/39xHyX9p6uux9sbNynsxqvNDIzxrbqqGV2Ia7A=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ikV9XBCqbW4QGB1QIY6Zg9NPNw80F6GPzyYz/6asXg4u/0tO4yE3RXE8GQ+DAG0KvY8kXiUYUdTwqiEx1UcU5CthTCBLBnksCkwLWaammQYlFfzxc5Xlparzb7bsDb4Us2KlrjrkXFD/P9GL5t3Gdwh0ktYVjjDkLvyg0Y6D57Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kvbLmrdO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1128BC433F1;
	Mon,  8 Apr 2024 17:57:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712599064;
	bh=38xl/39xHyX9p6uux9sbNynsxqvNDIzxrbqqGV2Ia7A=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=kvbLmrdOdq759DeSzwgWiRlTkPEBE3SIzbWhMl/z6apsp8s3PT2iihcbqDfyM1iJd
	 oNXSiPSmi+to4x/YMcTVwf29lgEGpQQaiuDvePQtYTvmn+cFPzpQALu+aG4Dau97mX
	 iWTGt1+xlP57k3ojlinjdgD5sHjpudV+RdVNgaSvzTuRoK2MU04ZzYJus8oxzENMjd
	 Jy73Fh7acaurjtqJh6up+A44I63smoGe23UGXu0RT627biSIMzcz/mdL9lodcUkxJT
	 sBVLMOMC7Hk01inV77cHw3burUcAoHxYr0t9xtUgfx/xBXLrzRPq9TNJmLxiqRf4He
	 1N+WveIha/vRA==
From: Mark Brown <broonie@kernel.org>
To: Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Vaishnav Achath <vaishnav.a@ti.com>, 
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
 Rob Herring <robh@kernel.org>, 
 =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Cc: linux-spi@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org, 
 Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>, 
 Gregory CLEMENT <gregory.clement@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Tawfik Bayouk <tawfik.bayouk@mobileye.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20240405-cdns-qspi-mbly-v2-0-956679866d6d@bootlin.com>
References: <20240405-cdns-qspi-mbly-v2-0-956679866d6d@bootlin.com>
Subject: Re: (subset) [PATCH v2 00/11] spi: cadence-qspi: add Mobileye
 EyeQ5 support
Message-Id: <171259906078.120310.15397790336440498713.b4-ty@kernel.org>
Date: Mon, 08 Apr 2024 18:57:40 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.14-dev

On Fri, 05 Apr 2024 17:02:10 +0200, Théo Lebrun wrote:
> V2 of this series adding octal SPI-NOR support to Mobileye EyeQ5
> platform. It has been tested on EyeQ5 hardware successfully.
> V1 cover letter [5] contains a brief summary of what gets added.
> 
> There is no dependency except if you want zero errors in devicetree:
> system-controller series [3] for <&clocks> phandle.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[03/11] spi: cadence-qspi: allow building for MIPS
        commit: 708eafeba9eec51c5bde8efef2a7c22d7113b771
[04/11] spi: cadence-qspi: store device data pointer in private struct
        commit: dcc594aef1bf3a6a49b77ad2c0348d894b7cd956
[06/11] spi: cadence-qspi: minimise register accesses on each op if !DTR
        commit: 563f8598cbc246a81d256e0e888dc085504caa90
[07/11] spi: cadence-qspi: add no-IRQ mode to indirect reads
        (no commit info)

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark



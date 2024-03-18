Return-Path: <linux-kernel+bounces-106447-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DA3CE87EEC6
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 18:27:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E8A428208B
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 17:27:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2157255789;
	Mon, 18 Mar 2024 17:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PVCsEdPU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 612A146549;
	Mon, 18 Mar 2024 17:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710782869; cv=none; b=cLjlmuq4grOn+bwnAACVgWPQ/Y8SFACebJFEo4XM7w74DJc+TNCt/Y4MOC/XF1jzL1E3vj3C8Q7n8u/fRacu9HKTsXukSnB1d2cVyX+g/yE7o9mj0pOCBfcEPYKTJJi9jVWbnpw/wXuwJy/lgf7l1821RN8z/rU9VXENAR2LjN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710782869; c=relaxed/simple;
	bh=cp00rm8kBV3GrMvifU8ZwZskEZ3mcADfirWEWCIPek8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=g4qVizQ9Wl2ALBBzsa1kKiEKR51eptoZ8w/jgFpz2knc2CrawIopsEGDFo5ux1ptGI9+FKwyxuNiUCy//xPcWFBxHiLU7KcLKHObBqFDXbT9cCq6xKsaq7zoEsEriPx+Ob4K+MmGZWr8sjFtTcb7AdPCkP5ZlttHmI72p1lq0qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PVCsEdPU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62717C43394;
	Mon, 18 Mar 2024 17:27:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710782868;
	bh=cp00rm8kBV3GrMvifU8ZwZskEZ3mcADfirWEWCIPek8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=PVCsEdPUGxPEfgC6LyLWF4C2+WLSvC4sntI9xipractRmaVCj1TgUfVwrEC5NNeWu
	 l5Gn4KtzrdSv2poR13/K8hgNHbhC7eo514JStJLFnwR1DUypKsxNfL7hcOGQ2tnMDm
	 tTG07ilkwZGAUOqaMKqg5UoIrT1IiUbGGsBvq99WNym/d+kWp7yOIJ4djbZGgglI5V
	 giWcllxgVQHmS8X1wsD3QAMMUf8FLZST1ZbJF6eBujRGjSKMuaFplLLFQs5hKozgiM
	 OZtes0MCH89ajFGSgeG1OfsYzqjye78GzCspENYXMFLCj5CX//eiQR+YnqN5KlKK7N
	 8GQauJpV89BzQ==
From: Mark Brown <broonie@kernel.org>
To: linux-kernel@vger.kernel.org, 
 Kousik Sanagavarapu <five231003@gmail.com>
Cc: linux-spi@vger.kernel.org, linux-hwmon@vger.kernel.org, 
 Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
In-Reply-To: <20240318154540.90613-1-five231003@gmail.com>
References: <20240318130840.74589-1-five231003@gmail.com>
 <20240318154540.90613-1-five231003@gmail.com>
Subject: Re: (subset) [PATCH v2 0/2] lm70 and lm70llp doc link fixes
Message-Id: <171078286713.91354.1940130554038787719.b4-ty@kernel.org>
Date: Mon, 18 Mar 2024 17:27:47 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-a684c

On Mon, 18 Mar 2024 21:08:33 +0530, Kousik Sanagavarapu wrote:
> Fix links from the documentation and in-code comments pointing to
> datasheets.
> 
> Changes since v1:
> - I forgot to fix the links in in-code comments in spi, so do that.
> - New commit to address the same issues in hwmon/lm70 since the spi eval board
>   is based on that.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/2] spi: lm70llp: fix links in doc and comments
      commit: 7397175cb7b48f7a3fc699083aa46f1234904c7e

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



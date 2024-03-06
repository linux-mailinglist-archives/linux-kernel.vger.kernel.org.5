Return-Path: <linux-kernel+bounces-94621-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F068F874248
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 23:00:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 907A31F23516
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 22:00:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D616A1B94D;
	Wed,  6 Mar 2024 21:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tnZBhiPk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 237E11AAA5;
	Wed,  6 Mar 2024 21:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709762392; cv=none; b=Z4MmktoxlBpl1Ud2TA5OOM8sLPXEoSKVaVhhwJw7fceTTB5IFM3/CbrQHe0ruJxAtwriJMuGQZ+m2tEKvmX+L6EQkDB0tiK9g3kDRHCXNXFMMETkPalds8CywMwVjxIu2VTqwWtzf5bz+xVNRC+QF4JiVNf28446Qp8J+h/z3tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709762392; c=relaxed/simple;
	bh=xp3DpbG9dKut5r/Z3ynsNgokARzxQfk1Ahmf/wL7bLo=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=AuSXTqvv0Lahw7uXjN1+OxVrRJ5uDPw5RFxBNMPsY54mpReZGPPLlUdY82jcUfO3z229fvxcaramcdtb4Cj/DYECJ5D2ZmU5fz/mwnMy/gF9z2ZFJBrLqb2aO30QzqQDldkSFxuNUKgHKsv0lIF1FXwzGIy2gGqW0bAr1cK4GmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tnZBhiPk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFB86C433F1;
	Wed,  6 Mar 2024 21:59:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709762391;
	bh=xp3DpbG9dKut5r/Z3ynsNgokARzxQfk1Ahmf/wL7bLo=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=tnZBhiPkgDDZNgIxmjOjG4N/lC53h+4AoQgGdK/IqvyE2svLgYtOw8WQBP7NJ5GCW
	 hsJaSj6pLrJiiJs29QTHmrAhfWUj3nFZ5aETPSoAGKYXCh9jkGwWul9XLpL88Rd5sr
	 yZ3U4gWn7gnVzVmoCNC3xBRkfR/nnffNj8ibIXtD1heMAH0dRBFUOY9eDqOaCHP3OT
	 iPyN3zUtXSdwY/+gGGWjx4hrxghIJmdQQNIxBXFccML/B82faC70tyvn+Pa7zRE852
	 t/aqj4uu1cCrX99gNNtw1yxqBMQGIAVRHEXMIKvKiZ8nQtSgkKIzVHtFUcK77hdjNw
	 ZjxhDA34z6fUQ==
From: Mark Brown <broonie@kernel.org>
To: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
In-Reply-To: <20240306160114.3471398-1-andriy.shevchenko@linux.intel.com>
References: <20240306160114.3471398-1-andriy.shevchenko@linux.intel.com>
Subject: Re: (subset) [PATCH v1 0/3] spi: CS code, variables and comments
 clarification
Message-Id: <170976239071.258774.10326274744681538196.b4-ty@kernel.org>
Date: Wed, 06 Mar 2024 21:59:50 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-a684c

On Wed, 06 Mar 2024 17:59:39 +0200, Andy Shevchenko wrote:
> There are a few duplicated code pieces, inconsitent types and comments
> regarding to Chip Select pins. Refactor and clarify that.
> 
> Andy Shevchenko (3):
>   spi: Exctract spi_set_all_cs_unused() helper
>   spi: Exctract spi_dev_check_cs() helper
>   spi: Fix multiple issues with Chip Select variables and comments
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/3] spi: Exctract spi_set_all_cs_unused() helper
      commit: 5ee91605ad9ad363766a7ed13dc7d47f5102982a
[2/3] spi: Exctract spi_dev_check_cs() helper
      commit: 9086d0f23b7c292f162a828967975e29e97c0680

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



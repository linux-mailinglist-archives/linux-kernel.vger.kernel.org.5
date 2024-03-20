Return-Path: <linux-kernel+bounces-109027-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F5F4881399
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 15:43:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E1695B22B2D
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 14:43:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4453D4AEC0;
	Wed, 20 Mar 2024 14:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GUJ664pX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83E444E1D5;
	Wed, 20 Mar 2024 14:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710945777; cv=none; b=hhXk1ZEk6RXbSakF1b0Uf8gRmQ68ShYYtoiXCkuTxnkx5zXcwD+rHByfmhzZlQU13eVNWSwbt7WurUPjUOC8mHypre6XpudXWUhPItnubmHE4eSh1LNTraP53/4Nirsa3GfvdfaffJkOIIPY3V+avo6yvBjrw66kujdl9I/hZyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710945777; c=relaxed/simple;
	bh=www9+uCQGEWiQdScfALOEuJdVLyTt8z24vD7RlM8ylY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=mC8DPp4o/zImJB6mYDXKoKd082LZptNfr03RrHydXBFDfzlOFR5GFrn2jnYcuo6StxdoD5XkD7jxz69mFFGUmWV+ek6C3n5Qm2Bpdyzd6OwuOfbXNoaPkuy6iS6pg4XUEviIAcZyGVrySiOHz388iy9Ktt4cm0sp6McFvw838VY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GUJ664pX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A745C433B1;
	Wed, 20 Mar 2024 14:42:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710945776;
	bh=www9+uCQGEWiQdScfALOEuJdVLyTt8z24vD7RlM8ylY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=GUJ664pXiQp0xiPuAaEtaFpCFyIokXMOFCenN7TS8T2pV/XicVNqh5eLtH8FCbVpw
	 E8GYroetoGRpZ1N/e+KVXqOPRfQDW0ORS2/BnImkDbIRuE3FdFn47Lfv4QuRPHsJtZ
	 3xvj0OXAbAVBSdTdFv7o9l02r3gmIiSOoQyc0Ldo771EHL0AHyaIkYfu1GGzqYUT3h
	 0ch+uBLJCrWvO5l1qr5c2uyIhTHLKNV1Wauk6QIjXbGA3I123A9SE9xihkCWKKpoQI
	 ymvZ2v9oYURziIxwxFkVYK5Nhmq0A5oxyx1OLdVLrRyBs3jsI5zHFC78O9P35R1cU4
	 0EPGAmffhtLVw==
From: Mark Brown <broonie@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240319183344.2106335-1-dlechner@baylibre.com>
References: <20240319183344.2106335-1-dlechner@baylibre.com>
Subject: Re: [PATCH] spi: docs: spidev: fix echo command format
Message-Id: <171094577595.45707.18175820576468275327.b4-ty@kernel.org>
Date: Wed, 20 Mar 2024 14:42:55 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-a684c

On Tue, 19 Mar 2024 13:33:42 -0500, David Lechner wrote:
> The two example echo commands for binding the spidev driver were being
> rendered as one line in the HTML output. This patch makes use of the
> restructured text :: to format the commands as a code block instead
> which preserves the line break.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: docs: spidev: fix echo command format
      commit: 2ff0573e7aff5129d73ec5c3159cd84d862cb1cc

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



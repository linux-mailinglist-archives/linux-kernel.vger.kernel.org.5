Return-Path: <linux-kernel+bounces-117625-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E2CAF88AD73
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 19:15:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 81CB31FA1F80
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 18:15:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C59224C637;
	Mon, 25 Mar 2024 17:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b5E7Cp9v"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E97F44DA19;
	Mon, 25 Mar 2024 17:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711388668; cv=none; b=gkkQao9rWXTmSc3nZCfguYLXu3eKXSOEn12z5rEC1fIXv+knIpHJBFhugcbQz5zWepzPv04BWDTLH+bGG3xGQ7ZnVxWqUyOxMTxJ129gwI2u7VHO5bG3WCv0Kgt3jj+MsORWuc2RVBpDy5+TNa3vbl1yxbAoPSHxrrb8lIpIpU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711388668; c=relaxed/simple;
	bh=7CY+Bz8yedB/peytCKYBeJnkgHswHn7/LaefhaOtwso=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=hDQeoITqPhs4x0eQZ0iJk1HOxF76qWxn/ZfiKuCpRRzXwdbzRU632TWz/fNHE0op5RsJa2tIkAvcNV8R3LZqpLyIHXSPTWs7uEqYnm2A8M665k/lD1u0r4GKiEcdf9vo/SEwUAZKd+2MACNMJ+FkC56+8851m7uz5mLgTy/lobw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b5E7Cp9v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83E1CC43394;
	Mon, 25 Mar 2024 17:44:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711388667;
	bh=7CY+Bz8yedB/peytCKYBeJnkgHswHn7/LaefhaOtwso=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=b5E7Cp9vw5ZcCZo74dXk618Ub7MK4Cu8hzLzgh5xDExGgQX489Kv1CxIFLQJLXGv1
	 m5uiOiTiimIokRR7BArZB7QTrH3PEKOC2CipiM9j/LcPN1y9GcHaLoz7n/kFJLjf5M
	 Rxhbh4tpcDZlvnOiFi1ueacxBmIFMkKiB1w18IvivgnaSh7AXKjktg8Jd6D7ZalQZG
	 EBodP1GBDJ82oPQCtUSZEPxJq5RwTT6pOk787V0q42ECiK5sNWlfWV1nu+eE1yHaC/
	 qiL0GZ41s2WWdmUDPdmaTTslwZjq/N4gZrSKILtFCLWrKGgLq1WW9qDmRHWu7qyyTd
	 fqLdYptM0EcWg==
From: Mark Brown <broonie@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J . Wysocki" <rafael@kernel.org>, 
 Colin Ian King <colin.i.king@gmail.com>
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240315084417.2427797-1-colin.i.king@gmail.com>
References: <20240315084417.2427797-1-colin.i.king@gmail.com>
Subject: Re: [PATCH][next] regmap: maple: Remove second semicolon
Message-Id: <171138866623.327223.15646139902370074252.b4-ty@kernel.org>
Date: Mon, 25 Mar 2024 17:44:26 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev

On Fri, 15 Mar 2024 08:44:17 +0000, Colin Ian King wrote:
> There is a statement with two semicolons. Remove the second one, it
> is redundant.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git for-next

Thanks!

[1/1] regmap: maple: Remove second semicolon
      commit: aad6b35290f52639d3601063d33d9621c0948a04

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



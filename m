Return-Path: <linux-kernel+bounces-54606-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A618A84B171
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 10:38:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 601432876F8
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 09:38:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AFBA12E1C2;
	Tue,  6 Feb 2024 09:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JSoSGJ8R"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7A8312D75F;
	Tue,  6 Feb 2024 09:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707212269; cv=none; b=AX7Gh9OV9GBiRHvd2L9JqMrWRSusuz9dA5r0zq2Tp3sdW2yiC+Cv4XlTstidqCAJzwLPUUNJE9G6dbzD90R0bqYDWUdbE8Z4C7kEgI9eY5uGv/Faa58iwg1CY/QX9ABRUsxfeCAtxZ2MBet0OcmqvDZpRx1uIM8aX5VogRKjYt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707212269; c=relaxed/simple;
	bh=Zux+7GM6pvRfkdpOcbEA1PKkpVrCV94PVDnGGBqnzZo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=RlYRLiGnU977gsYyU414oAmLwHfyIt8JntSPBnlS58OPD4YwNIu8s1zegIWxmtos3qWx50W0zi5aJNpJ5835cTV8GfGwFKbCz4XhtaowfdI6vV+IJxw1W+qwKdIIBdakbXbW7FXzhruSz4z22Zio27It2mCyLcwi85KNmztcH1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JSoSGJ8R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FDC1C433F1;
	Tue,  6 Feb 2024 09:37:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707212269;
	bh=Zux+7GM6pvRfkdpOcbEA1PKkpVrCV94PVDnGGBqnzZo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=JSoSGJ8RWrID5TCGXynrgnhPWiPPzQIUkMSgFFx5wo0McLSsgnYgkVVSUFQd/PIid
	 2tZ4jZYeu1DLppKNSDbAlAUATKWXm0cGh11ZA+9Uzls796zNwhsNe8gfgVlDsNWCj1
	 lAY9oeG/tGFR3gWFxoFqJUK+yqb0lAqvFyErCyhrP1JZNjEWb9nYeNKpOvvbf2a2Su
	 WizBkQahNswJ9alfaAWRkWRSovvPrxXvEHIppjnHzxTzKLqiOvmTkHSh5t8ZseXmH3
	 cA9dv3YIiNNYy4skLgQ6OcuSgX2TFvRbI92YUOCDXNE0OdSlRPtmEpwhru/wyWS9YD
	 eJzZTRmMxt0yA==
From: Mark Brown <broonie@kernel.org>
To: R SUNDAR <prosunofficial@gmail.com>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240204154506.3561-1-prosunofficial@gmail.com>
References: <20240204154506.3561-1-prosunofficial@gmail.com>
Subject: Re: [PATCH] Remove the @multi_cs_cap to prevent kernel-doc
 warnings
Message-Id: <170721226718.850647.2636169047428281316.b4-ty@kernel.org>
Date: Tue, 06 Feb 2024 09:37:47 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-0438c

On Sun, 04 Feb 2024 21:15:06 +0530, R SUNDAR wrote:
> ./include/linux/spi/spi.h:778: warning: Excess struct member 'multi_cs_cap' description in 'spi_controller'
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] Remove the @multi_cs_cap to prevent kernel-doc warnings
      commit: c5d74fe6a7f4240f6060dc51dd113b8a45f6cb56

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



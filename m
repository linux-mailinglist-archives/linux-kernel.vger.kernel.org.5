Return-Path: <linux-kernel+bounces-83127-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D2DF6868ED1
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 12:31:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D7B81C24CB9
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 11:31:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C6AD139597;
	Tue, 27 Feb 2024 11:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f6i9GP5H"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C16592A8C1
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 11:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709033492; cv=none; b=goHdRRgiZp72CpGN6mhCdSNyCo9S+uZVrbtq21lMZXFnqsJVODrWEYUmfHNygq20nURKae0XkxWYT5/vdJryz5XYmwh5kT9jyU7e0X5+uFNap0vMbaOAhFmQTVK9ce6Wq3AFw3B2Ee6y2HPOCtv4w1dWY5V3fELFPvZ01siW604=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709033492; c=relaxed/simple;
	bh=sGTB8CRdqXo2csxvM3ZA6uP3ffXhX15EUcNcGEjFAQc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=e4ke1DA2uhUjknW9aKaGYlH7tJptvFDHaWW/Epo31ZiPvYJABg7YLth+pObrSwReXv9ugEASO20Gu7jyxeZZqhXMbrgbHe16ykQO+p1LWMXFjtxCrU/ik1nCgWdkxL0CKnolht29OVNufssLNjA81JsYkBaBc/jsBakjd+LBgac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f6i9GP5H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 390F6C433C7;
	Tue, 27 Feb 2024 11:31:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709033492;
	bh=sGTB8CRdqXo2csxvM3ZA6uP3ffXhX15EUcNcGEjFAQc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=f6i9GP5HcbBCTezUVkSYb2B3+Ms8OthdRmXo8SCngsVWt2xjAsdf5e/gc1rDK8fdD
	 3exfbDFs1clsOKk+bpLyoIpEBCEDZkWXyiWvmKfClzQvRPdERzDPui5N+TLfjY45+r
	 DPP5yFs+ZMwhI8SW9vAbugKt20OwNS9uvVeb7GMqniEsG2fVvXhD8zmahIse5CCise
	 hvEb5Zsv4AMnGY57vhrDLmJnV8JVrw/+n2wuipkU6j6iAYNuuFhUha2cmXVcJiTRzd
	 EnWtV0to7uLpJVFQ5imzjTvKVCY5Yzx10X8HFEv12ire0acuYBFhdtB5OF2VZAu2Z6
	 YyDK7bMgeEiyw==
From: Mark Brown <broonie@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>, 
 Support Opensource <support.opensource@diasemi.com>, 
 Lee Jones <lee@kernel.org>, Linus Walleij <linus.walleij@linaro.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20240220-descriptors-regulators-v1-0-097f608694be@linaro.org>
References: <20240220-descriptors-regulators-v1-0-097f608694be@linaro.org>
Subject: Re: [PATCH 0/5] Convert some regulator drivers to GPIO descriptors
Message-Id: <170903349096.16921.1513708498792696039.b4-ty@kernel.org>
Date: Tue, 27 Feb 2024 11:31:30 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-a684c

On Tue, 20 Feb 2024 09:36:23 +0100, Linus Walleij wrote:
> Despite the work to convert the regulator core to GPIO
> descriptors, there are some outliers that use legacy GPIO
> numbers in various ways. Convert them all over.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/5] regulator: max8973: Finalize switch to GPIO descriptors
      commit: 4d52f575e258c6f93f4180c21afda8634b0d2af5
[2/5] regulator: da9055: Fully convert to GPIO descriptors
      commit: e450a2b3a335332d4a51fe10c9fff8150c6e2364
[3/5] regulator: lp8788-buck: Fully convert to GPIO descriptors
      commit: 95daa868f22b509ad641bf003d9d441d6a2fa505
[4/5] regulator: max8997: Convert to GPIO descriptors
      commit: 84618d5e31cfd01fc3f53a8c2ebb68bc43d8b760
[5/5] regulator: max8998: Convert to GPIO descriptors
      commit: f25828a1eae1ee1a9257e2818b237b8208bd383e

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



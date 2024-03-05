Return-Path: <linux-kernel+bounces-92974-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D05BD8728D7
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 21:42:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 623051F24CE7
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 20:42:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B34D512AAF5;
	Tue,  5 Mar 2024 20:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="daopmgxO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C996A12A17F;
	Tue,  5 Mar 2024 20:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709671318; cv=none; b=F2bh8L5keBnvIalO0KL+a+CtUOUAXlv3UD21OGBx96qOpvHy0EePNE8o5HzjqJZikzKtK4fT+wWTjSpcj8BA83g8Geu85GB9RdFbhURqEMHfLmfHf6qcSThGxFjQ27aIqEXLtmlFJnUwi8k1+eK6Y4B0a8Avw0TLwx+jiGmqhfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709671318; c=relaxed/simple;
	bh=sze64vVYedfBh6VlJbl59BjYZBFydyCqCR9/3XGZ4aQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=rU6ZxYHlfvALTOgoZYzJckQNNt2Iq+y77DHHF6FpzBCBj5dEyOrrRuhnCqRyuRvVJnS76wFK7SWkayRrdEwTu5ZOJ9LT3rZAtWUZKh9lhebgjcMdrTF0tVgWMf9izMUZxlvyx67zXKJBxvw55CXW4H51Dv+410Dz8XodPLO1yCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=daopmgxO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31243C43390;
	Tue,  5 Mar 2024 20:41:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709671318;
	bh=sze64vVYedfBh6VlJbl59BjYZBFydyCqCR9/3XGZ4aQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=daopmgxOkXu0SOaxRTeBhHxdhmk8c+Yz1YxOzGXNhCCqV4YtMHKSP5e5UjtsON6ZL
	 qNyNNAgeCSd/6RZ1W3HvCtvhOm3bD83w8NU9kpfMg1Ieq+O5z9K2GTivRhONV5kQjK
	 jfyPP53vg93JsfIltd9GeBb6h/cI5ouvLS/956ouI9OgFcVeAbT20zrkvArQN/6+R3
	 vIHJdtXkVABHE3G8UH8TsCO+ZfJnlODKCABxsL5SucwaB65Lt4MpbmqIv7GCbH9fdx
	 BSd0oVZMIM7Tt8p2Qa7X6WTfmNp00faeKOaZnaYkDDrKj7w3xiY1mh7wtjmps+G7XL
	 DpAJ0cInPItzw==
From: Mark Brown <broonie@kernel.org>
To: Richard Fitzgerald <rf@opensource.cirrus.com>
Cc: alsa-devel@alsa-project.org, linux-sound@vger.kernel.org, 
 linux-kernel@vger.kernel.org, patches@opensource.cirrus.com
In-Reply-To: <20240304143705.26362-1-rf@opensource.cirrus.com>
References: <20240304143705.26362-1-rf@opensource.cirrus.com>
Subject: Re: [PATCH v3] ASoC: cs-amp-lib: Add KUnit test for calibration
 helpers
Message-Id: <170967131688.228819.10804344071690892747.b4-ty@kernel.org>
Date: Tue, 05 Mar 2024 20:41:56 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-a684c

On Mon, 04 Mar 2024 14:37:05 +0000, Richard Fitzgerald wrote:
> Add a KUnit test for the cs-amp-lib library. This has test cases
> for cs_amp_get_efi_calibration_data() and cs_amp_write_cal_coeffs().
> 
> A KUNIT_STATIC_STUB_REDIRECT() has been added to
> cs_amp_get_efi_variable() and cs_amp_write_cal_coeff() so that the
> KUnit test can redirect these to test harness functions.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: cs-amp-lib: Add KUnit test for calibration helpers
      commit: 177862317a98adde284233aee074fc6e6a51cf95

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



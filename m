Return-Path: <linux-kernel+bounces-128570-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DA18895C90
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 21:30:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B1E221F26DB6
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 19:30:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCD6215B96F;
	Tue,  2 Apr 2024 19:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RaM2EanR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21B3615B962;
	Tue,  2 Apr 2024 19:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712086213; cv=none; b=SxD85aHkQPJWrmMS4Qq+0AKk6ERuuGrImAWHLeKrgL6hTgPrNny2zUVa0CV0gFJ2RWa9fVFSc7G4COKv5V2JjAAG8D/citcl6VgTkXvEdbWh2HoI/9E5GPjzLx6LhbmvVl0Ki6I5oQVHrednMlzxp4u9vZssmBgc6pC/IUQpbts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712086213; c=relaxed/simple;
	bh=oNRMOvs4cihgd9w+hFC2lFQF+Ek1K+cyUSrbrX4eXyQ=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=cskGEhS2q7wazvfawMnVl/HG4yX7+t5GBM8Zhnp2UsEaCPuObD/sEb08We4wfYPbPDhurhxNW7HcYqX366DZaQPO4g6iLmN+iJGn1Pf7YNPFIoOlCNW4Z0ot6T8JZBT6YUTEVYYWTvR1hMFhTu5AvNavrFYVy/1chpzi9M4MbIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RaM2EanR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D530C433F1;
	Tue,  2 Apr 2024 19:30:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712086213;
	bh=oNRMOvs4cihgd9w+hFC2lFQF+Ek1K+cyUSrbrX4eXyQ=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=RaM2EanR2OD/x+G1NLJAogiFRqSv9XOhWcEnCqkxlLU7uI68qufJEJA90bSV8BRXC
	 8CojT4pePcPVYuDImMc/7UrImzMiolQIhQ/YuFGZCQjPkp+3c7PSB1qKa+BXNOnyEY
	 H1JOHwOdZdD/+0v/FzRjdWSdHDi+Fh6TdFcezDYaAqfeC1dMsC7bAL76Id6XOaELBC
	 cnPULXsgQLIlHsroXzHSrBrKoUoNXRIvvTZsIcbLjgaWex51hhWpfA6V5xWRf1Gatx
	 dhyP5qmND9rOwAYhngRrMK44amoSAHNktK4Plvvmcg20VsRBGyLSSN6/KnrxGlxvPj
	 idrUzdOGH+gNA==
From: Mark Brown <broonie@kernel.org>
To: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20240328203927.156184-1-krzysztof.kozlowski@linaro.org>
References: <20240328203927.156184-1-krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH] spi: docs: drop driver owner initialization
Message-Id: <171208621172.89757.13064316709689083675.b4-ty@kernel.org>
Date: Tue, 02 Apr 2024 20:30:11 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev

On Thu, 28 Mar 2024 21:39:27 +0100, Krzysztof Kozlowski wrote:
> Core in spi_register_driver() already sets the .owner, so driver
> does not need to.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: docs: drop driver owner initialization
      commit: 5da57c7ca9eabccd89087ed2fdac31a79b1504d8

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



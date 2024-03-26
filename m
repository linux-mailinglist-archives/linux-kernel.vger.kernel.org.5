Return-Path: <linux-kernel+bounces-119820-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1049B88CD57
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 20:40:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C81C82E6536
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 19:40:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E931313D25A;
	Tue, 26 Mar 2024 19:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HcksCLbp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3434213D246;
	Tue, 26 Mar 2024 19:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711482022; cv=none; b=mHelVSSV19+fJWm6cNlFspT7DM6Ctlr7cqPM5aVzdImd2ttCv+a2ga6NMJZJNc7Sl0FxMNZzyHf/USqRb81Od6c3CS/xEVUBC4L/7z0VWucrr1MByJsSLPwWEqMEGm3lZopWlORJN/AAS5nclIExsPL+kEnd0xxC5t8zvXQTg20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711482022; c=relaxed/simple;
	bh=qXrfcSLytIfZgEv1B88MedI/9yDyjES8/rbAFuET0+k=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=dc9pBpZbvL+d6xoVxg1aMalXgSsgoCfsNM3t0D69QnV8s00At7neQuo+qK6aXsz0VDSzB3v7b80LMLJXTpYr9tCBgzOPYcqxUcL4iRom+EgY7m3QfbZYQjm4wWwLWe6paKGd4VW/ibuu3q73udf+s/imVINLcoYJrzJ6dDSJl0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HcksCLbp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 121FEC433F1;
	Tue, 26 Mar 2024 19:40:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711482021;
	bh=qXrfcSLytIfZgEv1B88MedI/9yDyjES8/rbAFuET0+k=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=HcksCLbpUjwsxuZgnHgqeEW4uaFBuIVX0pU34IplBUvydoPl5u91QRPXwA+XWxduq
	 V35/0j6S40sy+1j4H+9UOaZKUKhEi+qe08Y3Im6R93l6xood/+b9goMgFEf3pzQS1e
	 7tTURi0m6VL5d9kL0PzLtmMeyQgponBw2m2OcZeriNcmVzojprDghtEXmU79qc1HG8
	 Cs/6lluh7c0bZmv5XdN5uXLx8I0GyY9j8usQ3sGAypBs+rummS9CG4NOpDatEfXz8H
	 kDyOso6jINWASonn0/RhpKKC/u/tg1a6Lei1xW4iu4CEvevUAiPTQBshYxzVzRNidg
	 V++lzXjyLfUvQ==
From: Mark Brown <broonie@kernel.org>
To: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>
In-Reply-To: <20240318202602.182619-1-andriy.shevchenko@linux.intel.com>
References: <20240318202602.182619-1-andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v1 1/1] ASoC: soc-jack: Get rid of legacy GPIO support
Message-Id: <171148201977.195485.4608338587571570156.b4-ty@kernel.org>
Date: Tue, 26 Mar 2024 19:40:19 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev

On Mon, 18 Mar 2024 22:25:16 +0200, Andy Shevchenko wrote:
> No more users.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: soc-jack: Get rid of legacy GPIO support
      commit: 7b95ee0db7e0a7f99077f1b926323c7bf0d2e8f8

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



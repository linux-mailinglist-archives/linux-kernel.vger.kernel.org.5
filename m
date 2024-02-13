Return-Path: <linux-kernel+bounces-64406-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F06E853DF0
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 23:03:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE420291C2C
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 22:03:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A838633EC;
	Tue, 13 Feb 2024 21:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WeCd08mN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72A3B633E3
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 21:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707861517; cv=none; b=gVDCO5DCrwM/tMSvIq6/CiJ8n3LvdiLjEuK/5ulvho2kStq6Bn/kPnP5M7Jif8swS/Tm5Ro8j2cd3nJxP08FDsueBBV0a9xiGI03XAFxFLWhl7DyDKozySEXETixwwyt5tM4TIFWHX0TangeFIxElyRCCrlUoOv2XODKPSjN8Hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707861517; c=relaxed/simple;
	bh=SC1HYxybdeVIcqdFffZw6LKlZBwpfiY8f5gn+r01Njo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=PhVvl9kozD8NWJ6RNfIjnk8n1NdexVVO+sUn59p2E8FhQn5y4XToJTPnjqrjHGkM0O53qes0ujgNMp3KZM+I6tRa05URNceBPsUShwEjiZeXtbTnheMAaPs2K+CTWThgkStSRvkXMMcxDdl82FhV3irOlyOeORf31b6tm/PF9X0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WeCd08mN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D64D5C433B1;
	Tue, 13 Feb 2024 21:58:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707861516;
	bh=SC1HYxybdeVIcqdFffZw6LKlZBwpfiY8f5gn+r01Njo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=WeCd08mNLdZLR2NggI+eNn4j5txtco0N0h4YT+/LDiQujNkX5qkY1vDNb1ix+MeL7
	 KgvtKdtcrArHM5QKkj8p/GwENrHf0j99YO4zbSIA+vq/Sj5xhaTW1cIkdJHDy+wkHw
	 m6h1tBW3Y54xYeT9JTaMt7TmwM8qMH87D6jE1nV7q2lpUNvR6/uHi/SUIKgDOz3Zjx
	 boCiMCAAscdhAjYPdislwc4r+VzDtAqRl8XFvTFn/fxJ3o+o1bYKn4oVVK3h2xfuGZ
	 QOJ0ysBbUvTv8Y3y25wHyLNWLNMyErPC9IFpRuTMQ8VN6Gt9BdK+bKBYBLM08IjKzQ
	 TRo7xnnhv784w==
From: Mark Brown <broonie@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>, 
 Naresh Solanki <naresh.solanki@9elements.com>
Cc: mazziesaccount@gmail.com, linux-kernel@vger.kernel.org
In-Reply-To: <20240213145801.2564518-1-naresh.solanki@9elements.com>
References: <20240213145801.2564518-1-naresh.solanki@9elements.com>
Subject: Re: [PATCH] regulator (max5970): Fix regulator child node name
Message-Id: <170786151560.1066642.3051581162010229935.b4-ty@kernel.org>
Date: Tue, 13 Feb 2024 21:58:35 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-a684c

On Tue, 13 Feb 2024 20:28:00 +0530, Naresh Solanki wrote:
> Update regulator child node name to lower case i.e., sw0 & sw1 as
> descibed in max5970 dt binding.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator (max5970): Fix regulator child node name
      commit: e5d40e9afd84cec01cdbbbfe62d52f89959ab3ee

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



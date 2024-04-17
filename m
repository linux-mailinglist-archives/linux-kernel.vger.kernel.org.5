Return-Path: <linux-kernel+bounces-147788-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 554C48A79B0
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 02:12:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11066286828
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 00:12:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79097184F;
	Wed, 17 Apr 2024 00:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b6ppK5WW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBD11ECC;
	Wed, 17 Apr 2024 00:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713312727; cv=none; b=RBf8SERhqfyp+cX3beePfsPmnSQ/FJYGamnservQGDu+a7MAy4mEqgiE9FFkeWyt2kKasAbz/kC6N4kv8AQTVbYeNrGpGR6bPP+sY3UCVp5R7bIpHjgddNsGAbfA5G8pXDhcUEMYVAcjN6VFljLz4nFgbMmJEmnzVcijZ/ENbe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713312727; c=relaxed/simple;
	bh=uT0LZ0+w9TZK/EkJyb0TyHCOhtw73KC9C4PnOud+t5U=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=iTz9sPJ7v5DWwokl224xl29KYf5oby5qnVXSP7w2MU/iCRgrw74Mjl/zaEJFjedmux6u11jYV2NvBhulvn2R4MHvVUt/ElTLZnxRZdOrWFU6aVgm8W7/v+OLq6r8AuUHNMjESIT4vdmpe+0dFylWavjlQmhR1+ES0Ed0syt3/d0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b6ppK5WW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16A26C3277B;
	Wed, 17 Apr 2024 00:12:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713312727;
	bh=uT0LZ0+w9TZK/EkJyb0TyHCOhtw73KC9C4PnOud+t5U=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=b6ppK5WWL0xFm8r8z0bGxuZMOmg31qjOIHVgZ7ijrzLlH+tecFGaJsdux3lc4oGnL
	 /HzKAjVYaI6zYSBG3rLngCpMeojEXdU/KOqb/vurAzQm5xFZyialRBhda9bH45C8hI
	 jeJa6FqPNAOBon6Cl9NnJVoOM3VcfgeUjivkAjcH7LsaKGu37tJ9Sn9XR0J6zOob2K
	 0mm00ziCVfAiJyUQ5xKbdb+UwhHhbO37jejucGJVMprNRNyUIzhM7npFkkJgDokc7V
	 rmrotJriSGYM9RcNxB00z83ugKlYpVB13mJUwT9xcwgtZ39W+30B6/Wh05uZoO7YlL
	 P8zxNQUCkoaaA==
From: Mark Brown <broonie@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>, 
 Linux trace kernel <linux-trace-kernel@vger.kernel.org>, 
 Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Lars-Peter Clausen <lars@metafoo.de>
In-Reply-To: <20240416000303.04670cdf@rorschach.local.home>
References: <20240416000303.04670cdf@rorschach.local.home>
Subject: Re: [PATCH] ASoC: tracing: Export SND_SOC_DAPM_DIR_OUT to its
 value
Message-Id: <171331272553.1685717.8409632223960307327.b4-ty@kernel.org>
Date: Wed, 17 Apr 2024 09:12:05 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev

On Tue, 16 Apr 2024 00:03:03 -0400, Steven Rostedt wrote:
> The string SND_SOC_DAPM_DIR_OUT is printed in the snd_soc_dapm_path trace
> event instead of its value:
> 
>    (((REC->path_dir) == SND_SOC_DAPM_DIR_OUT) ? "->" : "<-")
> 
> User space cannot parse this, as it has no idea what SND_SOC_DAPM_DIR_OUT
> is. Use TRACE_DEFINE_ENUM() to convert it to its value:
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: tracing: Export SND_SOC_DAPM_DIR_OUT to its value
      commit: 58300f8d6a48e58d1843199be743f819e2791ea3

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



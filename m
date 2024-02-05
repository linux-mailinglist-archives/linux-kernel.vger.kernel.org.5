Return-Path: <linux-kernel+bounces-53054-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A7B584A01B
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 17:59:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F8451F22614
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 16:59:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D44C541218;
	Mon,  5 Feb 2024 16:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fD34cSn0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03B0645942;
	Mon,  5 Feb 2024 16:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707152320; cv=none; b=QE+r8c9WScOrwEQ8YGx9hUQO/67CSMHbj5hII5BrMgK1DMFxi/REK/xwXsETL9KT752FfH09yhKIh7S5GQSX2LGd4PCBggUBQOjB3Dz0WVw/X8h7aSCJb3UI4aOlAFaid8Goegh3bzsGbC3S37pcPpa1FB+4pdg5IcQSa2W3hMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707152320; c=relaxed/simple;
	bh=FeAcDnckfPaXEeaYOauA8BlGD/IQ8ouYP4OQekSYzE0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=BCdB71ZOeMUbrcbZEOhIs7JDpzC4cwAwWTumeWkA5fKkjwxdVgabG6obgRWorPEL/xhMTwQ5iyvk8ZQ2+VQFAhlQSbKnU9uKVyFUaQLDftT6riR+qpPiZ7nvKhyvjaoqyVNjdxb0q1MFwg5ByifBrj/7ODDs/LdNzrCFWSz0iCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fD34cSn0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53353C43390;
	Mon,  5 Feb 2024 16:58:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707152319;
	bh=FeAcDnckfPaXEeaYOauA8BlGD/IQ8ouYP4OQekSYzE0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=fD34cSn0fuegDAoTMIJEKx1zYCkveApNcjp9VtqWXD+wwZkK4vcZWZ3bRRwZ8w21d
	 nlbzkF92umQdEwqFM897EJGwbetKWc0Bd0Aaxd3/aPcjV9MoLrZZtYGd2FdxCSb/bS
	 RkOWq/vD3D6DPZvhQo0cEHXiD6gTmyBeKGkTFHWjRgLxaABmleMoveEEsS1ZkCeUq9
	 5gcjT46hQoXpeNTJNb4YwUnOvgmzVZn5bvJuysN22E5Jd8KtZFDLY4iXwLTPRL7Yzp
	 eg5szW8MfKwS1V9NnbzOYAVGqABRIHnCN5xX2MvWAeFD2jv1i4yPqJdJ1lCXdDBpVb
	 vdt3Cc5IR8BnA==
From: Mark Brown <broonie@kernel.org>
To: lgirdwood@gmail.com, robh@kernel.org, krzysztof.kozlowski+dt@linaro.org, 
 conor+dt@kernel.org, judyhsiao@chromium.org, quic_bjorande@quicinc.com, 
 Jeffrey Hugo <quic_jhugo@quicinc.com>
Cc: linux-sound@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240202174313.4113670-1-quic_jhugo@quicinc.com>
References: <20240202174313.4113670-1-quic_jhugo@quicinc.com>
Subject: Re: [PATCH] ASoC: dt-bindings: google,sc7280-herobrine: Drop
 bouncing @codeaurora
Message-Id: <170715231596.801804.4691901821282176179.b4-ty@kernel.org>
Date: Mon, 05 Feb 2024 16:58:35 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-0438c

On Fri, 02 Feb 2024 10:43:13 -0700, Jeffrey Hugo wrote:
> The servers for the @codeaurora domain have long been retired and any
> messages sent there bounce.  Srinivasa Rao Mandadapu has left the
> company and there does not appear to be an updated address to suggest,
> so drop Srinivasa as maintainer of the binding.  The binding still
> appears to be maintined as Judy is listed.
> 
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: dt-bindings: google,sc7280-herobrine: Drop bouncing @codeaurora
      commit: ac670505d825151ce47c1e75b9964485991954dd

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



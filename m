Return-Path: <linux-kernel+bounces-67184-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FF708567AF
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 16:31:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 42D9D1C23DF5
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 15:31:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07F75134CED;
	Thu, 15 Feb 2024 15:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OI1bz2tp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F529134CCC
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 15:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708011037; cv=none; b=tZKUuVQwCJ+a24a0QhLKhwVWAb5bi0Hmr1eZCFphQMlxxl58ueUaYqRDcKPdC72mReJxRFYDuXGmLeWYBqinOmi71mjyuk5JpLUT4/vDSQytYdO48h11X+/y7ib7VZCFCZ96dNBji455QPBNE/6tC4liOxDGMArxkOuOYm0m9Kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708011037; c=relaxed/simple;
	bh=KLmrAcg/xYRY8OgUQYc6KakNPJkBqSdX6uUdZ8c1ksM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=oIIlKt+oARgfr+oKKBS0RJzpqBuPB+WBX/3HggGgg0QPlaJ1GzoJLM4VDPQ7h4t9pfYK3A2cmyFkFzZzep18SUrvSz3zoSwZTT0aRXvnRYkor7LmmTlYi1whDlxXQMOeobGLbWR4tit+7XV9I2IcaQnpCtANPPmIeOdirkDWTZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OI1bz2tp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 221C2C433C7;
	Thu, 15 Feb 2024 15:30:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708011036;
	bh=KLmrAcg/xYRY8OgUQYc6KakNPJkBqSdX6uUdZ8c1ksM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=OI1bz2tpqNKnRauwLcpdf0eW0J2bJjgTEsf5QItCh2GCRibF1fJ2LSBs8QnTbSzGX
	 3RBOhVkyU95XASijcg9xOl68t/cGiR/Ad5RR3+J1IMkYaRrwVzN4mdTmZp0ip3MlHt
	 RGNXwWMswgOveUdc5If6LZp1B/RfPdm32nKIT0ZxI9iFnLWoQjSmYAAO1KO1nB+1s1
	 8s6xHru2gqNMlXCth/ts1HVHY7PvoWnQPcMrfaijpTY7poGjCit2EPkGymAZZKwZYU
	 /EU9TfEAToVbJ6RmWaAjgIuj7oRmMnlPZpxOae47V55RHrIUEeLMeJ5X9EsRdN7m3x
	 KPwbdnIGfUZSg==
From: Mark Brown <broonie@kernel.org>
To: J Keerthy <j-keerthy@ti.com>, Liam Girdwood <lgirdwood@gmail.com>, 
 Geert Uytterhoeven <geert+renesas@glider.be>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <15edeaa9a644c4025234088da3dabb023fce04ac.1708002503.git.geert+renesas@glider.be>
References: <15edeaa9a644c4025234088da3dabb023fce04ac.1708002503.git.geert+renesas@glider.be>
Subject: Re: [PATCH v2] regulator: lp873x: Use bitfield helpers
Message-Id: <170801103587.74704.5406672445598084799.b4-ty@kernel.org>
Date: Thu, 15 Feb 2024 15:30:35 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-a684c

On Thu, 15 Feb 2024 14:09:18 +0100, Geert Uytterhoeven wrote:
> Use the FIELD_PREP() helper, instead open-coding the same operation.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: lp873x: Use bitfield helpers
      commit: 2601b6fb7d715fe5a808d12232ed9ae05fb86eef

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



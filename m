Return-Path: <linux-kernel+bounces-157035-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2B008B0BE2
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 16:05:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 103DC1C21F9C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 14:05:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6608A15D5D8;
	Wed, 24 Apr 2024 14:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NMYtRAGd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEE6415B986
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 14:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713967521; cv=none; b=UrCHXilI36pARdfGc9qk/7v4lm0Bgh9uDxtfyhP/z22PTLkFuqeLJD/MrnRP7s4UBLmFrbf/EJ7zm6PZ77Z7nsKWLks8a3Z7zY7hj9FGt3PE5qeuJFQnTVEj8orQgFUNFZmP/VgYx6CS8rgWnphkCzvVY3U44b/l2Kfyhs3/A9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713967521; c=relaxed/simple;
	bh=4SJtdaTjsf5SlFRQaf4S7zUbhDdqyb6snZP2XyBRKSc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=HVfx+7avQoFLMZKgwl4I5/LnfbVnfNNMOZUbhbPwyudO1K/GTv9JaTVtP63eEF4Qeyf7Z804wmwZ/k07WnSc1X8p8YmoFEns7SLAB4RAnbqBRdb2nlDxRG+9Je5RUR9Y2yiudbYl58yZmSR4vitfNe+wymktDOYtkNLNZ2OXkio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NMYtRAGd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17C3CC113CE;
	Wed, 24 Apr 2024 14:05:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713967521;
	bh=4SJtdaTjsf5SlFRQaf4S7zUbhDdqyb6snZP2XyBRKSc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=NMYtRAGdWkBMaTV7DfzwijJ6jca+ChyqJzITpUswwvWPgJEtKeZ/CpAphHvTj8YN9
	 5iLXynLGsF/L/zcVF4omD/VLl2l6xpicrp5RbzZEowNQz5OD4RBIXFABzXYrNgk+Ad
	 h1acPwRPTFEyBnbeZoQbpiQgfjQIxMo/t328RT0GugXx9ig/qFmqn7Egokwbk1cIZq
	 OaYSBtua/NrzsgKD2NHkGWH9Hx/CMmt3KtuFbclLD/hlqeHtvudrG8dhwmB3PsVulq
	 i/OOp3vAZAVluv0a/VDkmTJaIYuuogPZevvQlznfXTAUB7ZkjOFxbNXgP6GdQy4lAj
	 I95dDWlIdiOxw==
From: Mark Brown <broonie@kernel.org>
To: Matti Vaittinen <mazziesaccount@gmail.com>, 
 Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, 
 Aleksander Mazur <deweloper@wp.pl>, Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <ZiedtOE00Zozd3XO@fedora>
References: <ZiedtOE00Zozd3XO@fedora>
Subject: Re: [PATCH] regulator: change devm_regulator_get_enable_optional()
 stub to return Ok
Message-Id: <171396751942.1800997.17688066759852563892.b4-ty@kernel.org>
Date: Wed, 24 Apr 2024 23:05:19 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev

On Tue, 23 Apr 2024 14:38:28 +0300, Matti Vaittinen wrote:
> The devm_regulator_get_enable_optional() should be a 'call and forget'
> API, meaning, when it is used to enable the regulators, the API does not
> provide a handle to do any further control of the regulators. It gives
> no real benefit to return an error from the stub if CONFIG_REGULATOR is
> not set.
> 
> On the contrary, returning an error is causing problems to drivers when
> hardware is such it works out just fine with no regulator control.
> Returning an error forces drivers to specifically handle the case where
> CONFIG_REGULATOR is not set, making the mere existence of the stub
> questionalble.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: change devm_regulator_get_enable_optional() stub to return Ok
      commit: ff33132605c1a0acea59e4c523cb7c6fabe856b2

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



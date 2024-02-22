Return-Path: <linux-kernel+bounces-77388-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C98A8604A7
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 22:20:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31F5F1F250D2
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 21:20:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 192AA73F21;
	Thu, 22 Feb 2024 21:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h2VtMYEu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59B3B14B832;
	Thu, 22 Feb 2024 21:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708636830; cv=none; b=CQYJlshTmUSXY/UpRyAg088t82a0ify+qr9UCetJuoS2GUpmVoUtuRVb+j4s453i+SsL16otLNYRc0lZ7eUoY0V3bJ/3uWhEJvx1rAzO9LzQzcJeCWRWHmjn1uxfe4wMVxUuaHc8Frud0GhrH+Zfsm5YH0hLa0B9FZuy0LXfgKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708636830; c=relaxed/simple;
	bh=5MUlZbapTPCxc1lpZiRLDnYoq2FuEhSOM8CkV5YjxZI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=IcOL92UyI8S1HnZtKfBWzokDjLQw+oNA+bw91EputlmxM/s6Wz8YhxrsglW4FuflzyJaF6mn6o/in6GYgbwIGwHDK5E2IHDURRRogJBRFXTUEcYL/K7/dzx+8NpM/9SqcpCPHcLL8OeJvlOb2MFuFzHuOhgU/R0ZRf9KxJYe85k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h2VtMYEu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D24CDC43390;
	Thu, 22 Feb 2024 21:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708636829;
	bh=5MUlZbapTPCxc1lpZiRLDnYoq2FuEhSOM8CkV5YjxZI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=h2VtMYEuXU11hflmGrWqiXXuAHbJX3MhEv7CHQFfoHN4PzRSKztaV0mzZZP8XVgIj
	 I+Y3tjAl5fTCWzqsbub9i/4clcQj0MZl/xl2eQzmZtv7olo0M7lNIcgLaUOs045oFz
	 w3TRbSUj+koiFC7thzmLwz97mmJ4es52wJzNxx3UU0610S+6TDzuwJFuMYExbeq5Eb
	 5/FKvEeX7OzcKz3Z3E2V9Ywt+LatHQBnLuABFFFoWPp76WvEvO84kH1OFdvzDqR+//
	 hTl21JoE8AuOS0zPNigL4Yv/FNEIXyiBYOWAaKhAKUMxRnlA6ozE8VJkTelsKc5ykg
	 +xxGhYCSDgNkQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B287AD84BBB;
	Thu, 22 Feb 2024 21:20:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: hci_qca: don't use IS_ERR_OR_NULL() with
 gpiod_get_optional()
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <170863682972.29147.2545768852887642149.git-patchwork-notify@kernel.org>
Date: Thu, 22 Feb 2024 21:20:29 +0000
References: <20240208164017.26699-1-brgl@bgdev.pl>
In-Reply-To: <20240208164017.26699-1-brgl@bgdev.pl>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com, linmq006@gmail.com,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 bartosz.golaszewski@linaro.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu,  8 Feb 2024 17:40:17 +0100 you wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> The optional variants for the gpiod_get() family of functions return NULL
> if the GPIO in question is not associated with this device. They return
> ERR_PTR() on any other error. NULL descriptors are graciously handled by
> GPIOLIB and can be safely passed to any of the GPIO consumer interfaces
> as they will return 0 and act as if the function succeeded. If one is
> using the optional variant, then there's no point in checking for NULL.
> 
> [...]

Here is the summary with links:
  - Bluetooth: hci_qca: don't use IS_ERR_OR_NULL() with gpiod_get_optional()
    https://git.kernel.org/bluetooth/bluetooth-next/c/75518da8cf76

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




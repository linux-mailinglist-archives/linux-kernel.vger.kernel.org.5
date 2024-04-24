Return-Path: <linux-kernel+bounces-157230-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BA0578B0ED9
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 17:43:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EAF3C1C24767
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 15:43:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E4A4161914;
	Wed, 24 Apr 2024 15:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qaUzYRic"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E4591422AF;
	Wed, 24 Apr 2024 15:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713973228; cv=none; b=iuAKK+yOdxBHxkGZiufmoXs+rbUyPUXgntgpEWH+sDCuJV1NG+aAhrzXK5Vbrt/Fs6p6sxyoaGeklASHN6Gwex8/dNDUVkU3/bysOUfq7pbK7V7JaI5STFxwsD4JDXsluozOmmY67niZkF7tRACWIsKclkjfE20QnMqq0oO4dco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713973228; c=relaxed/simple;
	bh=tSF+fXC/5UoyBir7NlJl0L6xjWjymwNzHWTY9j9wrms=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=SgTDs3AvZEAejuaIq72jjYw62P7hZ7mLoaYdkM4qSbo4nK/u6LBGKFfrsGemv7yhO6IXXOYTtJkAm2/rR2ys6iGXxkdyLb/7hmOLEuhbKn0ioAAHYanweNyfIUUGxBlHWbmmL3hJzz+2lSgVJmUaMZyR2IAxkHUdzqGOgr3D5rM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qaUzYRic; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 080BCC2BD10;
	Wed, 24 Apr 2024 15:40:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713973228;
	bh=tSF+fXC/5UoyBir7NlJl0L6xjWjymwNzHWTY9j9wrms=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=qaUzYRicrYGQY4oIzj5ut5+FLbcXi10VFRvov5hu/rlgbDJvtkoI7tv7uENqnldmO
	 p7QKCh0inAxncxd9/q2goFNGTpkE0zjYUTXlOHPtHz/8Ip5DuUjO5ye+SM/pMLe1pD
	 U+PqZgTP/X08KfomjiDjpWqgmpvmYhAsZvjbgK9HsJSGaof4X+Q7Jl7zdUBWBi3uF+
	 6CkZkL2R9O87yu38m+aRPORfD/q0lOfOUU6lqH6JqVkuJ2wlRz8m4mqV6ALTYGkHhw
	 PvauqujeE86AoaIO0/vG2NKrPTUi57V4bqXDQnmOfhxEHXA4CoQ40bg5OPS44Y8MBu
	 ZqIffjMzDGvMQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E32D5C595CE;
	Wed, 24 Apr 2024 15:40:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] Bluetooth: qca: set power_ctrl_enabled on NULL returned by
 gpiod_get_optional()
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <171397322792.12898.8815870206676100532.git-patchwork-notify@kernel.org>
Date: Wed, 24 Apr 2024 15:40:27 +0000
References: <20240424122932.79120-1-brgl@bgdev.pl>
In-Reply-To: <20240424122932.79120-1-brgl@bgdev.pl>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com, krzysztof.kozlowski@linaro.org,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 bartosz.golaszewski@linaro.org, wt@penguintechs.org, quic_zijuhu@quicinc.com

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed, 24 Apr 2024 14:29:32 +0200 you wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> Any return value from gpiod_get_optional() other than a pointer to a
> GPIO descriptor or a NULL-pointer is an error and the driver should
> abort probing. That being said: commit 56d074d26c58 ("Bluetooth: hci_qca:
> don't use IS_ERR_OR_NULL() with gpiod_get_optional()") no longer sets
> power_ctrl_enabled on NULL-pointer returned by
> devm_gpiod_get_optional(). Restore this behavior but bail-out on errors.
> While at it: also bail-out on error returned when trying to get the
> "swctrl" GPIO.
> 
> [...]

Here is the summary with links:
  - [v2] Bluetooth: qca: set power_ctrl_enabled on NULL returned by gpiod_get_optional()
    https://git.kernel.org/bluetooth/bluetooth-next/c/48a9e64a533b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




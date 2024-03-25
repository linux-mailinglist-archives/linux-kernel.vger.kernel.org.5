Return-Path: <linux-kernel+bounces-116403-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11464889AA8
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:32:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 343D81C33475
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 10:32:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FCCF143C6F;
	Mon, 25 Mar 2024 05:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bf4PA4AJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4FC21448C5;
	Mon, 25 Mar 2024 02:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711332790; cv=none; b=t6GriCTwVChT//VbpLOuyjwDLji0uRD7+A2zT+2+RH1T1Y2UMmUgs/ZP2l0Mwp4e2xeuFbOdKrsFvZJN73iLtFD4ZgpzXDUJLfSxxE/AkqZDUziN409ca1r/OdL9hzYDdBRXPdPq7jeEucl66Cf1368FxalqI4RGZai+/qNj/ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711332790; c=relaxed/simple;
	bh=5wz/G6BX39xadTRq0vFfWqYZDZhSRjYlx0kuuawdnUY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=RTqZ+N+YfszdbYr0Jv7vsSMJscmQa5uQ6l8VSSkHhwAP0S2Jy/sPwgt4qMFczCXEpzeZwDa7joQg/lTLhLgGIcQK37hWSuH2Kh7R5Uy9MCP2ZCx9XmukLEaoTImoCqJikbHMAmOrqO8MXyU4yVkcIcCb/z8bA0QzF0azKKrVMy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bf4PA4AJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C2673C3278B;
	Mon, 25 Mar 2024 02:13:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711332787;
	bh=5wz/G6BX39xadTRq0vFfWqYZDZhSRjYlx0kuuawdnUY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=bf4PA4AJ6lFivhLpGcubQoBLV61qpUeFb5CEvCqEnG+WnZVpdTtq1TuutfbOOTnK8
	 KUbnm61riFCmr43khH6NJi+4O1d75Ldpm05eeetUHo1B1Wi5vnJupujdw46EbtGMoy
	 guqa2zX2JJk5Oa+qv/Oa+zEqgpaecqGNAMw04MelD+IQ2unKuY71gotTmBa86UnRwW
	 nytA2WM5NsQWo/cY8jD0IUH2Bh9n9HuqLCO+m9hyxg0EyTrdg7l7WlHXTeT9aqwg9v
	 uuNMse2kFdLrJV17V0aMiyoJc+5+ucfT+2/0JNrcXygvVB5vKNmDS3mjGr2f763QO+
	 WAOcXVm6tj7Rw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B4277D2D0E4;
	Mon, 25 Mar 2024 02:13:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] treewide,
 serdev: change receive_buf() return type to size_t
From: patchwork-bot+chrome-platform@kernel.org
Message-Id: 
 <171133278773.9916.16472744560807510288.git-patchwork-notify@kernel.org>
Date: Mon, 25 Mar 2024 02:13:07 +0000
References: <20240122180551.34429-1-francesco@dolcini.it>
In-Reply-To: <20240122180551.34429-1-francesco@dolcini.it>
To: Francesco Dolcini <francesco@dolcini.it>
Cc: gregkh@linuxfoundation.org, jirislaby@kernel.org,
 linux-bluetooth@vger.kernel.org, linux-mediatek@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 greybus-dev@lists.linaro.org, linux-iio@vger.kernel.org,
 netdev@vger.kernel.org, chrome-platform@lists.linux.dev,
 platform-driver-x86@vger.kernel.org, linux-serial@vger.kernel.org,
 linux-sound@vger.kernel.org, francesco.dolcini@toradex.com,
 luiz.dentz@gmail.com, johan@kernel.org, elder@kernel.org, jic23@kernel.org,
 lee@kernel.org, kuba@kernel.org, pabeni@redhat.com, edumazet@google.com,
 davem@davemloft.net, krzysztof.kozlowski@linaro.org, hdegoede@redhat.com,
 ilpo.jarvinen@linux.intel.com, bleung@chromium.org, tzungbi@kernel.org,
 robh@kernel.org, Jonathan.Cameron@huawei.com

Hello:

This patch was applied to chrome-platform/linux.git (for-next)
by Greg Kroah-Hartman <gregkh@linuxfoundation.org>:

On Mon, 22 Jan 2024 19:05:51 +0100 you wrote:
> From: Francesco Dolcini <francesco.dolcini@toradex.com>
> 
> receive_buf() is called from ttyport_receive_buf() that expects values
> ">= 0" from serdev_controller_receive_buf(), change its return type from
> ssize_t to size_t.
> 
> The need for this clean-up was noticed while fixing a warning, see
> commit 94d053942544 ("Bluetooth: btnxpuart: fix recv_buf() return value").
> Changing the callback prototype to return an unsigned seems the best way
> to document the API and ensure that is properly used.
> 
> [...]

Here is the summary with links:
  - [v2] treewide, serdev: change receive_buf() return type to size_t
    https://git.kernel.org/chrome-platform/c/fed99212acae

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




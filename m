Return-Path: <linux-kernel+bounces-116386-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26A8988995C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:08:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 16365B28ECF
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 08:48:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0415E131E3A;
	Mon, 25 Mar 2024 05:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H5v5+h49"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BC32149C6F;
	Mon, 25 Mar 2024 01:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711331664; cv=none; b=GJotvEpMU2t96ExlDP3QYkgti/oue1B5/XZ2/OAaIXFHBOg1K26ltNX9kzVIaC/PnayRyFTRu4YN4f21q8FdTbC9asELWe8D6wb/XNMMmEug7fnwPJGVoT5EkY2oD+cMj3e1Xyxxr/P3JU9ZaKKy5lFZlvUtn2KgsaoMl5MvKZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711331664; c=relaxed/simple;
	bh=6oSruhpUUM/JsOE/DmTpdI2vwwDBrgPZ0a067ebg71g=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=BXavgyVIwbI0XKt1bmIkdF8F+g0tHgU1gEza/QMi5atTyUN40Y2UP4Zw6q60v2jdLAevl79doPcqwa3mWV37MQAFut45u2PH4gdHOaD5f3a/3JCcsD95+91BVI6QTqL08yDZxgNdIsE1jv1Y6zYz+VCooluQ5p0gBwpWn7T7MgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H5v5+h49; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B6E65C3278A;
	Mon, 25 Mar 2024 01:54:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711331662;
	bh=6oSruhpUUM/JsOE/DmTpdI2vwwDBrgPZ0a067ebg71g=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=H5v5+h49ENxYpO4Qx7Bxhx6rXvKE1uOYwWRPMuOMKAAAGjbVLOwiVpxBUGFp5tgD0
	 bRdst26F9hDjh7YUZUwWr0x2cAfYNRnj+dxtl/ne6glopIwxX+aoKUy6CJcxbWbaUd
	 MNr0+9gadKcBt3ZsPaHE1sxCHjuCpj1s5bpqLzxDj5YOy3Dta1gaLkaSqBQAzpz4LX
	 MIdCzDsNSrkQbOQKie0yC9qHiPkAzdY9UedzZ5MflJ7Du/7ighdOEZfL1lo9oLnp14
	 irlDyqzxpGP8P9NN8Jv7v8MMGYjdEJEFqvc3HShkoC9g70mAo7FfNU3xI07MtYbvbK
	 tzSw6JGLkISEA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A9007D2D0E0;
	Mon, 25 Mar 2024 01:54:22 +0000 (UTC)
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
 <171133166268.9916.3624245768126440750.git-patchwork-notify@kernel.org>
Date: Mon, 25 Mar 2024 01:54:22 +0000
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

This patch was applied to chrome-platform/linux.git (for-kernelci)
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




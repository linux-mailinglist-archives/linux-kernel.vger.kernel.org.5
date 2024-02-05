Return-Path: <linux-kernel+bounces-53195-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C4D284A1F2
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 19:17:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1BF8EB221B6
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 18:17:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43187481D1;
	Mon,  5 Feb 2024 18:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mC8+boFi"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84CBE41218;
	Mon,  5 Feb 2024 18:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707157058; cv=none; b=oa/gtwQ67D6tY+GsTpKXqTai07MXNx/a4Vi5YQz6RSJgzwmN/0qUP6khuub2hD9sYbjZ+33TiDqR9fcEWazbOdXacrNAwAik5iteHFeq08o0vacq07XrmenykgdmgjtmCpkLbiyC45j2Xe9et3MjStfKC7vuT4GyUEZyXtMgIm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707157058; c=relaxed/simple;
	bh=oB756OMoEHxo37eMDbKNdcdFMPmbQx4qT7PDAoBgfcE=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=kgBVtY6Z3uerOPaQ49X1iJH74RXI5A10hBzlRnZcq0WPxpmqP40VHxv55Kwj19vfW/FTF1O/lARMXGug493cJ9x2I2mpdkN481qeZpZiKZbHX80Htud+re2bBeIT+O39N7qp1zm7xrF/vUwU5FiZXaax38DXbCYdt+Y6FEZZnhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mC8+boFi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21E74C433C7;
	Mon,  5 Feb 2024 18:17:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707157058;
	bh=oB756OMoEHxo37eMDbKNdcdFMPmbQx4qT7PDAoBgfcE=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=mC8+boFiw5YGwQwgeNyQ21llida4awt2o1/R+Ry1NHomR8zE+8iYg3HpzH7/Si6Xx
	 1emrGfWnQfZlNeD87qwscNjmiSMi7kbvgkT4owtAmjJow7Vl+zx3WknmenB5R1EHrb
	 4Yq6nh1chr9+y57M/TqE7UFr9YZXMLNmZDkzCqYyMP4Sov+eTV4MaaPhWnZX8Isuqt
	 Bta0SuKWePXflpY56kHPwDxXo9HlP+iIrk4kt2ZtXzEDiuILneycRVqCi09Y0eN8rW
	 8WS5DEHt/64roz50H8Jf5RCs2sPgN84Fgqm5SGyTRLKc78aNRCSZGewVAnqlduedny
	 3+y//tlI2KWng==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 2/6] wifi: ti: wlcore: sdio: Drop unused include
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20240131-descriptors-wireless-v1-2-e1c7c5d68746@linaro.org>
References: <20240131-descriptors-wireless-v1-2-e1c7c5d68746@linaro.org>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
 Arend van Spriel <aspriel@gmail.com>, Franky Lin <franky.lin@broadcom.com>,
 Hante Meuleman <hante.meuleman@broadcom.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Arnd Bergmann <arnd@arndb.de>, Lee Jones <lee@kernel.org>,
 Brian Norris <briannorris@chromium.org>,
 Srinivasan Raju <srini.raju@purelifi.com>, linux-wireless@vger.kernel.org,
 linux-kernel@vger.kernel.org, brcm80211-dev-list.pdl@broadcom.com,
 Linus Walleij <linus.walleij@linaro.org>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <170715705340.1586694.2181997666325091353.kvalo@kernel.org>
Date: Mon,  5 Feb 2024 18:17:34 +0000 (UTC)

Linus Walleij <linus.walleij@linaro.org> wrote:

> The file is including the legacy GPIO header <linux/gpio.h> but
> is not using any symbols from it, drop the header.
> 
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

5 patches applied to wireless-next.git, thanks.

04e9c8af8b2d wifi: ti: wlcore: sdio: Drop unused include
b303de763b63 wifi: brcmsmac: Drop legacy header
163857d99531 wifi: mwifiex: Drop unused headers
d8da5a213812 wifi: plfxlc: Drop unused include
2719a9e7156c wifi: cw1200: Convert to GPIO descriptors

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20240131-descriptors-wireless-v1-2-e1c7c5d68746@linaro.org/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches



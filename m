Return-Path: <linux-kernel+bounces-53188-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F54284A1DB
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 19:13:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D21B01C22F2E
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 18:13:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFCE947F76;
	Mon,  5 Feb 2024 18:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZcED2MTl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1929D45957;
	Mon,  5 Feb 2024 18:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707156809; cv=none; b=d0jyDuvOxrwy6c134t72dZphGNdB4j24bA46NJ4hT67TnWdPerkzD6A2XqJI1rTq8qZLdjVsLu8ZvW9Uqp1br3PZUMi82FhdO4JCeBnRhskhrozMqa53Vcb1zZ2Wc5YGLyUiLtQW/XVQujQpnMFZgplJO87fY+59kua+NTwoeFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707156809; c=relaxed/simple;
	bh=zwWd6kMUZL9LhGKU5H/sABkgezip0N01LItAnce207s=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=CK/hJ7r/Dt4z+bbAXPiIsy1X7r7Ft+43bMEeJkUfBKb0VuoOLwhbIjDOl1yMLMG2eAEI/1t5mg2DYmyTUfl0+229R1kCsbu3bta+1eaaioq7ZkiY4LbPncj2fQAgLxGbWPlYEkEABQHGmo1iEqkhHpih6yVqtuQ+ecxxnXhUbAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZcED2MTl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97E68C433C7;
	Mon,  5 Feb 2024 18:13:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707156808;
	bh=zwWd6kMUZL9LhGKU5H/sABkgezip0N01LItAnce207s=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=ZcED2MTlyOPWREAeEJYA6ocQXSVuOqH3Z1ufADn5PUv8WNpcTUIGLlkXEv9kISzvh
	 Hnsa1izkdRiA+RQaXzNjDR9xfuIw5pBbTVhrEK+YPwF53lDCiTDwTNInrJVlJd0Hh8
	 Eaa1ffFWZ0unOSZ8m8dhv36PGkaOSD5zVC7W1iwWN6Dn4RflfMcLG0EBN1CsfD+gzq
	 bA3bXkTvpb60DhxO7Hz1kwhsDWW9FyCTFa0QabniskTotpN/XcfbitW+EHoTqHczyV
	 nr4BPeR4xKtW2b2sHgL0VuF5hQb0kOlvTjsifRaZsO+Up6GT9IwHAIrnI+t7D5jhW9
	 Pq6SK++RWIg9Q==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 1/6] wifi: ath9k: Obtain system GPIOS from descriptors
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20240131-descriptors-wireless-v1-1-e1c7c5d68746@linaro.org>
References: <20240131-descriptors-wireless-v1-1-e1c7c5d68746@linaro.org>
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
Message-ID: <170715680359.1586694.14954330985835827619.kvalo@kernel.org>
Date: Mon,  5 Feb 2024 18:13:25 +0000 (UTC)

Linus Walleij <linus.walleij@linaro.org> wrote:

> The ath9k has an odd use of system-wide GPIOs: if the chip
> does not have internal GPIO capability, it will try to obtain a
> GPIO line from the system GPIO controller:
> 
>   if (BIT(gpio) & ah->caps.gpio_mask)
>         ath9k_hw_gpio_cfg_wmac(...);
>   else if (AR_SREV_SOC(ah))
>         ath9k_hw_gpio_cfg_soc(ah, gpio, out, label);
> 
> Where ath9k_hw_gpio_cfg_soc() will attempt to issue
> gpio_request_one() passing the local GPIO number of the controller
> (0..31) to gpio_request_one().
> 
> This is somewhat peculiar and possibly even dangerous: there is
> nowadays no guarantee of the numbering of these system-wide
> GPIOs, and assuming that GPIO 0..31 as used by ath9k would
> correspond to GPIOs 0..31 on the system as a whole seems a bit
> wild.
> 
> My best guess is that everyone actually using this driver has
> support for the local (custom) GPIO API and the bit in
> h->caps.gpio_mask is always set for any GPIO the driver may
> try to obtain, so this facility to use system-wide GPIOs is
> actually unused and could be deleted.
> 
> Anyway: I cannot know if this is really the case, so implement
> a fallback handling using GPIO descriptors obtained from the
> ah->dev device indexed 0..31. These can for example be passed
> in the device tree, ACPI or through board files. I doubt that
> anyone will use them, but this makes it possible to obtain a
> system-wide GPIO for any of the 0..31 GPIOs potentially
> requested by the driver.
> 
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> Acked-by: Toke Høiland-Jørgensen <toke@toke.dk>

I understood that there will be a new version for ath9k so dropping
patch 1.

Patch set to Changes Requested.

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20240131-descriptors-wireless-v1-1-e1c7c5d68746@linaro.org/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches



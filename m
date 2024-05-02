Return-Path: <linux-kernel+bounces-166768-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2859D8B9F42
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 19:09:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 17A0DB23BAC
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 17:09:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED28D16FF26;
	Thu,  2 May 2024 17:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nt88XE8T"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39B4C16F8F2;
	Thu,  2 May 2024 17:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714669783; cv=none; b=HgAH9Cddunwe/fM+L1NPSKqtL29Ozjxrv7mdNUX7a1JkQzYBeD6cpl59zkVcj+CLxLyVM4y7bHtdMjOOFU62zfnJaFl7wP269BcZJuQeINtEEBTJ+SIf4gBMh/NzWxjDQ13LyLgct2P06+sr+fpCv/DpWPyCUkv/gd4Ra0WKgDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714669783; c=relaxed/simple;
	bh=PNX+UoOq3rXawHExE4biSBofUVNLXa/fcPmSy+UzoDw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=n+mvp2pxa7pckrgyXUao8E/D3ryx772TcvTFvbOIqD1Sf5UcyFWyDhEAbGq5ib0bbKBYItIKt/UjZ0f8frS6rgvJJ210qWk2iqiehPRxNRIrA3pba2VKhGIS3kgCrCkCMNo9ARgCttsELcUdp18LsR2qe1CSDQXxwcDQ2gDU6oU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nt88XE8T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD02DC113CC;
	Thu,  2 May 2024 17:09:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714669783;
	bh=PNX+UoOq3rXawHExE4biSBofUVNLXa/fcPmSy+UzoDw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=Nt88XE8Tag5MyuJMtGY4EcVsjTCWdwSwTk1xB131zOydXFz+Aer4YLNkorNFSDgqE
	 Bq7SMlwc3INgPwT6tEQa+RnJhzk4zQ2S8Fr7qPZPUrPlcnB7iPK1bkV41pTBlYrCH+
	 fmWED6LLOK6z+lYvFhdzxhe+eNP6jNZPwS7kad8ezqSwWPydB0DNGrzxW/mHWcjQYA
	 5L3X0LjwesG/G66XlpIW+6p6JcS7sWftDLIb+1qIAH3y/sgZg1EdBfJ+9e8XVsorPl
	 fqas/KUKEtutsU0ENcf9xWJyLf/FdWimKxb0LYeD9LmWstljHLiBRO1vPF2x/eCAzM
	 X/x1wzvL08Izw==
From: Lee Jones <lee@kernel.org>
To: Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>, 
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org, 
 linux-leds@vger.kernel.org
In-Reply-To: <f7c8c22242544b11e95d9a77d7d0ea17f5a24fd5.1714318454.git.christophe.jaillet@wanadoo.fr>
References: <f7c8c22242544b11e95d9a77d7d0ea17f5a24fd5.1714318454.git.christophe.jaillet@wanadoo.fr>
Subject: Re: (subset) [PATCH] leds: aat1290: Remove an unused field in
 struct aat1290_led
Message-Id: <171466978150.1217698.11684406650765336889.b4-ty@kernel.org>
Date: Thu, 02 May 2024 18:09:41 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.12.4

On Sun, 28 Apr 2024 17:34:55 +0200, Christophe JAILLET wrote:
> In "struct aat1290_led", the 'torch_brightness' field is unused.
> Remove it.
> 
> Found with cppcheck, unusedStructMember.
> 
> 

Applied, thanks!

[1/1] leds: aat1290: Remove an unused field in struct aat1290_led
      commit: 678ba7d25467c06850d0d2922108573ea7346a48

--
Lee Jones [李琼斯]



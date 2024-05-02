Return-Path: <linux-kernel+bounces-166769-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C28368B9F46
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 19:11:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E387289FDE
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 17:11:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F1AA16FF2B;
	Thu,  2 May 2024 17:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DoQM7NZ2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D33B15E5A9;
	Thu,  2 May 2024 17:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714669906; cv=none; b=YWyyJVkyAw9OxufRhk0/Y4S0eToyXfe71uxpC1as1kqJIuC9v/l07o4tJ42e03ggqgtInVYNSl53zicT2zAhtRIdDWdE4aMnnoJVeZBfhZbhUGW4Dq9sDcTREYIqe2p/laRnFESxIRJrwIrQ4UdWLSlximLS3C3asR2SgYoZ9oM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714669906; c=relaxed/simple;
	bh=u/DblLfRiDCkeEtlb4y+YuZ+dOra+VrsYY7qYqGOq2U=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=fD8v0BSSxCEcl05R3iHVoJrnV3an+a7WVQh4b+/ype69hdJc4I3i46bvjcYa3BCMg99fDpfYC7r4vdiigaQ2JJJKxZO44S9tNQfaRNFoWGIKhUgx0Z+6hmo7Funxij+QJJULddo3HSE9AcyBX27YBE0JqM1Ms8Nk1xVfSxZm7Wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DoQM7NZ2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDF0FC113CC;
	Thu,  2 May 2024 17:11:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714669906;
	bh=u/DblLfRiDCkeEtlb4y+YuZ+dOra+VrsYY7qYqGOq2U=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=DoQM7NZ298WvKRt0m/RS2MQR8Yrug59kj6Nxm26XZxHIQVKqwoEV84Eoprg0xgtn8
	 aFtkgPgdNBNcW/yF0LRRsXlCnTxxz2g5gPXWdpoU0G458pltl/uE2QjyWK9Adkw94T
	 c1MapKJIv9Wj2zQjIcqxnhCIV7IyW32BZQdXzJQuNLZKZz7wtrmKFjqw5hMfafg9fc
	 GXVn9DV0/zGjfvQqmy5MIHT3a4E4ieb01Oa9nkqF0Lgh/D5m0BQfy9RpyyUlHexPg/
	 AYvC9Ru2pNndjk8QZ3rsbx7cZKdwael3PC7g64pyWqw5GunaDaVTDrCoDNFYGI9TDz
	 ZL+ulDfHxFzXg==
From: Lee Jones <lee@kernel.org>
To: Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>, 
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org, 
 linux-leds@vger.kernel.org
In-Reply-To: <bc2e5e57b93ca0a33bcc84e9bdc89f26fc8f6d57.1714324500.git.christophe.jaillet@wanadoo.fr>
References: <bc2e5e57b93ca0a33bcc84e9bdc89f26fc8f6d57.1714324500.git.christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH 1/2] leds: lp50xx: Remove an unused field in struct
 lp50xx_led
Message-Id: <171466990460.1219041.13171423659108477834.b4-ty@kernel.org>
Date: Thu, 02 May 2024 18:11:44 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.12.4

On Sun, 28 Apr 2024 19:15:24 +0200, Christophe JAILLET wrote:
> In "struct lp50xx_led", the 'bank_modules' field is unused.
> Remove it.
> 
> Found with cppcheck, unusedStructMember.
> 
> 

Applied, thanks!

[1/2] leds: lp50xx: Remove an unused field in struct lp50xx_led
      commit: 221db0183bebbee146922b5816419bdc9b5425ff
[2/2] leds: lp50xx: Remove an unused field in struct lp50xx
      commit: dd66d058565a705980e6d55bd6592958531221b9

--
Lee Jones [李琼斯]



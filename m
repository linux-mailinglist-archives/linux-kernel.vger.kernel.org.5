Return-Path: <linux-kernel+bounces-66072-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EED2C855641
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 23:43:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ACCE7281729
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 22:43:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEF631EEF7;
	Wed, 14 Feb 2024 22:43:01 +0000 (UTC)
Received: from 12.mo561.mail-out.ovh.net (12.mo561.mail-out.ovh.net [188.165.41.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6462A24B33
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 22:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.165.41.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707950581; cv=none; b=rUJ9SPTcigurFjhufPry+DRaJR9yNTrAL9EDlpFEoFiXvp7XbW3V6uUDsgGL+m6ndWpQ82k3bZuf2yJE4jpIzneAEjPgGOkBhj/ntUUuA51hHwkNpCcI6ECw3KHADzT1XQii2JQG6QY2RxLRM1ove0cuN8tKk+M6Ey94gEIYBUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707950581; c=relaxed/simple;
	bh=8IKT/Bb8CyKfUbAKJZcwS4WxswL0YJYeSnHUhSLM34g=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=JuumcUtBIJwuYVB1KwuUTw0te9Xuc3AHYIDuBYyy5BOK7YXy8IuJ1Dqz36oSoVg4b/jBND6RWeRzca0vCz8MyMHob5cG8whkuOcKLsd1WKtt8FDI4904q+38rFiKFWoXBmoU7cuvbu4chIoMTulhvaRDRjrUAxqjtrL0+ec7MTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=etezian.org; arc=none smtp.client-ip=188.165.41.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etezian.org
Received: from director8.ghost.mail-out.ovh.net (unknown [10.109.176.110])
	by mo561.mail-out.ovh.net (Postfix) with ESMTP id 4TZt7D56lyz1FhH
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 22:25:28 +0000 (UTC)
Received: from ghost-submission-6684bf9d7b-g6lsk (unknown [10.110.113.83])
	by director8.ghost.mail-out.ovh.net (Postfix) with ESMTPS id 5CEE21FDC1;
	Wed, 14 Feb 2024 22:25:24 +0000 (UTC)
Received: from etezian.org ([37.59.142.108])
	by ghost-submission-6684bf9d7b-g6lsk with ESMTPSA
	id kOdFN9Q9zWW2+BMA5AQA5w
	(envelope-from <andi@etezian.org>); Wed, 14 Feb 2024 22:25:24 +0000
Authentication-Results:garm.ovh; auth=pass (GARM-108S0028a4cc169-7cca-414a-93f3-2f549766b70e,
                    C0FC2E5C6A7315DD97BDDE4B9606AB6EEADB6D9F) smtp.auth=andi@etezian.org
X-OVh-ClientIp:89.217.109.169
From: Andi Shyti <andi.shyti@kernel.org>
To: Avi Fishman <avifishman70@gmail.com>, 
 Tomer Maimon <tmaimon77@gmail.com>, Tali Perry <tali.perry1@gmail.com>, 
 Patrick Venture <venture@google.com>, Nancy Yuen <yuenn@google.com>, 
 Benjamin Fair <benjaminfair@google.com>, openbmc@lists.ozlabs.org, 
 linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Rand Deeb <rand.sec96@gmail.com>
Cc: deeb.rand@confident.ru, lvc-project@linuxtesting.org, 
 voskresenski.stanislav@confident.ru
In-Reply-To: <20240206194201.10054-1-rand.sec96@gmail.com>
References: <20240206194201.10054-1-rand.sec96@gmail.com>
Subject: Re: [PATCH] i2c: Remove redundant comparison in npcm_i2c_reg_slave
Message-Id: <170794952331.4171357.5051078389218008556.b4-ty@kernel.org>
Date: Wed, 14 Feb 2024 23:25:23 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.4
X-Ovh-Tracer-Id: 4456311833711348360
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvledrudejgdduiedvucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvegjfhfukfffgggtgffosehtjeertdertdejnecuhfhrohhmpeetnhguihcuufhhhihtihcuoegrnhguihdrshhhhihtiheskhgvrhhnvghlrdhorhhgqeenucggtffrrghtthgvrhhnpeffteehudffvdfhudfgffdugfejjeduheehgeefgeeuhfeiuefghffgueffvdfgfeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppeduvdejrddtrddtrddupdekledrvddujedruddtledrudeiledpfeejrdehledrudegvddruddtkeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduvdejrddtrddtrddupdhmrghilhhfrhhomhepoegrnhguihesvghtvgiiihgrnhdrohhrgheqpdhnsggprhgtphhtthhopedupdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdfovfetjfhoshhtpehmohehiedupdhmohguvgepshhmthhpohhuth

Hi

On Tue, 06 Feb 2024 22:42:01 +0300, Rand Deeb wrote:
> In the npcm_i2c_reg_slave() function, there was a redundant
> comparison that checked if 'bus->slave' was null immediately after
> assigning it the 'client' value. There were concerns about a
> potential null dereference because of `client->adapter`, but
> according to Wolfram Sang, "we trusted ourselves here" Therefore,
> this comparison is unnecessary.
> 
> [...]

Applied to i2c/i2c-host on

git://git.kernel.org/pub/scm/linux/kernel/git/andi.shyti/linux.git

Thank you,
Andi

Patches applied
===============
[1/1] i2c: Remove redundant comparison in npcm_i2c_reg_slave
      commit: 48acf8292280f257fb0047478153a81471ee7f4d



Return-Path: <linux-kernel+bounces-121401-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 632B888E785
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 15:58:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9579C1C2D463
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 14:58:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BF2212D766;
	Wed, 27 Mar 2024 14:09:12 +0000 (UTC)
Received: from new-mail.astralinux.ru (new-mail.astralinux.ru [51.250.53.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A2305F86B;
	Wed, 27 Mar 2024 14:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.250.53.164
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711548551; cv=none; b=cQYRYItD76lYYzQ0frCWjK2el8S02l6/5Bcfe1KjsulNuGsAlCRY7ftHAVl879UVzld5hS+FYuuT6rNAC7/l560D8sFYBGE+/Ginxj19JYYqiLDke8tgdI2vA3Ii0QbylXzqe+kAfCxuRoVDnaIRjq+hzQwI7hB6BJUp477ZnDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711548551; c=relaxed/simple;
	bh=t/Kptzfy3Hum5GwewZLzVCIRt6x2ZEcgnsoW//doSQg=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:Cc:
	 In-Reply-To:Content-Type; b=XhXY7A1PIlVLG2uRznLyp2rmWTpcnPkNkQkPF1x3MWqE5xaTA1r9fKeHVJYRIl9W8xJSka+TkJKZpVEYJPrZTCWLxNUJO95aDHeemzZIbJIqSNQMRBXOsSHFp+QTVq7AyrcPWx6d4gt9IsvddH/m1dNlWsg/YvAgfNw+icekQZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=astralinux.ru; spf=pass smtp.mailfrom=astralinux.ru; arc=none smtp.client-ip=51.250.53.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=astralinux.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=astralinux.ru
Received: from [10.177.233.149] (unknown [10.177.233.149])
	by new-mail.astralinux.ru (Postfix) with ESMTPA id 4V4T6w3z3ZzqSP9;
	Wed, 27 Mar 2024 17:08:56 +0300 (MSK)
Message-ID: <7f5b99c5-4b30-4bcc-9aa3-4ac8d518f8c6@astralinux.ru>
Date: Wed, 27 Mar 2024 17:08:45 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: RuPost Desktop
Subject: Re: [lvc-project] [PATCH] net: dsa: add return value check of
 genphy_read_status()
Content-Language: ru
From: Alexandra Diupina <adiupina@astralinux.ru>
To: Florian Fainelli <f.fainelli@gmail.com>, Andrew Lunn <andrew@lunn.ch>
References: <20240314063008.11214-1-adiupina@astralinux.ru>
 <99631ba3-36f9-4eed-80d9-4a663ef46d80@lunn.ch>
 <bb752899-dbf3-4dd2-89f0-d280488bd8bf@astralinux.ru>
 <05a042d5-95fa-4eff-b2ad-c26e865837b1@gmail.com>
 <5968a30f-bf5c-47b7-be2d-71d8dd18699b@astralinux.ru>
Cc: Vladimir Oltean <olteanv@gmail.com>, lvc-project@linuxtesting.org,
 netdev@vger.kernel.org, Sebastian Reichel <sre@kernel.org>,
 linux-kernel@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 "David S. Miller" <davem@davemloft.net>
In-Reply-To: <5968a30f-bf5c-47b7-be2d-71d8dd18699b@astralinux.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DrWeb-SpamScore: -100
X-DrWeb-SpamState: legit
X-DrWeb-SpamDetail: gggruggvucftvghtrhhoucdtuddrgedvfedrvdehuddgtddvucetufdoteggodetrfcurfhrohhfihhlvgemucfftfghgfeunecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkffggfgfuhffvfhevjggtgfesthejredttderjeenucfhrhhomheptehlvgigrghnughrrgcuffhiuhhpihhnrgcuoegrughiuhhpihhnrgesrghsthhrrghlihhnuhigrdhruheqnecuggftrfgrthhtvghrnhepveetleduudeiieefleelgffgudevgfevtdduhfeiteeludeutdeguedvgeelkeejnecukfhppedutddrudejjedrvdeffedrudegleenucfrrghrrghmpehhvghloheplgdutddrudejjedrvdeffedrudeglegnpdhinhgvthepuddtrddujeejrddvfeefrddugeelmeehjeekkedvpdhmrghilhhfrhhomheprgguihhuphhinhgrsegrshhtrhgrlhhinhhugidrrhhupdhnsggprhgtphhtthhopeduuddprhgtphhtthhopehfrdhfrghinhgvlhhlihesghhmrghilhdrtghomhdprhgtphhtthhopegrnhgurhgvfieslhhunhhnrdgthhdprhgtphhtthhopeholhhtvggrnhhvsehgmhgrihhlrdgtohhmpdhrtghpthhtoheplhhvtgdqphhrohhjvggttheslhhinhhugihtvghsthhinhhgrdhorhhgpdhrtghpthhtohepnhgvthguvghvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhrvgeskhgvrhhnvghlrdhorhhgpdhrtghpth
 htoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepvgguuhhmrgiivghtsehgohhoghhlvgdrtghomhdprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgrsggvnhhisehrvgguhhgrthdrtghomhdprhgtphhtthhopegurghvvghmsegurghvvghmlhhofhhtrdhnvght
X-DrWeb-SpamVersion: Vade Retro 01.423.251#02 AS+AV+AP Profile: DRWEB; Bailout: 300
X-AntiVirus: Checked by Dr.Web [MailD: 11.1.19.2307031128, SE: 11.1.12.2210241838, Core engine: 7.00.62.01180, Virus records: 12538490, Updated: 2024-Mar-27 12:43:46 UTC]

just a friendly reminder

Alexandra



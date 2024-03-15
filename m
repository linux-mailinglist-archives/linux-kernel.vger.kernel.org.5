Return-Path: <linux-kernel+bounces-104258-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E05987CB55
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 11:26:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1EF5281AA5
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 10:26:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59CB418E27;
	Fri, 15 Mar 2024 10:26:03 +0000 (UTC)
Received: from new-mail.astralinux.ru (new-mail.astralinux.ru [51.250.53.244])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E3A618E1D;
	Fri, 15 Mar 2024 10:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.250.53.244
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710498362; cv=none; b=ZqLCR8KVy754gYhDvqFWF25OM5GHkvVC7uY+JBAtLpAjvo9U7rBziM+y+Bgo9XvPsk/VaMaCPnPUnFDO86lUtG+gd7drEc402X4soCALGGCjcmqHLbWzGavK41JEp9KOboQHkMt8R2FpJAT9dvUlnKMOeJvY7FEJSdEyNt713QM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710498362; c=relaxed/simple;
	bh=znxxTxn2sNcmnhzQDLmAO9i7+RTv/6Iv0UkoT+G+YQk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fvI5kSux8cmOTZG+ggXG+OKOQBPFkK+CxLUzFzGx1c3iPSiFRu6qPWPZK5uonH5XTw4YRTpisMaeMkev754SPE0ONe69uTumEwatU0yim5Vkzckwp98PC5Tj0APZwHu/0etpUj97PI8G38/TLgKs25hWEUi1+yy7VkQIDFRClWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=astralinux.ru; spf=pass smtp.mailfrom=astralinux.ru; arc=none smtp.client-ip=51.250.53.244
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=astralinux.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=astralinux.ru
Received: from [10.177.235.219] (unknown [10.177.235.219])
	by new-mail.astralinux.ru (Postfix) with ESMTPA id 4Tx0l10P0szyYT;
	Fri, 15 Mar 2024 13:25:48 +0300 (MSK)
Message-ID: <bb752899-dbf3-4dd2-89f0-d280488bd8bf@astralinux.ru>
Date: Fri, 15 Mar 2024 13:25:42 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: RuPost Desktop
Subject: Re: [PATCH] net: dsa: add return value check of genphy_read_status()
Content-Language: ru
To: Andrew Lunn <andrew@lunn.ch>
Cc: Florian Fainelli <f.fainelli@gmail.com>,
 Vladimir Oltean <olteanv@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Sebastian Reichel <sre@kernel.org>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
References: <20240314063008.11214-1-adiupina@astralinux.ru>
 <99631ba3-36f9-4eed-80d9-4a663ef46d80@lunn.ch>
From: =?UTF-8?B?0JDQu9C10LrRgdCw0L3QtNGA0LAg0JTRjtC/0LjQvdCw?=
 <adiupina@astralinux.ru>
In-Reply-To: <99631ba3-36f9-4eed-80d9-4a663ef46d80@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-DrWeb-SpamScore: -100
X-DrWeb-SpamState: legit
X-DrWeb-SpamDetail: gggruggvucftvghtrhhoucdtuddrgedvfedrvdehuddgtddvucetufdoteggodetrfcurfhrohhfihhlvgemucfftfghgfeunecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkffggfgfuvfevfhfhjggtgfesthekredttderjeenucfhrhhomhepteipvghktggrhhipphgrucippihnpihhrgcuoegrughiuhhpihhnrgesrghsthhrrghlihhnuhigrdhruheqnecuggftrfgrthhtvghrnhepueeijedvjeegjefhudeutdejudetteekjeethefhieehtefhkeejieethedugfejnecukfhppedutddrudejjedrvdefhedrvdduleenucfrrghrrghmpehhvghloheplgdutddrudejjedrvdefhedrvddulegnpdhinhgvthepuddtrddujeejrddvfeehrddvudelmeehtdegleegpdhmrghilhhfrhhomheprgguihhuphhinhgrsegrshhtrhgrlhhinhhugidrrhhupdhnsggprhgtphhtthhopeduuddprhgtphhtthhopegrnhgurhgvfieslhhunhhnrdgthhdprhgtphhtthhopehfrdhfrghinhgvlhhlihesghhmrghilhdrtghomhdprhgtphhtthhopeholhhtvggrnhhvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopegvughumhgriigvthesghhoohhglhgvrdgtohhmpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehprggsvghnihesrh
 gvughhrghtrdgtohhmpdhrtghpthhtohepshhrvgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepnhgvthguvghvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhvtgdqphhrohhjvggttheslhhinhhugihtvghsthhinhhgrdhorhhg
X-DrWeb-SpamVersion: Vade Retro 01.423.251#02 AS+AV+AP Profile: DRWEB; Bailout: 300
X-AntiVirus: Checked by Dr.Web [MailD: 11.1.19.2307031128, SE: 11.1.12.2210241838, Core engine: 7.00.62.01180, Virus records: 12505325, Updated: 2024-Mar-15 08:07:08 UTC]

Hello, Andrew!

The dsa_register_switch() function is used in various DSA
drivers (in probe function), so it is necessary to check all
possible errors. If the return value (may be an error code)
of genphy_read_status() is not checked in
dsa_shared_port_fixed_link_register_of(), a possible error
in dsa_register_switch() may be missed.

14/03/24 16:02, Andrew Lunn пишет:

> On Thu, Mar 14, 2024 at 09:30:08AM +0300, Alexandra Diupina wrote:
>> Need to check return value of genphy_read_status(),
>> because higher in the call hierarchy is the
>> dsa_register_switch() function,
>> which is used in various drivers.
> I don't understand the commit message. Why is it important to
> dsa_register_switch()?
>
> 	Andrew



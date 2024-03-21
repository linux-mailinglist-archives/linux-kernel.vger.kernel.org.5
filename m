Return-Path: <linux-kernel+bounces-110006-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 940578858D0
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 13:07:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4EBEF283485
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 12:07:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 783697603C;
	Thu, 21 Mar 2024 12:06:49 +0000 (UTC)
Received: from new-mail.astralinux.ru (new-mail.astralinux.ru [51.250.53.244])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5C1576C67;
	Thu, 21 Mar 2024 12:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.250.53.244
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711022809; cv=none; b=Glq5K255PYnsTXaGebzi4ELCM20swlPB8PnlowOyjhZD1ocZBPWDOueUlP4eWTnt+PlMhtVFy26u+yU76F87CqNGDlAY+zW9JCzj2Lx/7q0GyePIpw8bfW3TzIiw43rHzC/R+hAjtbwkHVg0ZdM1Gwp56KGwSwoYgVpX0iYB9+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711022809; c=relaxed/simple;
	bh=fMXrWdlgBnkT3rnzcxkUUwb/SvMNn9s7qewG8AcMhQU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fcGBLCxMukM/yPlJaG/+pvhEyT6uB8hPubr+YkUlUsr6OY4Sy6v8vSRaF1kLBRJf54VgOKO7P6H7Sh8zA8zUcih3ZPn4lCTnGH7r2FdqpomvPomUSIw+eJIr/zDTfzvPQPnzMT+wkBFEl3yEprXgsaGMMfB9+5iKuIHgkGq6LUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=astralinux.ru; spf=pass smtp.mailfrom=astralinux.ru; arc=none smtp.client-ip=51.250.53.244
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=astralinux.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=astralinux.ru
Received: from [10.177.233.158] (unknown [10.177.233.158])
	by new-mail.astralinux.ru (Postfix) with ESMTPA id 4V0khY4vL1zlVqp;
	Thu, 21 Mar 2024 15:06:37 +0300 (MSK)
Message-ID: <5968a30f-bf5c-47b7-be2d-71d8dd18699b@astralinux.ru>
Date: Thu, 21 Mar 2024 15:06:30 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: RuPost Desktop
Subject: Re: [PATCH] net: dsa: add return value check of genphy_read_status()
Content-Language: ru
To: Florian Fainelli <f.fainelli@gmail.com>, Andrew Lunn <andrew@lunn.ch>
Cc: Vladimir Oltean <olteanv@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Sebastian Reichel <sre@kernel.org>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
References: <20240314063008.11214-1-adiupina@astralinux.ru>
 <99631ba3-36f9-4eed-80d9-4a663ef46d80@lunn.ch>
 <bb752899-dbf3-4dd2-89f0-d280488bd8bf@astralinux.ru>
 <05a042d5-95fa-4eff-b2ad-c26e865837b1@gmail.com>
From: Alexandra Diupina <adiupina@astralinux.ru>
In-Reply-To: <05a042d5-95fa-4eff-b2ad-c26e865837b1@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-DrWeb-SpamScore: -100
X-DrWeb-SpamState: legit
X-DrWeb-SpamDetail: gggruggvucftvghtrhhoucdtuddrgedvfedrvdehuddgtddvucetufdoteggodetrfcurfhrohhfihhlvgemucfftfghgfeunecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkffggfgfuvfevfhfhjggtgfesthekredttderjeenucfhrhhomheptehlvgigrghnughrrgcuffhiuhhpihhnrgcuoegrughiuhhpihhnrgesrghsthhrrghlihhnuhigrdhruheqnecuggftrfgrthhtvghrnheptdekffduvefhgffhffejjefhuddthfffueeugfeuffevveeigedtudegudduueeunecukfhppedutddrudejjedrvdeffedrudehkeenucfrrghrrghmpehhvghloheplgdutddrudejjedrvdeffedrudehkegnpdhinhgvthepuddtrddujeejrddvfeefrdduheekmeehieduvddvpdhmrghilhhfrhhomheprgguihhuphhinhgrsegrshhtrhgrlhhinhhugidrrhhupdhnsggprhgtphhtthhopeduuddprhgtphhtthhopehfrdhfrghinhgvlhhlihesghhmrghilhdrtghomhdprhgtphhtthhopegrnhgurhgvfieslhhunhhnrdgthhdprhgtphhtthhopeholhhtvggrnhhvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopegvughumhgriigvthesghhoohhglhgvrdgtohhmpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehprggsvghnihesrh
 gvughhrghtrdgtohhmpdhrtghpthhtohepshhrvgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepnhgvthguvghvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhvtgdqphhrohhjvggttheslhhinhhugihtvghsthhinhhgrdhorhhg
X-DrWeb-SpamVersion: Vade Retro 01.423.251#02 AS+AV+AP Profile: DRWEB; Bailout: 300
X-AntiVirus: Checked by Dr.Web [MailD: 11.1.19.2307031128, SE: 11.1.12.2210241838, Core engine: 7.00.62.01180, Virus records: 12528158, Updated: 2024-Mar-21 10:27:40 UTC]



21/03/24 02:48, Florian Fainelli пишет:
>
>
> On 15/03/2024 03:25, Александра Дюпина wrote:
>> Hello, Andrew!
>
> (please do not top-post)
>
>>
>> The dsa_register_switch() function is used in various DSA
>> drivers (in probe function), so it is necessary to check all
>> possible errors. If the return value (may be an error code)
>> of genphy_read_status() is not checked in
>> dsa_shared_port_fixed_link_register_of(), a possible error
>> in dsa_register_switch() may be missed.
>
> This is not a path that will fail, because the fixed PHY emulation 
> layer is not a real piece of hardware, therefore no MDIO read could 
> really cause a problem here. I don't have a strong opinion however if 
> you want to propagate it properly.

Hi, Florian!
I would like to make sure that I have understood you correctly. Checking 
the return value of genphy_read_status() in 
dsa_shared_port_fixed_link_register_of() is not needed because 
dsa_shared_port_fixed_link_register_of() is called if 
of_phy_is_fixed_link()==true (this means that the PHY emulation layer is 
used, link is registered by of_phy_register_fixed_link() without errors 
and therefore there cannot be an error in genphy_read_status()). Right?


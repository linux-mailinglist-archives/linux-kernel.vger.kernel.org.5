Return-Path: <linux-kernel+bounces-167317-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D26968BA7C0
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 09:28:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F599281BAA
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 07:28:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD5B1146D57;
	Fri,  3 May 2024 07:28:08 +0000 (UTC)
Received: from 12.mo583.mail-out.ovh.net (12.mo583.mail-out.ovh.net [46.105.39.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7D24139593
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 07:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.105.39.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714721288; cv=none; b=XgWXv1hPGCD1mdbWs2SRbakfiKFYWgcqahnPV6p2+ZLrvMd7cw6rxPJ1bllM9+7woz/yF24Q8dLTJy1wauHeqDSHX54nGXzTRIMq8xxv79WdpYnErdVHDXrRwUETMfkA28xG32mPuXxpKEg3MSLQByqIEZksyYhmBgsV5Rwau3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714721288; c=relaxed/simple;
	bh=O9dHTfqdUKYqYcEkVxGpE1PpwlajnvKSe2uB3eZESzc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=TMOQYg7N4j87s92bl0ruwa039/SACWk8BEPNOpr5NF1Cre8M9xvicdSe7AkiecgcNjuxJEJ8ZM+UOSJ0L10p8WBh037v+aAhYSL+yFcQxAU6oP3HP11erbGU0Khr64W3zvNw2ZFeC2SQ2t7tiH9iMGILKmlQApKHh+sV4Rqler4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=etezian.org; arc=none smtp.client-ip=46.105.39.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etezian.org
Received: from director3.ghost.mail-out.ovh.net (unknown [10.108.2.118])
	by mo583.mail-out.ovh.net (Postfix) with ESMTP id 4VVqPg5frzz1QjG
	for <linux-kernel@vger.kernel.org>; Thu,  2 May 2024 23:09:11 +0000 (UTC)
Received: from ghost-submission-6684bf9d7b-b6h52 (unknown [10.108.42.39])
	by director3.ghost.mail-out.ovh.net (Postfix) with ESMTPS id A17F91FDF8;
	Thu,  2 May 2024 23:09:06 +0000 (UTC)
Received: from etezian.org ([37.59.142.105])
	by ghost-submission-6684bf9d7b-b6h52 with ESMTPSA
	id 8ifaEBIdNGZnZx8AitxrAg
	(envelope-from <andi@etezian.org>); Thu, 02 May 2024 23:09:06 +0000
Authentication-Results:garm.ovh; auth=pass (GARM-105G006ccf2312c-b8e8-4f3e-a551-11cf7daafa4c,
                    C3C300A9F266149161DCD69BC7DE92F4F10D7925) smtp.auth=andi@etezian.org
X-OVh-ClientIp:89.217.109.169
From: Andi Shyti <andi.shyti@kernel.org>
To: linux-kernel@vger.kernel.org, 
 Florian Fainelli <florian.fainelli@broadcom.com>
Cc: Jarkko Nikula <jarkko.nikula@linux.intel.com>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Mika Westerberg <mika.westerberg@linux.intel.com>, 
 Jan Dabros <jsd@semihalf.com>, Lee Jones <lee@kernel.org>, 
 Jiawen Wu <jiawenwu@trustnetic.com>, 
 Mengyuan Lou <mengyuanlou@net-swift.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>, 
 Andrew Lunn <andrew@lunn.ch>, Duanqiang Wen <duanqiangwen@net-swift.com>, 
 linux-i2c@vger.kernel.org, netdev@vger.kernel.org
In-Reply-To: <20240425214438.2100534-1-florian.fainelli@broadcom.com>
References: <20240425214438.2100534-1-florian.fainelli@broadcom.com>
Subject: Re: (subset) [PATCH v3 0/5] Define i2c_designware in a header file
Message-Id: <171469134545.1016503.10207141192762647093.b4-ty@kernel.org>
Date: Fri, 03 May 2024 01:09:05 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0
X-Ovh-Tracer-Id: 2096144151853337100
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvledrvdduledgudelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvegjfhfukfffgggtgffosehtjeertdertdejnecuhfhrohhmpeetnhguihcuufhhhihtihcuoegrnhguihdrshhhhihtiheskhgvrhhnvghlrdhorhhgqeenucggtffrrghtthgvrhhnpeffteehudffvdfhudfgffdugfejjeduheehgeefgeeuhfeiuefghffgueffvdfgfeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppeduvdejrddtrddtrddupdekledrvddujedruddtledrudeiledpfeejrdehledrudegvddruddtheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduvdejrddtrddtrddupdhmrghilhhfrhhomheprghnughisegvthgviihirghnrdhorhhgpdhnsggprhgtphhtthhopedupdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdfovfetjfhoshhtpehmohehkeefpdhmohguvgepshhmthhpohhuth

Hi

On Thu, 25 Apr 2024 14:44:33 -0700, Florian Fainelli wrote:
> This patch series depends upon the following two patches being applied:
> 
> https://lore.kernel.org/all/20240422084109.3201-1-duanqiangwen@net-swift.com/
> https://lore.kernel.org/all/20240422084109.3201-2-duanqiangwen@net-swift.com/
> 
> There is no reason why each driver should have to repeat the
> "i2c_designware" string all over the place, because when that happens we
> see the reverts like the above being necessary.
> 
> [...]

Applied to i2c/i2c-host on

git://git.kernel.org/pub/scm/linux/kernel/git/andi.shyti/linux.git

Thank you,
Andi

Patches applied
===============
[1/5] i2c: designware: Replace MODULE_ALIAS() with MODULE_DEVICE_TABLE()
      commit: 91647e64f0f5677ace84165dc25dc99579147b8f
[2/5] i2c: designware: Create shared header hosting driver name
      commit: 856cd5f13de7cebca44db5ff4bc2ca73490dd8d7



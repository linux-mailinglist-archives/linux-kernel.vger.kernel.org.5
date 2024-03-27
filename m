Return-Path: <linux-kernel+bounces-122104-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D00D88F1ED
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 23:33:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B7381C2FAA0
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 22:33:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94E26152E1B;
	Wed, 27 Mar 2024 22:33:20 +0000 (UTC)
Received: from 2.mo560.mail-out.ovh.net (2.mo560.mail-out.ovh.net [188.165.53.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E0932376A
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 22:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.165.53.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711578800; cv=none; b=cy+GARi5Mww0LMApk44CAiL4LS4h1djFU4B1/Bsl6xI2yJ13sXiqtJqazxI+quVIl9yJE/XOhwrSXu41R/6YSq91ghYHOc56vijdvS6uC3NlSmoqFFr6MPSMJ1/HDdQBEGaKhFgdYDwWrhsqFiq3K8WyN+H1VmZ2XjxGMPF6/e4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711578800; c=relaxed/simple;
	bh=uubMJfEGsx1wHMfNv8O85cjpX0Z4oxTc9ge4GrdhcKE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O3qVHDR52x3cNqCevnhfZjJHePaqsQSQNoI9T3otS0UD7rimozn59lDOy8V2nk82q/U2IowM7qBdwCw6KIbxQrq1QOGaDrrnS/l8sj1Ues/zgHhTrrX2RsJOogV79EW7WDEJQNBE9GyhRVl+9rw9GlJrC0yVrgx7h60u8xc9zRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=milecki.pl; spf=pass smtp.mailfrom=milecki.pl; arc=none smtp.client-ip=188.165.53.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=milecki.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=milecki.pl
Received: from director9.ghost.mail-out.ovh.net (unknown [10.109.176.162])
	by mo560.mail-out.ovh.net (Postfix) with ESMTP id 4V4gvv0d45z1JMc
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 22:15:07 +0000 (UTC)
Received: from ghost-submission-6684bf9d7b-xfkn4 (unknown [10.110.178.52])
	by director9.ghost.mail-out.ovh.net (Postfix) with ESMTPS id E1CF91FD2C;
	Wed, 27 Mar 2024 22:15:03 +0000 (UTC)
Received: from milecki.pl ([37.59.142.107])
	by ghost-submission-6684bf9d7b-xfkn4 with ESMTPSA
	id gjE7MWeaBGY6QxIAbVqslg
	(envelope-from <rafal@milecki.pl>); Wed, 27 Mar 2024 22:15:03 +0000
Authentication-Results:garm.ovh; auth=pass (GARM-107S0012491a7f4-335c-4194-8bbd-5f1ada98fd90,
                    AD8588E3BB83D84E59DEA8CE8674EAB20989D6B2) smtp.auth=rafal@milecki.pl
X-OVh-ClientIp:31.11.218.106
Message-ID: <30bc0d38-b610-4397-ba42-46819d5507fc@milecki.pl>
Date: Wed, 27 Mar 2024 23:15:02 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] mtd: limit OTP NVMEM Cell parse to non Nand devices
Content-Language: en-US
To: Christian Marangi <ansuelsmth@gmail.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Claudiu Beznea <claudiu.beznea@tuxon.dev>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
References: <20240322040951.16680-1-ansuelsmth@gmail.com>
From: =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
In-Reply-To: <20240322040951.16680-1-ansuelsmth@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 11126987304968301369
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvledrudduiedgudefgecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkffggfgfuvfevfhfhjggtgfesthejredttddvjeenucfhrhhomheptfgrfhgrlhcuofhilhgvtghkihcuoehrrghfrghlsehmihhlvggtkhhirdhplheqnecuggftrfgrthhtvghrnhepgeekvdfgleeuteeludfghfduvdffjeekhfehteefvefggeelheeludeuiedvueejnecukfhppeduvdejrddtrddtrddupdefuddruddurddvudekrddutdeipdefjedrheelrddugedvrddutdejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepuddvjedrtddrtddruddpmhgrihhlfhhrohhmpehrrghfrghlsehmihhlvggtkhhirdhplhdpnhgspghrtghpthhtohepuddprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdpoffvtefjohhsthepmhhoheeitddpmhhouggvpehsmhhtphhouhht

On 22.03.2024 05:09, Christian Marangi wrote:
> diff --git a/drivers/mtd/mtdcore.c b/drivers/mtd/mtdcore.c
> index 5887feb347a4..0de87bc63840 100644
> --- a/drivers/mtd/mtdcore.c
> +++ b/drivers/mtd/mtdcore.c
> @@ -900,7 +900,7 @@ static struct nvmem_device *mtd_otp_nvmem_register(struct mtd_info *mtd,
>   	config.name = compatible;
>   	config.id = NVMEM_DEVID_AUTO;
>   	config.owner = THIS_MODULE;
> -	config.add_legacy_fixed_of_cells = true;
> +	config.add_legacy_fixed_of_cells = !mtd_type_is_nand(mtd);
>   	config.type = NVMEM_TYPE_OTP;
>   	config.root_only = true;
>   	config.ignore_wp = true;

I think there may be even more unwanted behaviour here. If
mtd_otp_nvmem_register() fails to find node with "user-otp" /
"factory-otp" compatible then it sets "config.of_node" to NULL but that
means NVMEM core still looks for NVMEM cells in device's "of_node".

I believe we should not look for OTP NVMEM cells out of the "user-otp" /
"factory-otp" compatible nodes.

So maybe what we need in the first place is just:
config.add_legacy_fixed_of_cells = !!np;
?

Any extra limitation of .add_legacy_fixed_of_cells should probably be
used only if we want to prevent new users of the legacy syntax. The
problem is that mtd.yaml binding allowed "user-otp" and "factory-otp"
with old syntax cells. It means every MTD device was allowed to have
them.

No in-kernel DTS even used "user-otp" or "factory-otp" with NVMEM legacy
cells but I'm not sure about downstream DTS files. Ideally we would do
config.add_legacy_fixed_of_cells = false;
but that could break compatibility with some downstream DTS files.


Return-Path: <linux-kernel+bounces-45946-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6101D84383B
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 08:49:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D1341C21671
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 07:49:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 978205578D;
	Wed, 31 Jan 2024 07:49:08 +0000 (UTC)
Received: from smtpout6.mo539.mail-out.ovh.net (smtpout6.mo539.mail-out.ovh.net [51.210.91.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 004A050A7C;
	Wed, 31 Jan 2024 07:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.210.91.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706687348; cv=none; b=asuR/yBt8YfDb227eoGzM0I8xkqf30KVIvLy/Q//9i96Ul9aVkLvJX9ysHeOdRk/v2c8a5z6lhAHe3lfjMAUOkA7VBzdzu/9aKx+DiUriVpcw6lZm1ERc0MkQ+1ZgCIqnbJtlr2/2CVCMp1E/LfHcDTJ22xJ6VMedwfGBSxMsSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706687348; c=relaxed/simple;
	bh=Hw13MPJ3GhSveA/QB4xi4k5QM0dv0Kf9dUeEqT6svb4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=uLCHW4JSWnznR5WTP0GHv2xDUjbLiMlV8c5WSR9X6qwwEa+X4uxjXWwny6pWweSUvIGToOKbNRuUxCxq20e67i60osOhJ2ToP2mP58nxp0L6s6evPbiefZtFgkxCXDRy6yHxkwoStvZpp12L2MmatJkIaBbuQFQ0k1kokMIIzzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=traphandler.com; spf=pass smtp.mailfrom=traphandler.com; arc=none smtp.client-ip=51.210.91.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=traphandler.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=traphandler.com
Received: from director3.derp.mail-out.ovh.net (director3.derp.mail-out.ovh.net [152.228.215.222])
	by mo539.mail-out.ovh.net (Postfix) with ESMTPS id AD7801FF90;
	Wed, 31 Jan 2024 07:39:02 +0000 (UTC)
Received: from director3.derp.mail-out.ovh.net (director3.derp.mail-out.ovh.net. [127.0.0.1])
        by director3.derp.mail-out.ovh.net (inspect_sender_mail_agent) with SMTP
        for <lee@kernel.org>; Wed, 31 Jan 2024 07:39:02 +0000 (UTC)
Received: from pro2.mail.ovh.net (unknown [10.109.140.67])
	by director3.derp.mail-out.ovh.net (Postfix) with ESMTPS id 65D30101836;
	Wed, 31 Jan 2024 07:39:02 +0000 (UTC)
Received: from [192.168.1.15] (88.161.25.233) by DAG1EX1.emp2.local
 (172.16.2.1) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 31 Jan
 2024 08:39:01 +0100
Message-ID: <05f9c78d-b398-420e-bc0f-fb642e76efdc@traphandler.com>
Date: Wed, 31 Jan 2024 08:39:01 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] leds: rgb: leds-group-multicolor: allow leds to stay
 on in suspend
To: Aren Moynihan <aren@peacevolution.org>, <linux-kernel@vger.kernel.org>
CC: Miles Alan <m@milesalan.com>, Ondrej Jirman <megi@xff.cz>, Lee Jones
	<lee@kernel.org>, Pavel Machek <pavel@ucw.cz>, <linux-leds@vger.kernel.org>
References: <20240128204740.2355092-1-aren@peacevolution.org>
Content-Language: en-US
From: Jean-Jacques Hiblot <jjhiblot@traphandler.com>
In-Reply-To: <20240128204740.2355092-1-aren@peacevolution.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DAG2EX1.emp2.local (172.16.2.11) To DAG1EX1.emp2.local
 (172.16.2.1)
X-Ovh-Tracer-Id: 17948533367631264241
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvkedrfedtkedguddtkecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkffggfgfuvfevfhfhjggtgfhisehtjeertddtvdejnecuhfhrohhmpeflvggrnhdqlfgrtghquhgvshcujfhisghlohhtuceojhhjhhhisghlohhtsehtrhgrphhhrghnughlvghrrdgtohhmqeenucggtffrrghtthgvrhhnpefhfffgtdffvdelheejhfdtfeeklefhheeghfffueeggfdukedtfeefteelleekgfenucfkphepuddvjedrtddrtddruddpkeekrdduiedurddvhedrvdeffeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduvdejrddtrddtrddupdhmrghilhhfrhhomhepoehjjhhhihgslhhothesthhrrghphhgrnhgulhgvrhdrtghomheqpdhnsggprhgtphhtthhopedupdhrtghpthhtoheplhgvvgeskhgvrhhnvghlrdhorhhgpdhmsehmihhlvghsrghlrghnrdgtohhmpdgrrhgvnhesphgvrggtvghvohhluhhtihhonhdrohhrghdpphgrvhgvlhesuhgtfidrtgiipdhlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdplhhinhhugidqlhgvughssehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmvghgihesgihffhdrtgiipdfovfetjfhoshhtpehmohehfeelpdhmohguvg
 epshhmthhpohhuth



On 28/01/2024 21:45, Aren Moynihan wrote:
> If none of the managed leds enable LED_CORE_SUSPENDRESUME, then we
> shouldn't need to set it here. This makes it possible to use multicolor
> groups with gpio leds that enable retain-state-suspended in the device
> tree.
> 
> Signed-off-by: Aren Moynihan <aren@peacevolution.org>
> ---
> 
>   drivers/leds/rgb/leds-group-multicolor.c | 8 ++++++--
>   1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/leds/rgb/leds-group-multicolor.c b/drivers/leds/rgb/leds-group-multicolor.c
> index 39f58be32af5..194c6a33640b 100644
> --- a/drivers/leds/rgb/leds-group-multicolor.c
> +++ b/drivers/leds/rgb/leds-group-multicolor.c
> @@ -69,7 +69,7 @@ static int leds_gmc_probe(struct platform_device *pdev)
>   	struct mc_subled *subled;
>   	struct leds_multicolor *priv;
>   	unsigned int max_brightness = 0;
> -	int i, ret, count = 0;
> +	int i, ret, count, common_flags = 0;

count is not initialized anymore. Isn't it a problem ?
>   
>   	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
>   	if (!priv)
> @@ -91,6 +91,7 @@ static int leds_gmc_probe(struct platform_device *pdev)
>   		if (!priv->monochromatics)
>   			return -ENOMEM;
>   
> +		common_flags |= led_cdev->flags;
>   		priv->monochromatics[count] = led_cdev;
>   
>   		max_brightness = max(max_brightness, led_cdev->max_brightness);
> @@ -114,12 +115,15 @@ static int leds_gmc_probe(struct platform_device *pdev)
>   
>   	/* Initialise the multicolor's LED class device */
>   	cdev = &priv->mc_cdev.led_cdev;
> -	cdev->flags = LED_CORE_SUSPENDRESUME;
>   	cdev->brightness_set_blocking = leds_gmc_set;
>   	cdev->max_brightness = max_brightness;
>   	cdev->color = LED_COLOR_ID_MULTI;
>   	priv->mc_cdev.num_colors = count;
>   
> +	/* we only need suspend/resume if a sub-led requests it */
> +	if (common_flags & LED_CORE_SUSPENDRESUME)
> +		cdev->flags = LED_CORE_SUSPENDRESUME;
> +
>   	init_data.fwnode = dev_fwnode(dev);
>   	ret = devm_led_classdev_multicolor_register_ext(dev, &priv->mc_cdev, &init_data);
>   	if (ret)


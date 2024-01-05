Return-Path: <linux-kernel+bounces-17542-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D9529824F1D
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 08:19:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC35E1C22503
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 07:19:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 875D41EB35;
	Fri,  5 Jan 2024 07:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="V68hIClb"
X-Original-To: linux-kernel@vger.kernel.org
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A6CE1DDDC;
	Fri,  5 Jan 2024 07:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4057JKiM065605;
	Fri, 5 Jan 2024 01:19:20 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1704439160;
	bh=nnbd4NNKlxIwd09RppD3PPXEsR2CI47y98ZUeI58Kjg=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=V68hIClb9NB4iTuZkakfWhO8/vk5DBlJFqTiIrE81l6Wq1Yqdz/8UMF4SZvLXzMFv
	 OmpdS2yScv8n8DnYQY5SZmPYUtx/LYrdLkoBTvoYIvDPoBDjcIOkMuiZ76ARG64A1j
	 tcbGQKQOEpVLh/pUZq4i3FKfgsjIKsIg2TwmtuFA=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4057JKaU013603
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 5 Jan 2024 01:19:20 -0600
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 5
 Jan 2024 01:19:20 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 5 Jan 2024 01:19:20 -0600
Received: from [10.249.132.18] ([10.249.132.18])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4057JF5I023483;
	Fri, 5 Jan 2024 01:19:16 -0600
Message-ID: <e08d7240-6b28-43c4-9ce4-95a041bfad25@ti.com>
Date: Fri, 5 Jan 2024 12:49:14 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: can: Add support for aliases in CAN
Content-Language: en-US
To: Simon Horman <horms@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-can@vger.kernel.org>, <mailhol.vincent@wanadoo.fr>,
        <rcsekar@samsung.com>, <pabeni@redhat.com>, <kuba@kernel.org>,
        <edumazet@google.com>, <davem@davemloft.net>, <mkl@pengutronix.de>,
        <wg@grandegger.com>, <vigneshr@ti.com>, <u-kumar1@ti.com>
References: <20240102102949.138607-1-b-kapoor@ti.com>
 <20240104171940.GI31813@kernel.org>
From: Bhavya Kapoor <b-kapoor@ti.com>
In-Reply-To: <20240104171940.GI31813@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180


On 04/01/24 22:49, Simon Horman wrote:
> On Tue, Jan 02, 2024 at 03:59:49PM +0530, Bhavya Kapoor wrote:
>> When multiple CAN's are present, then names that are getting assigned
>> changes after every boot even after providing alias in the device tree.
>> Thus, Add support for implementing CAN aliasing so that names or
>> alias for CAN will now be provided from device tree.
>>
>> Signed-off-by: Bhavya Kapoor <b-kapoor@ti.com>
> Hi Bhavya,
>
> some minor feedback from my side.
>
> ...
>
>> diff --git a/drivers/net/can/dev/dev.c b/drivers/net/can/dev/dev.c
>> index 3a3be5cdfc1f..ed483c23ec79 100644
>> --- a/drivers/net/can/dev/dev.c
>> +++ b/drivers/net/can/dev/dev.c
>> @@ -247,12 +247,14 @@ void can_setup(struct net_device *dev)
>>  
>>  /* Allocate and setup space for the CAN network device */
>>  struct net_device *alloc_candev_mqs(int sizeof_priv, unsigned int echo_skb_max,
>> -				    unsigned int txqs, unsigned int rxqs)
>> +					unsigned int txqs, unsigned int rxqs,
>> +					struct device *candev)
>>  {
>>  	struct can_ml_priv *can_ml;
>>  	struct net_device *dev;
>>  	struct can_priv *priv;
>> -	int size;
>> +	int size, aliasid;
>> +	char devname[6] = "can%d";
> nit: Please consider arranging local variables in Networking code
>      in reverse xmas tree order - longest line to shortest.
Okay, i will keep this in mind from next time.
>
>>  
>>  	/* We put the driver's priv, the CAN mid layer priv and the
>>  	 * echo skb into the netdevice's priv. The memory layout for
>> @@ -273,7 +275,14 @@ struct net_device *alloc_candev_mqs(int sizeof_priv, unsigned int echo_skb_max,
>>  		size = ALIGN(size, sizeof(struct sk_buff *)) +
>>  			echo_skb_max * sizeof(struct sk_buff *);
>>  
>> -	dev = alloc_netdev_mqs(size, "can%d", NET_NAME_UNKNOWN, can_setup,
>> +	if (candev) {
>> +		aliasid = of_alias_get_id(candev->of_node, "can");
>> +		if (aliasid >= 0)
>> +			snprintf(devname, sizeof(devname), "%s%d", "can", aliasid);
> The size of devname is 6 bytes (can%d\0).
> This means that snprintf() will truncate devname if alias is greater than 99.
> Is this a concern?

When sequential naming will be done from can0 in aliases for can, 

considering that 99 is still a very large number and so 6 bytes for

devname should suffice.

Regards

> If so, perhaps devname could be declared to be IFNAMSIZ bytes long?
>
> Flagged by gcc-13 -Wformat-truncation
>
>> +	}
>> +	dev_dbg(candev, "Name of CAN assigned is : %s\n", devname);
>> +
>> +	dev = alloc_netdev_mqs(size, devname, NET_NAME_UNKNOWN, can_setup,
>>  			       txqs, rxqs);
>>  	if (!dev)
>>  		return NULL;
> ...


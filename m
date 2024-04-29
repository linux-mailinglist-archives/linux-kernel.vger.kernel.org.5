Return-Path: <linux-kernel+bounces-161759-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C59718B50D5
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 07:55:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 734E41F2202B
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 05:55:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B4ACEAFA;
	Mon, 29 Apr 2024 05:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="w9+EPYWQ"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 997D7DDD8;
	Mon, 29 Apr 2024 05:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714370104; cv=none; b=HrIdWDSeoJe+YXeCJzbrdJCKnnglBsVNR8mZAO2FRR8UMIsUfad+De2tRkSDR7IFh25ai1UwFq77qqS6X1OxzdjIJA7Jl7ULrbKLiAs1gdJyySALWZHM+QqRhh2auSiZOee9qdgg3n3YOOdyLEp1XFb7j5k1Pk0yzwZ8yTWczNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714370104; c=relaxed/simple;
	bh=B/8yaOKjqm4lDksZDUxYpsKoDBodUyrAGmiPUBu0eq8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=FcNKF+ueXNakm4DpS4za8oO071WDj2py2B3Z4G6pa7tkUVJOL0IGKAnSfDhPIhsSDhhnV9CjQtMoRvpiUgWLtrTI/rc5o4CutUIoYgSeX9pq3tYnrYSHxDsexvTkvXllYn5kOyQS6gpnHJw36140PmaaF7M4AQWR3DNcasdnHwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=w9+EPYWQ; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 43T5s82Q052960;
	Mon, 29 Apr 2024 00:54:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1714370048;
	bh=9z+5mrcooFlbXR+nO+DTW5Jb0Y5LWwkCd9vReQSQTeA=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=w9+EPYWQ6GGF8dZ+J2fGTL2TArMBiqkkvdCS/SdNjSfGehyDyEIIFNgydFTJ5qJn9
	 wqtCy7lD4trk/O+Tf+u6Qi9wLdqvlxsH/lmf6DShIvU6XOeqy+AkL6NI6eiNUrZKEZ
	 AhWTL7a7MLqN3lh7Bxu9KDN8HIyTD2beCNDboNnI=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 43T5s873114950
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 29 Apr 2024 00:54:08 -0500
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 29
 Apr 2024 00:54:08 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 29 Apr 2024 00:54:08 -0500
Received: from [10.24.69.25] (danish-tpc.dhcp.ti.com [10.24.69.25])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 43T5s2m5029844;
	Mon, 29 Apr 2024 00:54:03 -0500
Message-ID: <c138f315-ed9d-4c10-b9b6-e88cc3ec5e8c@ti.com>
Date: Mon, 29 Apr 2024 11:24:02 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: ti: icssg_prueth: Add SW TX / RX Coalescing
 based on hrtimers
Content-Language: en-US
To: Simon Horman <horms@kernel.org>
CC: Dan Carpenter <dan.carpenter@linaro.org>,
        Heiner Kallweit
	<hkallweit1@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
        Jan Kiszka
	<jan.kiszka@siemens.com>,
        Diogo Ivo <diogo.ivo@siemens.com>, Paolo Abeni
	<pabeni@redhat.com>,
        Jakub Kicinski <kuba@kernel.org>, Eric Dumazet
	<edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>,
        Vignesh Raghavendra
	<vigneshr@ti.com>, <r-gunasekaran@ti.com>,
        Roger Quadros <rogerq@kernel.org>
References: <20240424091823.1814136-1-danishanwar@ti.com>
 <20240427134120.GJ516117@kernel.org>
From: MD Danish Anwar <danishanwar@ti.com>
In-Reply-To: <20240427134120.GJ516117@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180



On 27/04/24 7:11 pm, Simon Horman wrote:
> On Wed, Apr 24, 2024 at 02:48:23PM +0530, MD Danish Anwar wrote:
>> Add SW IRQ coalescing based on hrtimers for RX and TX data path for ICSSG
>> driver, which can be enabled by ethtool commands:
>>
>> - RX coalescing
>>   ethtool -C eth1 rx-usecs 50
>>
>> - TX coalescing can be enabled per TX queue
>>
>>   - by default enables coalesing for TX0
>>   ethtool -C eth1 tx-usecs 50
>>   - configure TX0
>>   ethtool -Q eth0 queue_mask 1 --coalesce tx-usecs 100
>>   - configure TX1
>>   ethtool -Q eth0 queue_mask 2 --coalesce tx-usecs 100
>>   - configure TX0 and TX1
>>   ethtool -Q eth0 queue_mask 3 --coalesce tx-usecs 100 --coalesce
>> tx-usecs 100
>>
>> Minimum value for both rx-usecs and tx-usecs is 20us.
>>
>> Comapared to gro_flush_timeout and napi_defer_hard_irqs this patch
> 
> nit: Compared
> 
>> allows to enable IRQ coalescing for RX path separately.
>>
>> Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
> 
> ...
> 
>> @@ -190,19 +191,35 @@ int emac_tx_complete_packets(struct prueth_emac *emac, int chn,
>>  	return num_tx;
>>  }
>>  
>> +static enum hrtimer_restart emac_tx_timer_callback(struct hrtimer *timer)
>> +{
>> +	struct prueth_tx_chn *tx_chns =
>> +			container_of(timer, struct prueth_tx_chn, tx_hrtimer);
>> +
>> +	enable_irq(tx_chns->irq);
>> +	return HRTIMER_NORESTART;
>> +}
>> +
>>  static int emac_napi_tx_poll(struct napi_struct *napi_tx, int budget)
>>  {
>>  	struct prueth_tx_chn *tx_chn = prueth_napi_to_tx_chn(napi_tx);
>>  	struct prueth_emac *emac = tx_chn->emac;
>> +	bool tdown = false;
>>  	int num_tx_packets;
>>  
>> -	num_tx_packets = emac_tx_complete_packets(emac, tx_chn->id, budget);
>> +	num_tx_packets = emac_tx_complete_packets(emac, tx_chn->id, budget, &tdown);
> 
> Please consider limiting lines to 80 columns wide in Networking code.
> 
>>  
>>  	if (num_tx_packets >= budget)
>>  		return budget;
>>  
>> -	if (napi_complete_done(napi_tx, num_tx_packets))
>> -		enable_irq(tx_chn->irq);
>> +	if (napi_complete_done(napi_tx, num_tx_packets)) {
>> +		if (unlikely(tx_chn->tx_pace_timeout_ns && !tdown))
>> +			hrtimer_start(&tx_chn->tx_hrtimer,
>> +				      ns_to_ktime(tx_chn->tx_pace_timeout_ns),
>> +				      HRTIMER_MODE_REL_PINNED);
>> +		else
>> +			enable_irq(tx_chn->irq);
>> +	}
>>  
>>  	return num_tx_packets;
>>  }
> 
> ...
> 
>> @@ -870,7 +889,12 @@ int emac_napi_rx_poll(struct napi_struct *napi_rx, int budget)
>>  	}
>>  
>>  	if (num_rx < budget && napi_complete_done(napi_rx, num_rx))
>> -		enable_irq(emac->rx_chns.irq[rx_flow]);
>> +		if (unlikely(emac->rx_pace_timeout_ns))
>> +			hrtimer_start(&emac->rx_hrtimer,
>> +				      ns_to_ktime(emac->rx_pace_timeout_ns),
>> +				      HRTIMER_MODE_REL_PINNED);
>> +		else
>> +			enable_irq(emac->rx_chns.irq[rx_flow]);
> 
> clang-18 and gcc-13 both complain about the if/else logic above.
> I think it would be best to add {} to the outer if statement.
> 
>>  
>>  	return num_rx;
>>  }
> 
> ...

Sure Simon, I'll fix all this and send v2.

-- 
Thanks and Regards,
Danish


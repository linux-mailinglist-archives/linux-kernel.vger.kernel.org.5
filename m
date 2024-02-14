Return-Path: <linux-kernel+bounces-66027-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9273B85558E
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 23:08:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 345DDB25EBD
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 22:08:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A125141991;
	Wed, 14 Feb 2024 22:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.net header.i=@posteo.net header.b="keCfEwEU"
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5235513EFFE
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 22:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707948488; cv=none; b=uIwoA6zjUPEopTW3BhzAmMyOTaP/safMiUZQ7cnoENT3VCIxWOET23/fq9RB8kWYfpm+6zuntm9nFXwj9sB0DFekj5ND14JaHmsoBwzKqJkcsOq7m0YzuVqisqhl+52AU6rS3L4MBdEA14TqjnorsNv2ras95YZt5mltjeDXV58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707948488; c=relaxed/simple;
	bh=kk0R2G/YjOd1hA/HNk8g9v7ksPlfTh04eDSOWoYDd4o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n/ZFw9sbB6SlPvwaC68lOl6HSdcMLV9wJlqTKeHihk+wNWiY7qgshOGHYA4WRZ7/7uBuPzBKm/pvAlmNV2NKEGZ3utIPtfrZ7AuxBVUpIyWUKOewhmVaN9S3jXy7M5FUSev3cFLmppuDIKUWzFRJbfVN/Nsg50b+yL7gwDgYrxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net; spf=pass smtp.mailfrom=posteo.net; dkim=pass (2048-bit key) header.d=posteo.net header.i=@posteo.net header.b=keCfEwEU; arc=none smtp.client-ip=185.67.36.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.net
Received: from submission (posteo.de [185.67.36.169]) 
	by mout01.posteo.de (Postfix) with ESMTPS id 2FA24240027
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 23:08:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
	t=1707948483; bh=kk0R2G/YjOd1hA/HNk8g9v7ksPlfTh04eDSOWoYDd4o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:Content-Type:
	 Content-Transfer-Encoding:From;
	b=keCfEwEUTqi9U1Dca/BJAbvJ1nX7aqfiHGg0EGaORv53DgUimF6H73hNxPpc6zKcq
	 g9PbWwK9+GJVrZWQ8LxgsBQGQ45xVFXrana687MEL6WkxN9GeAx/Pqxq6yOId5BPpZ
	 5nI9CFoV+bQhL7ZtQgKZVjKueicY8NPzE20jUvmqPq/T+erdIUjGLZh3cgqFvLU9va
	 Fmu3E249bcADfo/ueZ+Eay1xDOupsm3Qa5uNSSHD5WYJTWpxMyMOPEHksnGJbsrom8
	 RQp1YKcaQ8liKkpVo1kZKLsrnR5f7fv8BhWAlyE6bZmCG/8n/ZHB7uUlcICjP8RivL
	 Y7LsGWc6lRW8A==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4TZsl33Bl6z9rxG;
	Wed, 14 Feb 2024 23:07:59 +0100 (CET)
Message-ID: <867da21e-7f30-4caf-9f78-260d426e4186@posteo.net>
Date: Wed, 14 Feb 2024 22:07:58 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] net: stmmac: xgmac: fix initializer element is not
 constant error
To: Jacob Keller <jacob.e.keller@intel.com>, linux-kernel@vger.kernel.org
Cc: alexandre.torgue@foss.st.com, joabreu@synopsys.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 mcoquelin.stm32@gmail.com, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org
References: <20240212154319.907447-1-shiftee@posteo.net>
 <44c29a45-86fa-4e41-b4b5-e69187f0712e@intel.com>
Content-Language: en-US
From: Mark O'Donovan <shiftee@posteo.net>
In-Reply-To: <44c29a45-86fa-4e41-b4b5-e69187f0712e@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 14/02/2024 20:31, Jacob Keller wrote:
> 
> 
> On 2/12/2024 7:43 AM, Mark O'Donovan wrote:
>> GCC prior to 8.x gives an "initializer element is not constant"
>> error for the uses of dpp_tx_err in dwxgmac3_dma_dpp_errors.
>> Newer compilers accept either version.
>>
>> More info here:
>> https://lore.kernel.org/all/20240103-fix-bq24190_charger-vbus_desc-non-const-v1-1-115ddf798c70@kernel.org
>>
>> Signed-off-by: Mark O'Donovan <shiftee@posteo.net>
>> ---
> 
> I'm not sure whether the Linux kernel project has an explicit cutoff for
> what versions of GCC (or other compilers) are supported. GCC 8 was first
> released in 2018.
> 
> The fix provided here is fairly straight forward, and while I do think
> the benefit of using builtin types vs using the macros is nice, I don't
> see that as a strong enough reason to hold up supporting the older compiler.
> 
> Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
> 
>>   drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
>> index 323c57f03c93..c02c035b81c0 100644
>> --- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
>> +++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
>> @@ -830,8 +830,8 @@ static const struct dwxgmac3_error_desc dwxgmac3_dma_errors[32]= {
>>   	{ false, "UNKNOWN", "Unknown Error" }, /* 31 */
>>   };
>>   
>> -static const char * const dpp_rx_err = "Read Rx Descriptor Parity checker Error";
>> -static const char * const dpp_tx_err = "Read Tx Descriptor Parity checker Error";
>> +#define dpp_rx_err "Read Rx Descriptor Parity checker Error"
>> +#define dpp_tx_err "Read Tx Descriptor Parity checker Error"
>>   static const struct dwxgmac3_error_desc dwxgmac3_dma_dpp_errors[32] = {
>>   	{ true, "TDPES0", dpp_tx_err },
>>   	{ true, "TDPES1", dpp_tx_err },
>>
>> base-commit: 841c35169323cd833294798e58b9bf63fa4fa1de

Thanks Jacob.

The minimum versions for compilers and other tools are documented here:
https://www.kernel.org/doc/html/latest/process/changes.html

I am using a SLES 15 server to build, the first version of which came out in 2017.

Mark


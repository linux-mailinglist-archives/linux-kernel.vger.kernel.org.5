Return-Path: <linux-kernel+bounces-80608-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C97E9866A4C
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 07:50:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4081F1F22862
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 06:50:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FE181BC53;
	Mon, 26 Feb 2024 06:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="LvZNwcMT"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B89731BF28;
	Mon, 26 Feb 2024 06:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708930216; cv=none; b=gTDetIgeIMZy7f0Bnqq2uVh9k16F69/7jYN6lbEGXaIgGxV7U5JpD/TxXtiUDAZo2ofqWafmTJKrmSKDBIylPHGXSC1gSbuTGrs0x3eMQcodkPnYGE2JMkJkab3YG3eU2vr4K3MQxHbE43KiAmNSJHYTOCFi9qChZXZ2by/8y9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708930216; c=relaxed/simple;
	bh=6oiheK8jXhJu3jEbbcTC7KYrEfi4/V3nGQUHfUKvfCs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KT0zWV9G/rv2OWMOHjnXBdVQ7BtodQsphtt7bK7TKUS0cwsdw8rb3TGMwPgJYZs+UXAQEMQSbwETnie+oiZtyMbgv9iDzJQUCmr8Qx99Gsa7kcRxZsR19LzDGaV+eLM0gh70bLM5kpGe2pixU3fu6c08oKMp51anVXwQ5kYv7ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=LvZNwcMT; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=1kc2WcM3zb+rxch8r0ftfqGh2C9F2iUAZFnheJ+68jk=; b=LvZNwcMTQzKVcHpiPtles1wWKs
	Z8S57J8xGJj9KeJiehkQqflREG3srrXKYZBNOA0dV2EJFCPMAJ1rFJBEa/CEdi0X+fnCe2ZA4JRbV
	mQnSRTg9j3JRdWMjav4ma7k/6tWO5jbAAC328Vhu0A75WTKJHNLrKcmt3aMna+nk7txDYddBtaraG
	ziEzsPkadrVJkYjRV4AjxmhO2UmMhDC2YoJcq9yosU9j7mdbvrmM2m5p2kA+9XYVW0311XBsNKdJn
	RIPLCFgiGLDOke7cDXJhh6tL0kCoaLD+NTKtkSkiL9J6xgTTjUxMzon2WSRx3sDRakOd6MvgBHE/w
	Ezro9YTQ==;
Received: from [50.53.50.0] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1reUoV-0000000GhjS-1wzZ;
	Mon, 26 Feb 2024 06:50:11 +0000
Message-ID: <77012b38-4b49-47f4-9a88-d773d52909ad@infradead.org>
Date: Sun, 25 Feb 2024 22:50:10 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: ethernet: adi: requires PHYLIB support
To: Michal Kubecek <mkubecek@suse.cz>
Cc: linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>,
 Lennart Franzen <lennart@lfdomain.com>,
 Alexandru Tachici <alexandru.tachici@analog.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org
References: <20240215070050.2389-1-rdunlap@infradead.org>
 <20240226064440.ismpxvp5qmnskyna@lion.mk-sys.cz>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20240226064440.ismpxvp5qmnskyna@lion.mk-sys.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 2/25/24 22:44, Michal Kubecek wrote:
> On Wed, Feb 14, 2024 at 11:00:50PM -0800, Randy Dunlap wrote:
>> This driver uses functions that are supplied by the Kconfig symbol
>> PHYLIB, so select it to ensure that they are built as needed.
>>
>> When CONFIG_ADIN1110=y and CONFIG_PHYLIB=m, there are multiple build
>> (linker) errors that are resolved by this Kconfig change:
>>
>>    ld: drivers/net/ethernet/adi/adin1110.o: in function `adin1110_net_open':
>>    drivers/net/ethernet/adi/adin1110.c:933: undefined reference to `phy_start'
>>    ld: drivers/net/ethernet/adi/adin1110.o: in function `adin1110_probe_netdevs':
>>    drivers/net/ethernet/adi/adin1110.c:1603: undefined reference to `get_phy_device'
>>    ld: drivers/net/ethernet/adi/adin1110.c:1609: undefined reference to `phy_connect'
>>    ld: drivers/net/ethernet/adi/adin1110.o: in function `adin1110_disconnect_phy':
>>    drivers/net/ethernet/adi/adin1110.c:1226: undefined reference to `phy_disconnect'
>>    ld: drivers/net/ethernet/adi/adin1110.o: in function `devm_mdiobus_alloc':
>>    include/linux/phy.h:455: undefined reference to `devm_mdiobus_alloc_size'
>>    ld: drivers/net/ethernet/adi/adin1110.o: in function `adin1110_register_mdiobus':
>>    drivers/net/ethernet/adi/adin1110.c:529: undefined reference to `__devm_mdiobus_register'
>>    ld: drivers/net/ethernet/adi/adin1110.o: in function `adin1110_net_stop':
>>    drivers/net/ethernet/adi/adin1110.c:958: undefined reference to `phy_stop'
>>    ld: drivers/net/ethernet/adi/adin1110.o: in function `adin1110_disconnect_phy':
>>    drivers/net/ethernet/adi/adin1110.c:1226: undefined reference to `phy_disconnect'
>>    ld: drivers/net/ethernet/adi/adin1110.o: in function `adin1110_adjust_link':
>>    drivers/net/ethernet/adi/adin1110.c:1077: undefined reference to `phy_print_status'
>>    ld: drivers/net/ethernet/adi/adin1110.o: in function `adin1110_ioctl':
>>    drivers/net/ethernet/adi/adin1110.c:790: undefined reference to `phy_do_ioctl'
>>    ld: drivers/net/ethernet/adi/adin1110.o:(.rodata+0xf60): undefined reference to `phy_ethtool_get_link_ksettings'
>>    ld: drivers/net/ethernet/adi/adin1110.o:(.rodata+0xf68): undefined reference to `phy_ethtool_set_link_ksettings'
>>
>> Fixes: bc93e19d088b ("net: ethernet: adi: Add ADIN1110 support")
>> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
>> Reported-by: kernel test robot <lkp@intel.com>
>> Closes: https://lore.kernel.org/oe-kbuild-all/202402070626.eZsfVHG5-lkp@intel.com/
>> Cc: Lennart Franzen <lennart@lfdomain.com>
>> Cc: Alexandru Tachici <alexandru.tachici@analog.com>
>> Cc: "David S. Miller" <davem@davemloft.net>
>> Cc: Eric Dumazet <edumazet@google.com>
>> Cc: Jakub Kicinski <kuba@kernel.org>
>> Cc: Paolo Abeni <pabeni@redhat.com>
>> Cc: netdev@vger.kernel.org
>> ---
>>  drivers/net/ethernet/adi/Kconfig |    1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff -- a/drivers/net/ethernet/adi/Kconfig b/drivers/net/ethernet/adi/Kconfig
>> --- a/drivers/net/ethernet/adi/Kconfig
>> +++ b/drivers/net/ethernet/adi/Kconfig
>> @@ -7,6 +7,7 @@ config NET_VENDOR_ADI
>>  	bool "Analog Devices devices"
>>  	default y
>>  	depends on SPI
>> +	select PHYLIB
>>  	help
>>  	  If you have a network (Ethernet) card belonging to this class, say Y.
> 
> Shouldn't the "select PHYLIB" be added to ADIN1110 rather than
> NET_VENDOR_ADI? Now with v6.8-rc6, PHYLIB and few other options are
> forced to "Y" whenever NET_VENDOR_ADI is enabled (even with ADIN1110
> disabled).

ugh, I believe that you are correct.
I'll send a corrected patch.

Thanks.
-- 
#Randy


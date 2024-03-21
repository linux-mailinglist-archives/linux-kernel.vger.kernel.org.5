Return-Path: <linux-kernel+bounces-109558-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DA81881ACE
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 03:00:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DD94CB212C0
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 02:00:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3EDA4C79;
	Thu, 21 Mar 2024 02:00:01 +0000 (UTC)
Received: from smtpbgsg1.qq.com (smtpbgsg1.qq.com [54.254.200.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E893EC3;
	Thu, 21 Mar 2024 01:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710986401; cv=none; b=gdulR/JN4P/Ch/T+mUBFUfS97M1mZxnd5ZUgOO1ICbW7hQx4wP2L0ddh0lIpIlP6IKwYyiCVGBgi4iRm41PU32sSfz38bCRfXjAyGPqR9y2q4l+KPStXej0LIWpT+GRR3eX6yjFLWbLn0I1pkb+Z62HoWqJAtJ1qmeFs54YHbqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710986401; c=relaxed/simple;
	bh=SLgfU+LNzx4NoeR3O8DjEuK5meB8Z1RlJ8QYCVS7GWw=;
	h=From:To:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZNRtN1NWyk2s4r2yorPKmnnf3i7DUGumVmY5SEI+U/xLIJWNo/4YxaL/gYLncJeuZKPvKG3MH2RgOUek6GlOSsLQeBnpaVqhEaDJP65Jc830rLIkqRd8iwtFI1GIGuanpo00I0xNc5gXY3399yT0LmhSsgIega0+B9kgmz5d6bA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=54.254.200.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid:Yeas3t1710986305t393t55860
Received: from 3DB253DBDE8942B29385B9DFB0B7E889 (jiawenwu@trustnetic.com [36.20.53.11])
X-QQ-SSF:00400000000000F0FUF000000000000
From: =?utf-8?b?Smlhd2VuIFd1?= <jiawenwu@trustnetic.com>
X-BIZMAIL-ID: 14093918444484282112
To: "'Duanqiang Wen'" <duanqiangwen@net-swift.com>,
	<netdev@vger.kernel.org>,
	<mengyuanlou@net-swift.com>,
	<davem@davemloft.net>,
	<edumazet@google.com>,
	<kuba@kernel.org>,
	<pabeni@redhat.com>,
	<maciej.fijalkowski@intel.com>,
	<andrew@lunn.ch>,
	<wangxiongfeng2@huawei.com>,
	<linux-kernel@vger.kernel.org>
References: <20240321015139.437376-1-duanqiangwen@net-swift.com>
In-Reply-To: <20240321015139.437376-1-duanqiangwen@net-swift.com>
Subject: RE: [PATCH net v2] net: txgbe: fix i2c dev name cannot match clkdev
Date: Thu, 21 Mar 2024 09:58:24 +0800
Message-ID: <014301da7b33$42413850$c6c3a8f0$@trustnetic.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: zh-cn
Thread-Index: AQHDtAMD4Ji0dmygFwLsKqktAbdvnrFu/YsA
X-QQ-SENDSIZE: 520
Feedback-ID: Yeas:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz8a-1



> -----Original Message-----
> From: Duanqiang Wen <duanqiangwen@net-swift.com>
> Sent: Thursday, March 21, 2024 9:52 AM
> To: netdev@vger.kernel.org; jiawenwu@trustnetic.com; mengyuanlou@net-swift.com; davem@davemloft.net;
> edumazet@google.com; kuba@kernel.org; pabeni@redhat.com; maciej.fijalkowski@intel.com; andrew@lunn.ch;
> wangxiongfeng2@huawei.com; linux-kernel@vger.kernel.org
> Cc: Duanqiang Wen <duanqiangwen@net-swift.com>
> Subject: [PATCH net v2] net: txgbe: fix i2c dev name cannot match clkdev
> 
> txgbe clkdev shortened clk_name, so i2c_dev info_name
> also need to shorten. Otherwise, i2c_dev cannot initialize
> clock. And had "i2c_dw" string in a define.
> 
> Fixes: e30cef001da2 ("net: txgbe: fix clk_name exceed MAX_DEV_ID limits")
> 
> Signed-off-by: Duanqiang Wen <duanqiangwen@net-swift.com>
> ---
>  drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c | 6 +++---
>  drivers/net/ethernet/wangxun/txgbe/txgbe_phy.h | 2 ++
>  2 files changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c
> index 5b5d5e4310d1..3f61f161f1ed 100644
> --- a/drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c
> +++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c
> @@ -571,8 +571,8 @@ static int txgbe_clock_register(struct txgbe *txgbe)
>  	char clk_name[32];
>  	struct clk *clk;
> 
> -	snprintf(clk_name, sizeof(clk_name), "i2c_dw.%d",
> -		 pci_dev_id(pdev));
> +	snprintf(clk_name, sizeof(clk_name), "%s.%d",
> +		 TXGBE_I2C_CLK_DEV_NAME, pci_dev_id(pdev));
> 
>  	clk = clk_register_fixed_rate(NULL, clk_name, NULL, 0, 156250000);
>  	if (IS_ERR(clk))
> @@ -634,7 +634,7 @@ static int txgbe_i2c_register(struct txgbe *txgbe)
> 
>  	info.parent = &pdev->dev;
>  	info.fwnode = software_node_fwnode(txgbe->nodes.group[SWNODE_I2C]);
> -	info.name = "i2c_designware";
> +	info.name = TXGBE_I2C_CLK_DEV_NAME;
>  	info.id = pci_dev_id(pdev);
> 
>  	info.res = &DEFINE_RES_IRQ(pdev->irq);
> diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_phy.h b/drivers/net/ethernet/wangxun/txgbe/txgbe_phy.h
> index 8a026d804fe2..c7f2157f3d95 100644
> --- a/drivers/net/ethernet/wangxun/txgbe/txgbe_phy.h
> +++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_phy.h
> @@ -4,6 +4,8 @@
>  #ifndef _TXGBE_PHY_H_
>  #define _TXGBE_PHY_H_
> 
> +#define TXGBE_I2C_CLK_DEV_NAME "i2c_dw"

Please add the define in txgbe_type.h

> +
>  irqreturn_t txgbe_gpio_irq_handler(int irq, void *data);
>  void txgbe_reinit_gpio_intr(struct wx *wx);
>  irqreturn_t txgbe_link_irq_handler(int irq, void *data);
> --
> 2.27.0
> 



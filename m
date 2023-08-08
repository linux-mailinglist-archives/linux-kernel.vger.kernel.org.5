Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 361D97742D7
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 19:50:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232959AbjHHRuy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 13:50:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234953AbjHHRuY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 13:50:24 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B5BC27570;
        Tue,  8 Aug 2023 09:22:27 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 378DAUek094282;
        Tue, 8 Aug 2023 08:10:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1691500230;
        bh=qXuYKk139NgvV423lfYnq+098xTyM+6thAwcW6OsYx8=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=VYL3koAV1DeI0UpsdX+iYiQkj7CDglWwDKjUMgagubCRn08gs1SALLaN3T/VfWket
         6PhdnTs1jTCVEMH8siU8y3CMCITF7TzTyz60IRL3xtJ1c38enCI7EYV4B0l/5zONGQ
         aX3x7x39ErJ94YNZzqYCeOpF1eC77AvGX5iAfbQM=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 378DAUKM121030
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 8 Aug 2023 08:10:30 -0500
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 8
 Aug 2023 08:10:30 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 8 Aug 2023 08:10:30 -0500
Received: from [172.24.227.217] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 378DAOx8008267;
        Tue, 8 Aug 2023 08:10:24 -0500
Message-ID: <0b141b27-57b8-fb96-200a-d4c3d75193be@ti.com>
Date:   Tue, 8 Aug 2023 18:40:23 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 5/5] net: ti: icssg-prueth: am65x SR2.0 add 10M full
 duplex support
Content-Language: en-US
To:     Roger Quadros <rogerq@kernel.org>,
        MD Danish Anwar <danishanwar@ti.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Simon Horman <simon.horman@corigine.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Richard Cochran <richardcochran@gmail.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>
CC:     <nm@ti.com>, <srk@ti.com>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-omap@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20230807110048.2611456-1-danishanwar@ti.com>
 <20230807110048.2611456-6-danishanwar@ti.com>
 <a333e70a-88ba-750d-34ce-6c8fa91e355b@kernel.org>
From:   Md Danish Anwar <a0501179@ti.com>
Organization: Texas Instruments
In-Reply-To: <a333e70a-88ba-750d-34ce-6c8fa91e355b@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/08/23 4:44 pm, Roger Quadros wrote:
> 
> 
> On 07/08/2023 14:00, MD Danish Anwar wrote:
>> From: Grygorii Strashko <grygorii.strashko@ti.com>
>>
>> For AM65x SR2.0 it's required to enable IEP1 in raw 64bit mode which is
>> used by PRU FW to monitor the link and apply w/a for 10M link issue.
>> Note. No public errata available yet.
>>
>> Without this w/a the PRU FW will stuck if link state changes under TX
>> traffic pressure.
>>
>> Hence, add support for 10M full duplex for AM65x SR2.0:
>>  - add new IEP API to enable IEP, but without PTP support
>>  - add pdata quirk_10m_link_issue to enable 10M link issue w/a.
>>
>> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
>> Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
>> Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
>> ---
>>  drivers/net/ethernet/ti/icssg/icss_iep.c     | 26 ++++++++++++++++++++
>>  drivers/net/ethernet/ti/icssg/icss_iep.h     |  2 ++
>>  drivers/net/ethernet/ti/icssg/icssg_config.c |  6 +++++
>>  drivers/net/ethernet/ti/icssg/icssg_prueth.c | 17 +++++++++++--
>>  4 files changed, 49 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/ti/icssg/icss_iep.c b/drivers/net/ethernet/ti/icssg/icss_iep.c
>> index 455c803dea36..527f17430f05 100644
>> --- a/drivers/net/ethernet/ti/icssg/icss_iep.c
>> +++ b/drivers/net/ethernet/ti/icssg/icss_iep.c
>> @@ -721,6 +721,32 @@ void icss_iep_put(struct icss_iep *iep)
>>  }
>>  EXPORT_SYMBOL_GPL(icss_iep_put);
>>  
>> +void icss_iep_init_fw(struct icss_iep *iep)
>> +{
>> +	/* start IEP for FW use in raw 64bit mode, no PTP support */
>> +	iep->clk_tick_time = iep->def_inc;
>> +	iep->cycle_time_ns = 0;
>> +	iep->ops = NULL;
>> +	iep->clockops_data = NULL;
>> +	icss_iep_set_default_inc(iep, iep->def_inc);
>> +	icss_iep_set_compensation_inc(iep, iep->def_inc);
>> +	icss_iep_set_compensation_count(iep, 0);
>> +	regmap_write(iep->map, ICSS_IEP_SYNC_PWIDTH_REG, iep->refclk_freq / 10); /* 100 ms pulse */
>> +	regmap_write(iep->map, ICSS_IEP_SYNC0_PERIOD_REG, 0);
>> +	if (iep->plat_data->flags & ICSS_IEP_SLOW_COMPEN_REG_SUPPORT)
>> +		icss_iep_set_slow_compensation_count(iep, 0);
>> +
>> +	icss_iep_enable(iep);
>> +	icss_iep_settime(iep, 0);
>> +}
>> +EXPORT_SYMBOL_GPL(icss_iep_init_fw);
>> +
>> +void icss_iep_exit_fw(struct icss_iep *iep)
>> +{
>> +	icss_iep_disable(iep);
>> +}
>> +EXPORT_SYMBOL_GPL(icss_iep_exit_fw);
>> +
>>  int icss_iep_init(struct icss_iep *iep, const struct icss_iep_clockops *clkops,
>>  		  void *clockops_data, u32 cycle_time_ns)
>>  {
>> diff --git a/drivers/net/ethernet/ti/icssg/icss_iep.h b/drivers/net/ethernet/ti/icssg/icss_iep.h
>> index 9c7f4d0a0916..803a4b714893 100644
>> --- a/drivers/net/ethernet/ti/icssg/icss_iep.h
>> +++ b/drivers/net/ethernet/ti/icssg/icss_iep.h
>> @@ -35,5 +35,7 @@ int icss_iep_exit(struct icss_iep *iep);
>>  int icss_iep_get_count_low(struct icss_iep *iep);
>>  int icss_iep_get_count_hi(struct icss_iep *iep);
>>  int icss_iep_get_ptp_clock_idx(struct icss_iep *iep);
>> +void icss_iep_init_fw(struct icss_iep *iep);
>> +void icss_iep_exit_fw(struct icss_iep *iep);
>>  
>>  #endif /* __NET_TI_ICSS_IEP_H */
>> diff --git a/drivers/net/ethernet/ti/icssg/icssg_config.c b/drivers/net/ethernet/ti/icssg/icssg_config.c
>> index ab648d3efe85..4c2b5d496670 100644
>> --- a/drivers/net/ethernet/ti/icssg/icssg_config.c
>> +++ b/drivers/net/ethernet/ti/icssg/icssg_config.c
>> @@ -210,6 +210,9 @@ void icssg_config_ipg(struct prueth_emac *emac)
>>  	case SPEED_100:
>>  		icssg_mii_update_ipg(prueth->mii_rt, slice, MII_RT_TX_IPG_100M);
>>  		break;
>> +	case SPEED_10:
>> +		icssg_mii_update_ipg(prueth->mii_rt, slice, MII_RT_TX_IPG_100M);
>> +		break;
>>  	default:
>>  		/* Other links speeds not supported */
>>  		netdev_err(emac->ndev, "Unsupported link speed\n");
>> @@ -440,6 +443,9 @@ void icssg_config_set_speed(struct prueth_emac *emac)
>>  	case SPEED_100:
>>  		fw_speed = FW_LINK_SPEED_100M;
>>  		break;
>> +	case SPEED_10:
>> +		fw_speed = FW_LINK_SPEED_10M;
>> +		break;
>>  	default:
>>  		/* Other links speeds not supported */
>>  		netdev_err(emac->ndev, "Unsupported link speed\n");
>> diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.c b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
>> index b82a718fd602..216918162960 100644
>> --- a/drivers/net/ethernet/ti/icssg/icssg_prueth.c
>> +++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
>> @@ -1131,7 +1131,6 @@ static int emac_phy_connect(struct prueth_emac *emac)
>>  
>>  	/* remove unsupported modes */
>>  	phy_remove_link_mode(ndev->phydev, ETHTOOL_LINK_MODE_10baseT_Half_BIT);
>> -	phy_remove_link_mode(ndev->phydev, ETHTOOL_LINK_MODE_10baseT_Full_BIT);
>>  	phy_remove_link_mode(ndev->phydev, ETHTOOL_LINK_MODE_100baseT_Half_BIT);
>>  	phy_remove_link_mode(ndev->phydev, ETHTOOL_LINK_MODE_1000baseT_Half_BIT);
>>  	phy_remove_link_mode(ndev->phydev, ETHTOOL_LINK_MODE_Pause_BIT);
>> @@ -2081,13 +2080,20 @@ static int prueth_probe(struct platform_device *pdev)
>>  		goto free_pool;
>>  	}
>>  
>> +	if (prueth->pdata.quirk_10m_link_issue) {
>> +		/* Enable IEP1 for FW in 64bit mode as W/A for 10M FD link detect issue under TX
>> +		 * traffic.
>> +		 */
>> +		icss_iep_init_fw(prueth->iep1);
> 
> This is the only place where IEP1 is used.
> You should add all IEP1 related code in this patch.

Sure Roger, I'll do that.
> 
>> +	}
>> +
>>  	/* setup netdev interfaces */
>>  	if (eth0_node) {
>>  		ret = prueth_netdev_init(prueth, eth0_node);
>>  		if (ret) {
>>  			dev_err_probe(dev, ret, "netdev init %s failed\n",
>>  				      eth0_node->name);
>> -			goto netdev_exit;
>> +			goto exit_iep;
>>  		}
>>  		prueth->emac[PRUETH_MAC0]->iep = prueth->iep0;
>>  	}
>> @@ -2158,6 +2164,10 @@ static int prueth_probe(struct platform_device *pdev)
>>  		prueth_netdev_exit(prueth, eth_node);
>>  	}
>>  
>> +exit_iep:
>> +	if (prueth->pdata.quirk_10m_link_issue)
>> +		icss_iep_exit_fw(prueth->iep1);
>> +
>>  free_pool:
>>  	gen_pool_free(prueth->sram_pool,
>>  		      (unsigned long)prueth->msmcram.va, msmc_ram_size);
>> @@ -2203,6 +2213,9 @@ static void prueth_remove(struct platform_device *pdev)
>>  		prueth_netdev_exit(prueth, eth_node);
>>  	}
>>  
>> +	if (prueth->pdata.quirk_10m_link_issue)
>> +		icss_iep_exit_fw(prueth->iep1);
>> +
>>  	icss_iep_put(prueth->iep1);
>>  	icss_iep_put(prueth->iep0);
>>  
> 

-- 
Thanks and Regards,
Danish.

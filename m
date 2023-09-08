Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CE1479818F
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 07:32:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239292AbjIHFcB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 01:32:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230208AbjIHFb7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 01:31:59 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8446519AB;
        Thu,  7 Sep 2023 22:31:55 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3885VI5u127503;
        Fri, 8 Sep 2023 00:31:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1694151078;
        bh=ytb/oOdN4X4WPgolvKeWPvRV2KinLFocYZems56fZgc=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=C8p5eyLrB0Nd7cK9rMXpAaWW1/8dXvx8JfAIBUGtZsWFH7IyTvSRBmojIQ6eZnBbU
         fEvEolHyTLInnRM2y0601ysDq5Hv13zkRM/PZudrCek8Gvlw7gknyeLKYUq0ggSqT+
         m8DLtj2V/ThLEckbtD032N7Ix/ZJ9xktWCiKgUnw=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3885VIcd029714
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 8 Sep 2023 00:31:18 -0500
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 8
 Sep 2023 00:31:16 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 8 Sep 2023 00:31:16 -0500
Received: from [10.24.69.199] (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3885VBqn127454;
        Fri, 8 Sep 2023 00:31:12 -0500
Message-ID: <87a80560-7813-e15e-46e5-03094e87a634@ti.com>
Date:   Fri, 8 Sep 2023 11:01:10 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [EXTERNAL] Re: [RFC PATCH net-next 4/4] net: ti: icssg_prueth:
 add TAPRIO offload support
Content-Language: en-US
To:     Roger Quadros <rogerq@kernel.org>, Simon Horman <horms@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Jacob Keller <jacob.e.keller@intel.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Richard Cochran <richardcochran@gmail.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>
CC:     <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <srk@ti.com>, <r-gunasekaran@ti.com>
References: <20230830110847.1219515-1-danishanwar@ti.com>
 <20230830110847.1219515-5-danishanwar@ti.com>
 <d492bdeb-6bb6-4891-ba5e-7658a6e5e6ec@kernel.org>
From:   MD Danish Anwar <danishanwar@ti.com>
In-Reply-To: <d492bdeb-6bb6-4891-ba5e-7658a6e5e6ec@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/09/23 17:53, Roger Quadros wrote:
> 
> 
> On 30/08/2023 14:08, MD Danish Anwar wrote:
>> From: Roger Quadros <rogerq@kernel.org>
>>
>> ICSSG dual-emac f/w supports Enhanced Scheduled Traffic (EST – defined
>> in P802.1Qbv/D2.2 that later got included in IEEE 802.1Q-2018)
>> configuration. EST allows express queue traffic to be scheduled
>> (placed) on the wire at specific repeatable time intervals. In
>> Linux kernel, EST configuration is done through tc command and
>> the taprio scheduler in the net core implements a software only
>> scheduler (SCH_TAPRIO). If the NIC is capable of EST configuration,
>> user indicate "flag 2" in the command which is then parsed by
>> taprio scheduler in net core and indicate that the command is to
>> be offloaded to h/w. taprio then offloads the command to the
>> driver by calling ndo_setup_tc() ndo ops. This patch implements
>> ndo_setup_tc() to offload EST configuration to ICSSG.
>>
>> Signed-off-by: Roger Quadros <rogerq@ti.com>
>> Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
>> Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
>> ---
>>  drivers/net/ethernet/ti/Makefile             |   3 +-
>>  drivers/net/ethernet/ti/icssg/icssg_prueth.c |   5 +-
>>  drivers/net/ethernet/ti/icssg/icssg_prueth.h |   7 +
>>  drivers/net/ethernet/ti/icssg/icssg_qos.c    | 294 +++++++++++++++++++
>>  drivers/net/ethernet/ti/icssg/icssg_qos.h    | 119 ++++++++
>>  5 files changed, 426 insertions(+), 2 deletions(-)
>>  create mode 100644 drivers/net/ethernet/ti/icssg/icssg_qos.c
>>  create mode 100644 drivers/net/ethernet/ti/icssg/icssg_qos.h
>>
>> diff --git a/drivers/net/ethernet/ti/Makefile b/drivers/net/ethernet/ti/Makefile
>> index 3adceff760ce..de348c20eff9 100644
>> --- a/drivers/net/ethernet/ti/Makefile
>> +++ b/drivers/net/ethernet/ti/Makefile
>> @@ -38,5 +38,6 @@ icssg-prueth-y := k3-cppi-desc-pool.o \
>>  		  icssg/icssg_mii_cfg.o \
>>  		  icssg/icssg_stats.o \
>>  		  icssg/icssg_ethtool.o \
>> -		  icssg/icssg_switchdev.o
>> +		  icssg/icssg_switchdev.o \
>> +		  icssg/icssg_qos.o
>>  obj-$(CONFIG_TI_ICSS_IEP) += icssg/icss_iep.o
>> diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.c b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
>> index 5b7e7297ce23..3236af45aa4e 100644
>> --- a/drivers/net/ethernet/ti/icssg/icssg_prueth.c
>> +++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
>> @@ -1179,7 +1179,7 @@ static int emac_phy_connect(struct prueth_emac *emac)
>>  	return 0;
>>  }
>>  
>> -static u64 prueth_iep_gettime(void *clockops_data, struct ptp_system_timestamp *sts)
>> +u64 prueth_iep_gettime(void *clockops_data, struct ptp_system_timestamp *sts)
>>  {
>>  	u32 hi_rollover_count, hi_rollover_count_r;
>>  	struct prueth_emac *emac = clockops_data;
>> @@ -1416,6 +1416,8 @@ static int emac_ndo_open(struct net_device *ndev)
>>  		napi_enable(&emac->tx_chns[i].napi_tx);
>>  	napi_enable(&emac->napi_rx);
>>  
>> +	icssg_qos_init(ndev);
>> +
>>  	/* start PHY */
>>  	phy_start(ndev->phydev);
>>  
>> @@ -1695,6 +1697,7 @@ static const struct net_device_ops emac_netdev_ops = {
>>  	.ndo_set_rx_mode = emac_ndo_set_rx_mode,
>>  	.ndo_eth_ioctl = emac_ndo_ioctl,
>>  	.ndo_get_stats64 = emac_ndo_get_stats64,
>> +	.ndo_setup_tc = icssg_qos_ndo_setup_tc,
>>  };
>>  
>>  /* get emac_port corresponding to eth_node name */
>> diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.h b/drivers/net/ethernet/ti/icssg/icssg_prueth.h
>> index 6e18da06c786..43b67213d8c7 100644
>> --- a/drivers/net/ethernet/ti/icssg/icssg_prueth.h
>> +++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.h
>> @@ -37,6 +37,7 @@
>>  #include "icssg_config.h"
>>  #include "icss_iep.h"
>>  #include "icssg_switch_map.h"
>> +#include "icssg_qos.h"
>>  
>>  #define PRUETH_MAX_MTU          (2000 - ETH_HLEN - ETH_FCS_LEN)
>>  #define PRUETH_MIN_PKT_SIZE     (VLAN_ETH_ZLEN)
>> @@ -186,6 +187,9 @@ struct prueth_emac {
>>  	struct devlink_port devlink_port;
>>  	int port_vlan;
>>  
>> +	struct prueth_qos qos;
>> +	struct work_struct ts_work;
>> +
>>  	struct delayed_work stats_work;
>>  	u64 stats[ICSSG_NUM_STATS];
>>  };
>> @@ -331,4 +335,7 @@ void icssg_set_pvid(struct prueth *prueth, u8 vid, u8 port);
>>  void emac_stats_work_handler(struct work_struct *work);
>>  void emac_update_hardware_stats(struct prueth_emac *emac);
>>  int emac_get_stat_by_name(struct prueth_emac *emac, char *stat_name);
>> +
>> +u64 prueth_iep_gettime(void *clockops_data, struct ptp_system_timestamp *sts);
>> +
>>  #endif /* __NET_TI_ICSSG_PRUETH_H */
>> diff --git a/drivers/net/ethernet/ti/icssg/icssg_qos.c b/drivers/net/ethernet/ti/icssg/icssg_qos.c
>> new file mode 100644
>> index 000000000000..e8102703e257
>> --- /dev/null
>> +++ b/drivers/net/ethernet/ti/icssg/icssg_qos.c
>> @@ -0,0 +1,294 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/* Texas Instruments ICSSG PRUETH QoS submodule
>> + * Copyright (C) 2020 Texas Instruments Incorporated - http://www.ti.com/
> 
> 2023 here and rest of series.
> 

Sure Roger.

>> + */
>> +
>> +#include <linux/printk.h>
>> +#include "icssg_prueth.h"
>> +#include "icssg_switch_map.h"
>> +
>> +static void icssg_qos_tas_init(struct net_device *ndev);
>> +
>> +void icssg_qos_init(struct net_device *ndev)
>> +{
>> +	icssg_qos_tas_init(ndev);
>> +
>> +	/* IET init goes here */
> 
> Please drop this comment.
> 

Will drop this and post next revision.

>> +}
>> +
> 
> <snip>
> 

-- 
Thanks and Regards,
Danish

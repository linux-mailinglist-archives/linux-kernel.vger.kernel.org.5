Return-Path: <linux-kernel+bounces-25711-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EBA9682D4E3
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 09:14:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6AA261F21920
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 08:14:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 433D363AC;
	Mon, 15 Jan 2024 08:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="pX5IN/dn"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C087E6FA1;
	Mon, 15 Jan 2024 08:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 40F6sJsD011020;
	Mon, 15 Jan 2024 00:54:19 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1705301659;
	bh=m1mxe8d7nT+K4Nm5wafkruzgsL9mWqgJvfnfAjVx5bc=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=pX5IN/dnM20yIUV47TsLcK6qJnqVyVKTvGxCMRh8Z5GoZpTxa80TJnrIHqHhsMln+
	 npfGXl48WON3b56wn/Q4OnxbB8S0KFV7Hgw98JQtGhTZOdgADuNKmBJWpll09GR8+j
	 N/kal71uJOiWl7WENtWAIrt9ikDDMFaWIXM6Mcg4=
Received: from DLEE101.ent.ti.com (dlee101.ent.ti.com [157.170.170.31])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 40F6sIoI066956
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 15 Jan 2024 00:54:19 -0600
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 15
 Jan 2024 00:54:18 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 15 Jan 2024 00:54:18 -0600
Received: from [10.24.69.25] (danish-tpc.dhcp.ti.com [10.24.69.25])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 40F6sCvS096901;
	Mon, 15 Jan 2024 00:54:13 -0600
Message-ID: <cfb5edf6-90ac-4d2a-a138-981c276e24bb@ti.com>
Date: Mon, 15 Jan 2024 12:24:12 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4] net: ti: icssg_prueth: add TAPRIO offload
 support
Content-Language: en-US
To: Vladimir Oltean <vladimir.oltean@nxp.com>
CC: Andrew Lunn <andrew@lunn.ch>, Roger Quadros <rogerq@kernel.org>,
        Vignesh
 Raghavendra <vigneshr@ti.com>,
        Richard Cochran <richardcochran@gmail.com>,
        Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
        Eric
 Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Simon
 Horman <horms@kernel.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <srk@ti.com>, <r-gunasekaran@ti.com>,
        <linux-arm-kernel@lists.infradead.org>, Roger Quadros <rogerq@ti.com>,
        Vinicius Costa Gomes <vinicius.gomes@intel.com>
References: <20231006102028.3831341-1-danishanwar@ti.com>
 <20231011102536.r65xyzmh5kap2cf2@skbuf>
From: MD Danish Anwar <danishanwar@ti.com>
In-Reply-To: <20231011102536.r65xyzmh5kap2cf2@skbuf>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi Vladimir,

On 11/10/23 3:55 pm, Vladimir Oltean wrote:
> On Fri, Oct 06, 2023 at 03:50:28PM +0530, MD Danish Anwar wrote:
>> From: Roger Quadros <rogerq@ti.com>
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
>> Cc: Roger Quadros <rogerq@ti.com>
>> Cc: Andrew Lunn <andrew@lunn.ch>
>> Cc: Vinicius Costa Gomes <vinicius.gomes@intel.com>
>> Cc: Jakub Kicinski <kuba@kernel.org>
>>
>> Changes from v3 to v4:
>> *) Rebased on the latest next-20231005 linux-next.
> 
> The tree that the patch will be applied to is
> https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git,
> not linux-next.
> 

Sure. I will rebase this on net-next and resend.

>> *) Addressed Roger and Vinicius' comments and moved all the validations to
>>    emac_taprio_replace() API.
>> *) Modified emac_setup_taprio() API to use switch case based on taprio->cmd
>>    and added emac_taprio_destroy() and emac_taprio_replace() APIs.
>> *) Modified the documentation of structs / enums in icssg_qos.h by using
>>    the correct kdoc format.
>>
>> Changes from v2 to v3:
>> *) Rebased on the latest next-20230928 linux-next.
>> *) Retained original authorship of the patch.
>> *) Addressed Roger's comments and modified emac_setup_taprio() and
>>    emac_set_taprio() APIs accordingly.
>> *) Removed netif_running() check from emac_setup_taprio().
>> *) Addressed Vinicius' comments and added check for MIN and MAX cycle time.
>> *) Added check for allocation failure of est_new in emac_setup_taprio().
>>
>> Changes from v1 to v2:
>> *) Rebased on the latest next-20230921 linux-next.
>> *) Dropped the RFC tag as merge window is open now.
>> *) Splitted this patch from the switch mode series [v1].
>> *) Removed TODO comment as asked by Andrew and Roger.
>> *) Changed Copyright to 2023 as asked by Roger.
>>
>> v3: https://lore.kernel.org/all/20230928103000.186304-1-danishanwar@ti.com/
>> v2: https://lore.kernel.org/all/20230921070031.795788-1-danishanwar@ti.com/
>> v1: https://lore.kernel.org/all/20230830110847.1219515-1-danishanwar@ti.com/
>>
>>  drivers/net/ethernet/ti/Makefile             |   3 +-
>>  drivers/net/ethernet/ti/icssg/icssg_prueth.c |   5 +-
>>  drivers/net/ethernet/ti/icssg/icssg_prueth.h |   6 +
>>  drivers/net/ethernet/ti/icssg/icssg_qos.c    | 301 +++++++++++++++++++
>>  drivers/net/ethernet/ti/icssg/icssg_qos.h    | 113 +++++++
>>  5 files changed, 426 insertions(+), 2 deletions(-)
>>  create mode 100644 drivers/net/ethernet/ti/icssg/icssg_qos.c
>>  create mode 100644 drivers/net/ethernet/ti/icssg/icssg_qos.h
>>
>> diff --git a/drivers/net/ethernet/ti/Makefile b/drivers/net/ethernet/ti/Makefile
>> index 34fd7a716ba6..0df60ded1b2d 100644
>> --- a/drivers/net/ethernet/ti/Makefile
>> +++ b/drivers/net/ethernet/ti/Makefile
>> @@ -37,5 +37,6 @@ icssg-prueth-y := k3-cppi-desc-pool.o \
>>  		  icssg/icssg_config.o \
>>  		  icssg/icssg_mii_cfg.o \
>>  		  icssg/icssg_stats.o \
>> -		  icssg/icssg_ethtool.o
>> +		  icssg/icssg_ethtool.o \
>> +		  icssg/icssg_qos.o
>>  obj-$(CONFIG_TI_ICSS_IEP) += icssg/icss_iep.o
>> diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.c b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
>> index 6635b28bc672..89c301716926 100644
>> --- a/drivers/net/ethernet/ti/icssg/icssg_prueth.c
>> +++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
>> @@ -1166,7 +1166,7 @@ static int emac_phy_connect(struct prueth_emac *emac)
>>  	return 0;
>>  }
>>  
>> -static u64 prueth_iep_gettime(void *clockops_data, struct ptp_system_timestamp *sts)
>> +u64 prueth_iep_gettime(void *clockops_data, struct ptp_system_timestamp *sts)
>>  {
>>  	u32 hi_rollover_count, hi_rollover_count_r;
>>  	struct prueth_emac *emac = clockops_data;
>> @@ -1403,6 +1403,8 @@ static int emac_ndo_open(struct net_device *ndev)
>>  		napi_enable(&emac->tx_chns[i].napi_tx);
>>  	napi_enable(&emac->napi_rx);
>>  
>> +	icssg_qos_tas_init(ndev);
> 
> I believe the intention is for this code to be run before any taprio
> offload is added, correct? But it is possible for the user to add an

Yes, the intention here is to run this code before any taprio offload is
added.

> offloaded Qdisc even while the netdev has not yet been brought up.
> Is that case handled correctly, or will it simply result in NULL pointer
> dereferences (tas->config_list)?
> 

In that case, it will eventually result in NULL pointer dereference as
tas->config_list will be pointing to NULL. To handle this correctly we
can add the below check in emac_taprio_replace().

if (!ndev_running(ndev)) {
	netdev_err(ndev, "Device is not running");
	return -EINVAL;
}

>> +
>>  	/* start PHY */
>>  	phy_start(ndev->phydev);
>>  
>> @@ -1669,6 +1671,7 @@ static const struct net_device_ops emac_netdev_ops = {
>>  	.ndo_set_rx_mode = emac_ndo_set_rx_mode,
>>  	.ndo_eth_ioctl = emac_ndo_ioctl,
>>  	.ndo_get_stats64 = emac_ndo_get_stats64,
>> +	.ndo_setup_tc = icssg_qos_ndo_setup_tc,
>>  };
>>  
>>  /* get emac_port corresponding to eth_node name */
>> diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.h b/drivers/net/ethernet/ti/icssg/icssg_prueth.h
>> index 8b6d6b497010..7cbf0e561905 100644
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
>> @@ -174,6 +175,8 @@ struct prueth_emac {
>>  
>>  	struct pruss_mem_region dram;
>>  
>> +	struct prueth_qos qos;
>> +
>>  	struct delayed_work stats_work;
>>  	u64 stats[ICSSG_NUM_STATS];
>>  };
>> @@ -285,4 +288,7 @@ u32 icssg_queue_level(struct prueth *prueth, int queue);
>>  void emac_stats_work_handler(struct work_struct *work);
>>  void emac_update_hardware_stats(struct prueth_emac *emac);
>>  int emac_get_stat_by_name(struct prueth_emac *emac, char *stat_name);
>> +
>> +u64 prueth_iep_gettime(void *clockops_data, struct ptp_system_timestamp *sts);
>> +
>>  #endif /* __NET_TI_ICSSG_PRUETH_H */
>> diff --git a/drivers/net/ethernet/ti/icssg/icssg_qos.c b/drivers/net/ethernet/ti/icssg/icssg_qos.c
>> new file mode 100644
>> index 000000000000..c8c4450c41bb
>> --- /dev/null
>> +++ b/drivers/net/ethernet/ti/icssg/icssg_qos.c
>> @@ -0,0 +1,301 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/* Texas Instruments ICSSG PRUETH QoS submodule
>> + * Copyright (C) 2023 Texas Instruments Incorporated - http://www.ti.com/
>> + */
>> +
>> +#include <linux/printk.h>
>> +#include "icssg_prueth.h"
>> +#include "icssg_switch_map.h"
>> +
>> +static void tas_update_fw_list_pointers(struct prueth_emac *emac)
>> +{
>> +	struct tas_config *tas = &emac->qos.tas.config;
>> +
>> +	if ((readb(tas->active_list)) == TAS_LIST0) {
>> +		tas->fw_active_list = emac->dram.va + TAS_GATE_MASK_LIST0;
>> +		tas->fw_shadow_list = emac->dram.va + TAS_GATE_MASK_LIST1;
>> +	} else {
>> +		tas->fw_active_list = emac->dram.va + TAS_GATE_MASK_LIST1;
>> +		tas->fw_shadow_list = emac->dram.va + TAS_GATE_MASK_LIST0;
>> +	}
>> +}
>> +
>> +static void tas_update_maxsdu_table(struct prueth_emac *emac)
>> +{
>> +	struct tas_config *tas = &emac->qos.tas.config;
>> +	u16 __iomem *max_sdu_tbl_ptr;
>> +	u8 gate_idx;
>> +
>> +	/* update the maxsdu table */
>> +	max_sdu_tbl_ptr = emac->dram.va + TAS_QUEUE_MAX_SDU_LIST;
>> +
>> +	for (gate_idx = 0; gate_idx < TAS_MAX_NUM_QUEUES; gate_idx++)
>> +		writew(tas->max_sdu_table.max_sdu[gate_idx], &max_sdu_tbl_ptr[gate_idx]);
>> +}
>> +
>> +static void tas_reset(struct prueth_emac *emac)
>> +{
>> +	struct tas_config *tas = &emac->qos.tas.config;
>> +	int i;
>> +
>> +	for (i = 0; i < TAS_MAX_NUM_QUEUES; i++)
>> +		tas->max_sdu_table.max_sdu[i] = 2048;
>> +
>> +	tas_update_maxsdu_table(emac);
>> +
>> +	writeb(TAS_LIST0, tas->active_list);
>> +
>> +	memset_io(tas->fw_active_list, 0, sizeof(*tas->fw_active_list));
>> +	memset_io(tas->fw_shadow_list, 0, sizeof(*tas->fw_shadow_list));
>> +}
>> +
>> +static int tas_set_state(struct prueth_emac *emac, enum tas_state state)
>> +{
>> +	struct tas_config *tas = &emac->qos.tas.config;
>> +	int ret;
>> +
>> +	if (tas->state == state)
>> +		return 0;
>> +
>> +	switch (state) {
>> +	case TAS_STATE_RESET:
>> +		tas_reset(emac);
>> +		ret = emac_set_port_state(emac, ICSSG_EMAC_PORT_TAS_RESET);
>> +		tas->state = TAS_STATE_RESET;
>> +		break;
>> +	case TAS_STATE_ENABLE:
>> +		ret = emac_set_port_state(emac, ICSSG_EMAC_PORT_TAS_ENABLE);
>> +		tas->state = TAS_STATE_ENABLE;
>> +		break;
>> +	case TAS_STATE_DISABLE:
>> +		ret = emac_set_port_state(emac, ICSSG_EMAC_PORT_TAS_DISABLE);
>> +		tas->state = TAS_STATE_DISABLE;
>> +		break;
>> +	default:
>> +		netdev_err(emac->ndev, "%s: unsupported state\n", __func__);
>> +		ret = -EINVAL;
>> +		break;
>> +	}
>> +
>> +	if (ret)
>> +		netdev_err(emac->ndev, "TAS set state failed %d\n", ret);
>> +	return ret;
>> +}
>> +
>> +static int tas_set_trigger_list_change(struct prueth_emac *emac)
>> +{
>> +	struct tc_taprio_qopt_offload *admin_list = emac->qos.tas.taprio_admin;
>> +	struct tas_config *tas = &emac->qos.tas.config;
>> +	struct ptp_system_timestamp sts;
>> +	u32 change_cycle_count;
>> +	u32 cycle_time;
>> +	u64 base_time;
>> +	u64 cur_time;
>> +
>> +	if (admin_list->cycle_time < TAS_MIN_CYCLE_TIME)
>> +		return -EINVAL;
> 
> Shouldn't this verification have been part of emac_taprio_replace(), and
> have a proper extack?
> 

Sure. I'll move this to emac_taprio_replace().

>> +
>> +	cycle_time = admin_list->cycle_time - 4; /* -4ns to compensate for IEP wraparound time */
> 
> Details? Doesn't this make the phase alignment of the schedule diverge
> from what the user expects?

4ns is needed to compensate for IEP wraparound time. IEP is the clock
used by ICSSG driver. IEP tick is 4ns and we adjust this 4ns whenever
calculating cycle_time. You may refer to [1] for details on IEP driver.

> 
>> +	base_time = admin_list->base_time;
>> +	cur_time = prueth_iep_gettime(emac, &sts);
>> +
>> +	if (base_time > cur_time)
>> +		change_cycle_count = DIV_ROUND_UP_ULL(base_time - cur_time, cycle_time);
>> +	else
>> +		change_cycle_count = 1;
> 
> I see that the base_time is only used to calculate the number of cycles
> relative to cur_time. Taprio users want to specify a basetime value
> which indicates the phase alignment of the schedule. This is important
> when the device is synchronized over PTP with other switches in the
> network. Can you explain how is the basetime taken into consideration in
> your implementation?
> 

In this implementation base_time is used only to obtain the
change_cycle_count and to write it to TAS_CONFIG_CHANGE_CYCLE_COUNT. In
this implementation base_time is not used for anything else.

>> +
>> +	writel(cycle_time, emac->dram.va + TAS_ADMIN_CYCLE_TIME);
>> +	writel(change_cycle_count, emac->dram.va + TAS_CONFIG_CHANGE_CYCLE_COUNT);
>> +	writeb(admin_list->num_entries, emac->dram.va + TAS_ADMIN_LIST_LENGTH);
>> +
>> +	/* config_change cleared by f/w to ack reception of new shadow list */
>> +	writeb(1, &tas->config_list->config_change);
>> +	/* config_pending cleared by f/w when new shadow list is copied to active list */
>> +	writeb(1, &tas->config_list->config_pending);
>> +
>> +	return emac_set_port_state(emac, ICSSG_EMAC_PORT_TAS_TRIGGER);
>> +}
>> +
>> +static int tas_update_oper_list(struct prueth_emac *emac)
>> +{
>> +	struct tc_taprio_qopt_offload *admin_list = emac->qos.tas.taprio_admin;
>> +	struct tas_config *tas = &emac->qos.tas.config;
>> +	u32 tas_acc_gate_close_time = 0;
>> +	u8 idx, gate_idx, val;
>> +	int ret;
>> +
>> +	if (admin_list->cycle_time > TAS_MAX_CYCLE_TIME)
>> +		return -EINVAL;
>> +
>> +	tas_update_fw_list_pointers(emac);
>> +
>> +	for (idx = 0; idx < admin_list->num_entries; idx++) {
>> +		writeb(admin_list->entries[idx].gate_mask,
>> +		       &tas->fw_shadow_list->gate_mask_list[idx]);
>> +		tas_acc_gate_close_time += admin_list->entries[idx].interval;
>> +
>> +		/* extend last entry till end of cycle time */
>> +		if (idx == admin_list->num_entries - 1)
>> +			writel(admin_list->cycle_time,
>> +			       &tas->fw_shadow_list->win_end_time_list[idx]);
>> +		else
>> +			writel(tas_acc_gate_close_time,
>> +			       &tas->fw_shadow_list->win_end_time_list[idx]);
>> +	}
>> +
>> +	/* clear remaining entries */
>> +	for (idx = admin_list->num_entries; idx < TAS_MAX_CMD_LISTS; idx++) {
>> +		writeb(0, &tas->fw_shadow_list->gate_mask_list[idx]);
>> +		writel(0, &tas->fw_shadow_list->win_end_time_list[idx]);
>> +	}
>> +
>> +	/* update the Array of gate close time for each queue in each window */
>> +	for (idx = 0 ; idx < admin_list->num_entries; idx++) {
>> +		/* On Linux, only PRUETH_MAX_TX_QUEUES are supported per port */
>> +		for (gate_idx = 0; gate_idx < PRUETH_MAX_TX_QUEUES; gate_idx++) {
>> +			u8 gate_mask_list_idx = readb(&tas->fw_shadow_list->gate_mask_list[idx]);
>> +			u32 gate_close_time = 0;
>> +
>> +			if (gate_mask_list_idx & BIT(gate_idx))
>> +				gate_close_time = readl(&tas->fw_shadow_list->win_end_time_list[idx]);
>> +
>> +			writel(gate_close_time,
>> +			       &tas->fw_shadow_list->gate_close_time_list[idx][gate_idx]);
>> +		}
>> +	}
>> +
>> +	/* tell f/w to swap active & shadow list */
>> +	ret = tas_set_trigger_list_change(emac);
>> +	if (ret) {
>> +		netdev_err(emac->ndev, "failed to swap f/w config list: %d\n", ret);
>> +		return ret;
>> +	}
>> +
>> +	/* Wait for completion */
>> +	ret = readb_poll_timeout(&tas->config_list->config_change, val, !val,
>> +				 USEC_PER_MSEC, 10 * USEC_PER_MSEC);
>> +	if (ret) {
>> +		netdev_err(emac->ndev, "TAS list change completion time out\n");
>> +		return ret;
>> +	}
>> +
>> +	tas_update_fw_list_pointers(emac);
>> +
>> +	return 0;
>> +}
>> +
>> +static void emac_cp_taprio(struct tc_taprio_qopt_offload *from,
>> +			   struct tc_taprio_qopt_offload *to)
>> +{
>> +	int i;
>> +
>> +	*to = *from;
>> +	for (i = 0; i < from->num_entries; i++)
>> +		to->entries[i] = from->entries[i];
>> +}
>> +
>> +static int emac_taprio_replace(struct net_device *ndev,
>> +			       struct tc_taprio_qopt_offload *taprio)
>> +{
>> +	struct prueth_emac *emac = netdev_priv(ndev);
>> +	struct tc_taprio_qopt_offload *est_new;
>> +	int ret, idx;
>> +
>> +	if (taprio->cycle_time_extension) {
>> +		netdev_err(ndev, "Failed to set cycle time extension");
> 
> "failed" implies that the driver tried to do something, but it didn't work.
> Maybe "Cycle time extension not supported"? Also, NL_SET_ERR_MSG_MOD().
> 

Sure, I'll change it to below,

if (taprio->cycle_time_extension) {
	NL_SET_ERR_MSG_MOD(taprio->extack, "Cycle time extension not supported");
	return -EOPNOTSUPP;
}

>> +		return -EOPNOTSUPP;
>> +	}
>> +
>> +	if (taprio->num_entries == 0 ||
> 
> Cannot happen. See sch_taprio.c:
> 

Sure. I'll remove this check.

> 	if (new_admin->num_entries == 0) {
> 		NL_SET_ERR_MSG(extack, "There should be at least one entry in the schedule");
> 		err = -EINVAL;
> 		goto free_sched;
> 	}
> 
>> +	    taprio->num_entries > TAS_MAX_CMD_LISTS) {
>> +		NL_SET_ERR_MSG_FMT_MOD(taprio->extack, "unsupported num_entries %ld in taprio config\n",
>> +				       taprio->num_entries);
> 
> Better to say what's the hardware maximum, than to report back num_entries
> as being not supported.
> 

Sure, I'll change it to below,

if (taprio->num_entries > TAS_MAX_CMD_LISTS) {
	NL_SET_ERR_MSG_FMT_MOD(taprio->extack, "num_entries %ld is more than
maximum supported entries %ld in taprio config\n",
				       taprio->num_entries, TAS_MAX_CMD_LISTS);
	return -EINVAL;
}

>> +		return -EINVAL;
>> +	}
>> +
>> +	/* If any time_interval is 0 in between the list, then exit */
>> +	for (idx = 0; idx < taprio->num_entries; idx++) {
>> +		if (taprio->entries[idx].interval == 0) {
>> +			NL_SET_ERR_MSG_MOD(taprio->extack, "0 interval in taprio config not supported\n");
>> +			return -EINVAL;
>> +		}
>> +	}
> 
> Also not possible, see fill_sched_entry()

Sure. I'll remove this check.

> 
> 	/* The interval should allow at least the minimum ethernet
> 	 * frame to go out.
> 	 */
> 	if (interval < min_duration) {
> 		NL_SET_ERR_MSG(extack, "Invalid interval for schedule entry");
> 		return -EINVAL;
> 	}
> 
>> +
>> +	if (emac->qos.tas.taprio_admin)
>> +		devm_kfree(&ndev->dev, emac->qos.tas.taprio_admin);
>> +
>> +	est_new = devm_kzalloc(&ndev->dev,
>> +			       struct_size(est_new, entries, taprio->num_entries),
>> +			       GFP_KERNEL);
>> +	if (!est_new)
>> +		return -ENOMEM;
> 
> You don't need to allocate est_new, you can keep a reference on taprio
> using taprio_offload_get(), and call taprio_offload_put() to release the
> reference when you're done with it.
> 

Sure. I will not allocate est_new. Instead I'll set taprio_admin to
taprio_offload_get(taprio) and call taprio_offload_free(taprio) when
it's done.

>> +
>> +	emac_cp_taprio(taprio, est_new);
>> +	emac->qos.tas.taprio_admin = est_new;
>> +	ret = tas_update_oper_list(emac);
>> +	if (ret)
>> +		return ret;
>> +
>> +	ret =  tas_set_state(emac, TAS_STATE_ENABLE);
>> +	if (ret)
>> +		devm_kfree(&ndev->dev, est_new);
>> +
>> +	return ret;
>> +}

Below is how the code will look like.

	emac->qos.tas.taprio_admin = taprio_offload_get(taprio);
	ret = tas_update_oper_list(emac);
	if (ret)
		return ret;

	ret = tas_set_state(emac, TAS_STATE_ENABLE);
	if (ret) {
		emac->qos.tas.taprio_admin = NULL;
		taprio_offload_free(taprio);
	}

	return ret;

Please let me know if all of these changes looks ok, I'll resend the
patch once you confirm. Thanks for reviewing.

[1]
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/net/ethernet/ti/icssg/icss_iep.c?h=v6.7

-- 
Thanks and Regards,
Danish


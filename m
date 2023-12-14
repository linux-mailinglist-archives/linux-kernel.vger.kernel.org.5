Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9E248131B0
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 14:36:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573373AbjLNNf6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 08:35:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573348AbjLNNf5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 08:35:57 -0500
X-Greylist: delayed 1154 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 14 Dec 2023 05:36:02 PST
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A0C1118;
        Thu, 14 Dec 2023 05:36:02 -0800 (PST)
Received: from mail.maildlp.com (unknown [172.19.88.234])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4SrXsN4LxQz1Q6P2;
        Thu, 14 Dec 2023 21:15:36 +0800 (CST)
Received: from dggpeml500022.china.huawei.com (unknown [7.185.36.66])
        by mail.maildlp.com (Postfix) with ESMTPS id 67D761400CB;
        Thu, 14 Dec 2023 21:16:45 +0800 (CST)
Received: from [10.67.120.135] (10.67.120.135) by
 dggpeml500022.china.huawei.com (7.185.36.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 14 Dec 2023 21:16:45 +0800
Subject: Re: [PATCH net-next v4 2/4] octeon_ep: PF-VF mailbox version support
To:     Shinas Rasheed <srasheed@marvell.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <hgani@marvell.com>, <vimleshk@marvell.com>, <egallen@redhat.com>,
        <mschmidt@redhat.com>, <pabeni@redhat.com>, <horms@kernel.org>,
        <kuba@kernel.org>, <davem@davemloft.net>, <wizhao@redhat.com>,
        <kheib@redhat.com>, <konguyen@redhat.com>,
        Veerasenareddy Burru <vburru@marvell.com>,
        Sathesh Edara <sedara@marvell.com>,
        Eric Dumazet <edumazet@google.com>
References: <20231213035816.2656851-1-srasheed@marvell.com>
 <20231213035816.2656851-3-srasheed@marvell.com>
From:   "shenjian (K)" <shenjian15@huawei.com>
Message-ID: <59426716-2f97-2f08-1d9f-84ce6483cfa9@huawei.com>
Date:   Thu, 14 Dec 2023 21:16:44 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <20231213035816.2656851-3-srasheed@marvell.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.120.135]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpeml500022.china.huawei.com (7.185.36.66)
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2023/12/13 11:58, Shinas Rasheed 写道:
> Add PF-VF mailbox initial version support
>
> Signed-off-by: Shinas Rasheed <srasheed@marvell.com>
> ---
> V4:
>    - No changes
>
> V3: https://lore.kernel.org/all/20231211063355.2630028-3-srasheed@marvell.com/
>    - No changes
>
> V2: https://lore.kernel.org/all/20231209081450.2613561-3-srasheed@marvell.com/
>    - No changes
>
> V1: https://lore.kernel.org/all/20231208070352.2606192-3-srasheed@marvell.com/
>
>   .../net/ethernet/marvell/octeon_ep/octep_main.h   |  1 +
>   .../ethernet/marvell/octeon_ep/octep_pfvf_mbox.c  | 15 ++++++++++++---
>   .../ethernet/marvell/octeon_ep/octep_pfvf_mbox.h  |  7 +++++--
>   3 files changed, 18 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/net/ethernet/marvell/octeon_ep/octep_main.h b/drivers/net/ethernet/marvell/octeon_ep/octep_main.h
> index 3223bb6f95ea..fee59e0e0138 100644
> --- a/drivers/net/ethernet/marvell/octeon_ep/octep_main.h
> +++ b/drivers/net/ethernet/marvell/octeon_ep/octep_main.h
> @@ -220,6 +220,7 @@ struct octep_iface_link_info {
>   /* The Octeon VF device specific info data structure.*/
>   struct octep_pfvf_info {
>   	u8 mac_addr[ETH_ALEN];
> +	u32 mbox_version;
>   };
>   
>   /* The Octeon device specific private data structure.
> diff --git a/drivers/net/ethernet/marvell/octeon_ep/octep_pfvf_mbox.c b/drivers/net/ethernet/marvell/octeon_ep/octep_pfvf_mbox.c
> index 43b40e91f7bf..baffe298a2a0 100644
> --- a/drivers/net/ethernet/marvell/octeon_ep/octep_pfvf_mbox.c
> +++ b/drivers/net/ethernet/marvell/octeon_ep/octep_pfvf_mbox.c
> @@ -28,10 +28,18 @@ static void octep_pfvf_validate_version(struct octep_device *oct,  u32 vf_id,
>   {
>   	u32 vf_version = (u32)cmd.s_version.version;
>   
> -	if (vf_version <= OCTEP_PFVF_MBOX_VERSION_V1)
> -		rsp->s_version.type = OCTEP_PFVF_MBOX_TYPE_RSP_ACK;
> +	dev_dbg(&oct->pdev->dev, "VF id:%d VF version:%d PF version:%d\n",
> +		vf_id, vf_version, OCTEP_PFVF_MBOX_VERSION_CURRENT);
> +	if (vf_version < OCTEP_PFVF_MBOX_VERSION_CURRENT)
> +		rsp->s_version.version = vf_version;
>   	else
> -		rsp->s_version.type = OCTEP_PFVF_MBOX_TYPE_RSP_NACK;
> +		rsp->s_version.version = OCTEP_PFVF_MBOX_VERSION_CURRENT;
> +
> +	oct->vf_info[vf_id].mbox_version = rsp->s_version.version;
> +	dev_dbg(&oct->pdev->dev, "VF id:%d negotiated VF version:%d\n",
> +		vf_id, oct->vf_info[vf_id].mbox_version);
> +
> +	rsp->s_version.type = OCTEP_PFVF_MBOX_TYPE_RSP_ACK;
>   }
>   
>   static void octep_pfvf_get_link_status(struct octep_device *oct, u32 vf_id,
> @@ -167,6 +175,7 @@ int octep_setup_pfvf_mbox(struct octep_device *oct)
>   			goto free_mbox;
>   
>   		memset(oct->mbox[ring], 0, sizeof(struct octep_mbox));
> +		memset(&oct->vf_info[i], 0, sizeof(struct octep_pfvf_info));
>   		mutex_init(&oct->mbox[ring]->lock);
>   		INIT_WORK(&oct->mbox[ring]->wk.work, octep_pfvf_mbox_work);
>   		oct->mbox[ring]->wk.ctxptr = oct->mbox[ring];
> diff --git a/drivers/net/ethernet/marvell/octeon_ep/octep_pfvf_mbox.h b/drivers/net/ethernet/marvell/octeon_ep/octep_pfvf_mbox.h
> index 34feeb559b0d..af4dcf5ef7f1 100644
> --- a/drivers/net/ethernet/marvell/octeon_ep/octep_pfvf_mbox.h
> +++ b/drivers/net/ethernet/marvell/octeon_ep/octep_pfvf_mbox.h
> @@ -13,11 +13,15 @@
>   #define OCTEON_SDP_16K_HW_FRS  16380UL
>   #define OCTEON_SDP_64K_HW_FRS  65531UL
>   
> +/* When a new command is implemented,PF Mbox version should be bumped.
> + */
>   enum octep_pfvf_mbox_version {
>   	OCTEP_PFVF_MBOX_VERSION_V0,
>   	OCTEP_PFVF_MBOX_VERSION_V1,
>   };
>   
> +#define OCTEP_PFVF_MBOX_VERSION_CURRENT	OCTEP_PFVF_MBOX_VERSION_V1
> +
>   enum octep_pfvf_mbox_opcode {
>   	OCTEP_PFVF_MBOX_CMD_VERSION,
>   	OCTEP_PFVF_MBOX_CMD_SET_MTU,
> @@ -30,7 +34,7 @@ enum octep_pfvf_mbox_opcode {
>   	OCTEP_PFVF_MBOX_CMD_GET_LINK_STATUS,
>   	OCTEP_PFVF_MBOX_CMD_GET_MTU,
>   	OCTEP_PFVF_MBOX_CMD_DEV_REMOVE,
> -	OCTEP_PFVF_MBOX_CMD_LAST,
> +	OCTEP_PFVF_MBOX_CMD_MAX,
>   };
This change is unrelative with
this enum is introduced in the first patch, why not directly rename it 
in the first one?

>   
>   enum octep_pfvf_mbox_word_type {
> @@ -79,7 +83,6 @@ enum octep_pfvf_link_autoneg {
>   
>   #define OCTEP_PFVF_MBOX_TIMEOUT_MS     500
>   #define OCTEP_PFVF_MBOX_MAX_RETRIES    2
> -#define OCTEP_PFVF_MBOX_VERSION        0
Similar here,  you introduce it in first patch, and no place used, then 
remove it int the second one.
Maybe you can reorganize this patchset ?

>   #define OCTEP_PFVF_MBOX_MAX_DATA_SIZE  6
>   #define OCTEP_PFVF_MBOX_MORE_FRAG_FLAG 1
>   #define OCTEP_PFVF_MBOX_WRITE_WAIT_TIME msecs_to_jiffies(1)


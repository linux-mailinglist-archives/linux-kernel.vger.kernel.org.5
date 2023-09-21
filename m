Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D37367AA5AE
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 01:37:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230150AbjIUXhW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 19:37:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbjIUXhV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 19:37:21 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6852DF7;
        Thu, 21 Sep 2023 16:37:14 -0700 (PDT)
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38LNaVq3019344;
        Thu, 21 Sep 2023 23:37:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : from : subject : to : cc : references : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=EO/d9pHekLqRpgsfzm2Ra1JOPWYWuC4JKQlVK5hjhhA=;
 b=T0q5uCQuREtvugGsjcjC7XVvlb8JAgLxenZ048lNxrr8teV4asoMhem+EmlKbH+yuyaM
 VtI/megQtpDZ+ndDSHCCSOQwpCjSZwLD7oCcUjiR61L8JUjbNdDjqkcxLisZjsKItHGs
 svzxCRZOfZYq7D1kqfgh+UbirSR9WyGTIvdPQz2X7yoTmkNPwwqYMP2hkBFfO1NJYQdY
 0kXGXlel7agSMsH3L3MT/qx0gGjIBFRvuF7P7WVcykV9V6UfX5sQSImz0JVk72yDbpcJ
 fRyxloD/22lCUT2pS1/iJSVmeDsnQN+H6GZRBAq7RhAiCU2qd0+viyEPMeBJVvFrxh7L wQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3t8xvg91ru-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 21 Sep 2023 23:37:08 +0000
Received: from m0353722.ppops.net (m0353722.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 38LNb4X0022362;
        Thu, 21 Sep 2023 23:37:04 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3t8xvg9169-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 21 Sep 2023 23:37:04 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
        by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 38LN8Hv2015471;
        Thu, 21 Sep 2023 23:31:56 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
        by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3t8tsp4rpt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 21 Sep 2023 23:31:56 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
        by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 38LNVuO020906610
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Sep 2023 23:31:56 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E04975805F;
        Thu, 21 Sep 2023 23:31:55 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9210258043;
        Thu, 21 Sep 2023 23:31:53 +0000 (GMT)
Received: from [9.171.4.137] (unknown [9.171.4.137])
        by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Thu, 21 Sep 2023 23:31:53 +0000 (GMT)
Message-ID: <881e43f8-54e0-4847-67c4-82b9c0b3e50c@linux.ibm.com>
Date:   Fri, 22 Sep 2023 01:31:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
From:   Wenjia Zhang <wenjia@linux.ibm.com>
Subject: Re: [PATCH net-next v3 12/18] net/smc: implement DMB-related
 operations of loopback
To:     Wen Gu <guwen@linux.alibaba.com>, kgraul@linux.ibm.com,
        jaka@linux.ibm.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com
Cc:     alibuda@linux.alibaba.com, tonylu@linux.alibaba.com,
        linux-s390@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1695302360-46691-1-git-send-email-guwen@linux.alibaba.com>
 <1695302360-46691-13-git-send-email-guwen@linux.alibaba.com>
In-Reply-To: <1695302360-46691-13-git-send-email-guwen@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: yXKKzDRr1JKdcoHGtq4N7wSiX_CjoCuA
X-Proofpoint-GUID: 636YQuLCp2OOa0fo0e_k2ywgefInpqJ9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-21_19,2023-09-21_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 priorityscore=1501 spamscore=0 malwarescore=0 mlxlogscore=874 mlxscore=0
 lowpriorityscore=0 phishscore=0 clxscore=1011 impostorscore=0
 suspectscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2309180000 definitions=main-2309210205
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 21.09.23 15:19, Wen Gu wrote:
> This patch implements DMB registration, unregistration and data move
> operations of SMC-D loopback.
> 
> Signed-off-by: Wen Gu <guwen@linux.alibaba.com>
> ---
>   net/smc/smc_cdc.c      |   6 +++
>   net/smc/smc_cdc.h      |   1 +
>   net/smc/smc_loopback.c | 128 +++++++++++++++++++++++++++++++++++++++++++++++--
>   net/smc/smc_loopback.h |  13 +++++
>   4 files changed, 145 insertions(+), 3 deletions(-)
> 
> diff --git a/net/smc/smc_cdc.c b/net/smc/smc_cdc.c
> index 89105e9..2641800 100644
> --- a/net/smc/smc_cdc.c
> +++ b/net/smc/smc_cdc.c
> @@ -411,6 +411,12 @@ static void smc_cdc_msg_recv(struct smc_sock *smc, struct smc_cdc_msg *cdc)
>   static void smcd_cdc_rx_tsklet(struct tasklet_struct *t)
>   {
>   	struct smc_connection *conn = from_tasklet(conn, t, rx_tsklet);
> +
> +	smcd_cdc_rx_handler(conn);
> +}
> +
> +void smcd_cdc_rx_handler(struct smc_connection *conn)
> +{
>   	struct smcd_cdc_msg *data_cdc;
>   	struct smcd_cdc_msg cdc;
>   	struct smc_sock *smc;
> diff --git a/net/smc/smc_cdc.h b/net/smc/smc_cdc.h
> index 696cc11..11559d4 100644
> --- a/net/smc/smc_cdc.h
> +++ b/net/smc/smc_cdc.h
> @@ -301,5 +301,6 @@ int smcr_cdc_msg_send_validation(struct smc_connection *conn,
>   				 struct smc_wr_buf *wr_buf);
>   int smc_cdc_init(void) __init;
>   void smcd_cdc_rx_init(struct smc_connection *conn);
> +void smcd_cdc_rx_handler(struct smc_connection *conn);
>   
>   #endif /* SMC_CDC_H */
> diff --git a/net/smc/smc_loopback.c b/net/smc/smc_loopback.c
> index 9034ebd..cfbcabf 100644
> --- a/net/smc/smc_loopback.c
> +++ b/net/smc/smc_loopback.c
> @@ -16,6 +16,7 @@
>   #include <linux/smc.h>
>   #include <net/smc.h>
>   
> +#include "smc_cdc.h"
>   #include "smc_ism.h"
>   #include "smc_loopback.h"
>   
> @@ -74,6 +75,93 @@ static int smc_lo_query_rgid(struct smcd_dev *smcd, struct smcd_gid *rgid,
>   	return 0;
>   }
>   
> +static int smc_lo_register_dmb(struct smcd_dev *smcd, struct smcd_dmb *dmb,
> +			       void *client_priv)
> +{
> +	struct smc_lo_dmb_node *dmb_node, *tmp_node;
> +	struct smc_lo_dev *ldev = smcd->priv;
> +	int sba_idx, rc;
> +
> +	/* check space for new dmb */
> +	for_each_clear_bit(sba_idx, ldev->sba_idx_mask, SMC_LODEV_MAX_DMBS) {
> +		if (!test_and_set_bit(sba_idx, ldev->sba_idx_mask))
> +			break;
> +	}
> +	if (sba_idx == SMC_LODEV_MAX_DMBS)
> +		return -ENOSPC;
> +
> +	dmb_node = kzalloc(sizeof(*dmb_node), GFP_KERNEL);
> +	if (!dmb_node) {
> +		rc = -ENOMEM;
> +		goto err_bit;
> +	}
> +
> +	dmb_node->sba_idx = sba_idx;
> +	dmb_node->cpu_addr = kzalloc(dmb->dmb_len, GFP_KERNEL |
> +				     __GFP_NOWARN | __GFP_NORETRY |
> +				     __GFP_NOMEMALLOC);
kzalloc()/kmalloc() allocates physically contigueous memory. Are you 
sure it is suitable for allocating the dmb?

> +	if (!dmb_node->cpu_addr) {
> +		rc = -ENOMEM;
> +		goto err_node;
> +	}
> +	dmb_node->len = dmb->dmb_len;
> +	dmb_node->dma_addr = (dma_addr_t)dmb_node->cpu_addr;
> +
> +again:
> +	/* add new dmb into hash table */
> +	get_random_bytes(&dmb_node->token, sizeof(dmb_node->token));
> +	write_lock(&ldev->dmb_ht_lock);
> +	hash_for_each_possible(ldev->dmb_ht, tmp_node, list, dmb_node->token) {
> +		if (tmp_node->token == dmb_node->token) {
> +			write_unlock(&ldev->dmb_ht_lock);
> +			goto again;
> +		}
> +	}
> +	hash_add(ldev->dmb_ht, &dmb_node->list, dmb_node->token);
> +	write_unlock(&ldev->dmb_ht_lock);
> +
> +	dmb->sba_idx = dmb_node->sba_idx;
> +	dmb->dmb_tok = dmb_node->token;
> +	dmb->cpu_addr = dmb_node->cpu_addr;
> +	dmb->dma_addr = dmb_node->dma_addr;
> +	dmb->dmb_len = dmb_node->len;
> +
> +	return 0;
> +
> +err_node:
> +	kfree(dmb_node);
> +err_bit:
> +	clear_bit(sba_idx, ldev->sba_idx_mask);
> +	return rc;
> +}
> +
> +static int smc_lo_unregister_dmb(struct smcd_dev *smcd, struct smcd_dmb *dmb)
> +{
> +	struct smc_lo_dmb_node *dmb_node = NULL, *tmp_node;
> +	struct smc_lo_dev *ldev = smcd->priv;
> +
> +	/* remove dmb from hash table */
> +	write_lock(&ldev->dmb_ht_lock);
> +	hash_for_each_possible(ldev->dmb_ht, tmp_node, list, dmb->dmb_tok) {
> +		if (tmp_node->token == dmb->dmb_tok) {
> +			dmb_node = tmp_node;
> +			break;
> +		}
> +	}
> +	if (!dmb_node) {
> +		write_unlock(&ldev->dmb_ht_lock);
> +		return -EINVAL;
> +	}
> +	hash_del(&dmb_node->list);
> +	write_unlock(&ldev->dmb_ht_lock);
> +
> +	clear_bit(dmb_node->sba_idx, ldev->sba_idx_mask);
> +	kfree(dmb_node->cpu_addr);
> +	kfree(dmb_node);
> +
> +	return 0;
> +}
> +
>   static int smc_lo_add_vlan_id(struct smcd_dev *smcd, u64 vlan_id)
>   {
>   	return -EOPNOTSUPP;
> @@ -100,6 +188,38 @@ static int smc_lo_signal_event(struct smcd_dev *dev, struct smcd_gid *rgid,
>   	return 0;
>   }
>   
> +static int smc_lo_move_data(struct smcd_dev *smcd, u64 dmb_tok, unsigned int idx,
> +			    bool sf, unsigned int offset, void *data,
> +			    unsigned int size)
> +{
> +	struct smc_lo_dmb_node *rmb_node = NULL, *tmp_node;
> +	struct smc_lo_dev *ldev = smcd->priv;
> +
> +	read_lock(&ldev->dmb_ht_lock);
> +	hash_for_each_possible(ldev->dmb_ht, tmp_node, list, dmb_tok) {
> +		if (tmp_node->token == dmb_tok) {
> +			rmb_node = tmp_node;
> +			break;
> +		}
> +	}
> +	if (!rmb_node) {
> +		read_unlock(&ldev->dmb_ht_lock);
> +		return -EINVAL;
> +	}
> +	read_unlock(&ldev->dmb_ht_lock);
> +
> +	memcpy((char *)rmb_node->cpu_addr + offset, data, size);
> +
> +	if (sf) {
> +		struct smc_connection *conn =
> +			smcd->conn[rmb_node->sba_idx];
> +
> +		if (conn && !conn->killed)
> +			smcd_cdc_rx_handler(conn);
> +	}
> +	return 0;
> +}
> +
>   static int smc_lo_supports_v2(void)
>   {
>   	return SMC_LO_SUPPORTS_V2;
> @@ -131,14 +251,14 @@ static struct device *smc_lo_get_dev(struct smcd_dev *smcd)
>   
>   static const struct smcd_ops lo_ops = {
>   	.query_remote_gid = smc_lo_query_rgid,
> -	.register_dmb		= NULL,
> -	.unregister_dmb		= NULL,
> +	.register_dmb = smc_lo_register_dmb,
> +	.unregister_dmb = smc_lo_unregister_dmb,
>   	.add_vlan_id = smc_lo_add_vlan_id,
>   	.del_vlan_id = smc_lo_del_vlan_id,
>   	.set_vlan_required = smc_lo_set_vlan_required,
>   	.reset_vlan_required = smc_lo_reset_vlan_required,
>   	.signal_event = smc_lo_signal_event,
> -	.move_data		= NULL,
> +	.move_data = smc_lo_move_data,
>   	.supports_v2 = smc_lo_supports_v2,
>   	.get_system_eid = smc_lo_get_system_eid,
>   	.get_local_gid = smc_lo_get_local_gid,
> @@ -212,6 +332,8 @@ static void smc_lo_dev_release(struct device *dev)
>   static int smc_lo_dev_init(struct smc_lo_dev *ldev)
>   {
>   	smc_lo_generate_id(ldev);
> +	rwlock_init(&ldev->dmb_ht_lock);
> +	hash_init(ldev->dmb_ht);
>   
>   	return smcd_lo_register_dev(ldev);
>   }
> diff --git a/net/smc/smc_loopback.h b/net/smc/smc_loopback.h
> index 2156f22..943424f 100644
> --- a/net/smc/smc_loopback.h
> +++ b/net/smc/smc_loopback.h
> @@ -20,12 +20,25 @@
>   
>   #define SMC_LO_CHID 0xFFFF
>   #define SMC_LODEV_MAX_DMBS 5000
> +#define SMC_LODEV_DMBS_HASH_BITS 12
> +
> +struct smc_lo_dmb_node {
> +	struct hlist_node list;
> +	u64 token;
> +	u32 len;
> +	u32 sba_idx;
> +	void *cpu_addr;
> +	dma_addr_t dma_addr;
> +};
>   
>   struct smc_lo_dev {
>   	struct smcd_dev *smcd;
>   	struct device dev;
>   	u16 chid;
>   	struct smcd_gid local_gid;
> +	DECLARE_BITMAP(sba_idx_mask, SMC_LODEV_MAX_DMBS);
> +	rwlock_t dmb_ht_lock;
> +	DECLARE_HASHTABLE(dmb_ht, SMC_LODEV_DMBS_HASH_BITS);
>   };
>   
>   int smc_loopback_init(void);

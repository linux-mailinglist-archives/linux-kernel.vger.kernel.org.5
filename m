Return-Path: <linux-kernel+bounces-78452-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 528508613B8
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 15:13:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0383A284BB8
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 14:13:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A80780BE4;
	Fri, 23 Feb 2024 14:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="sHqx16oE"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A48C27FBD9;
	Fri, 23 Feb 2024 14:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708697597; cv=none; b=Gs86bCaUX7GeS+4/IDzwGPMj9lcxgOY/jS/aZpVLInysdaM4RBMUR/HYIw9VQfbUrhfUeoe6FdC7LPL+aP2x/Zf1Kx7i2djalqrtZF7rJRBuwb60221tWt1Wcb5DJ5ZyNXvGhBL3F6Nm8J02UGhcFL3rQ8KkdI77UXadeCnSLUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708697597; c=relaxed/simple;
	bh=phVhooZ/MTs1+62yOFmazVhZyc4WnpKkUOXoFooggh8=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=WwQ2PdhAAAhKMjnSCX1NAEm7o1/q5NBBMOcewmrGFm4Eg6yf4RCLroI4uv1awu/173Wa1QIL/HURxAbuA9KxB9tcy76Za/9uVD1WYt00w1L31nSDY48Bg5MJnYpw7jPNXdkZ+kwGJpJy3hLIaaOZRV6/NigCRnLmstKO4CweyTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=sHqx16oE; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41NE7HES015212;
	Fri, 23 Feb 2024 14:13:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : from : subject : to : cc : references : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=Cb5FpcCRI9ynnROlJT7pd1Dc9SHm+Cgby9OdbwA7C6M=;
 b=sHqx16oE8phvmJgbUoqFfHsiv/oYXTQPI7HaJPTg0r1qomc2oFrkAh8KXPWmn0ghs4wd
 VDY1AQNoFiplREV57fVe1TdqKLxZW6qMZpGviYe4qjBXLO61e1KlVp3gGADgIHc35i2u
 QquQ4kRtMnN+G0N9eUMzkmydF7r2ztRreyBZNXSk0rvakAi8X/k40OU/7UuT+DhMqO2u
 t0jRxz1aDWR6wDf6kSbdAAr3ajaSKnW4oQRX6dt13DO8qmctDJIj9mUI1oy9d/St7V5t
 DYK25BFX3hMZpU5aMSrtW33f7eyRMUsk7w9YG1aqda/7wt1tKQdqGYynJCwWFC/A0nd8 aA== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wetxuu2rx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Feb 2024 14:13:07 +0000
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 41NE84xM020689;
	Fri, 23 Feb 2024 14:13:07 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wetxuu2r6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Feb 2024 14:13:07 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 41NBI8Yq009540;
	Fri, 23 Feb 2024 14:13:06 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3wb84pwt23-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Feb 2024 14:13:06 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 41NED3Tq7078438
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 23 Feb 2024 14:13:05 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1F90658059;
	Fri, 23 Feb 2024 14:13:03 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C81295806A;
	Fri, 23 Feb 2024 14:12:59 +0000 (GMT)
Received: from [9.171.73.236] (unknown [9.171.73.236])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 23 Feb 2024 14:12:59 +0000 (GMT)
Message-ID: <2fe9e5e0-aa5a-41e8-a2b3-80db0208cfa9@linux.ibm.com>
Date: Fri, 23 Feb 2024 15:12:58 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Wenjia Zhang <wenjia@linux.ibm.com>
Subject: Re: [PATCH net-next 06/15] net/smc: implement DMB-related operations
 of loopback-ism
To: Wen Gu <guwen@linux.alibaba.com>, wintera@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com, agordeev@linux.ibm.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        jaka@linux.ibm.com, Gerd Bayer <gbayer@linux.ibm.com>
Cc: borntraeger@linux.ibm.com, svens@linux.ibm.com, alibuda@linux.alibaba.com,
        tonylu@linux.alibaba.com, linux-s390@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240111120036.109903-1-guwen@linux.alibaba.com>
 <20240111120036.109903-7-guwen@linux.alibaba.com>
 <b5b4b96f-e512-4c1a-b749-f9fc3e7c2fcf@linux.ibm.com>
 <a06cdb50-591b-4984-b7d5-7ab758569d21@linux.alibaba.com>
Content-Language: en-GB
In-Reply-To: <a06cdb50-591b-4984-b7d5-7ab758569d21@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: YuG2ZLXkCxjwpAYMYjrK2YsGgWKwje5B
X-Proofpoint-ORIG-GUID: jFb1KQo3tSrfPidEzDU5Omo9nxWqVCsS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-22_15,2024-02-23_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=894 spamscore=0
 mlxscore=0 suspectscore=0 lowpriorityscore=0 impostorscore=0
 malwarescore=0 clxscore=1015 priorityscore=1501 phishscore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402230103



On 20.02.24 02:55, Wen Gu wrote:
> 
> 
> On 2024/2/16 22:13, Wenjia Zhang wrote:
>>
>>
>> On 11.01.24 13:00, Wen Gu wrote:
>>> This implements DMB (un)registration and data move operations of
>>> loopback-ism device.
>>>
>>> Signed-off-by: Wen Gu <guwen@linux.alibaba.com>
>>> ---
>>>   net/smc/smc_cdc.c      |   6 ++
>>>   net/smc/smc_cdc.h      |   1 +
>>>   net/smc/smc_loopback.c | 133 ++++++++++++++++++++++++++++++++++++++++-
>>>   net/smc/smc_loopback.h |  13 ++++
>>>   4 files changed, 150 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/net/smc/smc_cdc.c b/net/smc/smc_cdc.c
>>> index 3c06625ceb20..c820ef197610 100644
>>> --- a/net/smc/smc_cdc.c
>>> +++ b/net/smc/smc_cdc.c
>>> @@ -410,6 +410,12 @@ static void smc_cdc_msg_recv(struct smc_sock 
>>> *smc, struct smc_cdc_msg *cdc)
>>>   static void smcd_cdc_rx_tsklet(struct tasklet_struct *t)
>>>   {
>>>       struct smc_connection *conn = from_tasklet(conn, t, rx_tsklet);
>>> +
>>> +    smcd_cdc_rx_handler(conn);
>>> +}
>>> +
>>> +void smcd_cdc_rx_handler(struct smc_connection *conn)
>>> +{
>>>       struct smcd_cdc_msg *data_cdc;
>>>       struct smcd_cdc_msg cdc;
>>>       struct smc_sock *smc;
>>> diff --git a/net/smc/smc_cdc.h b/net/smc/smc_cdc.h
>>> index 696cc11f2303..11559d4ebf2b 100644
>>> --- a/net/smc/smc_cdc.h
>>> +++ b/net/smc/smc_cdc.h
>>> @@ -301,5 +301,6 @@ int smcr_cdc_msg_send_validation(struct 
>>> smc_connection *conn,
>>>                    struct smc_wr_buf *wr_buf);
>>>   int smc_cdc_init(void) __init;
>>>   void smcd_cdc_rx_init(struct smc_connection *conn);
>>> +void smcd_cdc_rx_handler(struct smc_connection *conn);
>>>   #endif /* SMC_CDC_H */
>>> diff --git a/net/smc/smc_loopback.c b/net/smc/smc_loopback.c
>>> index 353d4a2d69a1..f72e7b24fc1a 100644
>>> --- a/net/smc/smc_loopback.c
>>> +++ b/net/smc/smc_loopback.c
>>> @@ -15,11 +15,13 @@
>>>   #include <linux/types.h>
>>>   #include <net/smc.h>
>>> +#include "smc_cdc.h"
>>>   #include "smc_ism.h"
>>>   #include "smc_loopback.h"
>>>   #if IS_ENABLED(CONFIG_SMC_LO)
>>>   #define SMC_LO_V2_CAPABLE    0x1 /* loopback-ism acts as ISMv2 */
>>> +#define SMC_DMA_ADDR_INVALID    (~(dma_addr_t)0)
>>>   static const char smc_lo_dev_name[] = "loopback-ism";
>>>   static struct smc_lo_dev *lo_dev;
>>> @@ -50,6 +52,97 @@ static int smc_lo_query_rgid(struct smcd_dev 
>>> *smcd, struct smcd_gid *rgid,
>>>       return 0;
>>>   }
>>> +static int smc_lo_register_dmb(struct smcd_dev *smcd, struct 
>>> smcd_dmb *dmb,
>>> +                   void *client_priv)
>>> +{
>>> +    struct smc_lo_dmb_node *dmb_node, *tmp_node;
>>> +    struct smc_lo_dev *ldev = smcd->priv;
>>> +    int sba_idx, order, rc;
>>> +    struct page *pages;
>>> +
>>> +    /* check space for new dmb */
>>> +    for_each_clear_bit(sba_idx, ldev->sba_idx_mask, SMC_LO_MAX_DMBS) {
>>> +        if (!test_and_set_bit(sba_idx, ldev->sba_idx_mask))
>>> +            break;
>>> +    }
>>> +    if (sba_idx == SMC_LO_MAX_DMBS)
>>> +        return -ENOSPC;
>>> +
>>> +    dmb_node = kzalloc(sizeof(*dmb_node), GFP_KERNEL);
>>> +    if (!dmb_node) {
>>> +        rc = -ENOMEM;
>>> +        goto err_bit;
>>> +    }
>>> +
>>> +    dmb_node->sba_idx = sba_idx;
>>> +    order = get_order(dmb->dmb_len);
>>> +    pages = alloc_pages(GFP_KERNEL | __GFP_NOWARN |
>>> +                __GFP_NOMEMALLOC | __GFP_COMP |
>>> +                __GFP_NORETRY | __GFP_ZERO,
>>> +                order);
>>> +    if (!pages) {
>>> +        rc = -ENOMEM;
>>> +        goto err_node;
>>> +    }
>>> +    dmb_node->cpu_addr = (void *)page_address(pages);
>>> +    dmb_node->len = dmb->dmb_len;
>>> +    dmb_node->dma_addr = SMC_DMA_ADDR_INVALID;
>>> +
>>> +again:
>>> +    /* add new dmb into hash table */
>>> +    get_random_bytes(&dmb_node->token, sizeof(dmb_node->token));
>>> +    write_lock(&ldev->dmb_ht_lock);
>>> +    hash_for_each_possible(ldev->dmb_ht, tmp_node, list, 
>>> dmb_node->token) {
>>> +        if (tmp_node->token == dmb_node->token) {
>>> +            write_unlock(&ldev->dmb_ht_lock);
>>> +            goto again;
>>> +        }
>>> +    }
>>> +    hash_add(ldev->dmb_ht, &dmb_node->list, dmb_node->token);
>>> +    write_unlock(&ldev->dmb_ht_lock);
>>> +
>> The write_lock_irqsave()/write_unlock_irqrestore() and 
>> read_lock_irqsave()/read_unlock_irqrestore()should be used instead of 
>> write_lock()/write_unlock() and read_lock()/read_unlock() in order to 
>> keep the lock irq-safe.
>>
> 
> dmb_ht_lock won't be hold in an interrupt or sockirq context. The 
> dmb_{register|unregister},
> dmb_{attach|detach} and data_move are all on the process context. So I 
> think write_(un)lock
> and read_(un)lock is safe here.

right, it is not directly hold in a interrupt context, but it has a 
dependency on conn->send_lock as you wrote below, which requires 
irq-safe lock. And this matches our finding from a test:

=====================================================
WARNING: SOFTIRQ-safe -> SOFTIRQ-unsafe lock order detected
6.8.0-rc4-00787-g8eb4d2392609 #2 Not tainted
-----------------------------------------------------
smcapp/33802 [HC0[0]:SC0[2]:HE1:SE0] is trying to acquire:
00000000a2fc0330 (&ldev->dmb_ht_lock){++++}-{2:2}, at: 
smc_lo_move_data+0x84/0x1d0 [>
and this task is already holding:
00000000e4df6f28 (&smc->conn.send_lock){+.-.}-{2:2}, at: 
smc_tx_sndbuf_nonempty+0xaa>
which would create a new lock dependency:
(&smc->conn.send_lock){+.-.}-{2:2} -> (&ldev->dmb_ht_lock){++++}-{2:2}
but this new dependency connects a SOFTIRQ-irq-safe lock:
(&smc->conn.send_lock){+.-.}-{2:2}

> 
>>> +    dmb->sba_idx = dmb_node->sba_idx;
>>> +    dmb->dmb_tok = dmb_node->token;
>>> +    dmb->cpu_addr = dmb_node->cpu_addr;
>>> +    dmb->dma_addr = dmb_node->dma_addr;
>>> +    dmb->dmb_len = dmb_node->len;
>>> +
>>> +    return 0;
>>> +
>>> +err_node:
>>> +    kfree(dmb_node);
>>> +err_bit:
>>> +    clear_bit(sba_idx, ldev->sba_idx_mask);
>>> +    return rc;
>>> +}
>>> +
>>> +static int smc_lo_unregister_dmb(struct smcd_dev *smcd, struct 
>>> smcd_dmb *dmb)
>>> +{
>>> +    struct smc_lo_dmb_node *dmb_node = NULL, *tmp_node;
>>> +    struct smc_lo_dev *ldev = smcd->priv;
>>> +
>>> +    /* remove dmb from hash table */
>>> +    write_lock(&ldev->dmb_ht_lock);
>>> +    hash_for_each_possible(ldev->dmb_ht, tmp_node, list, 
>>> dmb->dmb_tok) {
>>> +        if (tmp_node->token == dmb->dmb_tok) {
>>> +            dmb_node = tmp_node;
>>> +            break;
>>> +        }
>>> +    }
>>> +    if (!dmb_node) {
>>> +        write_unlock(&ldev->dmb_ht_lock);
>>> +        return -EINVAL;
>>> +    }
>>> +    hash_del(&dmb_node->list);
>>> +    write_unlock(&ldev->dmb_ht_lock);
>>> +
>>> +    clear_bit(dmb_node->sba_idx, ldev->sba_idx_mask);
>>> +    kfree(dmb_node->cpu_addr);
>>> +    kfree(dmb_node);
>>> +
>>> +    return 0;
>>> +}
>>> +
>>>   static int smc_lo_add_vlan_id(struct smcd_dev *smcd, u64 vlan_id)
>>>   {
>>>       return -EOPNOTSUPP;
>>> @@ -76,6 +169,38 @@ static int smc_lo_signal_event(struct smcd_dev 
>>> *dev, struct smcd_gid *rgid,
>>>       return 0;
>>>   }
>>> +static int smc_lo_move_data(struct smcd_dev *smcd, u64 dmb_tok,
>>> +                unsigned int idx, bool sf, unsigned int offset,
>>> +                void *data, unsigned int size)
>>> +{
>>> +    struct smc_lo_dmb_node *rmb_node = NULL, *tmp_node;
>>> +    struct smc_lo_dev *ldev = smcd->priv;
>>> +
>>> +    read_lock(&ldev->dmb_ht_lock);
>>> +    hash_for_each_possible(ldev->dmb_ht, tmp_node, list, dmb_tok) {
>>> +        if (tmp_node->token == dmb_tok) {
>>> +            rmb_node = tmp_node;
>>> +            break;
>>> +        }
>>> +    }
>>> +    if (!rmb_node) {
>>> +        read_unlock(&ldev->dmb_ht_lock);
>>> +        return -EINVAL;
>>> +    }
>>> +    read_unlock(&ldev->dmb_ht_lock);
>>> +
>>> +    memcpy((char *)rmb_node->cpu_addr + offset, data, size);
>>> +
>>
>> Should this read_unlock be placed behind memcpy()?
>>
> 
> dmb_ht_lock is used to ensure safe access to the DMB hash table of 
> loopback-ism.
> The DMB hash table could be accessed by all the connections on 
> loopback-ism, so
> it should be protected.
> 
> But a certain DMB is only used by one connection, and the move_data 
> process is
> protected by conn->send_lock (see smcd_tx_sndbuf_nonempty()), so the 
> memcpy(rmb_node)
> here is safe and no race with other.
> 
> Thanks!
> 
sounds reasonable.
>> <...>


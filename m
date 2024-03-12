Return-Path: <linux-kernel+bounces-99939-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D36B2878F77
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 09:06:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 881BF281C56
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 08:06:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67B7369D0F;
	Tue, 12 Mar 2024 08:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Mf47vl3L"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1E0469D00;
	Tue, 12 Mar 2024 08:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710230806; cv=none; b=mj4orm2TFEFYy259qpCXcq1r5xgRG3ZBaHvat7YVz0bhDOe/+8DYkUxIbm1yQ83VQ5+Bksi7Ro1ZavdQmTIU3e/ePsQ5PoQgddm/kmus9bTpTCAUs4jf6tCsukcSnE7L8a4WdFDg6AWcfjGhdOJueoLvvBzIX+3tYc+3YJmuBwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710230806; c=relaxed/simple;
	bh=loyLU4g6Zw9kjPLNyvmCoapQCZCe19iImHhWuu9Onio=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kLPcxh08mN7AttFr6TFQa48aGS67x3sKV1b42ZuRJWnI+oHuN99FlMK1h/3DWJm6gmE8dj1ndvK7IwCyIZDf26unBZF22aJHBJ6F9vFpWiefXuJKfsvFqoe8zc76NiNLWYP615+HWNldJYnPosoJlJtTYP5Q6nRAtW2mZS8WH5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Mf47vl3L; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42C7uXBE018333;
	Tue, 12 Mar 2024 08:06:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=BEHUUGBRVWHM0oJZ353lAyKYuBhe2eOkFIuCO80ZIgM=;
 b=Mf47vl3Lb8O2kmp0jJKSbiDyen0PCwj3uIk/sSSSxa07KNQOtF2H51MhCzwP6wh6wpVS
 BRhIETSiUsVeZ707dHgqNSy3auTK5ETJeJrv9YLg1pBhUXBVQK/vCqUBw40HHe1G7boq
 ZteUxzvVP05aTRtUQJFRoyJ6PBQL7YMm5ooIBdQNiV4XPtHnJ+UZwv4luk9AGcL0FJB+
 4kSUfVhkQ0UgK6FqvGfmKldnBWF9Yi2bOLMgHUjRavnCB0EB7m1AnZqNXDelb5sNJ8yp
 OOAYNkE5NzmMa2CfnO5XGU0ZbmEi6enkBYBzCN66CjyRjGmRihKc68840wF8uWOQG/VD 3w== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wtht2s8rq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 Mar 2024 08:06:38 +0000
Received: from m0353724.ppops.net (m0353724.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 42C80Bop030544;
	Tue, 12 Mar 2024 08:06:38 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wtht2s8rc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 Mar 2024 08:06:38 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 42C5Wf5h015089;
	Tue, 12 Mar 2024 08:06:37 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3ws33nnr7r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 Mar 2024 08:06:37 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 42C86VqV50594154
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 12 Mar 2024 08:06:33 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 992502004B;
	Tue, 12 Mar 2024 08:06:31 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 437E920040;
	Tue, 12 Mar 2024 08:06:31 +0000 (GMT)
Received: from [9.152.224.118] (unknown [9.152.224.118])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 12 Mar 2024 08:06:31 +0000 (GMT)
Message-ID: <36141145-6838-45eb-a6d6-1c052b6fb076@linux.ibm.com>
Date: Tue, 12 Mar 2024 09:06:30 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 11/11] net/smc: implement DMB-merged
 operations of loopback-ism
To: Wen Gu <guwen@linux.alibaba.com>, wintera@linux.ibm.com,
        twinkler@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com,
        agordeev@linux.ibm.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, wenjia@linux.ibm.com
Cc: borntraeger@linux.ibm.com, svens@linux.ibm.com, alibuda@linux.alibaba.com,
        tonylu@linux.alibaba.com, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, netdev@vger.kernel.org
References: <20240307095536.29648-1-guwen@linux.alibaba.com>
 <20240307095536.29648-12-guwen@linux.alibaba.com>
From: Jan Karcher <jaka@linux.ibm.com>
Organization: IBM - Network Linux on Z
In-Reply-To: <20240307095536.29648-12-guwen@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Ck5CYi2OFVpM6ofcKTAdoBwRI6sttqjQ
X-Proofpoint-ORIG-GUID: Y65Urj8U7fSLhu3KyfcVIt6ROA4JMJ3A
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-12_06,2024-03-11_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 mlxlogscore=999
 clxscore=1015 adultscore=0 impostorscore=0 suspectscore=0
 lowpriorityscore=0 malwarescore=0 phishscore=0 priorityscore=1501
 spamscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2403120062



On 07/03/2024 10:55, Wen Gu wrote:
> This implements operations related to merging sndbuf with peer DMB in
> loopback-ism. The DMB won't be freed until no sndbuf is attached to it.

Hi Wen Gu,

while I'm still reviewing let me drop a lockdep finding.

> 
> Signed-off-by: Wen Gu <guwen@linux.alibaba.com>
> ---
>   net/smc/smc_loopback.c | 136 +++++++++++++++++++++++++++++++++++------
>   net/smc/smc_loopback.h |   3 +
>   2 files changed, 119 insertions(+), 20 deletions(-)
> 
> diff --git a/net/smc/smc_loopback.c b/net/smc/smc_loopback.c
> index 6828e0ad3e90..7e772f3772de 100644
> --- a/net/smc/smc_loopback.c
> +++ b/net/smc/smc_loopback.c

[...]

>   
> @@ -170,8 +249,22 @@ static int smc_lo_move_data(struct smcd_dev *smcd, u64 dmb_tok,
>   {
>   	struct smc_lo_dmb_node *rmb_node = NULL, *tmp_node;
>   	struct smc_lo_dev *ldev = smcd->priv;
> -
> -	read_lock(&ldev->dmb_ht_lock);
> +	struct smc_connection *conn;
> +
> +	if (!sf)
> +		/* since sndbuf is merged with peer DMB, there is
> +		 * no need to copy data from sndbuf to peer DMB.
> +		 */
> +		return 0;
> +
> +	/* read_lock_bh() is used here just to make lockdep
> +	 * happy, because spin_(un)lock_bh(&conn->send_lock) wraps
> +	 * smc_lo_move_data() and if we use read_lock() here, lockdep
> +	 * will complain about SOFTIRQ-safe -> SOFTIRQ-unsafe lock
> +	 * order detected, but in fact ldev->dmb_ht_lock will never
> +	 * be held in bh context.
> +	 */
> +	read_lock_bh(&ldev->dmb_ht_lock);
>   	hash_for_each_possible(ldev->dmb_ht, tmp_node, list, dmb_tok) {
>   		if (tmp_node->token == dmb_tok) {
>   			rmb_node = tmp_node;
> @@ -182,19 +275,14 @@ static int smc_lo_move_data(struct smcd_dev *smcd, u64 dmb_tok,
>   		read_unlock(&ldev->dmb_ht_lock);
>   		return -EINVAL;
>   	}
> -	read_unlock(&ldev->dmb_ht_lock);
> +	read_unlock_bh(&ldev->dmb_ht_lock);
>   
>   	memcpy((char *)rmb_node->cpu_addr + offset, data, size);
>   
> -	if (sf) {
> -		struct smc_connection *conn =
> -			smcd->conn[rmb_node->sba_idx];
> -
> -		if (conn && !conn->killed)
> -			smcd_cdc_rx_handler(conn);
> -		else
> -			return -EPIPE;
> -	}
> +	conn = smcd->conn[rmb_node->sba_idx];
> +	if (!conn || conn->killed)
> +		return -EPIPE;
> +	smcd_cdc_rx_handler(conn);

[ 2385.528515] ============================================
[ 2385.528517] WARNING: possible recursive locking detected
[ 2385.528519] 6.8.0-loopback_ism-g30af186e8a18-dirty #12 Not tainted
[ 2385.528521] --------------------------------------------
[ 2385.528522] smcapp/51326 is trying to acquire lock:
[ 2385.528524] 000000018707a128 (&smc->conn.send_lock){+...}-{2:2}, at: 
smc_tx_sndbuf_nonempty+0xba/0x1c0 [smc]
[ 2385.528552]
                but task is already holding lock:
[ 2385.528554] 0000000187078728 (&smc->conn.send_lock){+...}-{2:2}, at: 
smc_cdc_get_slot_and_msg_send+0x66/0xa0 [smc]
[ 2385.528568]
                other info that might help us debug this:
[ 2385.528570]  Possible unsafe locking scenario:

[ 2385.528572]        CPU0
[ 2385.528573]        ----
[ 2385.528574]   lock(&smc->conn.send_lock);
[ 2385.528576]   lock(&smc->conn.send_lock);
[ 2385.528579]
                 *** DEADLOCK ***

[ 2385.528580]  May be due to missing lock nesting notation

[ 2385.528582] 3 locks held by smcapp/51326:
[ 2385.528584]  #0: 0000000187078378 (sk_lock-AF_SMC){+.+.}-{0:0}, at: 
smc_recvmsg+0x3c/0x2b0 [smc]
[ 2385.528598]  #1: 0000000187078728 (&smc->conn.send_lock){+...}-{2:2}, 
at: smc_cdc_get_slot_and_msg_send+0x66/0xa0 [smc]
[ 2385.528613]  #2: 0000000187079ce8 (slock-AF_SMC){+...}-{2:2}, at: 
smc_cdc_msg_recv+0x56/0xe0 [smc]
[ 2385.528627]
                stack backtrace:
[ 2385.528660] CPU: 3 PID: 51326 Comm: smcapp Not tainted 
6.8.0-loopback_ism-g30af186e8a18-dirty #12
[ 2385.528663] Hardware name: IBM 3906 M04 704 (LPAR)
[ 2385.528664] Call Trace:
[ 2385.528666]  [<000000012db60788>] dump_stack_lvl+0x90/0x120
[ 2385.528671]  [<000000012cc6d088>] validate_chain+0x560/0x960
[ 2385.528677]  [<000000012cc6f644>] __lock_acquire+0x654/0xd58
[ 2385.528680]  [<000000012cc70a04>] lock_acquire.part.0+0xec/0x260
[ 2385.528683]  [<000000012cc70c24>] lock_acquire+0xac/0x170
[ 2385.528687]  [<000000012dba4ccc>] _raw_spin_lock_bh+0x5c/0xb0
[ 2385.528690]  [<000003ff80453b32>] smc_tx_sndbuf_nonempty+0xba/0x1c0 [smc]
[ 2385.528702]  [<000003ff8045428a>] smc_tx_pending+0x32/0x60 [smc]
[ 2385.528712]  [<000003ff80451f02>] smc_cdc_msg_recv_action+0x3c2/0x528 
[smc]
[ 2385.528723]  [<000003ff804520cc>] smc_cdc_msg_recv+0x64/0xe0 [smc]
[ 2385.528734]  [<000003ff80452a4c>] smcd_cdc_rx_handler+0x64/0x70 [smc]
[ 2385.528745]  [<000003ff80459f7e>] smc_lo_move_data+0xde/0x100 [smc]
[ 2385.528755]  [<000003ff804533e0>] smcd_tx_ism_write+0x68/0x90 [smc]
[ 2385.528766]  [<000003ff804528a4>] smcd_cdc_msg_send+0x74/0x118 [smc]
[ 2385.528776]  [<000003ff804529b8>] 
smc_cdc_get_slot_and_msg_send+0x70/0xa0 [smc]
[ 2385.528788]  [<000003ff804543ec>] smc_tx_consumer_update+0xe4/0x1b0 [smc]
[ 2385.528798]  [<000003ff8045458e>] smc_rx_update_consumer+0x86/0x170 [smc]
[ 2385.528809]  [<000003ff80455ba8>] smc_rx_recvmsg+0x3b8/0x6e8 [smc]
[ 2385.528820]  [<000003ff804388a4>] smc_recvmsg+0xdc/0x2b0 [smc]
[ 2385.528831]  [<000000012d8a6d58>] sock_recvmsg+0x70/0xb0
[ 2385.528837]  [<000000012d8aa0c8>] __sys_recvfrom+0xa8/0x128
[ 2385.528840]  [<000000012d8ab3ca>] __do_sys_socketcall+0x1ca/0x398
[ 2385.528844]  [<000000012db8d4c4>] __do_syscall+0x244/0x308
[ 2385.528847]  [<000000012dba6140>] system_call+0x70/0x98
[ 2385.528850] INFO: lockdep is turned off.


I did not investigate deeper, yet. Just an early heads up that there 
might be something broken.

Thank you
- Jan


>   	return 0;
>   }
>   
> @@ -226,6 +314,9 @@ static const struct smcd_ops lo_ops = {
>   	.query_remote_gid = smc_lo_query_rgid,
>   	.register_dmb = smc_lo_register_dmb,
>   	.unregister_dmb = smc_lo_unregister_dmb,
> +	.support_dmb_nocopy = smc_lo_support_dmb_nocopy,
> +	.attach_dmb = smc_lo_attach_dmb,
> +	.detach_dmb = smc_lo_detach_dmb,
>   	.add_vlan_id = smc_lo_add_vlan_id,
>   	.del_vlan_id = smc_lo_del_vlan_id,
>   	.set_vlan_required = smc_lo_set_vlan_required,
> @@ -304,12 +395,17 @@ static int smc_lo_dev_init(struct smc_lo_dev *ldev)
>   	smc_lo_generate_id(ldev);
>   	rwlock_init(&ldev->dmb_ht_lock);
>   	hash_init(ldev->dmb_ht);
> +	atomic_set(&ldev->dmb_cnt, 0);
> +	init_waitqueue_head(&ldev->ldev_release);
> +
>   	return smcd_lo_register_dev(ldev);
>   }
>   
>   static void smc_lo_dev_exit(struct smc_lo_dev *ldev)
>   {
>   	smcd_lo_unregister_dev(ldev);
> +	if (atomic_read(&ldev->dmb_cnt))
> +		wait_event(ldev->ldev_release, !atomic_read(&ldev->dmb_cnt));
>   }
>   
>   static void smc_lo_dev_release(struct device *dev)
> diff --git a/net/smc/smc_loopback.h b/net/smc/smc_loopback.h
> index 24ab9d747613..9156a6c37e65 100644
> --- a/net/smc/smc_loopback.h
> +++ b/net/smc/smc_loopback.h
> @@ -30,6 +30,7 @@ struct smc_lo_dmb_node {
>   	u32 sba_idx;
>   	void *cpu_addr;
>   	dma_addr_t dma_addr;
> +	refcount_t refcnt;
>   };
>   
>   struct smc_lo_dev {
> @@ -37,9 +38,11 @@ struct smc_lo_dev {
>   	struct device dev;
>   	u16 chid;
>   	struct smcd_gid local_gid;
> +	atomic_t dmb_cnt;
>   	rwlock_t dmb_ht_lock;
>   	DECLARE_BITMAP(sba_idx_mask, SMC_LO_MAX_DMBS);
>   	DECLARE_HASHTABLE(dmb_ht, SMC_LO_DMBS_HASH_BITS);
> +	wait_queue_head_t ldev_release;
>   };
>   #endif
>   


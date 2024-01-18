Return-Path: <linux-kernel+bounces-30164-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDA9D831AC6
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 14:45:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 08C591C22312
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 13:45:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFC3825613;
	Thu, 18 Jan 2024 13:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="OJrN8ayc"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14FC625750;
	Thu, 18 Jan 2024 13:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705585496; cv=none; b=IGfnFAnrJ6Dz/18+vi0UN5GfNyRoVR0xetMVuSndFHtRw/JNaotNbrcGN/EGZ/xAOyhFp7JmvZG1NhpYnZCdmbc3e6roX6Gz+LLYuJZm4XZ6Aq4fr3WyLohh2e7F9he9jGJaZQ6gyEeusqpBKfmsup0/gcFy52NfUJ1AL84Fu60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705585496; c=relaxed/simple;
	bh=fyOO87gyCVvda8Dtdu5dP+4OJie3gUe4JS7z6my6Q4k=;
	h=Received:DKIM-Signature:Received:Received:Received:Received:
	 Received:Received:Received:Received:Received:Message-ID:Date:
	 User-Agent:Subject:Content-Language:To:Cc:References:From:
	 In-Reply-To:Content-Type:X-TM-AS-GCONF:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-GUID:Content-Transfer-Encoding:X-Proofpoint-UnRewURL:
	 MIME-Version:X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	b=saXkjpCXvVBEBaXPaXorHxS4Fyd0vLC5o9CrFHiIcZpbZf/4Iddx1qtzSjgS3/tUAxowt47hEwRvL6daqMrpRREO2Hh0WbVAsQWczjui5wk7F+v3Wksw6+qQtQucmt1rZgw/8Bf6I/oGcMT41Z5Eqio/ySeEmtzvKfUEqn7DXnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=OJrN8ayc; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40ID1JOC009014;
	Thu, 18 Jan 2024 13:44:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=E11fxe4FBaAFH8dgSAN7Sr3yf87afr7uMgZUqa9RFe4=;
 b=OJrN8ayc5rglqP0kFFe2zkEgWUn1Gzuk95HoXINOcHNTFmbNqnwyhcyl5+bXhKUmulDP
 FiSGFeC/2WxDmf6FTZSVDnGZUT3LHOL4f9SaER0F5vg8Gqf/hYWG4lu3BW8yaU6VM1Et
 AKYGy482DtCxVeXmKbMLWLf+kc4T+DZWsCKcucGVzdTMKPQpBvjVY547v7vey6FdXx/S
 5L005JXt8g1fNHx/8xkWYqVvsV17RqTYIN1hBA1rhBM5sum6I7WUKP/K2e5Ih/Nf3eEE
 uLx9KLjfoxKYL5tY4CXCLvKKD+ihLPnF4lM360CU+VTJmDXc4IzYi2TlrgQbz/DbmJE2 cw== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vq45j21v8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Jan 2024 13:44:43 +0000
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 40ID27aK012758;
	Thu, 18 Jan 2024 13:44:42 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vq45j21u9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Jan 2024 13:44:42 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 40IAeACi005842;
	Thu, 18 Jan 2024 13:44:41 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3vm6bkufr1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Jan 2024 13:44:41 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 40IDieD121496516
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 18 Jan 2024 13:44:40 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8B1BD58058;
	Thu, 18 Jan 2024 13:44:40 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A526B58057;
	Thu, 18 Jan 2024 13:44:38 +0000 (GMT)
Received: from [9.179.26.4] (unknown [9.179.26.4])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 18 Jan 2024 13:44:38 +0000 (GMT)
Message-ID: <33cd7db0-2a0d-43af-b26c-a81bca382fbf@linux.ibm.com>
Date: Thu, 18 Jan 2024 14:44:37 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] net/smc: fix illegal rmb_desc access in SMC-D
 connection dump
Content-Language: en-GB
To: Wen Gu <guwen@linux.alibaba.com>, jaka@linux.ibm.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Cc: alibuda@linux.alibaba.com, tonylu@linux.alibaba.com, ubraun@linux.ibm.com,
        linux-s390@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20240118043210.47618-1-guwen@linux.alibaba.com>
From: Wenjia Zhang <wenjia@linux.ibm.com>
In-Reply-To: <20240118043210.47618-1-guwen@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: XbUDJE67GtkkyzaHfEeR40bcqAkgRk_j
X-Proofpoint-GUID: beCBhPepnKjL4QOlxfj2LQVhokggwF0d
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-18_08,2024-01-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 priorityscore=1501
 malwarescore=0 suspectscore=0 adultscore=0 bulkscore=0 impostorscore=0
 spamscore=0 mlxlogscore=999 lowpriorityscore=0 clxscore=1011 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2401180099



On 18.01.24 05:32, Wen Gu wrote:
> A crash was found when dumping SMC-D connections. It can be reproduced
> by following steps:
> 
> - run nginx/wrk test:
>    smc_run nginx
>    smc_run wrk -t 16 -c 1000 -d <duration> -H 'Connection: Close' <URL>
> 
> - continuously dump SMC-D connections in parallel:
>    watch -n 1 'smcss -D'
> 
>   BUG: kernel NULL pointer dereference, address: 0000000000000030
>   CPU: 2 PID: 7204 Comm: smcss Kdump: loaded Tainted: G	E      6.7.0+ #55
>   RIP: 0010:__smc_diag_dump.constprop.0+0x5e5/0x620 [smc_diag]
>   Call Trace:
>    <TASK>
>    ? __die+0x24/0x70
>    ? page_fault_oops+0x66/0x150
>    ? exc_page_fault+0x69/0x140
>    ? asm_exc_page_fault+0x26/0x30
>    ? __smc_diag_dump.constprop.0+0x5e5/0x620 [smc_diag]
>    ? __kmalloc_node_track_caller+0x35d/0x430
>    ? __alloc_skb+0x77/0x170
>    smc_diag_dump_proto+0xd0/0xf0 [smc_diag]
>    smc_diag_dump+0x26/0x60 [smc_diag]
>    netlink_dump+0x19f/0x320
>    __netlink_dump_start+0x1dc/0x300
>    smc_diag_handler_dump+0x6a/0x80 [smc_diag]
>    ? __pfx_smc_diag_dump+0x10/0x10 [smc_diag]
>    sock_diag_rcv_msg+0x121/0x140
>    ? __pfx_sock_diag_rcv_msg+0x10/0x10
>    netlink_rcv_skb+0x5a/0x110
>    sock_diag_rcv+0x28/0x40
>    netlink_unicast+0x22a/0x330
>    netlink_sendmsg+0x1f8/0x420
>    __sock_sendmsg+0xb0/0xc0
>    ____sys_sendmsg+0x24e/0x300
>    ? copy_msghdr_from_user+0x62/0x80
>    ___sys_sendmsg+0x7c/0xd0
>    ? __do_fault+0x34/0x160
>    ? do_read_fault+0x5f/0x100
>    ? do_fault+0xb0/0x110
>    ? __handle_mm_fault+0x2b0/0x6c0
>    __sys_sendmsg+0x4d/0x80
>    do_syscall_64+0x69/0x180
>    entry_SYSCALL_64_after_hwframe+0x6e/0x76
> 
> It is possible that the connection is in process of being established
> when we dump it. Assumed that the connection has been registered in a
> link group by smc_conn_create() but the rmb_desc has not yet been
> initialized by smc_buf_create(), thus causing the illegal access to
> conn->rmb_desc. So fix it by checking before dump.
> 
> Fixes: 4b1b7d3b30a6 ("net/smc: add SMC-D diag support")
> Signed-off-by: Wen Gu <guwen@linux.alibaba.com>
> ---
> v2->v1: corrected the commit in Fixes tag.
> (https://lore.kernel.org/netdev/20240117122749.63785-1-guwen@linux.alibaba.com/)
> 
>   net/smc/smc_diag.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/smc/smc_diag.c b/net/smc/smc_diag.c
> index 52f7c4f1e767..5a33908015f3 100644
> --- a/net/smc/smc_diag.c
> +++ b/net/smc/smc_diag.c
> @@ -164,7 +164,7 @@ static int __smc_diag_dump(struct sock *sk, struct sk_buff *skb,
>   	}
>   	if (smc_conn_lgr_valid(&smc->conn) && smc->conn.lgr->is_smcd &&
>   	    (req->diag_ext & (1 << (SMC_DIAG_DMBINFO - 1))) &&
> -	    !list_empty(&smc->conn.lgr->list)) {
> +	    !list_empty(&smc->conn.lgr->list) && smc->conn.rmb_desc) {
>   		struct smc_connection *conn = &smc->conn;
>   		struct smcd_diag_dmbinfo dinfo;
>   		struct smcd_dev *smcd = conn->lgr->smcd;

That sounds reasonable to me! Thank you for the fix!

Reviewed-by: Wenjia Zhang <wenjia@linux.ibm.com>


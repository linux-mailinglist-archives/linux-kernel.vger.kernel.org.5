Return-Path: <linux-kernel+bounces-109759-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4014E885558
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 09:13:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 63A801C211E2
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 08:13:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E8A178263;
	Thu, 21 Mar 2024 08:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="WGmXxNnN"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85D0177F14;
	Thu, 21 Mar 2024 08:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711008759; cv=none; b=qDvfZvJny6p/q5EyxyGGSrsiLE0xLiYoLNRTNZ3Y9p7CSKwWFccUXBi8u43dbX76A+48IC16yfR6vAjov+fcOWbOW36tBuREPS0ZmRRaTWAW0JcHQY+B+LHyAe1BZQlsKmEdR6FLhJjbkFzNxsJIHESQW53mhpMbr/Wnr4z9JII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711008759; c=relaxed/simple;
	bh=Kj8KUSghrmg0GoKUmi5UVBDNwlsLdNHc1SqFPZMjA5I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DNGaXT93RKrkfa9SHE75tp1HymzAkJwEnnAqqWQJ+ZeaGyYsI6DGak8Jc4xv09dQaaebc/C4+YGSSluF/+OLP/P7mFcf1LIc+nw75mO1eKJUijOYwWPYvrUCVyb/APp31XIPSl3aml0hkdTtfMFhqI3+vD7tLTdPeI4cIjNOi3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=WGmXxNnN; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42L4xSXp026240;
	Thu, 21 Mar 2024 08:12:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=iTRimnW+D2YIFUe/aOmIWkblXn+SJABHdBSkm41+Nro=;
 b=WGmXxNnNYOtUrWtdAWI4AQUUjlEUpZrJzBT07pCUHqgsWpaJZMoV8K35dy8c2CEN3kiU
 OgFDVspWZW1yV23KIoHq2FN1LOlgC34o66Hs8N2/BtdIhB90aVN+QqKq5E7WKmzgXWZu
 D9Q2XKFh/fw0CAxePf9E5LhEC1ecn+62LXqqEC8DDIxYTZr2/7VfKGaXrmEJ6sdX8x98
 O+4T6lZj7ZYxOCKqoOgKEBr/MMwj5WYWaHnFq4hnHSdNmK3O3K68eSGjyuX4pAqFiLzf
 lu61cCvvnCScybWOz7c2GJ/eVtFpYn112TupEozr8eDaTT1yRUneW61xI8Qmw+G2/nGm 4g== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3x0an3rp2k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Mar 2024 08:12:33 +0000
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 42L8CW0b025773;
	Thu, 21 Mar 2024 08:12:32 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3x0an3rp2e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Mar 2024 08:12:32 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 42L5frBV017242;
	Thu, 21 Mar 2024 08:12:32 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3wwnrtkywt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Mar 2024 08:12:31 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 42L8CQVO51773914
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 21 Mar 2024 08:12:28 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B65F920040;
	Thu, 21 Mar 2024 08:12:26 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BA40E20043;
	Thu, 21 Mar 2024 08:12:25 +0000 (GMT)
Received: from [9.179.15.41] (unknown [9.179.15.41])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 21 Mar 2024 08:12:25 +0000 (GMT)
Message-ID: <1b3428f6-1fcc-4aba-80a0-0743c7c0c138@linux.ibm.com>
Date: Thu, 21 Mar 2024 09:12:19 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH net-next v4 10/11] net/smc: adapt cursor update when
 sndbuf and peer DMB are merged
To: Wen Gu <guwen@linux.alibaba.com>, wintera@linux.ibm.com,
        twinkler@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com,
        agordeev@linux.ibm.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, wenjia@linux.ibm.com
Cc: borntraeger@linux.ibm.com, svens@linux.ibm.com, alibuda@linux.alibaba.com,
        tonylu@linux.alibaba.com, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, netdev@vger.kernel.org
References: <20240317100545.96663-1-guwen@linux.alibaba.com>
 <20240317100545.96663-11-guwen@linux.alibaba.com>
From: Jan Karcher <jaka@linux.ibm.com>
Organization: IBM - Network Linux on Z
In-Reply-To: <20240317100545.96663-11-guwen@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: z9YziVEJzFcbbcV0eWp2ZNC8zo7KLreG
X-Proofpoint-GUID: 9zCpydCXa2yomG6ecs39FNB_K3MqK4wz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-21_05,2024-03-18_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxscore=0
 suspectscore=0 clxscore=1015 priorityscore=1501 bulkscore=0
 impostorscore=0 lowpriorityscore=0 adultscore=0 malwarescore=0
 mlxlogscore=999 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2403140000 definitions=main-2403210055



On 17/03/2024 11:05, Wen Gu wrote:
> Since ghost sndbuf shares the same physical memory with peer DMB,
> the cursor update processing needs to be adapted to ensure that the
> data to be consumed won't be overwritten.
> 
> So in this case, the fin_curs and sndbuf_space that were originally
> updated after sending the CDC message should be modified to not be
> update until the peer updates cons_curs.
> 
> Signed-off-by: Wen Gu <guwen@linux.alibaba.com>
> ---
>   net/smc/smc_cdc.c | 52 +++++++++++++++++++++++++++++++++++++----------
>   1 file changed, 41 insertions(+), 11 deletions(-)
> 
> diff --git a/net/smc/smc_cdc.c b/net/smc/smc_cdc.c
> index 3c06625ceb20..bf5b214ec15a 100644
> --- a/net/smc/smc_cdc.c
> +++ b/net/smc/smc_cdc.c
> @@ -18,6 +18,7 @@
>   #include "smc_tx.h"
>   #include "smc_rx.h"
>   #include "smc_close.h"
> +#include "smc_ism.h"
>   
>   /********************************** send *************************************/
>   
> @@ -255,17 +256,25 @@ int smcd_cdc_msg_send(struct smc_connection *conn)
>   		return rc;
>   	smc_curs_copy(&conn->rx_curs_confirmed, &curs, conn);
>   	conn->local_rx_ctrl.prod_flags.cons_curs_upd_req = 0;
> -	/* Calculate transmitted data and increment free send buffer space */
> -	diff = smc_curs_diff(conn->sndbuf_desc->len, &conn->tx_curs_fin,
> -			     &conn->tx_curs_sent);
> -	/* increased by confirmed number of bytes */
> -	smp_mb__before_atomic();
> -	atomic_add(diff, &conn->sndbuf_space);
> -	/* guarantee 0 <= sndbuf_space <= sndbuf_desc->len */
> -	smp_mb__after_atomic();
> -	smc_curs_copy(&conn->tx_curs_fin, &conn->tx_curs_sent, conn);
> +	if (!smc_ism_support_dmb_nocopy(conn->lgr->smcd)) {
> +		/* Ghost sndbuf shares the same memory region with
> +		 * peer DMB, so don't update the tx_curs_fin and
> +		 * sndbuf_space until peer has consumed the data.
> +		 */

Hi Wen Gu,

move this comment above the if please. Two consecutive multiline 
comments are difficult to read here.

> +		/* Calculate transmitted data and increment free
> +		 * send buffer space
> +		 */
> +		diff = smc_curs_diff(conn->sndbuf_desc->len, &conn->tx_curs_fin,
> +				     &conn->tx_curs_sent);
> +		/* increased by confirmed number of bytes */
> +		smp_mb__before_atomic();
> +		atomic_add(diff, &conn->sndbuf_space);
> +		/* guarantee 0 <= sndbuf_space <= sndbuf_desc->len */
> +		smp_mb__after_atomic();
> +		smc_curs_copy(&conn->tx_curs_fin, &conn->tx_curs_sent, conn);
>   
> -	smc_tx_sndbuf_nonfull(smc);
> +		smc_tx_sndbuf_nonfull(smc);
> +	}
>   	return rc;
>   }
>   
> @@ -323,7 +332,7 @@ static void smc_cdc_msg_recv_action(struct smc_sock *smc,
>   {
>   	union smc_host_cursor cons_old, prod_old;
>   	struct smc_connection *conn = &smc->conn;
> -	int diff_cons, diff_prod;
> +	int diff_cons, diff_prod, diff_tx;
>   
>   	smc_curs_copy(&prod_old, &conn->local_rx_ctrl.prod, conn);
>   	smc_curs_copy(&cons_old, &conn->local_rx_ctrl.cons, conn);
> @@ -339,6 +348,27 @@ static void smc_cdc_msg_recv_action(struct smc_sock *smc,
>   		atomic_add(diff_cons, &conn->peer_rmbe_space);
>   		/* guarantee 0 <= peer_rmbe_space <= peer_rmbe_size */
>   		smp_mb__after_atomic();
> +
> +		if (conn->lgr->is_smcd &&
> +		    smc_ism_support_dmb_nocopy(conn->lgr->smcd)) {
> +			/* Ghost sndbuf shares the same memory region with
> +			 * peer RMB, so update tx_curs_fin and sndbuf_space
> +			 * when peer has consumed the data.
> +			 */

Same as above.

Thanks
- Jan

> +			/* calculate peer rmb consumed data */
> +			diff_tx = smc_curs_diff(conn->sndbuf_desc->len,
> +						&conn->tx_curs_fin,
> +						&conn->local_rx_ctrl.cons);
> +			/* increase local sndbuf space and fin_curs */
> +			smp_mb__before_atomic();
> +			atomic_add(diff_tx, &conn->sndbuf_space);
> +			/* guarantee 0 <= sndbuf_space <= sndbuf_desc->len */
> +			smp_mb__after_atomic();
> +			smc_curs_copy(&conn->tx_curs_fin,
> +				      &conn->local_rx_ctrl.cons, conn);
> +
> +			smc_tx_sndbuf_nonfull(smc);
> +		}
>   	}
>   
>   	diff_prod = smc_curs_diff(conn->rmb_desc->len, &prod_old,


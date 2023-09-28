Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E4E37B110F
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 05:08:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230048AbjI1DI0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 23:08:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjI1DIZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 23:08:25 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7AC694;
        Wed, 27 Sep 2023 20:08:23 -0700 (PDT)
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38S29Wot030226;
        Thu, 28 Sep 2023 03:08:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : from : subject : to : cc : references : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=dFLQXN1t82LKSrLGWEHwpqhB37cuQ+meu4w5ADWXs2M=;
 b=Al9UtYHSp5MmWZbzcyeyAeZymo3buFLqL2rUpxSnhP3mE3HyQjyR18sEsUNZeCLu16lT
 kof6qioXxqXxOm0a3gDJFsCgIj/HLpe6sgjSsX7VvZAVq6qemjL4tK0MQ79Lz2xMx340
 +JAt5k71lpb2fZ+viB4QrWewvuOwr1CXo7BX7vAbuDA53JftCOF/BA306RvT5/e7JrSK
 JWi7d/WFusmpF+mFWHPwmOg/L3x4cpu6V/thkEAcn9jzBc7Tqo0NYHFbA6cpQCTt8um9
 oDpm+39jiQ/aU0CLdqHsvXyZWyqQNuoBM8wGpIEg8M3igtfj8PIBj9MrK6YX594S8Y8H BA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tcuvbrc5y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 28 Sep 2023 03:08:20 +0000
Received: from m0353727.ppops.net (m0353727.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 38S2utdf023926;
        Thu, 28 Sep 2023 03:08:19 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tcuvbrc5f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 28 Sep 2023 03:08:19 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
        by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 38S2l1CP008386;
        Thu, 28 Sep 2023 03:08:18 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
        by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3taabt183a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 28 Sep 2023 03:08:18 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
        by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 38S38FHO14025342
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 Sep 2023 03:08:15 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5DCE320040;
        Thu, 28 Sep 2023 03:08:15 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 641902004F;
        Thu, 28 Sep 2023 03:08:14 +0000 (GMT)
Received: from [9.171.44.93] (unknown [9.171.44.93])
        by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Thu, 28 Sep 2023 03:08:14 +0000 (GMT)
Message-ID: <902e41df-0c98-c8ef-09cb-a92cf053f9d2@linux.ibm.com>
Date:   Thu, 28 Sep 2023 05:08:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
From:   Jan Karcher <jaka@linux.ibm.com>
Subject: Re: [PATCH net-next v4 03/18] net/smc: extract v2 check helper from
 SMC-D device registration
To:     Wen Gu <guwen@linux.alibaba.com>, kgraul@linux.ibm.com,
        wenjia@linux.ibm.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com
Cc:     wintera@linux.ibm.com, schnelle@linux.ibm.com,
        gbayer@linux.ibm.com, pasic@linux.ibm.com,
        alibuda@linux.alibaba.com, tonylu@linux.alibaba.com,
        dust.li@linux.alibaba.com, linux-s390@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1695568613-125057-1-git-send-email-guwen@linux.alibaba.com>
 <1695568613-125057-4-git-send-email-guwen@linux.alibaba.com>
Organization: IBM - Network Linux on Z
In-Reply-To: <1695568613-125057-4-git-send-email-guwen@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: OtSDE0L3XGkTtmUhmDPbxqR4-m_NLCaL
X-Proofpoint-ORIG-GUID: XCytkwSQw7uIEkwBqN-TzpZFvF3tDwgL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-27_17,2023-09-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 adultscore=0 suspectscore=0 malwarescore=0 mlxlogscore=999 phishscore=0
 priorityscore=1501 impostorscore=0 mlxscore=0 spamscore=0 clxscore=1011
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2309280026
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 24/09/2023 17:16, Wen Gu wrote:
> This patch extracts v2-capable logic from the process of registering the
> ISM device as an SMC-D device, so that the registration process of other
> underlying devices can reuse it.
> 
> Signed-off-by: Wen Gu <guwen@linux.alibaba.com>
> ---
>   net/smc/smc_ism.c | 29 ++++++++++++++++++-----------
>   net/smc/smc_ism.h |  1 +
>   2 files changed, 19 insertions(+), 11 deletions(-)
> 
> diff --git a/net/smc/smc_ism.c b/net/smc/smc_ism.c
> index 455ae0a..8f1ba74 100644
> --- a/net/smc/smc_ism.c
> +++ b/net/smc/smc_ism.c
> @@ -69,6 +69,22 @@ bool smc_ism_is_v2_capable(void)
>   	return smc_ism_v2_capable;
>   }
>   
> +/* must be called under smcd_dev_list.mutex lock */
> +void smc_ism_check_v2_capable(struct smcd_dev *smcd)
> +{
> +	u8 *system_eid = NULL;
> +
> +	if (smc_ism_v2_capable)
> +		return;
> +
> +	system_eid = smcd->ops->get_system_eid();
> +	if (smcd->ops->supports_v2()) {
> +		smc_ism_v2_capable = true;
> +		memcpy(smc_ism_v2_system_eid, system_eid,
> +		       SMC_MAX_EID_LEN);
> +	}
> +}
> +
>   /* Set a connection using this DMBE. */
>   void smc_ism_set_conn(struct smc_connection *conn)
>   {
> @@ -423,16 +439,7 @@ static void smcd_register_dev(struct ism_dev *ism)
>   		smc_pnetid_by_table_smcd(smcd);
>   
>   	mutex_lock(&smcd_dev_list.mutex);
> -	if (list_empty(&smcd_dev_list.list)) {
> -		u8 *system_eid = NULL;
> -
> -		system_eid = smcd->ops->get_system_eid();
> -		if (smcd->ops->supports_v2()) {
> -			smc_ism_v2_capable = true;
> -			memcpy(smc_ism_v2_system_eid, system_eid,
> -			       SMC_MAX_EID_LEN);
> -		}
> -	}
> +	smc_ism_check_v2_capable(smcd);

The list_empty check is omitted here which means the 
smc_ism_check_v2_capable does not touch the list.
So i think the call could be placed prior the mutex_lock.

>   	/* sort list: devices without pnetid before devices with pnetid */
>   	if (smcd->pnetid[0])
>   		list_add_tail(&smcd->list, &smcd_dev_list.list);
> @@ -535,10 +542,10 @@ int smc_ism_init(void)
>   {
>   	int rc = 0;
>   
> -#if IS_ENABLED(CONFIG_ISM)
>   	smc_ism_v2_capable = false;
>   	memset(smc_ism_v2_system_eid, 0, SMC_MAX_EID_LEN);
>   
> +#if IS_ENABLED(CONFIG_ISM)
>   	rc = ism_register_client(&smc_ism_client);
>   #endif
>   	return rc;
> diff --git a/net/smc/smc_ism.h b/net/smc/smc_ism.h
> index 832b2f4..14d2e77 100644
> --- a/net/smc/smc_ism.h
> +++ b/net/smc/smc_ism.h
> @@ -42,6 +42,7 @@ int smc_ism_register_dmb(struct smc_link_group *lgr, int buf_size,
>   void smc_ism_get_system_eid(u8 **eid);
>   u16 smc_ism_get_chid(struct smcd_dev *dev);
>   bool smc_ism_is_v2_capable(void);
> +void smc_ism_check_v2_capable(struct smcd_dev *dev);
>   int smc_ism_init(void);
>   void smc_ism_exit(void);
>   int smcd_nl_get_device(struct sk_buff *skb, struct netlink_callback *cb);

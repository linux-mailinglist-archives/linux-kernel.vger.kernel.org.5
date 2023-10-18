Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64D147CE811
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 21:48:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231549AbjJRTsJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 15:48:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbjJRTsH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 15:48:07 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63D4195;
        Wed, 18 Oct 2023 12:48:06 -0700 (PDT)
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39IJkAn5021294;
        Wed, 18 Oct 2023 19:48:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=FpMPMvLMbHyms6D+yKm1lAAYT/LnaHzuY9KJAnlmIXA=;
 b=Fnu/a6dDtbaVl1DUpEKZTr/+iLVdv+UdgTn2uzPzHt3Ywpiau0AtuqOUIOsHhGY6U/xJ
 NVhva1XigzXNBqMRWRH3tFL3feglv7Iwd6E8ppq0NiAgH+LSQr5hxjdqqbfctYKjI5AT
 Xf8jA3LcgbgiBz02VAww2fy+6N7eI/1fOQtsBSBxWDVunqfA+lP44Rxl7Ywnt6MkgbAQ
 5A5Jx3uXn9RyHvJ4ecsN9Oj+d7ueXUvNLAYgr0atErBjAeJ+zXXrz7prw9nxa5qUtOaw
 ksy1VbpeQ3JbLKIn/nui8rneXVqFGddUctK7f2/KLCG1x52kuWh4O3t+lKtkqJ/Oxc1y kQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ttnpbr7je-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 18 Oct 2023 19:48:03 +0000
Received: from m0353728.ppops.net (m0353728.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 39IJkOZZ023064;
        Wed, 18 Oct 2023 19:48:03 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ttnpbr7hw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 18 Oct 2023 19:48:03 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 39IILPLu012858;
        Wed, 18 Oct 2023 19:48:02 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
        by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3tr5pykq52-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 18 Oct 2023 19:48:02 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
        by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 39IJm1U610486482
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 Oct 2023 19:48:01 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3077F5803F;
        Wed, 18 Oct 2023 19:48:01 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C72E95804E;
        Wed, 18 Oct 2023 19:47:56 +0000 (GMT)
Received: from [9.171.53.134] (unknown [9.171.53.134])
        by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Wed, 18 Oct 2023 19:47:56 +0000 (GMT)
Message-ID: <77dbc865-2f19-45f3-ae4d-53d0b53e5dad@linux.ibm.com>
Date:   Wed, 18 Oct 2023 21:47:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2 1/2] net/smc: change function name from
 smc_find_ism_store_rc to smc_find_device_store_rc
Content-Language: en-GB
To:     Guangguan Wang <guangguan.wang@linux.alibaba.com>,
        kgraul@linux.ibm.com, jaka@linux.ibm.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Cc:     tonylu@linux.alibaba.com, alibuda@linux.alibaba.com,
        guwen@linux.alibaba.com, linux-s390@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20231017124234.99574-1-guangguan.wang@linux.alibaba.com>
 <20231017124234.99574-2-guangguan.wang@linux.alibaba.com>
From:   Wenjia Zhang <wenjia@linux.ibm.com>
In-Reply-To: <20231017124234.99574-2-guangguan.wang@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: yq3jji94Sg9yEnzCTWnDPMKcmlxLrppB
X-Proofpoint-ORIG-GUID: vkN3FwgQ1RCrIuMU46rngvk3sp2AM--E
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-18_18,2023-10-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 spamscore=0
 impostorscore=0 bulkscore=0 clxscore=1015 malwarescore=0 mlxscore=0
 suspectscore=0 mlxlogscore=999 priorityscore=1501 lowpriorityscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310180162
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 17.10.23 14:42, Guangguan Wang wrote:
> The function smc_find_ism_store_rc is not only used for ism, so it is
> reasonable to change the function name to smc_find_device_store_rc.
> 
> Signed-off-by: Guangguan Wang <guangguan.wang@linux.alibaba.com>
> ---

same as the patch [2/2], please see the comment from Jakub

>   net/smc/af_smc.c | 16 ++++++++--------
>   1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
> index 35ddebae8894..b3a67a168495 100644
> --- a/net/smc/af_smc.c
> +++ b/net/smc/af_smc.c
> @@ -2122,7 +2122,7 @@ static void smc_check_ism_v2_match(struct smc_init_info *ini,
>   	}
>   }
>   
> -static void smc_find_ism_store_rc(u32 rc, struct smc_init_info *ini)
> +static void smc_find_device_store_rc(u32 rc, struct smc_init_info *ini)
>   {
>   	if (!ini->rc)
>   		ini->rc = rc;
> @@ -2164,7 +2164,7 @@ static void smc_find_ism_v2_device_serv(struct smc_sock *new_smc,
>   	mutex_unlock(&smcd_dev_list.mutex);
>   
>   	if (!ini->ism_dev[0]) {
> -		smc_find_ism_store_rc(SMC_CLC_DECL_NOSMCD2DEV, ini);
> +		smc_find_device_store_rc(SMC_CLC_DECL_NOSMCD2DEV, ini);
>   		goto not_found;
>   	}
>   
> @@ -2181,7 +2181,7 @@ static void smc_find_ism_v2_device_serv(struct smc_sock *new_smc,
>   		ini->ism_selected = i;
>   		rc = smc_listen_ism_init(new_smc, ini);
>   		if (rc) {
> -			smc_find_ism_store_rc(rc, ini);
> +			smc_find_device_store_rc(rc, ini);
>   			/* try next active ISM device */
>   			continue;
>   		}
> @@ -2218,7 +2218,7 @@ static void smc_find_ism_v1_device_serv(struct smc_sock *new_smc,
>   		return;		/* V1 ISM device found */
>   
>   not_found:
> -	smc_find_ism_store_rc(rc, ini);
> +	smc_find_device_store_rc(rc, ini);
>   	ini->smcd_version &= ~SMC_V1;
>   	ini->ism_dev[0] = NULL;
>   	ini->is_smcd = false;
> @@ -2268,7 +2268,7 @@ static void smc_find_rdma_v2_device_serv(struct smc_sock *new_smc,
>   	ini->smcrv2.daddr = smc_ib_gid_to_ipv4(smc_v2_ext->roce);
>   	rc = smc_find_rdma_device(new_smc, ini);
>   	if (rc) {
> -		smc_find_ism_store_rc(rc, ini);
> +		smc_find_device_store_rc(rc, ini);
>   		goto not_found;
>   	}
>   	if (!ini->smcrv2.uses_gateway)
> @@ -2285,7 +2285,7 @@ static void smc_find_rdma_v2_device_serv(struct smc_sock *new_smc,
>   	if (!rc)
>   		return;
>   	ini->smcr_version = smcr_version;
> -	smc_find_ism_store_rc(rc, ini);
> +	smc_find_device_store_rc(rc, ini);
>   
>   not_found:
>   	ini->smcr_version &= ~SMC_V2;
> @@ -2332,7 +2332,7 @@ static int smc_listen_find_device(struct smc_sock *new_smc,
>   	/* check for matching IP prefix and subnet length (V1) */
>   	prfx_rc = smc_listen_prfx_check(new_smc, pclc);
>   	if (prfx_rc)
> -		smc_find_ism_store_rc(prfx_rc, ini);
> +		smc_find_device_store_rc(prfx_rc, ini);
>   
>   	/* get vlan id from IP device */
>   	if (smc_vlan_by_tcpsk(new_smc->clcsock, ini))
> @@ -2359,7 +2359,7 @@ static int smc_listen_find_device(struct smc_sock *new_smc,
>   		int rc;
>   
>   		rc = smc_find_rdma_v1_device_serv(new_smc, pclc, ini);
> -		smc_find_ism_store_rc(rc, ini);
> +		smc_find_device_store_rc(rc, ini);
>   		return (!rc) ? 0 : ini->rc;
>   	}
>   	return prfx_rc;

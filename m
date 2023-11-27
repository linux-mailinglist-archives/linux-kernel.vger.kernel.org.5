Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BBAE7FA29C
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 15:28:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233712AbjK0O2T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 09:28:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233629AbjK0O2I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 09:28:08 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1575C49F5;
        Mon, 27 Nov 2023 06:04:14 -0800 (PST)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3ARDfPeC020065;
        Mon, 27 Nov 2023 14:04:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=S4Tp0kxCaMHnRHT1GJrDl8TCv/MjeeTlTcvoJVFJlTg=;
 b=lhPJ4hUJfOwm6emHKlTuqa489O+uqe4KES7BUQ4oWgfqEL75fEJ+BR05JS9iXr3or6CZ
 NNQhiixgwxyMp5K07gCJNhpjk70DruJE/Ny2Y+6g/5ejwkschP8Fkz1vSFXkZYNmj9cO
 adj3lqpFpc14hyQF+T4YnnvD8pQ7xYLejRq+PP4HZnIcH/LUuaBKGMiMdGAM8W+cU4je
 lww4EZn7jaX7u1OF0YkcZCSvtzJRnjn7vhYOQVHS+IObfnpvVy0j61NKYEQr6OC127+9
 VC7KzEAshC7F9DNyWpeKd4uHejlfaloIao/M16Ul6F1xDDt3jmg/DkrtAmt9V3RhQH9H pQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3umufpa6kt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Nov 2023 14:04:11 +0000
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3ARDfhbQ022126;
        Mon, 27 Nov 2023 14:04:11 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3umufpa6k0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Nov 2023 14:04:10 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
        by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3ARBYTRv025052;
        Mon, 27 Nov 2023 14:04:10 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
        by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3ukwfjrp4j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Nov 2023 14:04:09 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
        by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3ARE479211403924
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 27 Nov 2023 14:04:07 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 11A8220040;
        Mon, 27 Nov 2023 14:04:07 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 47DFC2004E;
        Mon, 27 Nov 2023 14:04:06 +0000 (GMT)
Received: from [9.171.23.51] (unknown [9.171.23.51])
        by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Mon, 27 Nov 2023 14:04:06 +0000 (GMT)
Message-ID: <48732f15-64bf-4bb7-8b88-95263a99cf6a@linux.ibm.com>
Date:   Mon, 27 Nov 2023 15:04:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 7/7] net/smc: manage system EID in SMC stack
 instead of ISM driver
Content-Language: en-US
To:     Wen Gu <guwen@linux.alibaba.com>, wenjia@linux.ibm.com,
        hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, kgraul@linux.ibm.com, jaka@linux.ibm.com
Cc:     borntraeger@linux.ibm.com, svens@linux.ibm.com,
        alibuda@linux.alibaba.com, tonylu@linux.alibaba.com,
        raspl@linux.ibm.com, schnelle@linux.ibm.com,
        linux-s390@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1700836935-23819-1-git-send-email-guwen@linux.alibaba.com>
 <1700836935-23819-8-git-send-email-guwen@linux.alibaba.com>
From:   Alexandra Winter <wintera@linux.ibm.com>
In-Reply-To: <1700836935-23819-8-git-send-email-guwen@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: fJDrBNokjRlIYL3rtNsZN4dw69qn_1ni
X-Proofpoint-ORIG-GUID: xSbd2aPQt7CNLtD5NBNNiINtRVyy21Is
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-27_11,2023-11-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 suspectscore=0
 bulkscore=0 phishscore=0 mlxlogscore=999 lowpriorityscore=0
 priorityscore=1501 impostorscore=0 mlxscore=0 adultscore=0 clxscore=1015
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311270096
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 24.11.23 15:42, Wen Gu wrote:
> The System EID (SEID) is an internal EID that is used by the SMCv2
> software stack that has a predefined and constant value representing
> the s390 physical machine that the OS is executing on. So it should
> be managed by SMC stack instead of ISM driver and be consistent for
> all ISMv2 device (including virtual ISM devices) on s390 architecture.
> 
> Suggested-by: Alexandra Winter <wintera@linux.ibm.com>
> Signed-off-by: Wen Gu <guwen@linux.alibaba.com>
> ---

Yes, this is what I had in mind. Thank you Wen Gu.
[...]

> 
> diff --git a/drivers/s390/net/ism.h b/drivers/s390/net/ism.h
> index 70c5bbd..49ccbd68 100644
> --- a/drivers/s390/net/ism.h
> +++ b/drivers/s390/net/ism.h

Please remove ISM_IDENT_MASK from drivers/s390/net/ism.h
[...]

> --- a/drivers/s390/net/ism_drv.c
> +++ b/drivers/s390/net/ism_drv.c
> @@ -36,6 +36,7 @@
[...]
> -static void ism_create_system_eid(void)
> -{
> -	struct cpuid id;
> -	u16 ident_tail;
> -	char tmp[5];
> -
> -	get_cpu_id(&id);
> -	ident_tail = (u16)(id.ident & ISM_IDENT_MASK);
> -	snprintf(tmp, 5, "%04X", ident_tail);
> -	memcpy(&SYSTEM_EID.serial_number, tmp, 4);
> -	snprintf(tmp, 5, "%04X", id.machine);
> -	memcpy(&SYSTEM_EID.type, tmp, 4);
> -}
> -
[...]
> @@ -560,7 +535,7 @@ static int ism_dev_init(struct ism_dev *ism)
>  
>  	if (!ism_add_vlan_id(ism, ISM_RESERVED_VLANID))
>  		/* hardware is V2 capable */
> -		ism_create_system_eid();
> +		ism_v2_capable = true;
>  

Please assign 'false' in the else path.
This is required here for backwards compatibility. Hardware that only supports v1,
will reject ISM_RESERVED_VLANID.

[...]


> --- a/net/smc/smc_ism.c
> +++ b/net/smc/smc_ism.c
[...]
> @@ -70,6 +91,11 @@ bool smc_ism_is_v2_capable(void)
>  	return smc_ism_v2_capable;
>  }
>  
> +void smc_ism_set_v2_capable(void)
> +{
> +	smc_ism_v2_capable = true;
> +}
> +
>  /* Set a connection using this DMBE. */
>  void smc_ism_set_conn(struct smc_connection *conn)
>  {
> @@ -431,14 +457,8 @@ static void smcd_register_dev(struct ism_dev *ism)
>  
>  	mutex_lock(&smcd_dev_list.mutex);
>  	if (list_empty(&smcd_dev_list.list)) {
> -		u8 *system_eid = NULL;
> -
> -		system_eid = smcd->ops->get_system_eid();
> -		if (smcd->ops->supports_v2()) {
> -			smc_ism_v2_capable = true;
> -			memcpy(smc_ism_v2_system_eid, system_eid,
> -			       SMC_MAX_EID_LEN);
> -		}
> +		if (smcd->ops->supports_v2())
> +			smc_ism_set_v2_capable();

I don't see the benefit in declaring smc_ism_set_v2_capable() and exporting it in smc_ism.h,
when it is used only once and only here. 
Why don't you just set 
	smc_ism_v2_capable = true;
here?

[...]
> diff --git a/net/smc/smc_ism.h b/net/smc/smc_ism.h
> index 0e5e563..6903cd5 100644
> --- a/net/smc/smc_ism.h
> +++ b/net/smc/smc_ism.h
> @@ -16,6 +16,7 @@
>  #include "smc.h"
>  
>  #define SMC_VIRTUAL_ISM_CHID_MASK	0xFF00
> +#define SMC_ISM_IDENT_MASK		0x00FFFF
>  
[...]
> @@ -45,6 +52,7 @@ int smc_ism_register_dmb(struct smc_link_group *lgr, int buf_size,
>  void smc_ism_get_system_eid(u8 **eid);
>  u16 smc_ism_get_chid(struct smcd_dev *dev);
>  bool smc_ism_is_v2_capable(void);
> +void smc_ism_set_v2_capable(void);
>  int smc_ism_init(void);
>  void smc_ism_exit(void);
>  int smcd_nl_get_device(struct sk_buff *skb, struct netlink_callback *cb);

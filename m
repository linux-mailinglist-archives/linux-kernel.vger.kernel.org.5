Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A08C7CE7FA
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 21:44:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231641AbjJRToK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 15:44:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231588AbjJRToH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 15:44:07 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8F9695;
        Wed, 18 Oct 2023 12:44:05 -0700 (PDT)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39IJbvWe032552;
        Wed, 18 Oct 2023 19:44:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=T1fezS4UywICDvJ90uKoLiKK+E/ufLqrGA8Vl8sOm7E=;
 b=hjCb/cMYtY2FfPWJ/DZ6QGQWpN0tIkJ1QEa9ZA6c3H+59zXwTeZRFZ+zselE0B4eHpCR
 XRQVOiYVmt2ypFChQH239RCEaThyTP+ZGEHsmZqnDQc+1HX6qu3jV/3z52ZCiGaXTUOH
 ICN5LFLpADTF3/ozpbqXWgpK2DvUTzIN7c/P78R0CygNI3PYu++lxyqK9uPzf35VCmeu
 OxxAiMfxGbMWW65YQQgtEuwFBo6ZEyDSRVJqLnLYqoiek2bmjv1rEZpQjaAOefAfTyAk
 2CViqeg2fUnLZpakJWbjihsB+MXuQhXCGzhOz7dcNlmQ3lsgw3bJZKTnYfUMljZ8UzGA /Q== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ttnpb89ym-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 18 Oct 2023 19:44:03 +0000
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 39IJdQ5G006027;
        Wed, 18 Oct 2023 19:44:02 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ttnpb89kc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 18 Oct 2023 19:44:02 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
        by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 39IHpSPC019672;
        Wed, 18 Oct 2023 19:43:55 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
        by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3tr811u05x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 18 Oct 2023 19:43:55 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
        by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 39IJhs0528574412
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 Oct 2023 19:43:54 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 94AC35804E;
        Wed, 18 Oct 2023 19:43:54 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D405958055;
        Wed, 18 Oct 2023 19:43:51 +0000 (GMT)
Received: from [9.171.53.134] (unknown [9.171.53.134])
        by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Wed, 18 Oct 2023 19:43:51 +0000 (GMT)
Message-ID: <a33cb54f-3414-4034-bb0a-9aeebd65f044@linux.ibm.com>
Date:   Wed, 18 Oct 2023 21:43:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2 2/2] net/smc: correct the reason code in
 smc_listen_find_device when fallback
Content-Language: en-GB
To:     Guangguan Wang <guangguan.wang@linux.alibaba.com>,
        dust.li@linux.alibaba.com, kgraul@linux.ibm.com,
        jaka@linux.ibm.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com
Cc:     tonylu@linux.alibaba.com, alibuda@linux.alibaba.com,
        guwen@linux.alibaba.com, linux-s390@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20231017124234.99574-1-guangguan.wang@linux.alibaba.com>
 <20231017124234.99574-3-guangguan.wang@linux.alibaba.com>
 <20231018070142.GY92403@linux.alibaba.com>
 <c7277fd2-cc44-40a1-9f56-9341d3340e2e@linux.alibaba.com>
From:   Wenjia Zhang <wenjia@linux.ibm.com>
In-Reply-To: <c7277fd2-cc44-40a1-9f56-9341d3340e2e@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: sTVJhDrlY6O5BgV306ffAYNxtAvjjqAX
X-Proofpoint-ORIG-GUID: 50GX0DNAtrOiyUV2A07uqipHBU0FTfqN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-18_18,2023-10-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 bulkscore=0
 lowpriorityscore=0 priorityscore=1501 mlxscore=0 clxscore=1015
 impostorscore=0 mlxlogscore=999 adultscore=0 phishscore=0 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310180162
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 18.10.23 10:35, Guangguan Wang wrote:
> 
> 
> On 2023/10/18 15:01, Dust Li wrote:
>> On Tue, Oct 17, 2023 at 08:42:34PM +0800, Guangguan Wang wrote:
>>> The ini->rc is used to store the last error happened when finding usable
>>> ism or rdma device in smc_listen_find_device, and is set by calling smc_
>>> find_device_store_rc. Once the ini->rc is assigned to an none-zero value,
>>> the value can not be overwritten anymore. So the ini-rc should be set to
>>> the error reason only when an error actually occurs.
>>>
>>> When finding ISM/RDMA devices, device not found is not a real error, as
>>> not all machine have ISM/RDMA devices. Failures after device found, when
What do you mean about this sentence? Do you mean that no any (ISM/RDMA) 
device  found is not real error? If not, what is the real reason?

>>> initializing device or when initializing connection, is real errors, and
>>> should be store in ini->rc.
>>>
>>> SMC_CLC_DECL_DIFFPREFIX also is not a real error, as for SMC-RV2, it is
>>> not require same prefix.
>>>
>>> Signed-off-by: Guangguan Wang <guangguan.wang@linux.alibaba.com>
>>> ---
>>> net/smc/af_smc.c | 12 +++---------
>>> 1 file changed, 3 insertions(+), 9 deletions(-)
>>>
>>> diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
>>> index b3a67a168495..21e9c6ec4d01 100644
>>> --- a/net/smc/af_smc.c
>>> +++ b/net/smc/af_smc.c
>>> @@ -2163,10 +2163,8 @@ static void smc_find_ism_v2_device_serv(struct smc_sock *new_smc,
>>> 	}
>>> 	mutex_unlock(&smcd_dev_list.mutex);
>>>
>>> -	if (!ini->ism_dev[0]) {
>>> -		smc_find_device_store_rc(SMC_CLC_DECL_NOSMCD2DEV, ini);
>>> +	if (!ini->ism_dev[0])
>>
>> Hi Guangguan,
>>
>> Generally, I think this is right. Fallback in one kind of device should
>> not be the final fallback reason.
>>
>> But what if we have more than one device and failed more than once, for
>> example:
>> Let's say we have an ISM device, a RDMA device. First we looked the ISM device
>> and failed during the initialization, we got a fallback reason A. Then we
>> looked for the RDMA device, and failed again, with another reason B.
>> Finally, we fallback to TCP. What should fallback reason be ?
> 
> IMO, the order of finding devices is defined by preference. ISM v2, ISM v1, RDMA v2, RDMA v1, the former the prefer.
> I think it should return the most preferred device's failure reason if found and failed during the initialization.
> So, here should return the first reason(reason A).
> 
In this case Dust mentioned, I'd prefer a reaon including A and B, like 
current reason SMC_CLC_DECL_NOSMCDEV.

>>
>> OTOH, SMC_CLC_DECL_NOSMCD2DEV is only used here. Removing it would mean
>> that we would never see SMC_CLC_DECL_NOSMCD2DEV in the fallback reason,
>> which makes it meaningless.
>>
>   
> Is SMC_CLC_DECL_NOSMCD2DEV really necessary? There is no reason names SMC_CLC_DECL_NOSMCR2DEV.
> 
I do see the necessity for the debugging.
> Thanks,
> Guangguan Wang
> 
>> Best regards,
>> Dust
>>
>>> 		goto not_found;
>>> -	}
>>>
>>> 	smc_ism_get_system_eid(&eid);
>>> 	if (!smc_clc_match_eid(ini->negotiated_eid, smc_v2_ext,
>>> @@ -2216,9 +2214,9 @@ static void smc_find_ism_v1_device_serv(struct smc_sock *new_smc,
>>> 	rc = smc_listen_ism_init(new_smc, ini);
>>> 	if (!rc)
>>> 		return;		/* V1 ISM device found */
>>> +	smc_find_device_store_rc(rc, ini);
>>>
>>> not_found:
>>> -	smc_find_device_store_rc(rc, ini);
>>> 	ini->smcd_version &= ~SMC_V1;
>>> 	ini->ism_dev[0] = NULL;
>>> 	ini->is_smcd = false;
>>> @@ -2267,10 +2265,8 @@ static void smc_find_rdma_v2_device_serv(struct smc_sock *new_smc,
>>> 	ini->smcrv2.saddr = new_smc->clcsock->sk->sk_rcv_saddr;
>>> 	ini->smcrv2.daddr = smc_ib_gid_to_ipv4(smc_v2_ext->roce);
>>> 	rc = smc_find_rdma_device(new_smc, ini);
>>> -	if (rc) {
>>> -		smc_find_device_store_rc(rc, ini);
>>> +	if (rc)
>>> 		goto not_found;
>>> -	}
>>> 	if (!ini->smcrv2.uses_gateway)
>>> 		memcpy(ini->smcrv2.nexthop_mac, pclc->lcl.mac, ETH_ALEN);
>>>
>>> @@ -2331,8 +2327,6 @@ static int smc_listen_find_device(struct smc_sock *new_smc,
>>>
>>> 	/* check for matching IP prefix and subnet length (V1) */
>>> 	prfx_rc = smc_listen_prfx_check(new_smc, pclc);
>>> -	if (prfx_rc)
>>> -		smc_find_device_store_rc(prfx_rc, ini);
>>>
>>> 	/* get vlan id from IP device */
>>> 	if (smc_vlan_by_tcpsk(new_smc->clcsock, ini))
>>> -- 
>>> 2.24.3 (Apple Git-128)

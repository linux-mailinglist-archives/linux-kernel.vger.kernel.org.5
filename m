Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3407804EB3
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 10:52:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235055AbjLEJv6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 04:51:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235029AbjLEJvx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 04:51:53 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE6B2127;
        Tue,  5 Dec 2023 01:51:59 -0800 (PST)
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B59mKrM026723;
        Tue, 5 Dec 2023 09:51:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=K2INagPhm0bbOH+kwrPAF2/wkzUBLPFqq8LrsNbIESs=;
 b=QGed3lmIyH630QqeJ2GgHhwulUAl89oSD0o7j4QjBPxYNkdmZ4DwnMqYqZAIAkjokcN/
 uqc2s71LSDMZC2k4vrUalT6VFx5tgtTogPNxu7ZKNPqQgxxgwCA06fnHHy+opgXczloV
 n2/KN7TLFehbLmTqqcO6VN0hX1EUOYaWbMzGTTFUmBAq0qoST5Ni8/0ofTemjGdTsGY3
 cm0i1d+1Wh+NZkETgPkOauvvR5LcmojEUJhwhIoRb9aR6h2IUWLbC0hzU+6yghw6OjFs
 u3KoO/r/WTx012q/dSiUufgdYyQH3CFKwh8sqMCD5D+R1B/aiHKAEMBNwzU5mUJR4PxJ 3A== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ut1j182ju-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 05 Dec 2023 09:51:54 +0000
Received: from m0353723.ppops.net (m0353723.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3B59nr8B030135;
        Tue, 5 Dec 2023 09:51:53 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ut1j182cd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 05 Dec 2023 09:51:53 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
        by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3B57YLVt022637;
        Tue, 5 Dec 2023 09:51:32 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
        by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3urhm258sp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 05 Dec 2023 09:51:32 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
        by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3B59pTHI18940560
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 5 Dec 2023 09:51:29 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6A2322004B;
        Tue,  5 Dec 2023 09:51:29 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 08CC620043;
        Tue,  5 Dec 2023 09:51:29 +0000 (GMT)
Received: from [9.152.224.24] (unknown [9.152.224.24])
        by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Tue,  5 Dec 2023 09:51:28 +0000 (GMT)
Message-ID: <edb7dc54-a7f9-4356-a2a4-905b5f48b1f0@linux.ibm.com>
Date:   Tue, 5 Dec 2023 10:51:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 5/7] net/smc: compatible with 128-bits extend
 GID of virtual ISM device
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
References: <1701343695-122657-1-git-send-email-guwen@linux.alibaba.com>
 <1701343695-122657-6-git-send-email-guwen@linux.alibaba.com>
 <19b288d3-5434-40b1-93fa-7db47e417f60@linux.ibm.com>
 <3f8dfc86-c27a-f1df-0a58-35fb4948e526@linux.alibaba.com>
From:   Alexandra Winter <wintera@linux.ibm.com>
In-Reply-To: <3f8dfc86-c27a-f1df-0a58-35fb4948e526@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: PdGQx-BgP_YwVmrJsDRplK-pFvZB-WNK
X-Proofpoint-GUID: 3DIC8H6iwyLrtbQK9147eyq813_uomKt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-05_04,2023-12-04_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=999 lowpriorityscore=0 bulkscore=0 suspectscore=0 spamscore=0
 malwarescore=0 phishscore=0 clxscore=1015 mlxscore=0 adultscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2312050080
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 04.12.23 13:24, Wen Gu wrote:
> Thank you very much for review. See below.
> 
> On 2023/12/2 00:30, Alexandra Winter wrote:
>>
>>
>> On 30.11.23 12:28, Wen Gu wrote:
>> [...]
>>> diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
>>> index 766a1f1..d1e18bf 100644
>>> --- a/net/smc/af_smc.c
>>> +++ b/net/smc/af_smc.c
>> [...]
>>> @@ -1048,7 +1048,8 @@ static int smc_find_ism_v2_device_clnt(struct smc_sock *smc,
>>>   {
>>>       int rc = SMC_CLC_DECL_NOSMCDDEV;
>>>       struct smcd_dev *smcd;
>>> -    int i = 1;
>>> +    int i = 1, entry = 1;
>>> +    bool is_virtual;
>>>       u16 chid;
>>>         if (smcd_indicated(ini->smc_type_v1))
>>> @@ -1060,14 +1061,23 @@ static int smc_find_ism_v2_device_clnt(struct smc_sock *smc,
>>>           chid = smc_ism_get_chid(smcd);
>>>           if (!smc_find_ism_v2_is_unique_chid(chid, ini, i))
>>>               continue;
>>> +        is_virtual = __smc_ism_is_virtual(chid);
>>>           if (!smc_pnet_is_pnetid_set(smcd->pnetid) ||
>>>               smc_pnet_is_ndev_pnetid(sock_net(&smc->sk), smcd->pnetid)) {
>>> +            if (is_virtual && entry == SMC_MAX_ISM_DEVS)
>>> +                /* only one GID-CHID entry left in CLC Proposal SMC-Dv2
>>> +                 * extension. but a virtual ISM device's GID takes two
>>> +                 * entries. So give up it and try the next potential ISM
>>> +                 * device.
>>> +                 */
>>
>> It is really importatnt to note that virtual ISMs take 2 entries.
>> But it is still hard to understand this piece of code. e.g. I was wondering for a while,
>> why you mention CLC here...
>> Maybe it would be easier to understand this, if you rename SMC_MAX_ISM_DEVS to something else?
>> Something like SMCD_MAX_V2_GID_ENTRIES?
>>
> 
> I agree.
> 
> But I perfer to define a new macro to represent the max ISMv2 entries in CLC proposal message,
> e.g. SMCD_CLC_MAX_V2_GID_ENTRIES, and keep using SMC_MAX_ISM_DEVS to represent the max devices
> that can be proposed. Both semantics are required in the code, such as:
> 
> ini->ism_dev[SMC_MAX_ISM_DEVS]        | smcd_v2_ext->gidchid[SMCD_CLC_MAX_V2_GID_ENTRIES]
> -------------------------------------------------------------------------------------------
> [1:virtual_ISM_1]                     | [1:virtual_ISM_1 GID]
>                                       | [2:virtual_ISM_1 extension GID]
> [2:ISM_2]                             | [3:ISM_2 GID/CHID]
> [3:ISM_3]                             | [4:ISM_3 GID/CHID]
> 
> And SMC_MAX_ISM_DEVS is required no more than SMCD_CLC_MAX_V2_GID_ENTRIES.

I agree, this is even better.

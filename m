Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B01347C76A7
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 21:24:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442125AbjJLTX7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 15:23:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442071AbjJLTX4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 15:23:56 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C198BB;
        Thu, 12 Oct 2023 12:23:55 -0700 (PDT)
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39CJMnpw028395;
        Thu, 12 Oct 2023 19:23:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=Ujq9HEe+dEgNGePgJ0zVUq1niKYvqT3YYqdkfFcOObk=;
 b=lFviFLRwFWGhAQFAG8I+DXB98rHsRidJ4J0hLdgeT4R2Lc5jiSO0rj5o0/qH+68ooFBP
 jHtuJ+jjP8IYjeb+KUnZgjKQfITt7LRUecVlHko61Y6kG/vNT6A/feNBX+JWHNB43tMK
 q3eBp321qFmQPfKNogXUfSzj2nrPfczpr3kpHXObyqckDuU92tgOQNbyIgtie7QPJIz3
 IHVdpc8lVx7vvwky2rNjSfZEi5hXN71cZd3kFZbVMoEzfSta5h45lE9vtzSINSMm0u7h
 07iGn1GH12R+auv5eYHEALFuuUP/WHMOSwgRRreZKdG0EyQ/1oDguSFEytj6oySfIMT5 fg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tppwar0h8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 Oct 2023 19:23:36 +0000
Received: from m0353728.ppops.net (m0353728.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 39CJNViI031012;
        Thu, 12 Oct 2023 19:23:35 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tppwar0gu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 Oct 2023 19:23:35 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
        by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 39CIh3l3001170;
        Thu, 12 Oct 2023 19:23:34 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
        by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3tkkvk9fm9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 Oct 2023 19:23:34 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
        by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 39CJNXiE11272764
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 Oct 2023 19:23:33 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 811185805B;
        Thu, 12 Oct 2023 19:23:33 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9CDA258058;
        Thu, 12 Oct 2023 19:23:30 +0000 (GMT)
Received: from [9.171.29.13] (unknown [9.171.29.13])
        by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Thu, 12 Oct 2023 19:23:30 +0000 (GMT)
Message-ID: <2d5224b6-1ff2-4c0f-8b7b-3c3ff6d34157@linux.ibm.com>
Date:   Thu, 12 Oct 2023 21:23:29 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net/smc: add support for netdevice in
 containers.
Content-Language: en-GB
To:     dust.li@linux.alibaba.com,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Albert Huang <huangjie.albert@bytedance.com>,
        Karsten Graul <kgraul@linux.ibm.com>,
        Jan Karcher <jaka@linux.ibm.com>
Cc:     "D. Wythe" <alibuda@linux.alibaba.com>,
        Tony Lu <tonylu@linux.alibaba.com>,
        Wen Gu <guwen@linux.alibaba.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, linux-s390@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230925023546.9964-1-huangjie.albert@bytedance.com>
 <00bbbf48440c1889ecd16a590ebb746b820a4f48.camel@linux.ibm.com>
 <20231011144816.GO92403@linux.alibaba.com>
 <20231012121740.GR92403@linux.alibaba.com>
From:   Wenjia Zhang <wenjia@linux.ibm.com>
In-Reply-To: <20231012121740.GR92403@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: dQX6mAR0JwdnEXr-0JGA0JnUqegMsj_q
X-Proofpoint-GUID: UiIth32omlzHZOJMLaylWZecWGdyJjrs
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-12_11,2023-10-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 phishscore=0 clxscore=1015 lowpriorityscore=0 bulkscore=0 mlxlogscore=999
 impostorscore=0 suspectscore=0 adultscore=0 spamscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310120161
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12.10.23 14:17, Dust Li wrote:
> On Wed, Oct 11, 2023 at 10:48:16PM +0800, Dust Li wrote:
>> On Thu, Sep 28, 2023 at 05:04:21PM +0200, Niklas Schnelle wrote:
>>> On Mon, 2023-09-25 at 10:35 +0800, Albert Huang wrote:
>>>> If the netdevice is within a container and communicates externally
>>>> through network technologies like VXLAN, we won't be able to find
>>>> routing information in the init_net namespace. To address this issue,
>>>> we need to add a struct net parameter to the smc_ib_find_route function.
>>>> This allow us to locate the routing information within the corresponding
>>>> net namespace, ensuring the correct completion of the SMC CLC interaction.
>>>>
>>>> Signed-off-by: Albert Huang <huangjie.albert@bytedance.com>
>>>> ---
>>>>   net/smc/af_smc.c | 3 ++-
>>>>   net/smc/smc_ib.c | 7 ++++---
>>>>   net/smc/smc_ib.h | 2 +-
>>>>   3 files changed, 7 insertions(+), 5 deletions(-)
>>>>
>>>
>>> I'm trying to test this patch on s390x but I'm running into the same
>>> issue I ran into with the original SMC namespace
>>> support:https://lore.kernel.org/netdev/8701fa4557026983a9ec687cfdd7ac5b3b85fd39.camel@linux.ibm.com/
>>>
>>> Just like back then I'm using a server and a client network namespace
>>> on the same system with two ConnectX-4 VFs from the same card and port.
>>> Both TCP/IP traffic as well as user-space RDMA via "qperf … rc_bw" and
>>> `qperf … rc_lat` work between namespaces and definitely go via the
>>> card.
>>>
>>> I did use "rdma system set netns exclusive" then moved the RDMA devices
>>> into the namespaces with "rdma dev set <rdma_dev> netns <namespace>". I
>>> also verified with "ip netns exec <namespace> rdma dev"
>>> that the RDMA devices are in the network namespace and as seen by the
>>> qperf runs normal RDMA does work.
>>>
>>> For reference the smc_chck tool gives me the following output:
>>>
>>> Server started on port 37373
>>> [DEBUG] Interfaces to check: eno4378
>>> Test with target IP 10.10.93.12 and port 37373
>>>   Live test (SMC-D and SMC-R)
>>> [DEBUG] Running client: smc_run /tmp/echo-clt.x0q8iO 10.10.93.12 -p
>>> 37373
>>> [DEBUG] Client result: TCP 0x05000000/0x03030000
>>>      Failed  (TCP fallback), reasons:
>>>           Client:        0x05000000   Peer declined during handshake
>>>           Server:        0x03030000   No SMC devices found (R and D)
>>>
>>> I also checked that SMC is generally working, once I add an ISM device
>>> I do get SMC-D between the namespaces. Any ideas what could break SMC-R
>>> here?
>>
>> I missed the email :(
>>
>> Are you running SMC-Rv2 or v1 ?
> 
> Hi Niklas,
> 
> I tried your test today, and I encounter the same issue.
> But I found it's because my 2 VFs are in difference subnets,
> SMC-Rv2 work fine, SMC-Rv1 won't work, which is expected.
> When I set the 2 VFs in the same subnet, SMC-Rv1 also works.
> 
> So I'm not sure it's the same for you. Can you check it out ?
> 
> BTW, the fallback reason(SMC_CLC_DECL_NOSMCDEV) in this case
> is really not friendly, it's better to return SMC_CLC_DECL_DIFFPREFIX.
> 
> Best regards,
> Dust
> 
Thank you, Dust, for trying it out!
The reason code SMC_CLC_DECL_NOSMCDEV there could really make one 
misunderstand.

> 
>>
>> Best regards,
>> Dust
>>
>>
>>>
>>> Thanks,
>>> Niklas

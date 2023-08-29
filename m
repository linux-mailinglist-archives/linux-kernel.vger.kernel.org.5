Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E223778C4FF
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 15:19:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235925AbjH2NSc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 09:18:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235932AbjH2NST (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 09:18:19 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC16C187;
        Tue, 29 Aug 2023 06:18:16 -0700 (PDT)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37TCZFw3011224;
        Tue, 29 Aug 2023 13:18:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date : from
 : subject : to : cc : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=NuCjsxWNfxqtK7+8oiuLPQKeSPs4dNgp+Zg2Eczw8DQ=;
 b=HcpMKsNx4ejnRiqoBEiLirbvHh/GBRF8nL0DcTYLihV7D6++XVaD7cZkeAv+uIvMfADB
 1jfwP1AQaDYeqOh5OZ8qvq4zEdx8rtQn4h1N0DVx+wn8MCvH1u1DqkhVTC1EvWBqi4hC
 OsJNiTsaBhe6XjBNgrw52ALT2lUQh3rdlmd9StJrWmM5vcU6mV8qGINa2Ylymg1Ky86G
 LowvWPCfeKAx5djiysQ6fgVab5bFEKRQXaq+/p9TXADLVJ/bTo0wnl3zYheNpqz00vB7
 s1anmFe9zHoV1gEimIkMVUnpMDjxKUysNbYetUzNzNzw3KUHSmhmG9vUJs3ltJiZDRYf UA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ssfmkbf7d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 29 Aug 2023 13:18:10 +0000
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 37TDAvAM024578;
        Tue, 29 Aug 2023 13:18:09 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ssfmkbf6r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 29 Aug 2023 13:18:09 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
        by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 37TBDxfn014115;
        Tue, 29 Aug 2023 13:18:08 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
        by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3sqwxju62y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 29 Aug 2023 13:18:08 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
        by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 37TDI7xb23069046
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Aug 2023 13:18:07 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CE89D5805E;
        Tue, 29 Aug 2023 13:18:07 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B9CF65805A;
        Tue, 29 Aug 2023 13:18:05 +0000 (GMT)
Received: from [9.171.1.177] (unknown [9.171.1.177])
        by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Tue, 29 Aug 2023 13:18:05 +0000 (GMT)
Message-ID: <e1cba3b8-1333-3b30-04f2-c7634bf02da1@linux.ibm.com>
Date:   Tue, 29 Aug 2023 15:18:04 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
From:   Wenjia Zhang <wenjia@linux.ibm.com>
Subject: Re: [RFC PATCH v2 net-next 4/6] net/smc: support max connections per
 lgr negotiation
To:     Guangguan Wang <guangguan.wang@linux.alibaba.com>,
        jaka@linux.ibm.com, kgraul@linux.ibm.com, tonylu@linux.alibaba.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com
Cc:     horms@kernel.org, alibuda@linux.alibaba.com,
        guwen@linux.alibaba.com, linux-s390@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230807062720.20555-1-guangguan.wang@linux.alibaba.com>
 <20230807062720.20555-5-guangguan.wang@linux.alibaba.com>
 <a7ed9f2d-5c50-b37f-07d4-088ceef6aeac@linux.ibm.com>
 <9f4292c4-4004-b73b-1079-41ce7b1a5750@linux.alibaba.com>
 <2dbf25a0-05a6-d899-3351-598e952a927d@linux.ibm.com>
 <484c9f62-748c-6193-9c02-c41449b757b4@linux.alibaba.com>
In-Reply-To: <484c9f62-748c-6193-9c02-c41449b757b4@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: kuEH14m8bLsoctsMlYa0dbPBzXsACaw6
X-Proofpoint-ORIG-GUID: syGWUMMTqQbHOw2bJdSVPDCXsK_7Bs-l
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-29_10,2023-08-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 clxscore=1015 bulkscore=0 mlxlogscore=999 lowpriorityscore=0 spamscore=0
 impostorscore=0 priorityscore=1501 phishscore=0 malwarescore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2308290113
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 29.08.23 04:31, Guangguan Wang wrote:
> 
> 
> On 2023/8/28 20:54, Wenjia Zhang wrote:
>>
>>
>> On 15.08.23 08:31, Guangguan Wang wrote:
>>>
>>>
>>> On 2023/8/10 00:04, Wenjia Zhang wrote:
>>>>
>>>>
>>>> On 07.08.23 08:27, Guangguan Wang wrote:
>>>>> Support max connections per lgr negotiation for SMCR v2.1,
>>>>> which is one of smc v2.1 features.
>>> ...
>>>>> @@ -472,6 +473,9 @@ int smc_llc_send_confirm_link(struct smc_link *link,
>>>>>         confllc->link_num = link->link_id;
>>>>>         memcpy(confllc->link_uid, link->link_uid, SMC_LGR_ID_SIZE);
>>>>>         confllc->max_links = SMC_LLC_ADD_LNK_MAX_LINKS;
>>>>> +    if (link->lgr->smc_version == SMC_V2 &&
>>>>> +        link->lgr->peer_smc_release >= SMC_RELEASE_1)
>>>>> +        confllc->max_conns = link->lgr->max_conns;
>>>>>         /* send llc message */
>>>>>         rc = smc_wr_tx_send(link, pend);
>>>>>     put_out:
>>>>
>>>> Did I miss the negotiation process somewhere for the following scenario?
>>>> (Example 4 in the document)
>>>> Client                 Server
>>>>       Proposal(max conns(16))
>>>>       ----------------------->
>>>>
>>>>       Accept(max conns(32))
>>>>       <-----------------------
>>>>
>>>>       Confirm(max conns(32))
>>>>       ----------------------->
>>>
>>> Did you mean the accepted max conns is different(not 32) from the Example 4 when the proposal max conns is 16?
>>>
>>> As described in (https://www.ibm.com/support/pages/node/7009315) page 41:
>>> ...
>>> 2. Max conns and max links values sent in the CLC Proposal are the client preferred values.
>>> 3. The v2.1 values sent in the Accept message are the final values. The client must accept the values or
>>> DECLINE the connection.
>>> 4. Max conns and links values sent in the CLC Accept are the final values (server dictates). The server can
>>> either honor the client’s preferred values or return different (negotiated but final) values.
>>> ...
>>>
>>> If I understand correctly, the server dictates the final value of max conns, but how the server dictates the final
>>> value of max conns is not defined in SMC v2.1. In this patch, the server use the minimum value of client preferred
>>> value and server preferred value as the final value of max conns. The max links is negotiated with the same logic.
>>>
>>> Client                 Server
>>>        Proposal(max conns(client preferred))
>>>        ----------------------->
>>>          Accept(max conns(accepted value)) accepted value=min(client preferred, server preferred)
>>>        <-----------------------
>>>          Confirm(max conns(accepted value))
>>>        ----------------------->
>>>
>>> I also will add this description into commit message for better understanding.
>>>
>>> Thanks,
>>> Guangguan Wang
>>>
>>>
>>>
>>
>> Sorry for the late answer, I'm just back from vacation.
>>
>> That's true that the protocol does not define how the server decides the final value(s). I'm wondering if there is some reason for you to use the minimum value instead of maximum (corresponding to the examples in the document). If the both prefered values (client's and server's) are in the range of the acceptable value, why not the maximum? Is there any consideration on that?
>>
>> Best,
>> Wenjia
> 
> Since the value of the default preferred max conns is already the maximum value of the range(16-255), I am wondering
> whether it makes any sense to use the maximum for decision, where the negotiated result of max conns is always 255.
> So does the max links.
> 
> Thanks,
> Guangguan

I don't think the server's default maxconns must be the maximum value, 
i.e 255. Since the patches series are already applied, we say the 
previous implementation uses maximus value because the maxconns is not 
tunable, so that we choose an appropriate value as the default value.
Now the value is negotiable, the default value could be also the 
server's prefer value.
But regarding maxlinks, I'm fine with the minimus, and actually it 
should be, because it should not be possible to try to add another link 
if one of the peers can and want to support only one link, i.e. down-level.
Any opinion?

Best,
Wenjia

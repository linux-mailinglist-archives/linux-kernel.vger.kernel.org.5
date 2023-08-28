Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5831478B1C6
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 15:26:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230497AbjH1NZr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 09:25:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230377AbjH1NZZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 09:25:25 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E58BB124;
        Mon, 28 Aug 2023 06:25:22 -0700 (PDT)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37SD7ZtI020130;
        Mon, 28 Aug 2023 13:25:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=wZAjz4E7MEsOdY9HI/dOJ+RW62+KtVSEo0RkQ75UebY=;
 b=j57/lF8Tv/JQoGxZJbvUxl10p0Xb5f8VCO0TiRk7M1PQMDfjQ0cxapz41311fD0wE3Un
 PNhaNLFa37E+z3It2xCVmALxS8UE8r/Wi+y9CdWRWP8t6S24rZuOykknheS54/oj27bU
 StULUfSvmriA7hto3K2NfhzT4ewyoHbyrp6aIR4XD+RsZR3gHTyM7lFkfYEnltXKvJuE
 1CpWo4rcmXmvSzS98LCShtu4iZYK+46ZdYFoVmXFZbG+zoP4TxMmG2/sCqH7y/O25xpA
 G6aGLQlcmgGISoTVDV76D8uWxVF3nzEsPN+7MganAfETKyzAwqdezgEf16onOKco2P0k jA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sradxwc4g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 28 Aug 2023 13:25:17 +0000
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 37SD8Do7024092;
        Mon, 28 Aug 2023 13:25:17 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sradxwc17-11
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 28 Aug 2023 13:25:16 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 37SC0A4o020504;
        Mon, 28 Aug 2023 12:55:01 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
        by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3sqv3y2xqr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 28 Aug 2023 12:55:01 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
        by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 37SCt0mH52691204
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 28 Aug 2023 12:55:01 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9B0F558056;
        Mon, 28 Aug 2023 12:55:00 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E000C5805A;
        Mon, 28 Aug 2023 12:54:57 +0000 (GMT)
Received: from [9.171.1.65] (unknown [9.171.1.65])
        by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Mon, 28 Aug 2023 12:54:57 +0000 (GMT)
Message-ID: <2dbf25a0-05a6-d899-3351-598e952a927d@linux.ibm.com>
Date:   Mon, 28 Aug 2023 14:54:57 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
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
From:   Wenjia Zhang <wenjia@linux.ibm.com>
In-Reply-To: <9f4292c4-4004-b73b-1079-41ce7b1a5750@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: dxp3Odo9LCCf7KpDDX-UWtNUORvU9bcv
X-Proofpoint-ORIG-GUID: BrccTP5sTCCSuVjWTMmG94m7cO4vtnb8
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-28_09,2023-08-28_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 spamscore=0
 lowpriorityscore=0 priorityscore=1501 mlxlogscore=999 clxscore=1011
 suspectscore=0 malwarescore=0 mlxscore=0 adultscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2308280114
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 15.08.23 08:31, Guangguan Wang wrote:
> 
> 
> On 2023/8/10 00:04, Wenjia Zhang wrote:
>>
>>
>> On 07.08.23 08:27, Guangguan Wang wrote:
>>> Support max connections per lgr negotiation for SMCR v2.1,
>>> which is one of smc v2.1 features.
> ...
>>> diff --git a/net/smc/smc_core.c b/net/smc/smc_core.c
>>> index 6aa3db47a956..5de1fbaa6e28 100644
>>> --- a/net/smc/smc_core.c
>>> +++ b/net/smc/smc_core.c
>>> @@ -895,9 +895,11 @@ static int smc_lgr_create(struct smc_sock *smc, struct smc_init_info *ini)
>>>                lgr->uses_gateway = ini->smcrv2.uses_gateway;
>>>                memcpy(lgr->nexthop_mac, ini->smcrv2.nexthop_mac,
>>>                       ETH_ALEN);
>>> +            lgr->max_conns = ini->max_conns;
>>>            } else {
>>>                ibdev = ini->ib_dev;
>>>                ibport = ini->ib_port;
>>> +            lgr->max_conns = SMC_RMBS_PER_LGR_MAX;
>>
>>
>> It is kind of confused sometimes SMC_RMBS_PER_LGR_MAX is used and sometimes SMC_CONN_PER_LGR_MAX. IMO, you can use SMC_CONN_PER_LGR_MAX in the patches series for the new feature, because they are the same value and the name is more suiable.
> 
> OK, I will re-define the macros like this:
> #define SMC_CONN_PER_LGR_MAX 255
> #define SMC_CONN_PER_LGR_MIN 16
> #define SMC_CONN_PER_LGR_PREFER 255 //vendors or distrubutions can modify this to a value between 16-255 as needed.
> 
> ...
>>> @@ -472,6 +473,9 @@ int smc_llc_send_confirm_link(struct smc_link *link,
>>>        confllc->link_num = link->link_id;
>>>        memcpy(confllc->link_uid, link->link_uid, SMC_LGR_ID_SIZE);
>>>        confllc->max_links = SMC_LLC_ADD_LNK_MAX_LINKS;
>>> +    if (link->lgr->smc_version == SMC_V2 &&
>>> +        link->lgr->peer_smc_release >= SMC_RELEASE_1)
>>> +        confllc->max_conns = link->lgr->max_conns;
>>>        /* send llc message */
>>>        rc = smc_wr_tx_send(link, pend);
>>>    put_out:
>>
>> Did I miss the negotiation process somewhere for the following scenario?
>> (Example 4 in the document)
>> Client                 Server
>>      Proposal(max conns(16))
>>      ----------------------->
>>
>>      Accept(max conns(32))
>>      <-----------------------
>>
>>      Confirm(max conns(32))
>>      ----------------------->
> 
> Did you mean the accepted max conns is different(not 32) from the Example 4 when the proposal max conns is 16?
> 
> As described in (https://www.ibm.com/support/pages/node/7009315) page 41:
> ...
> 2. Max conns and max links values sent in the CLC Proposal are the client preferred values.
> 3. The v2.1 values sent in the Accept message are the final values. The client must accept the values or
> DECLINE the connection.
> 4. Max conns and links values sent in the CLC Accept are the final values (server dictates). The server can
> either honor the client’s preferred values or return different (negotiated but final) values.
> ...
> 
> If I understand correctly, the server dictates the final value of max conns, but how the server dictates the final
> value of max conns is not defined in SMC v2.1. In this patch, the server use the minimum value of client preferred
> value and server preferred value as the final value of max conns. The max links is negotiated with the same logic.
> 
> Client                 Server
>       Proposal(max conns(client preferred))
>       ----------------------->
>   
>       Accept(max conns(accepted value)) accepted value=min(client preferred, server preferred)
>       <-----------------------
>   
>       Confirm(max conns(accepted value))
>       ----------------------->
> 
> I also will add this description into commit message for better understanding.
> 
> Thanks,
> Guangguan Wang
> 
> 
> 

Sorry for the late answer, I'm just back from vacation.

That's true that the protocol does not define how the server decides the 
final value(s). I'm wondering if there is some reason for you to use the 
minimum value instead of maximum (corresponding to the examples in the 
document). If the both prefered values (client's and server's) are in 
the range of the acceptable value, why not the maximum? Is there any 
consideration on that?

Best,
Wenjia


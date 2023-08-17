Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41EF477F0A8
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 08:43:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348299AbjHQGm5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 02:42:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348313AbjHQGmh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 02:42:37 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21D532D63;
        Wed, 16 Aug 2023 23:42:30 -0700 (PDT)
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37H6bktL023453;
        Thu, 17 Aug 2023 06:42:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=FlbNCA6xgJ30vKto+vD+yS4gMg4g7W2LICECtg1VPlw=;
 b=T1xMRN59u8zTktlvV+pgLanaNTkfXrFD5m58Aae8oQyN2AS7uRz7pCurEBEBKvqltKFM
 mvET0FDf6WkenLfnLJue97i0POoTp+ovRL7riDayqDAnCCHwA8FoUuzOE7qLDFCVmZvQ
 Xqx0jzyepHIbIRuN9aUYa3+tq9cja/HFW9OO01sfhOvVNwbv1jzrsG1FEflBtz2C3tdW
 jT2hDlqgPwPC8XN3+H4XvR5WV4p2lerU2pzydnMfs2Wv8hHOFTtxelVcUEO0hNmDR8yp
 KNaDyf8Fpy/y2KoVU1nnJrng5mOJQidxN9Lixi5LWeqc7BiObTF+onesxmkKJuG/TysX hA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3she768h4f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 17 Aug 2023 06:42:25 +0000
Received: from m0353723.ppops.net (m0353723.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 37H6bs4u024259;
        Thu, 17 Aug 2023 06:42:25 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3she768h3r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 17 Aug 2023 06:42:25 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 37H5LgPd007861;
        Thu, 17 Aug 2023 06:42:23 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
        by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3senwkkp6p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 17 Aug 2023 06:42:23 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
        by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 37H6gKRn34668958
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Aug 2023 06:42:20 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B3FAD2004E;
        Thu, 17 Aug 2023 06:42:20 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CD72320040;
        Thu, 17 Aug 2023 06:42:19 +0000 (GMT)
Received: from [9.171.82.18] (unknown [9.171.82.18])
        by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Thu, 17 Aug 2023 06:42:19 +0000 (GMT)
Message-ID: <af4eaa36-75ec-10f2-3a41-81895730f435@linux.ibm.com>
Date:   Thu, 17 Aug 2023 08:42:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH net-next 1/6] net/smc: support smc release version
 negotiation in clc handshake
To:     Guangguan Wang <guangguan.wang@linux.alibaba.com>,
        wenjia@linux.ibm.com, kgraul@linux.ibm.com,
        tonylu@linux.alibaba.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com
Cc:     horms@kernel.org, alibuda@linux.alibaba.com,
        guwen@linux.alibaba.com, linux-s390@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230816083328.95746-1-guangguan.wang@linux.alibaba.com>
 <20230816083328.95746-2-guangguan.wang@linux.alibaba.com>
 <36db51b2-ff88-0419-1e9b-cae2b111e570@linux.ibm.com>
 <2a494003-c41d-c8a6-6e3f-df6280494715@linux.alibaba.com>
From:   Jan Karcher <jaka@linux.ibm.com>
Organization: IBM - Network Linux on Z
In-Reply-To: <2a494003-c41d-c8a6-6e3f-df6280494715@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 3w63FAzMyfVwm9YVeh4hruLu7yaIUVq7
X-Proofpoint-ORIG-GUID: luPpyWbFVm5WDHBZZeLSjQ2Pm5C36YcO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-17_03,2023-08-15_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 adultscore=0 clxscore=1015 suspectscore=0 phishscore=0 bulkscore=0
 mlxlogscore=999 malwarescore=0 lowpriorityscore=0 spamscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308170057
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 17/08/2023 05:18, Guangguan Wang wrote:
> 
> 
> On 2023/8/16 22:14, Jan Karcher wrote:
>>
>>
>> On 16/08/2023 10:33, Guangguan Wang wrote:
>>> Support smc release version negotiation in clc handshake based on
>>> SMC v2, where no negotiation process for different releases, but
>>> for different versions. The latest smc release version was updated
>>> to v2.1. And currently there are two release versions of SMCv2, v2.0
>>> and v2.1. In the release version negotiation, client sends the preferred
>>> release version by CLC Proposal Message, server makes decision for which
>>> release version to use based on the client preferred release version and
>>> self-supported release version (here choose the minimum release version
>>> of the client preferred and server latest supported), then the decision
>>> returns to client by CLC Accept Message. Client confirms the decision by
>>> CLC Confirm Message.
>>>
>>> Client                                    Server
>>>         Proposal(preferred release version)
>>>        ------------------------------------>
>>>
>>>         Accept(accpeted release version)
>>>    min(client preferred, server latest supported)
>>>        <------------------------------------
>>>
>>>         Confirm(accpeted release version)
>>>        ------------------------------------>
>>>
>>> Signed-off-by: Guangguan Wang <guangguan.wang@linux.alibaba.com>
>>> Reviewed-by: Tony Lu <tonylu@linux.alibaba.com>
>>> ---
>>>    net/smc/af_smc.c   | 18 ++++++++++++++++--
>>>    net/smc/smc.h      |  5 ++++-
>>>    net/smc/smc_clc.c  | 14 +++++++-------
>>>    net/smc/smc_clc.h  | 23 ++++++++++++++++++++++-
>>>    net/smc/smc_core.h |  1 +
>>>    5 files changed, 50 insertions(+), 11 deletions(-)
>>>
>>> diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
>>> index a7f887d91d89..97265691bc95 100644
>>> --- a/net/smc/af_smc.c
>>> +++ b/net/smc/af_smc.c
>>> @@ -1187,6 +1187,9 @@ static int smc_connect_rdma_v2_prepare(struct smc_sock *smc,
>>>                return SMC_CLC_DECL_NOINDIRECT;
>>>            }
>>>        }
>>> +
>>> +    ini->release_nr = fce->release;
>>> +
>>
>> why would we do this and vvvvv
>>>        return 0;
>>>    }
>>>    @@ -1355,6 +1358,13 @@ static int smc_connect_ism(struct smc_sock *smc,
>>>            struct smc_clc_msg_accept_confirm_v2 *aclc_v2 =
>>>                (struct smc_clc_msg_accept_confirm_v2 *)aclc;
>>>    +        if (ini->first_contact_peer) {
>>> +            struct smc_clc_first_contact_ext *fce =
>>> +                smc_get_clc_first_contact_ext(aclc_v2, true);
>>> +
>>> +            ini->release_nr = fce->release;
>>> +        }
>>> +
>>
>> this two times?
>> Can't we put this together into __smc_connect where those functions get called (via smc_connect_rdma and smc_connect_ism)?
>>
>> Please provide reasoning, it might be that i oversaw the reasoning behind this duplication.
>>
> ini->release_nr is assigned only when doing first connect, thus this depends on the value test of
> ini->first_contact_peer. I have to follow the ini->first_contact_peer code logic, which may also
> make us wonder that why not put ini->first_contact_peer together into __smc_connect.
> 
> Indeed, both of ini->first_contact_peer and ini->release_nr can put together into __smc_connect.
> But I think it is better to start a new patch series to refactor those code, not in v2.1 features.

True. It would only be clean if move both. Works for me.

> 
> 
>> Also note: Even if there is a reason to set this information seperate for SMC-D and SMC-R think about using your very neat helper function (smc_get_clc_first_contact_ext) in smc_connect_rdma_v2_prepare as well.
>>
> 
> OK, I will replace the code to smc_get_clc_first_contact_ext.
> 
> Thanks,
> Guangguan Wang
> 

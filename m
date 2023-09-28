Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4E897B16DE
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 11:11:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231526AbjI1JLM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 05:11:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231475AbjI1JLK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 05:11:10 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF76FAC;
        Thu, 28 Sep 2023 02:11:07 -0700 (PDT)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38S8aXA7013982;
        Thu, 28 Sep 2023 09:10:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=kdgykgeTkMGRW1mCSejfdo9JY/L/mZUwVcRMWhuHjoA=;
 b=TOYvsmZgqChS2hTHE4jBfD6lG/suTxZv315KJcMisWqruU9p0tS32dZ9BXRk4MrQQX2U
 w/A+BMEjJi5ZhyEtJp4/95u8OfHPUOz+nLELhRbfGhC6YjwoSZldRShxkRcvQFL19jBX
 wqYbzRJp6M9xC7sSrylyyF0nopCUPIGnjZDxRKb+vuVcj0cbRvopq1Ajj4Y9Dx3ZAttQ
 tXTveDw5I4uzpNR8/b3ZoHO7BV5Cn0pz1Bu95bVSkVvgFLhqsX4NQDvPFqplJo6din7I
 Xt/C8LG1Y91nWk+c1PdMw0SNCLuuzjfoE9PG/zk2SkB82jl/EE4jHkFE1EXhFJnjVLQF 3g== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3td5kpsr2c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 28 Sep 2023 09:10:59 +0000
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 38S8aVUs013910;
        Thu, 28 Sep 2023 09:10:58 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3td5kpsr1p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 28 Sep 2023 09:10:58 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
        by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 38S8LqoG030454;
        Thu, 28 Sep 2023 09:10:57 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
        by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3tad222b04-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 28 Sep 2023 09:10:57 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
        by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 38S9AsP69634414
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 Sep 2023 09:10:54 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2819920088;
        Thu, 28 Sep 2023 09:10:54 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DFB522007B;
        Thu, 28 Sep 2023 09:10:53 +0000 (GMT)
Received: from [9.152.224.54] (unknown [9.152.224.54])
        by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Thu, 28 Sep 2023 09:10:53 +0000 (GMT)
Message-ID: <987f4ee8-57ab-71c2-597d-7835c3e1e202@linux.ibm.com>
Date:   Thu, 28 Sep 2023 11:10:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH net-next v4 05/18] net/smc: reserve CHID range for SMC-D
 virtual device
Content-Language: en-US
To:     Jan Karcher <jaka@linux.ibm.com>, Wen Gu <guwen@linux.alibaba.com>,
        kgraul@linux.ibm.com, wenjia@linux.ibm.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Cc:     schnelle@linux.ibm.com, gbayer@linux.ibm.com, pasic@linux.ibm.com,
        alibuda@linux.alibaba.com, tonylu@linux.alibaba.com,
        dust.li@linux.alibaba.com, linux-s390@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1695568613-125057-1-git-send-email-guwen@linux.alibaba.com>
 <1695568613-125057-6-git-send-email-guwen@linux.alibaba.com>
 <d5cf999b-ec76-844a-873b-e8767be9ffb5@linux.ibm.com>
From:   Alexandra Winter <wintera@linux.ibm.com>
In-Reply-To: <d5cf999b-ec76-844a-873b-e8767be9ffb5@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: ye_HTkBtzuqWs0y4Nby5n1tfWUV-9xEI
X-Proofpoint-GUID: l0MMxELJzpQSmFJj8cLoUEw5hSstQfpj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-28_06,2023-09-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxlogscore=994
 lowpriorityscore=0 mlxscore=0 adultscore=0 spamscore=0 malwarescore=0
 suspectscore=0 impostorscore=0 priorityscore=1501 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2309280077
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 28.09.23 05:08, Jan Karcher wrote:
> On 24/09/2023 17:16, Wen Gu wrote:
>> This patch reserve CHID range from 0xFF00 to 0xFFFF for SMC-D virtual
> 
> The current state is that 0xFF00 - 0xFFFF is the range of all virtual SMC-D devices. This range devides into:
> - 0xFF00 - 0xFFFE is for virto-ism
> - 0xFFFF is for loopback
> 
> 
>> device and introduces helpers to identify them.
>>
>> Signed-off-by: Wen Gu <guwen@linux.alibaba.com>
>> ---
>>   net/smc/smc_ism.h | 15 +++++++++++++++
>>   1 file changed, 15 insertions(+)
>>
>> diff --git a/net/smc/smc_ism.h b/net/smc/smc_ism.h
>> index 14d2e77..2ecc8de 100644
>> --- a/net/smc/smc_ism.h
>> +++ b/net/smc/smc_ism.h
>> @@ -15,6 +15,9 @@
>>     #include "smc.h"
>>   +#define SMC_VIRT_ISM_CHID_MAX        0xFFFF
> 
> SMC_VIRT_ISM_MAX is 0xFFFE. Or do you mean virtual devices as the whole group. If yes i think that this naming will be very confusing in a few months/years.
> Maybe something like SMC_VIRTUAL_DEV_CHID_{MIN|MAX}?


IMO names are important. They can make future lives easier or harder.

Your first group of patches aims at 'decouple ISM device hard code from SMC-D stack'
Maybe now would be a good point in time to decide what ISM should mean in net/smc.
a) the s390 ISM devices
b) SMC-D devices in general
I would vote for a). (today a) and b) can be found in the code, as well as the term smcd_dev)

Then like Jan wrote above:
"0xFF00 - 0xFFFF is the range of all virtual SMC-D devices" and it should NOT be called SMC_VIRT_ISM_CHID_MAX.


Then in many places in net/smc 'ism' should be replaces by 'smcd_dev' or something similar.
Wen Gu, is that something you would offer to do as part of the preparation work for this series?

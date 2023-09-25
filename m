Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60F057AD920
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 15:29:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229563AbjIYN32 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 09:29:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231278AbjIYN3Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 09:29:24 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BDB910E;
        Mon, 25 Sep 2023 06:29:17 -0700 (PDT)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38PDPV7d011432;
        Mon, 25 Sep 2023 13:29:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : from : to : cc : references : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=4PUFM8unlv/0l5zmXdSmUGzyRvP6q3M0XEjDrU3Eg64=;
 b=C0Uy61LFZ/q/AixUr3V5kXAfpOXaRmJENcrAIzvN+w5mYefMdjRxy8ufHyExUGsCTNmC
 A9i7woizOrgramTOo4NW+m5avQmppKjsmKw4SleNPQSBto9q8JlXdmHiTeq1c1BE38VO
 uQX7ryUtuP+R9viW2BWU2AdLv7WOQVidJkXLMmEW/bR92lhrPy57qLIb+aZgTOSn0L0O
 lWwSRepBt4J+/scUuECQ4LgnNP80Y67ilkiRcZUABjEKRtna0GoUZ6JInqlyytdwyaS3
 wN1BdiJ5lh1/NfSG59I/dQUiFq1Ecee4Z5h4LhZBcg5pwJd/ZCy0iiI0yo1X8NV+KL8d Vg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tb8vgm6h8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 25 Sep 2023 13:29:14 +0000
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 38PCc8bV032081;
        Mon, 25 Sep 2023 13:29:13 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tb8vgm6gt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 25 Sep 2023 13:29:13 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
        by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 38PCaRsu030719;
        Mon, 25 Sep 2023 13:29:12 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
        by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3tacjjhycq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 25 Sep 2023 13:29:12 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
        by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 38PDT9gx15401510
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 25 Sep 2023 13:29:09 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9F7A42004D;
        Mon, 25 Sep 2023 13:29:09 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3CEB520040;
        Mon, 25 Sep 2023 13:29:09 +0000 (GMT)
Received: from [9.152.224.54] (unknown [9.152.224.54])
        by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Mon, 25 Sep 2023 13:29:09 +0000 (GMT)
Message-ID: <c4ba2015-d951-451a-f96c-2946bfb9611c@linux.ibm.com>
Date:   Mon, 25 Sep 2023 15:29:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH net-next v4 09/18] net/smc: introduce SMC-D loopback
 device
Content-Language: en-US
From:   Alexandra Winter <wintera@linux.ibm.com>
To:     Wen Gu <guwen@linux.alibaba.com>, kgraul@linux.ibm.com,
        wenjia@linux.ibm.com, jaka@linux.ibm.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Cc:     schnelle@linux.ibm.com, gbayer@linux.ibm.com, pasic@linux.ibm.com,
        alibuda@linux.alibaba.com, tonylu@linux.alibaba.com,
        dust.li@linux.alibaba.com, linux-s390@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1695568613-125057-1-git-send-email-guwen@linux.alibaba.com>
 <1695568613-125057-10-git-send-email-guwen@linux.alibaba.com>
 <3febdf3e-e213-7acf-7dd4-75d177676c3e@linux.ibm.com>
In-Reply-To: <3febdf3e-e213-7acf-7dd4-75d177676c3e@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 4XwUEBuC4o2vJ19oSf6slw5IxQ8g9UdF
X-Proofpoint-ORIG-GUID: OLesoVtNi6RDrGd3HhQj4LKrRCnixe0E
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-25_10,2023-09-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 spamscore=0
 mlxlogscore=585 phishscore=0 clxscore=1015 mlxscore=0 suspectscore=0
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 impostorscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2309250098
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 25.09.23 13:50, Alexandra Winter wrote:
> 
> 
> On 24.09.23 17:16, Wen Gu wrote:
>> This patch introduces a kind of loopback device for SMC-D. The device
>> is created when SMC module is loaded and destroyed when the SMC module
>> is unloaded. The loopback device is a kernel device used only by the
>> SMC module and is not restricted by net namespace, so it can be used
>> for local inter-process or inter-container communication.
>>
>> Signed-off-by: Wen Gu <guwen@linux.alibaba.com>
>> ---
>>  net/smc/Kconfig        |  13 ++++
>>  net/smc/Makefile       |   2 +-
>>  net/smc/af_smc.c       |  12 +++-
>>  net/smc/smc_loopback.c | 165 +++++++++++++++++++++++++++++++++++++++++++++++++
>>  net/smc/smc_loopback.h |  33 ++++++++++
>>  5 files changed, 223 insertions(+), 2 deletions(-)
>>  create mode 100644 net/smc/smc_loopback.c
>>  create mode 100644 net/smc/smc_loopback.h
> 
> 
> Hello Wen Gu,
> 
> thank you for adding the Kconfig, so the distributions can decide when to offer this feature.
> 
> I propose you add some kind of runtime switch as well. Not every user who loads the SMC module
> may want to exploit smcd-loopback. Especially in native environements without containers.
> 
> If no RoCE interfaces or no ISM interfaces exist, the respective handling is skipped in SMC.
> If loopback is always created unconditionally, there is no way to opt-out.
> 

Another thing came to my mind:

When loopback is created and registered when the SMC module is loaded, it will implicitly always have highest priority, right?
That should be stated somewhere.
Also, if you create a runtime switch this will change, so then you need to decide about priority of loopback vs ISM device (and other future smcd-devices).

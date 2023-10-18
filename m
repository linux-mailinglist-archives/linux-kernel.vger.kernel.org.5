Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D64817CE7F7
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 21:43:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231459AbjJRTn5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 15:43:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231724AbjJRTny (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 15:43:54 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4593195;
        Wed, 18 Oct 2023 12:43:53 -0700 (PDT)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39IJc4lA013634;
        Wed, 18 Oct 2023 19:43:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=1wAlIzhdahUXrjREXhznI7ZxPs1/qwk6S/so0wB3ZWo=;
 b=L9nPzo7aA1BUPfrnm8MlBNhjDLlPZX0tcCaa+a25nWGWMCFbkPSaPBw/LhxHu5Uw+YGd
 b2PjVVuKhsVihnQwi9Zj9WSPOkeE3tJW1IUAm7P8nqgti4wfe9maUuKmPKOS4YwhGXZU
 zD7Vnk4jx6LgzmU7x3BConKXUeSm2cS0CzXdMCUBDAXqA0oRkdFOFvZJWljqaZhOJQT8
 WRB+fBkDNjEYuxMXDz92rgLxLKdzoPwUVIwLPZPcffuUdl3ev4WOveCS9sme1qWziEOn
 xnCPtRAIXj2ESPzpzkxLDgf36CPsayDlGgaBAbx26rGoVUfb6WQT3Zmxeit5SO/jlS4u 0g== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ttnpdr8rn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 18 Oct 2023 19:43:50 +0000
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 39IJcqwe015407;
        Wed, 18 Oct 2023 19:43:49 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ttnpdr8k4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 18 Oct 2023 19:43:49 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
        by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 39IHwwQw019881;
        Wed, 18 Oct 2023 19:43:46 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
        by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3tr811u047-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 18 Oct 2023 19:43:46 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
        by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 39IJhj7U21234416
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 Oct 2023 19:43:45 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3ABE458054;
        Wed, 18 Oct 2023 19:43:45 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1022C5804E;
        Wed, 18 Oct 2023 19:43:42 +0000 (GMT)
Received: from [9.171.53.134] (unknown [9.171.53.134])
        by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Wed, 18 Oct 2023 19:43:41 +0000 (GMT)
Message-ID: <68580479-c66e-41e3-b869-b9f98e348f01@linux.ibm.com>
Date:   Wed, 18 Oct 2023 21:43:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4 00/18] net/smc: implement virtual ISM
 extension and loopback-ism
Content-Language: en-GB
To:     Wen Gu <guwen@linux.alibaba.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>, kgraul@linux.ibm.com,
        jaka@linux.ibm.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com
Cc:     wintera@linux.ibm.com, gbayer@linux.ibm.com, pasic@linux.ibm.com,
        alibuda@linux.alibaba.com, tonylu@linux.alibaba.com,
        dust.li@linux.alibaba.com, linux-s390@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1695568613-125057-1-git-send-email-guwen@linux.alibaba.com>
 <dcc46fedda57e7e3ade14685ddb262309544ad7e.camel@linux.ibm.com>
 <d04f304b-fe41-09b5-b2a5-5ce0e8254e41@linux.alibaba.com>
 <49847786-9914-b615-56d6-f39fbc6e03c2@linux.alibaba.com>
From:   Wenjia Zhang <wenjia@linux.ibm.com>
In-Reply-To: <49847786-9914-b615-56d6-f39fbc6e03c2@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 5Z0z2u4sSi5qD8aSKeK2Fo8debmTPYqm
X-Proofpoint-GUID: V1DHv_58D7XxJyd7noitwiW0f3qWdE1o
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-18_18,2023-10-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 phishscore=0 mlxlogscore=999 mlxscore=0 bulkscore=0 clxscore=1015
 adultscore=0 priorityscore=1501 suspectscore=0 impostorscore=0
 malwarescore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310180162
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 17.10.23 05:49, Wen Gu wrote:
> 
> 
> On 2023/10/8 15:19, Wen Gu wrote:
>>
>>
>> On 2023/10/5 16:21, Niklas Schnelle wrote:
>>
>>>
>>> Hi Wen Gu,
>>>
>>> I've been trying out your series with iperf3, qperf, and uperf on
>>> s390x. I'm using network namespaces with a ConnectX VF from the same
>>> card in each namespace for the initial TCP/IP connection i.e. initially
>>> it goes out to a real NIC even if that can switch internally. All of
>>> these look great for streaming workloads both in terms of performance
>>> and stability. With a Connect-Request-Response workload and uperf
>>> however I've run into issues. The test configuration I use is as
>>> follows:
>>>
>>> Client Command:
>>>
>>> # host=$ip_server ip netns exec client smc_run uperf -m tcp_crr.xml
>>>
>>> Server Command:
>>>
>>> # ip netns exec server smc_run uperf -s &> /dev/null
>>>
>>> Uperf tcp_crr.xml:
>>>
>>> <?xml version="1.0"?>
>>> <profile name="TCP_CRR">
>>>          <group nthreads="12">
>>>                  <transaction duration="120">
>>>                          <flowop type="connect" 
>>> options="remotehost=$host protocol=tcp" />
>>>                          <flowop type="write" options="size=200"/>
>>>                          <flowop type="read" options="size=1000"/>
>>>                          <flowop type="disconnect" />
>>>                  </transaction>
>>>          </group>
>>> </profile>
>>>
>>> The workload first runs fine but then after about 4 GB of data
>>> transferred fails with "Connection refused" and "Connection reset by
>>> peer" errors. The failure is not permanent however and re-running
>>> the streaming workloads run fine again (with both uperf server and
>>> client restarted). So I suspect something gets stuck in either the
>>> client or server sockets. The same workload runs fine with TCP/IP of
>>> course.
>>>
>>> Thanks,
>>> Niklas
>>>
>>>
>>
>> Hi Niklas,
>>
>> Thank you very much for the test. With the test example you provided, 
>> I've
>> reproduced the issue in my VM. And moreover, sometimes the test complains
>> with 'Error saying goodbye with <ip>'
>>
>> I'll figure out what's going on here.
>>
>> Thanks!
>> Wen Gu
> 
> I think that there is a common issue for SMC-R and SMC-D. I also reproduce
> 'connection reset by peer' and 'Error saying goodbye with <ip>' when using
> SMC-R under the same test condition. They occur at the end of the test.
> 
> When the uperf test time ends, some signals are sent. At this point there
> are usually some SMC connections doing CLC handshake. I catch some 
> -EINTR(-4)
> in client and -ECONNRESET(-104) in server returned from smc_clc_wait_msg,
> (correspondingly handshake error counts also increase) and TCP RST packets
> sent to terminate the CLC TCP connection(clcsock).
> 
> I am not sure if this should be considered as a bydesign or a bug of SMC.
>  From an application perspective, the conn reset behavior only happens when
> using SMC.
> 
> @Wenjia, could you please take a look at this?
> 
> Thanks,
> Wen Gu

Hi Wen,

Do you mean the bug in smc_clc_wait_msg()?
If yes, I can not see any problem in the smc_clc_wait_msg(). From your 
description, it looks to me like the server should get the CLC_PROPOSAL 
message, but nothing in it while the client is waiting for the accept 
CLC_ACCEPT message from the server until the wait loops is broken out.

Thanks,
Wenjia

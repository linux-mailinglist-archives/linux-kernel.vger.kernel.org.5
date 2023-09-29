Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4969E7B3445
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 16:09:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233103AbjI2OJZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 10:09:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232630AbjI2OJX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 10:09:23 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BACA0DB;
        Fri, 29 Sep 2023 07:09:20 -0700 (PDT)
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38TE5JsB023179;
        Fri, 29 Sep 2023 14:09:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=6hpkonIYzlGTeNSZH3G+bqnCE7UFtjMK+yvrmruqcbM=;
 b=ObnGF4yHm68d7n+Z3qXsEWgfks48bpVBTfdsJal9I4J9PqtmwBgun7OQ3uaX4cDfWaVJ
 otDvA29TlXvINmmor5UnWOxjQokSZ/a0y0ezXwPCW/fgzSaNsX07TDmCMK4hxfVavula
 wuekDY7KV3hcAnmAl+R1tkPLXACXwUxuknc2R++d4M1OJU4N+4Fd02i2F8Kphbnb8nxl
 Hq1SI1d7le+6jdZPy5LInMuxYHGpkHRSBw4Xcgjhi6jNuZCZNB5g3ij/XSRSJztxtCR9
 7tDnjxnMJT9LeoKqfxQs3/1BuZLh1jX33UgCItUfOfQvqqDk6RxTkVGdy3GydE5LQnkN ag== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tdyuk8pa3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 29 Sep 2023 14:09:12 +0000
Received: from m0353724.ppops.net (m0353724.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 38TDqS89010147;
        Fri, 29 Sep 2023 14:08:56 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tdyuk8p0e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 29 Sep 2023 14:08:56 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 38TBpAJE008150;
        Fri, 29 Sep 2023 14:08:50 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
        by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3taar05b6p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 29 Sep 2023 14:08:50 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
        by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 38TE8lqG45351430
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 29 Sep 2023 14:08:47 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 89B4220040;
        Fri, 29 Sep 2023 14:08:47 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9AB052004B;
        Fri, 29 Sep 2023 14:08:46 +0000 (GMT)
Received: from [9.179.2.72] (unknown [9.179.2.72])
        by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Fri, 29 Sep 2023 14:08:46 +0000 (GMT)
Message-ID: <c2117ecb-466c-cc45-04c5-f12adedec217@linux.ibm.com>
Date:   Fri, 29 Sep 2023 16:08:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH net-next v4 09/18] net/smc: introduce SMC-D loopback
 device
Content-Language: en-US
To:     Wen Gu <guwen@linux.alibaba.com>, Jan Karcher <jaka@linux.ibm.com>,
        dust.li@linux.alibaba.com, kgraul@linux.ibm.com,
        wenjia@linux.ibm.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com
Cc:     schnelle@linux.ibm.com, gbayer@linux.ibm.com, pasic@linux.ibm.com,
        alibuda@linux.alibaba.com, tonylu@linux.alibaba.com,
        linux-s390@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1695568613-125057-1-git-send-email-guwen@linux.alibaba.com>
 <1695568613-125057-10-git-send-email-guwen@linux.alibaba.com>
 <3febdf3e-e213-7acf-7dd4-75d177676c3e@linux.ibm.com>
 <20230925151816.GC92403@linux.alibaba.com>
 <3f71928e-157a-748e-42ee-4de3c80ed109@linux.ibm.com>
 <e85fe903-a025-a693-906b-834ff2a2a812@linux.ibm.com>
 <22858b56-dee0-e65f-a698-b0f2090a872d@linux.alibaba.com>
From:   Alexandra Winter <wintera@linux.ibm.com>
In-Reply-To: <22858b56-dee0-e65f-a698-b0f2090a872d@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: d0wyDnEd3MkOnUnhHQZueMsaQuLIsWiv
X-Proofpoint-GUID: kzksUxrgw3u9VpXhQO98yQCRhj3cFm_1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-29_11,2023-09-28_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 suspectscore=0 phishscore=0 mlxlogscore=736 mlxscore=0 bulkscore=0
 malwarescore=0 spamscore=0 clxscore=1015 impostorscore=0 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2309290120
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 28.09.23 20:35, Wen Gu wrote:
> 
> 
> On 2023/9/28 11:16, Jan Karcher wrote:
>>
>>
>> On 26/09/2023 09:24, Alexandra Winter wrote:
>>>
>>>
>>> On 25.09.23 17:18, Dust Li wrote:
>>>>> Hello Wen Gu,
>>>>>
>>>>> thank you for adding the Kconfig, so the distributions can decide when to offer this feature.
>>>>>
>>>>> I propose you add some kind of runtime switch as well. Not every user who loads the SMC module
>>>>> may want to exploit smcd-loopback. Especially in native environements without containers.
>>>>>
>>>>> If no RoCE interfaces or no ISM interfaces exist, the respective handling is skipped in SMC.
>>>>> If loopback is always created unconditionally, there is no way to opt-out.
>>>> Hi Sandy,
>>>>
>>>> After talking to Wen Gu offline, I think the real issue here might be
>>>> we don't have an abstract layer in SMC, something like net/core/dev.c
>>>>
>>>> Without this, we cannot do:
>>>>
>>>> 1. Enable/disable those devices dynamically
>>>>     Currently, If we want to disable a SMC-R device to communicate with
>>>>     others, we need to refer to 'ip link set dev xxx down' to disable the
>>>>     netdevice, then Infiniband subsystem will notify SMC that the state of
>>>>     the IB device has changed. We cannot explicitly choose not to use some
>>>>     specific IB/RoCE devices without disable totally.
>>>>     If the loopback device need to support enable/disable itself, I
>>>>     think it might be better to enable this feature for all SMC devices.
>>>>
>>>> 2. Do statistics per device
>>>>     Now, we have to relay on IB/RoCE devices' hardware statistics to see
>>>>     how many packets/bytes we have sent through this device.
>>>>
>>>> Both the above issues get worse when the IB/RoCE device is shared by SMC
>>>> and userspace RDMA applications. If SMC-R and userspace RDMA applications
>>>> run at the same time, we can't enable the device to run userspace RDMA
>>>> applications while block it from running SMC. For statistics, we cannot
>>>> tell how many packets/bytes were sent by SMC and how many were sent by
>>>> userspace RDMA applications.
>>>>
>>>> So I think those are better to support in the SMC layer.
>>>>
>>>> Best regards!
>>>> Dust
>>>
>>> Thank you very much for your considerations. I also think a generic handling
>>> of these requirements in the smc layer would be best. Especially, if we want
>>> to add virtio-ism support soon. There we will face the same issues again.
>>> Let's hear what others think about this.
>>>
>>>
>>
>> Thanks you Sandy for bringing it up and Dust Li & Wen Gu for your thoughts.
>> I agree that such a runtime switch is needed and also that this generic handling would be good in the smc layer.
> 
> Right. runtime switch is necessary. I'm trying some ways to see which one is more suitable.
> 
> 
> As for implementing a abstract layer that capable of handling 1) enable/disable SMC usage of
> RDMA/ISM devices. 2) count packets/bytes of RDMA/ISM devices that generated/consumed by SMC,
> I believe it would be helpful, and IMHO its architecture may be:
> 
> ----------------------------------------------
>                   SMC protocol
>     (af_smc.c / smc_core.c / smc_clc.c ...)
> ----------------------------------------------
>           Abstract layer of SMC device
>       (define SMC device common operations)
> ----------------------------------------------
>   RDMA device |        (virt) ISM device
>   (smc_ib.c)  |   (smc_ism.c / smc_loopback.c)
> ----------------------------------------------
> 
> But I also believe this may require a lot of works and may be a long-term job.
> 

I like that concept a lot. If we can agree on a direction, we can define
meaningful pieces and approach it piece by piece.


> If only for the virtual ISM device, e.g.loopback-ism, I am considering adding it to the Linux
> device tree (/sys/devices/virtual/) to make it more 'device-like', and controlling its
> enable/disable and get the statistics through some files, such as
> echo 1 > /sys/devices/virtual/loopback-ism/alive
> or
> cat /sys/devices/virtual/loopback-ism/statistics/{rx|tx}_{bytes|packets}
> (similar to what tcp lo have in /sys/devices/virtual/net/lo)
> 
> What are your thoughts on it? Thanks.
> 

Makes sense to me, but I don't have too much experience in that area.
I have never seen an attribute called 'alive' before. 
I think attributes like 'power', 'enable' or 'online' are used for other device types.

> 
> -- 
> A little off-topic, it's currently China's National Day holiday, which lasts for about a week,
> so we are now on vacation. As a result, my responses might be a bit slower, but I will still
> make time to check/reply the mail and prepare for my new version. Thank you all very much!
> 
> Regards,
> Wen Gu

Next week is Germany's national holiday, so many of us are out as well.

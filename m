Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0CD67AE6B9
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 09:24:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232413AbjIZHYs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 03:24:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbjIZHYq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 03:24:46 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2403EB;
        Tue, 26 Sep 2023 00:24:39 -0700 (PDT)
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38Q5mEbg021881;
        Tue, 26 Sep 2023 07:24:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=8tY32ey+J+orStTGSZLCWD/fMv5X9gWzCYN4SQZOxSU=;
 b=QB2JtF8jkWVck1VfsUTMYPOMUsdBZj7lgcvcBnCLGHFjNjPD0VQrX3ijIMeviORT4uiz
 l+7lpqZtKXk3P7QgbNMVs1/QhpLrZFO8LP18zeBURvVfvGYb5ooIc4XiB0ggM/W7lO73
 UDBj3nFLrLepASzgJuxr3gY+MCxz3oMFUbprvBc844+o+mC5f29qb6RxqwbwOH9j9Erg
 FqoenYcuYcSw6IMJdt2jBfHa+QEyfF3aZQl+H9qWPQMagp9rGYz5sSvoBfIU6BUtC+UB
 u5UhnTAHigobZIIkm8fJy6+vqnMXZDf5sfeJZ3bc3Xb37TM4ciRCg+H3T17guCrcYRth vQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tbqbfckw1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 26 Sep 2023 07:24:34 +0000
Received: from m0353722.ppops.net (m0353722.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 38Q6toGq010309;
        Tue, 26 Sep 2023 07:24:33 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tbqbfckvb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 26 Sep 2023 07:24:33 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
        by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 38Q4qbnv008394;
        Tue, 26 Sep 2023 07:24:32 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
        by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3taabsj263-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 26 Sep 2023 07:24:32 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
        by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 38Q7OTpf20906746
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Sep 2023 07:24:29 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B439E2004B;
        Tue, 26 Sep 2023 07:24:29 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6D49320040;
        Tue, 26 Sep 2023 07:24:29 +0000 (GMT)
Received: from [9.152.224.54] (unknown [9.152.224.54])
        by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Tue, 26 Sep 2023 07:24:29 +0000 (GMT)
Message-ID: <3f71928e-157a-748e-42ee-4de3c80ed109@linux.ibm.com>
Date:   Tue, 26 Sep 2023 09:24:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH net-next v4 09/18] net/smc: introduce SMC-D loopback
 device
Content-Language: en-US
To:     dust.li@linux.alibaba.com, Wen Gu <guwen@linux.alibaba.com>,
        kgraul@linux.ibm.com, wenjia@linux.ibm.com, jaka@linux.ibm.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com
Cc:     schnelle@linux.ibm.com, gbayer@linux.ibm.com, pasic@linux.ibm.com,
        alibuda@linux.alibaba.com, tonylu@linux.alibaba.com,
        linux-s390@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1695568613-125057-1-git-send-email-guwen@linux.alibaba.com>
 <1695568613-125057-10-git-send-email-guwen@linux.alibaba.com>
 <3febdf3e-e213-7acf-7dd4-75d177676c3e@linux.ibm.com>
 <20230925151816.GC92403@linux.alibaba.com>
From:   Alexandra Winter <wintera@linux.ibm.com>
In-Reply-To: <20230925151816.GC92403@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 6ts8XhcPOgsswvvfsBOK9qhHd3J-Lbc_
X-Proofpoint-ORIG-GUID: 9_whUnQEoCXAoQyxNBqwVM-8LEICf3o-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-26_05,2023-09-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 clxscore=1015
 priorityscore=1501 malwarescore=0 mlxscore=0 adultscore=0 mlxlogscore=746
 lowpriorityscore=0 suspectscore=0 impostorscore=0 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2309260062
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 25.09.23 17:18, Dust Li wrote:
>> Hello Wen Gu,
>>
>> thank you for adding the Kconfig, so the distributions can decide when to offer this feature.
>>
>> I propose you add some kind of runtime switch as well. Not every user who loads the SMC module
>> may want to exploit smcd-loopback. Especially in native environements without containers.
>>
>> If no RoCE interfaces or no ISM interfaces exist, the respective handling is skipped in SMC.
>> If loopback is always created unconditionally, there is no way to opt-out.
> Hi Sandy,
> 
> After talking to Wen Gu offline, I think the real issue here might be
> we don't have an abstract layer in SMC, something like net/core/dev.c
> 
> Without this, we cannot do:
> 
> 1. Enable/disable those devices dynamically
>    Currently, If we want to disable a SMC-R device to communicate with
>    others, we need to refer to 'ip link set dev xxx down' to disable the
>    netdevice, then Infiniband subsystem will notify SMC that the state of
>    the IB device has changed. We cannot explicitly choose not to use some
>    specific IB/RoCE devices without disable totally.
>    If the loopback device need to support enable/disable itself, I
>    think it might be better to enable this feature for all SMC devices.
> 
> 2. Do statistics per device
>    Now, we have to relay on IB/RoCE devices' hardware statistics to see
>    how many packets/bytes we have sent through this device.
> 
> Both the above issues get worse when the IB/RoCE device is shared by SMC
> and userspace RDMA applications. If SMC-R and userspace RDMA applications
> run at the same time, we can't enable the device to run userspace RDMA
> applications while block it from running SMC. For statistics, we cannot
> tell how many packets/bytes were sent by SMC and how many were sent by
> userspace RDMA applications.
> 
> So I think those are better to support in the SMC layer.
> 
> Best regards!
> Dust

Thank you very much for your considerations. I also think a generic handling 
of these requirements in the smc layer would be best. Especially, if we want 
to add virtio-ism support soon. There we will face the same issues again.
Let's hear what others think about this.


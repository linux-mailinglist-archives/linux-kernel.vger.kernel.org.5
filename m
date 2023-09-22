Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 267A27AB9E7
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 21:15:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233509AbjIVTQD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 15:16:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231226AbjIVTQB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 15:16:01 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 356AAAF;
        Fri, 22 Sep 2023 12:15:55 -0700 (PDT)
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38MJEKcZ021852;
        Fri, 22 Sep 2023 19:15:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=HVfyxw/Kl8/+TQQ2WdC9XhJKmxyl8eQRXxHJLzVysuU=;
 b=c0RLGFRnxuoHtZEx9SRZj41qa6wGhBFHyPBp2xi8NahLKm60TYAl+DsraQioXS5TLFIw
 cZgldxh7aUN4/MDIbGO8pS/i4gzFEMtfo4Q6u1QAiUgDJW+DDN0h/HCPqGm1q5y0456Y
 tPpaoq8FdshCojJotVy9jzZU9QwhlaIoY8KUvmEgSmItMnQj597OKFjCJAsUMvSwhqo7
 r18+Q7ahfeU9Eolbp6cVgWgKKEIB/cUg+iAisiTeHu8w6hoSRkHOg9g7qALEBVEtTF1J
 cBKDEmnA0kChtZcN4jiCIrvRolhT+bYNM3Eto0ttlh9k8oLS3rZJ1aoju69GLTN16vv7 eA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3t9gwdr110-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 22 Sep 2023 19:15:54 +0000
Received: from m0353723.ppops.net (m0353723.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 38MJEMCN021963;
        Fri, 22 Sep 2023 19:15:53 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3t9gwdr10n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 22 Sep 2023 19:15:53 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 38MIb30H029794;
        Fri, 22 Sep 2023 19:15:53 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
        by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3t8tsp764k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 22 Sep 2023 19:15:52 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
        by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 38MJFnLj27198148
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 22 Sep 2023 19:15:49 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D047420043;
        Fri, 22 Sep 2023 19:15:49 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2F82A20040;
        Fri, 22 Sep 2023 19:15:49 +0000 (GMT)
Received: from [9.171.40.202] (unknown [9.171.40.202])
        by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Fri, 22 Sep 2023 19:15:49 +0000 (GMT)
Message-ID: <b9e9eca9-413c-0301-3839-bb7534ac76d2@linux.ibm.com>
Date:   Fri, 22 Sep 2023 21:15:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH] s390/cio: Fix a memleak in css_alloc_subchannel
Content-Language: en-US
To:     Halil Pasic <pasic@linux.ibm.com>,
        Cornelia Huck <cohuck@redhat.com>
Cc:     Dinghao Liu <dinghao.liu@zju.edu.cn>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Julian Wiedmann <jwi@linux.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230921071412.13806-1-dinghao.liu@zju.edu.cn>
 <20230922141700.10895474.pasic@linux.ibm.com> <87sf76z961.fsf@redhat.com>
 <20230922152035.3ef1cb7e.pasic@linux.ibm.com>
From:   Vineeth Vijayan <vneethv@linux.ibm.com>
In-Reply-To: <20230922152035.3ef1cb7e.pasic@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: xDptwDPUkk6uTTiLnmC_34Hzon01rhdX
X-Proofpoint-ORIG-GUID: PiT7fz-S8xg7tnqFFWmCzPbK8SBCe1xC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-22_17,2023-09-21_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 adultscore=0 bulkscore=0 mlxlogscore=725 malwarescore=0
 mlxscore=0 lowpriorityscore=0 suspectscore=0 clxscore=1011 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2309220164
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/22/23 15:20, Halil Pasic wrote:
>> Author of 2ec2298412e1 here. If I don't completely misremember things,
>> this was for the orphanage stuff (i.e. ccw devices that were still kept
>> as disconnected, like dasd still in use, that had to be moved from their
>> old subchannel object because a different device appeared on that
>> subchannel.) That orphanage used a single dummy subchannel for all ccw
>> devices moved there.
>>
>> I have no idea how the current common I/O layer works, but that might
>> give you a hint about what to look for 😄
> Yes, that is what the commit states and what the series is about. I hope
> Vineeth can give us some answers 😄 maybe even out of the top of his
> head... If not, I would trust his judgment on whether figuring things
> out is worthwhile or not.
> 
As Corny mentioned, orphanage is the only case i remember where
this scenario of dynamically allocated sch->lock  being used. I hope
you remember the cdev->ccwlock, which is nothing but the copy of
sch->lock pointer. This is rather a tricky design, where we are using 
the sch->lock and cdev->ccwlock, which are same pointers.
Because this sch is exclusively for the cdev ops. But at the same time,
a CC3 code in the stsch can make the attached device an orphanage and
remove the sch.

We have already seen an issue with this approach and had couple of
discussions about avoiding this pointer usage without using an extra
lock but do not have a right solution for this now.

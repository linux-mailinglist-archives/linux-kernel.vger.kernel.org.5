Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44D0877889D
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 09:53:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234300AbjHKHxg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 03:53:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229642AbjHKHxf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 03:53:35 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B799A12D;
        Fri, 11 Aug 2023 00:53:34 -0700 (PDT)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37B7gSdP003926;
        Fri, 11 Aug 2023 07:53:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=fsxSThKavB4Wa/c1slzKbPIW5l6Yh6RXKmr7qs6SFSo=;
 b=JGPM0ylHnbvmOTDiFgoOo/EMXDwuIqbqPDsZd1gFQ3sSSE0Bzqq8ifiLWmsDqfY/4mQc
 3ln3tLlol5hot0/q8aNQ87BpTl/hJ3+sk/634IbptVQNfkdlBgECVulA823V/6H6etew
 7ITA9Mkrvusa5ioRBTZmB7MCpKzeZC2eAV7Dh50r6oCicfL0X9wtMT1S58prdIyZ0r5M
 zgU79h62Uj9vm6pJRd3UiDNnaDIK7pmIgf5bllZZYMHKcryoDj+AX2PhuvWPW7NJ37f+
 G3nWTvSULjjZeYXJiUjOEXu4kGn1Dn2z/3EIWx17nYt5DUGPYwq2KGqzH0QsDAznAXLU 2Q== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sdgtwg7xn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 11 Aug 2023 07:53:15 +0000
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 37B7hdWN007933;
        Fri, 11 Aug 2023 07:53:14 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sdgtwg7xd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 11 Aug 2023 07:53:14 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
        by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 37B76qu4015354;
        Fri, 11 Aug 2023 07:53:13 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
        by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3sb3f3jj4q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 11 Aug 2023 07:53:13 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
        by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 37B7rAsw57934296
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 11 Aug 2023 07:53:10 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9542E20040;
        Fri, 11 Aug 2023 07:53:10 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C5EAC2004B;
        Fri, 11 Aug 2023 07:53:06 +0000 (GMT)
Received: from [9.43.111.169] (unknown [9.43.111.169])
        by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Fri, 11 Aug 2023 07:53:06 +0000 (GMT)
Message-ID: <772c4140-3035-16d8-0253-f5893c3698e2@linux.ibm.com>
Date:   Fri, 11 Aug 2023 13:23:05 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH V3 01/14] blk-mq: add blk_mq_max_nr_hw_queues()
To:     Baoquan He <bhe@redhat.com>, Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Pingfan Liu <piliu@redhat.com>, Dave Young <dyoung@redhat.com>,
        npiggin@gmail.com, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        Wen Xiong <wenxiong@linux.ibm.com>, kexec@lists.infradead.org,
        Keith Busch <kbusch@kernel.org>, linuxppc-dev@lists.ozlabs.org,
        Christoph Hellwig <hch@lst.de>,
        Mahesh J Salgaonkar <mahesh@linux.ibm.com>
References: <20230808104239.146085-1-ming.lei@redhat.com>
 <20230808104239.146085-2-ming.lei@redhat.com> <20230809134401.GA31852@lst.de>
 <ZNQqt1C0pXspGl3d@fedora> <ZNQ64xhCIBU6XM/5@MiWiFi-R3L-srv>
 <ZNRGNsRzEJfzUEzH@fedora> <ZNRTGrRuwf69EgnE@MiWiFi-R3L-srv>
Content-Language: en-US
From:   Hari Bathini <hbathini@linux.ibm.com>
In-Reply-To: <ZNRTGrRuwf69EgnE@MiWiFi-R3L-srv>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: gWFn9VUrffjAE3WNuOELsGUhX27lTrVe
X-Proofpoint-ORIG-GUID: oPPSb3RsDgqGSQYgmI0ooyVmbtyN59DI
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-10_20,2023-08-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 phishscore=0
 impostorscore=0 clxscore=1011 mlxscore=0 priorityscore=1501 spamscore=0
 mlxlogscore=999 adultscore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308110068
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/08/23 8:31 am, Baoquan He wrote:
> On 08/10/23 at 10:06am, Ming Lei wrote:
>> On Thu, Aug 10, 2023 at 09:18:27AM +0800, Baoquan He wrote:
>>> On 08/10/23 at 08:09am, Ming Lei wrote:
>>>> On Wed, Aug 09, 2023 at 03:44:01PM +0200, Christoph Hellwig wrote:
>>>>> I'm starting to sound like a broken record, but we can't just do random
>>>>> is_kdump checks, and it's not going to get better by resending it again and
>>>>> again.  If kdump kernels limit the number of possible CPUs, it needs to
>>>>> reflected in cpu_possible_map and we need to use that information.
>>>>>
>>>>
>>>> Can you look at previous kdump/arch guys' comment about kdump usage &
>>>> num_possible_cpus?
>>>>
>>>>      https://lore.kernel.org/linux-block/CAF+s44RuqswbosY9kMDx35crviQnxOeuvgNsuE75Bb0Y2Jg2uw@mail.gmail.com/
>>>>      https://lore.kernel.org/linux-block/ZKz912KyFQ7q9qwL@MiWiFi-R3L-srv/
>>>>
>>>> The point is that kdump kernels does not limit the number of possible CPUs.
>>>>
>>>> 1) some archs support 'nr_cpus=1' for kdump kernel, which is fine, since
>>>> num_possible_cpus becomes 1.
>>>
>>> Yes, "nr_cpus=" is strongly suggested in kdump kernel because "nr_cpus="
>>> limits the possible cpu numbers, while "maxcpuss=" only limits the cpu
>>> number which can be brought up during bootup. We noticed this diference
>>> because a large number of possible cpus will cost more memory in kdump
>>> kernel. e.g percpu initialization, even though kdump kernel have set
>>> "maxcpus=1".
>>>
>>> Currently x86 and arm64 all support "nr_cpus=". Pingfan ever spent much
>>> effort to make patches to add "nr_cpus=" support to ppc64, seems ppc64
>>> dev and maintainers do not care about it. Finally the patches are not
>>> accepted, and the work is not continued.
>>>
>>> Now, I am wondering what is the barrier to add "nr_cpus=" to power ach.
>>> Can we reconsider adding 'nr_cpus=' to power arch since real issue
>>> occurred in kdump kernel?
>>
>> If 'nr_cpus=' can be supported on ppc64, this patchset isn't needed.
>>
>>>
>>> As for this patchset, it can be accpeted so that no failure in kdump
>>> kernel is seen on ARCHes w/o "nr_cpus=" support? My personal opinion.
>>
>> IMO 'nr_cpus=' support should be preferred, given it is annoying to
>> maintain two kinds of implementation for kdump kernel from driver
>> viewpoint. I guess kdump things can be simplified too with supporting
>> 'nr_cpus=' only.
> 
> Yes, 'nr_cpus=' is ideal. Not sure if there's some underlying concerns so
> that power people decided to not support it.

Though "nr_cpus=1" is an ideal solution, maintainer was not happy with
the patch as the code changes have impact for regular boot path and
it is likely to cause breakages. So, even if "nr_cpus=1" support for
ppc64 is revived, the change is going to take time to be accepted
upstream.

Also, I see is_kdump_kernel() being used irrespective of "nr_cpus=1"
support for other optimizations in the driver for the special dump
capture environment kdump is.

If there is no other downside for driver code, to use is_kdump_kernel(),
other than the maintainability aspect, I think the above changes are
worth considering.

Thanks
Hari

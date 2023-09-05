Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EF9C792ED6
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 21:26:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233374AbjIET0y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 15:26:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243044AbjIET0v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 15:26:51 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6029B9C
        for <linux-kernel@vger.kernel.org>; Tue,  5 Sep 2023 12:26:30 -0700 (PDT)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 385JFfjt003469;
        Tue, 5 Sep 2023 19:26:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=7ULapfELbIAWVvGJokYwrzD3uX2qjQSeL5o58+0Keaw=;
 b=fhJW5nouIxtm32yjzNxic3wQ5MRYHMEoapL2O0Ls0hAh79JTkE21xIBZ4NtGxzFWPqe1
 vbQ7IZ4mP6KQjCPPUWzvhoCmM/uGd8BKsGlNBfbaDs25BYy09aC7TdHhxDCTya5fLjj5
 Wc/ef0UIyD+rRXo7ZHjw9rLbPCs+TpuOjrZVaHh/dXNzRAZzIjoW/4FxbWwzsBSBYTA+
 DjgSyvF/S3XSHPPYvRoceR8bUQesPDdk5Bj1IABGLqfMxkEhcz7RHvifuD4+/136mCNz
 EwIhJ4XK0O1MvvBQU+3M9HT22giJecy75a9NfLlmbeUzQ8Hl9ExvOxlDjYflzlPCtp0g eQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sxaay0kbg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 05 Sep 2023 19:26:01 +0000
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 385JFvEb004836;
        Tue, 5 Sep 2023 19:26:00 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sxaay0kay-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 05 Sep 2023 19:26:00 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
        by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 385HudYB011121;
        Tue, 5 Sep 2023 19:26:00 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
        by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3svj31mrha-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 05 Sep 2023 19:26:00 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
        by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 385JPvQF45417100
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 5 Sep 2023 19:25:57 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 37BC420040;
        Tue,  5 Sep 2023 19:25:57 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AB93420043;
        Tue,  5 Sep 2023 19:25:55 +0000 (GMT)
Received: from [9.43.114.159] (unknown [9.43.114.159])
        by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Tue,  5 Sep 2023 19:25:55 +0000 (GMT)
Message-ID: <7ae76fa1-6d6e-2aff-a71d-4db76e63857a@linux.ibm.com>
Date:   Wed, 6 Sep 2023 00:55:54 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 1/2] vmcore: allow alternate dump capturing methods to
 export vmcore without is_kdump_kernel()
Content-Language: en-US
To:     Baoquan He <bhe@redhat.com>
Cc:     linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Kexec-ml <kexec@lists.infradead.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Sourabh Jain <sourabhjain@linux.ibm.com>,
        Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
        Dave Young <dyoung@redhat.com>
References: <20230901190438.375678-1-hbathini@linux.ibm.com>
 <ZPP/UeP1zUbGPzrt@MiWiFi-R3L-srv>
 <8fcd7ba7-0f27-7bbc-676f-7e13c8bf00d7@linux.ibm.com>
 <ZPaSyMuPa466sEPz@MiWiFi-R3L-srv>
From:   Hari Bathini <hbathini@linux.ibm.com>
In-Reply-To: <ZPaSyMuPa466sEPz@MiWiFi-R3L-srv>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: aEHGwkuBtXUEo2dCd_xfSKUN6LXkp4yf
X-Proofpoint-GUID: qQMHCb5SNcsQKhOcYNs-Yo4cP2UbEtyt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-05_12,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 phishscore=0 adultscore=0 bulkscore=0 suspectscore=0
 mlxscore=0 impostorscore=0 malwarescore=0 mlxlogscore=487 clxscore=1015
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309050166
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 05/09/23 8:00 am, Baoquan He wrote:
> On 09/04/23 at 08:04pm, Hari Bathini wrote:
>> Hi Baoquan,
>>
>> Thanks for the review...
>>
>> On 03/09/23 9:06 am, Baoquan He wrote:
>>> Hi Hari,
>>>
>>> On 09/02/23 at 12:34am, Hari Bathini wrote:
>>>> Currently, is_kdump_kernel() returns true when elfcorehdr_addr is set.
>>>> While elfcorehdr_addr is set for kexec based kernel dump mechanism,
>>>> alternate dump capturing methods like fadump [1] also set it to export
>>>> the vmcore. is_kdump_kernel() is used to restrict resources in crash
>>>> dump capture kernel but such restrictions may not be desirable for
>>>> fadump. Allow is_kdump_kernel() to be defined differently for such
>>>> scenarios. With this, is_kdump_kernel() could be false while vmcore
>>>> is usable. So, introduce is_crashdump_kernel() to return true when
>>>> elfcorehdr_addr is set and use it for vmcore related checks.
>>>
>>> I got what is done in these two patches, but didn't get why they need be
>>> done. vmcore_unusable()/is_vmcore_usable() are only unitilized in ia64.
>>> Why do you care if it's is_crashdump_kernel() or is_kdump_kernel()?
>>> If you want to override the generic is_kdump_kernel() with powerpc's own
>>> is_kdump_kernel(), your below change is enough to allow you to do that.
>>> I can't see why is_crashdump_kernel() is needed. Could you explain that
>>> specifically?
>>
>> You mean to just remove is_kdump_kernel() check in is_vmcore_usable() &
>> vmcore_unusable() functions? Replaced generic is_crashdump_kernel()
>> function instead, that returns true for any dump capturing method,
>> irrespective of whether is_kdump_kernel() returns true or false.
>> For fadump case, is_kdump_kernel() will return false after patch 2/2.
> 
> OK, I could understand what you want to achieve. You want to make
> is_kdump_kernel() only return true for kdump, while is_vmcore_usable()
> returns true for both kdump and fadump.
> 
> IIUC, can we change as below? It could make code clearer and more
> straightforward. I don't think adding another is_crashdump_kernel()
> is a good idea, that would be a torture for non-powerpc people reading
> code when they need differentiate between kdump and crashdump.
> 

Sure, Baoquan.
Posted v2 based on your suggestion.

Thanks
Hari

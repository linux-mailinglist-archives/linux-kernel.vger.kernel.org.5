Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99CAC7DE0B0
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 13:21:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235067AbjKAMQc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 08:16:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235094AbjKAMQa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 08:16:30 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F23411A
        for <linux-kernel@vger.kernel.org>; Wed,  1 Nov 2023 05:16:27 -0700 (PDT)
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A1BjarR022421;
        Wed, 1 Nov 2023 12:16:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=Ph84lQXU68EoTTG4StNcbimDFbn5BZ4vfRL1oCqzeqI=;
 b=ep1ZxeiKis2Dv1L6UlIjub745hHGjVsOZiilIC0EQ57BmP9ZmIv7nCL2mCnlkXr/SKkc
 iirkb8Lh/hhuQJBTBKopvBTdacSI8/OcDuAbjE+yU/7n0R0KDbJtk2lksFdbPIZ0F2OS
 BO/zmeOX1HCMh9ieblT5z0MNInp+VHxd7vYFL3QgTE7kX+9biVDz/Uh9ktW6EAY0EOk0
 g+03BX8ubYHvTqeEObU4lasykdwtNl8CaEZj+RL2QlYPkGeMjmOIoaxZlKMN2AnnDDHK
 llhToMUgtKheVkwlIfkot04Q4EGeFk+bkzWan0C803vdT6cl9zr+RkipROYeCY9owHqf Rg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3u3p30gtj0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 01 Nov 2023 12:16:17 +0000
Received: from m0353723.ppops.net (m0353723.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3A1BqD3H012250;
        Wed, 1 Nov 2023 12:16:16 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3u3p30gteb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 01 Nov 2023 12:16:16 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3A19ebjW007674;
        Wed, 1 Nov 2023 12:11:14 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
        by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3u1dmnqfk1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 01 Nov 2023 12:11:14 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
        by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3A1CBDq849676976
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 1 Nov 2023 12:11:13 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A2E3B58056;
        Wed,  1 Nov 2023 12:11:13 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F08D158052;
        Wed,  1 Nov 2023 12:11:12 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
        by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTPS;
        Wed,  1 Nov 2023 12:11:12 +0000 (GMT)
Message-ID: <e30c9f81-959f-418d-a4b1-d34d47391e09@linux.ibm.com>
Date:   Wed, 1 Nov 2023 08:11:12 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] rootfs: Use tmpfs for rootfs even if root= is given
Content-Language: en-US
To:     Rob Landley <rob@landley.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        "Milton D. Miller II" <mdmii@outlook.com>,
        Jeff Layton <jlayton@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Jim Cromie <jim.cromie@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "H. Peter Anvin" <hpa@zytor.com>, Mimi Zohar <zohar@linux.ibm.com>
References: <20231031154417.621742-1-stefanb@linux.ibm.com>
 <2023103159-punctuate-amount-f09d@gregkh>
 <6dae6aa6-e6c6-89d6-f9d7-7563708f7662@landley.net>
From:   Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <6dae6aa6-e6c6-89d6-f9d7-7563708f7662@landley.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: W4xH87J47g3l8VWxYxLrA62KSxyD1zVA
X-Proofpoint-GUID: -V1DmN1nO23wntWKNf14ljD_pFTk67-6
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-01_09,2023-11-01_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxlogscore=854
 lowpriorityscore=0 mlxscore=0 spamscore=0 impostorscore=0 clxscore=1015
 adultscore=0 phishscore=0 malwarescore=0 priorityscore=1501 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2310240000
 definitions=main-2311010102
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/1/23 07:35, Rob Landley wrote:
> On 10/31/23 11:56, Greg Kroah-Hartman wrote:
>> On Tue, Oct 31, 2023 at 11:44:17AM -0400, Stefan Berger wrote:
>>> rootfs currently does not use tmpfs if the root= boot option is passed
>>> even though the documentation about rootfs (added in 6e19eded3684) in
>>> Documentation/filesystems/ramfs-rootfs-initramfs.rst states:
>>>
>>>    If CONFIG_TMPFS is enabled, rootfs will use tmpfs instead of ramfs by
>>>    default.  To force ramfs, add "rootfstype=ramfs" to the kernel command
>>>    line.
>>
>> At this point in time, is there even any difference between ramfs and
>> tmpfs anymore?  Why would you want to choose one over the other here?
> 
> I submitted a patch to fix this to the list multiple times, which got ignored as
> always. Most recently here:
> 
> https://lore.kernel.org/lkml/8244c75f-445e-b15b-9dbf-266e7ca666e2@landley.net/

I just tried it with your patch and the machine I am using this with 
(OpenBMC) uses the boot command line 'console=ttyS4,115200n8 
root=/dev/ram rw'. When I append rootfstype=tmpfs to this boot command 
line then it starts actually using tmpfs. So I think this would work for me.
I can add my Tested-by tag to the patch if this helps to get it merged. 
Ideally it would also propagate back with a Fixes tag...

    Stefan

> 
> Rob

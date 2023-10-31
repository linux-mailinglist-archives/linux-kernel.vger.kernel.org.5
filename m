Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF8697DD770
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 22:03:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232064AbjJaVDL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 17:03:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231287AbjJaVDJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 17:03:09 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF9F1F3
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 14:03:06 -0700 (PDT)
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39VL0enn028967;
        Tue, 31 Oct 2023 21:03:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=8wdSHrI9y8FcJDLER0LIrEGaNVtngqDK7qsD5hk7h9Y=;
 b=Ejm5cY0sa+O/p86tsWO+DlzX30tZULrP3MaHbbADld+9EzvTDQgrncTpO1YG/bPNFfLa
 mDhCPDxi+gSSPipNpRlIgSjiPExNr8U/ixH+T9HSzrJT1GcUL/gydO8xAPdMHEarNTR3
 n0ErGWbaPEd1tgMa2ODE8u9oWIFGg5K8nfxD1hH1TbW/GkgsXZElO8JJpFgGZrekagvI
 3WmSgEki8PYPYdCcLVtIgUYhThlmzvYUqm+hCJJrZhplqwPAtOjH4bWgDiPWHcuo4zVI
 OWLONrdXlFsWIku+07QQWISn2ryXDSNvAUrhnbTMOtObbr9cZKdNrBOGRJClCC1OEqXg gQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3u3948g2fx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 31 Oct 2023 21:02:59 +0000
Received: from m0353724.ppops.net (m0353724.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 39VL0uNe029562;
        Tue, 31 Oct 2023 21:02:59 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3u3948g2fc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 31 Oct 2023 21:02:59 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
        by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 39VJcpPl000725;
        Tue, 31 Oct 2023 21:02:58 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
        by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3u1cmt3pp3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 31 Oct 2023 21:02:58 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
        by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 39VL2vEO45875470
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 31 Oct 2023 21:02:57 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 642FF58051;
        Tue, 31 Oct 2023 21:02:57 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A94835805A;
        Tue, 31 Oct 2023 21:02:56 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
        by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTPS;
        Tue, 31 Oct 2023 21:02:56 +0000 (GMT)
Message-ID: <b3b62f3f-7af4-4af4-8ec3-d4f63698b103@linux.ibm.com>
Date:   Tue, 31 Oct 2023 17:02:56 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] rootfs: Use tmpfs for rootfs even if root= is given
Content-Language: en-US
To:     "H. Peter Anvin" <hpa@zytor.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        "Milton D. Miller II" <mdmii@outlook.com>,
        Rob Landley <rob@landley.net>,
        Jeff Layton <jlayton@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Jim Cromie <jim.cromie@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Mimi Zohar <zohar@linux.ibm.com>
References: <20231031154417.621742-1-stefanb@linux.ibm.com>
 <2023103159-punctuate-amount-f09d@gregkh>
 <b035a00f-865a-453c-bb27-0916aada0594@linux.ibm.com>
 <3FBB731F-2A45-4EC6-AF8C-76C21B8607BC@zytor.com>
From:   Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <3FBB731F-2A45-4EC6-AF8C-76C21B8607BC@zytor.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: rkiowVA8tR9LoUY05AOku358bZK8SbY7
X-Proofpoint-ORIG-GUID: cxE22DGeHXLZGgc9FC3H2uP8QK-UAM5B
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-31_07,2023-10-31_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=623
 malwarescore=0 suspectscore=0 impostorscore=0 adultscore=0
 priorityscore=1501 mlxscore=0 lowpriorityscore=0 spamscore=0 clxscore=1015
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310240000 definitions=main-2310310172
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/31/23 16:33, H. Peter Anvin wrote:
> On October 31, 2023 10:11:01 AM PDT, Stefan Berger <stefanb@linux.ibm.com> wrote:
>>
>> On 10/31/23 12:56, Greg Kroah-Hartman wrote:
>>> On Tue, Oct 31, 2023 at 11:44:17AM -0400, Stefan Berger wrote:
>>>> rootfs currently does not use tmpfs if the root= boot option is passed
>>>> even though the documentation about rootfs (added in 6e19eded3684) in
>>>> Documentation/filesystems/ramfs-rootfs-initramfs.rst states:
>>>>
>>>>     If CONFIG_TMPFS is enabled, rootfs will use tmpfs instead of ramfs by
>>>>     default.  To force ramfs, add "rootfstype=ramfs" to the kernel command
>>>>     line.
>>> At this point in time, is there even any difference between ramfs and
>>> tmpfs anymore?  Why would you want to choose one over the other here?
>>
>> CONFIG_TPMFS_XATTRS allows us to set xattrs, such as security.ima.
>>
>>     Stefan
>>
>>>
>>> thanks,
>>>
>>> greg k-h
> Why do we even keep ramfs as a standalone file system? To guarantee it cannot be swapped out? Does anyone actually use it?

Probably all machines that have root= on the boot command line use it...

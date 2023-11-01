Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31ECC7DE364
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 16:36:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344247AbjKAORL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 10:17:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232094AbjKAORJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 10:17:09 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B067DDC
        for <linux-kernel@vger.kernel.org>; Wed,  1 Nov 2023 07:17:03 -0700 (PDT)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A1DogJC017255;
        Wed, 1 Nov 2023 14:16:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=ZyizBjyFMUtcrQ74hLgTVrIM1r22WuWkds2VME0f4N0=;
 b=Hjb6bA+wY12WJkd6GlQ3M+XU7PvegPWrHedjMzldzep6MrOerKfnoaFKIfknN7q1jH6o
 0oWKmrh0NVHTjZaTVNOLNGc+LyzZC7CnlxJD/fIYQFuPchxt4BjMXZgA0760pSiLIlyc
 IuVg40k5S7+JQcl+2lqm/owbfrkA3QUYrIAaJNq3zc3Qa8tLyLh6U/phTds7/TzSOBaT
 gYeuvW/JCUuKCYa0yo8ASMNgBxPyJWU2FQJ+DfN5WSKUwI+h8siNiDw/7nHPimTQ3ul3
 lFMH5/b+qAq0kBr/39lNeEoqbwcbkrSNdXYZyIhoAgVhVx8UuikMuXzQzJ2MDZHR7nxV yQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3u3qwq8snq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 01 Nov 2023 14:16:42 +0000
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3A1EGfxK021145;
        Wed, 1 Nov 2023 14:16:41 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3u3qwq8snd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 01 Nov 2023 14:16:41 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
        by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3A1C36H3031499;
        Wed, 1 Nov 2023 14:16:40 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
        by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3u1fb27hek-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 01 Nov 2023 14:16:40 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
        by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3A1EGdwv49873196
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 1 Nov 2023 14:16:40 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DA48558053;
        Wed,  1 Nov 2023 14:16:39 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D0E3458059;
        Wed,  1 Nov 2023 14:16:38 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
        by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTPS;
        Wed,  1 Nov 2023 14:16:38 +0000 (GMT)
Message-ID: <a8693232-431e-4840-a020-cd83c162446e@linux.ibm.com>
Date:   Wed, 1 Nov 2023 10:16:37 -0400
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
X-Proofpoint-ORIG-GUID: A301PZar53WvtTcvB4WkdgaSDqnXQB_f
X-Proofpoint-GUID: W4Mf0NfUK1vWzLWTZ5Ii_49ShGxglLYx
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-01_12,2023-11-01_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=727 spamscore=0
 malwarescore=0 clxscore=1015 mlxscore=0 suspectscore=0 adultscore=0
 impostorscore=0 priorityscore=1501 bulkscore=0 phishscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310240000 definitions=main-2311010119
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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

Everyone,
I now responded to Rob's patch over here: 
https://lkml.org/lkml/2023/11/1/333


> 
> Rob

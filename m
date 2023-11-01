Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDA9D7DE3C0
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 16:37:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344483AbjKAOb6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 10:31:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344477AbjKAObz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 10:31:55 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6E0C125
        for <linux-kernel@vger.kernel.org>; Wed,  1 Nov 2023 07:31:49 -0700 (PDT)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A1DlLpV011889;
        Wed, 1 Nov 2023 14:31:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=R3TXsPSK5SajbEwGt6n5yCmJHeQW6iBSn6r0VLoxBqo=;
 b=bIDhcizJf/L6DWSgDCKeShQIQml9t3W2T7JRA0d98na8mu05ppupGDIIyn9ANLlQqz38
 LiEF7htyCDtqAH5eord2cDMq8EohATC3qcV2zETVgV238oW6c5QLQ8PMsXAk2JNPezP5
 a6O6pIpsRDXyiGptdvHJzBad2R4UstpXi4FkyLxFcVHh+yU35/xG0e0pihrUzZXg0UB1
 YLx4aWBZWHYv9TIsPUpX29MJx6WdnJtwyc8NiVTsXqcOTRR7barLFI1GNvl1G7Ii5200
 1TgRjdrV46Wu5ZJjyKfrBJHnaaGVJle2Gj/M8ENIRk40HNd/hqPZfJj0OJGKWUg2oN7a +g== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3u3qv5hqe9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 01 Nov 2023 14:31:33 +0000
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3A1EJmE2023469;
        Wed, 1 Nov 2023 14:31:32 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3u3qv5hq51-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 01 Nov 2023 14:31:32 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3A1DiYfM011536;
        Wed, 1 Nov 2023 14:31:16 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
        by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3u1e4m002q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 01 Nov 2023 14:31:16 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
        by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3A1EVFHB2949714
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 1 Nov 2023 14:31:15 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 34F6658062;
        Wed,  1 Nov 2023 14:31:15 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 393A05805A;
        Wed,  1 Nov 2023 14:31:14 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.61.182.196])
        by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Wed,  1 Nov 2023 14:31:14 +0000 (GMT)
Message-ID: <aa0074d1f0e33dc6f50e4f71a8fb7a19d319e96c.camel@linux.ibm.com>
Subject: Re: [RFC PATCH] rootfs: Use tmpfs for rootfs even if root= is given
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Stefan Berger <stefanb@linux.ibm.com>
Cc:     Rob Landley <rob@landley.net>, linux-kernel@vger.kernel.org,
        "Milton D. Miller II" <mdmii@outlook.com>,
        Jeff Layton <jlayton@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Jim Cromie <jim.cromie@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "H. Peter Anvin" <hpa@zytor.com>
Date:   Wed, 01 Nov 2023 10:31:13 -0400
In-Reply-To: <2023110159-rasping-stature-af8d@gregkh>
References: <20231031154417.621742-1-stefanb@linux.ibm.com>
         <2023103159-punctuate-amount-f09d@gregkh>
         <6dae6aa6-e6c6-89d6-f9d7-7563708f7662@landley.net>
         <a8693232-431e-4840-a020-cd83c162446e@linux.ibm.com>
         <2023110159-rasping-stature-af8d@gregkh>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-22.el8) 
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: I34zfmbionZTQ6jAt1JyQO00jwjYu6JE
X-Proofpoint-ORIG-GUID: nyCITZ8Mk80SKjGXm5oKkWxuTTwcsbhh
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-01_12,2023-11-01_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 spamscore=0
 mlxlogscore=866 adultscore=0 malwarescore=0 lowpriorityscore=0
 phishscore=0 mlxscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2310240000 definitions=main-2311010122
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2023-11-01 at 15:28 +0100, Greg Kroah-Hartman wrote:
> On Wed, Nov 01, 2023 at 10:16:37AM -0400, Stefan Berger wrote:
> > 
> > 
> > On 11/1/23 07:35, Rob Landley wrote:
> > > On 10/31/23 11:56, Greg Kroah-Hartman wrote:
> > > > On Tue, Oct 31, 2023 at 11:44:17AM -0400, Stefan Berger wrote:
> > > > > rootfs currently does not use tmpfs if the root= boot option is passed
> > > > > even though the documentation about rootfs (added in 6e19eded3684) in
> > > > > Documentation/filesystems/ramfs-rootfs-initramfs.rst states:
> > > > > 
> > > > >    If CONFIG_TMPFS is enabled, rootfs will use tmpfs instead of ramfs by
> > > > >    default.  To force ramfs, add "rootfstype=ramfs" to the kernel command
> > > > >    line.
> > > > 
> > > > At this point in time, is there even any difference between ramfs and
> > > > tmpfs anymore?  Why would you want to choose one over the other here?
> > > 
> > > I submitted a patch to fix this to the list multiple times, which got ignored as
> > > always. Most recently here:
> > > 
> > > https://lore.kernel.org/lkml/8244c75f-445e-b15b-9dbf-266e7ca666e2@landley.net/
> > 
> > Everyone,
> > I now responded to Rob's patch over here:
> > https://lkml.org/lkml/2023/11/1/333
> 
> Note, we can't do anything with lkml.org links, they don't even work at
> times, please always use lore.kernel.org
> 
> Also, one patch out of a longer series also will not work as we can't
> pick it up from there either.
> 
> Can someone resend it, as a stand-alone patch, with the proper people
>  cc:ed and then we can handle that.  You all know this...

The initramfs@vger.kernel.org mailing list should be Cc'ed as well.

-- 
thanks,

Mimi


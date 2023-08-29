Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74EEA78CC87
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 20:57:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238596AbjH2S4r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 14:56:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238598AbjH2S4b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 14:56:31 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 244A1D7;
        Tue, 29 Aug 2023 11:56:29 -0700 (PDT)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37TIk2ku009717;
        Tue, 29 Aug 2023 18:56:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=norCt2lOHTuVAlrFeRtRqK39KWa1v4RfmqoFDy7b2vs=;
 b=TKB8caAVMlHTN7AxO2cC2fNmnJ0UDgXX/JsAn6xNcRc0QFVndEbyOIncvPRtlniUZR2i
 fDj8ctdcY+958tg0Qk/K0wDDA9BM565ZY19XBRjcJ/vJ+GjP6wCwfmhmgHZj/Nlrr1Gx
 fXhlvbBSmQQPGG8pa+oW+dzYC88UzNihwtaM3jQXDDaB00CgHU3RhMENcaO04X6PO1jb
 YSu6Gtsyz0YLdc5nhXcn5LsIkfP2A68zaJ6/Ck60FwzC9XODzQLpmVfYTeohZOTKIxI/
 nwOT8m+dQYOrHw3cp041G7BhK92luSBkLOcvBZtDNkVxqrLcXBcK5sBHhdvULBzwzHnD eg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ssnyc0js6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 29 Aug 2023 18:56:19 +0000
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 37TIa5MA001097;
        Tue, 29 Aug 2023 18:56:19 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ssnyc0jrk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 29 Aug 2023 18:56:19 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 37THPsHS009897;
        Tue, 29 Aug 2023 18:56:17 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
        by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3sqw7kdkjc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 29 Aug 2023 18:56:17 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
        by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 37TIuGjN37224996
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Aug 2023 18:56:16 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 692C95805B;
        Tue, 29 Aug 2023 18:56:16 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D17D458055;
        Tue, 29 Aug 2023 18:56:14 +0000 (GMT)
Received: from [9.61.14.194] (unknown [9.61.14.194])
        by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Tue, 29 Aug 2023 18:56:14 +0000 (GMT)
Message-ID: <9a8ca460-3d36-92cf-ccf4-7ecf1a654f06@linux.ibm.com>
Date:   Tue, 29 Aug 2023 14:56:14 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [syzbot] [input?] INFO: task hung in uhid_char_release
Content-Language: en-US
To:     syzbot <syzbot+8fe2d362af0e1cba8735@syzkaller.appspotmail.com>,
        agordeev@linux.ibm.com, akrowiak@linux.ibm.com,
        benjamin.tissoires@redhat.com, clg@redhat.com, davem@davemloft.net,
        david.rheinsberg@gmail.com, edumazet@google.com, jikos@kernel.org,
        kuba@kernel.org, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        pabeni@redhat.com, syzkaller-bugs@googlegroups.com
References: <00000000000068345606041323fc@google.com>
From:   Matthew Rosato <mjrosato@linux.ibm.com>
In-Reply-To: <00000000000068345606041323fc@google.com>
Content-Type: text/plain; charset=UTF-8
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: O8M01QiYjAGrilVgmI_XpEnLoqm1ASrl
X-Proofpoint-GUID: MtKJXelBIYx1eBNrsjICnvdI0vL2M_6s
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-29_13,2023-08-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 malwarescore=0
 bulkscore=0 mlxlogscore=683 lowpriorityscore=0 priorityscore=1501
 impostorscore=0 phishscore=0 clxscore=1011 spamscore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2308290161
X-Spam-Status: No, score=-0.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/29/23 1:28 PM, syzbot wrote:
> syzbot has bisected this issue to:
> 
> commit bf48961f6f48e3b7eb80c3e179207e9f4e4cd660
> Author: Tony Krowiak <akrowiak@linux.ibm.com>
> Date:   Tue May 30 22:35:37 2023 +0000
> 
>     s390/vfio-ap: realize the VFIO_DEVICE_SET_IRQS ioctl

Hmm, this doesn't seem like the right commit.  The changes for bf48961f6f48e3b7eb80c3e179207e9f4e4cd660 are limited to the vfio_ap module, which requires CONFIG_S390 and CONFIG_VFIO_AP.  Besides the config referenced below I also looked at other cases via the dashboard link and none of the config files I checked had either of these.

Thanks,
Matt

> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=155eba2fa80000
> start commit:   bde7f150276b Merge tag 'pm-6.5-rc2' of git://git.kernel.or..
> git tree:       upstream
> final oops:     https://syzkaller.appspot.com/x/report.txt?x=175eba2fa80000
> console output: https://syzkaller.appspot.com/x/log.txt?x=135eba2fa80000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=6d0f369ef5fb88c9
> dashboard link: https://syzkaller.appspot.com/bug?extid=8fe2d362af0e1cba8735
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=124711b6a80000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=178c5a92a80000
> 
> Reported-by: syzbot+8fe2d362af0e1cba8735@syzkaller.appspotmail.com
> Fixes: bf48961f6f48 ("s390/vfio-ap: realize the VFIO_DEVICE_SET_IRQS ioctl")
> 
> For information about bisection process see: https://goo.gl/tpsmEJ#bisection




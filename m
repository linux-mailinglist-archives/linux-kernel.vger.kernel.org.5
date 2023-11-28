Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 949447FBBA9
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 14:35:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345414AbjK1NfL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 08:35:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344120AbjK1NfJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 08:35:09 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D413BC
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 05:35:16 -0800 (PST)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3ASDM8EZ003645;
        Tue, 28 Nov 2023 13:35:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=pp1;
 bh=rEdfKdSB7ja2iMZ2jUGAX+h3w2ARYDfMjM2Lc41rvaM=;
 b=FQcL6Z+5RV7sdWfOllWiwWJGqpqv8GATNJZwUAEvkXb2sb3oSMhRZnA2AhvcLXYgh+lR
 yM58cw+NtAKWej318jZJCS8SClzbCUaqJMZ/80aodj1XWNjqFGJ6Jy7Z/fBe66/AXOyc
 ZqRVh5wSAEn/8WmYIbsg7VUx89b66KK5cds/eN05WFLVmBsV0+CZO2x340HmgPFn6WVQ
 PIgPT5Idvwig60qGNIptzuZKmOlEZdunxPvSwaGL+TSwU2WJLBYEorlEZFQTd14Z3xu9
 cEWRBlaBdN9AgqLZ0WO1r21fVwDrIxudz6dyJW13RRTxTyZKQl18MBC2Blk3HPBfTnY9 +A== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3unh1bgdua-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Nov 2023 13:35:02 +0000
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3ASDMeRc004795;
        Tue, 28 Nov 2023 13:35:02 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3unh1bgdtd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Nov 2023 13:35:02 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
        by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3ASDS9dW004930;
        Tue, 28 Nov 2023 13:35:01 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
        by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3ukwfjyhf5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Nov 2023 13:35:01 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
        by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3ASDYxEZ22020740
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 Nov 2023 13:34:59 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5DE4F2004B;
        Tue, 28 Nov 2023 13:34:59 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A315020043;
        Tue, 28 Nov 2023 13:34:58 +0000 (GMT)
Received: from li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com (unknown [9.171.44.4])
        by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Tue, 28 Nov 2023 13:34:58 +0000 (GMT)
Date:   Tue, 28 Nov 2023 14:34:56 +0100
From:   Alexander Gordeev <agordeev@linux.ibm.com>
To:     Baoquan He <bhe@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
        x86@kernel.org, akpm@linux-foundation.org, eric_devolder@yahoo.com,
        ignat@cloudflare.com
Subject: Re: [PATCH v2] drivers/base/cpu: crash data showing should depends
 on KEXEC_CORE
Message-ID: <ZWXsgElVV7TH+pte@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
References: <20231128055248.659808-1-bhe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231128055248.659808-1-bhe@redhat.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 9jN2dB2dP_bs7b9e1lhEwwnjrNoRXWV2
X-Proofpoint-ORIG-GUID: qOMzKUQ6Gb8v5cc7INwMaU2CbAA7vyAA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-28_14,2023-11-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 mlxlogscore=726
 spamscore=0 priorityscore=1501 phishscore=0 malwarescore=0
 lowpriorityscore=0 bulkscore=0 impostorscore=0 adultscore=0 suspectscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311280108
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 28, 2023 at 01:52:48PM +0800, Baoquan He wrote:
> After commit 88a6f8994421 ("crash: memory and CPU hotplug sysfs
> attributes"), on x86_64, if only below kernel configs related to kdump
> are set, compiling error are triggered.
> 
> ----
> CONFIG_CRASH_CORE=y
> CONFIG_KEXEC_CORE=y
> CONFIG_CRASH_DUMP=y
> CONFIG_CRASH_HOTPLUG=y
> ------
> 
> ------------------------------------------------------
> drivers/base/cpu.c: In function ‘crash_hotplug_show’:
> drivers/base/cpu.c:309:40: error: implicit declaration of function ‘crash_hotplug_cpu_support’; did you mean ‘crash_hotplug_show’? [-Werror=implicit-function-declaration]
>   309 |         return sysfs_emit(buf, "%d\n", crash_hotplug_cpu_support());
>       |                                        ^~~~~~~~~~~~~~~~~~~~~~~~~
>       |                                        crash_hotplug_show
> cc1: some warnings being treated as errors
> ------------------------------------------------------
> 
> CONFIG_KEXEC is used to enable kexec_load interface, the
> crash_notes/crash_notes_size/crash_hotplug showing depends on
> CONFIG_KEXEC is incorrect. It should depend on KEXEC_CORE instead.
> 
> Fix it now.
> 
> Fixes: commit 88a6f8994421 ("crash: memory and CPU hotplug sysfs attributes")
> Signed-off-by: Baoquan He <bhe@redhat.com>
> ---
>  drivers/base/cpu.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Not implemented on s390, but still:
Tested-by: Alexander Gordeev <agordeev@linux.ibm.com>

Thanks!

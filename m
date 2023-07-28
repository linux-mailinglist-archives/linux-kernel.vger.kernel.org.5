Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41A60766798
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 10:47:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234106AbjG1IrK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 04:47:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbjG1Iql (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 04:46:41 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBFCB4208
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 01:46:02 -0700 (PDT)
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36S8jDcv004062;
        Fri, 28 Jul 2023 08:45:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=g/WTtRdr0WgLR2CAnyveRUJpX8y58Wg0Rq3WiXJcs2M=;
 b=Arx+CXTuXRQQ2Jv9ddD4+HFHo9KN+9lwoLMwqhZjfnBFY9B9vo4HB9ovKOtjJQ40eGI8
 3uCM3Ay6YLbPtSGfNjYQ7k8AAQsgTjt8wxdw7G079X5h0Ok6hDyPPpfUk949IEubZDZV
 A9UVY6O1L/iPFVwqecP+M/DeKVM4hzKX6yOJJah0Azd+10sIqT/JbX4cghbe4hfXo/9S
 2mrkrI++7Pg5kEu/U88RKvwQ7CpMObU6o6xJvCocJLakTRYcMnkpFMibUy9q4cdJfZez
 jYRLB+KfBYmRThpWpN9xmyB16TJDn5RmPHR0HBZBzbOy8V3bvcvZoWyL/CmBOCBqgEnp hw== 
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3s497p20pb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 28 Jul 2023 08:45:48 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 36S7c8R4002079;
        Fri, 28 Jul 2023 08:45:47 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
        by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3s0tenmkcq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 28 Jul 2023 08:45:46 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
        by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 36S8jj8318219598
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Jul 2023 08:45:45 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E920320043;
        Fri, 28 Jul 2023 08:45:44 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CEDE920040;
        Fri, 28 Jul 2023 08:45:44 +0000 (GMT)
Received: from [9.171.162.186] (unknown [9.171.162.186])
        by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Fri, 28 Jul 2023 08:45:44 +0000 (GMT)
Message-ID: <4d9a0771-6331-c25b-333e-320879a826ea@linux.ibm.com>
Date:   Fri, 28 Jul 2023 10:45:44 +0200
Subject: Re: [PATCH] [v2] gcov: shut up missing prototype warnings for
 internal stubs
To:     Arnd Bergmann <arnd@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
References: <20230725123042.2269077-1-arnd@kernel.org>
Content-Language: en-US
From:   Peter Oberparleiter <oberpar@linux.ibm.com>
In-Reply-To: <20230725123042.2269077-1-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: HzvQHj3GvcUXFw-GAUDAXcGHIwc_8YNX
X-Proofpoint-GUID: HzvQHj3GvcUXFw-GAUDAXcGHIwc_8YNX
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-27_10,2023-07-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 clxscore=1011 mlxscore=0 phishscore=0 spamscore=0 priorityscore=1501
 malwarescore=0 bulkscore=0 suspectscore=0 mlxlogscore=779 adultscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307280077
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25.07.2023 14:23, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> gcov uses global functions that are called from generated code,
> but these have no prototype in a header, which causes a W=1
> build warning:
> 
> kernel/gcov/gcc_base.c:12:6: error: no previous prototype for '__gcov_init' [-Werror=missing-prototypes]
> kernel/gcov/gcc_base.c:40:6: error: no previous prototype for '__gcov_flush' [-Werror=missing-prototypes]
> kernel/gcov/gcc_base.c:46:6: error: no previous prototype for '__gcov_merge_add' [-Werror=missing-prototypes]
> kernel/gcov/gcc_base.c:52:6: error: no previous prototype for '__gcov_merge_single' [-Werror=missing-prototypes]
> 
> Just turn off these warnings unconditionally for the two files
> that contain them.
> 
> Link: https://lore.kernel.org/all/0820010f-e9dc-779d-7924-49c7df446bce@linux.ibm.com/
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Tested successfully with GCC 13.1 and Clang 18. Thanks for the fix!

Acked-by: Peter Oberparleiter <oberpar@linux.ibm.com>

Andrew, could you add this patch via your tree?

> ---
>  kernel/gcov/Makefile | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/kernel/gcov/Makefile b/kernel/gcov/Makefile
> index 16f8ecc7d8821..ccd02afaeffb4 100644
> --- a/kernel/gcov/Makefile
> +++ b/kernel/gcov/Makefile
> @@ -3,4 +3,6 @@ ccflags-y := -DSRCTREE='"$(srctree)"' -DOBJTREE='"$(objtree)"'
>  
>  obj-y := base.o fs.o
>  obj-$(CONFIG_CC_IS_GCC) += gcc_base.o gcc_4_7.o
> +CFLAGS_gcc_base.o += -Wno-missing-prototypes -Wno-missing-declarations
>  obj-$(CONFIG_CC_IS_CLANG) += clang.o
> +CFLAGS_clang.o += -Wno-missing-prototypes -Wno-missing-declarations

-- 
Peter Oberparleiter
Linux on IBM Z Development - IBM Germany R&D


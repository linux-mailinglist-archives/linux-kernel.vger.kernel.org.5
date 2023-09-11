Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E7DD79B098
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 01:50:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235107AbjIKUsl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 16:48:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237047AbjIKLyg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 07:54:36 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07AA5E40;
        Mon, 11 Sep 2023 04:54:30 -0700 (PDT)
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38BB7fEA011377;
        Mon, 11 Sep 2023 11:54:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=6zAtbOPLTprDp5l7a3xBBQM94y0SgE+eMjbCRCMbzIQ=;
 b=JLN5RrouLe82dpApYqPuGsE594lDoDu5EmAF/495hcmALP0d7EnL/hRlmyS0r4mJd52D
 /L+OG25knQuEVzINCmGB7jSF2tENrljlEVBRWl3csgzN8tvKm5YmUUWe3PqDYS5Unx7i
 EmjouTBTPxJQo4DnVi8ENKLWL5xXH4NpeF4xHOcQ3X+ufkGAFgguCqniWs9luegi44JK
 wTFCRw8s77Ep03NlDbYfozSsLd9j7yVlGWt7ga7onmh4XNdtVRGmcrlSgA6CUUcNYqwQ
 Ssq0CS3xgniphTh7dNCd9BNjauRJNLGmDNe23vxUBNim4Hb5mpot2xspqe7ra8rqW9J/ 8w== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3t20gp2w4h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 Sep 2023 11:54:25 +0000
Received: from m0353722.ppops.net (m0353722.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 38BBb5tU023469;
        Mon, 11 Sep 2023 11:54:25 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3t20gp2w44-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 Sep 2023 11:54:25 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 38B9UCVw012083;
        Mon, 11 Sep 2023 11:54:24 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
        by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3t13dyadxm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 Sep 2023 11:54:24 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
        by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 38BBsN2820185526
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 11 Sep 2023 11:54:23 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 12FB65805C;
        Mon, 11 Sep 2023 11:54:23 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6ECA75805A;
        Mon, 11 Sep 2023 11:54:17 +0000 (GMT)
Received: from [9.171.51.126] (unknown [9.171.51.126])
        by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Mon, 11 Sep 2023 11:54:16 +0000 (GMT)
Message-ID: <2b1d129c-06e2-0161-7c8a-1e930150d797@linux.ibm.com>
Date:   Mon, 11 Sep 2023 13:54:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [RFC PATCH net-next] net/smc: Introduce SMC-related proc files
To:     Wen Gu <guwen@linux.alibaba.com>, kgraul@linux.ibm.com,
        jaka@linux.ibm.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com
Cc:     alibuda@linux.alibaba.com, tonylu@linux.alibaba.com,
        linux-s390@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1694416820-60340-1-git-send-email-guwen@linux.alibaba.com>
From:   Wenjia Zhang <wenjia@linux.ibm.com>
In-Reply-To: <1694416820-60340-1-git-send-email-guwen@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: zZ85GoqsMvyzF1GYSDC44WzjAXuOsqnB
X-Proofpoint-ORIG-GUID: tVcKMCzZtJNKN0HX0ekLoduII0CImiOx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-11_06,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 clxscore=1011
 mlxlogscore=700 priorityscore=1501 malwarescore=0 spamscore=0 adultscore=0
 phishscore=0 impostorscore=0 mlxscore=0 lowpriorityscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309110105
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11.09.23 09:20, Wen Gu wrote:
> This patch introduces /proc/net/smc4 and /proc/net/smc6 files to report
> statistic information of SMC connections.
> 
> Compared with 'smcss' command in smc-tools, getting SMC connections via
> proc files is not efficient. However, in some container scenarios, some
> dependencies are lacked for compiling and using smc-tools. In this case,
> using proc files to check SMC connections becomes a simple and fast way.
> 
> Signed-off-by: Wen Gu <guwen@linux.alibaba.com>
> ---
>   include/net/smc.h  |   5 +-
>   net/smc/Makefile   |   2 +-
>   net/smc/af_smc.c   |  22 ++++-
>   net/smc/smc_diag.c |  29 +++---
>   net/smc/smc_proc.c | 283 +++++++++++++++++++++++++++++++++++++++++++++++++++++
>   net/smc/smc_proc.h |  35 +++++++
>   6 files changed, 355 insertions(+), 21 deletions(-)
>   create mode 100644 net/smc/smc_proc.c
>   create mode 100644 net/smc/smc_proc.h
> 

Hi Wen,

I can understand your problem and frustration. However, there are two 
reasons I'm not really convinced by the proc file method:
1) AFAI, the proc method could consume many CPU time especially in case 
with a log of sockets to read the pseudo files.
2) We have already implemented the complex netlink method on the same 
purpose. I see the double expense to main the code.

Then the question is if the lack of dependency issue can be handle 
somehow, or the proc method is the only way to achieve this purpose?

Any opinion is welcome!

Thanks,
Wenjia

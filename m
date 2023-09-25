Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C6EB7AD740
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 13:50:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230434AbjIYLul (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 07:50:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjIYLug (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 07:50:36 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DF3E9B;
        Mon, 25 Sep 2023 04:50:30 -0700 (PDT)
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38PBbbSR000407;
        Mon, 25 Sep 2023 11:50:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=u/uhG0g/kXxNmlqKDXNg/CTspL0SQq4wEiD1G7ilDOA=;
 b=gPk0OIhhwM4P/q0SQJ8jShpAnQvbf8wHyamg1+r0ImY1fE+0375sSKWLzFisMCp7SKRW
 zt4eA1tPDWGVaLSylOF+8molm1X3gDsHxo1PBsaKxL3AKBSBUeCexzTtoEWSg76efouN
 owxOIY37Dk/22AU/JGGZxVIF9P3MobfeXQ52wrusa/+6/yF0/2Hd5bKTkUn5/YbVo1A3
 eEDxG5dAbrcW2n5gu14igOHUZ/M/a0GYIzsCoKL+7EBFOnCyFwOn0gLs3kfieVMqDi94
 xE1xWrNpzomuY0v1bjJIUEfu8OBJKQJg8WT8rcshuP+sivlM+rTFaaHAf5yuqaxYF+mz TQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tb7m62ts9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 25 Sep 2023 11:50:27 +0000
Received: from m0353726.ppops.net (m0353726.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 38PBbp5h002470;
        Mon, 25 Sep 2023 11:50:27 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tb7m62trt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 25 Sep 2023 11:50:26 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
        by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 38P9tmFS030719;
        Mon, 25 Sep 2023 11:50:26 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
        by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3tacjjhd4d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 25 Sep 2023 11:50:25 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
        by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 38PBoMN116908974
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 25 Sep 2023 11:50:23 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CE75320043;
        Mon, 25 Sep 2023 11:50:22 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9433F20040;
        Mon, 25 Sep 2023 11:50:22 +0000 (GMT)
Received: from [9.152.224.54] (unknown [9.152.224.54])
        by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Mon, 25 Sep 2023 11:50:22 +0000 (GMT)
Message-ID: <3febdf3e-e213-7acf-7dd4-75d177676c3e@linux.ibm.com>
Date:   Mon, 25 Sep 2023 13:50:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH net-next v4 09/18] net/smc: introduce SMC-D loopback
 device
Content-Language: en-US
To:     Wen Gu <guwen@linux.alibaba.com>, kgraul@linux.ibm.com,
        wenjia@linux.ibm.com, jaka@linux.ibm.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Cc:     schnelle@linux.ibm.com, gbayer@linux.ibm.com, pasic@linux.ibm.com,
        alibuda@linux.alibaba.com, tonylu@linux.alibaba.com,
        dust.li@linux.alibaba.com, linux-s390@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1695568613-125057-1-git-send-email-guwen@linux.alibaba.com>
 <1695568613-125057-10-git-send-email-guwen@linux.alibaba.com>
From:   Alexandra Winter <wintera@linux.ibm.com>
In-Reply-To: <1695568613-125057-10-git-send-email-guwen@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: t_8wHPH4AWvOWU9GE8aKNKofI0SNlpax
X-Proofpoint-GUID: RlZnKHlCw6vIphuA58WF_Icozxk9YcXO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-25_08,2023-09-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 lowpriorityscore=0 clxscore=1015 priorityscore=1501 adultscore=0
 impostorscore=0 phishscore=0 spamscore=0 mlxlogscore=577 suspectscore=0
 mlxscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2309250086
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 24.09.23 17:16, Wen Gu wrote:
> This patch introduces a kind of loopback device for SMC-D. The device
> is created when SMC module is loaded and destroyed when the SMC module
> is unloaded. The loopback device is a kernel device used only by the
> SMC module and is not restricted by net namespace, so it can be used
> for local inter-process or inter-container communication.
> 
> Signed-off-by: Wen Gu <guwen@linux.alibaba.com>
> ---
>  net/smc/Kconfig        |  13 ++++
>  net/smc/Makefile       |   2 +-
>  net/smc/af_smc.c       |  12 +++-
>  net/smc/smc_loopback.c | 165 +++++++++++++++++++++++++++++++++++++++++++++++++
>  net/smc/smc_loopback.h |  33 ++++++++++
>  5 files changed, 223 insertions(+), 2 deletions(-)
>  create mode 100644 net/smc/smc_loopback.c
>  create mode 100644 net/smc/smc_loopback.h


Hello Wen Gu,

thank you for adding the Kconfig, so the distributions can decide when to offer this feature.

I propose you add some kind of runtime switch as well. Not every user who loads the SMC module
may want to exploit smcd-loopback. Especially in native environements without containers.

If no RoCE interfaces or no ISM interfaces exist, the respective handling is skipped in SMC.
If loopback is always created unconditionally, there is no way to opt-out.

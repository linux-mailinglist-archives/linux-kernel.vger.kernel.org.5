Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 974C575878C
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 23:57:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230417AbjGRV5z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 17:57:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbjGRV5x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 17:57:53 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C5081995
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 14:57:52 -0700 (PDT)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36ILcsCR007145;
        Tue, 18 Jul 2023 21:57:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=y1Sq4aa1BxBRuguYrChk1qcoYn3CGsLEXoGXBt/56hI=;
 b=gALsVim0H4c0iZ26CEZt+cb5w+V6DYBdL8S/5TNmlzPNAJ7elQD7nbJvV8EpD/WAojj7
 g5suYD/PLk/zWNhxGUohtAm4hClek2xtUqoznESMQvWGWDy3ZuAVixU3GNGJiZhBC+sM
 gUcpQ3nTtnp4AQr6MG1hcZ4svxwnUQiSqvpRPxDR2kDAOqAEjcdCqPICyOl2HhdQQAwu
 kbyhUj1ieJaVIw0ZT4lYeBk4WaqUh5+fI5aT9HL/QCQ53oh97uV4hLf9ZhCWu4rU5NK1
 C5ocOfQbLt7FyxG5eUAG2U1tsuR0k0Yv3kVz37LhRRb6WZFaJbvbWCm/lUP7Q1dkR6mJ gw== 
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rx24vs8md-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 18 Jul 2023 21:57:42 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 36IJkJpo029057;
        Tue, 18 Jul 2023 21:57:41 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
        by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3rv6smemjm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 18 Jul 2023 21:57:41 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
        by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 36ILveWU66060666
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 18 Jul 2023 21:57:40 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4CBD85805D;
        Tue, 18 Jul 2023 21:57:40 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D847558053;
        Tue, 18 Jul 2023 21:57:39 +0000 (GMT)
Received: from [9.61.1.152] (unknown [9.61.1.152])
        by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Tue, 18 Jul 2023 21:57:39 +0000 (GMT)
Message-ID: <9b4102fc-b630-8463-aa00-e7d8aab4a2be@linux.ibm.com>
Date:   Tue, 18 Jul 2023 16:57:39 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2] fsi: Explicitly include correct DT includes
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>, Jeremy Kerr <jk@ozlabs.org>,
        Joel Stanley <joel@jms.id.au>,
        Alistar Popple <alistair@popple.id.au>
Cc:     linux-fsi@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20230718205508.1790932-1-robh@kernel.org>
From:   Eddie James <eajames@linux.ibm.com>
In-Reply-To: <20230718205508.1790932-1-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: a3GsO9wmnPVgiqvr7os23eQ7mATA7bTe
X-Proofpoint-GUID: a3GsO9wmnPVgiqvr7os23eQ7mATA7bTe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-18_17,2023-07-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 priorityscore=1501 clxscore=1015 malwarescore=0 adultscore=0
 suspectscore=0 mlxlogscore=866 mlxscore=0 impostorscore=0 bulkscore=0
 spamscore=0 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2306200000 definitions=main-2307180196
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 7/18/23 15:55, Rob Herring wrote:
> The DT of_device.h and of_platform.h date back to the separate
> of_platform_bus_type before it as merged into the regular platform bus.
> As part of that merge prepping Arm DT support 13 years ago, they
> "temporarily" include each other. They also include platform_device.h
> and of.h. As a result, there's a pretty much random mix of those include
> files used throughout the tree. In order to detangle these headers and
> replace the implicit includes with struct declarations, users need to
> explicitly include the correct includes.


Thanks,

Reviewed-by: Eddie James <eajames@linux.ibm.com>


>
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
> v2:
>   - I inadvertently had a dependency in my tree partially updating the
>     headers. That's squashed in now.
> ---
>   drivers/fsi/fsi-occ.c     | 2 +-
>   drivers/fsi/fsi-sbefifo.c | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/fsi/fsi-occ.c b/drivers/fsi/fsi-occ.c
> index abdd37d5507f..da35ca9e84a6 100644
> --- a/drivers/fsi/fsi-occ.c
> +++ b/drivers/fsi/fsi-occ.c
> @@ -15,7 +15,7 @@
>   #include <linux/mutex.h>
>   #include <linux/fsi-occ.h>
>   #include <linux/of.h>
> -#include <linux/of_device.h>
> +#include <linux/of_platform.h>
>   #include <linux/platform_device.h>
>   #include <linux/sched.h>
>   #include <linux/slab.h>
> diff --git a/drivers/fsi/fsi-sbefifo.c b/drivers/fsi/fsi-sbefifo.c
> index 9912b7a6a4b9..4bae52c98620 100644
> --- a/drivers/fsi/fsi-sbefifo.c
> +++ b/drivers/fsi/fsi-sbefifo.c
> @@ -22,8 +22,8 @@
>   #include <linux/module.h>
>   #include <linux/mutex.h>
>   #include <linux/of.h>
> -#include <linux/of_device.h>
>   #include <linux/of_platform.h>
> +#include <linux/platform_device.h>
>   #include <linux/sched.h>
>   #include <linux/slab.h>
>   #include <linux/uaccess.h>

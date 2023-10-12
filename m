Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2A957C76B0
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 21:26:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442163AbjJLT0w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 15:26:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442009AbjJLT0u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 15:26:50 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C77B9C0;
        Thu, 12 Oct 2023 12:26:48 -0700 (PDT)
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39CJH8Bx014840;
        Thu, 12 Oct 2023 19:26:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=r/YKueMPzYqIDK3VPyKHJMLplhIvH5ZVkLFWtXEXrxg=;
 b=H/PBjvRpBHnHd47o7XWZrGkB4vprRC+20RI4KI/iGlv0GkC3mEHO0iB/j/aB0+XWIfJG
 cC5NfFj/n5WdlVHOlYUUlR2H6Pm8cRhW7Fxwk8/PXWhpcJVfu0n3BzhE7YzkM84OHW2Y
 fmPIXUP2LoFCAH6tIo8fVc5JdoOh6BAm4iAxqzncwXcogT6WlUfQBQRs3ZF2aTh6jLtj
 jCoHQtU9yEHqHqtOSFak8bHWkFwEYlESB4fmUNSw4PQD89pAJDMXptQmZAmvPgBfCaMi
 W7oos5v59n8+lauC7O8dsCc3hcHnXnnBZFOkSDb53t6/Pi7PIprLUxZe/TKhZoGK4QTt Sw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tpptq8drm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 Oct 2023 19:26:34 +0000
Received: from m0353727.ppops.net (m0353727.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 39CJIBOw020564;
        Thu, 12 Oct 2023 19:26:34 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tpptq8dnq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 Oct 2023 19:26:34 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
        by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 39CIq8NM001270;
        Thu, 12 Oct 2023 19:26:30 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
        by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3tkkvk9g5y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 Oct 2023 19:26:30 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
        by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 39CJQTQq17105522
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 Oct 2023 19:26:29 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 01BE058058;
        Thu, 12 Oct 2023 19:26:29 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8DD255805B;
        Thu, 12 Oct 2023 19:26:26 +0000 (GMT)
Received: from [9.171.29.13] (unknown [9.171.29.13])
        by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Thu, 12 Oct 2023 19:26:26 +0000 (GMT)
Message-ID: <0b7b9d03-13a5-4cfc-948b-72a56bfe3d50@linux.ibm.com>
Date:   Thu, 12 Oct 2023 21:26:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 net] net/smc: fix smc clc failed issue when netdevice
 not in init_net
Content-Language: en-GB
To:     Albert Huang <huangjie.albert@bytedance.com>,
        Karsten Graul <kgraul@linux.ibm.com>,
        Jan Karcher <jaka@linux.ibm.com>,
        Tony Lu <tonylu@linux.alibaba.com>,
        Wen Gu <guwen@linux.alibaba.com>
Cc:     "D. Wythe" <alibuda@linux.alibaba.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, linux-s390@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20231011074851.95280-1-huangjie.albert@bytedance.com>
From:   Wenjia Zhang <wenjia@linux.ibm.com>
In-Reply-To: <20231011074851.95280-1-huangjie.albert@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: udSsbT1dY7S7JpUUKrjjQ-E905tpav33
X-Proofpoint-ORIG-GUID: zBWMfv-x-sigqOgduXlAoSY-hDk0eZte
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-12_11,2023-10-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 phishscore=0
 bulkscore=0 spamscore=0 impostorscore=0 suspectscore=0 malwarescore=0
 mlxscore=0 mlxlogscore=999 adultscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310120162
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11.10.23 09:48, Albert Huang wrote:
> If the netdevice is within a container and communicates externally
> through network technologies such as VxLAN, we won't be able to find
> routing information in the init_net namespace. To address this issue,
> we need to add a struct net parameter to the smc_ib_find_route function.
> This allow us to locate the routing information within the corresponding
> net namespace, ensuring the correct completion of the SMC CLC interaction.
> 
> Fixes: e5c4744cfb59 ("net/smc: add SMC-Rv2 connection establishment")
> Signed-off-by: Albert Huang <huangjie.albert@bytedance.com>
> ---
>   net/smc/af_smc.c | 3 ++-
>   net/smc/smc_ib.c | 7 ++++---
>   net/smc/smc_ib.h | 2 +-
>   3 files changed, 7 insertions(+), 5 deletions(-)
> 

looks good to me, thanks!

Reviewed-by: Wenjia Zhang <wenjia@linux.ibm.com>

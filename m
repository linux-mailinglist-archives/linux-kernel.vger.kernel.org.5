Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4BF87F749B
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 14:11:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230159AbjKXNLl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 08:11:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230333AbjKXNLi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 08:11:38 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF39C10F3;
        Fri, 24 Nov 2023 05:11:44 -0800 (PST)
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AOCIFKS008542;
        Fri, 24 Nov 2023 13:11:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=5IoTUiCxTRIPqYPCKOzSb0u5MJow0CO3WitoRploFwA=;
 b=IKtdipP5X5umVD/CtAI9EQfZH28Z+pie6OzdKras9+AfBwe0YWU2Zec1PBQHWr/3DX7n
 NJamVke+dOJFIrTwpbcPAgvzvHQNw8ry3m4gULxphdwPyIoFzQqRuo1y8rHVquWuOJO9
 WiKSEQXNTZCNE5ECLazgAQcPT2Ep4doQsOK4QWT0MgmAFYmkhxA+i7+82qISZJI2OCm9
 FBWQVVCWj49xbJu7/pMpla8dVzZZ5qZIMPu3Yx9yl36I6mbXRXWQk7eI0Nyr7+Rd+Q5a
 b2GDdOXwrek7uQgvuuqZyCPpWPSE434DjdDeBJWZxaG0iutjSh5DKmKTqfOcmMrVS9Oj Iw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ujuq6s43x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 24 Nov 2023 13:11:40 +0000
Received: from m0353722.ppops.net (m0353722.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3AODB5ul006198;
        Fri, 24 Nov 2023 13:11:39 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ujuq6s43b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 24 Nov 2023 13:11:39 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3AOCIoCE018998;
        Fri, 24 Nov 2023 13:11:38 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
        by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3uf93mdk6r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 24 Nov 2023 13:11:38 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
        by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3AODBbaT19726940
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 24 Nov 2023 13:11:38 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 96D9E58060;
        Fri, 24 Nov 2023 13:11:37 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 055A958056;
        Fri, 24 Nov 2023 13:11:34 +0000 (GMT)
Received: from [9.171.44.206] (unknown [9.171.44.206])
        by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Fri, 24 Nov 2023 13:11:33 +0000 (GMT)
Message-ID: <30b53b21-40ad-407a-bef7-ddc28f8978e2@linux.ibm.com>
Date:   Fri, 24 Nov 2023 14:11:33 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 0/7] net/smc: implement SMCv2.1 virtual ISM
 device support
Content-Language: en-GB
To:     Wen Gu <guwen@linux.alibaba.com>, wintera@linux.ibm.com,
        hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, kgraul@linux.ibm.com, jaka@linux.ibm.com
Cc:     borntraeger@linux.ibm.com, svens@linux.ibm.com,
        alibuda@linux.alibaba.com, tonylu@linux.alibaba.com,
        raspl@linux.ibm.com, schnelle@linux.ibm.com,
        linux-s390@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1700402277-93750-1-git-send-email-guwen@linux.alibaba.com>
From:   Wenjia Zhang <wenjia@linux.ibm.com>
In-Reply-To: <1700402277-93750-1-git-send-email-guwen@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 5XEJB9UbR5achhgrO0-9qVQrsNZgbc6A
X-Proofpoint-GUID: SXTFhSlAIzL3ucdUb8ZCp0gQhMjXWwoW
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-23_15,2023-11-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 mlxlogscore=999 bulkscore=0 priorityscore=1501 adultscore=0
 impostorscore=0 spamscore=0 clxscore=1011 malwarescore=0 mlxscore=0
 phishscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2311060000 definitions=main-2311240102
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 19.11.23 14:57, Wen Gu wrote:
> The fourth edition of SMCv2 adds the SMC version 2.1 feature updates for
> SMC-Dv2 with virtual ISM. Virtual ISM are created and supported mainly by
> OS or hypervisor software, comparable to IBM ISM which is based on platform
> firmware or hardware.
> 
> With the introduction of virtual ISM, SMCv2.1 makes some updates:
> 
> - Introduce feature bitmask to indicate supplemental features.
> - Reserve a range of CHIDs for virtual ISM.
> - Support extended GIDs (128 bits) in CLC handshake.
> 
> So this patch set aims to implement these updates in Linux kernel. And it
> acts as the first part of the new version of [1].
> 
> [1] https://lore.kernel.org/netdev/1695568613-125057-1-git-send-email-guwen@linux.alibaba.com/
> 
> Wen Gu (7):
>    net/smc: Rename some variable 'fce' to 'fce_v2x' for clarity
>    net/smc: support SMCv2.x supplemental features negotiation
>    net/smc: introduce virtual ISM device support feature
>    net/smc: define a reserved CHID range for virtual ISM devices
>    net/smc: compatible with 128-bits extend GID of virtual ISM device
>    net/smc: disable SEID on non-s390 archs where virtual ISM may be used
>    net/smc: manage system EID in SMC stack instead of ISM driver
> 
>   drivers/s390/net/ism.h     |  6 ---
>   drivers/s390/net/ism_drv.c | 54 +++++++--------------------
>   include/linux/ism.h        |  1 -
>   include/net/smc.h          | 16 +++++---
>   net/smc/af_smc.c           | 68 ++++++++++++++++++++++++++-------
>   net/smc/smc.h              |  7 ++++
>   net/smc/smc_clc.c          | 93 ++++++++++++++++++++++++++++++++--------------
>   net/smc/smc_clc.h          | 22 +++++++----
>   net/smc/smc_core.c         | 30 ++++++++++-----
>   net/smc/smc_core.h         |  8 ++--
>   net/smc/smc_diag.c         |  7 +++-
>   net/smc/smc_ism.c          | 57 ++++++++++++++++++++--------
>   net/smc/smc_ism.h          | 31 +++++++++++++++-
>   net/smc/smc_pnet.c         |  4 +-
>   14 files changed, 269 insertions(+), 135 deletions(-)
> 

Hi Wen Gu,

Just FYI, the review is still on going and some tests on our plateform 
still need to do. I'll give you my comments as soon as the testing is 
done. I think it would be at the beginning of next week.

Thanks,
Wenjia

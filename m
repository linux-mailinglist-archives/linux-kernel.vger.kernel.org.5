Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DFE17B07F0
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 17:16:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232370AbjI0PQw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 11:16:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232289AbjI0PQv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 11:16:51 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99CF3121;
        Wed, 27 Sep 2023 08:16:49 -0700 (PDT)
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38REdBKl008435;
        Wed, 27 Sep 2023 15:16:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=v9WDm3swDxscG39kJoxW69ln7dXHTF+Bl/xaN5IviGE=;
 b=oh4ZMEcSSsC5E/Ob9R4hjNaeeiUeZW2bvP5n97p9Neoq2h1plFTI7ywIozx+0yt15qc0
 djfHAqkD4tn/0vlf60JAmDqo7rGyo3mxGX9ampwaieZWN8yWOOWBH8GnmSOA3tC2Fce9
 E+J52mE8Rqpr5zudvjdZ5MV/NSJ9O7DI9BO5Bb4NJsg53vfo8lO7yMb7PQ1mjiV1Ye+d
 TQmbKaPAU3gssC0fO103YPIZmK9tdH3iwWEe8ImietQJnTklvn/KyrfVD4RQlS55RDTn
 SWCHZcI2NCWNsy6dIhQsSYwfSfYpDT3ZczGaNxtLQK2Cm4rQDKjApYXFIRbWgnWeDhk3 cA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tcnrejp0s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 27 Sep 2023 15:16:44 +0000
Received: from m0353728.ppops.net (m0353728.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 38REdiol011469;
        Wed, 27 Sep 2023 15:16:44 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tcnrejnyw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 27 Sep 2023 15:16:43 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 38RDlpZW008192;
        Wed, 27 Sep 2023 15:16:42 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
        by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3tabbnce06-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 27 Sep 2023 15:16:42 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
        by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 38RFGdGj27460316
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 27 Sep 2023 15:16:39 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5733420043;
        Wed, 27 Sep 2023 15:16:39 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0E06C20040;
        Wed, 27 Sep 2023 15:16:39 +0000 (GMT)
Received: from [9.152.224.54] (unknown [9.152.224.54])
        by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Wed, 27 Sep 2023 15:16:39 +0000 (GMT)
Message-ID: <2e4bb42a-1a6c-476e-c982-c4d6cfdac63b@linux.ibm.com>
Date:   Wed, 27 Sep 2023 17:16:38 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH net-next v4 00/18] net/smc: implement virtual ISM
 extension and loopback-ism
To:     Wen Gu <guwen@linux.alibaba.com>, kgraul@linux.ibm.com,
        wenjia@linux.ibm.com, jaka@linux.ibm.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Cc:     schnelle@linux.ibm.com, gbayer@linux.ibm.com, pasic@linux.ibm.com,
        alibuda@linux.alibaba.com, tonylu@linux.alibaba.com,
        dust.li@linux.alibaba.com, linux-s390@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1695568613-125057-1-git-send-email-guwen@linux.alibaba.com>
Content-Language: en-US
From:   Alexandra Winter <wintera@linux.ibm.com>
In-Reply-To: <1695568613-125057-1-git-send-email-guwen@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: D3TzLw2NxL2MMA3iaphM9MHelsWsd5FI
X-Proofpoint-ORIG-GUID: bDksIiKl37y27rHIoRyXx7P-b45IYNCI
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 4 URL's were un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-27_09,2023-09-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 bulkscore=0 clxscore=1015 adultscore=0
 phishscore=0 impostorscore=0 mlxlogscore=629 mlxscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2309270127
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
> Wen Gu (18):
>   net/smc: decouple ism_dev from SMC-D device dump
>   net/smc: decouple ism_dev from SMC-D DMB registration
>   net/smc: extract v2 check helper from SMC-D device registration
>   net/smc: support SMCv2.x supplemental features negotiation
>   net/smc: reserve CHID range for SMC-D virtual device
>   net/smc: extend GID to 128bits only for virtual ISM device
>   net/smc: disable SEID on non-s390 architecture
>   net/smc: enable virtual ISM device feature bit
>   net/smc: introduce SMC-D loopback device
>   net/smc: implement ID-related operations of loopback
>   net/smc: implement some unsupported operations of loopback
>   net/smc: implement DMB-related operations of loopback
>   net/smc: register loopback device as SMC-Dv2 device
>   net/smc: add operation for getting DMB attribute
>   net/smc: add operations for DMB attach and detach
>   net/smc: avoid data copy from sndbuf to peer RMB in SMC-D
>   net/smc: modify cursor update logic when sndbuf mapped to RMB
>   net/smc: add interface implementation of loopback device
> 
>  drivers/s390/net/ism_drv.c    |  20 +-
>  include/net/smc.h             |  32 ++-
>  include/uapi/linux/smc.h      |   3 +
>  include/uapi/linux/smc_diag.h |   2 +
>  net/smc/Kconfig               |  13 ++
>  net/smc/Makefile              |   2 +-
>  net/smc/af_smc.c              |  88 ++++++--
>  net/smc/smc.h                 |   7 +
>  net/smc/smc_cdc.c             |  56 ++++-
>  net/smc/smc_cdc.h             |   1 +
>  net/smc/smc_clc.c             |  64 ++++--
>  net/smc/smc_clc.h             |  10 +-
>  net/smc/smc_core.c            | 111 +++++++++-
>  net/smc/smc_core.h            |   9 +-
>  net/smc/smc_diag.c            |  11 +-
>  net/smc/smc_ism.c             | 100 ++++++---
>  net/smc/smc_ism.h             |  24 ++-
>  net/smc/smc_loopback.c        | 489 ++++++++++++++++++++++++++++++++++++++++++
>  net/smc/smc_loopback.h        |  54 +++++
>  net/smc/smc_pnet.c            |   4 +-
>  20 files changed, 996 insertions(+), 104 deletions(-)
>  create mode 100644 net/smc/smc_loopback.c
>  create mode 100644 net/smc/smc_loopback.h


Hello Wen Gu,

I applied and built your patches and noticed some things that you may want to consider in the next version:

Series should be split up [2]

Several lines exceed 80 columns [1][3]

'git clang-format HEAD~18' finds several formatting issues.
	Maybe not all of them need to be fixed.

codespell *.patch
0006-net-smc-extend-GID-to-128bits-only-for-virtual-ISM-d.patch:7: protocal ==> protocol

With your patches applied I get some new warnings [4]:
Seems there are some ntoh conversions missing

  CHECK   net/smc/af_smc.c
net/smc/af_smc.c:723:32: warning: cast to restricted __be64
net/smc/af_smc.c:1427:52: warning: cast to restricted __be64
  CHECK   net/smc/smc_pnet.c
  CHECK   net/smc/smc_ib.c
  CHECK   net/smc/smc_clc.c
net/smc/smc_clc.c:954:72: warning: incorrect type in argument 1 (different base types)
net/smc/smc_clc.c:954:72:    expected unsigned short [usertype] chid
net/smc/smc_clc.c:954:72:    got restricted __be16 [usertype] chid
net/smc/smc_clc.c:1050:29: warning: incorrect type in assignment (different base types)
net/smc/smc_clc.c:1050:29:    expected unsigned long long [usertype] gid
net/smc/smc_clc.c:1050:29:    got restricted __be64 [usertype]
net/smc/smc_clc.c:1051:31: warning: incorrect type in assignment (different base types)
net/smc/smc_clc.c:1051:31:    expected unsigned long long [usertype] token
net/smc/smc_clc.c:1051:31:    got restricted __be64 [usertype]


[1] linux/Documentation/process/coding-style.rst
[2] https://www.kernel.org/doc/html/v6.3/process/maintainer-netdev.html?highlight=network
[3] scripts/checkpatch.pl --strict --max-line-length=80 --git HEAD-18
[4] make C=2 CF=-D__CHECK_ENDIAN__ M=net/smc -Wunused-function -Wimplicit-fallthrough -Wincompatible-function-pointer-types-strict



When I installed the patches, I noticed that 
> smcd info
showed an SEID, even though I had no ISM device --> good


> smcd device
FID  Type  PCI-ID        PCHID  InUse  #LGs  PNET-ID
0000 0                   0000   Yes       2

This needs some improvements.., but I'm not sure what is the best way to display virtual smcd interfaces in the smc-tools.


I was able to do SMC transfers via the smcd-loopback feature :-D



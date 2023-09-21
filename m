Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7AF07AA646
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 03:01:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229799AbjIVBBn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 21:01:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjIVBBk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 21:01:40 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19F50F5;
        Thu, 21 Sep 2023 18:01:34 -0700 (PDT)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38M0EcJQ020151;
        Fri, 22 Sep 2023 00:30:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=6blrRc8iXSDrSIVcgYTn8uUAYP9uOU5xot1/K/YUonk=;
 b=kvBuLbxdRmH23oiKCNqpX4OM0jar0PIyBMEpbncnlk2D+G4UrCoSxpATGPsnyTauWqS8
 zg8yYF2OKmYshGfsJlukd7PS6abxGD6pps41lwdgwdDW3GA+lu8zxrkOPGlAnjie3q3s
 DAb1Tsv8N7IGnEnSnstPGxP3G9U1aHjcW7tyEyfxVMrDDCPIQit4mvm8a4V6ilItJzJV
 3WgNzPvsPT3bwhbxe9dp8uFW5wTvBZvEE6zxILE/8fjDZ7tDgCxu9hzarY1XcGdC6bAE
 n2UQx9C3hi7yjn/c0owXm2UeApom/7KrqmGYJhY6SIZsCbVuhgBwvfykjv2q/TSIzrLZ Ww== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3t8x1036y8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 22 Sep 2023 00:30:54 +0000
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 38M0G50K028261;
        Fri, 22 Sep 2023 00:30:54 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3t8x1036x9-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 22 Sep 2023 00:30:54 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
        by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 38LN8Kub025959;
        Thu, 21 Sep 2023 23:31:40 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
        by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3t8tspmraa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 21 Sep 2023 23:31:40 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
        by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 38LNVexj37290316
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Sep 2023 23:31:40 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 07BFF58059;
        Thu, 21 Sep 2023 23:31:40 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A1FAE58043;
        Thu, 21 Sep 2023 23:31:37 +0000 (GMT)
Received: from [9.171.4.137] (unknown [9.171.4.137])
        by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Thu, 21 Sep 2023 23:31:37 +0000 (GMT)
Message-ID: <be68eac1-f22e-1ff6-dbaf-8cbd09315454@linux.ibm.com>
Date:   Fri, 22 Sep 2023 01:31:36 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH net-next v3 00/18] net/smc: implement virtual ISM
 extension and loopback-ism
To:     Wen Gu <guwen@linux.alibaba.com>, kgraul@linux.ibm.com,
        jaka@linux.ibm.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com
Cc:     alibuda@linux.alibaba.com, tonylu@linux.alibaba.com,
        linux-s390@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1695302360-46691-1-git-send-email-guwen@linux.alibaba.com>
From:   Wenjia Zhang <wenjia@linux.ibm.com>
In-Reply-To: <1695302360-46691-1-git-send-email-guwen@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: ZEEhhL5cCgVJYhOpb7E3c5esWhKaXqyg
X-Proofpoint-GUID: KFGdPNz8uGdJ3w8AjAaT-gYwIIzDrI25
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-21_20,2023-09-21_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxlogscore=999
 mlxscore=0 phishscore=0 lowpriorityscore=0 impostorscore=0 suspectscore=0
 bulkscore=0 malwarescore=0 priorityscore=1501 clxscore=1015 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2309210209
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,NUMERIC_HTTP_ADDR,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 21.09.23 15:19, Wen Gu wrote:
> Hi, all
> 
> # Background
> 
> SMC-D is now used in IBM z with ISM function to optimize network interconnect
> for intra-CPC communications. Inspired by this, we try to make SMC-D available
> on the non-s390 architecture through a software-simulated virtual ISM device,
> such as loopback-ism device here, to accelerate inter-process or inter-containers
> communication within the same OS.
> 
> # Design
> 
> This patch set includes 4 parts:
> 
>   - Patch #1-#3: decouple ISM device hard code from SMC-D stack.
>   - Patch #4-#8: implement virtual ISM extension defined in SMCv2.1.
>   - Patch #9-#13: implement loopback-ism device.
>   - Patch #14-#18: memory copy optimization for the case using loopback.
> 
> The loopback-ism device is designed as a kernel device and not be limited to
> a specific net namespace, ends of both inter-process connection (1/1' in diagram
> below) or inter-container connection (2/2' in diagram below) will find that peer
> shares the same loopback-ism device during the CLC handshake. Then loopback-ism
> device will be chosen.
> 
>   Container 1 (ns1)                              Container 2 (ns2)
>   +-----------------------------------------+    +-------------------------+
>   | +-------+      +-------+      +-------+ |    |        +-------+        |
>   | | App A |      | App B |      | App C | |    |        | App D |<-+     |
>   | +-------+      +---^---+      +-------+ |    |        +-------+  |(2') |
>   |     |127.0.0.1 (1')|             |192.168.0.11       192.168.0.12|     |
>   |  (1)|   +--------+ | +--------+  |(2)   |    | +--------+   +--------+ |
>   |     `-->|   lo   |-` |  eth0  |<-`      |    | |   lo   |   |  eth0  | |
>   +---------+--|---^-+---+-----|--+---------+    +-+--------+---+-^------+-+
>                |   |           |                                  |
>   Kernel       |   |           |                                  |
>   +----+-------v---+-----------v----------------------------------+---+----+
>   |    |                            TCP                               |    |
>   |    |                                                              |    |
>   |    +--------------------------------------------------------------+    |
>   |                                                                        |
>   |                           +--------------+                             |
>   |                           | smc loopback |                             |
>   +---------------------------+--------------+-----------------------------+
> 
> 
> loopback-ism device allocs RMBs and sndbufs for each connection peer and 'moves'
> data from sndbuf at one end to RMB at the other end. Since communication occurs
> within the same kernel, the sndbuf can be mapped to peer RMB so that the data
> copy in loopback-ism case can be avoided.
> 
>   Container 1 (ns1)                              Container 2 (ns2)
>   +-----------------------------------------+    +-------------------------+
>   | +-------+      +-------+      +-------+ |    |        +-------+        |
>   | | App A |      | App B |      | App C | |    |        | App D |        |
>   | +-------+      +--^----+      +-------+ |    |        +---^---+        |
>   |       |           |               |     |    |            |            |
>   |   (1) |      (1') |           (2) |     |    |       (2') |            |
>   |       |           |               |     |    |            |            |
>   +-------|-----------|---------------|-----+    +------------|------------+
>           |           |               |                       |
>   Kernel  |           |               |                       |
>   +-------|-----------|---------------|-----------------------|------------+
>   | +-----v-+      +-------+      +---v---+               +-------+        |
>   | | snd A |-+    | RMB B |<--+  | snd C |-+          +->| RMB D |        |
>   | +-------+ |    +-------+   |  +-------+ |          |  +-------+        |
>   | +-------+ |    +-------+   |  +-------+ |          |  +-------+        |
>   | | RMB A | |    | snd B |   |  | RMB C | |          |  | snd D |        |
>   | +-------+ |    +-------+   |  +-------+ |          |  +-------+        |
>   |           |               +-------------v+         |                   |
>   |           +-------------->| smc loopback |---------+                   |
>   +---------------------------+--------------+-----------------------------+
> 
> # Benchmark Test
> 
>   * Test environments:
>        - VM with Intel Xeon Platinum 8 core 2.50GHz, 16 GiB mem.
>        - SMC sndbuf/RMB size 1MB.
> 
>   * Test object:
>        - TCP: run on TCP loopback.
>        - domain: run on UNIX domain.
>        - SMC lo: run on SMC loopback device.
> 
> 1. ipc-benchmark (see [1])
> 
>   - ./<foo> -c 1000000 -s 100
> 
>                         TCP              domain              SMC-lo
> Message
> rate (msg/s)         78855     107621(+36.41%)     153351(+94.47%)
> 
> 2. sockperf
> 
>   - serv: <smc_run> taskset -c <cpu> sockperf sr --tcp
>   - clnt: <smc_run> taskset -c <cpu> sockperf { tp | pp } --tcp --msg-size={ 64000 for tp | 14 for pp } -i 127.0.0.1 -t 30
> 
>                              TCP                  SMC-lo
> Bandwidth(MBps)        5169.250       8007.080(+54.89%)
> Latency(us)               6.122          3.174(-48.15%)
> 
> 3. nginx/wrk
> 
>   - serv: <smc_run> nginx
>   - clnt: <smc_run> wrk -t 8 -c 1000 -d 30 http://127.0.0.1:80
> 
>                             TCP                   SMC-lo
> Requests/s           197432.19       261056.09(+32.22%)
> 
> 4. redis-benchmark
> 
>   - serv: <smc_run> redis-server
>   - clnt: <smc_run> redis-benchmark -h 127.0.0.1 -q -t set,get -n 400000 -c 200 -d 1024
> 
>                             TCP                   SMC-lo
> GET(Requests/s)       86244.07       122025.62(+41.48%)
> SET(Requests/s)       86749.08       120048.02(+38.38%)
> 
> [1] https://github.com/goldsborough/ipc-bench
> 
> v2->v3:
>   - Fix build warning of patch#1 and patch#10.
> 
> v1->v2:
>   - Fix build error on s390 arch.
> 
> Wen Gu (18):
>    net/smc: decouple ism_dev from SMC-D device dump
>    net/smc: decouple ism_dev from SMC-D DMB registration
>    net/smc: extract v2 check helper from SMC-D device registration
>    net/smc: support SMCv2.x supplemental features negotiation
>    net/smc: reserve CHID range for SMC-D virtual device
>    net/smc: extend GID to 128bits for virtual ISM device
>    net/smc: disable SEID on non-s390 architecture
>    net/smc: enable virtual ISM device feature bit
>    net/smc: introduce SMC-D loopback device
>    net/smc: implement ID-related operations of loopback
>    net/smc: implement some unsupported operations of loopback
>    net/smc: implement DMB-related operations of loopback
>    net/smc: register loopback device as SMC-Dv2 device
>    net/smc: add operation for getting DMB attribute
>    net/smc: add operations for DMB attach and detach
>    net/smc: avoid data copy from sndbuf to peer RMB in SMC-D
>    net/smc: modify cursor update logic when sndbuf mapped to RMB
>    net/smc: add interface implementation of loopback device
> 
>   drivers/s390/net/ism_drv.c |  19 +-
>   include/net/smc.h          |  32 ++-
>   include/uapi/linux/smc.h   |   3 +
>   net/smc/Makefile           |   2 +-
>   net/smc/af_smc.c           |  73 +++++--
>   net/smc/smc.h              |   7 +
>   net/smc/smc_cdc.c          |  56 ++++--
>   net/smc/smc_cdc.h          |   1 +
>   net/smc/smc_clc.c          |  56 ++++--
>   net/smc/smc_clc.h          |  10 +-
>   net/smc/smc_core.c         | 108 +++++++++-
>   net/smc/smc_core.h         |   9 +-
>   net/smc/smc_diag.c         |   6 +-
>   net/smc/smc_ism.c          | 100 +++++++---
>   net/smc/smc_ism.h          |  24 ++-
>   net/smc/smc_loopback.c     | 483 +++++++++++++++++++++++++++++++++++++++++++++
>   net/smc/smc_loopback.h     |  52 +++++
>   net/smc/smc_pnet.c         |   4 +-
>   18 files changed, 946 insertions(+), 99 deletions(-)
>   create mode 100644 net/smc/smc_loopback.c
>   create mode 100644 net/smc/smc_loopback.h
> 

Hi Wen,

Thank you for the effort!
You can find my comments in the respective patches. One general question 
from our team, could you please add a Kconfig option to turn off/on 
loopback-ism?

BTW, I'm in vacation next week, my colleagues will follow on the answer 
and update.

Thanks,
Wenjia


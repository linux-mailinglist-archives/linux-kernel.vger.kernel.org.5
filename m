Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 834B67BA2CB
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 17:47:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234077AbjJEPrS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 11:47:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233532AbjJEPqc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 11:46:32 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A8AD8862;
        Thu,  5 Oct 2023 08:03:01 -0700 (PDT)
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 395ExjYd006794;
        Thu, 5 Oct 2023 15:02:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=YgYYgzYwO9PSxWqLIRQnBK4k7RetQefF9XdOzJSQoYc=;
 b=Wo1i9/ZmRfW+sOiV10vsxsaYC2jRqByRanJsB4FrEnZn9bx9PzoFf+uVU3oYGNJf2K5Q
 cqIAI9o+2h7qveiTI9VjL5eAoEwi0edPMBMDeRIjj21UO23MbKH6FAF/i280UuuzpMIR
 piw4jTA3pd7iB8a1Y06BL2rps7aUne+rPu8gxdKU+MCdwR1QSsiZzDQDByoehrUg8H5W
 H/BU7BYWW7pFf0vGpv5+osvAk7QAFqQ2kFiONNViyhy3Bb14l9Bj1K0bazOipMncyG2V
 nO8F8T2GX6AUsVNpv81JsNNDpSeUsSRU+XfyMmgzTl3o90+7K44mEOnCB9dqXGnmO/g4 Zg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3thy9q845k-69
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 05 Oct 2023 15:02:51 +0000
Received: from m0353722.ppops.net (m0353722.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 395A5MFL024567;
        Thu, 5 Oct 2023 10:31:57 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3thsaqcufv-154
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 05 Oct 2023 10:31:57 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
        by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3956oBos006684;
        Thu, 5 Oct 2023 08:21:07 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
        by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3tf07khqq6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 05 Oct 2023 08:21:07 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
        by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3958L4cY18940654
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 5 Oct 2023 08:21:04 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9E5902004B;
        Thu,  5 Oct 2023 08:21:04 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7114E20040;
        Thu,  5 Oct 2023 08:21:03 +0000 (GMT)
Received: from [9.171.88.212] (unknown [9.171.88.212])
        by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Thu,  5 Oct 2023 08:21:03 +0000 (GMT)
Message-ID: <dcc46fedda57e7e3ade14685ddb262309544ad7e.camel@linux.ibm.com>
Subject: Re: [PATCH net-next v4 00/18] net/smc: implement virtual ISM
 extension and loopback-ism
From:   Niklas Schnelle <schnelle@linux.ibm.com>
To:     Wen Gu <guwen@linux.alibaba.com>, kgraul@linux.ibm.com,
        wenjia@linux.ibm.com, jaka@linux.ibm.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Cc:     wintera@linux.ibm.com, gbayer@linux.ibm.com, pasic@linux.ibm.com,
        alibuda@linux.alibaba.com, tonylu@linux.alibaba.com,
        dust.li@linux.alibaba.com, linux-s390@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Thu, 05 Oct 2023 10:21:03 +0200
In-Reply-To: <1695568613-125057-1-git-send-email-guwen@linux.alibaba.com>
References: <1695568613-125057-1-git-send-email-guwen@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: WlOKwDSQ3j-4dmb_5lF51_EYmohTTJVy
X-Proofpoint-ORIG-GUID: XGcQ2sILzvao8M7KWvTeOWeqmLTjaIxY
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-05_08,2023-10-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 mlxlogscore=999 impostorscore=0 malwarescore=0 spamscore=0 phishscore=0
 clxscore=1015 suspectscore=0 lowpriorityscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2310050115
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NUMERIC_HTTP_ADDR,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2023-09-24 at 23:16 +0800, Wen Gu wrote:
> Hi, all
>=20
> # Background
>=20
> SMC-D is now used in IBM z with ISM function to optimize network intercon=
nect
> for intra-CPC communications. Inspired by this, we try to make SMC-D avai=
lable
> on the non-s390 architecture through a software-simulated virtual ISM dev=
ice,
> such as loopback-ism device here, to accelerate inter-process or inter-co=
ntainers
> communication within the same OS.
>=20
> # Design
>=20
> This patch set includes 4 parts:
>=20
>  - Patch #1-#3: decouple ISM device hard code from SMC-D stack.
>  - Patch #4-#8: implement virtual ISM extension defined in SMCv2.1.
>  - Patch #9-#13: implement loopback-ism device.
>  - Patch #14-#18: memory copy optimization for the case using loopback.
>=20
> The loopback-ism device is designed as a kernel device and not be limited=
 to
> a specific net namespace, ends of both inter-process connection (1/1' in =
diagram
> below) or inter-container connection (2/2' in diagram below) will find th=
at peer
> shares the same loopback-ism device during the CLC handshake. Then loopba=
ck-ism
> device will be chosen.
>=20
>  Container 1 (ns1)                              Container 2 (ns2)
>  +-----------------------------------------+    +------------------------=
-+
>  | +-------+      +-------+      +-------+ |    |        +-------+       =
 |
>  | | App A |      | App B |      | App C | |    |        | App D |<-+    =
 |
>  | +-------+      +---^---+      +-------+ |    |        +-------+  |(2')=
 |
>  |     |127.0.0.1 (1')|             |192.168.0.11       192.168.0.12|    =
 |
>  |  (1)|   +--------+ | +--------+  |(2)   |    | +--------+   +--------+=
 |
>  |     `-->|   lo   |-` |  eth0  |<-`      |    | |   lo   |   |  eth0  |=
 |
>  +---------+--|---^-+---+-----|--+---------+    +-+--------+---+-^------+=
-+
>               |   |           |                                  |
>  Kernel       |   |           |                                  |
>  +----+-------v---+-----------v----------------------------------+---+---=
-+
>  |    |                            TCP                               |   =
 |
>  |    |                                                              |   =
 |
>  |    +--------------------------------------------------------------+   =
 |
>  |                                                                       =
 |
>  |                           +--------------+                            =
 |
>  |                           | smc loopback |                            =
 |
>  +---------------------------+--------------+----------------------------=
-+
>=20
>=20
> loopback-ism device allocs RMBs and sndbufs for each connection peer and =
'moves'
> data from sndbuf at one end to RMB at the other end. Since communication =
occurs
> within the same kernel, the sndbuf can be mapped to peer RMB so that the =
data
> copy in loopback-ism case can be avoided.
>=20
>  Container 1 (ns1)                              Container 2 (ns2)
>  +-----------------------------------------+    +------------------------=
-+
>  | +-------+      +-------+      +-------+ |    |        +-------+       =
 |
>  | | App A |      | App B |      | App C | |    |        | App D |       =
 |
>  | +-------+      +--^----+      +-------+ |    |        +---^---+       =
 |
>  |       |           |               |     |    |            |           =
 |
>  |   (1) |      (1') |           (2) |     |    |       (2') |           =
 |
>  |       |           |               |     |    |            |           =
 |
>  +-------|-----------|---------------|-----+    +------------|-----------=
-+
>          |           |               |                       |
>  Kernel  |           |               |                       |
>  +-------|-----------|---------------|-----------------------|-----------=
-+
>  | +-----v-+      +-------+      +---v---+               +-------+       =
 |
>  | | snd A |-+    | RMB B |<--+  | snd C |-+          +->| RMB D |       =
 |
>  | +-------+ |    +-------+   |  +-------+ |          |  +-------+       =
 |
>  | +-------+ |    +-------+   |  +-------+ |          |  +-------+       =
 |
>  | | RMB A | |    | snd B |   |  | RMB C | |          |  | snd D |       =
 |
>  | +-------+ |    +-------+   |  +-------+ |          |  +-------+       =
 |
>  |           |               +-------------v+         |                  =
 |
>  |           +-------------->| smc loopback |---------+                  =
 |
>  +---------------------------+--------------+----------------------------=
-+
>=20
> # Benchmark Test
>=20
>  * Test environments:
>       - VM with Intel Xeon Platinum 8 core 2.50GHz, 16 GiB mem.
>       - SMC sndbuf/RMB size 1MB.
>=20
>  * Test object:
>       - TCP: run on TCP loopback.
>       - domain: run on UNIX domain.
>       - SMC lo: run on SMC loopback device.
>=20
> 1. ipc-benchmark (see [1])
>=20
>  - ./<foo> -c 1000000 -s 100
>=20
>                             TCP                  SMC-lo
> Message
> rate (msg/s)              81539                  151251(+85.50%)
>=20
> 2. sockperf
>=20
>  - serv: <smc_run> taskset -c <cpu> sockperf sr --tcp
>  - clnt: <smc_run> taskset -c <cpu> sockperf { tp | pp } --tcp --msg-size=
=3D{ 64000 for tp | 14 for pp } -i 127.0.0.1 -t 30
>=20
>                             TCP                  SMC-lo
> Bandwidth(MBps)         5313.66                 8270.51(+55.65%)
> Latency(us)               5.806                   3.207(-44.76%)
>=20
> 3. nginx/wrk
>=20
>  - serv: <smc_run> nginx
>  - clnt: <smc_run> wrk -t 8 -c 1000 -d 30 http://127.0.0.1:80
>=20
>                            TCP                   SMC-lo
> Requests/s           194641.79                258656.13(+32.89%)
>=20
> 4. redis-benchmark
>=20
>  - serv: <smc_run> redis-server
>  - clnt: <smc_run> redis-benchmark -h 127.0.0.1 -q -t set,get -n 400000 -=
c 200 -d 1024
>=20
>                            TCP                   SMC-lo
> GET(Requests/s)       85855.34                115640.35(+34.69%)
> SET(Requests/s)       86337.15                118203.30(+36.90%)
>=20
> [1] https://github.com/goldsborough/ipc-bench
>=20

Hi Wen Gu,

I've been trying out your series with iperf3, qperf, and uperf on
s390x. I'm using network namespaces with a ConnectX VF from the same
card in each namespace for the initial TCP/IP connection i.e. initially
it goes out to a real NIC even if that can switch internally. All of
these look great for streaming workloads both in terms of performance
and stability. With a Connect-Request-Response workload and uperf
however I've run into issues. The test configuration I use is as
follows:

Client Command:

# host=3D$ip_server ip netns exec client smc_run uperf -m tcp_crr.xml

Server Command:

# ip netns exec server smc_run uperf -s &> /dev/null

Uperf tcp_crr.xml:

<?xml version=3D"1.0"?>
<profile name=3D"TCP_CRR">
        <group nthreads=3D"12">
                <transaction duration=3D"120">
                        <flowop type=3D"connect" options=3D"remotehost=3D$h=
ost protocol=3Dtcp" />
                        <flowop type=3D"write" options=3D"size=3D200"/>
                        <flowop type=3D"read" options=3D"size=3D1000"/>
                        <flowop type=3D"disconnect" />
                </transaction>
        </group>
</profile>

The workload first runs fine but then after about 4 GB of data
transferred fails with "Connection refused" and "Connection reset by
peer" errors. The failure is not permanent however and re-running
the streaming workloads run fine again (with both uperf server and
client restarted). So I suspect something gets stuck in either the
client or server sockets. The same workload runs fine with TCP/IP of
course.

Thanks,
Niklas



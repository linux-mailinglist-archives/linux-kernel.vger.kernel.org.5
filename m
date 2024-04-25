Return-Path: <linux-kernel+bounces-158447-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 853A58B2045
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 13:31:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8062BB20A3C
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 11:31:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BDEF12AAD2;
	Thu, 25 Apr 2024 11:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Wc2s88kA"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D18112BEB8;
	Thu, 25 Apr 2024 11:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714044623; cv=none; b=J+YHZSRbMiRERmX7YjxRU5t0B+gc5Zu1QMzw+Ch11IynFHUGlC90N8W7bbUn63bKGop5stDgOUzLZg4PnYfUtp5XDE0tV3uIzrrciv0FxQgPA184AwuPR15iD9HIkXl7n0xljCmQEXbovv7dypBy/2i+defiYSdlVFuDQdCeUFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714044623; c=relaxed/simple;
	bh=7q84ME6y+fcBqveGSowGZRxGuw4P5y9oUZiGmbzNteI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Npz6kaDnTYmpILqoRj61kalWpofFxiL2X1PUeRIjI8QVD81Bgq92kMJeiUp1NjOxFdEZQE8wkwXnOcKBLMNllBbvij521ln4ftvAgz7nR/8Nxy0g2zHvK5jnKbcGZo9II7uNeHfh/xlekyRe4ZV7pJzWG14kWka+8rQf0oyHlp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Wc2s88kA; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43PBRJ3L025891;
	Thu, 25 Apr 2024 11:30:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=I6XGV3Vz8a3wGJnf0sY8yZgCD+7SDnIv+ElV1klFDKI=;
 b=Wc2s88kA8oSyNfr0DomTCiCAKg3nEu6kHHY+uEUYKRglegGtgMLVYyRvXzsBYeSe3qVc
 fOQGLjIMgPPZuM6kWtjbk8FKljc4cuVEIiWhaoLKdMdMZ5p+hqzlSjqBHjc+5JKKQBKE
 7E46WzbIrivT6bYqcA4Y4aAYHSRC357D74VUEB3LwltwuyyvbD6TKiroRPYLQgWVozn6
 Kf1J7l9D9uSyWwOpwoLykfgYgBF03M9xfjYUBCW0JLzJFEgeNafftNtIZgxd2/93L6rQ
 pe/4Ms2urR0suoRrKAODRJHOhnlY1VYufz6ZP11w2Y0pCn5sPRnV1LsTxW9rDlcHEaD8 mQ== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xqpagg0a9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Apr 2024 11:30:15 +0000
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 43PBUFvI031166;
	Thu, 25 Apr 2024 11:30:15 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xqpagg09x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Apr 2024 11:30:15 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 43P9tPcm005736;
	Thu, 25 Apr 2024 11:30:14 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3xmx3cr73y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Apr 2024 11:30:14 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 43PBUBTt23659080
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 25 Apr 2024 11:30:13 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 212C55808A;
	Thu, 25 Apr 2024 11:30:11 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5767D58089;
	Thu, 25 Apr 2024 11:30:08 +0000 (GMT)
Received: from [9.171.19.157] (unknown [9.171.19.157])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 25 Apr 2024 11:30:08 +0000 (GMT)
Message-ID: <defb2c4b-ddb7-4359-9e13-9f9b7723238f@linux.ibm.com>
Date: Thu, 25 Apr 2024 13:30:07 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v6 00/11] net/smc: SMC intra-OS shortcut with
 loopback-ism
Content-Language: en-GB
To: Wen Gu <guwen@linux.alibaba.com>, wintera@linux.ibm.com,
        twinkler@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com,
        agordeev@linux.ibm.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, jaka@linux.ibm.com
Cc: borntraeger@linux.ibm.com, svens@linux.ibm.com, alibuda@linux.alibaba.com,
        tonylu@linux.alibaba.com, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, netdev@vger.kernel.org
References: <20240414040304.54255-1-guwen@linux.alibaba.com>
From: Wenjia Zhang <wenjia@linux.ibm.com>
In-Reply-To: <20240414040304.54255-1-guwen@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: QTyECMJUpdD-vD6ivkttejOxzX5Hp93F
X-Proofpoint-ORIG-GUID: o7nbmZhOTiNgdm9g6gn0YU2LQAm69vgR
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-25_11,2024-04-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 lowpriorityscore=0 suspectscore=0 impostorscore=0 bulkscore=0 adultscore=0
 spamscore=0 malwarescore=0 clxscore=1015 mlxscore=0 mlxlogscore=999
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404250083



On 14.04.24 06:02, Wen Gu wrote:
> This patch set acts as the second part of the new version of [1] (The first
> part can be referred from [2]), the updated things of this version are listed
> at the end.
> 
> - Background
> 
> SMC-D is now used in IBM z with ISM function to optimize network interconnect
> for intra-CPC communications. Inspired by this, we try to make SMC-D available
> on the non-s390 architecture through a software-implemented Emulated-ISM device,
> that is the loopback-ism device here, to accelerate inter-process or
> inter-containers communication within the same OS instance.
> 
> - Design
> 
> This patch set includes 3 parts:
> 
>   - Patch #1: some prepare work for loopback-ism.
>   - Patch #2-#7: implement loopback-ism device and adapt SMC-D for it.
>     loopback-ism now serves only SMC and no userspace interfaces exposed.
>   - Patch #8-#11: memory copy optimization for intra-OS scenario.
> 
> The loopback-ism device is designed as an ISMv2 device and not be limited to
> a specific net namespace, ends of both inter-process connection (1/1' in diagram
> below) or inter-container connection (2/2' in diagram below) can find the same
> available loopback-ism and choose it during the CLC handshake.
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
> loopback-ism device creates DMBs (shared memory) for each connection peer.
> Since data transfer occurs within the same kernel, the sndbuf of each peer
> is only a descriptor and point to the same memory region as peer DMB, so that
> the data copy from sndbuf to peer DMB can be avoided in loopback-ism case.
> 
>   Container 1 (ns1)                              Container 2 (ns2)
>   +-----------------------------------------+    +-------------------------+
>   | +-------+                               |    |        +-------+        |
>   | | App C |-----+                         |    |        | App D |        |
>   | +-------+     |                         |    |        +-^-----+        |
>   |               |                         |    |          |              |
>   |           (2) |                         |    |     (2') |              |
>   |               |                         |    |          |              |
>   +---------------|-------------------------+    +----------|--------------+
>                   |                                         |
>   Kernel          |                                         |
>   +---------------|-----------------------------------------|--------------+
>   | +--------+ +--v-----+                           +--------+ +--------+  |
>   | |dmb_desc| |snd_desc|                           |dmb_desc| |snd_desc|  |
>   | +-----|--+ +--|-----+                           +-----|--+ +--------+  |
>   | +-----|--+    |                                 +-----|--+             |
>   | | DMB C  |    +---------------------------------| DMB D  |             |
>   | +--------+                                      +--------+             |
>   |                                                                        |
>   |                           +--------------+                             |
>   |                           | smc loopback |                             |
>   +---------------------------+--------------+-----------------------------+
> 
> - Benchmark Test
> 
>   * Test environments:
>        - VM with Intel Xeon Platinum 8 core 2.50GHz, 16 GiB mem.
>        - SMC sndbuf/DMB size 1MB.
> 
>   * Test object:
>        - TCP: run on TCP loopback.
>        - SMC lo: run on SMC loopback-ism.
> 
> 1. ipc-benchmark (see [3])
> 
>   - ./<foo> -c 1000000 -s 100
> 
>                              TCP                  SMC-lo
> Message
> rate (msg/s)              79693                  148236(+86.01%)
> 
> 2. sockperf
> 
>   - serv: <smc_run> sockperf sr --tcp
>   - clnt: <smc_run> sockperf { tp | pp } --tcp --msg-size={ 64000 for tp | 14 for pp } -i 127.0.0.1 -t 30
> 
>                              TCP                  SMC-lo
> Bandwidth(MBps)         4815.18                 8061.77(+67.42%)
> Latency(us)               6.176                   3.449(-44.15%)
> 
> 3. nginx/wrk
> 
>   - serv: <smc_run> nginx
>   - clnt: <smc_run> wrk -t 8 -c 1000 -d 30 http://127.0.0.1:80
> 
>                             TCP                   SMC-lo
> Requests/s           196555.02                263270.95(+33.94%)
> 
> 4. redis-benchmark
> 
>   - serv: <smc_run> redis-server
>   - clnt: <smc_run> redis-benchmark -h 127.0.0.1 -q -t set,get -n 400000 -c 200 -d 1024
> 
>                             TCP                   SMC-lo
> GET(Requests/s)       88711.47                120048.02(+35.32%)
> SET(Requests/s)       89465.44                123152.71(+37.65%)
> 
> 
> Change log:
> 
> v6->RFC v5
> - Patch #2: make the use of CONFIG_SMC_LO cleaner.
> - Patch #5: mark some smcd_ops that loopback-ism doesn't support as
>    optional and check for the support when they are called.
> - Patch #7: keep loopback-ism at the beginning of the SMC-D device list.
> - Some expression changes in commit logs and comments.
> 
> RFC v5->RFC v4:
> Link: https://lore.kernel.org/netdev/20240324135522.108564-1-guwen@linux.alibaba.com/
> - Patch #2: minor changes in description of config SMC_LO and comments.
> - Patch #10: minor changes in comments and if(smc_ism_support_dmb_nocopy())
>    check in smcd_cdc_msg_send().
> - Patch #3: change smc_lo_generate_id() to smc_lo_generate_ids() and SMC_LO_CHID
>    to SMC_LO_RESERVED_CHID.
> - Patch #5: memcpy while holding the ldev->dmb_ht_lock.
> - Some expression changes in commit logs.
> 
> RFC v4->v3:
> Link: https://lore.kernel.org/netdev/20240317100545.96663-1-guwen@linux.alibaba.com/
> - The merge window of v6.9 is open, so post this series as an RFC.
> - Patch #6: since some information fed back by smc_nl_handle_smcd_dev() dose
>    not apply to Emulated-ISM (including loopback-ism here), loopback-ism is
>    not exposed through smc netlink for the time being. we may refactor this
>    part when smc netlink interface is updated.
> 
> v3->v2:
> Link: https://lore.kernel.org/netdev/20240312142743.41406-1-guwen@linux.alibaba.com/
> - Patch #11: use tasklet_schedule(&conn->rx_tsklet) instead of smcd_cdc_rx_handler()
>    to avoid possible recursive locking of conn->send_lock and use {read|write}_lock_bh()
>    to acquire dmb_ht_lock.
> 
> v2->v1:
> Link: https://lore.kernel.org/netdev/20240307095536.29648-1-guwen@linux.alibaba.com/
> - All the patches: changed the term virtual-ISM to Emulated-ISM as defined by SMCv2.1.
> - Patch #3: optimized the description of SMC_LO config. Avoid exposing loopback-ism
>    to sysfs and remove all the knobs until future definition clear.
> - Patch #3: try to make lockdep happy by using read_lock_bh() in smc_lo_move_data().
> - Patch #6: defaultly use physical contiguous DMB buffers.
> - Patch #11: defaultly enable DMB no-copy for loopback-ism and free the DMB in
>    unregister_dmb or detach_dmb when dmb_node->refcnt reaches 0, instead of using
>    wait_event to keep waiting in unregister_dmb.
> 
> v1->RFC:
> Link: https://lore.kernel.org/netdev/20240111120036.109903-1-guwen@linux.alibaba.com/
> - Patch #9: merge rx_bytes and tx_bytes as xfer_bytes statistics:
>    /sys/devices/virtual/smc/loopback-ism/xfer_bytes
> - Patch #10: add support_dmb_nocopy operation to check if SMC-D device supports
>    merging sndbuf with peer DMB.
> - Patch #13 & #14: introduce loopback-ism device control of DMB memory type and
>    control of whether to merge sndbuf and DMB. They can be respectively set by:
>    /sys/devices/virtual/smc/loopback-ism/dmb_type
>    /sys/devices/virtual/smc/loopback-ism/dmb_copy
>    The motivation for these two control is that a performance bottleneck was
>    found when using vzalloced DMB and sndbuf is merged with DMB, and there are
>    many CPUs and CONFIG_HARDENED_USERCOPY is set [4]. The bottleneck is caused
>    by the lock contention in vmap_area_lock [5] which is involved in memcpy_from_msg()
>    or memcpy_to_msg(). Currently, Uladzislau Rezki is working on mitigating the
>    vmap lock contention [6]. It has significant effects, but using virtual memory
>    still has additional overhead compared to using physical memory.
>    So this new version provides controls of dmb_type and dmb_copy to suit
>    different scenarios.
> - Some minor changes and comments improvements.
> 
> RFC->old version([1]):
> Link: https://lore.kernel.org/netdev/1702214654-32069-1-git-send-email-guwen@linux.alibaba.com/
> - Patch #1: improve the loopback-ism dump, it shows as follows now:
>    # smcd d
>    FID  Type  PCI-ID        PCHID  InUse  #LGs  PNET-ID
>    0000 0     loopback-ism  ffff   No        0
> - Patch #3: introduce the smc_ism_set_v2_capable() helper and set
>    smc_ism_v2_capable when ISMv2 or virtual ISM is registered,
>    regardless of whether there is already a device in smcd device list.
> - Patch #3: loopback-ism will be added into /sys/devices/virtual/smc/loopback-ism/.
> - Patch #8: introduce the runtime switch /sys/devices/virtual/smc/loopback-ism/active
>    to activate or deactivate the loopback-ism.
> - Patch #9: introduce the statistics of loopback-ism by
>    /sys/devices/virtual/smc/loopback-ism/{{tx|rx}_tytes|dmbs_cnt}.
> - Some minor changes and comments improvements.
> 
> [1] https://lore.kernel.org/netdev/1695568613-125057-1-git-send-email-guwen@linux.alibaba.com/
> [2] https://lore.kernel.org/netdev/20231219142616.80697-1-guwen@linux.alibaba.com/
> [3] https://github.com/goldsborough/ipc-bench
> [4] https://lore.kernel.org/all/3189e342-c38f-6076-b730-19a6efd732a5@linux.alibaba.com/
> [5] https://lore.kernel.org/all/238e63cd-e0e8-4fbf-852f-bc4d5bc35d5a@linux.alibaba.com/
> [6] https://lore.kernel.org/all/20240102184633.748113-1-urezki@gmail.com/
> 
> Wen Gu (11):
>    net/smc: decouple ism_client from SMC-D DMB registration
>    net/smc: introduce loopback-ism for SMC intra-OS shortcut
>    net/smc: implement ID-related operations of loopback-ism
>    net/smc: implement DMB-related operations of loopback-ism
>    net/smc: mark optional smcd_ops and check for support when called
>    net/smc: ignore loopback-ism when dumping SMC-D devices
>    net/smc: register loopback-ism into SMC-D device list
>    net/smc: add operations to merge sndbuf with peer DMB
>    net/smc: {at|de}tach sndbuf to peer DMB if supported
>    net/smc: adapt cursor update when sndbuf and peer DMB are merged
>    net/smc: implement DMB-merged operations of loopback-ism
> 
>   drivers/s390/net/ism_drv.c |   2 +-
>   include/net/smc.h          |  21 +-
>   net/smc/Kconfig            |  13 ++
>   net/smc/Makefile           |   1 +
>   net/smc/af_smc.c           |  28 ++-
>   net/smc/smc_cdc.c          |  34 ++-
>   net/smc/smc_core.c         |  61 +++++-
>   net/smc/smc_core.h         |   1 +
>   net/smc/smc_ism.c          |  88 ++++++--
>   net/smc/smc_ism.h          |  10 +
>   net/smc/smc_loopback.c     | 427 +++++++++++++++++++++++++++++++++++++
>   net/smc/smc_loopback.h     |  62 ++++++
>   12 files changed, 721 insertions(+), 27 deletions(-)
>   create mode 100644 net/smc/smc_loopback.c
>   create mode 100644 net/smc/smc_loopback.h
> 

Hi Wen,

They look good to me. Thank you again for the effort and the patience!

Here is my reviewed-by for the whole patches series:
Reviewed-by: Wenjia Zhang <wenjia@linux.ibm.com>

Thanks,
Wenjia


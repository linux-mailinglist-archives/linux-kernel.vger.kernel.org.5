Return-Path: <linux-kernel+bounces-95270-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 478DC874B92
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 10:59:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 92860B2389B
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 09:59:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0B8212BF0B;
	Thu,  7 Mar 2024 09:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="II/qh+bD"
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B02885274;
	Thu,  7 Mar 2024 09:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709805352; cv=none; b=fWhzt5IEh+4dkniBJE+HIpHWAB9tm4s+GKh9IxycY0NDrrvldkIt+39NeZFghTiQRzbV8noNa4E+EZZQEQdYBFIZuA0j3aRzHpk9zhJwtykw0Xijgi8sfJ1r584LbCimdKxpe0DyDiohACoZJTIJ2IhtQzQFX7r5rvZRt3CIzRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709805352; c=relaxed/simple;
	bh=Y706E7+wSwhpUpSD+ADfvCTxNz2v6+Eha2xgKpULnwI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=g5jI9R38P/XGmpNkQFo9cGbLOJsXLSpPmy2bPKf3J6cPA1sSTTl89Q3hF823zYbpXx99Ivq5YS+LPlAK6XYKxUflWNF/Tb81D1+7dRkjPwydEJWqSMg/z/PvbdV0cVUyfB49BIct77vWHgGMzcqCSjQhBvHnkLVQIdCbhYxRET8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=II/qh+bD; arc=none smtp.client-ip=115.124.30.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1709805340; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=fBaq6BITkcfyNDc5Epq7WVlMR7CHOylhALsk2kShEKY=;
	b=II/qh+bDvrxrUxWV1C3JC7oDjJZCwh0z9pMdh73a2AnWOVyxHSIneEdzQWTDCdRpYOomlMJsTavhMAwQOZSftJMHHBwbst2WqRi/qhW+KM8+4oK1WnHgqK9pZs0+aR4BifZsSpCTMmqZejlbIGUO1fzfeycRn1CspqWQq6NPvHA=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=guwen@linux.alibaba.com;NM=1;PH=DS;RN=19;SR=0;TI=SMTPD_---0W2-G9yn_1709805336;
Received: from localhost(mailfrom:guwen@linux.alibaba.com fp:SMTPD_---0W2-G9yn_1709805336)
          by smtp.aliyun-inc.com;
          Thu, 07 Mar 2024 17:55:40 +0800
From: Wen Gu <guwen@linux.alibaba.com>
To: wintera@linux.ibm.com,
	twinkler@linux.ibm.com,
	hca@linux.ibm.com,
	gor@linux.ibm.com,
	agordeev@linux.ibm.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	wenjia@linux.ibm.com,
	jaka@linux.ibm.com
Cc: borntraeger@linux.ibm.com,
	svens@linux.ibm.com,
	alibuda@linux.alibaba.com,
	tonylu@linux.alibaba.com,
	guwen@linux.alibaba.com,
	linux-kernel@vger.kernel.org,
	linux-s390@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH net-next v2 00/11] net/smc: SMC intra-OS shortcut with loopback-ism
Date: Thu,  7 Mar 2024 17:55:25 +0800
Message-Id: <20240307095536.29648-1-guwen@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch set acts as the second part of the new version of [1] (The first
part can be referred from [2]), the updated things of this version are listed
at the end.

- Background

SMC-D is now used in IBM z with ISM function to optimize network interconnect
for intra-CPC communications. Inspired by this, we try to make SMC-D available
on the non-s390 architecture through a software-implemented Emulated-ISM device,
that is the loopback-ism device here, to accelerate inter-process or
inter-containers communication within the same OS instance.

- Design

This patch set includes 3 parts:

 - Patch #1-#2: some prepare work for loopback-ism.
 - Patch #3-#7: implement loopback-ism device. Noted that loopback-ism now
   serves only SMC and no userspace interface exposed.
 - Patch #10-#15: memory copy optimization for intra-OS scenario.

The loopback-ism device is designed as an ISMv2 device and not be limited to
a specific net namespace, ends of both inter-process connection (1/1' in diagram
below) or inter-container connection (2/2' in diagram below) can find the same
available loopback-ism and choose it during the CLC handshake.

 Container 1 (ns1)                              Container 2 (ns2)
 +-----------------------------------------+    +-------------------------+
 | +-------+      +-------+      +-------+ |    |        +-------+        |
 | | App A |      | App B |      | App C | |    |        | App D |<-+     |
 | +-------+      +---^---+      +-------+ |    |        +-------+  |(2') |
 |     |127.0.0.1 (1')|             |192.168.0.11       192.168.0.12|     |
 |  (1)|   +--------+ | +--------+  |(2)   |    | +--------+   +--------+ |
 |     `-->|   lo   |-` |  eth0  |<-`      |    | |   lo   |   |  eth0  | |
 +---------+--|---^-+---+-----|--+---------+    +-+--------+---+-^------+-+
              |   |           |                                  |
 Kernel       |   |           |                                  |
 +----+-------v---+-----------v----------------------------------+---+----+
 |    |                            TCP                               |    |
 |    |                                                              |    |
 |    +--------------------------------------------------------------+    |
 |                                                                        |
 |                           +--------------+                             |
 |                           | smc loopback |                             |
 +---------------------------+--------------+-----------------------------+

loopback-ism device creates DMBs (shared memory) for each connection peer.
Since data transfer occurs within the same kernel, the sndbuf of each peer
is only a descriptor and point to the same memory region as peer DMB, so that
the data copy from sndbuf to peer DMB can be avoided in loopback-ism case.

 Container 1 (ns1)                              Container 2 (ns2)
 +-----------------------------------------+    +-------------------------+
 | +-------+                               |    |        +-------+        |
 | | App C |-----+                         |    |        | App D |        |
 | +-------+     |                         |    |        +-^-----+        |
 |               |                         |    |          |              |
 |           (2) |                         |    |     (2') |              |
 |               |                         |    |          |              |
 +---------------|-------------------------+    +----------|--------------+
                 |                                         |
 Kernel          |                                         |
 +---------------|-----------------------------------------|--------------+
 | +--------+ +--v-----+                           +--------+ +--------+  |
 | |dmb_desc| |snd_desc|                           |dmb_desc| |snd_desc|  |
 | +-----|--+ +--|-----+                           +-----|--+ +--------+  |
 | +-----|--+    |                                 +-----|--+             |
 | | DMB C  |    +---------------------------------| DMB D  |             |
 | +--------+                                      +--------+             |
 |                                                                        |
 |                           +--------------+                             |
 |                           | smc loopback |                             |
 +---------------------------+--------------+-----------------------------+

- Benchmark Test

 * Test environments:
      - VM with Intel Xeon Platinum 8 core 2.50GHz, 16 GiB mem.
      - SMC sndbuf/DMB size 1MB.

 * Test object:
      - TCP: run on TCP loopback.
      - SMC lo: run on SMC loopback-ism.

1. ipc-benchmark (see [3])

 - ./<foo> -c 1000000 -s 100

                            TCP                  SMC-lo
Message
rate (msg/s)              79287                  148946(+87.86%)

2. sockperf

 - serv: <smc_run> taskset -c <cpu> sockperf sr --tcp
 - clnt: <smc_run> taskset -c <cpu> sockperf { tp | pp } --tcp --msg-size={ 64000 for tp | 14 for pp } -i 127.0.0.1 -t 30

                            TCP                  SMC-lo
Bandwidth(MBps)         5053.47                 8195.07(+62.17%)
Latency(us)               6.108                   3.404(-44.27%)

3. nginx/wrk

 - serv: <smc_run> nginx
 - clnt: <smc_run> wrk -t 8 -c 1000 -d 30 http://127.0.0.1:80

                           TCP                   SMC-lo
Requests/s           178187.56                247970.92(+39.16%)

4. redis-benchmark

 - serv: <smc_run> redis-server
 - clnt: <smc_run> redis-benchmark -h 127.0.0.1 -q -t set,get -n 400000 -c 200 -d 1024

                           TCP                   SMC-lo
GET(Requests/s)       89067.02                123877.36(+39.08%)
SET(Requests/s)       87700.07                131319.77(+49.73%)


Change log:

v2->v1:
- All the patches: changed the term virtual-ISM to Emulated-ISM as defined by SMCv2.1.
- Patch #3: optimized the description of SMC_LO config. Avoid exposing loopback-ism
  to sysfs and remove all the knobs until future definition clear.
- Patch #3: try to make lockdep happy by using read_lock_bh() in smc_lo_move_data().
- Patch #6: defaultly use physical contiguous DMB buffers.
- Patch #11: defaultly enable DMB no-copy for loopback-ism and free the DMB in
  unregister_dmb or detach_dmb when dmb_node->refcnt reaches 0, instead of using
  wait_event to keep waiting in unregister_dmb.

v1->RFC:
- Patch #9: merge rx_bytes and tx_bytes as xfer_bytes statistics:
  /sys/devices/virtual/smc/loopback-ism/xfer_bytes
- Patch #10: add support_dmb_nocopy operation to check if SMC-D device supports
  merging sndbuf with peer DMB.
- Patch #13 & #14: introduce loopback-ism device control of DMB memory type and
  control of whether to merge sndbuf and DMB. They can be respectively set by:
  /sys/devices/virtual/smc/loopback-ism/dmb_type
  /sys/devices/virtual/smc/loopback-ism/dmb_copy
  The motivation for these two control is that a performance bottleneck was
  found when using vzalloced DMB and sndbuf is merged with DMB, and there are
  many CPUs and CONFIG_HARDENED_USERCOPY is set [4]. The bottleneck is caused
  by the lock contention in vmap_area_lock [5] which is involved in memcpy_from_msg()
  or memcpy_to_msg(). Currently, Uladzislau Rezki is working on mitigating the
  vmap lock contention [6]. It has significant effects, but using virtual memory
  still has additional overhead compared to using physical memory.
  So this new version provides controls of dmb_type and dmb_copy to suit
  different scenarios.
- Some minor changes and comments improvements.

RFC->old version([1]):
Link: https://lore.kernel.org/netdev/1702214654-32069-1-git-send-email-guwen@linux.alibaba.com/
- Patch #1: improve the loopback-ism dump, it shows as follows now:
  # smcd d
  FID  Type  PCI-ID        PCHID  InUse  #LGs  PNET-ID
  0000 0     loopback-ism  ffff   No        0
- Patch #3: introduce the smc_ism_set_v2_capable() helper and set
  smc_ism_v2_capable when ISMv2 or virtual ISM is registered,
  regardless of whether there is already a device in smcd device list.
- Patch #3: loopback-ism will be added into /sys/devices/virtual/smc/loopback-ism/.
- Patch #8: introduce the runtime switch /sys/devices/virtual/smc/loopback-ism/active
  to activate or deactivate the loopback-ism.
- Patch #9: introduce the statistics of loopback-ism by
  /sys/devices/virtual/smc/loopback-ism/{{tx|rx}_tytes|dmbs_cnt}.
- Some minor changes and comments improvements.

[1] https://lore.kernel.org/netdev/1695568613-125057-1-git-send-email-guwen@linux.alibaba.com/
[2] https://lore.kernel.org/netdev/20231219142616.80697-1-guwen@linux.alibaba.com/
[3] https://github.com/goldsborough/ipc-bench
[4] https://lore.kernel.org/all/3189e342-c38f-6076-b730-19a6efd732a5@linux.alibaba.com/
[5] https://lore.kernel.org/all/238e63cd-e0e8-4fbf-852f-bc4d5bc35d5a@linux.alibaba.com/
[6] https://lore.kernel.org/all/20240102184633.748113-1-urezki@gmail.com/

Wen Gu (11):
  net/smc: adapt SMC-D device dump for Emulated-ISM
  net/smc: decouple ism_client from SMC-D DMB registration
  net/smc: introduce loopback-ism for SMC intra-OS shortcut
  net/smc: implement ID-related operations of loopback-ism
  net/smc: implement some unsupported operations of loopback-ism
  net/smc: implement DMB-related operations of loopback-ism
  net/smc: register loopback-ism into SMC-D device list
  net/smc: add operations to merge sndbuf with peer DMB
  net/smc: attach or detach ghost sndbuf to peer DMB
  net/smc: adapt cursor update when sndbuf and peer DMB are merged
  net/smc: implement DMB-merged operations of loopback-ism

 drivers/s390/net/ism_drv.c |   2 +-
 include/net/smc.h          |   7 +-
 net/smc/Kconfig            |  13 +
 net/smc/Makefile           |   2 +-
 net/smc/af_smc.c           |  28 ++-
 net/smc/smc_cdc.c          |  58 ++++-
 net/smc/smc_cdc.h          |   1 +
 net/smc/smc_core.c         |  61 ++++-
 net/smc/smc_core.h         |   1 +
 net/smc/smc_ism.c          |  71 +++++-
 net/smc/smc_ism.h          |   5 +
 net/smc/smc_loopback.c     | 469 +++++++++++++++++++++++++++++++++++++
 net/smc/smc_loopback.h     |  52 ++++
 13 files changed, 741 insertions(+), 29 deletions(-)
 create mode 100644 net/smc/smc_loopback.c
 create mode 100644 net/smc/smc_loopback.h

-- 
2.32.0.3.g01195cf9f



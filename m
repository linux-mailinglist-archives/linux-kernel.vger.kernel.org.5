Return-Path: <linux-kernel+bounces-72295-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1532185B1B7
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 04:52:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C05F02827C3
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 03:52:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93BA856759;
	Tue, 20 Feb 2024 03:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="EI+SvDv3"
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF81B51037;
	Tue, 20 Feb 2024 03:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708401131; cv=none; b=frF8CXnNz1Yo8nqkPeDRSb8vT3qYfSCa8m93AeNjJm+LrGW7rRPb0Et67iuDdeagDtbVkw5uTqy/5T1JhYz8dWAuwwiRv4waCi9fvVZ7xIdxmSZxPkSzncibTa/ZSnM6ebUeEbEtvRG3bv3QZC2PwvPbW3WAEGUtmVXdjpz3syk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708401131; c=relaxed/simple;
	bh=0aZtum7GpJTK5e070oGcznr1ZLszEjCXaTCDzai2tQ4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=c5ANijdoTE3XrnjsxdVOKjDvVZLa/giLBAdMlJ6mbKSVMFY6y/gKAKNBZfhr9WLy4km+MCVVTNeOFLBKS7HmwlSXPX9bNVENwOwM04cDa2O5+pw47htEn7yaJocOMH0sVghFBXSN2wYNOHqUcQqg/792GKpTsRku/4Q8hfCVt+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=EI+SvDv3; arc=none smtp.client-ip=115.124.30.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1708401124; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=fU4Qo0bzDFl5Fs696AJax4gvvhphfr2U/1MPyEfkvTM=;
	b=EI+SvDv3MNO1zYrvt6pCD7d+MG1b0g/8LmvsQ3JqicwNPnzN27fE7d5JBDYl3xpvC2zmmO1ifTNn9EnBY50Eo5M4GVvv4nGlZmTplQsoht0MCz+ZFKiBE56iuGQHc9G/lZfaCDGkCgA7NKFx/FP6uulQ0PzBKAdIHfzF4p03Ky4=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=guwen@linux.alibaba.com;NM=1;PH=DS;RN=18;SR=0;TI=SMTPD_---0W0vCOJs_1708401122;
Received: from 30.221.128.233(mailfrom:guwen@linux.alibaba.com fp:SMTPD_---0W0vCOJs_1708401122)
          by smtp.aliyun-inc.com;
          Tue, 20 Feb 2024 11:52:04 +0800
Message-ID: <375c613e-a7ee-4ef0-8d41-3f87ae8cccea@linux.alibaba.com>
Date: Tue, 20 Feb 2024 11:52:02 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 00/15] net/smc: implement loopback-ism used by
 SMC-D
To: Wenjia Zhang <wenjia@linux.ibm.com>, wintera@linux.ibm.com,
 hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, jaka@linux.ibm.com, Gerd Bayer <gbayer@linux.ibm.com>
Cc: borntraeger@linux.ibm.com, svens@linux.ibm.com,
 alibuda@linux.alibaba.com, tonylu@linux.alibaba.com,
 linux-s390@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240111120036.109903-1-guwen@linux.alibaba.com>
 <76b53c2d-5596-44da-b759-e5e94571d401@linux.ibm.com>
From: Wen Gu <guwen@linux.alibaba.com>
In-Reply-To: <76b53c2d-5596-44da-b759-e5e94571d401@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2024/2/16 22:09, Wenjia Zhang wrote:
> 
> 
> On 11.01.24 13:00, Wen Gu wrote:
>> This patch set acts as the second part of the new version of [1] (The first
>> part can be referred from [2]), the updated things of this version are listed
>> at the end.
>>
>> # Background
>>
>> SMC-D is now used in IBM z with ISM function to optimize network interconnect
>> for intra-CPC communications. Inspired by this, we try to make SMC-D available
>> on the non-s390 architecture through a software-implemented virtual ISM device,
>> that is the loopback-ism device here, to accelerate inter-process or
>> inter-containers communication within the same OS instance.
>>
>> # Design
>>
>> This patch set includes 3 parts:
>>
>>   - Patch #1-#2: some prepare work for loopback-ism.
>>   - Patch #3-#9: implement loopback-ism device.
>>   - Patch #10-#15: memory copy optimization for loopback scenario.
>>
>> The loopback-ism device is designed as a ISMv2 device and not be limited to
>> a specific net namespace, ends of both inter-process connection (1/1' in diagram
>> below) or inter-container connection (2/2' in diagram below) can find the same
>> available loopback-ism and choose it during the CLC handshake.
>>
>>   Container 1 (ns1)                              Container 2 (ns2)
>>   +-----------------------------------------+    +-------------------------+
>>   | +-------+      +-------+      +-------+ |    |        +-------+        |
>>   | | App A |      | App B |      | App C | |    |        | App D |<-+     |
>>   | +-------+      +---^---+      +-------+ |    |        +-------+  |(2') |
>>   |     |127.0.0.1 (1')|             |192.168.0.11       192.168.0.12|     |
>>   |  (1)|   +--------+ | +--------+  |(2)   |    | +--------+   +--------+ |
>>   |     `-->|   lo   |-` |  eth0  |<-`      |    | |   lo   |   |  eth0  | |
>>   +---------+--|---^-+---+-----|--+---------+    +-+--------+---+-^------+-+
>>                |   |           |                                  |
>>   Kernel       |   |           |                                  |
>>   +----+-------v---+-----------v----------------------------------+---+----+
>>   |    |                            TCP                               |    |
>>   |    |                                                              |    |
>>   |    +--------------------------------------------------------------+    |
>>   |                                                                        |
>>   |                           +--------------+                             |
>>   |                           | smc loopback |                             |
>>   +---------------------------+--------------+-----------------------------+
>>
>> loopback-ism device creates DMBs (shared memory) for each connection peer.
>> Since data transfer occurs within the same kernel, the sndbuf of each peer
>> is only a descriptor and point to the same memory region as peer DMB, so that
>> the data copy from sndbuf to peer DMB can be avoided in loopback-ism case.
>>
>>   Container 1 (ns1)                              Container 2 (ns2)
>>   +-----------------------------------------+    +-------------------------+
>>   | +-------+                               |    |        +-------+        |
>>   | | App C |-----+                         |    |        | App D |        |
>>   | +-------+     |                         |    |        +-^-----+        |
>>   |               |                         |    |          |              |
>>   |           (2) |                         |    |     (2') |              |
>>   |               |                         |    |          |              |
>>   +---------------|-------------------------+    +----------|--------------+
>>                   |                                         |
>>   Kernel          |                                         |
>>   +---------------|-----------------------------------------|--------------+
>>   | +--------+ +--v-----+                           +--------+ +--------+  |
>>   | |dmb_desc| |snd_desc|                           |dmb_desc| |snd_desc|  |
>>   | +-----|--+ +--|-----+                           +-----|--+ +--------+  |
>>   | +-----|--+    |                                 +-----|--+             |
>>   | | DMB C  |    +---------------------------------| DMB D  |             |
>>   | +--------+                                      +--------+             |
>>   |                                                                        |
>>   |                           +--------------+                             |
>>   |                           | smc loopback |                             |
>>   +---------------------------+--------------+-----------------------------+
>>
>> # Benchmark Test
>>
>>   * Test environments:
>>        - VM with Intel Xeon Platinum 8 core 2.50GHz, 16 GiB mem.
>>        - SMC sndbuf/DMB size 1MB.
>>        - /sys/devices/virtual/smc/loopback-ism/dmb_copy is set to default 0,
>>          which means sndbuf and DMB are merged and no data copied between them.
>>        - /sys/devices/virtual/smc/loopback-ism/dmb_type is set to default 0,
>>          which means DMB is physically contiguous buffer.
>>
>>   * Test object:
>>        - TCP: run on TCP loopback.
>>        - SMC lo: run on SMC loopback device.
>>
>> 1. ipc-benchmark (see [3])
>>
>>   - ./<foo> -c 1000000 -s 100
>>
>>                              TCP                  SMC-lo
>> Message
>> rate (msg/s)              80636                  149515(+85.42%)
>>
>> 2. sockperf
>>
>>   - serv: <smc_run> taskset -c <cpu> sockperf sr --tcp
>>   - clnt: <smc_run> taskset -c <cpu> sockperf { tp | pp } --tcp --msg-size={ 64000 for tp | 14 for pp } -i 127.0.0.1 
>> -t 30
>>
>>                              TCP                  SMC-lo
>> Bandwidth(MBps)         4909.36                 8197.57(+66.98%)
>> Latency(us)               6.098                   3.383(-44.52%)
>>
>> 3. nginx/wrk
>>
>>   - serv: <smc_run> nginx
>>   - clnt: <smc_run> wrk -t 8 -c 1000 -d 30 http://127.0.0.1:80
>>
>>                             TCP                   SMC-lo
>> Requests/s           181685.74                246447.77(+35.65%)
>>
>> 4. redis-benchmark
>>
>>   - serv: <smc_run> redis-server
>>   - clnt: <smc_run> redis-benchmark -h 127.0.0.1 -q -t set,get -n 400000 -c 200 -d 1024
>>
>>                             TCP                   SMC-lo
>> GET(Requests/s)       85855.34                118553.64(+38.09%)
>> SET(Requests/s)       86824.40                125944.58(+45.06%)
>>
>>
>> Change log:
>>
>> v1->RFC:
>> - Patch #9: merge rx_bytes and tx_bytes as xfer_bytes statistics:
>>    /sys/devices/virtual/smc/loopback-ism/xfer_bytes
>> - Patch #10: add support_dmb_nocopy operation to check if SMC-D device supports
>>    merging sndbuf with peer DMB.
>> - Patch #13 & #14: introduce loopback-ism device control of DMB memory type and
>>    control of whether to merge sndbuf and DMB. They can be respectively set by:
>>    /sys/devices/virtual/smc/loopback-ism/dmb_type
>>    /sys/devices/virtual/smc/loopback-ism/dmb_copy
>>    The motivation for these two control is that a performance bottleneck was
>>    found when using vzalloced DMB and sndbuf is merged with DMB, and there are
>>    many CPUs and CONFIG_HARDENED_USERCOPY is set [4]. The bottleneck is caused
>>    by the lock contention in vmap_area_lock [5] which is involved in memcpy_from_msg()
>>    or memcpy_to_msg(). Currently, Uladzislau Rezki is working on mitigating the
>>    vmap lock contention [6]. It has significant effects, but using virtual memory
>>    still has additional overhead compared to using physical memory.
>>    So this new version provides controls of dmb_type and dmb_copy to suit
>>    different scenarios.
>> - Some minor changes and comments improvements.
>>
>> RFC->old version([1]):
>> Link: https://lore.kernel.org/netdev/1702214654-32069-1-git-send-email-guwen@linux.alibaba.com/
>> - Patch #1: improve the loopback-ism dump, it shows as follows now:
>>    # smcd d
>>    FID  Type  PCI-ID        PCHID  InUse  #LGs  PNET-ID
>>    0000 0     loopback-ism  ffff   No        0
>> - Patch #3: introduce the smc_ism_set_v2_capable() helper and set
>>    smc_ism_v2_capable when ISMv2 or virtual ISM is registered,
>>    regardless of whether there is already a device in smcd device list.
>> - Patch #3: loopback-ism will be added into /sys/devices/virtual/smc/loopback-ism/.
>> - Patch #8: introduce the runtime switch /sys/devices/virtual/smc/loopback-ism/active
>>    to activate or deactivate the loopback-ism.
>> - Patch #9: introduce the statistics of loopback-ism by
>>    /sys/devices/virtual/smc/loopback-ism/{{tx|rx}_tytes|dmbs_cnt}.
>> - Some minor changes and comments improvements.
>>
>> [1] https://lore.kernel.org/netdev/1695568613-125057-1-git-send-email-guwen@linux.alibaba.com/
>> [2] https://lore.kernel.org/netdev/20231219142616.80697-1-guwen@linux.alibaba.com/
>> [3] https://github.com/goldsborough/ipc-bench
>> [4] https://lore.kernel.org/all/3189e342-c38f-6076-b730-19a6efd732a5@linux.alibaba.com/
>> [5] https://lore.kernel.org/all/238e63cd-e0e8-4fbf-852f-bc4d5bc35d5a@linux.alibaba.com/
>> [6] https://lore.kernel.org/all/20240102184633.748113-1-urezki@gmail.com/
>>
>> Wen Gu (15):
>>    net/smc: improve SMC-D device dump for virtual ISM
>>    net/smc: decouple specialized struct from SMC-D DMB registration
>>    net/smc: introduce virtual ISM device loopback-ism
>>    net/smc: implement ID-related operations of loopback-ism
>>    net/smc: implement some unsupported operations of loopback-ism
>>    net/smc: implement DMB-related operations of loopback-ism
>>    net/smc: register loopback-ism into SMC-D device list
>>    net/smc: introduce loopback-ism runtime switch
>>    net/smc: introduce loopback-ism statistics attributes
>>    net/smc: add operations to merge sndbuf with peer DMB
>>    net/smc: attach or detach ghost sndbuf to peer DMB
>>    net/smc: adapt cursor update when sndbuf and peer DMB are merged
>>    net/smc: introduce loopback-ism DMB type control
>>    net/smc: introduce loopback-ism DMB data copy control
>>    net/smc: implement DMB-merged operations of loopback-ism
>>
>>   drivers/s390/net/ism_drv.c |   2 +-
>>   include/net/smc.h          |   7 +-
>>   net/smc/Kconfig            |  13 +
>>   net/smc/Makefile           |   2 +-
>>   net/smc/af_smc.c           |  28 +-
>>   net/smc/smc_cdc.c          |  58 ++-
>>   net/smc/smc_cdc.h          |   1 +
>>   net/smc/smc_core.c         |  61 +++-
>>   net/smc/smc_core.h         |   1 +
>>   net/smc/smc_ism.c          |  71 +++-
>>   net/smc/smc_ism.h          |   5 +
>>   net/smc/smc_loopback.c     | 718 +++++++++++++++++++++++++++++++++++++
>>   net/smc/smc_loopback.h     |  88 +++++
>>   13 files changed, 1026 insertions(+), 29 deletions(-)
>>   create mode 100644 net/smc/smc_loopback.c
>>   create mode 100644 net/smc/smc_loopback.h
>>
> Hi Wen,
> 
> Thank you for the patience again!
> 
> You can find the comments under the corresponding patches respectively.
> About the file hierarchy in sysfs and the names, we still have some thoughts. We need to investigate a bit more time on it.
> 

Hi Wenjia and Gerd,

Thank you very much!

I answered each comment you left. You can find my thoughts about sysfs and
knobs there. Looking forward to your further reply. Thanks!

Best regards,
Wen Gu

> Thanks,
> Gerd & Wenjia


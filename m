Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6694877FACD
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 17:32:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352222AbjHQPb6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 11:31:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352312AbjHQPbe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 11:31:34 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEEF030DE;
        Thu, 17 Aug 2023 08:31:31 -0700 (PDT)
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37HFCVbR018887;
        Thu, 17 Aug 2023 15:31:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : to : cc : from : subject : content-type :
 content-transfer-encoding; s=pp1;
 bh=+FOHtcPvFmOF5KvQi42U5gbX8u8xux1J6u63GV172WY=;
 b=VNE7Iq9L4nti7s78yFSN49Q/pbYOEP5vJxlhdMUCaCMAxb0JV4Lght1EOH0I+1IQzlkC
 IJbpiRf0YHQ0kpS5rAwqtpc2rhNORP4ULXtGsxM2nv8rx5c7Rih+DW2cjIZy2rgN9MT3
 n0YmuhxnlNmOzwdzzISqVmw4dofcybH+XqfGBJIwzL8C9SVjrsTjCrEpfc0NYHipU/zh
 D52LGn3LyKLl7JB8lsQTD3mwp950i8XE6CrBr2AmhVQVZ0EgZ3N4JhDFQK9l7WBZUfV2
 BJ+x4At79u5FIZigTyCJNpcVglRWsWiLPCXTz8XpYHOQP2VULn7a368FXOZQm6w46Sfp oA== 
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3shp058nap-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 17 Aug 2023 15:31:30 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 37HEUKjq007828;
        Thu, 17 Aug 2023 15:31:29 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
        by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3senwkq0j7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 17 Aug 2023 15:31:29 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
        by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 37HFVTFk63766818
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Aug 2023 15:31:29 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 258615805D;
        Thu, 17 Aug 2023 15:31:29 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EDE1A58057;
        Thu, 17 Aug 2023 15:31:25 +0000 (GMT)
Received: from [9.43.5.51] (unknown [9.43.5.51])
        by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Thu, 17 Aug 2023 15:31:25 +0000 (GMT)
Message-ID: <4febc355-ce03-06f6-8077-c08bc9a3a1f6@linux.vnet.ibm.com>
Date:   Thu, 17 Aug 2023 21:01:23 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Content-Language: en-US
To:     linux-kernel@vger.kernel.org, linux-next@vger.kernel.org
Cc:     abdhalee@linux.vnet.ibm.com, mputtash@linux.vnet.com,
        sachinp@linux.vnet.com
From:   Tasmiya Nalatwad <tasmiya@linux.vnet.ibm.com>
Subject: [linux-next] [Mellanox] [6.5.0-rc4-next-20230803] Kernel crash while
 installing to upstream kernel
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: x40vgtG2Q7Z0pKfoq-QtYmX1fRyqO2PB
X-Proofpoint-ORIG-GUID: x40vgtG2Q7Z0pKfoq-QtYmX1fRyqO2PB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-17_09,2023-08-17_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 clxscore=1011
 impostorscore=0 lowpriorityscore=0 malwarescore=0 priorityscore=1501
 bulkscore=0 suspectscore=0 spamscore=0 adultscore=0 phishscore=0
 mlxlogscore=527 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308170134
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings,

[linux-next] [Mellanox] [6.5.0-rc4-next-20230803] Kernel crash while
installing to upstream kernel

---Traces---

[  216.663025] BUG: Unable to handle kernel data access at
0x6800000005a01500
[  216.663034] Faulting instruction address: 0xc000000000531654
[  216.663039] Oops: Kernel access of bad area, sig: 11 [#1]
[  216.663041] LE PAGE_SIZE=64K MMU=Radix SMP NR_CPUS=8192 NUMA pSeries
[  216.663046] Modules linked in: pseries_rng vmx_crypto binfmt_misc
ext4 mbcache jbd2 dm_service_time sd_mod t10_pi crc64_rocksoft crc64 sg
ibmvfc scsi_transport_fc ibmveth mlx5_core mlxfw psample dm_multipath
dm_mirror dm_region_hash dm_log dm_mod fuse
[  216.663067] CPU: 8 PID: 1035 Comm: systemd-cgroups Not tainted
6.5.0-rc4-next-20230803-auto #1
[  216.663072] Hardware name: IBM,9080-HEX POWER10 (raw) 0x800200
0xf000006 of:IBM,FW1030.20 (NH1030_047) hv:phyp pSeries
[  216.663076] NIP:  c000000000531654 LR: c000000000531538 CTR:
0000000000000000
[  216.663078] REGS: c00000000da5f7a0 TRAP: 0380   Not tainted
(6.5.0-rc4-next-20230803-auto)
[  216.663082] MSR:  8000000000009033 <SF,EE,ME,IR,DR,RI,LE>  CR:
28022848  XER: 00000000
[  216.663090] CFAR: c000000000531540 IRQMASK: 0
[  216.663090] GPR00: c000000000531538 c00000000da5fa40 c000000001451c00
0000000000000000
[  216.663090] GPR04: 0000000000000cc0 0000000000000008 00000000000016c5
6800000005a01500
[  216.663090] GPR08: 00000000000016c4 0000000000000010 42f6d0d03e938537
c000000005a0b8d8
[  216.663090] GPR12: 0000000000000000 c0000018ffff5700 0000000000000000
0000000000000000
[  216.663090] GPR16: 0000000000000000 0000000000000000 0000000000000000
0000000000000000
[  216.663090] GPR20: c00000000da5fcc0 c00000000da5fd00 c00000000da5fcb8
0000000000000001
[  216.663090] GPR24: c00000000a709580 0000000000000000 c0000000001589e0
0000000000000028
[  216.663090] GPR28: 0000000000000cc0 0000000000000cc0 6800000005a014f0
c000000003019a00
[  216.663127] NIP [c000000000531654] kmem_cache_alloc+0x1c4/0x470
[  216.663134] LR [c000000000531538] kmem_cache_alloc+0xa8/0x470
[  216.663137] Call Trace:
[  216.663139] [c00000000da5fa40] [c000000000531538]
kmem_cache_alloc+0xa8/0x470 (unreliable)
[  216.663144] [c00000000da5fab0] [c0000000001589e0] vm_area_dup+0x70/0x110
[  216.663149] [c00000000da5faf0] [c0000000004bc190] __split_vma+0xc0/0x880
[  216.663153] [c00000000da5fbb0] [c0000000004c3c14]
mprotect_fixup+0x304/0x3c0
[  216.663158] [c00000000da5fc90] [c0000000004c4038]
do_mprotect_pkey+0x368/0x5c0
[  216.663162] [c00000000da5fdf0] [c0000000004c42c0] sys_mprotect+0x30/0x40
[  216.663166] [c00000000da5fe10] [c000000000036554]
system_call_exception+0x134/0x330
[  216.663171] [c00000000da5fe50] [c00000000000d6a0]
system_call_common+0x160/0x2e4
[  216.663177] --- interrupt: c00 at 0x7fff9cd89db4
[  216.663180] NIP:  00007fff9cd89db4 LR: 00007fff9cd70c9c CTR:
0000000000000000
[  216.663183] REGS: c00000000da5fe80 TRAP: 0c00   Not tainted
(6.5.0-rc4-next-20230803-auto)
[  216.663186] MSR:  800000000280f033
<SF,VEC,VSX,EE,PR,FP,ME,IR,DR,RI,LE>  CR: 24022248  XER: 00000000
[  216.663195] IRQMASK: 0
[  216.663195] GPR00: 000000000000007d 00007ffffadf2600 00007fff9cdb7e00
00007fff9c5f0000
[  216.663195] GPR04: 0000000000010000 0000000000000001 000000000000000b
00007fff9c5ff170
[  216.663195] GPR08: 00000000001fc1a8 0000000000000000 0000000000000000
0000000000000000
[  216.663195] GPR12: 0000000000000000 00007fff9cdc5ed0 00007fff9c4120a0
00007fff9cdb2ef8
[  216.663195] GPR16: 00007fff9c403fd0 00007ffffadf26d0 000000000000fff1
00007ffffadf26d0
[  216.663195] GPR20: 00007fff9c41848c 0000000000000000 00007fff9c600070
00007fff9c400000
[  216.663195] GPR24: 0000000000200070 0000000000000015 00007fff9c411f20
000000000000df50
[  216.663195] GPR28: 0000094e00000015 00007fff9cdb2b70 0000000000000000
00007fff9cdb2b70
[  216.663230] NIP [00007fff9cd89db4] 0x7fff9cd89db4
[  216.663233] LR [00007fff9cd70c9c] 0x7fff9cd70c9c
[  216.663235] --- interrupt: c00
[  216.663236] Code: 7ce95214 e9070008 7fc9502a e9270010 2fbe0000
419e01f8 2fa90000 419e01f0 813f0028 e95f00b8 38c80001 7cfe4a14
<7d3e482a> 78e50022 54fdc03e 54a4c03e
[  216.663249] ---[ end trace 0000000000000000 ]---

-- 
Regards,
Tasmiya Nalatwad
IBM Linux Technology Center


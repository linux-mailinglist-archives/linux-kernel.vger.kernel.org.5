Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8AB476FB54
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 09:42:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232626AbjHDHmr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 03:42:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229882AbjHDHmo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 03:42:44 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C3A5E70;
        Fri,  4 Aug 2023 00:42:43 -0700 (PDT)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3747eJqC030490;
        Fri, 4 Aug 2023 07:42:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : to : from : subject : content-type :
 content-transfer-encoding; s=pp1;
 bh=i7ZCOVWntLpopjLEQzPFburq/bPGQLc/fpmHL1zpqbg=;
 b=egl0mVrG4oriws6Gx5nwk1rgTxia44ZkjEE05Y/Kf7f1N7b71x6Jvh8b/CQ3PeuOFsPn
 txryM+m8p7g8BXhhcVBDamuMehf02sfuIcs+Kqfwzdj0TuahTdCyrUlhYIyFK+g7fE8r
 gItvy6YgVMAMgR+cemoX1RIyjS+E9iCou9F05hkPw5vianJeUD+ZtKwtV0H8uU2kpj+v
 UhAXiAlbtkahrAkH80a08LZuUiiT8zxB0B+cy76KxcMu22v2P1rzGK5TnRjEuQT+cUxV
 D888aOZu6C+QLCdxgwGbHbKSJa60CZVgOjN+VfrAVp/th9NyTxOJ/r4Ve8rba6tQdr1b jQ== 
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3s8vyf88c6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 04 Aug 2023 07:42:42 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
        by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3746ub3w022110;
        Fri, 4 Aug 2023 07:37:40 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
        by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3s8kp2uq36-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 04 Aug 2023 07:37:40 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
        by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3747bdEL36372910
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 4 Aug 2023 07:37:40 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B59D058058;
        Fri,  4 Aug 2023 07:37:39 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F3BE658057;
        Fri,  4 Aug 2023 07:37:37 +0000 (GMT)
Received: from [9.43.75.26] (unknown [9.43.75.26])
        by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Fri,  4 Aug 2023 07:37:37 +0000 (GMT)
Message-ID: <f14a90b9-c334-3c6b-6b9d-16fc578e8346@linux.vnet.ibm.com>
Date:   Fri, 4 Aug 2023 13:07:36 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Content-Language: en-US
To:     linux-kernel@vger.kernel.org, abdhalee@linux.vnet.ibm.com,
        mputtash@linux.vnet.com, sachinp@linux.vnet.com,
        linux-block@vger.kernel.org
From:   Tasmiya Nalatwad <tasmiya@linux.vnet.ibm.com>
Subject: [linux mainline/master] [6.5.0-rc4] WARNING: CPU: 23 PID: 138 at
 arch/powerpc/kernel/eeh_pe.c:439 eeh_pe_tree_remove+0xd0/0x250
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: sWcv7pyVNrdzu-k46gETLpcl5rp4gUsL
X-Proofpoint-ORIG-GUID: sWcv7pyVNrdzu-k46gETLpcl5rp4gUsL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-04_06,2023-08-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 malwarescore=0 lowpriorityscore=0 mlxlogscore=874 priorityscore=1501
 adultscore=0 bulkscore=0 suspectscore=0 spamscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308040066
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings,

[linux mainline/master] [6.5.0-rc4] WARNING: CPU: 23 PID: 138 at 
arch/powerpc/kernel/eeh_pe.c:439 eeh_pe_tree_remove+0xd0/0x250

---Traces---

[  145.751661] WARNING: CPU: 23 PID: 138 at 
arch/powerpc/kernel/eeh_pe.c:439 eeh_pe_tree_remove+0xd0/0x250
[  145.751670] Modules linked in: pseries_rng vmx_crypto 
aes_gcm_p10_crypto binfmt_misc xfs libcrc32c dm_service_time sd_mod 
t10_pi crc64_rocksoft crc64 sg ibmvfc mlx5_core scsi_transport_fc 
ibmveth mlxfw psample dm_multipath dm_mirror dm_region_hash dm_log 
dm_mod fuse
[  145.751691] CPU: 23 PID: 138 Comm: eehd Not tainted 
6.5.0-rc4-auto-gc1a515d3c027 #1
[  145.751695] Hardware name: IBM,9080-HEX POWER10 (raw) 0x800200 
0xf000006 of:IBM,FW1030.20 (NH1030_047) hv:phyp pSeries
[  145.751699] NIP:  c0000000000561e0 LR: c000000000056160 CTR: 
c000000000056f90
[  145.751702] REGS: c00000000d003a20 TRAP: 0700   Not tainted 
(6.5.0-rc4-auto-gc1a515d3c027)
[  145.751705] MSR:  800000000282b033 <SF,VEC,VSX,EE,FP,ME,IR,DR,RI,LE>  
CR: 44002222  XER: 20040008
[  145.751715] CFAR: c00000000082cbbc IRQMASK: 0
[  145.751715] GPR00: c000000000056fec c00000000d003cc0 c000000001431800 
0000000000000000
[  145.751715] GPR04: c000000004211330 c000000004211330 c000000050541068 
fffffffffffe0000
[  145.751715] GPR08: c000000050541068 0000000000000100 0000000000000004 
0000000000000000
[  145.751715] GPR12: c000000000056f90 c000000743dce300 c000000000196098 
c000000004048e00
[  145.751715] GPR16: 0000000000000000 0000000000000000 0000000000000000 
0000000000000000
[  145.751715] GPR20: 0000000000000000 0000000000000000 0000000000000000 
c000000050541068
[  145.751715] GPR24: 0000000000000000 0000000000000000 0000000000000003 
0000000000000002
[  145.751715] GPR28: 5deadbeef0000100 5deadbeef0000122 c00000000d233400 
c000000050541000
[  145.751753] NIP [c0000000000561e0] eeh_pe_tree_remove+0xd0/0x250
[  145.751757] LR [c000000000056160] eeh_pe_tree_remove+0x50/0x250
[  145.751760] Call Trace:
[  145.751762] [c00000000d003cc0] [c00000000d003d00] 0xc00000000d003d00 
(unreliable)
[  145.751767] [c00000000d003d40] [c000000000056fec] 
eeh_pe_detach_dev+0x5c/0xa0
[  145.751772] [c00000000d003d70] [c000000000055a7c] 
eeh_pe_traverse+0x6c/0x110
[  145.751775] [c00000000d003db0] [c000000000058cd0] 
eeh_reset_device+0x1b4/0x250
[  145.751779] [c00000000d003e50] [c000000000058398] 
eeh_handle_normal_event+0x758/0xa30
[  145.751784] [c00000000d003f30] [c000000000059608] 
eeh_event_handler+0x118/0x1a0
[  145.751788] [c00000000d003f90] [c0000000001961c8] kthread+0x138/0x140
[  145.751793] [c00000000d003fe0] [c00000000000df98] 
start_kernel_thread+0x14/0x18
[  145.751797] Code: ebdf0038 71490002 4082004c 60000000 e93f0006 
391f0068 552307bc 71290100 7c6307b4 2fa30000 41820098 409e0008 
<0fe00000> e93f0068 7fa94040 419e0044
[  145.751809] ---[ end trace 0000000000000000 ]---


-- 
Regards,
Tasmiya Nalatwad
IBM Linux Technology Center


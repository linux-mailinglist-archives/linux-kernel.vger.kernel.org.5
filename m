Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E10A78BDD2
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 07:33:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235786AbjH2Fbx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 01:31:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235827AbjH2Fbh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 01:31:37 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A281CDF
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 22:30:58 -0700 (PDT)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37T5H4WZ006775;
        Tue, 29 Aug 2023 05:30:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=wCc//+ZnLeD0imvx9zhi/IaL6OrfuN/rumipaIga5vM=;
 b=o/t4sflOkDgps4TP+HzwlWGIHPMIyzuMdJ+bODxehPXBeCyK5XOjJl3GTAWXqsqwCAaY
 i9gOS201/spZLsecsIjNuTo0RaGJeFeOgUHK/Y2/21A9cjdPXEypJv+5eS8sAnw716Na
 AYpaLrapfrb8h7iU5nRQyf6AnQAjuDkxH8OjZQPXj23rDzR+xaThMqQUUa8xOIP+dE32
 CErJNmS+V+irKYI/uPB4v7gg8LX1xuTuUv8IeYC3Y6pUmAa7OTSVVRsqohHg6s89b486
 XFWJSPSY/4O2Bk8n4hXdVQ7TJc/pRI4+0SpwVeU44AItvdPQC3TkJre7d/0HoihrETae Bw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sr62pk9d6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 29 Aug 2023 05:30:18 +0000
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 37T5OZuG032313;
        Tue, 29 Aug 2023 05:30:17 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sr62pk9cu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 29 Aug 2023 05:30:17 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
        by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 37T3Ikb0014115;
        Tue, 29 Aug 2023 05:30:17 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
        by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3sqwxjrfrw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 29 Aug 2023 05:30:17 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
        by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 37T5UG4B6423164
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Aug 2023 05:30:16 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1341F58063;
        Tue, 29 Aug 2023 05:30:16 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D483158056;
        Tue, 29 Aug 2023 05:30:11 +0000 (GMT)
Received: from [9.43.58.117] (unknown [9.43.58.117])
        by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Tue, 29 Aug 2023 05:30:11 +0000 (GMT)
Message-ID: <ad9167de-8d62-a2d6-b139-b02c6a35df4f@linux.vnet.ibm.com>
Date:   Tue, 29 Aug 2023 11:00:09 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [linux-next][mainline/master] [IPR] [Function could be =
 "__mutex_lock_slowpath(lock)"]OOPs kernel crash while performing IPR test
To:     Waiman Long <longman@redhat.com>, linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, abdhalee@linux.vnet.ibm.com,
        mingo@redhat.com, will@kernel.org, boqun.feng@gmail.com
References: <67f349e2-33f1-30a3-f92c-3c0a68d6d22f@linux.vnet.ibm.com>
 <731c0ca3-d9db-cbcd-ab64-876a5e689054@redhat.com>
Content-Language: en-US
From:   Tasmiya Nalatwad <tasmiya@linux.vnet.ibm.com>
In-Reply-To: <731c0ca3-d9db-cbcd-ab64-876a5e689054@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Y53aMbdHG5svfW7XHR_3xeSVW-IevUdy
X-Proofpoint-ORIG-GUID: XDITwS0Gi1cmERFARfDcTGyXcfQt3yND
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-29_02,2023-08-28_04,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 clxscore=1015
 priorityscore=1501 malwarescore=0 phishscore=0 spamscore=0 adultscore=0
 suspectscore=0 mlxscore=0 lowpriorityscore=0 bulkscore=0 mlxlogscore=825
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2308290043
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings,

Thank you Waiman Long for your analysis. The issue is seen consistently 
on every build of linux-next and mainline/master

On 8/27/23 21:39, Waiman Long wrote:
>
> On 8/27/23 04:26, Tasmiya Nalatwad wrote:
>> Greetings,
>>
>> [linux-next][mainline/master] [IPR] [Function could be = 
>> "__mutex_lock_slowpath(lock)"]OOPs kernel crash while performing IPR 
>> test
>>
>> --- Traces ---
>>
>> --- Traces ---
>> [65818.211823] Kernel attempted to read user page (380) - exploit 
>> attempt? (uid: 0)
>> [65818.211836] BUG: Kernel NULL pointer dereference on read at 
>> 0x00000380
>> [65818.211840] Faulting instruction address: 0xc000000000f5f2e4
>> [65818.211844] Oops: Kernel access of bad area, sig: 11 [#1]
>> [65818.211846] LE PAGE_SIZE=64K MMU=Radix SMP NR_CPUS=8192 NUMA pSeries
>> [65818.211850] Modules linked in: rpadlpar_io rpaphp nfnetlink 
>> xsk_diag bonding tls rfkill sunrpc ses enclosure scsi_transport_sas 
>> vmx_crypto pseries_rng binfmt_misc ip_tables ext4 mbcache jbd2 
>> dm_service_time sd_mod t10_pi crc64_rocksoft crc64 sg ibmvfc 
>> scsi_transport_fc ibmveth ipr dm_multipath dm_mirror dm_region_hash 
>> dm_log dm_mod fuse
>> [65818.211879] CPU: 16 PID: 613 Comm: kworker/16:3 Kdump: loaded Not 
>> tainted 6.5.0-rc7-next-20230824-auto #1
>> [65818.211883] Hardware name: IBM,9080-HEX POWER10 (raw) 0x800200 
>> 0xf000006 of:IBM,FW1030.30 (NH1030_062) hv:phyp pSeries
>> [65818.211887] Workqueue: events sg_remove_sfp_usercontext [sg]
>> [65818.211894] NIP:  c000000000f5f2e4 LR: c000000000f5f2d8 CTR: 
>> c00000000032df70
>> [65818.211897] REGS: c0000000081c7a10 TRAP: 0300   Not tainted 
>> (6.5.0-rc7-next-20230824-auto)
>> [65818.211900] MSR:  800000000280b033 
>> <SF,VEC,VSX,EE,FP,ME,IR,DR,RI,LE>  CR: 28000882  XER: 20040000
>> [65818.211909] CFAR: c000000000f5b0a4 DAR: 0000000000000380 DSISR: 
>> 40000000 IRQMASK: 0
>> [65818.211909] GPR00: c000000000f5f2d8 c0000000081c7cb0 
>> c000000001451300 0000000000000000
>> [65818.211909] GPR04: 00000000000000c0 00000000c0000000 
>> c000000006c5a298 98a2c506000000c0
>> [65818.211909] GPR08: c00000006408ab00 c0000000022a3515 
>> 0000000000000000 c008000000327d60
>> [65818.211909] GPR12: c00000000032df70 c000000c1bc93f00 
>> c000000000197cc8 c000000008797500
>> [65818.211909] GPR16: 0000000000000000 0000000000000000 
>> 0000000000000000 c000000003071ab0
>> [65818.211909] GPR20: c000000003494c05 c000000c11340040 
>> 0000000000000000 c0000000b9bb4030
>> [65818.211909] GPR24: c0000000b9bb4000 c00000005e8627c0 
>> 0000000000000000 c000000c19b91e00
>> [65818.211909] GPR28: c0000000b9bb5328 c00000005e8627c0 
>> 0000000000000380 0000000000000380
>> [65818.211946] NIP [c000000000f5f2e4] mutex_lock+0x34/0x90
>> [65818.211953] LR [c000000000f5f2d8] mutex_lock+0x28/0x90
>> [65818.211957] Call Trace:
>> [65818.211959] [c0000000081c7cb0] [c000000000f5f2d8] 
>> mutex_lock+0x28/0x90 (unreliable)
>> [65818.211966] [c0000000081c7ce0] [c00000000032df9c] 
>> blk_trace_remove+0x2c/0x80
>> [65818.211971] [c0000000081c7d10] [c0080000003205fc] 
>> sg_device_destroy+0x44/0x110 [sg]
>> [65818.211976] [c0000000081c7d90] [c008000000322988] 
>> sg_remove_sfp_usercontext+0x1d0/0x2c0 [sg]
>> [65818.211981] [c0000000081c7e40] [c000000000188010] 
>> process_scheduled_works+0x230/0x4f0
>> [65818.211987] [c0000000081c7f10] [c00000000018b044] 
>> worker_thread+0x1e4/0x500
>> [65818.211992] [c0000000081c7f90] [c000000000197df8] kthread+0x138/0x140
>> [65818.211996] [c0000000081c7fe0] [c00000000000df98] 
>> start_kernel_thread+0x14/0x18 
>
> The panic happens when a device is being removed. Maybe it is a 
> use-after-free problem. The mutex lock itself seems to be in an area 
> that is no longer accessible. It is not a problem in the locking code 
> itself.
>
> Cheers,
> Longman
>
-- 
Regards,
Tasmiya Nalatwad
IBM Linux Technology Center


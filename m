Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C733979876F
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 14:57:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243337AbjIHM5g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 08:57:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbjIHM5e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 08:57:34 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DEC819AE
        for <linux-kernel@vger.kernel.org>; Fri,  8 Sep 2023 05:57:30 -0700 (PDT)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 388CnmFM018343;
        Fri, 8 Sep 2023 12:57:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : message-id :
 content-type : subject : date : in-reply-to : cc : to : references :
 mime-version; s=pp1; bh=r6amjWQNixEAlpT3tONKcM93cYHDeFWpwVIIaeVzQE0=;
 b=rdgpep5LNQCrZ41DvBHLY1uuxSpf3yYWB7EwuiBNlur+U31J/UHG6IVfEv6SMK1M6xLp
 VAZUliIn0FE4eEP6LxcqMOU5NgJNsr6SMNwDajKpbXjL8QwZAYUz91r+9LkSZdBKdk9x
 W3zg9wbHolzRm+NsKVL67XPjFdGb5kOyutoGD2rGWm+IJVvLDqzH73V/IWFajE7AnRNN
 zN5/hJ+0HuO+X9eMtlW21wnS6fbwO7KCzTvXNGAnv/lBBkwVw7An7m0v/VaeBZ9WmuK1
 whidvwR/P43hoWCF58d2Ey13bQ0HKGOYxEUpHA1fX4RkUyCTG5FPHmUA60JgbfZjc3zG kw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3t03y905ya-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 08 Sep 2023 12:56:59 +0000
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 388CoPQw021260;
        Fri, 8 Sep 2023 12:56:59 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3t03y905xv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 08 Sep 2023 12:56:59 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 388AZ8pe021422;
        Fri, 8 Sep 2023 12:56:57 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
        by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3svfs03vyh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 08 Sep 2023 12:56:57 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
        by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 388Cut2P4391522
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 8 Sep 2023 12:56:55 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 931702004B;
        Fri,  8 Sep 2023 12:56:55 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3A13B20049;
        Fri,  8 Sep 2023 12:56:53 +0000 (GMT)
Received: from smtpclient.apple (unknown [9.43.38.223])
        by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Fri,  8 Sep 2023 12:56:52 +0000 (GMT)
From:   Sachin Sant <sachinp@linux.ibm.com>
Message-Id: <DD531436-22EE-4353-9944-6A3A87F27BC7@linux.ibm.com>
Content-Type: multipart/mixed;
        boundary="Apple-Mail=_3CF225EC-76D5-4445-AF51-6AB83E2471F3"
Subject: Re: [PATCH] mm: vmscan: fix NULL pointer dereference in
 can_reclaim_anon_pages
Date:   Fri, 8 Sep 2023 18:26:41 +0530
In-Reply-To: <20230908093103.2620512-1-liushixin2@huawei.com>
Cc:     Michael Ellerman <michaele@au1.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yosry Ahmed <yosryahmed@google.com>,
        Huang Ying <ying.huang@intel.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
To:     Liu Shixin <liushixin2@huawei.com>
References: <20230908093103.2620512-1-liushixin2@huawei.com>
X-Mailer: Apple Mail (2.3731.700.6)
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: AqhbbPdFnodz51lL0XUEnO2FSA0AxsMQ
X-Proofpoint-ORIG-GUID: bTRUe8N1m6gYE1y0CESUqG7Xx4FKVJlv
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-08_09,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 malwarescore=0 impostorscore=0 lowpriorityscore=0 clxscore=1011
 phishscore=0 bulkscore=0 priorityscore=1501 spamscore=0 mlxlogscore=999
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309080116
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Apple-Mail=_3CF225EC-76D5-4445-AF51-6AB83E2471F3
Content-Type: text/plain;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable



> On 08-Sep-2023, at 3:01 PM, Liu Shixin <liushixin2@huawei.com> wrote:
>=20
> The variable sc is NULL pointer in can_reclaim_anon_pages() when called
> from zone_reclaimable_pages(). Check it before setting swapcache_only.
>=20
> Reported-by: Sachin Sant <sachinp@linux.ibm.com>
> Link: https://lore.kernel.org/linux-mm/F00144DE-2A3F-4463-8203-45E0D57E31=
3E@linux.ibm.com/T/
> Fixes: 92039ae85e8d("mm: vmscan: try to reclaim swapcache pages if no swa=
p space")
> Signed-off-by: Liu Shixin <liushixin2@huawei.com>
> ---
> mm/vmscan.c | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)
>=20

Thanks for the fix. With this patch applied although I no longer run into
the reported crash the test program doesn=E2=80=99t complete. I have observ=
ed
hung task timeouts while running the program.

# ./min_free_kbytes
tst_test.c:1547: TINFO: Timeout per run is disabled
mem.c:648: TINFO: set overcommit_memory to 2
mem.c:648: TINFO: set min_free_kbytes to 31116
memfree is 58822592 kB before eatup mem
[  490.838676] __vm_enough_memory: pid: 10431, comm: min_free_kbytes, not e=
nough memory for the allocation
memfree is 25224000 kB after eatup mem
mem.c:648: TINFO: set min_free_kbytes to 62232
memfree is 58794048 kB before eatup mem
[  493.789210] __vm_enough_memory: pid: 10807, comm: min_free_kbytes, not e=
nough memory for the allocation
memfree is 25239232 kB after eatup mem
mem.c:648: TINFO: set min_free_kbytes to 1211553
memfree is 58777344 kB before eatup mem
[  496.736678] __vm_enough_memory: pid: 10943, comm: min_free_kbytes, not e=
nough memory for the allocation
memfree is 25145600 kB after eatup mem
mem.c:648: TINFO: set overcommit_memory to 0
mem.c:648: TINFO: set min_free_kbytes to 31116
memfree is 58684864 kB before eatup mem
[  736.065807] INFO: task kworker/u260:0:178 blocked for more than 122 seco=
nds.
[  736.065833]       Tainted: G            E      6.5.0-next-20230907-dirty=
 #16
[  736.065837] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables =
this message.
[  736.065842] task:kworker/u260:0  state:D stack:0     pid:178   ppid:2   =
   flags:0x00000000
[  736.065852] Workqueue: writeback wb_workfn (flush-8:0)
[  736.065864] Call Trace:
[  736.065867] [c0000000080e32a0] [c0000000080e3500] 0xc0000000080e3500 (un=
reliable)
[  736.065875] [c0000000080e3450] [c00000000001fc9c] __switch_to+0x13c/0x220
[  736.065884] [c0000000080e34b0] [c000000000fec5b0] __schedule+0x260/0x7c0
[  736.065891] [c0000000080e3580] [c000000000fecb84] schedule+0x74/0x150
[  736.065897] [c0000000080e35f0] [c000000000fecce4] io_schedule+0x54/0x80
[  736.065902] [c0000000080e3620] [c0000000007fb1fc] rq_qos_wait+0xfc/0x1e0
[  736.065910] [c0000000080e36d0] [c0000000008278a4] wbt_wait+0xd4/0x170
[  736.065916] [c0000000080e3730] [c0000000007fab64] __rq_qos_throttle+0x54=
/0x80
[  736.065922] [c0000000080e3760] [c0000000007df0dc] blk_mq_get_new_request=
s+0xfc/0x270
[  736.065931] [c0000000080e37f0] [c0000000007e4e6c] blk_mq_submit_bio+0x37=
c/0x580
[  736.065937] [c0000000080e3850] [c0000000007cd830] __submit_bio+0x30/0x250
[  736.065944] [c0000000080e3880] [c0000000007ce110] submit_bio_noacct_noch=
eck+0x140/0x260
[  736.065951] [c0000000080e38f0] [c000000000675a0c] iomap_submit_ioend+0x8=
c/0xf0
[  736.065959] [c0000000080e3930] [c00800000154fc20] xfs_vm_writepages+0xc8=
/0x140 [xfs]
[  736.066063] [c0000000080e39e0] [c0000000004768d0] do_writepages+0xc0/0x2=
90
[  736.066070] [c0000000080e3a60] [c00000000061553c] __writeback_single_ino=
de+0x6c/0x500
[  736.066076] [c0000000080e3ab0] [c0000000006160cc] writeback_sb_inodes+0x=
2dc/0x6d0
[  736.066081] [c0000000080e3bd0] [c000000000616544] __writeback_inodes_wb+=
0x84/0x1a0
[  736.066087] [c0000000080e3c40] [c0000000006169bc] wb_writeback+0x35c/0x4=
b0
[  736.066092] [c0000000080e3d00] [c000000000618274] wb_workfn+0x3a4/0x6f0
[  736.066097] [c0000000080e3e50] [c00000000018d4ec] process_one_work+0x1ec=
/0x4a0
[  736.066105] [c0000000080e3ef0] [c00000000018db5c] worker_thread+0x3bc/0x=
590
[  736.066112] [c0000000080e3f90] [c00000000019c2e8] kthread+0x138/0x140
[  736.066118] [c0000000080e3fe0] [c00000000000df98] start_kernel_thread+0x=
14/0x18

The system seems to lockup(atleast appears that way)  after few minutes. I =
cannot ssh to
the system. Killing the test program doesn=E2=80=99t appear to help.=20
I have attached the console output.

There still seems to be some issue with the patch.

- Sachin


--Apple-Mail=_3CF225EC-76D5-4445-AF51-6AB83E2471F3
Content-Disposition: attachment;
	filename=run.log
Content-Type: application/octet-stream;
	x-unix-mode=0644;
	name="run.log"
Content-Transfer-Encoding: 7bit

# ./min_free_kbytes 
tst_test.c:1547: TINFO: Timeout per run is disabled
mem.c:648: TINFO: set overcommit_memory to 2
mem.c:648: TINFO: set min_free_kbytes to 31116
memfree is 58822592 kB before eatup mem
[  490.838676] __vm_enough_memory: pid: 10431, comm: min_free_kbytes, not enough memory for the allocation
memfree is 25224000 kB after eatup mem
mem.c:648: TINFO: set min_free_kbytes to 62232
memfree is 58794048 kB before eatup mem
[  493.789210] __vm_enough_memory: pid: 10807, comm: min_free_kbytes, not enough memory for the allocation
memfree is 25239232 kB after eatup mem
mem.c:648: TINFO: set min_free_kbytes to 1211553
memfree is 58777344 kB before eatup mem
[  496.736678] __vm_enough_memory: pid: 10943, comm: min_free_kbytes, not enough memory for the allocation
memfree is 25145600 kB after eatup mem
mem.c:648: TINFO: set overcommit_memory to 0
mem.c:648: TINFO: set min_free_kbytes to 31116
memfree is 58684864 kB before eatup mem
[  736.065807] INFO: task kworker/u260:0:178 blocked for more than 122 seconds.
[  736.065833]       Tainted: G            E      6.5.0-next-20230907-dirty #16
[  736.065837] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[  736.065842] task:kworker/u260:0  state:D stack:0     pid:178   ppid:2      flags:0x00000000
[  736.065852] Workqueue: writeback wb_workfn (flush-8:0)
[  736.065864] Call Trace:
[  736.065867] [c0000000080e32a0] [c0000000080e3500] 0xc0000000080e3500 (unreliable)
[  736.065875] [c0000000080e3450] [c00000000001fc9c] __switch_to+0x13c/0x220
[  736.065884] [c0000000080e34b0] [c000000000fec5b0] __schedule+0x260/0x7c0
[  736.065891] [c0000000080e3580] [c000000000fecb84] schedule+0x74/0x150
[  736.065897] [c0000000080e35f0] [c000000000fecce4] io_schedule+0x54/0x80
[  736.065902] [c0000000080e3620] [c0000000007fb1fc] rq_qos_wait+0xfc/0x1e0
[  736.065910] [c0000000080e36d0] [c0000000008278a4] wbt_wait+0xd4/0x170
[  736.065916] [c0000000080e3730] [c0000000007fab64] __rq_qos_throttle+0x54/0x80
[  736.065922] [c0000000080e3760] [c0000000007df0dc] blk_mq_get_new_requests+0xfc/0x270
[  736.065931] [c0000000080e37f0] [c0000000007e4e6c] blk_mq_submit_bio+0x37c/0x580
[  736.065937] [c0000000080e3850] [c0000000007cd830] __submit_bio+0x30/0x250
[  736.065944] [c0000000080e3880] [c0000000007ce110] submit_bio_noacct_nocheck+0x140/0x260
[  736.065951] [c0000000080e38f0] [c000000000675a0c] iomap_submit_ioend+0x8c/0xf0
[  736.065959] [c0000000080e3930] [c00800000154fc20] xfs_vm_writepages+0xc8/0x140 [xfs]
[  736.066063] [c0000000080e39e0] [c0000000004768d0] do_writepages+0xc0/0x290
[  736.066070] [c0000000080e3a60] [c00000000061553c] __writeback_single_inode+0x6c/0x500
[  736.066076] [c0000000080e3ab0] [c0000000006160cc] writeback_sb_inodes+0x2dc/0x6d0
[  736.066081] [c0000000080e3bd0] [c000000000616544] __writeback_inodes_wb+0x84/0x1a0
[  736.066087] [c0000000080e3c40] [c0000000006169bc] wb_writeback+0x35c/0x4b0
[  736.066092] [c0000000080e3d00] [c000000000618274] wb_workfn+0x3a4/0x6f0
[  736.066097] [c0000000080e3e50] [c00000000018d4ec] process_one_work+0x1ec/0x4a0
[  736.066105] [c0000000080e3ef0] [c00000000018db5c] worker_thread+0x3bc/0x590
[  736.066112] [c0000000080e3f90] [c00000000019c2e8] kthread+0x138/0x140
[  736.066118] [c0000000080e3fe0] [c00000000000df98] start_kernel_thread+0x14/0x18
[  858.946003] INFO: task kworker/u260:0:178 blocked for more than 245 seconds.
[  858.946025]       Tainted: G            E      6.5.0-next-20230907-dirty #16
[  858.946030] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[  858.946035] task:kworker/u260:0  state:D stack:0     pid:178   ppid:2      flags:0x00000000
[  858.946045] Workqueue: writeback wb_workfn (flush-8:0)
[  858.946057] Call Trace:
[  858.946060] [c0000000080e32a0] [c0000000080e3500] 0xc0000000080e3500 (unreliable)
[  858.946070] [c0000000080e3450] [c00000000001fc9c] __switch_to+0x13c/0x220
[  858.946079] [c0000000080e34b0] [c000000000fec5b0] __schedule+0x260/0x7c0
[  858.946087] [c0000000080e3580] [c000000000fecb84] schedule+0x74/0x150
[  858.946094] [c0000000080e35f0] [c000000000fecce4] io_schedule+0x54/0x80
[  858.946100] [c0000000080e3620] [c0000000007fb1fc] rq_qos_wait+0xfc/0x1e0
[  858.946109] [c0000000080e36d0] [c0000000008278a4] wbt_wait+0xd4/0x170
[  858.946116] [c0000000080e3730] [c0000000007fab64] __rq_qos_throttle+0x54/0x80
[  858.946124] [c0000000080e3760] [c0000000007df0dc] blk_mq_get_new_requests+0xfc/0x270
[  858.946134] [c0000000080e37f0] [c0000000007e4e6c] blk_mq_submit_bio+0x37c/0x580
[  858.946142] [c0000000080e3850] [c0000000007cd830] __submit_bio+0x30/0x250
[  858.946150] [c0000000080e3880] [c0000000007ce110] submit_bio_noacct_nocheck+0x140/0x260
[  858.946158] [c0000000080e38f0] [c000000000675a0c] iomap_submit_ioend+0x8c/0xf0
[  858.946167] [c0000000080e3930] [c00800000154fc20] xfs_vm_writepages+0xc8/0x140 [xfs]
[  858.946298] [c0000000080e39e0] [c0000000004768d0] do_writepages+0xc0/0x290
[  858.946305] [c0000000080e3a60] [c00000000061553c] __writeback_single_inode+0x6c/0x500
[  858.946311] [c0000000080e3ab0] [c0000000006160cc] writeback_sb_inodes+0x2dc/0x6d0
[  858.946317] [c0000000080e3bd0] [c000000000616544] __writeback_inodes_wb+0x84/0x1a0
[  858.946322] [c0000000080e3c40] [c0000000006169bc] wb_writeback+0x35c/0x4b0
[  858.946327] [c0000000080e3d00] [c000000000618274] wb_workfn+0x3a4/0x6f0
[  858.946333] [c0000000080e3e50] [c00000000018d4ec] process_one_work+0x1ec/0x4a0
[  858.946340] [c0000000080e3ef0] [c00000000018db5c] worker_thread+0x3bc/0x590
[  858.946347] [c0000000080e3f90] [c00000000019c2e8] kthread+0x138/0x140
[  858.946353] [c0000000080e3fe0] [c00000000000df98] start_kernel_thread+0x14/0x18
[  858.946362] INFO: task kworker/u257:1:189 blocked for more than 122 seconds.
[  858.946366]       Tainted: G            E      6.5.0-next-20230907-dirty #16
[  858.946371] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[  858.946374] task:kworker/u257:1  state:D stack:0     pid:189   ppid:2      flags:0x00000000
[  858.946381] Workqueue: writeback wb_workfn (flush-8:0)
[  858.946386] Call Trace:
[  858.946389] [c000000008ee7450] [c00000000001fc9c] __switch_to+0x13c/0x220
[  858.946395] [c000000008ee74b0] [c000000000fec5b0] __schedule+0x260/0x7c0
[  858.946401] [c000000008ee7580] [c000000000fecb84] schedule+0x74/0x150
[  858.946406] [c000000008ee75f0] [c000000000fecce4] io_schedule+0x54/0x80
[  858.946411] [c000000008ee7620] [c0000000007fb1fc] rq_qos_wait+0xfc/0x1e0
[  858.946417] [c000000008ee76d0] [c0000000008278a4] wbt_wait+0xd4/0x170
[  858.946422] [c000000008ee7730] [c0000000007fab64] __rq_qos_throttle+0x54/0x80
[  858.946429] [c000000008ee7760] [c0000000007df0dc] blk_mq_get_new_requests+0xfc/0x270
[  858.946435] [c000000008ee77f0] [c0000000007e4e6c] blk_mq_submit_bio+0x37c/0x580
[  858.946442] [c000000008ee7850] [c0000000007cd830] __submit_bio+0x30/0x250
[  858.946448] [c000000008ee7880] [c0000000007ce110] submit_bio_noacct_nocheck+0x140/0x260
[  858.946455] [c000000008ee78f0] [c000000000675a0c] iomap_submit_ioend+0x8c/0xf0
[  858.946462] [c000000008ee7930] [c00800000154fc20] xfs_vm_writepages+0xc8/0x140 [xfs]
[  858.946561] [c000000008ee79e0] [c0000000004768d0] do_writepages+0xc0/0x290
[  858.946566] [c000000008ee7a60] [c00000000061553c] __writeback_single_inode+0x6c/0x500
[  858.946572] [c000000008ee7ab0] [c0000000006160cc] writeback_sb_inodes+0x2dc/0x6d0
[  858.946577] [c000000008ee7bd0] [c000000000616544] __writeback_inodes_wb+0x84/0x1a0
[  858.946583] [c000000008ee7c40] [c0000000006169bc] wb_writeback+0x35c/0x4b0
[  858.946588] [c000000008ee7d00] [c000000000618274] wb_workfn+0x3a4/0x6f0
[  858.946593] [c000000008ee7e50] [c00000000018d4ec] process_one_work+0x1ec/0x4a0
[  858.946600] [c000000008ee7ef0] [c00000000018db5c] worker_thread+0x3bc/0x590
[  858.946606] [c000000008ee7f90] [c00000000019c2e8] kthread+0x138/0x140
[  858.946612] [c000000008ee7fe0] [c00000000000df98] start_kernel_thread+0x14/0x18
[  858.946652] INFO: task xfsaild/sda3:623 blocked for more than 122 seconds.
[  858.946656]       Tainted: G            E      6.5.0-next-20230907-dirty #16
[  858.946660] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[  858.946663] task:xfsaild/sda3    state:D stack:0     pid:623   ppid:2      flags:0x00000000
[  858.946669] Call Trace:
[  858.946672] [c000000009ec35b0] [0000000000004000] 0x4000 (unreliable)
[  858.946678] [c000000009ec3760] [c00000000001fc9c] __switch_to+0x13c/0x220
[  858.946684] [c000000009ec37c0] [c000000000fec5b0] __schedule+0x260/0x7c0
[  858.946689] [c000000009ec3890] [c000000000fecb84] schedule+0x74/0x150
[  858.946695] [c000000009ec3900] [c000000000fecce4] io_schedule+0x54/0x80
[  858.946700] [c000000009ec3930] [c0000000007fb1fc] rq_qos_wait+0xfc/0x1e0
[  858.946706] [c000000009ec39e0] [c0000000008278a4] wbt_wait+0xd4/0x170
[  858.946711] [c000000009ec3a40] [c0000000007fab64] __rq_qos_throttle+0x54/0x80
[  858.946718] [c000000009ec3a70] [c0000000007df0dc] blk_mq_get_new_requests+0xfc/0x270
[  858.946724] [c000000009ec3b00] [c0000000007e4e6c] blk_mq_submit_bio+0x37c/0x580
[  858.946731] [c000000009ec3b60] [c0000000007cd830] __submit_bio+0x30/0x250
[  858.946737] [c000000009ec3b90] [c0000000007ce110] submit_bio_noacct_nocheck+0x140/0x260
[  858.946743] [c000000009ec3c00] [c008000001557a2c] xfs_buf_ioapply_map+0x2b4/0x2d0 [xfs]
[  858.946842] [c000000009ec3ca0] [c008000001557b54] _xfs_buf_ioapply+0x10c/0x200 [xfs]
[  858.946939] [c000000009ec3d60] [c008000001559880] __xfs_buf_submit+0x88/0x260 [xfs]
[  858.947038] [c000000009ec3da0] [c00800000155a2e0] xfs_buf_delwri_submit_buffers+0x138/0x2d0 [xfs]
[  858.947135] [c000000009ec3e30] [c0080000015afb10] xfsaild_push+0x1e8/0x7f0 [xfs]
[  858.947234] [c000000009ec3f10] [c0080000015b0240] xfsaild+0x128/0x260 [xfs]
[  858.947332] [c000000009ec3f90] [c00000000019c2e8] kthread+0x138/0x140
[  858.947338] [c000000009ec3fe0] [c00000000000df98] start_kernel_thread+0x14/0x18
[  858.947379] INFO: task kworker/u258:3:1931 blocked for more than 122 seconds.
[  858.947384]       Tainted: G            E      6.5.0-next-20230907-dirty #16
[  858.947388] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[  858.947391] task:kworker/u258:3  state:D stack:0     pid:1931  ppid:2      flags:0x00000080
[  858.947398] Workqueue: xfs-blockgc/sda3 xfs_blockgc_worker [xfs]
[  858.947497] Call Trace:
[  858.947500] [c00000000ae829a0] [c00000000001fc9c] __switch_to+0x13c/0x220
[  858.947506] [c00000000ae82a00] [c000000000fec5b0] __schedule+0x260/0x7c0
[  858.947511] [c00000000ae82ad0] [c000000000fecb84] schedule+0x74/0x150
[  858.947517] [c00000000ae82b40] [c000000000fecce4] io_schedule+0x54/0x80
[  858.947522] [c00000000ae82b70] [c0000000007fb1fc] rq_qos_wait+0xfc/0x1e0
[  858.947528] [c00000000ae82c20] [c0000000008278a4] wbt_wait+0xd4/0x170
[  858.947533] [c00000000ae82c80] [c0000000007fab64] __rq_qos_throttle+0x54/0x80
[  858.947539] [c00000000ae82cb0] [c0000000007df0dc] blk_mq_get_new_requests+0xfc/0x270
[  858.947546] [c00000000ae82d40] [c0000000007e4e6c] blk_mq_submit_bio+0x37c/0x580
[  858.947553] [c00000000ae82da0] [c0000000007cd830] __submit_bio+0x30/0x250
[  858.947559] [c00000000ae82dd0] [c0000000007ce110] submit_bio_noacct_nocheck+0x140/0x260
[  858.947566] [c00000000ae82e40] [c000000000519400] __swap_writepage+0x190/0x260
[  858.947573] [c00000000ae82e80] [c00000000051953c] swap_writepage+0x6c/0x110
[  858.947579] [c00000000ae82eb0] [c000000000486c4c] pageout+0x10c/0x3c0
[  858.947586] [c00000000ae82fa0] [c000000000487764] shrink_folio_list+0x864/0xe50
[  858.947591] [c00000000ae830b0] [c000000000489e48] shrink_inactive_list+0x268/0x680
[  858.947597] [c00000000ae83170] [c00000000048a3a8] shrink_lruvec+0x148/0x440
[  858.947602] [c00000000ae83260] [c00000000048a8f4] shrink_node_memcgs+0x254/0x2b0
[  858.947607] [c00000000ae832c0] [c00000000048aa2c] shrink_node+0xdc/0x4d0
[  858.947612] [c00000000ae83350] [c00000000048bd54] shrink_zones.constprop.0+0xd4/0x400
[  858.947617] [c00000000ae833d0] [c00000000048c198] do_try_to_free_pages+0x118/0x480
[  858.947623] [c00000000ae83450] [c00000000048cf5c] try_to_free_pages+0x13c/0x280
[  858.947628] [c00000000ae83510] [c000000000508d00] __alloc_pages_slowpath.constprop.0+0x3f0/0xb70
[  858.947636] [c00000000ae83660] [c000000000509690] __alloc_pages+0x210/0x2b0
[  858.947643] [c00000000ae836f0] [c00000000053eb58] alloc_pages+0xd8/0x1d0
[  858.947649] [c00000000ae83740] [c000000000553b18] allocate_slab+0x368/0x4b0
[  858.947655] [c00000000ae83800] [c000000000556b50] ___slab_alloc+0x440/0x890
[  858.947661] [c00000000ae83910] [c0000000005578a8] kmem_cache_alloc+0x438/0x4a0
[  858.947668] [c00000000ae83980] [c008000001509b70] xfs_bmbt_init_cursor+0x98/0x220 [xfs]
[  858.947764] [c00000000ae839e0] [c008000001507684] __xfs_bunmapi+0x75c/0x810 [xfs]
[  858.947859] [c00000000ae83ae0] [c00800000157a07c] xfs_itruncate_extents_flags+0xf4/0x2e0 [xfs]
[  858.947959] [c00000000ae83b60] [c0080000015544dc] xfs_free_eofblocks+0x114/0x1a0 [xfs]
[  858.948057] [c00000000ae83bb0] [c00800000156a748] xfs_inode_free_eofblocks.constprop.0+0x1c0/0x1d0 [xfs]
[  858.948155] [c00000000ae83bf0] [c00800000156ad34] xfs_icwalk_ag+0x20c/0x590 [xfs]
[  858.948253] [c00000000ae83dc0] [c00800000156b810] xfs_blockgc_worker+0x48/0x190 [xfs]
[  858.948350] [c00000000ae83e50] [c00000000018d4ec] process_one_work+0x1ec/0x4a0
[  858.948357] [c00000000ae83ef0] [c00000000018db5c] worker_thread+0x3bc/0x590
[  858.948363] [c00000000ae83f90] [c00000000019c2e8] kthread+0x138/0x140
[  858.948369] [c00000000ae83fe0] [c00000000000df98] start_kernel_thread+0x14/0x18
[  982.000135] INFO: task kworker/u260:0:178 blocked for more than 368 seconds.
[  982.000159]       Tainted: G            E      6.5.0-next-20230907-dirty #16
[  982.000165] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[  982.000169] task:kworker/u260:0  state:D stack:0     pid:178   ppid:2      flags:0x00000000
[  982.000179] Workqueue: writeback wb_workfn (flush-8:0)
[  982.000192] Call Trace:
[  982.000195] [c0000000080e32a0] [c0000000080e3500] 0xc0000000080e3500 (unreliable)
[  982.000205] [c0000000080e3450] [c00000000001fc9c] __switch_to+0x13c/0x220
[  982.000215] [c0000000080e34b0] [c000000000fec5b0] __schedule+0x260/0x7c0
[  982.000223] [c0000000080e3580] [c000000000fecb84] schedule+0x74/0x150
[  982.000229] [c0000000080e35f0] [c000000000fecce4] io_schedule+0x54/0x80
[  982.000236] [c0000000080e3620] [c0000000007fb1fc] rq_qos_wait+0xfc/0x1e0
[  982.000245] [c0000000080e36d0] [c0000000008278a4] wbt_wait+0xd4/0x170
[  982.000252] [c0000000080e3730] [c0000000007fab64] __rq_qos_throttle+0x54/0x80
[  982.000260] [c0000000080e3760] [c0000000007df0dc] blk_mq_get_new_requests+0xfc/0x270
[  982.000269] [c0000000080e37f0] [c0000000007e4e6c] blk_mq_submit_bio+0x37c/0x580
[  982.000278] [c0000000080e3850] [c0000000007cd830] __submit_bio+0x30/0x250
[  982.000286] [c0000000080e3880] [c0000000007ce110] submit_bio_noacct_nocheck+0x140/0x260
[  982.000295] [c0000000080e38f0] [c000000000675a0c] iomap_submit_ioend+0x8c/0xf0
[  982.000304] [c0000000080e3930] [c00800000154fc20] xfs_vm_writepages+0xc8/0x140 [xfs]
[  982.000420] [c0000000080e39e0] [c0000000004768d0] do_writepages+0xc0/0x290
[  982.000426] [c0000000080e3a60] [c00000000061553c] __writeback_single_inode+0x6c/0x500
[  982.000432] [c0000000080e3ab0] [c0000000006160cc] writeback_sb_inodes+0x2dc/0x6d0
[  982.000438] [c0000000080e3bd0] [c000000000616544] __writeback_inodes_wb+0x84/0x1a0
[  982.000443] [c0000000080e3c40] [c0000000006169bc] wb_writeback+0x35c/0x4b0
[  982.000449] [c0000000080e3d00] [c000000000618274] wb_workfn+0x3a4/0x6f0
[  982.000454] [c0000000080e3e50] [c00000000018d4ec] process_one_work+0x1ec/0x4a0
[  982.000462] [c0000000080e3ef0] [c00000000018db5c] worker_thread+0x3bc/0x590
[  982.000468] [c0000000080e3f90] [c00000000019c2e8] kthread+0x138/0x140
[  982.000474] [c0000000080e3fe0] [c00000000000df98] start_kernel_thread+0x14/0x18
[  982.000484] INFO: task kworker/u257:1:189 blocked for more than 245 seconds.
[  982.000488]       Tainted: G            E      6.5.0-next-20230907-dirty #16
[  982.000492] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[  982.000496] task:kworker/u257:1  state:D stack:0     pid:189   ppid:2      flags:0x00000000
[  982.000503] Workqueue: writeback wb_workfn (flush-8:0)
[  982.000508] Call Trace:
[  982.000510] [c000000008ee7450] [c00000000001fc9c] __switch_to+0x13c/0x220
[  982.000517] [c000000008ee74b0] [c000000000fec5b0] __schedule+0x260/0x7c0
[  982.000522] [c000000008ee7580] [c000000000fecb84] schedule+0x74/0x150
[  982.000527] [c000000008ee75f0] [c000000000fecce4] io_schedule+0x54/0x80
[  982.000532] [c000000008ee7620] [c0000000007fb1fc] rq_qos_wait+0xfc/0x1e0
[  982.000539] [c000000008ee76d0] [c0000000008278a4] wbt_wait+0xd4/0x170
[  982.000543] [c000000008ee7730] [c0000000007fab64] __rq_qos_throttle+0x54/0x80
[  982.000550] [c000000008ee7760] [c0000000007df0dc] blk_mq_get_new_requests+0xfc/0x270
[  982.000557] [c000000008ee77f0] [c0000000007e4e6c] blk_mq_submit_bio+0x37c/0x580
[  982.000563] [c000000008ee7850] [c0000000007cd830] __submit_bio+0x30/0x250
[  982.000570] [c000000008ee7880] [c0000000007ce110] submit_bio_noacct_nocheck+0x140/0x260
[  982.000576] [c000000008ee78f0] [c000000000675a0c] iomap_submit_ioend+0x8c/0xf0
[  982.000583] [c000000008ee7930] [c00800000154fc20] xfs_vm_writepages+0xc8/0x140 [xfs]
[  982.000681] [c000000008ee79e0] [c0000000004768d0] do_writepages+0xc0/0x290
[  982.000686] [c000000008ee7a60] [c00000000061553c] __writeback_single_inode+0x6c/0x500
[  982.000692] [c000000008ee7ab0] [c0000000006160cc] writeback_sb_inodes+0x2dc/0x6d0
[  982.000698] [c000000008ee7bd0] [c000000000616544] __writeback_inodes_wb+0x84/0x1a0
[  982.000703] [c000000008ee7c40] [c0000000006169bc] wb_writeback+0x35c/0x4b0
[  982.000708] [c000000008ee7d00] [c000000000618274] wb_workfn+0x3a4/0x6f0
[  982.000714] [c000000008ee7e50] [c00000000018d4ec] process_one_work+0x1ec/0x4a0
[  982.000720] [c000000008ee7ef0] [c00000000018db5c] worker_thread+0x3bc/0x590
[  982.000726] [c000000008ee7f90] [c00000000019c2e8] kthread+0x138/0x140
[  982.000732] [c000000008ee7fe0] [c00000000000df98] start_kernel_thread+0x14/0x18
[  982.000775] INFO: task xfsaild/sda3:623 blocked for more than 245 seconds.
[  982.000779]       Tainted: G            E      6.5.0-next-20230907-dirty #16
[  982.000782] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[  982.000786] task:xfsaild/sda3    state:D stack:0     pid:623   ppid:2      flags:0x00000000
[  982.000792] Call Trace:
[  982.000795] [c000000009ec35b0] [0000000000004000] 0x4000 (unreliable)
[  982.000800] [c000000009ec3760] [c00000000001fc9c] __switch_to+0x13c/0x220
[  982.000807] [c000000009ec37c0] [c000000000fec5b0] __schedule+0x260/0x7c0
[  982.000812] [c000000009ec3890] [c000000000fecb84] schedule+0x74/0x150
[  982.000817] [c000000009ec3900] [c000000000fecce4] io_schedule+0x54/0x80
[  982.000822] [c000000009ec3930] [c0000000007fb1fc] rq_qos_wait+0xfc/0x1e0
[  982.000829] [c000000009ec39e0] [c0000000008278a4] wbt_wait+0xd4/0x170
[  982.000833] [c000000009ec3a40] [c0000000007fab64] __rq_qos_throttle+0x54/0x80
[  982.000840] [c000000009ec3a70] [c0000000007df0dc] blk_mq_get_new_requests+0xfc/0x270
[  982.000847] [c000000009ec3b00] [c0000000007e4e6c] blk_mq_submit_bio+0x37c/0x580
[  982.000853] [c000000009ec3b60] [c0000000007cd830] __submit_bio+0x30/0x250
[  982.000859] [c000000009ec3b90] [c0000000007ce110] submit_bio_noacct_nocheck+0x140/0x260
[  982.000866] [c000000009ec3c00] [c008000001557a2c] xfs_buf_ioapply_map+0x2b4/0x2d0 [xfs]
[  982.000964] [c000000009ec3ca0] [c008000001557b54] _xfs_buf_ioapply+0x10c/0x200 [xfs]
[  982.001062] [c000000009ec3d60] [c008000001559880] __xfs_buf_submit+0x88/0x260 [xfs]
[  982.001159] [c000000009ec3da0] [c00800000155a2e0] xfs_buf_delwri_submit_buffers+0x138/0x2d0 [xfs]
[  982.001257] [c000000009ec3e30] [c0080000015afb10] xfsaild_push+0x1e8/0x7f0 [xfs]
[  982.001354] [c000000009ec3f10] [c0080000015b0240] xfsaild+0x128/0x260 [xfs]
[  982.001451] [c000000009ec3f90] [c00000000019c2e8] kthread+0x138/0x140
[  982.001457] [c000000009ec3fe0] [c00000000000df98] start_kernel_thread+0x14/0x18
[  982.001482] INFO: task systemd-logind:1041 blocked for more than 123 seconds.
[  982.001486]       Tainted: G            E      6.5.0-next-20230907-dirty #16
[  982.001490] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[  982.001494] task:systemd-logind  state:D stack:0     pid:1041  ppid:1      flags:0x00042480
[  982.001500] Call Trace:
[  982.001502] [c000000009dd6a20] [c000000009dd6ac0] 0xc000000009dd6ac0 (unreliable)
[  982.001508] [c000000009dd6bd0] [c00000000001fc9c] __switch_to+0x13c/0x220
[  982.001514] [c000000009dd6c30] [c000000000fec5b0] __schedule+0x260/0x7c0
[  982.001520] [c000000009dd6d00] [c000000000fecb84] schedule+0x74/0x150
[  982.001525] [c000000009dd6d70] [c000000000fecce4] io_schedule+0x54/0x80
[  982.001530] [c000000009dd6da0] [c0000000007fb1fc] rq_qos_wait+0xfc/0x1e0
[  982.001536] [c000000009dd6e50] [c0000000008278a4] wbt_wait+0xd4/0x170
[  982.001541] [c000000009dd6eb0] [c0000000007fab64] __rq_qos_throttle+0x54/0x80
[  982.001548] [c000000009dd6ee0] [c0000000007df0dc] blk_mq_get_new_requests+0xfc/0x270
[  982.001555] [c000000009dd6f70] [c0000000007e4e6c] blk_mq_submit_bio+0x37c/0x580
[  982.001561] [c000000009dd6fd0] [c0000000007cd830] __submit_bio+0x30/0x250
[  982.001568] [c000000009dd7000] [c0000000007ce110] submit_bio_noacct_nocheck+0x140/0x260
[  982.001574] [c000000009dd7070] [c000000000519400] __swap_writepage+0x190/0x260
[  982.001581] [c000000009dd70b0] [c00000000051953c] swap_writepage+0x6c/0x110
[  982.001587] [c000000009dd70e0] [c000000000486c4c] pageout+0x10c/0x3c0
[  982.001594] [c000000009dd71d0] [c000000000487764] shrink_folio_list+0x864/0xe50
[  982.001600] [c000000009dd72e0] [c000000000489e48] shrink_inactive_list+0x268/0x680
[  982.001605] [c000000009dd73a0] [c00000000048a3a8] shrink_lruvec+0x148/0x440
[  982.001610] [c000000009dd7490] [c00000000048a8f4] shrink_node_memcgs+0x254/0x2b0
[  982.001616] [c000000009dd74f0] [c00000000048aa2c] shrink_node+0xdc/0x4d0
[  982.001621] [c000000009dd7580] [c00000000048bd54] shrink_zones.constprop.0+0xd4/0x400
[  982.001627] [c000000009dd7600] [c00000000048c198] do_try_to_free_pages+0x118/0x480
[  982.001632] [c000000009dd7680] [c00000000048cf5c] try_to_free_pages+0x13c/0x280
[  982.001638] [c000000009dd7740] [c000000000508d00] __alloc_pages_slowpath.constprop.0+0x3f0/0xb70
[  982.001646] [c000000009dd7890] [c000000000509690] __alloc_pages+0x210/0x2b0
[  982.001652] [c000000009dd7920] [c00000000053eb58] alloc_pages+0xd8/0x1d0
[  982.001658] [c000000009dd7970] [c000000000553b18] allocate_slab+0x368/0x4b0
[  982.001665] [c000000009dd7a30] [c000000000556b50] ___slab_alloc+0x440/0x890
[  982.001671] [c000000009dd7b40] [c0000000005578a8] kmem_cache_alloc+0x438/0x4a0
[  982.001677] [c000000009dd7bb0] [c000000000ca82d8] sk_prot_alloc+0x58/0x200
[  982.001684] [c000000009dd7c00] [c000000000cab8d4] sk_alloc+0x54/0x240
[  982.001690] [c000000009dd7c50] [c000000000eb36c0] unix_create1+0xb0/0x350
[  982.001696] [c000000009dd7cc0] [c000000000eb39c8] unix_create+0x68/0x120
[  982.001701] [c000000009dd7ce0] [c000000000ca1088] __sock_create+0x138/0x2e0
[  982.001708] [c000000009dd7d90] [c000000000ca4210] __sys_socket+0xc0/0x190
[  982.001715] [c000000009dd7df0] [c000000000ca430c] sys_socket+0x2c/0x40
[  982.001721] [c000000009dd7e10] [c000000000034148] system_call_exception+0x138/0x330
[  982.001728] [c000000009dd7e50] [c00000000000d05c] system_call_vectored_common+0x15c/0x2ec
[  982.001735] --- interrupt: 3000 at 0x7fffa835715c
[  982.001739] NIP:  00007fffa835715c LR: 0000000000000000 CTR: 0000000000000000
[  982.001744] REGS: c000000009dd7e80 TRAP: 3000   Tainted: G            E       (6.5.0-next-20230907-dirty)
[  982.001749] MSR:  800000000000d033 <SF,EE,PR,ME,IR,DR,RI,LE>  CR: 44042804  XER: 00000000
[  982.001761] IRQMASK: 0 
[  982.001761] GPR00: 0000000000000146 00007fffd7ab6460 00007fffa8a37500 0000000000000001 
[  982.001761] GPR04: 0000000000080002 0000000000000000 0400000000000000 0000000000000054 
[  982.001761] GPR08: 0000000000000000 0000000000000000 0000000000000000 0000000000000000 
[  982.001761] GPR12: 0000000000000000 00007fffa8be4ba0 0000000000000001 000000000000000b 
[  982.001761] GPR16: 0000000000000000 0000000001000005 0000000173a31498 8000000000000000 
[  982.001761] GPR20: 00007fffd7ab6608 7fffffffffffffff 20c49ba5e353f7cf 000000007ffffffe 
[  982.001761] GPR24: 000000007fffffff 0000000000000000 0000000000000000 0000000000000000 
[  982.001761] GPR28: 00007fffa898a498 0000000000000000 0000000000000016 00007fffd7ab6460 
[  982.001814] NIP [00007fffa835715c] 0x7fffa835715c
[  982.001817] LR [0000000000000000] 0x0
[  982.001820] --- interrupt: 3000
[  982.001839] INFO: task kworker/u258:3:1931 blocked for more than 245 seconds.
[  982.001843]       Tainted: G            E      6.5.0-next-20230907-dirty #16
[  982.001847] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[  982.001850] task:kworker/u258:3  state:D stack:0     pid:1931  ppid:2      flags:0x00000080
[  982.001857] Workqueue: xfs-blockgc/sda3 xfs_blockgc_worker [xfs]
[  982.001956] Call Trace:
[  982.001958] [c00000000ae829a0] [c00000000001fc9c] __switch_to+0x13c/0x220
[  982.001964] [c00000000ae82a00] [c000000000fec5b0] __schedule+0x260/0x7c0
[  982.001970] [c00000000ae82ad0] [c000000000fecb84] schedule+0x74/0x150
[  982.001975] [c00000000ae82b40] [c000000000fecce4] io_schedule+0x54/0x80
[  982.001980] [c00000000ae82b70] [c0000000007fb1fc] rq_qos_wait+0xfc/0x1e0
[  982.001986] [c00000000ae82c20] [c0000000008278a4] wbt_wait+0xd4/0x170
[  982.001991] [c00000000ae82c80] [c0000000007fab64] __rq_qos_throttle+0x54/0x80
[  982.001998] [c00000000ae82cb0] [c0000000007df0dc] blk_mq_get_new_requests+0xfc/0x270
[  982.002004] [c00000000ae82d40] [c0000000007e4e6c] blk_mq_submit_bio+0x37c/0x580
[  982.002011] [c00000000ae82da0] [c0000000007cd830] __submit_bio+0x30/0x250
[  982.002017] [c00000000ae82dd0] [c0000000007ce110] submit_bio_noacct_nocheck+0x140/0x260
[  982.002023] [c00000000ae82e40] [c000000000519400] __swap_writepage+0x190/0x260
[  982.002030] [c00000000ae82e80] [c00000000051953c] swap_writepage+0x6c/0x110
[  982.002035] [c00000000ae82eb0] [c000000000486c4c] pageout+0x10c/0x3c0
[  982.002042] [c00000000ae82fa0] [c000000000487764] shrink_folio_list+0x864/0xe50
[  982.002047] [c00000000ae830b0] [c000000000489e48] shrink_inactive_list+0x268/0x680
[  982.002053] [c00000000ae83170] [c00000000048a3a8] shrink_lruvec+0x148/0x440
[  982.002058] [c00000000ae83260] [c00000000048a8f4] shrink_node_memcgs+0x254/0x2b0
[  982.002063] [c00000000ae832c0] [c00000000048aa2c] shrink_node+0xdc/0x4d0
[  982.002068] [c00000000ae83350] [c00000000048bd54] shrink_zones.constprop.0+0xd4/0x400
[  982.002074] [c00000000ae833d0] [c00000000048c198] do_try_to_free_pages+0x118/0x480
[  982.002079] [c00000000ae83450] [c00000000048cf5c] try_to_free_pages+0x13c/0x280
[  982.002084] [c00000000ae83510] [c000000000508d00] __alloc_pages_slowpath.constprop.0+0x3f0/0xb70
[  982.002092] [c00000000ae83660] [c000000000509690] __alloc_pages+0x210/0x2b0
[  982.002098] [c00000000ae836f0] [c00000000053eb58] alloc_pages+0xd8/0x1d0
[  982.002104] [c00000000ae83740] [c000000000553b18] allocate_slab+0x368/0x4b0
[  982.002110] [c00000000ae83800] [c000000000556b50] ___slab_alloc+0x440/0x890
[  982.002116] [c00000000ae83910] [c0000000005578a8] kmem_cache_alloc+0x438/0x4a0
[  982.002122] [c00000000ae83980] [c008000001509b70] xfs_bmbt_init_cursor+0x98/0x220 [xfs]
[  982.002218] [c00000000ae839e0] [c008000001507684] __xfs_bunmapi+0x75c/0x810 [xfs]
[  982.002314] [c00000000ae83ae0] [c00800000157a07c] xfs_itruncate_extents_flags+0xf4/0x2e0 [xfs]
[  982.002413] [c00000000ae83b60] [c0080000015544dc] xfs_free_eofblocks+0x114/0x1a0 [xfs]
[  982.002512] [c00000000ae83bb0] [c00800000156a748] xfs_inode_free_eofblocks.constprop.0+0x1c0/0x1d0 [xfs]
[  982.002610] [c00000000ae83bf0] [c00800000156ad34] xfs_icwalk_ag+0x20c/0x590 [xfs]
[  982.002707] [c00000000ae83dc0] [c00800000156b810] xfs_blockgc_worker+0x48/0x190 [xfs]
[  982.002805] [c00000000ae83e50] [c00000000018d4ec] process_one_work+0x1ec/0x4a0
[  982.002811] [c00000000ae83ef0] [c00000000018db5c] worker_thread+0x3bc/0x590
[  982.002817] [c00000000ae83f90] [c00000000019c2e8] kthread+0x138/0x140
[  982.002823] [c00000000ae83fe0] [c00000000000df98] start_kernel_thread+0x14/0x18
[  982.002828] Future hung task reports are suppressed, see sysctl kernel.hung_task_warnings
Sending SIGKILL to test process...
Sending SIGKILL to test process...
Sending SIGKILL to test process...
tst_test.c:1606: TINFO: Killed the leftover descendant processes
tst_test.c:1612: TINFO: If you are running on slow machine, try exporting LTP_TIMEOUT_MUL > 1
tst_test.c:1614: TBROK: Test killed! (timeout?)

Summary:
passed   0
failed   0
broken   1
skipped  0
warnings 0





--Apple-Mail=_3CF225EC-76D5-4445-AF51-6AB83E2471F3--


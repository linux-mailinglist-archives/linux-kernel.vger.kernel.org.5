Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22B6881157F
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 16:02:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442079AbjLMPCL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 10:02:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442024AbjLMPCK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 10:02:10 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1319D83;
        Wed, 13 Dec 2023 07:02:15 -0800 (PST)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BDELKdC022454;
        Wed, 13 Dec 2023 15:01:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=WUqGMWDQsotOfJsdMdUdUke3R0PN1jxvlT3CqFRehkM=;
 b=aE87hCYrJqeR/Q9CJPvk1HYBdKFIbpG8+DF3cjUDleBAh7vd4YQaJ6LyDe5FAtppjp/S
 XulsAGB5Gr4VWL/dZppypjurebXGNQdQhjY3QCNBUEpdpFJuEmtE0/nxs6ulLX8+MV0v
 PZZDOr33ax2ZKQqeBzPWzdOZor58of9R5m7bAPyIyBKcYgeIGukLWj07L5602WkMJrTu
 uEuyhN00ffUJHwPT/ZOxBykoPZcpceZ97TKmqDShgx0BPzf4QHlxvnm9JtyrnDhaaTYx
 EpsXozQynRZaHSUbCOywQcdr/spouf02RT/gfAAB1jngjXY3hBswgI9RvTY2/Yw/MFB3 RQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3uyd9qb1rw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 13 Dec 2023 15:01:52 +0000
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3BDELZV8024068;
        Wed, 13 Dec 2023 15:01:51 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3uyd9qb1qr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 13 Dec 2023 15:01:51 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
        by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3BDEGiPt008450;
        Wed, 13 Dec 2023 15:01:50 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
        by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3uw2jtht35-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 13 Dec 2023 15:01:50 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
        by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3BDF1lpD24052302
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Dec 2023 15:01:47 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 08F3B2004E;
        Wed, 13 Dec 2023 15:01:47 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A027920043;
        Wed, 13 Dec 2023 15:01:45 +0000 (GMT)
Received: from [9.171.70.156] (unknown [9.171.70.156])
        by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Wed, 13 Dec 2023 15:01:45 +0000 (GMT)
Message-ID: <0bd0f6f9d0c6ff454739f38d6661fdda662afcca.camel@linux.ibm.com>
Subject: Re: [PATCH v2 12/33] kmsan: Allow disabling KMSAN checks for the
 current task
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Alexander Potapenko <glider@google.com>
Cc:     Alexander Gordeev <agordeev@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Marco Elver <elver@google.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Pekka Enberg <penberg@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-s390@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Sven Schnelle <svens@linux.ibm.com>
Date:   Wed, 13 Dec 2023 16:01:45 +0100
In-Reply-To: <CAG_fn=VaJtMogdmehJoYmZRNrs5AXYs+ZwBTu3TQQVaSkFNzcw@mail.gmail.com>
References: <20231121220155.1217090-1-iii@linux.ibm.com>
         <20231121220155.1217090-13-iii@linux.ibm.com>
         <CAG_fn=VaJtMogdmehJoYmZRNrs5AXYs+ZwBTu3TQQVaSkFNzcw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: ahpnbjqfUrHjRu_h2faEroNfAjnwxAiU
X-Proofpoint-ORIG-GUID: DbOOs6ZkGakRHkgEME2dN21fy0MBcb1e
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-13_08,2023-12-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 impostorscore=0 malwarescore=0 clxscore=1015 phishscore=0 adultscore=0
 spamscore=0 mlxlogscore=553 priorityscore=1501 bulkscore=0
 lowpriorityscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2311290000 definitions=main-2312130106
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2023-12-11 at 12:50 +0100, Alexander Potapenko wrote:
> On Tue, Nov 21, 2023 at 11:06=E2=80=AFPM Ilya Leoshkevich <iii@linux.ibm.=
com>
> wrote:
> >=20
> > Like for KASAN, it's useful to temporarily disable KMSAN checks
> > around,
> > e.g., redzone accesses. Introduce kmsan_disable_current() and
> > kmsan_enable_current(), which are similar to their KASAN
> > counterparts.
>=20
> Initially we used to have this disablement counter in KMSAN, but
> adding it uncontrollably can result in KMSAN not functioning
> properly.
> E.g. forgetting to call kmsan_disable_current() or underflowing the
> counter will break reporting.
> We'd better put this API in include/linux/kmsan.h to indicate it
> should be discouraged.
>=20
> > Even though it's not strictly necessary, make them reentrant, in
> > order
> > to match the KASAN behavior.
>=20
> Until this becomes strictly necessary, I think we'd better
> KMSAN_WARN_ON if the counter is re-entered.

I encountered a case when we are freeing memory from an interrupt
handler:

[  149.840553] ------------[ cut here ]------------                  =20
[  149.840649] WARNING: CPU: 1 PID: 181 at mm/kmsan/hooks.c:447
kmsan_disable_current+0x2e/0x40                                      =20
[  149.840790] Modules linked in:                                    =20
[  149.840894] CPU: 1 PID: 181 Comm: (direxec) Tainted: G    B   W   =20
N 6.7.0-rc5-gd34a4b46f382 #13
[  149.841003] Hardware name: IBM 3931 A01 704 (KVM/Linux)    =20
[  149.841094] Krnl PSW : 0404c00180000000 000000000197dbc2
(kmsan_disable_current+0x32/0x40)
[  149.841276]            R:0 T:1 IO:0 EX:0 Key:0 M:1 W:0 P:0 AS:3 CC:0
PM:0 RI:0 EA:3
[  149.841420] Krnl GPRS: 0000000000000040 0000000096914100
0000000000001000 0000000000000001
[  149.841518]            0000036d827daee0 0000000007c97008
0000000080096500 0000000092f4f000
[  149.841617]            0000036d00000000 0000000000000000
0000000000000040 0000000000000000
[  149.841712]            0000000092f4efc0 00000001ff710f60
000000000193acba 0000037f0008f710
[  149.841893] Krnl Code: 000000000197dbb6: eb0018640352        mviy =20
14436(%r1),0
[  149.841893]            000000000197dbbc: 07fe                bcr  =20
15,%r14
[  149.841893]           #000000000197dbbe: af000000            mc   =20
0,0
[  149.841893]           >000000000197dbc2: a7f4fffa            brc  =20
15,000000000197dbb6
[  149.841893]            000000000197dbc6: 0700                bcr  =20
0,%r0
[  149.841893]            000000000197dbc8: 0700                bcr  =20
0,%r0
[  149.841893]            000000000197dbca: 0700                bcr  =20
0,%r0
[  149.841893]            000000000197dbcc: 0700                bcr  =20
0,%r0
[  149.842438] Call Trace:                                           =20
15:37:25 [90/1838]
[  149.842510]  [<000000000197dbc2>] kmsan_disable_current+0x32/0x40=20
[  149.842631] ([<000000000193ac14>] slab_pad_check+0x1d4/0xac0)
[  149.842738]  [<0000000001949222>] free_to_partial_list+0x1d72/0x3b80
[  149.842850]  [<0000000001947066>] __slab_free+0xd86/0x11d0=20
[  149.842956]  [<00000000019111e8>] kmem_cache_free+0x15d8/0x25d0=20
[  149.843062]  [<0000000000229e3a>] __tlb_remove_table+0x20a/0xa50=20
[  149.843174]  [<00000000016c7f98>] tlb_remove_table_rcu+0x98/0x120=20
[  149.843291]  [<000000000083e1c6>] rcu_core+0x15b6/0x54b0=20
[  149.843406]  [<00000000069c3c0e>] __do_softirq+0xa1e/0x2178=20
[  149.843514]  [<00000000003467b4>] irq_exit_rcu+0x2c4/0x630=20
[  149.843623]  [<0000000006949f6e>] do_ext_irq+0x9e/0x120=20
[  149.843736]  [<00000000069c18d4>] ext_int_handler+0xc4/0xf0=20
[  149.843841]  [<000000000197e428>] kmsan_get_metadata+0x68/0x280=20
[  149.843950]  [<000000000197e344>]
kmsan_get_shadow_origin_ptr+0x74/0xf0=20
[  149.844071]  [<000000000197ba3a>]
__msan_metadata_ptr_for_load_8+0x2a/0x40=20
[  149.844192]  [<0000000000184e4a>]
unwind_get_return_address+0xda/0x150=20
[  149.844313]  [<000000000018fd12>] arch_stack_walk+0x172/0x2f0=20
[  149.844417]  [<00000000008f1af0>] stack_trace_save+0x100/0x160=20
[  149.844529]  [<000000000197af22>]
kmsan_internal_chain_origin+0x62/0xe0=20
[  149.844647]  [<000000000197c1f0>] __msan_chain_origin+0xd0/0x160=20
[  149.844763]  [<00000000068b3ba4>] memchr_inv+0x5b4/0xb20=20
[  149.844877]  [<000000000193e730>] check_bytes_and_report+0xa0/0xd30=20
[  149.844986]  [<000000000193b920>] check_object+0x420/0x17d0=20
[  149.845092]  [<000000000194aa8a>] free_to_partial_list+0x35da/0x3b80
[  149.845202]  [<0000000001947066>] __slab_free+0xd86/0x11d0=20
[  149.845308]  [<00000000019111e8>] kmem_cache_free+0x15d8/0x25d0=20
[  149.845414]  [<00000000016bc2fe>] exit_mmap+0x87e/0x1200=20
[  149.845524]  [<00000000002f315c>] mmput+0x13c/0x5b0=20
[  149.845632]  [<0000000001b9d634>] exec_mmap+0xc34/0x1230=20
[  149.845744]  [<0000000001b996c2>] begin_new_exec+0xcf2/0x2520=20
[  149.845857]  [<0000000001f6a084>] load_elf_binary+0x2364/0x67d0=20
[  149.845971]  [<0000000001ba5ba4>] bprm_execve+0x25b4/0x4010=20
[  149.846083]  [<0000000001baa7e6>] do_execveat_common+0x2436/0x2600=20
[  149.846200]  [<0000000001ba78f8>] __s390x_sys_execve+0x108/0x140=20
[  149.846314]  [<000000000011b192>] do_syscall+0x4c2/0x690=20
[  149.846424]  [<0000000006949d78>] __do_syscall+0x98/0xe0=20
[  149.846536]  [<00000000069c1640>] system_call+0x70/0xa0=20
[  149.846638] INFO: lockdep is turned off.
[  149.846846] Last Breaking-Event-Address:
[  149.846916]  [<000000000197dbb2>] kmsan_disable_current+0x22/0x40
[  149.847057] irq event stamp: 0
[  149.847128] hardirqs last  enabled at (0): [<0000000000000000>] 0x0
[  149.847227] hardirqs last disabled at (0): [<00000000002f8f46>]
copy_process+0x21f6/0x8b20
[  149.847344] softirqs last  enabled at (0): [<00000000002f8f80>]
copy_process+0x2230/0x8b20
[  149.847461] softirqs last disabled at (0): [<0000000000000000>] 0x0
[  149.847559] ---[ end trace 0000000000000000 ]---
[  149.865485] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D

Using a counter resolves this issue, but, of course, at the expense of
not reporting valid issues in the interrupt handler.

Unfortunately I don't see another easy way to solve this problem. The
possibilities that come to mind are providing uninstrumented
memchr_inv() or disablement flags for each context, but I'm not sure if
we want to go there, especially since KASAN already has this
limitation.

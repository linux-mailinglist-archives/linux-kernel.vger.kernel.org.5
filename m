Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CD7C80E13D
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 03:05:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345630AbjLLCFs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 21:05:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345318AbjLLCFq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 21:05:46 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4B29D1;
        Mon, 11 Dec 2023 18:05:50 -0800 (PST)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BBNMuXi032321;
        Tue, 12 Dec 2023 02:05:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=Ot8KKoxIBjGSb3I4fQ0uzOZ3rMDzR3TKxD9TleX3+9A=;
 b=jA6Nr7J6zehZADQRYlcgUNAParhcaZLMCIynCWSG4T1CCxcihjha9ijlOh55MCgJCiHb
 YbmTeSWM7nuRUvzi/PVuH/z+crlzjAITEIJ6jP1R1yPOk8mBrpQTpdDE2uL30sFUbNmQ
 dStZsKVeOTKgII52Uolt5PA0MRPxnmPgh9v2NQV+uowdrwavs33HEC7MMrwKh8k0zSuw
 TPd5UToK+7GiHDFZhsifwqyE86lRogocOZ8d8tw2qboBlgSjOdNLXtPGyrHdYXd1gOEW
 ZUkA4EFrqGmCQcxhpe1SjlVZ38QF50SdTjUlCkNvSX6xr0zYg7KxY0C2o8usxqI+K44Y yg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3uxc1tjy2r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Dec 2023 02:05:32 +0000
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3BC1oHKZ006324;
        Tue, 12 Dec 2023 02:05:31 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3uxc1tjy27-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Dec 2023 02:05:31 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
        by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3BBN2wVU013869;
        Tue, 12 Dec 2023 02:05:30 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
        by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3uw591w85a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Dec 2023 02:05:30 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
        by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3BC25RGr46989760
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Dec 2023 02:05:27 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 601A520043;
        Tue, 12 Dec 2023 02:05:27 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0EA7920040;
        Tue, 12 Dec 2023 02:05:26 +0000 (GMT)
Received: from [9.171.76.38] (unknown [9.171.76.38])
        by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Tue, 12 Dec 2023 02:05:25 +0000 (GMT)
Message-ID: <3897a38ef97742f7f51fb4c84c5ddeb4e36dae79.camel@linux.ibm.com>
Subject: Re: [PATCH v2 01/33] ftrace: Unpoison ftrace_regs in
 ftrace_ops_list_func()
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Alexander Potapenko <glider@google.com>
Cc:     Alexander Gordeev <agordeev@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Marco Elver <elver@google.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Pekka Enberg <penberg@kernel.org>,
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
Date:   Tue, 12 Dec 2023 03:05:25 +0100
In-Reply-To: <20231208093133.62aae274@gandalf.local.home>
References: <20231121220155.1217090-1-iii@linux.ibm.com>
         <20231121220155.1217090-2-iii@linux.ibm.com>
         <CAG_fn=WHf0t=-OJL0031D+X7cX_D25G7TG0TqROsT34QcEnqsw@mail.gmail.com>
         <20231208093133.62aae274@gandalf.local.home>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: LdRjikzPVMkLwO_P5tClkpAJCESuoSPy
X-Proofpoint-GUID: LtJfjO66RfKFUX7oxZBtF4AB6-D3cx5W
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-11_11,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=884
 lowpriorityscore=0 adultscore=0 priorityscore=1501 mlxscore=0 bulkscore=0
 impostorscore=0 malwarescore=0 clxscore=1015 phishscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2312120015
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2023-12-08 at 09:31 -0500, Steven Rostedt wrote:
> On Fri, 8 Dec 2023 15:16:10 +0100
> Alexander Potapenko <glider@google.com> wrote:
>=20
> > On Tue, Nov 21, 2023 at 11:02=E2=80=AFPM Ilya Leoshkevich
> > <iii@linux.ibm.com> wrote:
> > >=20
> > > Architectures use assembly code to initialize ftrace_regs and
> > > call
> > > ftrace_ops_list_func(). Therefore, from the KMSAN's point of
> > > view,
> > > ftrace_regs is poisoned on ftrace_ops_list_func entry(). This
> > > causes
> > > KMSAN warnings when running the ftrace testsuite.=C2=A0=20
> >=20
> > I couldn't reproduce these warnings on x86, hope you really need
> > this
> > change on s390 :)

I just double-checked, and it's still needed. Without it, I get:

[    4.140184] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D =20
[    4.140416] BUG: KMSAN: uninit-value in
arch_ftrace_ops_list_func+0x8e6/0x14b0           =20
[    4.140484]  arch_ftrace_ops_list_func+0x8e6/0x14b0               =20
[    4.140546]  ftrace_graph_caller+0x0/0x34                         =20
[    4.140614]  read_tod_clock+0x6/0x1e0                             =20
[    4.140671]  ktime_get+0x3a4/0x670                                =20
[    4.140727]  clockevents_program_event+0x1c8/0xb10                =20
[    4.140785]  tick_program_event+0x11e/0x230                       =20
[    4.140842]  hrtimer_interrupt+0x118a/0x1d10                      =20
[    4.140898]  do_IRQ+0x108/0x150                                   =20
[    4.140959]  do_irq_async+0xfc/0x270                              =20
[    4.141021]  do_ext_irq+0x98/0x120                                =20
[    4.141080]  ext_int_handler+0xc4/0xf0                            =20
[    4.141141]  _raw_spin_unlock_irqrestore+0xfa/0x190               =20
[    4.141207]  _raw_spin_unlock_irqrestore+0xf6/0x190               =20
[    4.141271]  s390_kernel_write+0x218/0x250                        =20
[    4.141328]  ftrace_make_call+0x362/0x4a0                         =20
[    4.141386]  __ftrace_replace_code+0xb44/0xbd0                    =20
[    4.141442]  ftrace_replace_code+0x1d8/0x440                      =20
[    4.141497]  ftrace_modify_all_code+0xfe/0x510                    =20
[    4.141555]  ftrace_startup+0x4f0/0xcf0                           =20
[    4.141609]  register_ftrace_function+0x1316/0x1440               =20
[    4.141670]  function_trace_init+0x2c0/0x3d0                      =20
[    4.141732]  tracer_init+0x282/0x370                              =20
[    4.141789]  trace_selftest_startup_function+0x104/0x19d0         =20
[    4.141857]  run_tracer_selftest+0x7c8/0xab0                      =20
[    4.141918]  init_trace_selftests+0x200/0x820
[    4.141977]  do_one_initcall+0x35e/0x1090
[    4.142032]  do_initcall_level+0x276/0x660
[    4.142095]  do_initcalls+0x16a/0x2d0
[    4.142153]  kernel_init_freeable+0x632/0x960
[    4.142216]  kernel_init+0x36/0x1810
[    4.142277]  __ret_from_fork+0xc0/0x180
[    4.142333]  ret_from_fork+0xa/0x30
[    4.142431] Local variable agg.tmp.i.i created at:                =20
02:06:55 [30/1836]
[    4.142476]  timekeeping_advance+0x79a/0x2870
[    4.142394]=20
[    4.142431] Local variable agg.tmp.i.i created at:
[    4.142476]  timekeeping_advance+0x79a/0x2870
[    4.142534]=20
[    4.142573] CPU: 0 PID: 1 Comm: swapper/0 Tainted: G        W     =20
6.7.0-rc4-g7657d31dc545 #4
[    4.142638] Hardware name: IBM 3931 A01 704 (KVM/Linux)
[    4.142686] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
[    4.142734] Kernel panic - not syncing: kmsan.panic set ...
[    4.142734] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D

> On x86, ftrace_regs sits on the stack. And IIUC, s390 doesn't have
> the same
> concept of a "stack" as other architectures. Perhaps that's the
> reason s390
> needs this?

It's not that different on s390x. There is indeed no architecture-
mandated stack pointer and no push/pop, but other than that it's fairly
normal. Linux uses %r15 as a stack pointer.

On s390x ftrace_regs is allocated on stack by mcount.S. From what I can
see, Intel's ftrace_64.S does the same thing, so I don't immediately
see why uninit-value is not detected on Intel, even though I think it
should.

> -- Steve


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C42757EDE46
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 11:14:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344985AbjKPKOk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 05:14:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345040AbjKPKOd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 05:14:33 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C1E3D67;
        Thu, 16 Nov 2023 02:14:28 -0800 (PST)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AGAAM17023971;
        Thu, 16 Nov 2023 10:13:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=Ak1+5JgdIAueV3yIEUMqcop5dQmaB4mQXKLM2e0aWDE=;
 b=NAtPmPLZ4fBwqyAUbx+L2/Vi4ohkA2q3WrfCMYagsiBc+f9SbrJ7m4yNeajpcLW2Hhsq
 dF2LHUfY0ClCk63KcfpH8Z+JMoACkLh5nkcuV/xakb+/gyZP774FOtzT4CqAi8eHDQHr
 VTkOnhu3yq5/WIS9b7eDEhX2oUAVLyRfUjZfGnhYixaRwyZbDd6gvCW2RStREB8HdevT
 pqAA+FJ29k4I0QTIenmUqeTzfPJ79j6F0KEQzUZS/2hot9+kO+aoSMvVHPG2R2zEJWey
 ZLplbdwmN8kS1RHLv2S7eRlxsn2bc+j7xP9slRkEasX0xmbHAenoUsoQKQfWXH1oAwDp 7A== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3udh3b02ns-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Nov 2023 10:13:45 +0000
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3AGAB0vB024892;
        Thu, 16 Nov 2023 10:13:45 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3udh3b02n9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Nov 2023 10:13:45 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3AG8Xiqe000447;
        Thu, 16 Nov 2023 10:13:44 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
        by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3uanekwr7a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Nov 2023 10:13:44 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
        by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3AGADf5f19333700
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 Nov 2023 10:13:41 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 29C552008A;
        Thu, 16 Nov 2023 10:13:41 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C2E9E2008D;
        Thu, 16 Nov 2023 10:13:39 +0000 (GMT)
Received: from [9.179.9.51] (unknown [9.179.9.51])
        by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Thu, 16 Nov 2023 10:13:39 +0000 (GMT)
Message-ID: <7c222eff6c1baaa7647a9aa43a1ef19de9670230.camel@linux.ibm.com>
Subject: Re: [PATCH 00/32] kmsan: Enable on s390
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Alexander Potapenko <glider@google.com>
Cc:     Alexander Gordeev <agordeev@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
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
Date:   Thu, 16 Nov 2023 11:13:39 +0100
In-Reply-To: <CAG_fn=U+X=EE9SSb61E=QDReBXn6PGiX4gJnMfNKsTwQ6saKcA@mail.gmail.com>
References: <20231115203401.2495875-1-iii@linux.ibm.com>
         <CAG_fn=U+X=EE9SSb61E=QDReBXn6PGiX4gJnMfNKsTwQ6saKcA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: RSDRhI5h1HCfVYThrCR4RyNJd2bxpB6O
X-Proofpoint-GUID: JioNNmrH-KbF_Zczl6SxNj_OhO0okpXb
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-16_07,2023-11-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 malwarescore=0
 lowpriorityscore=0 phishscore=0 mlxscore=0 spamscore=0 priorityscore=1501
 impostorscore=0 mlxlogscore=549 adultscore=0 clxscore=1015 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2311160080
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED,URI_DOTEDU autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2023-11-16 at 09:42 +0100, Alexander Potapenko wrote:
> On Wed, Nov 15, 2023 at 9:34=E2=80=AFPM Ilya Leoshkevich <iii@linux.ibm.c=
om>
> wrote:
> >=20
> > Hi,
> >=20
> > This series provides the minimal support for Kernel Memory
> > Sanitizer on
> > s390. Kernel Memory Sanitizer is clang-only instrumentation for
> > finding
> > accesses to uninitialized memory. The clang support for s390 has
> > already
> > been merged [1].
> >=20
> > With this series, I can successfully boot s390 defconfig and
> > debug_defconfig with kmsan.panic=3D1. The tool found one real
> > s390-specific bug (fixed in master).
> >=20
> > Best regards,
> > Ilya
>=20
> Hi Ilya,
>=20
> This is really impressive!
> Can you please share some instructions on how to run KMSAN in QEMU?
> I've never touched s390, but I'm assuming it should be possible?

I developed this natively (without cross-compilation or emulation,
just KVM), but I just gave the following a try on x86_64 and had some
success:

$ make LLVM=3D1 ARCH=3Ds390 O=3D../linux-build-s390x-cross CC=3Dclang-18
LD=3Ds390x-linux-gnu-ld OBJCOPY=3Ds390x-linux-gnu-objcopy debug_defconfig

$ make LLVM=3D1 ARCH=3Ds390 O=3D../linux-build-s390x-cross CC=3Dclang-18
LD=3Ds390x-linux-gnu-ld OBJCOPY=3Ds390x-linux-gnu-objcopy menuconfig

$ make LLVM=3D1 ARCH=3Ds390 O=3D../linux-build-s390x-cross CC=3Dclang-18
LD=3Ds390x-linux-gnu-ld OBJCOPY=3Ds390x-linux-gnu-objcopy -j24

$ qemu-system-s390x -M accel=3Dtcg -smp 2 -m 4G -kernel ../linux-build-
s390x-cross/arch/s390/boot/bzImage -nographic -append 'root=3D/dev/vda1
rw console=3DttyS1 nokaslr earlyprintk cio_ignore=3Dall kmsan.panic=3D1' -
object rng-random,filename=3D/dev/urandom,id=3Drng0 -device virtio-rng-
ccw,rng=3Drng0

It's also possible to get a free s390 machine at [1].

[1] https://linuxone.cloud.marist.edu/oss

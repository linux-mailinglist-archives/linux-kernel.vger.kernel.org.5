Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E91517EE3EE
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 16:09:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345414AbjKPPJr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 10:09:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345330AbjKPPJq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 10:09:46 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B29193;
        Thu, 16 Nov 2023 07:09:41 -0800 (PST)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AGF2wT2000665;
        Thu, 16 Nov 2023 15:09:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=fbR/4LYIfiQo0P1zqKZIOJ71Sdj1oOT4JYZNUwb072M=;
 b=iC82ZytXIrHyHQGQyplNNWwqzIsTcdT1zPbaIX4NuowOuM5y9z/66cBho7CBRzC9o35B
 U364uRSYVgu4KvKeuNI20OXoKDLlkHm6QZRYGFrahiaInSr8CPmSGYw/wkW6m9c+kz98
 RL3emxkJNvUZu56xeHqp4w1dgbk9qnUGgUBeeuxtsJ9qzo/0VaQAq6rCEQkGa5RNH1Lc
 kQZSCIZxnSzTBu4HqWGk3kbmvHhfhaLWoyz2bifcDs9BTVnNTceZOlSHNZyx0EUWBoIV
 Ib21JhCVClH1/0Vt6obIWjAtIts+9NGksw7/cZkjU2dZ9xwhCGzo7WoeVVgth5XPKuIQ LQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3udncagdg8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Nov 2023 15:09:09 +0000
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3AGF2uF1000499;
        Thu, 16 Nov 2023 15:09:06 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3udncag9q9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Nov 2023 15:09:05 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
        by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3AGERv2d007963;
        Thu, 16 Nov 2023 15:08:19 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
        by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3uapn1xx9m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Nov 2023 15:08:19 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
        by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3AGF8G1815729200
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 Nov 2023 15:08:16 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 426CD20043;
        Thu, 16 Nov 2023 15:08:16 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8FE9120040;
        Thu, 16 Nov 2023 15:08:15 +0000 (GMT)
Received: from [9.155.200.166] (unknown [9.155.200.166])
        by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Thu, 16 Nov 2023 15:08:15 +0000 (GMT)
Message-ID: <50846951de5c3c246c2c6263605a349a04a6ae45.camel@linux.ibm.com>
Subject: Re: [PATCH 13/32] kmsan: Support SLAB_POISON
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
Date:   Thu, 16 Nov 2023 16:08:15 +0100
In-Reply-To: <CAG_fn=WOfRvDw3r3zcZXWr8aa6MiEuKSa1etQrGVSJP+ic7=mg@mail.gmail.com>
References: <20231115203401.2495875-1-iii@linux.ibm.com>
         <20231115203401.2495875-14-iii@linux.ibm.com>
         <CAG_fn=WOfRvDw3r3zcZXWr8aa6MiEuKSa1etQrGVSJP+ic7=mg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: ytVHJmlpUSeyjqKkMO8KNbDnnh0SJfQg
X-Proofpoint-ORIG-GUID: GoQTG6AsG7rXNy-iKNMNk95yhUTNkZSq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-16_15,2023-11-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 priorityscore=1501 phishscore=0 mlxscore=0 spamscore=0
 clxscore=1015 malwarescore=0 impostorscore=0 adultscore=0 mlxlogscore=953
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311160118
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2023-11-16 at 15:55 +0100, Alexander Potapenko wrote:
> On Wed, Nov 15, 2023 at 9:34=E2=80=AFPM Ilya Leoshkevich <iii@linux.ibm.c=
om>
> wrote:
> >=20
> > Avoid false KMSAN negatives with SLUB_DEBUG by allowing
> > kmsan_slab_free() to poison the freed memory, and by preventing
> > init_object() from unpoisoning new allocations.
> >=20
> > Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> > ---
> > =C2=A0mm/kmsan/hooks.c | 2 +-
> > =C2=A0mm/slub.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 3 ++-
> > =C2=A02 files changed, 3 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/mm/kmsan/hooks.c b/mm/kmsan/hooks.c
> > index 7b5814412e9f..7a30274b893c 100644
> > --- a/mm/kmsan/hooks.c
> > +++ b/mm/kmsan/hooks.c
> > @@ -76,7 +76,7 @@ void kmsan_slab_free(struct kmem_cache *s, void
> > *object)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 return;
> >=20
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* RCU slabs could be legall=
y used after free within the
> > RCU period */
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (unlikely(s->flags & (SLAB_TYP=
ESAFE_BY_RCU |
> > SLAB_POISON)))
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (unlikely(s->flags & SLAB_TYPE=
SAFE_BY_RCU))
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 return;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * If there's a constru=
ctor, freed memory must remain in
> > the same state
> > diff --git a/mm/slub.c b/mm/slub.c
> > index 63d281dfacdb..8d9aa4d7cb7e 100644
> > --- a/mm/slub.c
> > +++ b/mm/slub.c
> > @@ -1024,7 +1024,8 @@ static __printf(3, 4) void slab_err(struct
> > kmem_cache *s, struct slab *slab,
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 add_taint(TAINT_BAD_PAGE, LO=
CKDEP_NOW_UNRELIABLE);
> > =C2=A0}
> >=20
> > -static void init_object(struct kmem_cache *s, void *object, u8
> > val)
> > +__no_sanitize_memory static void
>=20
> __no_sanitize_memory should be used with great care, because it drops
> all instrumentation from the function, and any shadow writes will be
> lost.
> Won't it be better to add kmsan_poison() to init_object() if you want
> it to stay uninitialized?

I wanted to avoid a ping-pong here, in which we already have properly
poisoned memory, then memset() incorrectly unpoisons it, and then we
undo the damage. My first attempt involved using __memset() instead,
but this resulted in worse assembly code. I wish there were something
like memset_noinstr().

Right now init_object() doesn't seem to be doing anything besides these
memset()s, but this can of course change in the future. So I don't mind
using kmsan_poison() instead of __no_sanitize_memory here too much,
since it results in better maintainability.

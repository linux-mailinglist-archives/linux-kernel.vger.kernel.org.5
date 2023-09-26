Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A1AC7AE395
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 04:11:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233179AbjIZCLV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 22:11:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjIZCLS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 22:11:18 -0400
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2999C0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 19:11:08 -0700 (PDT)
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20230926021105epoutp01eca71749e1440067e4a7cb3add2cf54c~IUPM3uO3k1713917139epoutp01W
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 02:11:05 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20230926021105epoutp01eca71749e1440067e4a7cb3add2cf54c~IUPM3uO3k1713917139epoutp01W
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1695694265;
        bh=avAklTkMEF1SNHqXPUWAIkv113Uw4FSIkPDMBqQqIgM=;
        h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
        b=Pzurd/L68nkms6vUk7nQXTE+cxzCOtDV79iQapsNP7fvpLYa90die0HNjBzLa7Iel
         J+LBgc6cYfGLCQTcQXEFaLT+TPSx6EtFh7y1ly+noy0Zq4MeWeWGiQEaOctD9M6Re5
         dsO8lA9GnhVVtQ1EBzO8U80y7JOL9j6bKbq2SGDo=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20230926021104epcas1p1c559e6a9bea11e079bc2055c689e0ab2~IUPMXXQei0945509455epcas1p13;
        Tue, 26 Sep 2023 02:11:04 +0000 (GMT)
Received: from epsmgec1p1.samsung.com (unknown [182.195.38.243]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4Rvjs41Y53z4x9QJ; Tue, 26 Sep
        2023 02:11:04 +0000 (GMT)
X-AuditID: b6c32a36-0d9ff700000025af-70-65123db89551
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmgec1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        F8.5C.09647.8BD32156; Tue, 26 Sep 2023 11:11:04 +0900 (KST)
Mime-Version: 1.0
Subject: RE: [PATCH v3] vmscan: add trace events for lru_gen
Reply-To: jaewon31.kim@samsung.com
Sender: =?UTF-8?B?6rmA7J6s7JuQ?= <jaewon31.kim@samsung.com>
From:   =?UTF-8?B?6rmA7J6s7JuQ?= <jaewon31.kim@samsung.com>
To:     SeongJae Park <sj@kernel.org>
CC:     "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "tjmercier@google.com" <tjmercier@google.com>,
        "yuzhao@google.com" <yuzhao@google.com>,
        "kaleshsingh@google.com" <kaleshsingh@google.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "vbabka@suse.cz" <vbabka@suse.cz>,
        "hannes@cmpxchg.org" <hannes@cmpxchg.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-trace-kernel@vger.kernel.org" 
        <linux-trace-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "jaewon31.kim@gmail.com" <jaewon31.kim@gmail.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <20230925213619.263131-1-sj@kernel.org>
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20230926021103epcms1p413b8c56ba8ce44af67b80cd3df3edf93@epcms1p4>
Date:   Tue, 26 Sep 2023 11:11:03 +0900
X-CMS-MailID: 20230926021103epcms1p413b8c56ba8ce44af67b80cd3df3edf93
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrBJsWRmVeSWpSXmKPExsWy7bCmvu4OW6FUg8+bWSzmrF/DZrF6k69F
        9+aZjBa9718xWTTtm8lucXnXHDaLe2v+s1ocWX+WxWJfxwMmi8Nf3zBZvFv/hc1idmMfo8W7
        CV9YHXg9Dr95z+yxc9Zddo+WfbfYPRZsKvXYtKqTzWPTp0nsHidm/Gbx6NuyitHjzIIj7B6f
        N8kFcEVl22SkJqakFimk5iXnp2TmpdsqeQfHO8ebmhkY6hpaWpgrKeQl5qbaKrn4BOi6ZeYA
        3a6kUJaYUwoUCkgsLlbSt7Mpyi8tSVXIyC8usVVKLUjJKTAr0CtOzC0uzUvXy0stsTI0MDAy
        BSpMyM5Yv3c7a8GVuIr2Gw2MDYzzI7sYOTgkBEwkfu5x7WLk5BAS2MEo0XNRGCTMKyAo8XeH
        MEhYWMBGoufcT1aIEiWJsz+usEPErSX2L5rBBGKzCVhKbL85kRHEFhFQlDj3+CJQPRcHs8BO
        Fok/G4+ANUsI8ErMaH/KAmFLS2xfvhWsgRPohHeLlrBBxEUlbq5+yw5jvz82nxHCFpFovXeW
        GcIWlHjwczcjzJw/x59D9RZLLOt8wARh10isOLcKKm4u0fB2JZjNK+Ar8RaqnkVAVWLr/z/M
        kGBwkbg6MwwkzCygLbFs4WuwMLOApsT6XfoQUxQldv6eywhRwifx7msP3Fc75j2B2qom0fLs
        K1RcRuLvv2dQtofEgesPmUBGCglUSxzZpTeBUWEWIpxnIdk7C2HvAkbmVYxiqQXFuempxYYF
        RvCITc7P3cQITsJaZjsYJ739oHeIkYmD8RCjBAezkgjvr2d8qUK8KYmVValF+fFFpTmpxYcY
        TYEensgsJZqcD8wDeSXxhiaWBiZmRiYWxpbGZkrivHMe96YICaQnlqRmp6YWpBbB9DFxcEo1
        MDHn1S38rp8Ts63YecqmuL3Z8r5cDyQPprto7TPR6GN5fWGVMr88p8tx44vPzHSbmYTKfAN8
        N73r2rlV8+Vq3rhTN7azNB5e7MVQazXHiC3umO3/y64lDYbX49svnhFpU7Tr2d1QcunxeeVD
        TDv1nl4L9zH7tznK52/NxJMev5aJT3nxUyXS4PbDyrpnCj/XTO+6bZvce+GH8MToGBlPz2yV
        +rDK67en3/s0c8lh3Rd1irtupmbnZexVOR10tOzqtrPRt13YZsw+fI6/lcs1zSZ1xo9lRbMt
        e62+WmbxXEza+ylvaf+TiUFvLxw++/v+AdfPq+4lT9FYGrB27/RYOa4JN4prIv/uMDEJT5GS
        3afEUpyRaKjFXFScCABPYuKtSwQAAA==
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230925213630epcas1p104cd077754d8419936b91795a87ad64c
References: <20230925213619.263131-1-sj@kernel.org>
        <CGME20230925213630epcas1p104cd077754d8419936b91795a87ad64c@epcms1p4>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>Hello,
>
>On Sun, 24 Sep 2023 23:23:43 +0900 Jaewon Kim <jaewon31.kim=40samsung.com>=
 wrote:
>
>> As the legacy lru provides, the lru_gen needs some trace events for
>> debugging.
>>=20
>> This commit introduces 2 trace events.
>>   trace_mm_vmscan_lru_gen_scan
>>   trace_mm_vmscan_lru_gen_evict
>>=20
>> Each event is similar to the following legacy events.
>>   trace_mm_vmscan_lru_isolate,
>>   trace_mm_vmscan_lru_shrink_=5Bin=5Dactive
>>=20
>> Here's an example
>>   mm_vmscan_lru_gen_scan: isolate_mode=3D0 classzone=3D1 order=3D9 nr_re=
quested=3D4096 nr_scanned=3D431 nr_skipped=3D0 nr_taken=3D55 lru=3Danon
>>   mm_vmscan_lru_gen_evict: nid=3D0 nr_reclaimed=3D42 nr_dirty=3D0 nr_wri=
teback=3D0 nr_congested=3D0 nr_immediate=3D0 nr_activate_anon=3D13 nr_activ=
ate_file=3D0 nr_ref_keep=3D0 nr_unmap_fail=3D0 priority=3D2 flags=3DRECLAIM=
_WB_ANON=7CRECLAIM_WB_ASYNC
>>   mm_vmscan_lru_gen_scan: isolate_mode=3D0 classzone=3D1 order=3D9 nr_re=
quested=3D4096 nr_scanned=3D66 nr_skipped=3D0 nr_taken=3D64 lru=3Dfile
>>   mm_vmscan_lru_gen_evict: nid=3D0 nr_reclaimed=3D62 nr_dirty=3D0 nr_wri=
teback=3D0 nr_congested=3D0 nr_immediate=3D0 nr_activate_anon=3D0 nr_activa=
te_file=3D2 nr_ref_keep=3D0 nr_unmap_fail=3D0 priority=3D2 flags=3DRECLAIM_=
WB_FILE=7CRECLAIM_WB_ASYNC
>>=20
>> Signed-off-by: Jaewon Kim <jaewon31.kim=40samsung.com>
>> Reviewed-by: Steven Rostedt (Google) <rostedt=40goodmis.org>
>> Reviewed-by: T.J. Mercier <tjmercier=40google.com>
>> ---
>> v3: change printk format
>> v2: use condition and make it aligned
>> v1: introduce trace events
>> ---
>>  include/trace/events/mmflags.h =7C  5 ++
>>  include/trace/events/vmscan.h  =7C 98 +++++++++++++++++++++++++++++++++=
+
>>  mm/vmscan.c                    =7C 17 ++++--
>>  3 files changed, 115 insertions(+), 5 deletions(-)
>>=20
>> diff --git a/include/trace/events/mmflags.h b/include/trace/events/mmfla=
gs.h
>> index 1478b9dd05fa..44e9b38f83e7 100644
>> --- a/include/trace/events/mmflags.h
>> +++ b/include/trace/events/mmflags.h
>> =40=40 -274,6 +274,10 =40=40 IF_HAVE_VM_SOFTDIRTY(VM_SOFTDIRTY,	=22softd=
irty=22	)		=5C
>>  		EM (LRU_ACTIVE_FILE, =22active_file=22) =5C
>>  		EMe(LRU_UNEVICTABLE, =22unevictable=22)
>> =20
>> +=23define LRU_GEN_NAMES		=5C
>> +		EM (LRU_GEN_ANON, =22anon=22) =5C
>> +		EMe(LRU_GEN_FILE, =22file=22)
>> +
>
>I found this patchset makes build fails when =21CONFIG_LRU_GEN, like below=
:
>
>    In file included from /linux/include/trace/trace_events.h:27,
>                     from /linux/include/trace/define_trace.h:102,
>                     from /linux/include/trace/events/oom.h:195,
>                     from /linux/mm/oom_kill.c:53:
>    /linux/include/trace/events/mmflags.h:278:7: error: =E2=80=98LRU_GEN_A=
NON=E2=80=99=20undeclared=20here=20(not=20in=20a=20function);=20did=20you=
=20mean=20=E2=80=98LRU_GEN_PGOFF=E2=80=99?=0D=0A>=20=20=20=20=20=20278=20=
=7C=20=20=20EM=20(LRU_GEN_ANON,=20=22anon=22)=20=5C=0D=0A>=20=20=20=20=20=
=20=20=20=20=20=7C=20=20=20=20=20=20=20=5E=7E=7E=7E=7E=7E=7E=7E=7E=7E=7E=7E=
=0D=0A>=0D=0A>Maybe=20some=20config=20checks=20are=20needed?=0D=0A=0D=0ASor=
ry=20and=20thank=20you=20for=20your=20comment.=0D=0AI=20think=20I=20need=20=
to=20wrap=20with=20CONFIG_LRU_GEN=0D=0AAdding=20=23ifdef=20CONFIG_LRU_GEN=
=20even=20to=20vmscan.c=20seems=20not=20nice=20though.=0D=0A=0D=0AAdditiona=
lly=20I=20had=20to=20remove=20isolate_mode=20to=20be=20compatible=20with=0D=
=0Amm,=20vmscan:=20remove=20ISOLATE_UNMAPPED=0D=0Ahttps://lore.kernel.org/l=
inux-mm/20230914131637.12204-4-vbabka=40suse.cz/=0D=0A=0D=0AHere's=20what=
=20I=20changed=20on=20top=20of=20this=20v3=20patch.=0D=0AI'm=20trying=20to=
=20find=20a=20way=20not=20to=20use=20ifdef=20CONFIG_LRU_GEN=20in=20vmscan.c=
=0D=0A=0D=0A=0D=0A=0D=0A---=20a/include/trace/events/mmflags.h=0D=0A+++=20b=
/include/trace/events/mmflags.h=0D=0A=40=40=20-274,9=20+274,11=20=40=40=20I=
F_HAVE_VM_SOFTDIRTY(VM_SOFTDIRTY,=20=22softdirty=22=20=20=20=20=20)=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=5C=0D=0A=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20EM=20(LRU_ACTIVE_FILE,=20=22active_file=22)=20=5C=0D=
=0A=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20EMe(LRU_UNEVICTABLE,=20=
=22unevictable=22)=0D=0A=20=0D=0A+=23ifdef=20CONFIG_LRU_GEN=0D=0A=20=23defi=
ne=20LRU_GEN_NAMES=20=20=20=20=20=20=20=20=20=20=5C=0D=0A=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20EM=20(LRU_GEN_ANON,=20=22anon=22)=20=5C=0D=0A=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20EMe(LRU_GEN_FILE,=20=22file=
=22)=0D=0A+=23endif=0D=0A=20=0D=0A=20/*=0D=0A=20=20*=20First=20define=20the=
=20enums=20in=20the=20above=20macros=20to=20be=20exported=20to=20userspace=
=0D=0A=40=40=20-292,7=20+294,9=20=40=40=20COMPACTION_PRIORITY=0D=0A=20/*=20=
COMPACTION_FEEDBACK=20are=20defines=20not=20enums.=20Not=20needed=20here.=
=20*/=0D=0A=20ZONE_TYPE=0D=0A=20LRU_NAMES=0D=0A+=23ifdef=20CONFIG_LRU_GEN=
=0D=0A=20LRU_GEN_NAMES=0D=0A+=23endif=0D=0A=20=0D=0A=20/*=0D=0A=20=20*=20No=
w=20redefine=20the=20EM()=20and=20EMe()=20macros=20to=20map=20the=20enums=
=20to=20the=20strings=0D=0Adiff=20--git=20a/include/trace/events/vmscan.h=
=20b/include/trace/events/vmscan.h=0D=0Aindex=20e7230fa8bda1..ba99182d6558=
=20100644=0D=0A---=20a/include/trace/events/vmscan.h=0D=0A+++=20b/include/t=
race/events/vmscan.h=0D=0A=40=40=20-323,6=20+323,7=20=40=40=20TRACE_EVENT(m=
m_vmscan_lru_isolate,=0D=0A=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
__print_symbolic(__entry->lru,=20LRU_NAMES))=0D=0A=20);=0D=0A=20=0D=0A+=23i=
fdef=20CONFIG_LRU_GEN=0D=0A=20TRACE_EVENT_CONDITION(mm_vmscan_lru_gen_scan,=
=0D=0A=20=20=20=20=20=20=20=20TP_PROTO(int=20highest_zoneidx,=0D=0A=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20int=20order,=0D=0A=40=40=20-330,1=
0=20+331,9=20=40=40=20TRACE_EVENT_CONDITION(mm_vmscan_lru_gen_scan,=0D=0A=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20unsigned=20long=20nr_scanne=
d,=0D=0A=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20unsigned=20long=20n=
r_skipped,=0D=0A=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20unsigned=20=
long=20nr_taken,=0D=0A-=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20isolate=
_mode_t=20isolate_mode,=0D=0A=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20int=20lru),=0D=0A=20=0D=0A-=20=20=20=20=20=20=20TP_ARGS(highest_zoneidx,=
=20order,=20nr_requested,=20nr_scanned,=20nr_skipped,=20nr_taken,=20isolate=
_mode,=20lru),=0D=0A+=20=20=20=20=20=20=20TP_ARGS(highest_zoneidx,=20order,=
=20nr_requested,=20nr_scanned,=20nr_skipped,=20nr_taken,=20lru),=0D=0A=20=
=0D=0A=20=20=20=20=20=20=20=20TP_CONDITION(nr_scanned),=0D=0A=20=0D=0A=40=
=40=20-344,7=20+344,6=20=40=40=20TRACE_EVENT_CONDITION(mm_vmscan_lru_gen_sc=
an,=0D=0A=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20__field(unsigned=
=20long,=20nr_scanned)=0D=0A=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20__field(unsigned=20long,=20nr_skipped)=0D=0A=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20__field(unsigned=20long,=20nr_taken)=0D=0A-=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20__field(unsigned=20int,=20isolate_mode)=
=0D=0A=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20__field(int,=20lru)=
=0D=0A=20=20=20=20=20=20=20=20),=0D=0A=20=0D=0A=40=40=20-355,7=20+354,6=20=
=40=40=20TRACE_EVENT_CONDITION(mm_vmscan_lru_gen_scan,=0D=0A=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20__entry->nr_scanned=20=3D=20nr_scanned;=0D=
=0A=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20__entry->nr_skipped=20=
=3D=20nr_skipped;=0D=0A=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20__en=
try->nr_taken=20=3D=20nr_taken;=0D=0A-=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20__entry->isolate_mode=20=3D=20(__force=20unsigned=20int)isolate_mo=
de;=0D=0A=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20__entry->lru=20=3D=
=20lru;=0D=0A=20=20=20=20=20=20=20=20),=0D=0A=20=0D=0A=40=40=20-363,7=20+36=
1,7=20=40=40=20TRACE_EVENT_CONDITION(mm_vmscan_lru_gen_scan,=0D=0A=20=20=20=
=20=20=20=20=20=20*=20classzone=20is=20previous=20name=20of=20the=20highest=
_zoneidx.=0D=0A=20=20=20=20=20=20=20=20=20*=20Reason=20not=20to=20change=20=
it=20is=20the=20ABI=20requirement=20of=20the=20tracepoint.=0D=0A=20=20=20=
=20=20=20=20=20=20*/=0D=0A-=20=20=20=20=20=20=20TP_printk(=22isolate_mode=
=3D%u=20classzone=3D%d=20order=3D%d=20nr_requested=3D%lu=20nr_scanned=3D%lu=
=20nr_skipped=3D%lu=20nr_taken=3D%lu=20lru=3D%s=22,=0D=0A+=20=20=20=20=20=
=20=20TP_printk(=22classzone=3D%d=20order=3D%d=20nr_requested=3D%lu=20nr_sc=
anned=3D%lu=20nr_skipped=3D%lu=20nr_taken=3D%lu=20lru=3D%s=22,=0D=0A=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20__entry->isolate_mode,=0D=0A=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20__entry->highest_zoneidx,=0D=
=0A=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20__entry->order,=0D=0A=40=
=40=20-373,6=20+371,7=20=40=40=20TRACE_EVENT_CONDITION(mm_vmscan_lru_gen_sc=
an,=0D=0A=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20__entry->nr_taken,=
=0D=0A=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20__print_symbolic(__en=
try->lru,=20LRU_GEN_NAMES))=0D=0A=20);=0D=0A+=23endif=0D=0A=20=0D=0A=20TRAC=
E_EVENT(mm_vmscan_write_folio,=0D=0A=20=0D=0A=40=40=20-484,6=20+483,7=20=40=
=40=20TRACE_EVENT(mm_vmscan_lru_shrink_active,=0D=0A=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20show_reclaim_flags(__entry->reclaim_flags))=0D=
=0A=20);=0D=0A=20=0D=0A+=23ifdef=20CONFIG_LRU_GEN=0D=0A=20TRACE_EVENT(mm_vm=
scan_lru_gen_evict,=0D=0A=20=0D=0A=20=20=20=20=20=20=20=20TP_PROTO(int=20ni=
d,=20unsigned=20long=20nr_reclaimed,=0D=0A=40=40=20-530,6=20+530,7=20=40=40=
=20TRACE_EVENT(mm_vmscan_lru_gen_evict,=0D=0A=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20__entry->priority,=0D=0A=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20show_reclaim_flags(__entry->reclaim_flags))=0D=0A=20);=0D=0A=
+=23endif=0D=0A=20=0D=0A=20TRACE_EVENT(mm_vmscan_node_reclaim_begin,=0D=0A=
=20=0D=0Adiff=20--git=20a/mm/vmscan.c=20b/mm/vmscan.c=0D=0Aindex=20dbfacf79=
b42c..d26e1d2610ca=20100644=0D=0A---=20a/mm/vmscan.c=0D=0A+++=20b/mm/vmscan=
.c=0D=0A=40=40=20-4390,9=20+4390,10=20=40=40=20static=20int=20scan_folios(s=
truct=20lruvec=20*lruvec,=20struct=20scan_control=20*sc,=0D=0A=20=20=20=20=
=20=20=20=20__count_memcg_events(memcg,=20PGREFILL,=20sorted);=0D=0A=20=20=
=20=20=20=20=20=20__count_vm_events(PGSCAN_ANON=20+=20type,=20isolated);=0D=
=0A=20=0D=0A+=23ifdef=20CONFIG_LRU_GEN=0D=0A=20=20=20=20=20=20=20=20trace_m=
m_vmscan_lru_gen_scan(sc->reclaim_idx,=20sc->order,=20MAX_LRU_BATCH,=0D=0A-=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20scanne=
d,=20skipped,=20isolated,=0D=0A-=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20sc->may_unmap=20?=200=20:=20ISOLATE_UNMAPPED,=20=
type);=0D=0A+=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20scanned,=20skipped,=20isolated,=20type);=0D=0A+=23endif=0D=0A=20=
=20=20=20=20=20=20=20/*=0D=0A=20=20=20=20=20=20=20=20=20*=20There=20might=
=20not=20be=20eligible=20folios=20due=20to=20reclaim_idx.=20Check=20the=0D=
=0A=20=20=20=20=20=20=20=20=20*=20remaining=20to=20prevent=20livelock=20if=
=20it's=20not=20making=20progress.=0D=0A=40=40=20-4522,8=20+4523,10=20=40=
=40=20static=20int=20evict_folios(struct=20lruvec=20*lruvec,=20struct=20sca=
n_control=20*sc,=20int=20swap=0D=0A=20retry:=0D=0A=20=20=20=20=20=20=20=20r=
eclaimed=20=3D=20shrink_folio_list(&list,=20pgdat,=20sc,=20&stat,=20false);=
=0D=0A=20=20=20=20=20=20=20=20sc->nr_reclaimed=20+=3D=20reclaimed;=0D=0A+=
=23ifdef=20CONFIG_LRU_GEN=0D=0A=20=20=20=20=20=20=20=20trace_mm_vmscan_lru_=
gen_evict(pgdat->node_id,=20reclaimed,=20&stat,=0D=0A=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20sc->priority,=20type);=0D=0A+=23endif=0D=0A=20=0D=0A=20=
=20=20=20=20=20=20=20list_for_each_entry_safe_reverse(folio,=20next,=20&lis=
t,=20lru)=20=7B=0D=0A=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20if=20(=
=21folio_evictable(folio))=20=7B=0D=0A=0D=0A=0D=0AThank=20you=0D=0A=0D=0A>=
=0D=0A>=0D=0A>Thanks,=0D=0A>SJ

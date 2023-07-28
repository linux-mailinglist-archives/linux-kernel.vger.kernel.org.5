Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84FE9766377
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 07:01:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232768AbjG1FBl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 01:01:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229946AbjG1FBh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 01:01:37 -0400
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 044842736
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 22:01:33 -0700 (PDT)
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20230728050131epoutp03695aec2f018d7b2649e4001bdd2d3957~17241Zqkn1831018310epoutp03V
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 05:01:31 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20230728050131epoutp03695aec2f018d7b2649e4001bdd2d3957~17241Zqkn1831018310epoutp03V
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1690520491;
        bh=jD3jergVqxO2h6X8ubpJnAfU8Do9zWyDEQe4PGFc1C0=;
        h=Subject:Reply-To:From:To:CC:Date:References:From;
        b=ClnNyvdpoX4BpyCS9WVGZpotHwpmE9IEhw1J3OLi2ymmrDznceVB2YboPwCJP7IIb
         c4exyH08fg5R+8ljcowQrQYa1z35HupouNfqwsWaBT2wqLnNTDdhEkt9GPc+oOJEyF
         qCZYt4plLNC5yEQoKXVWAJNL468o8u8ju+pF95Jo=
Received: from epsmges5p1new.samsung.com (unknown [182.195.42.73]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTP id
        20230728050131epcas5p358836e20e820308de78587a83cd8c2f7~1724dpiOe2843228432epcas5p3d;
        Fri, 28 Jul 2023 05:01:31 +0000 (GMT)
X-AuditID: b6c32a49-419ff7000000d8e2-72-64c34babd3d9
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        57.65.55522.BAB43C46; Fri, 28 Jul 2023 14:01:31 +0900 (KST)
Mime-Version: 1.0
Subject: RE: Re: [PATCH] USB: Fix race condition during UVC webcam
 disconnect
Reply-To: aman.deep@samsung.com
Sender: AMAN DEEP <aman.deep@samsung.com>
From:   AMAN DEEP <aman.deep@samsung.com>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     "stern@rowland.harvard.edu" <stern@rowland.harvard.edu>,
        "laurent.pinchart@ideasonboard.com" 
        <laurent.pinchart@ideasonboard.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Anuj Gupta <anuj01.gupta@samsung.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20230728045935epcms5p8f40b56f2c9100c7ea280c6f26b40d4fb@epcms5p8>
Date:   Fri, 28 Jul 2023 10:29:35 +0530
X-CMS-MailID: 20230728045935epcms5p8f40b56f2c9100c7ea280c6f26b40d4fb
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrPIsWRmVeSWpSXmKPExsWy7bCmpu5q78MpBsv/C1lcuelj0bx4PZtF
        58Ql7BaXd81hs1i0rJXZYsLvC2wObB6zO2ayeuyfu4bdY/bdH4wefVtWMXp83iQXwBrFZZOS
        mpNZllqkb5fAlTHrzBTmgisPGCvezdnE2sB48xZjFyMnh4SAicSVzoNMXYxcHEICuxkl/k2d
        ytbFyMHBKyAo8XeHMEiNsIC/xKNtf9lBbCEBeYnVjzYxQsQ1Jc5N+gYWZxNQlzj15yOYLSKg
        IfHy6C0WkJnMAquZJB7O/MwKsYxXYkb7UxYIW1pi+/KtUEeIStxc/ZYdxn5/bD5UXESi9d5Z
        ZghbUOLBz91QcRmJjkk7oOZUS0xovg72gIRAC6PEnQsToYrMJXb9XA1m8wr4Suy4sRTsCBYB
        VYldm19AHeQi8e3jdjCbWUBbYtnC18wgzzMDfbZ+lz5EiazE1FPrmCBK+CR6fz9hgvllxzwY
        W1ni/c0PUPdLShy81AN1s4dE591brCAjhQQCJfbuV53AKD8LEbqzkOydhbB3ASPzKkbJ1ILi
        3PTUYtMCw7zUcr3ixNzi0rx0veT83E2M4DSi5bmD8e6DD3qHGJk4GA8xSnAwK4nwngo4lCLE
        m5JYWZValB9fVJqTWnyIUZqDRUmc93Xr3BQhgfTEktTs1NSC1CKYLBMHp1QDk32iutb3sjW/
        K0sFlFzTNwgzzOoq1VnJrbn4j/PmR03Tl61KM1j942NEh9lpiVsGO98EnOqyuR4UvLtnXWnh
        Dbu62q15T8SNY2y+7G+vNPA/xsN1dY4a7x9rO3uPm/+Wxy019lPJWyX4OF3/1pvZwq4R+jPq
        P6doblVdsT2nzPMJr+TCswc2+JdZuB9wyThY+THojlfnZKlNU7zzN60oqe5yj1ytwrQjyObf
        z123Enk+KqZwpvw6uDfhtNbXq38+WYreTbdjSdr3eRJPeVBCytSHe58tEJ0mM1Ux+L0Ax/a5
        2b3bH5iffLGJdXbEj8UPjMUibuTckZxbzveqvsDIn9E+/8fsDKUNuidW+m7nV2Ipzkg01GIu
        Kk4EAPG8lF6SAwAA
X-CMS-RootMailID: 20230720113203epcas5p1eb52bec9c076d1a2f3dac5e317d0361b
References: <CGME20230720113203epcas5p1eb52bec9c076d1a2f3dac5e317d0361b@epcms5p8>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Thanks for your analysis.
and i am sorry for late reply due to some unavoidable circumstances.
My replies are inline.=C2=A0=0D=0A=C2=A0=0D=0A>On=C2=A0Thu,=C2=A0Jul=C2=A02=
0,=C2=A02023=C2=A0at=C2=A005:01:42PM=C2=A0+0530,=C2=A0Aman=C2=A0Deep=C2=A0w=
rote:=0D=0A>>=C2=A0In=C2=A0the=C2=A0bug=C2=A0happened=C2=A0during=C2=A0uvc=
=C2=A0webcam=C2=A0disconect,there=C2=A0is=C2=A0race=0D=0A>>=C2=A0between=C2=
=A0stopping=C2=A0a=C2=A0video=C2=A0transfer=C2=A0and=C2=A0usb=C2=A0disconne=
ct.=C2=A0This=C2=A0issue=C2=A0is=0D=0A>>=C2=A0reproduced=C2=A0in=C2=A0my=C2=
=A0system=C2=A0running=C2=A0Linux=C2=A0kernel=C2=A0when=C2=A0UVC=C2=A0webca=
m=C2=A0play=C2=A0is=0D=0A>>=C2=A0stopped=C2=A0and=C2=A0UVC=C2=A0webcam=C2=
=A0is=C2=A0disconnected=C2=A0at=C2=A0the=C2=A0same=C2=A0time.=C2=A0This=C2=
=A0causes=C2=A0the=0D=0A>>=C2=A0below=C2=A0backtrace:=0D=0A>>=C2=A0=0D=0A>>=
=C2=A0=5B2-3496.7275=5D=C2=A0=20PC=C2=A0is=C2=A0at=C2=A00xbf418000+0x2d8=C2=
=A0=5Busbcore=5D=0D=0A>>=C2=A0=5B2-3496.7275=5D=C2=A0=20LR=C2=A0is=C2=A0at=
=C2=A00x00000005=0D=0A>>=C2=A0=5B2-3496.7275=5D=C2=A0pc=C2=A0:=C2=A0=5B<bf4=
182d8>=5D((usb_ifnum_to_if=0D=0A>>=C2=A0</drivers/usb/core/usb.c:283=0D=0A>=
>=C2=A0=5Busbcore.ko=5D>))=C2=A0lr=C2=A0:=C2=A0=5B<00000005>=5D()=C2=A0psr:=
=C2=A020000013=0D=0A>>=C2=A0=5B2-3496.7275=5D=C2=A0Function=C2=A0entered=C2=
=A0at=C2=A0=5B<bf4182a4>=5D((usb_ifnum_to_if=0D=0A>>=C2=A0</drivers/usb/cor=
e/usb.c:275=0D=0A>>=C2=A0=5Busbcore.ko=5D>))=C2=A0(0xbf418000+0x2a4=C2=A0=
=5Busbcore=5D)=C2=A0from=0D=0A>>=C2=A0=5B<bf423974>=5D((usb_hcd_alloc_bandw=
idth=0D=0A>>=C2=A0</drivers/usb/core/hcd.c:1947=0D=0A>>=C2=A0=5Busbcore.ko=
=5D>))=C2=A0(0xbf418000+0xb974=C2=A0=5Busbcore=5D)=0D=0A>>=C2=A0=5B2-3496.7=
275=5D=C2=A0Function=C2=A0entered=C2=A0at=C2=A0=5B<bf423738>=5D((usb_hcd_al=
loc_bandwidth=0D=0A>>=C2=A0</drivers/usb/core/hcd.c:1876=0D=0A>>=C2=A0=5Bus=
bcore.ko=5D>))=C2=A0(0xbf418000+0xb738=C2=A0=5Busbcore=5D)=C2=A0from=0D=0A>=
>=C2=A0=5B<bf426ca0>=5D((usb_set_interface=0D=0A>>=C2=A0</drivers/usb/core/=
message.c:1461=0D=0A>>=C2=A0=5Busbcore.ko=5D>))=C2=A0(0xbf418000+0xeca0=C2=
=A0=5Busbcore=5D)=0D=0A>>=C2=A0=5B2-3496.7275=5D=C2=A0Function=C2=A0entered=
=C2=A0at=C2=A0=5B<bf426b9c>=5D((usb_set_interface=0D=0A>>=C2=A0</drivers/us=
b/core/message.c:1385=0D=0A>>=C2=A0=5Busbcore.ko=5D>))=C2=A0(0xbf418000+0xe=
b9c=C2=A0=5Busbcore=5D)=C2=A0from=0D=0A>>=C2=A0=5B<bf9c4dd4>=5D((uvc_video_=
clock_cleanup=0D=0A>>=C2=A0</drivers/media/usb/uvc/uvc_video.c:598=0D=0A>>=
=C2=A0uvc_video_stop_streaming=0D=0A>>=C2=A0</drivers/media/usb/uvc/uvc_vid=
eo.c:2221=0D=0A>>=C2=A0=5Buvcvideo.ko=5D>))=C2=A0(0xbf9bd000+0x7dd4=C2=A0=
=5Buvcvideo=5D)=0D=0A>>=C2=A0=5B2-3496.7275=5D=C2=A0Function=C2=A0entered=
=C2=A0at=C2=A0=5B<bf9c4d98>=5D((uvc_video_stop_streaming=0D=0A>>=C2=A0</dri=
vers/media/usb/uvc/uvc_video.c:2200=0D=0A>>=C2=A0=5Buvcvideo.ko=5D>))=C2=A0=
(0xbf9bd000+0x7d98=C2=A0=5Buvcvideo=5D)=C2=A0from=0D=0A>>=C2=A0=5B<bf9bfab8=
>=5D((spin_lock_irq=0D=0A>>=C2=A0</include/linux/spinlock.h:363=0D=0A>>=C2=
=A0uvc_stop_streaming=0D=0A>>=C2=A0</drivers/media/usb/uvc/uvc_queue.c:194=
=0D=0A>>=C2=A0=5Buvcvideo.ko=5D>))=C2=A0(0xbf9bd000+0x2ab8=C2=A0=5Buvcvideo=
=5D)=0D=0A>>=C2=A0=5B2-3496.7276=5D=C2=A0Function=C2=A0entered=C2=A0at=C2=
=A0=5B<bf9bfa94>=5D((uvc_stop_streaming=0D=0A>>=C2=A0</drivers/media/usb/uv=
c/uvc_queue.c:186=0D=0A>>=C2=A0=5Buvcvideo.ko=5D>))=C2=A0(0xbf9bd000+0x2a94=
=C2=A0=5Buvcvideo=5D)=C2=A0from=0D=0A>>=C2=A0=5B<be307150>=5D((__read_once_=
size=0D=0A>>=C2=A0</include/linux/compiler.h:290=0D=0A>>=C2=A0(discriminato=
r=C2=A01)=C2=A0__vb2_queue_cancel=0D=0A>>=C2=A0</drivers/media/common/video=
buf2/videobuf2-core.c:1893=0D=0A>>=C2=A0(discriminator=C2=A01)=C2=A0=5Bvide=
obuf2_common.ko=5D>))=C2=A0(0xbe306000+0x1150=0D=0A>>=C2=A0=5Bvideobuf2_com=
mon=5D)=0D=0A>>=C2=A0=5B2-3496.7276=5D=C2=A0Function=C2=A0entered=C2=A0at=
=C2=A0=5B<be307120>=5D((__vb2_queue_cancel=0D=0A>>=C2=A0</drivers/media/com=
mon/videobuf2/videobuf2-core.c:1877=0D=0A>>=C2=A0=5Bvideobuf2_common.ko=5D>=
))=C2=A0(0xbe306000+0x1120=C2=A0=5Bvideobuf2_common=5D)=C2=A0from=0D=0A>>=
=C2=A0=5B<be308894>=5D((vb2_core_streamoff=0D=0A>>=C2=A0</drivers/media/com=
mon/videobuf2/videobuf2-core.c:2053=0D=0A>=0D=0A>Odd=C2=A0wrapping,=C2=A0pl=
ease=C2=A0fix.=0D=0A=0D=0A=0D=0ASorry=20for=20odd=20wrapping.=0D=0AThis=20i=
s=20below=20complete=20backtrace=20for=20crash=20problem:=0D=0A=0D=0A=0D=0A=
=5B1-221.1821=5D=C2=A0=5B=C2=A0=20=C2=A0=20msg:=C2=A04788=5D=C2=A0Unable=C2=
=A0to=C2=A0handle=C2=A0kernel=C2=A0NULL=C2=A0pointer=C2=A0dereference=C2=A0=
at=C2=A0virtual=C2=A0address=C2=A000000000=0D=0A=5B1-221.1821=5D=C2=A0=5B=
=C2=A0=20=C2=A0=20msg:=C2=A04788=5D=C2=A0pgd=C2=A0=3D=C2=A0e136ded4=0D=0A=
=5B1-221.1821=5D=C2=A0=5B=C2=A0=20=C2=A0=20msg:=C2=A04788=5D=C2=A0=5B000000=
00=5D=C2=A0*pgd=3D26210003,=C2=A0*pmd=3D00000000=0D=0A=5B1-221.1821=5D=C2=
=A0=5B=C2=A0=20=C2=A0=20msg:=C2=A04788=5D=C2=A0=0D=0A=5B1-221.1821=5D=C2=A0=
=5B=C2=A0=20=C2=A0=20msg:=C2=A04788=5D=C2=A0Die=C2=A0cpu=C2=A0info=C2=A0:=
=0D=0A=5B1-221.1821=5D=C2=A0=5B=C2=A0=20=C2=A0=20msg:=C2=A04788=5D=C2=A0Int=
ernal=C2=A0error:=C2=A0Oops:=C2=A0206=C2=A0=5B=231=5D=C2=A0PREEMPT=C2=A0SMP=
=C2=A0ARM=0D=0A=5B1-221.1821=5D=C2=A0=5B=C2=A0=20=C2=A0=20msg:=C2=A04788=5D=
=C2=A0CPU:=C2=A01=C2=A0PID:=C2=A04788=C2=A0Comm:=C2=A0msg(muse-server)=C2=
=A0Kdump:=C2=A0loaded=C2=A0Tainted:=C2=A0PO=C2=A05.4.77=C2=A0=231=C2=A0PPID=
:=C2=A01=C2=A0PComm:=C2=A0systemd=C2=A0preempt_count:=C2=A00x0=0D=0A=5B1-22=
1.1821=5D=C2=A0=5B=C2=A0=20=C2=A0=20msg:=C2=A04788=5D=C2=A0Hardware=C2=A0na=
me:=C2=A0Novatek=C2=A0Cortex-A53=0D=0A=5B1-221.1822=5D=C2=A0=5B=C2=A0=20=C2=
=A0=20msg:=C2=A04788=5D=C2=A0PC=C2=A0is=C2=A0at=C2=A0usb_ifnum_to_if+0x30/0=
x74=C2=A0=5Busbcore=5D=0D=0A=5B1-221.1822=5D=C2=A0=5B=C2=A0=20=C2=A0=20msg:=
=C2=A04788=5D=C2=A0LR=C2=A0is=C2=A0at=C2=A00x5=0D=0A=5B1-221.1822=5D=C2=A0=
=5B=C2=A0=20=C2=A0=20msg:=C2=A04788=5D=C2=A0pc=C2=A0:=C2=A0=5B<bede1300>=5D=
=C2=A0=20=C2=A0=20lr=C2=A0:=C2=A0=5B<00000005>=5D=C2=A0=20=C2=A0=20psr:=C2=
=A020000113=0D=0A=5B1-221.1822=5D=C2=A0=5B=C2=A0=20=C2=A0=20msg:=C2=A04788=
=5D=C2=A0sp=C2=A0:=C2=A0ca443c18=C2=A0=20ip=C2=A0:=C2=A0ca443c28=C2=A0=20fp=
=C2=A0:=C2=A0ca443c24=0D=0A=5B1-221.1822=5D=C2=A0=5B=C2=A0=20=C2=A0=20msg:=
=C2=A04788=5D=C2=A0r10:=C2=A0e668b6c8=C2=A0=20r9=C2=A0:=C2=A000000000=C2=A0=
=20r8=C2=A0:=C2=A0e668b7e0=0D=0A=5B1-221.1822=5D=C2=A0=5B=C2=A0=20=C2=A0=20=
msg:=C2=A04788=5D=C2=A0r7=C2=A0:=C2=A0e7b78880=C2=A0=20r6=C2=A0:=C2=A0bf1d9=
db0=C2=A0=20r5=C2=A0:=C2=A0e668b6c8=C2=A0=20r4=C2=A0:=C2=A0e690c000=0D=0A=
=5B1-221.1822=5D=C2=A0=5B=C2=A0=20=C2=A0=20msg:=C2=A04788=5D=C2=A0r3=C2=A0:=
=C2=A000002000=C2=A0=20r2=C2=A0:=C2=A0e696ac40=C2=A0=20r1=C2=A0:=C2=A000000=
001=C2=A0=20r0=C2=A0:=C2=A000000000=0D=0A=5B1-221.1822=5D=C2=A0=5B=C2=A0=20=
=C2=A0=20msg:=C2=A04788=5D=C2=A0Flags:=C2=A0nzCv=C2=A0=20IRQs=C2=A0on=C2=A0=
=20FIQs=C2=A0on=C2=A0=20Mode=C2=A0SVC_32=C2=A0=20ISA=C2=A0ARM=C2=A0=20Segme=
nt=C2=A0user=0D=0A=5B1-221.1822=5D=C2=A0=5B=C2=A0=20=C2=A0=20msg:=C2=A04788=
=5D=C2=A0Control:=C2=A030c5383d=C2=A0=20Table:=C2=A0261f8a80=C2=A0=20DAC:=
=C2=A0e45d65d5=0D=0A=5B1-221.1822=5D=C2=A0=5B=C2=A0=20=C2=A0=20msg:=C2=A047=
88=5D=C2=A0Process=C2=A0msg=C2=A0(pid:=C2=A04788,=C2=A0stack=C2=A0limit=C2=
=A0=3D=C2=A00xa0153238)=0D=0A=5B1-221.1822=5D=C2=A0=5B=C2=A0=20=C2=A0=20msg=
:=C2=A04788=5D=C2=A0Stack:=C2=A0(0xca443c18=C2=A0to=C2=A00xca444000)=0D=0A=
=5B1-221.1822=5D=C2=A0=5B=C2=A0=20=C2=A0=20msg:=C2=A04788=5D=C2=A03c00:=C2=
=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=
=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=
=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=
=A0=20=C2=A0=20=C2=A0ca443c64=C2=A0ca443c28=0D=0A=5B1-221.1822=5D=C2=A0=5B=
=C2=A0=20=C2=A0=20msg:=C2=A04788=5D=C2=A03c20:=C2=A0bedee6e4=C2=A0bede12dc=
=C2=A000000000=C2=A0bee0ae78=C2=A0ca443c54=C2=A0ca443c40=C2=A0c083c894=C2=
=A0e7b78880=0D=0A=5B1-221.1822=5D=C2=A0=5B=C2=A0=20=C2=A0=20msg:=C2=A04788=
=5D=C2=A03c40:=C2=A0e6b88340=C2=A000000000=C2=A0bee0ae78=C2=A000000001=C2=
=A0e690c000=C2=A0e668b6c8=C2=A0ca443cb4=C2=A0ca443c68=0D=0A=5B1-221.1822=5D=
=C2=A0=5B=C2=A0=20=C2=A0=20msg:=C2=A04788=5D=C2=A03c60:=C2=A0bedf22ac=C2=A0=
bedee64c=C2=A0e5cf1508=C2=A0e5cf1508=C2=A0e5cf0000=C2=A0e5cf0330=C2=A000000=
001=C2=A0e5cf0330=0D=0A=5B1-221.1822=5D=C2=A0=5B=C2=A0=20=C2=A0=20msg:=C2=
=A04788=5D=C2=A03c80:=C2=A0ca443ca4=C2=A0ca443c90=C2=A0c083c894=C2=A0e5cf00=
00=C2=A0e5cf0330=C2=A000000001=C2=A0e5cf0330=C2=A000000000=0D=0A=5B1-221.18=
22=5D=C2=A0=5B=C2=A0=20=C2=A0=20msg:=C2=A04788=5D=C2=A03ca0:=C2=A000000001=
=C2=A0c08d1b3c=C2=A0ca443ccc=C2=A0ca443cb8=C2=A0bfb3f958=C2=A0bedf1ff4=C2=
=A0e5cf0330=C2=A0e5cf0330=0D=0A=5B1-221.1822=5D=C2=A0=5B=C2=A0=20=C2=A0=20m=
sg:=C2=A04788=5D=C2=A03cc0:=C2=A0ca443ce4=C2=A0ca443cd0=C2=A0bfb3a024=C2=A0=
bfb3f8a8=C2=A0e5cf0330=C2=A0e5cf0330=C2=A0ca443d14=C2=A0ca443ce8=0D=0A=5B1-=
221.1823=5D=C2=A0=5B=C2=A0=20=C2=A0=20msg:=C2=A04788=5D=C2=A03ce0:=C2=A0be3=
661e0=C2=A0bfb3a004=C2=A000000001=C2=A0e5cf0330=C2=A0e5cf0330=C2=A000000001=
=C2=A0c05d6260=C2=A000000000=0D=0A=5B1-221.1823=5D=C2=A0=5B=C2=A0=20=C2=A0=
=20msg:=C2=A04788=5D=C2=A03d00:=C2=A000000001=C2=A0c08d1b3c=C2=A0ca443d2c=
=C2=A0ca443d18=C2=A0be367994=C2=A0be3661b4=C2=A0e5cf0484=C2=A0e5cf0330=0D=
=0A=5B1-221.1823=5D=C2=A0=5B=C2=A0=20=C2=A0=20msg:=C2=A04788=5D=C2=A03d20:=
=C2=A0ca443d3c=C2=A0ca443d30=C2=A0be37e3e4=C2=A0be367978=C2=A0ca443d5c=C2=
=A0ca443d40=C2=A0bfb3a518=C2=A0be37e3cc=0D=0A=5B1-221.1823=5D=C2=A0=5B=C2=
=A0=20=C2=A0=20msg:=C2=A04788=5D=C2=A03d40:=C2=A0e5cf030c=C2=A0e5cf0000=C2=
=A000000001=C2=A0c05d6260=C2=A0ca443d7c=C2=A0ca443d60=C2=A0bfb3b628=C2=A0bf=
b3a4f0=0D=0A=5B1-221.1823=5D=C2=A0=5B=C2=A0=20=C2=A0=20msg:=C2=A04788=5D=C2=
=A03d60:=C2=A0bfb3b5e8=C2=A040045613=C2=A000000000=C2=A0c05d6260=C2=A0ca443=
d94=C2=A0ca443d80=C2=A0c05d6288=C2=A0bfb3b5f4=0D=0A=5B1-221.1823=5D=C2=A0=
=5B=C2=A0=20=C2=A0=20msg:=C2=A04788=5D=C2=A03d80:=C2=A0e5cf0010=C2=A0400456=
13=C2=A0ca443dfc=C2=A0ca443d98=C2=A0c05d9b84=C2=A0c05d626c=C2=A000000068=C2=
=A0ca443deb=0D=0A=5B1-221.1823=5D=C2=A0=5B=C2=A0=20=C2=A0=20msg:=C2=A04788=
=5D=C2=A03da0:=C2=A0c08d1b3c=C2=A000000001=C2=A0ca443e24=C2=A0bfb44680=C2=
=A000000000=C2=A0e2fa3780=C2=A0c01a926c=C2=A0031e1090=0D=0A=5B1-221.1823=5D=
=C2=A0=5B=C2=A0=20=C2=A0=20msg:=C2=A04788=5D=C2=A03dc0:=C2=A0ca443df4=C2=A0=
ffffffff=C2=A0c01e0048=C2=A00000072c=C2=A0000012b4=C2=A000000000=C2=A040045=
613=C2=A000000000=0D=0A=5B1-221.1823=5D=C2=A0=5B=C2=A0=20=C2=A0=20msg:=C2=
=A04788=5D=C2=A03de0:=C2=A000000000=C2=A000000001=C2=A000000004=C2=A0ca443e=
24=C2=A0ca443ed4=C2=A0ca443e00=C2=A0c05db320=C2=A0c05d9a04=0D=0A=5B1-221.18=
23=5D=C2=A0=5B=C2=A0=20=C2=A0=20msg:=C2=A04788=5D=C2=A03e00:=C2=A000000000=
=C2=A000000000=C2=A0c05d99f8=C2=A0e77a6700=C2=A0ab8fd26c=C2=A000000000=C2=
=A000000000=C2=A000000000=0D=0A=5B1-221.1823=5D=C2=A0=5B=C2=A0=20=C2=A0=20m=
sg:=C2=A04788=5D=C2=A03e20:=C2=A0ca443f60=C2=A000000001=C2=A0ca443ee0=C2=A0=
00000000=C2=A0ca443e9c=C2=A0ca443e40=C2=A0c02390a8=C2=A0be211e84=0D=0A=5B1-=
221.1823=5D=C2=A0=5B=C2=A0=20=C2=A0=20msg:=C2=A04788=5D=C2=A03e40:=C2=A0000=
00000=C2=A000000001=C2=A0e2861600=C2=A000000000=C2=A000000000=C2=A000000000=
=C2=A000000000=C2=A000000000=0D=0A=5B1-221.1823=5D=C2=A0=5B=C2=A0=20=C2=A0=
=20msg:=C2=A04788=5D=C2=A03e60:=C2=A000000000=C2=A000000000=C2=A000000000=
=C2=A0c03681bc=C2=A000000008=C2=A000000000=C2=A0ca443ee0=C2=A0c0bbd748=0D=
=0A=5B1-221.1823=5D=C2=A0=5B=C2=A0=20=C2=A0=20msg:=C2=A04788=5D=C2=A03e80:=
=C2=A000000000=C2=A0c0be9a14=C2=A0ca443ef4=C2=A000000002=C2=A0ca443ed4=C2=
=A0ca443ea0=C2=A0c03681bc=C2=A0c036790c=0D=0A=5B1-221.1823=5D=C2=A0=5B=C2=
=A0=20=C2=A0=20msg:=C2=A04788=5D=C2=A03ea0:=C2=A0ca443ef4=C2=A0c0bbd748=C2=
=A0e2861600=C2=A0c05db7dc=C2=A0e6695448=C2=A040045613=C2=A0ab8fd26c=C2=A0e7=
7a6700=0D=0A=5B1-221.1823=5D=C2=A0=5B=C2=A0=20=C2=A0=20msg:=C2=A04788=5D=C2=
=A03ec0:=C2=A000000021=C2=A000000036=C2=A0ca443ee4=C2=A0ca443ed8=C2=A0c05db=
7fc=C2=A0c05db0f8=C2=A0ca443efc=C2=A0ca443ee8=0D=0A=5B1-221.1823=5D=C2=A0=
=5B=C2=A0=20=C2=A0=20msg:=C2=A04788=5D=C2=A03ee0:=C2=A0c05d4728=C2=A0c05db7=
e8=C2=A0ab8fd26c=C2=A0e6695448=C2=A0ca443f6c=C2=A0ca443f00=C2=A0c02506a0=C2=
=A0c05d46e8=0D=0A=5B1-221.1823=5D=C2=A0=5B=C2=A0=20=C2=A0=20msg:=C2=A04788=
=5D=C2=A03f00:=C2=A0ca443f04=C2=A0c08a7a00=C2=A000000000=C2=A000000000=C2=
=A000000000=C2=A000000000=C2=A000000000=C2=A000000000=0D=0A=5B1-221.1823=5D=
=C2=A0=5B=C2=A0=20=C2=A0=20msg:=C2=A04788=5D=C2=A03f20:=C2=A000000000=C2=A0=
00000000=C2=A000000000=C2=A000000000=C2=A0ab8fd26c=C2=A0c0abb6ec=C2=A0ab8fd=
26c=C2=A0e77a6700=0D=0A=5B1-221.1823=5D=C2=A0=5B=C2=A0=20=C2=A0=20msg:=C2=
=A04788=5D=C2=A03f40:=C2=A0ca443f6c=C2=A0e77a6701=C2=A000000000=C2=A0400456=
13=C2=A0ab8fd26c=C2=A0e77a6700=C2=A000000021=C2=A000000036=0D=0A=5B1-221.18=
24=5D=C2=A0=5B=C2=A0=20=C2=A0=20msg:=C2=A04788=5D=C2=A03f60:=C2=A0ca443f94=
=C2=A0ca443f70=C2=A0c0250b3c=C2=A0c02502fc=C2=A000000000=C2=A0000006f7=C2=
=A000000000=C2=A000000036=0D=0A=5B1-221.1824=5D=C2=A0=5B=C2=A0=20=C2=A0=20m=
sg:=C2=A04788=5D=C2=A03f80:=C2=A0c000924c=C2=A0ca442000=C2=A0ca443fa4=C2=A0=
ca443f98=C2=A0c0250b78=C2=A0c0250adc=C2=A000000000=C2=A0ca443fa8=0D=0A=5B1-=
221.1824=5D=C2=A0=5B=C2=A0=20=C2=A0=20msg:=C2=A04788=5D=C2=A03fa0:=C2=A0c00=
09230=C2=A0c0250b6c=C2=A000000000=C2=A0000006f7=C2=A000000021=C2=A040045613=
=C2=A0ab8fd26c=C2=A000000021=0D=0A=5B1-221.1824=5D=C2=A0=5B=C2=A0=20=C2=A0=
=20msg:=C2=A04788=5D=C2=A03fc0:=C2=A000000000=C2=A0000006f7=C2=A000000000=
=C2=A000000036=C2=A0abb79e30=C2=A000000000=C2=A000000001=C2=A0abb79e28=0D=
=0A=5B1-221.1824=5D=C2=A0=5B=C2=A0=20=C2=A0=20msg:=C2=A04788=5D=C2=A03fe0:=
=C2=A0aeca607c=C2=A0ab8fd24c=C2=A0aec8e749=C2=A0b5f1ed1c=C2=A020000010=C2=
=A000000021=C2=A000000000=C2=A000000000=0D=0A=5B1-221.1824=5D=C2=A0=5B=C2=
=A0=20=C2=A0=20msg:=C2=A04788=5D=C2=A0Backtrace:=C2=A0=0D=0A=5B1-221.1824=
=5D=C2=A0=5B=C2=A0=20=C2=A0=20msg:=C2=A04788=5D=C2=A0=5B<bede12d0>=5D=C2=A0=
(usb_ifnum_to_if=C2=A0=5Busbcore=5D)=C2=A0from=C2=A0=5B<bedee6e4>=5D=C2=A0(=
usb_hcd_alloc_bandwidth+0xa4/0x564=C2=A0=5Busbcore=5D)=0D=0A=5B1-221.1824=
=5D=C2=A0=5B=C2=A0=20=C2=A0=20msg:=C2=A04788=5D=C2=A0=5B<bedee640>=5D=C2=A0=
(usb_hcd_alloc_bandwidth=C2=A0=5Busbcore=5D)=C2=A0from=C2=A0=5B<bedf22ac>=
=5D=C2=A0(usb_set_interface+0x2c4/0x61c=C2=A0=5Busbcore=5D)=0D=0A=5B1-221.1=
824=5D=C2=A0=5B=C2=A0=20=C2=A0=20msg:=C2=A04788=5D=C2=A0=20r10:e668b6c8=C2=
=A0r9:e690c000=C2=A0r8:00000001=C2=A0r7:bee0ae78=C2=A0r6:00000000=C2=A0r5:e=
6b88340=0D=0A=5B1-221.1824=5D=C2=A0=5B=C2=A0=20=C2=A0=20msg:=C2=A04788=5D=
=C2=A0=20r4:e7b78880=0D=0A=5B1-221.1825=5D=C2=A0=5B=C2=A0=20=C2=A0=20msg:=
=C2=A04788=5D=C2=A0=5B<bedf1fe8>=5D=C2=A0(usb_set_interface=C2=A0=5Busbcore=
=5D)=C2=A0from=C2=A0=5B<bfb3f958>=5D=C2=A0(uvc_video_stop_streaming+0xbc/0x=
c4=C2=A0=5Buvcvideo=5D)=0D=0A=5B1-221.1825=5D=C2=A0=5B=C2=A0=20=C2=A0=20msg=
:=C2=A04788=5D=C2=A0=20r10:c08d1b3c=C2=A0r9:00000001=C2=A0r8:00000000=C2=A0=
r7:e5cf0330=C2=A0r6:00000001=C2=A0r5:e5cf0330=0D=0A=5B1-221.1825=5D=C2=A0=
=5B=C2=A0=20=C2=A0=20msg:=C2=A04788=5D=C2=A0=20r4:e5cf0000=0D=0A=5B1-221.18=
25=5D=C2=A0=5B=C2=A0=20=C2=A0=20msg:=C2=A04788=5D=C2=A0=5B<bfb3f89c>=5D=C2=
=A0(uvc_video_stop_streaming=C2=A0=5Buvcvideo=5D)=C2=A0from=C2=A0=5B<bfb3a0=
24>=5D=C2=A0(uvc_stop_streaming+0x2c/0x50=C2=A0=5Buvcvideo=5D)=0D=0A=5B1-22=
1.1825=5D=C2=A0=5B=C2=A0=20=C2=A0=20msg:=C2=A04788=5D=C2=A0=20r5:e5cf0330=
=C2=A0r4:e5cf0330=0D=0A=5B1-221.1825=5D=C2=A0=5B=C2=A0=20=C2=A0=20msg:=C2=
=A04788=5D=C2=A0=5B<bfb39ff8>=5D=C2=A0(uvc_stop_streaming=C2=A0=5Buvcvideo=
=5D)=C2=A0from=C2=A0=5B<be3661e0>=5D=C2=A0(__vb2_queue_cancel+0x38/0x290=C2=
=A0=5Bvideobuf2_common=5D)=0D=0A=5B1-221.1825=5D=C2=A0=5B=C2=A0=20=C2=A0=20=
msg:=C2=A04788=5D=C2=A0=20r5:e5cf0330=C2=A0r4:e5cf0330=0D=0A=5B1-221.1825=
=5D=C2=A0=5B=C2=A0=20=C2=A0=20msg:=C2=A04788=5D=C2=A0=5B<be3661a8>=5D=C2=A0=
(__vb2_queue_cancel=C2=A0=5Bvideobuf2_common=5D)=C2=A0from=C2=A0=5B<be36799=
4>=5D=C2=A0(vb2_core_streamoff+0x28/0xb4=C2=A0=5Bvideobuf2_common=5D)=0D=0A=
=5B1-221.1825=5D=C2=A0=5B=C2=A0=20=C2=A0=20msg:=C2=A04788=5D=C2=A0=20r10:c0=
8d1b3c=C2=A0r9:00000001=C2=A0r8:00000000=C2=A0r7:c05d6260=C2=A0r6:00000001=
=C2=A0r5:e5cf0330=0D=0A=5B1-221.1825=5D=C2=A0=5B=C2=A0=20=C2=A0=20msg:=C2=
=A04788=5D=C2=A0=20r4:e5cf0330=C2=A0r3:00000001=0D=0A=5B1-221.1825=5D=C2=A0=
=5B=C2=A0=20=C2=A0=20msg:=C2=A04788=5D=C2=A0=5B<be36796c>=5D=C2=A0(vb2_core=
_streamoff=C2=A0=5Bvideobuf2_common=5D)=C2=A0from=C2=A0=5B<be37e3e4>=5D=C2=
=A0(vb2_streamoff+0x24/0x60=C2=A0=5Bvideobuf2_v4l2=5D)=0D=0A=5B1-221.1825=
=5D=C2=A0=5B=C2=A0=20=C2=A0=20msg:=C2=A04788=5D=C2=A0=20r5:e5cf0330=C2=A0r4=
:e5cf0484=0D=0A=5B1-221.1825=5D=C2=A0=5B=C2=A0=20=C2=A0=20msg:=C2=A04788=5D=
=C2=A0=5B<be37e3c0>=5D=C2=A0(vb2_streamoff=C2=A0=5Bvideobuf2_v4l2=5D)=C2=A0=
from=C2=A0=5B<bfb3a518>=5D=C2=A0(uvc_queue_streamoff+0x34/0x48=C2=A0=5Buvcv=
ideo=5D)=0D=0A=5B1-221.1825=5D=C2=A0=5B=C2=A0=20=C2=A0=20msg:=C2=A04788=5D=
=C2=A0=5B<bfb3a4e4>=5D=C2=A0(uvc_queue_streamoff=C2=A0=5Buvcvideo=5D)=C2=A0=
from=C2=A0=5B<bfb3b628>=5D=C2=A0(uvc_ioctl_streamoff+0x40/0x58=C2=A0=5Buvcv=
ideo=5D)=0D=0A=5B1-221.1826=5D=C2=A0=5B=C2=A0=20=C2=A0=20msg:=C2=A04788=5D=
=C2=A0=20r7:c05d6260=C2=A0r6:00000001=C2=A0r5:e5cf0000=C2=A0r4:e5cf030c=0D=
=0A=5B1-221.1826=5D=C2=A0=5B=C2=A0=20=C2=A0=20msg:=C2=A04788=5D=C2=A0=5B<bf=
b3b5e8>=5D=C2=A0(uvc_ioctl_streamoff=C2=A0=5Buvcvideo=5D)=C2=A0from=C2=A0=
=5B<c05d6288>=5D=C2=A0(v4l_streamoff+0x28/0x2c)=0D=0A=5B1-221.1826=5D=C2=A0=
=5B=C2=A0=20=C2=A0=20msg:=C2=A04788=5D=C2=A0=20r7:c05d6260=C2=A0r6:00000000=
=C2=A0r5:40045613=C2=A0r4:bfb3b5e8=0D=0A=5B1-221.1826=5D=C2=A0=5B=C2=A0=20=
=C2=A0=20msg:=C2=A04788=5D=C2=A0=5B<c05d6260>=5D=C2=A0(v4l_streamoff)=C2=A0=
from=C2=A0=5B<c05d9b84>=5D=C2=A0(__video_do_ioctl+0x18c/0x400)=0D=0A=5B1-22=
1.1826=5D=C2=A0=5B=C2=A0=20=C2=A0=20msg:=C2=A04788=5D=C2=A0=20r5:40045613=
=C2=A0r4:e5cf0010=0D=0A=5B1-221.1826=5D=C2=A0=5B=C2=A0=20=C2=A0=20msg:=C2=
=A04788=5D=C2=A0=5B<c05d99f8>=5D=C2=A0(__video_do_ioctl)=C2=A0from=C2=A0=5B=
<c05db320>=5D=C2=A0(video_usercopy+0x234/0x6f0)=0D=0A=5B1-221.1826=5D=C2=A0=
=5B=C2=A0=20=C2=A0=20msg:=C2=A04788=5D=C2=A0=20r10:ca443e24=C2=A0r9:0000000=
4=C2=A0r8:00000001=C2=A0r7:00000000=C2=A0r6:00000000=C2=A0r5:40045613=0D=0A=
=5B1-221.1826=5D=C2=A0=5B=C2=A0=20=C2=A0=20msg:=C2=A04788=5D=C2=A0=20r4:000=
00000=0D=0A=5B1-221.1826=5D=C2=A0=5B=C2=A0=20=C2=A0=20msg:=C2=A04788=5D=C2=
=A0=5B<c05db0ec>=5D=C2=A0(video_usercopy)=C2=A0from=C2=A0=5B<c05db7fc>=5D=
=C2=A0(video_ioctl2+0x20/0x24)=0D=0A=5B1-221.1826=5D=C2=A0=5B=C2=A0=20=C2=
=A0=20msg:=C2=A04788=5D=C2=A0=20r10:00000036=C2=A0r9:00000021=C2=A0r8:e77a6=
700=C2=A0r7:ab8fd26c=C2=A0r6:40045613=C2=A0r5:e6695448=0D=0A=5B1-221.1826=
=5D=C2=A0=5B=C2=A0=20=C2=A0=20msg:=C2=A04788=5D=C2=A0=20r4:c05db7dc=0D=0A=
=5B1-221.1826=5D=C2=A0=5B=C2=A0=20=C2=A0=20msg:=C2=A04788=5D=C2=A0=5B<c05db=
7dc>=5D=C2=A0(video_ioctl2)=C2=A0from=C2=A0=5B<c05d4728>=5D=C2=A0(v4l2_ioct=
l+0x4c/0x60)=0D=0A=5B1-221.1826=5D=C2=A0=5B=C2=A0=20=C2=A0=20msg:=C2=A04788=
=5D=C2=A0=5B<c05d46dc>=5D=C2=A0(v4l2_ioctl)=C2=A0from=C2=A0=5B<c02506a0>=5D=
=C2=A0(do_vfs_ioctl+0x3b0/0x7e0)=0D=0A=5B1-221.1826=5D=C2=A0=5B=C2=A0=20=C2=
=A0=20msg:=C2=A04788=5D=C2=A0=20r5:e6695448=C2=A0r4:ab8fd26c=0D=0A=5B1-221.=
1826=5D=C2=A0=5B=C2=A0=20=C2=A0=20msg:=C2=A04788=5D=C2=A0=5B<c02502f0>=5D=
=C2=A0(do_vfs_ioctl)=C2=A0from=C2=A0=5B<c0250b3c>=5D=C2=A0(ksys_ioctl+0x6c/=
0x90)=0D=0A=5B1-221.1826=5D=C2=A0=5B=C2=A0=20=C2=A0=20msg:=C2=A04788=5D=C2=
=A0=20r10:00000036=C2=A0r9:00000021=C2=A0r8:e77a6700=C2=A0r7:ab8fd26c=C2=A0=
r6:40045613=C2=A0r5:00000000=0D=0A=5B1-221.1826=5D=C2=A0=5B=C2=A0=20=C2=A0=
=20msg:=C2=A04788=5D=C2=A0=20r4:e77a6701=0D=0A=5B1-221.1826=5D=C2=A0=5B=C2=
=A0=20=C2=A0=20msg:=C2=A04788=5D=C2=A0=5B<c0250ad0>=5D=C2=A0(ksys_ioctl)=C2=
=A0from=C2=A0=5B<c0250b78>=5D=C2=A0(sys_ioctl+0x18/0x1c)=0D=0A=5B1-221.1826=
=5D=C2=A0=5B=C2=A0=20=C2=A0=20msg:=C2=A04788=5D=C2=A0=20r9:ca442000=C2=A0r8=
:c000924c=C2=A0r7:00000036=C2=A0r6:00000000=C2=A0r5:000006f7=C2=A0r4:000000=
00=0D=0A=5B1-221.1827=5D=C2=A0=5B=C2=A0=20=C2=A0=20msg:=C2=A04788=5D=C2=A0=
=5B<c0250b60>=5D=C2=A0(sys_ioctl)=C2=A0from=C2=A0=5B<c0009230>=5D=C2=A0(__s=
ys_trace_return+0x0/0x10)=0D=0A=0D=0A=0D=0A>>=C2=A0=0D=0A>>=C2=A0This=C2=A0=
below=C2=A0solution=C2=A0patch=C2=A0fixes=C2=A0this=C2=A0race=C2=A0conditio=
n=C2=A0at=C2=A0USB=C2=A0core=C2=A0level=0D=0A>>=C2=A0occurring=C2=A0during=
=C2=A0UVC=C2=A0webcam=C2=A0device=C2=A0disconnect.=0D=0A>>=C2=A0=0D=0A>>=C2=
=A0Signed-off-by:=C2=A0Anuj=C2=A0Gupta=C2=A0<anuj01.gupta=40samsung.com>=0D=
=0A>>=C2=A0Signed-off-by:=C2=A0Aman=C2=A0Deep=C2=A0<aman.deep=40samsung.com=
>=0D=0A>=0D=0A>What=C2=A0commit=C2=A0id=C2=A0does=C2=A0this=C2=A0fix?=C2=A0=
=20SHould=C2=A0this=C2=A0go=C2=A0to=C2=A0the=C2=A0stable=C2=A0trees?=0D=0A=
=0D=0A=0D=0AThis=20issue=20is=20present=20in=20stable=20trees=20and=20i=20h=
ave=20found=20few=20other=20online=20references=20for=20this=20issue=20repo=
rted=20before.=0D=0Ahttps://lore.kernel.org/all/CANiDSCsSn=3DUJfCt6shy8htGX=
APyeEceVzKva3eD+YxhC3YVmxA=40mail.gmail.com/t/=0D=0Ahttps://bugs.launchpad.=
net/ubuntu/+source/linux/+bug/1827452=0D=0A=0D=0A=0D=0A>>=C2=A0---=0D=0A>>=
=C2=A0=20drivers/usb/core/hcd.c=C2=A0=20=C2=A0=20=C2=A0=7C=C2=A07=C2=A0++++=
++-=0D=0A>>=C2=A0=20drivers/usb/core/message.c=C2=A0=7C=C2=A04=C2=A0++++=0D=
=0A>>=C2=A0=20drivers/usb/core/usb.c=C2=A0=20=C2=A0=20=C2=A0=7C=C2=A09=C2=
=A0++++++---=0D=0A>>=C2=A0=203=C2=A0files=C2=A0changed,=C2=A016=C2=A0insert=
ions(+),=C2=A04=C2=A0deletions(-)=0D=0A>=0D=0A>Why=C2=A0are=C2=A0you=C2=A0m=
aking=C2=A0changes=C2=A0to=C2=A0the=C2=A0core=C2=A0USB=C2=A0stack=C2=A0for=
=C2=A0a=C2=A0driver=C2=A0bug?=0D=0A=0D=0A=0D=0AI=20thought=20this=20issue=
=20can=20occur=20with=20other=20devices=20in=20simillar=20race=20conditions=
=20so=20i=20thought=20it=20will=20be=20fixed=20for=20all=20drivers.=0D=0A=
=0D=0A=0D=0A>>=C2=A0=0D=0A>>=C2=A0diff=C2=A0--git=C2=A0a/drivers/usb/core/h=
cd.c=C2=A0b/drivers/usb/core/hcd.c=0D=0A>>=C2=A0index=C2=A08300baedafd2..=
=C2=A0a06452cbbaa4=C2=A0100644=0D=0A>>=C2=A0---=C2=A0a/drivers/usb/core/hcd=
.c=0D=0A>>=C2=A0+++=C2=A0b/drivers/usb/core/hcd.c=0D=0A>>=C2=A0=40=40=C2=A0=
-1931,7=C2=A0+1931,12=C2=A0=40=40=C2=A0int=C2=A0usb_hcd_alloc_bandwidth(str=
uct=C2=A0usb_device=C2=A0*udev,=0D=0A>>=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=
=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=7D=0D=0A>>=C2=A0=20=C2=A0=20=
=C2=A0=20=C2=A0=20=C2=A0=20=7D=0D=0A>>=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=
=C2=A0=20if=C2=A0(cur_alt=C2=A0&&=C2=A0new_alt)=C2=A0=7B=0D=0A>>=C2=A0-=C2=
=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20struct=
=C2=A0usb_interface=C2=A0*iface=C2=A0=3D=C2=A0usb_ifnum_to_if(udev,=0D=0A>>=
=C2=A0+=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=
=A0=20struct=C2=A0usb_interface=C2=A0*iface;=0D=0A>>=C2=A0+=0D=0A>>=C2=A0+=
=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20if=
=C2=A0(udev->state=C2=A0=3D=3D=C2=A0USB_STATE_NOTATTACHED)=0D=0A>>=C2=A0+=
=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=
=A0=20=C2=A0=20=C2=A0=20=C2=A0=20return=C2=A0-ENODEV;=0D=0A>>=C2=A0+=0D=0A>=
>=C2=A0+=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=
=A0=20iface=C2=A0=3D=C2=A0usb_ifnum_to_if(udev,=0D=0A>>=C2=A0=20=C2=A0=20=
=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=
=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20cur_alt->desc.b=
InterfaceNumber);=0D=0A>>=C2=A0=20=0D=0A>>=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=
=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20if=C2=A0(=21iface)=0D=0A>>=
=C2=A0diff=C2=A0--git=C2=A0a/drivers/usb/core/message.c=C2=A0b/drivers/usb/=
core/message.c=0D=0A>>=C2=A0index=C2=A0b5811620f1de..f31c7287dc01=C2=A01006=
44=0D=0A>>=C2=A0---=C2=A0a/drivers/usb/core/message.c=0D=0A>>=C2=A0+++=C2=
=A0b/drivers/usb/core/message.c=0D=0A>>=C2=A0=40=40=C2=A0-1575,7=C2=A0+1575=
,11=C2=A0=40=40=C2=A0int=C2=A0usb_set_interface(struct=C2=A0usb_device=C2=
=A0*dev,=C2=A0int=C2=A0interface,=C2=A0int=C2=A0alternate)=0D=0A>>=C2=A0=20=
=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20for=C2=A0(i=C2=A0=3D=C2=A00;=C2=A0i=C2=
=A0<=C2=A0iface->cur_altsetting->desc.bNumEndpoints;=C2=A0i++)=0D=0A>>=C2=
=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=
=20iface->cur_altsetting->endpoint=5Bi=5D.streams=C2=A0=3D=C2=A00;=0D=0A>>=
=C2=A0=20=0D=0A>>=C2=A0+=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20if=C2=A0(dev->s=
tate=C2=A0=3D=3D=C2=A0USB_STATE_NOTATTACHED)=0D=0A>>=C2=A0+=C2=A0=20=C2=A0=
=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20return=C2=A0-ENODE=
V;=0D=0A>>=C2=A0+=0D=0A>>=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20ret=
=C2=A0=3D=C2=A0usb_hcd_alloc_bandwidth(dev,=C2=A0NULL,=C2=A0iface->cur_alts=
etting,=C2=A0alt);=0D=0A>>=C2=A0+=0D=0A>=0D=0A>Why=C2=A0the=C2=A0extra=C2=
=A0line?=0D=0A=0D=0AThis=20is=20done=20to=20provide=20more=20checking=20for=
=20disconnected=20device=20case.=0D=0A=0D=0A>=0D=0A>And=C2=A0why=C2=A0can't=
=C2=A0the=C2=A0state=C2=A0change=C2=A0right=C2=A0after=C2=A0you=C2=A0check=
=C2=A0for=C2=A0it?=C2=A0=20What=0D=0A>happens=C2=A0if=C2=A0the=C2=A0device=
=C2=A0is=C2=A0unattached=C2=A0right=C2=A0here?=0D=0A>=0D=0A=0D=0APlease=20s=
uggest=20if=20we=20need=20to=20add=20locking=20mechanism=20to=20cover=20suc=
h=20cases.=0D=0Ai=20will=20try=20accordingly.=0D=0A=0D=0A=0D=0A>>=C2=A0=20=
=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20if=C2=A0(ret=C2=A0<=C2=A00)=C2=A0=7B=0D=
=0A>>=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=
=20=C2=A0=20dev_info(&dev->dev,=C2=A0=22Not=C2=A0enough=C2=A0bandwidth=C2=
=A0for=C2=A0altsetting=C2=A0%d=5Cn=22,=0D=0A>>=C2=A0=20=C2=A0=20=C2=A0=20=
=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=
=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20alternate);=0D=0A>>=C2=
=A0diff=C2=A0--git=C2=A0a/drivers/usb/core/usb.c=C2=A0b/drivers/usb/core/us=
b.c=0D=0A>>=C2=A0index=C2=A0901ec732321c..6fb8b14469ae=C2=A0100644=0D=0A>>=
=C2=A0---=C2=A0a/drivers/usb/core/usb.c=0D=0A>>=C2=A0+++=C2=A0b/drivers/usb=
/core/usb.c=0D=0A>>=C2=A0=40=40=C2=A0-352,10=C2=A0+352,13=C2=A0=40=40=C2=A0=
struct=C2=A0usb_interface=C2=A0*usb_ifnum_to_if(const=C2=A0struct=C2=A0usb_=
device=C2=A0*dev,=0D=0A>>=C2=A0=20=0D=0A>>=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=
=20=C2=A0=20if=C2=A0(=21config)=0D=0A>>=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=
=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20return=C2=A0NULL;=0D=0A>>=C2=
=A0-=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20for=C2=A0(i=C2=A0=3D=C2=A00;=C2=A0i=
=C2=A0<=C2=A0config->desc.bNumInterfaces;=C2=A0i++)=0D=0A>>=C2=A0-=C2=A0=20=
=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20if=C2=A0(con=
fig->interface=5Bi=5D->altsetting=5B0=5D=0D=0A>>=C2=A0-=C2=A0=20=C2=A0=20=
=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=
=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20.desc.bInterfaceNumber=
=C2=A0=3D=3D=C2=A0ifnum)=0D=0A>>=C2=A0+=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=
for=C2=A0(i=C2=A0=3D=C2=A00;=C2=A0i=C2=A0<=C2=A0config->desc.bNumInterfaces=
;=C2=A0i++)=C2=A0=7B=0D=0A>>=C2=A0+=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=
=A0=20=C2=A0=20=C2=A0=20=C2=A0=20if=C2=A0(config->interface=5Bi=5D=C2=A0&&=
=0D=0A>>=C2=A0+=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=
=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=
=C2=A0=20config->interface=5Bi=5D->altsetting=5B0=5D=0D=0A>>=C2=A0+=C2=A0=
=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=
=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20.desc.bInter=
faceNumber=C2=A0=3D=3D=C2=A0ifnum)=C2=A0=7B=0D=0A>>=C2=A0=20=C2=A0=20=C2=A0=
=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=
=C2=A0=20=C2=A0=20return=C2=A0config->interface=5Bi=5D;=0D=0A>=0D=0A>I=C2=
=A0don't=C2=A0understand=C2=A0this=C2=A0change,=C2=A0what=C2=A0does=C2=A0it=
=C2=A0do?=0D=0A>=0D=0A>=0D=0A>Your=C2=A0changelog=C2=A0does=C2=A0not=C2=A0s=
ay=C2=A0why=C2=A0you=C2=A0are=C2=A0doing=C2=A0any=C2=A0of=C2=A0this,=C2=A0o=
nly=C2=A0that=0D=0A>=22there=C2=A0is=C2=A0a=C2=A0problem=22,=C2=A0please=C2=
=A0explain=C2=A0this=C2=A0better=C2=A0when=C2=A0you=C2=A0resubmit=C2=A0this=
.=0D=0A>=0D=0A>thanks,=0D=0A>=0D=0A>greg=C2=A0k-h=0D=0A=0D=0AThis=20is=20ju=
st=20for=20more=20NULL=20checking=20for=20pointers.=0D=0AIf=20you=20suggest=
,=20i=20can=20remove=20it.=0D=0A=0D=0A=0D=0AThanks,=0D=0AAman=20Deep=0D=0A=
=C2=A0=0D=0A=0D=0A

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 690C3766379
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 07:02:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229946AbjG1FBw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 01:01:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232860AbjG1FBq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 01:01:46 -0400
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10E762736
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 22:01:44 -0700 (PDT)
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20230728050142epoutp03e7213e664c03375ca69bbb20889ef0a2~173C1AH-p1831018310epoutp03c
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 05:01:42 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20230728050142epoutp03e7213e664c03375ca69bbb20889ef0a2~173C1AH-p1831018310epoutp03c
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1690520502;
        bh=SGKbvDGq5dDm+i7ooAM8tY7QMRPgqssebHTyJCoPuA0=;
        h=Subject:Reply-To:From:To:CC:Date:References:From;
        b=FWCqnwkgA5obDT276RyyLtYR1F1IutnuFczmfhiunD+5RmMYaLhNXhHPIzdEQt+Q4
         TKWIX/iMnetwrG64GneNlSaNLPvs59temwlO6bLTMTlXLQj7VDzOzeihpIYBPO1eYD
         E3LWVvfmkvWbaARe34yU1/MN5heEjYbscXnHq2HA=
Received: from epsmges5p3new.samsung.com (unknown [182.195.42.75]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTP id
        20230728050142epcas5p1753701771d31e2ee8ff23b2bca2279fd~173Ce3nuW2210722107epcas5p1v;
        Fri, 28 Jul 2023 05:01:42 +0000 (GMT)
X-AuditID: b6c32a4b-cafff700000017d3-88-64c34bb5d8ed
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        F2.52.06099.5BB43C46; Fri, 28 Jul 2023 14:01:42 +0900 (KST)
Mime-Version: 1.0
Subject: RE: Re: [PATCH] USB: Fix race condition during UVC webcam
 disconnect
Reply-To: aman.deep@samsung.com
Sender: AMAN DEEP <aman.deep@samsung.com>
From:   AMAN DEEP <aman.deep@samsung.com>
To:     Alan Stern <stern@rowland.harvard.edu>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
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
Message-ID: <20230728050117epcms5p10334ca8d1c6d498d90b6027e95856b1c@epcms5p1>
Date:   Fri, 28 Jul 2023 10:31:17 +0530
X-CMS-MailID: 20230728050117epcms5p10334ca8d1c6d498d90b6027e95856b1c
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrHIsWRmVeSWpSXmKPExsWy7bCmlu4278MpBh+fM1tcuelj0bx4PZtF
        58Ql7BaXd81hs1i0rJXZYsLvC2wObB6zO2ayeuyfu4bdY/bdH4wefVtWMXp83iQXwBrFZZOS
        mpNZllqkb5fAlTHxzTyWgmU3GSsurRZtYLx0mbGLkZNDQsBE4mfXfeYuRi4OIYHdjBKP9/QD
        JTg4eAUEJf7uEAapERbwl3i07S87iC0kIC+x+tEmRoi4psS5Sd/A4mwC6hKn/nwEs0UEtCQ2
        N70Em8kssJZJ4tbb2UwQy3glZrQ/ZYGwpSW2L98KdYSoxM3Vb9lh7PfH5kPFRSRa751lhrAF
        JR783A0Vl5HomLQDak61xITm60wgyyQEWhgl7lyYCFVkLrHr52owm1fAV+LKppdsII+xCKhK
        XLohA1HiIrHx61mw25gFtCWWLXzNDFLCDPTY+l36ECWyElNPrYMq4ZPo/f0E7pUd82BsZYn3
        Nz9AnS8pcfBSD9TJHhKdd2+xQsItUGL+rmbGCYzysxChOwvJ4lkIixcwMq9ilEwtKM5NTy02
        LTDOSy3XK07MLS7NS9dLzs/dxAhOIlreOxgfPfigd4iRiYPxEKMEB7OSCO+pgEMpQrwpiZVV
        qUX58UWlOanFhxilOViUxHlft85NERJITyxJzU5NLUgtgskycXBKNTDFZHct2xbeOKFD08ql
        5rPGvcgvz8P/HypZOf/70hdXjKZzRq99VKLA9CphpcYJ5cfVItOX5Uz55fxXwPOVlppF4je1
        8H2iefemcaeXf/jlJt1vbFP18fRO3Qtvj16YKmgsOq9QrPuCk8iHgMOLPCVMTnyrlDDMtPyh
        1dHRVbn+d9gvtdOvWmZczT3OViq4u/fREcEzGjetLnJPcmJt495796TpY9klttP9bBOa7Qu2
        MMy7dy5xT4KytoeN6Eaj6tDXazv8XHy2Tyv6x8bQc60zVmnS0c1Hyxy+TO3j+7xAvPl3wuTa
        L64293N2BYc9/nha+P3syemhSq0y6osDVR7cynBWELDyrPD6evD7n3NKLMUZiYZazEXFiQDN
        tiJKkQMAAA==
X-CMS-RootMailID: 20230720113203epcas5p1eb52bec9c076d1a2f3dac5e317d0361b
References: <CGME20230720113203epcas5p1eb52bec9c076d1a2f3dac5e317d0361b@epcms5p1>
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



Thanks for your detailed analysis.=C2=A0=0D=0ASorry=20for=20late=20reply=20=
and=20my=20answers=20are=20inline.=0D=0A=C2=A0=0D=0A>On=20Thu,=20Jul=2020,=
=202023=20at=2005:01:42PM=20+0530,=20Aman=20Deep=20wrote:=0D=0A>>=20In=20th=
e=20bug=20happened=20during=20uvc=20webcam=20disconect,there=20is=20race=0D=
=0A>>=20between=20stopping=20a=20video=20transfer=20and=20usb=20disconnect.=
=20This=20issue=20is=0D=0A>>=20reproduced=20in=20my=20system=20running=20Li=
nux=20kernel=20when=20UVC=20webcam=20play=20is=0D=0A>>=20stopped=20and=20UV=
C=20webcam=20is=20disconnected=20at=20the=20same=20time.=20This=20causes=20=
the=0D=0A>>=20below=20backtrace:=0D=0A>>=20=0D=0A>>=20=5B2-3496.7275=5D=C2=
=A0=20PC=20is=20at=200xbf418000+0x2d8=20=5Busbcore=5D=0D=0A>>=20=5B2-3496.7=
275=5D=C2=A0=20LR=20is=20at=200x00000005=0D=0A>>=20=5B2-3496.7275=5D=20pc=
=20:=20=5B<bf4182d8>=5D((usb_ifnum_to_if=0D=0A>>=20</drivers/usb/core/usb.c=
:283=0D=0A>>=20=5Busbcore.ko=5D>))=20lr=20:=20=5B<00000005>=5D()=20psr:=202=
0000013=0D=0A>>=20=5B2-3496.7275=5D=20Function=20entered=20at=20=5B<bf4182a=
4>=5D((usb_ifnum_to_if=0D=0A>>=20</drivers/usb/core/usb.c:275=0D=0A>>=20=5B=
usbcore.ko=5D>))=20(0xbf418000+0x2a4=20=5Busbcore=5D)=20from=0D=0A>>=20=5B<=
bf423974>=5D((usb_hcd_alloc_bandwidth=0D=0A>>=20</drivers/usb/core/hcd.c:19=
47=0D=0A>>=20=5Busbcore.ko=5D>))=20(0xbf418000+0xb974=20=5Busbcore=5D)=0D=
=0A>>=20=5B2-3496.7275=5D=20Function=20entered=20at=20=5B<bf423738>=5D((usb=
_hcd_alloc_bandwidth=0D=0A>>=20</drivers/usb/core/hcd.c:1876=0D=0A>>=20=5Bu=
sbcore.ko=5D>))=20(0xbf418000+0xb738=20=5Busbcore=5D)=20from=0D=0A>>=20=5B<=
bf426ca0>=5D((usb_set_interface=0D=0A>>=20</drivers/usb/core/message.c:1461=
=0D=0A>>=20=5Busbcore.ko=5D>))=20(0xbf418000+0xeca0=20=5Busbcore=5D)=0D=0A>=
>=20=5B2-3496.7275=5D=20Function=20entered=20at=20=5B<bf426b9c>=5D((usb_set=
_interface=0D=0A>>=20</drivers/usb/core/message.c:1385=0D=0A>>=20=5Busbcore=
.ko=5D>))=20(0xbf418000+0xeb9c=20=5Busbcore=5D)=20from=0D=0A>>=20=5B<bf9c4d=
d4>=5D((uvc_video_clock_cleanup=0D=0A>>=20</drivers/media/usb/uvc/uvc_video=
.c:598=0D=0A>>=20uvc_video_stop_streaming=0D=0A>>=20</drivers/media/usb/uvc=
/uvc_video.c:2221=0D=0A>>=20=5Buvcvideo.ko=5D>))=20(0xbf9bd000+0x7dd4=20=5B=
uvcvideo=5D)=0D=0A>>=20=5B2-3496.7275=5D=20Function=20entered=20at=20=5B<bf=
9c4d98>=5D((uvc_video_stop_streaming=0D=0A>>=20</drivers/media/usb/uvc/uvc_=
video.c:2200=0D=0A>>=20=5Buvcvideo.ko=5D>))=20(0xbf9bd000+0x7d98=20=5Buvcvi=
deo=5D)=20from=0D=0A>>=20=5B<bf9bfab8>=5D((spin_lock_irq=0D=0A>>=20</includ=
e/linux/spinlock.h:363=0D=0A>>=20uvc_stop_streaming=0D=0A>>=20</drivers/med=
ia/usb/uvc/uvc_queue.c:194=0D=0A>>=20=5Buvcvideo.ko=5D>))=20(0xbf9bd000+0x2=
ab8=20=5Buvcvideo=5D)=0D=0A>>=20=5B2-3496.7276=5D=20Function=20entered=20at=
=20=5B<bf9bfa94>=5D((uvc_stop_streaming=0D=0A>>=20</drivers/media/usb/uvc/u=
vc_queue.c:186=0D=0A>>=20=5Buvcvideo.ko=5D>))=20(0xbf9bd000+0x2a94=20=5Buvc=
video=5D)=20from=0D=0A>>=20=5B<be307150>=5D((__read_once_size=0D=0A>>=20</i=
nclude/linux/compiler.h:290=0D=0A>>=20(discriminator=201)=20__vb2_queue_can=
cel=0D=0A>>=20</drivers/media/common/videobuf2/videobuf2-core.c:1893=0D=0A>=
>=20(discriminator=201)=20=5Bvideobuf2_common.ko=5D>))=20(0xbe306000+0x1150=
=0D=0A>>=20=5Bvideobuf2_common=5D)=0D=0A>>=20=5B2-3496.7276=5D=20Function=
=20entered=20at=20=5B<be307120>=5D((__vb2_queue_cancel=0D=0A>>=20</drivers/=
media/common/videobuf2/videobuf2-core.c:1877=0D=0A>>=20=5Bvideobuf2_common.=
ko=5D>))=20(0xbe306000+0x1120=20=5Bvideobuf2_common=5D)=20from=0D=0A>>=20=
=5B<be308894>=5D((vb2_core_streamoff=0D=0A>>=20</drivers/media/common/video=
buf2/videobuf2-core.c:2053=0D=0A>=0D=0A>This=20backtrace=20doesn't=20show=
=20what=20actually=20caused=20the=20bug.=C2=A0=20You=20should=20=0D=0A>have=
=20included=20several=20lines=20from=20the=20system=20log=20_preceding_=20t=
he=20=0D=0A>backtrace.=C2=A0=20Without=20those=20lines,=20we=20can=20only=
=20guess=20at=20what=20the=20problem=20=0D=0A>was.=0D=0A=0D=0A=0D=0AThis=20=
is=20below=20complete=20backtrace=20for=20crash=20problem:=0D=0A=0D=0A=0D=
=0A=5B1-221.1821=5D=C2=A0=5B=C2=A0=20=C2=A0=20msg:=C2=A04788=5D=C2=A0Unable=
=C2=A0to=C2=A0handle=C2=A0kernel=C2=A0NULL=C2=A0pointer=C2=A0dereference=C2=
=A0at=C2=A0virtual=C2=A0address=C2=A000000000=0D=0A=5B1-221.1821=5D=C2=A0=
=5B=C2=A0=20=C2=A0=20msg:=C2=A04788=5D=C2=A0pgd=C2=A0=3D=C2=A0e136ded4=0D=
=0A=5B1-221.1821=5D=C2=A0=5B=C2=A0=20=C2=A0=20msg:=C2=A04788=5D=C2=A0=5B000=
00000=5D=C2=A0*pgd=3D26210003,=C2=A0*pmd=3D00000000=0D=0A=5B1-221.1821=5D=
=C2=A0=5B=C2=A0=20=C2=A0=20msg:=C2=A04788=5D=C2=A0=0D=0A=5B1-221.1821=5D=C2=
=A0=5B=C2=A0=20=C2=A0=20msg:=C2=A04788=5D=C2=A0Die=C2=A0cpu=C2=A0info=C2=A0=
:=0D=0A=5B1-221.1821=5D=C2=A0=5B=C2=A0=20=C2=A0=20msg:=C2=A04788=5D=C2=A0In=
ternal=C2=A0error:=C2=A0Oops:=C2=A0206=C2=A0=5B=231=5D=C2=A0PREEMPT=C2=A0SM=
P=C2=A0ARM=0D=0A=5B1-221.1821=5D=C2=A0=5B=C2=A0=20=C2=A0=20msg:=C2=A04788=
=5D=C2=A0CPU:=C2=A01=C2=A0PID:=C2=A04788=C2=A0Comm:=C2=A0msg(muse-server)=
=C2=A0Kdump:=C2=A0loaded=C2=A0Tainted:=C2=A0PO=C2=A05.4.77=C2=A0=231=C2=A0P=
PID:=C2=A01=C2=A0PComm:=C2=A0systemd=C2=A0preempt_count:=C2=A00x0=0D=0A=5B1=
-221.1821=5D=C2=A0=5B=C2=A0=20=C2=A0=20msg:=C2=A04788=5D=C2=A0Hardware=C2=
=A0name:=C2=A0Novatek=C2=A0Cortex-A53=0D=0A=5B1-221.1822=5D=C2=A0=5B=C2=A0=
=20=C2=A0=20msg:=C2=A04788=5D=C2=A0PC=C2=A0is=C2=A0at=C2=A0usb_ifnum_to_if+=
0x30/0x74=C2=A0=5Busbcore=5D=0D=0A=5B1-221.1822=5D=C2=A0=5B=C2=A0=20=C2=A0=
=20msg:=C2=A04788=5D=C2=A0LR=C2=A0is=C2=A0at=C2=A00x5=0D=0A=5B1-221.1822=5D=
=C2=A0=5B=C2=A0=20=C2=A0=20msg:=C2=A04788=5D=C2=A0pc=C2=A0:=C2=A0=5B<bede13=
00>=5D=C2=A0=20=C2=A0=20lr=C2=A0:=C2=A0=5B<00000005>=5D=C2=A0=20=C2=A0=20ps=
r:=C2=A020000113=0D=0A=5B1-221.1822=5D=C2=A0=5B=C2=A0=20=C2=A0=20msg:=C2=A0=
4788=5D=C2=A0sp=C2=A0:=C2=A0ca443c18=C2=A0=20ip=C2=A0:=C2=A0ca443c28=C2=A0=
=20fp=C2=A0:=C2=A0ca443c24=0D=0A=5B1-221.1822=5D=C2=A0=5B=C2=A0=20=C2=A0=20=
msg:=C2=A04788=5D=C2=A0r10:=C2=A0e668b6c8=C2=A0=20r9=C2=A0:=C2=A000000000=
=C2=A0=20r8=C2=A0:=C2=A0e668b7e0=0D=0A=5B1-221.1822=5D=C2=A0=5B=C2=A0=20=C2=
=A0=20msg:=C2=A04788=5D=C2=A0r7=C2=A0:=C2=A0e7b78880=C2=A0=20r6=C2=A0:=C2=
=A0bf1d9db0=C2=A0=20r5=C2=A0:=C2=A0e668b6c8=C2=A0=20r4=C2=A0:=C2=A0e690c000=
=0D=0A=5B1-221.1822=5D=C2=A0=5B=C2=A0=20=C2=A0=20msg:=C2=A04788=5D=C2=A0r3=
=C2=A0:=C2=A000002000=C2=A0=20r2=C2=A0:=C2=A0e696ac40=C2=A0=20r1=C2=A0:=C2=
=A000000001=C2=A0=20r0=C2=A0:=C2=A000000000=0D=0A=5B1-221.1822=5D=C2=A0=5B=
=C2=A0=20=C2=A0=20msg:=C2=A04788=5D=C2=A0Flags:=C2=A0nzCv=C2=A0=20IRQs=C2=
=A0on=C2=A0=20FIQs=C2=A0on=C2=A0=20Mode=C2=A0SVC_32=C2=A0=20ISA=C2=A0ARM=C2=
=A0=20Segment=C2=A0user=0D=0A=5B1-221.1822=5D=C2=A0=5B=C2=A0=20=C2=A0=20msg=
:=C2=A04788=5D=C2=A0Control:=C2=A030c5383d=C2=A0=20Table:=C2=A0261f8a80=C2=
=A0=20DAC:=C2=A0e45d65d5=0D=0A=5B1-221.1822=5D=C2=A0=5B=C2=A0=20=C2=A0=20ms=
g:=C2=A04788=5D=C2=A0Process=C2=A0msg=C2=A0(pid:=C2=A04788,=C2=A0stack=C2=
=A0limit=C2=A0=3D=C2=A00xa0153238)=0D=0A=5B1-221.1822=5D=C2=A0=5B=C2=A0=20=
=C2=A0=20msg:=C2=A04788=5D=C2=A0Stack:=C2=A0(0xca443c18=C2=A0to=C2=A00xca44=
4000)=0D=0A=5B1-221.1822=5D=C2=A0=5B=C2=A0=20=C2=A0=20msg:=C2=A04788=5D=C2=
=A03c00:=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=
=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=
=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=
=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0ca443c64=C2=A0ca443c28=0D=0A=5B1-221.1822=
=5D=C2=A0=5B=C2=A0=20=C2=A0=20msg:=C2=A04788=5D=C2=A03c20:=C2=A0bedee6e4=C2=
=A0bede12dc=C2=A000000000=C2=A0bee0ae78=C2=A0ca443c54=C2=A0ca443c40=C2=A0c0=
83c894=C2=A0e7b78880=0D=0A=5B1-221.1822=5D=C2=A0=5B=C2=A0=20=C2=A0=20msg:=
=C2=A04788=5D=C2=A03c40:=C2=A0e6b88340=C2=A000000000=C2=A0bee0ae78=C2=A0000=
00001=C2=A0e690c000=C2=A0e668b6c8=C2=A0ca443cb4=C2=A0ca443c68=0D=0A=5B1-221=
.1822=5D=C2=A0=5B=C2=A0=20=C2=A0=20msg:=C2=A04788=5D=C2=A03c60:=C2=A0bedf22=
ac=C2=A0bedee64c=C2=A0e5cf1508=C2=A0e5cf1508=C2=A0e5cf0000=C2=A0e5cf0330=C2=
=A000000001=C2=A0e5cf0330=0D=0A=5B1-221.1822=5D=C2=A0=5B=C2=A0=20=C2=A0=20m=
sg:=C2=A04788=5D=C2=A03c80:=C2=A0ca443ca4=C2=A0ca443c90=C2=A0c083c894=C2=A0=
e5cf0000=C2=A0e5cf0330=C2=A000000001=C2=A0e5cf0330=C2=A000000000=0D=0A=5B1-=
221.1822=5D=C2=A0=5B=C2=A0=20=C2=A0=20msg:=C2=A04788=5D=C2=A03ca0:=C2=A0000=
00001=C2=A0c08d1b3c=C2=A0ca443ccc=C2=A0ca443cb8=C2=A0bfb3f958=C2=A0bedf1ff4=
=C2=A0e5cf0330=C2=A0e5cf0330=0D=0A=5B1-221.1822=5D=C2=A0=5B=C2=A0=20=C2=A0=
=20msg:=C2=A04788=5D=C2=A03cc0:=C2=A0ca443ce4=C2=A0ca443cd0=C2=A0bfb3a024=
=C2=A0bfb3f8a8=C2=A0e5cf0330=C2=A0e5cf0330=C2=A0ca443d14=C2=A0ca443ce8=0D=
=0A=5B1-221.1823=5D=C2=A0=5B=C2=A0=20=C2=A0=20msg:=C2=A04788=5D=C2=A03ce0:=
=C2=A0be3661e0=C2=A0bfb3a004=C2=A000000001=C2=A0e5cf0330=C2=A0e5cf0330=C2=
=A000000001=C2=A0c05d6260=C2=A000000000=0D=0A=5B1-221.1823=5D=C2=A0=5B=C2=
=A0=20=C2=A0=20msg:=C2=A04788=5D=C2=A03d00:=C2=A000000001=C2=A0c08d1b3c=C2=
=A0ca443d2c=C2=A0ca443d18=C2=A0be367994=C2=A0be3661b4=C2=A0e5cf0484=C2=A0e5=
cf0330=0D=0A=5B1-221.1823=5D=C2=A0=5B=C2=A0=20=C2=A0=20msg:=C2=A04788=5D=C2=
=A03d20:=C2=A0ca443d3c=C2=A0ca443d30=C2=A0be37e3e4=C2=A0be367978=C2=A0ca443=
d5c=C2=A0ca443d40=C2=A0bfb3a518=C2=A0be37e3cc=0D=0A=5B1-221.1823=5D=C2=A0=
=5B=C2=A0=20=C2=A0=20msg:=C2=A04788=5D=C2=A03d40:=C2=A0e5cf030c=C2=A0e5cf00=
00=C2=A000000001=C2=A0c05d6260=C2=A0ca443d7c=C2=A0ca443d60=C2=A0bfb3b628=C2=
=A0bfb3a4f0=0D=0A=5B1-221.1823=5D=C2=A0=5B=C2=A0=20=C2=A0=20msg:=C2=A04788=
=5D=C2=A03d60:=C2=A0bfb3b5e8=C2=A040045613=C2=A000000000=C2=A0c05d6260=C2=
=A0ca443d94=C2=A0ca443d80=C2=A0c05d6288=C2=A0bfb3b5f4=0D=0A=5B1-221.1823=5D=
=C2=A0=5B=C2=A0=20=C2=A0=20msg:=C2=A04788=5D=C2=A03d80:=C2=A0e5cf0010=C2=A0=
40045613=C2=A0ca443dfc=C2=A0ca443d98=C2=A0c05d9b84=C2=A0c05d626c=C2=A000000=
068=C2=A0ca443deb=0D=0A=5B1-221.1823=5D=C2=A0=5B=C2=A0=20=C2=A0=20msg:=C2=
=A04788=5D=C2=A03da0:=C2=A0c08d1b3c=C2=A000000001=C2=A0ca443e24=C2=A0bfb446=
80=C2=A000000000=C2=A0e2fa3780=C2=A0c01a926c=C2=A0031e1090=0D=0A=5B1-221.18=
23=5D=C2=A0=5B=C2=A0=20=C2=A0=20msg:=C2=A04788=5D=C2=A03dc0:=C2=A0ca443df4=
=C2=A0ffffffff=C2=A0c01e0048=C2=A00000072c=C2=A0000012b4=C2=A000000000=C2=
=A040045613=C2=A000000000=0D=0A=5B1-221.1823=5D=C2=A0=5B=C2=A0=20=C2=A0=20m=
sg:=C2=A04788=5D=C2=A03de0:=C2=A000000000=C2=A000000001=C2=A000000004=C2=A0=
ca443e24=C2=A0ca443ed4=C2=A0ca443e00=C2=A0c05db320=C2=A0c05d9a04=0D=0A=5B1-=
221.1823=5D=C2=A0=5B=C2=A0=20=C2=A0=20msg:=C2=A04788=5D=C2=A03e00:=C2=A0000=
00000=C2=A000000000=C2=A0c05d99f8=C2=A0e77a6700=C2=A0ab8fd26c=C2=A000000000=
=C2=A000000000=C2=A000000000=0D=0A=5B1-221.1823=5D=C2=A0=5B=C2=A0=20=C2=A0=
=20msg:=C2=A04788=5D=C2=A03e20:=C2=A0ca443f60=C2=A000000001=C2=A0ca443ee0=
=C2=A000000000=C2=A0ca443e9c=C2=A0ca443e40=C2=A0c02390a8=C2=A0be211e84=0D=
=0A=5B1-221.1823=5D=C2=A0=5B=C2=A0=20=C2=A0=20msg:=C2=A04788=5D=C2=A03e40:=
=C2=A000000000=C2=A000000001=C2=A0e2861600=C2=A000000000=C2=A000000000=C2=
=A000000000=C2=A000000000=C2=A000000000=0D=0A=5B1-221.1823=5D=C2=A0=5B=C2=
=A0=20=C2=A0=20msg:=C2=A04788=5D=C2=A03e60:=C2=A000000000=C2=A000000000=C2=
=A000000000=C2=A0c03681bc=C2=A000000008=C2=A000000000=C2=A0ca443ee0=C2=A0c0=
bbd748=0D=0A=5B1-221.1823=5D=C2=A0=5B=C2=A0=20=C2=A0=20msg:=C2=A04788=5D=C2=
=A03e80:=C2=A000000000=C2=A0c0be9a14=C2=A0ca443ef4=C2=A000000002=C2=A0ca443=
ed4=C2=A0ca443ea0=C2=A0c03681bc=C2=A0c036790c=0D=0A=5B1-221.1823=5D=C2=A0=
=5B=C2=A0=20=C2=A0=20msg:=C2=A04788=5D=C2=A03ea0:=C2=A0ca443ef4=C2=A0c0bbd7=
48=C2=A0e2861600=C2=A0c05db7dc=C2=A0e6695448=C2=A040045613=C2=A0ab8fd26c=C2=
=A0e77a6700=0D=0A=5B1-221.1823=5D=C2=A0=5B=C2=A0=20=C2=A0=20msg:=C2=A04788=
=5D=C2=A03ec0:=C2=A000000021=C2=A000000036=C2=A0ca443ee4=C2=A0ca443ed8=C2=
=A0c05db7fc=C2=A0c05db0f8=C2=A0ca443efc=C2=A0ca443ee8=0D=0A=5B1-221.1823=5D=
=C2=A0=5B=C2=A0=20=C2=A0=20msg:=C2=A04788=5D=C2=A03ee0:=C2=A0c05d4728=C2=A0=
c05db7e8=C2=A0ab8fd26c=C2=A0e6695448=C2=A0ca443f6c=C2=A0ca443f00=C2=A0c0250=
6a0=C2=A0c05d46e8=0D=0A=5B1-221.1823=5D=C2=A0=5B=C2=A0=20=C2=A0=20msg:=C2=
=A04788=5D=C2=A03f00:=C2=A0ca443f04=C2=A0c08a7a00=C2=A000000000=C2=A0000000=
00=C2=A000000000=C2=A000000000=C2=A000000000=C2=A000000000=0D=0A=5B1-221.18=
23=5D=C2=A0=5B=C2=A0=20=C2=A0=20msg:=C2=A04788=5D=C2=A03f20:=C2=A000000000=
=C2=A000000000=C2=A000000000=C2=A000000000=C2=A0ab8fd26c=C2=A0c0abb6ec=C2=
=A0ab8fd26c=C2=A0e77a6700=0D=0A=5B1-221.1823=5D=C2=A0=5B=C2=A0=20=C2=A0=20m=
sg:=C2=A04788=5D=C2=A03f40:=C2=A0ca443f6c=C2=A0e77a6701=C2=A000000000=C2=A0=
40045613=C2=A0ab8fd26c=C2=A0e77a6700=C2=A000000021=C2=A000000036=0D=0A=5B1-=
221.1824=5D=C2=A0=5B=C2=A0=20=C2=A0=20msg:=C2=A04788=5D=C2=A03f60:=C2=A0ca4=
43f94=C2=A0ca443f70=C2=A0c0250b3c=C2=A0c02502fc=C2=A000000000=C2=A0000006f7=
=C2=A000000000=C2=A000000036=0D=0A=5B1-221.1824=5D=C2=A0=5B=C2=A0=20=C2=A0=
=20msg:=C2=A04788=5D=C2=A03f80:=C2=A0c000924c=C2=A0ca442000=C2=A0ca443fa4=
=C2=A0ca443f98=C2=A0c0250b78=C2=A0c0250adc=C2=A000000000=C2=A0ca443fa8=0D=
=0A=5B1-221.1824=5D=C2=A0=5B=C2=A0=20=C2=A0=20msg:=C2=A04788=5D=C2=A03fa0:=
=C2=A0c0009230=C2=A0c0250b6c=C2=A000000000=C2=A0000006f7=C2=A000000021=C2=
=A040045613=C2=A0ab8fd26c=C2=A000000021=0D=0A=5B1-221.1824=5D=C2=A0=5B=C2=
=A0=20=C2=A0=20msg:=C2=A04788=5D=C2=A03fc0:=C2=A000000000=C2=A0000006f7=C2=
=A000000000=C2=A000000036=C2=A0abb79e30=C2=A000000000=C2=A000000001=C2=A0ab=
b79e28=0D=0A=5B1-221.1824=5D=C2=A0=5B=C2=A0=20=C2=A0=20msg:=C2=A04788=5D=C2=
=A03fe0:=C2=A0aeca607c=C2=A0ab8fd24c=C2=A0aec8e749=C2=A0b5f1ed1c=C2=A020000=
010=C2=A000000021=C2=A000000000=C2=A000000000=0D=0A=5B1-221.1824=5D=C2=A0=
=5B=C2=A0=20=C2=A0=20msg:=C2=A04788=5D=C2=A0Backtrace:=C2=A0=0D=0A=5B1-221.=
1824=5D=C2=A0=5B=C2=A0=20=C2=A0=20msg:=C2=A04788=5D=C2=A0=5B<bede12d0>=5D=
=C2=A0(usb_ifnum_to_if=C2=A0=5Busbcore=5D)=C2=A0from=C2=A0=5B<bedee6e4>=5D=
=C2=A0(usb_hcd_alloc_bandwidth+0xa4/0x564=C2=A0=5Busbcore=5D)=0D=0A=5B1-221=
.1824=5D=C2=A0=5B=C2=A0=20=C2=A0=20msg:=C2=A04788=5D=C2=A0=5B<bedee640>=5D=
=C2=A0(usb_hcd_alloc_bandwidth=C2=A0=5Busbcore=5D)=C2=A0from=C2=A0=5B<bedf2=
2ac>=5D=C2=A0(usb_set_interface+0x2c4/0x61c=C2=A0=5Busbcore=5D)=0D=0A=5B1-2=
21.1824=5D=C2=A0=5B=C2=A0=20=C2=A0=20msg:=C2=A04788=5D=C2=A0=20r10:e668b6c8=
=C2=A0r9:e690c000=C2=A0r8:00000001=C2=A0r7:bee0ae78=C2=A0r6:00000000=C2=A0r=
5:e6b88340=0D=0A=5B1-221.1824=5D=C2=A0=5B=C2=A0=20=C2=A0=20msg:=C2=A04788=
=5D=C2=A0=20r4:e7b78880=0D=0A=5B1-221.1825=5D=C2=A0=5B=C2=A0=20=C2=A0=20msg=
:=C2=A04788=5D=C2=A0=5B<bedf1fe8>=5D=C2=A0(usb_set_interface=C2=A0=5Busbcor=
e=5D)=C2=A0from=C2=A0=5B<bfb3f958>=5D=C2=A0(uvc_video_stop_streaming+0xbc/0=
xc4=C2=A0=5Buvcvideo=5D)=0D=0A=5B1-221.1825=5D=C2=A0=5B=C2=A0=20=C2=A0=20ms=
g:=C2=A04788=5D=C2=A0=20r10:c08d1b3c=C2=A0r9:00000001=C2=A0r8:00000000=C2=
=A0r7:e5cf0330=C2=A0r6:00000001=C2=A0r5:e5cf0330=0D=0A=5B1-221.1825=5D=C2=
=A0=5B=C2=A0=20=C2=A0=20msg:=C2=A04788=5D=C2=A0=20r4:e5cf0000=0D=0A=5B1-221=
.1825=5D=C2=A0=5B=C2=A0=20=C2=A0=20msg:=C2=A04788=5D=C2=A0=5B<bfb3f89c>=5D=
=C2=A0(uvc_video_stop_streaming=C2=A0=5Buvcvideo=5D)=C2=A0from=C2=A0=5B<bfb=
3a024>=5D=C2=A0(uvc_stop_streaming+0x2c/0x50=C2=A0=5Buvcvideo=5D)=0D=0A=5B1=
-221.1825=5D=C2=A0=5B=C2=A0=20=C2=A0=20msg:=C2=A04788=5D=C2=A0=20r5:e5cf033=
0=C2=A0r4:e5cf0330=0D=0A=5B1-221.1825=5D=C2=A0=5B=C2=A0=20=C2=A0=20msg:=C2=
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
ys_trace_return+0x0/0x10)=0D=0A=0D=0A=0D=0A>>=20This=20below=20solution=20p=
atch=20fixes=20this=20race=20condition=20at=20USB=20core=20level=0D=0A>>=20=
occurring=20during=20UVC=20webcam=20device=20disconnect.=0D=0A>=0D=0A>How=
=20can=20a=20race=20in=20the=20UVC=20driver=20be=20fixed=20by=20changing=20=
the=20USB=20core?=C2=A0=20It=20=0D=0A>seems=20obvious=20that=20the=20only=
=20way=20to=20fix=20such=20a=20race=20is=20by=20changing=20the=20=0D=0A>UVC=
=20driver.=0D=0A=0D=0A=0D=0AI=20think=20solution=20fixed=20at=20USB=20core=
=20level=20avoids=20race=20condition=20for=20all=20kind=20of=20devices=20an=
d=20drivers.=0D=0A=0D=0A=0D=0A>>=20Signed-off-by:=20Anuj=20Gupta=20<anuj01.=
gupta=40samsung.com>=0D=0A>>=20Signed-off-by:=20Aman=20Deep=20<aman.deep=40=
samsung.com>=0D=0A>>=20---=0D=0A>>=C2=A0=20drivers/usb/core/hcd.c=C2=A0=20=
=C2=A0=20=20=7C=207=20++++++-=0D=0A>>=C2=A0=20drivers/usb/core/message.c=20=
=7C=204=20++++=0D=0A>>=C2=A0=20drivers/usb/core/usb.c=C2=A0=20=C2=A0=20=20=
=7C=209=20++++++---=0D=0A>>=C2=A0=203=20files=20changed,=2016=20insertions(=
+),=204=20deletions(-)=0D=0A>>=20=0D=0A>>=20diff=20--git=20a/drivers/usb/co=
re/hcd.c=20b/drivers/usb/core/hcd.c=0D=0A>>=20index=208300baedafd2..=20a064=
52cbbaa4=20100644=0D=0A>>=20---=20a/drivers/usb/core/hcd.c=0D=0A>>=20+++=20=
b/drivers/usb/core/hcd.c=0D=0A>>=20=40=40=20-1931,7=20+1931,12=20=40=40=20i=
nt=20usb_hcd_alloc_bandwidth(struct=20usb_device=20*udev,=0D=0A>>=C2=A0=20=
=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=7D=
=0D=0A>>=C2=A0=20=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=7D=0D=0A>>=C2=A0=20=
=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0if=20(cur_alt=20&&=20new_alt)=20=7B=0D=
=0A>>=20-=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=
=C2=A0struct=20usb_interface=20*iface=20=3D=20usb_ifnum_to_if(udev,=0D=0A>>=
=20+=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=
=A0struct=20usb_interface=20*iface;=0D=0A>>=20+=0D=0A>>=20+=20=C2=A0=20=C2=
=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0if=20(udev->state=
=20=3D=3D=20USB_STATE_NOTATTACHED)=0D=0A>>=20+=20=C2=A0=20=C2=A0=20=C2=A0=
=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=
=C2=A0return=20-ENODEV;=0D=0A>=0D=0A>What=20will=20happen=20if=20the=20stat=
e=20changes=20to=20USB_STATE_NOTATTACHED=20at=20this=20=0D=0A>point,=20afte=
r=20that=20test=20was=20made?=0D=0A=0D=0A=0D=0APlease=20suggest=20if=20i=20=
should=20add=20some=20propr=20locking=20mechanism=20to=20avoid=20this.=0D=
=0AI=20will=20add=20accordingly.=0D=0A=0D=0A=0D=0A>>=20+=0D=0A>>=20+=20=C2=
=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0iface=20=
=3D=20usb_ifnum_to_if(udev,=0D=0A>>=C2=A0=20=20=C2=A0=20=C2=A0=20=C2=A0=20=
=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=
=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0cur_alt->desc.bInterfaceNumber);=0D=
=0A>>=C2=A0=20=0D=0A>>=C2=A0=20=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=
=A0=20=C2=A0=20=C2=A0=20=C2=A0if=20(=21iface)=0D=0A>>=20diff=20--git=20a/dr=
ivers/usb/core/message.c=20b/drivers/usb/core/message.c=0D=0A>>=20index=20b=
5811620f1de..=20f31c7287dc01=20100644=0D=0A>>=20---=20a/drivers/usb/core/me=
ssage.c=0D=0A>>=20+++=20b/drivers/usb/core/message.c=0D=0A>>=20=40=40=20-15=
75,7=20+1575,11=20=40=40=20int=20usb_set_interface(struct=20usb_device=20*d=
ev,=20int=20interface,=20int=20alternate)=0D=0A>>=C2=A0=20=20=C2=A0=20=C2=
=A0=20=C2=A0=20=C2=A0for=20(i=20=3D=200;=20i=20<=20iface->cur_altsetting->d=
esc.bNumEndpoints;=20i++)=0D=0A>>=C2=A0=20=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=
=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0iface->cur_altsetting->endpoint=5Bi=
=5D.streams=20=3D=200;=0D=0A>>=C2=A0=20=0D=0A>>=20+=20=C2=A0=20=C2=A0=20=C2=
=A0=20=C2=A0if=20(dev->state=20=3D=3D=20USB_STATE_NOTATTACHED)=0D=0A>>=20+=
=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0ret=
urn=20-ENODEV;=0D=0A>=0D=0A>Same=20question:=20What=20happens=20if=20the=20=
state=20changes=20right=20here?=0D=0A=0D=0A=0D=0Ayes,=20please=20suggest=20=
more=20required=20changes=20for=20it.=0D=0A=0D=0A=0D=0A>>=20+=0D=0A>>=C2=A0=
=20=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0ret=20=3D=20usb_hcd_alloc_bandwidth(=
dev,=20NULL,=20iface->cur_altsetting,=20alt);=0D=0A>>=20+=0D=0A>>=C2=A0=20=
=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0if=20(ret=20<=200)=20=7B=0D=0A>>=C2=A0=
=20=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=
dev_info(&dev->dev,=20=22Not=20enough=20bandwidth=20for=20altsetting=20%d=
=5Cn=22,=0D=0A>>=C2=A0=20=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=
=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=
=A0=20=C2=A0=20=C2=A0alternate);=0D=0A>>=20diff=20--git=20a/drivers/usb/cor=
e/usb.c=20b/drivers/usb/core/usb.c=0D=0A>>=20index=20901ec732321c..=206fb8b=
14469ae=20100644=0D=0A>>=20---=20a/drivers/usb/core/usb.c=0D=0A>>=20+++=20b=
/drivers/usb/core/usb.c=0D=0A>>=20=40=40=20-352,10=20+352,13=20=40=40=20str=
uct=20usb_interface=20*usb_ifnum_to_if(const=20struct=20usb_device=20*dev,=
=0D=0A>>=C2=A0=20=0D=0A>>=C2=A0=20=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0if=20=
(=21config)=0D=0A>>=C2=A0=20=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=
=20=C2=A0=20=C2=A0=20=C2=A0return=20NULL;=0D=0A>>=20-=20=C2=A0=20=C2=A0=20=
=C2=A0=20=C2=A0for=20(i=20=3D=200;=20i=20<=20config->desc.bNumInterfaces;=
=20i++)=0D=0A>>=20-=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=
=20=C2=A0=20=C2=A0if=20(config->interface=5Bi=5D->altsetting=5B0=5D=0D=0A>>=
=20-=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=
=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=
.desc.bInterfaceNumber=20=3D=3D=20ifnum)=0D=0A>>=20+=20=C2=A0=20=C2=A0=20=
=C2=A0=20=C2=A0for=20(i=20=3D=200;=20i=20<=20config->desc.bNumInterfaces;=
=20i++)=20=7B=0D=0A>>=20+=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=
=C2=A0=20=C2=A0=20=C2=A0if=20(config->interface=5Bi=5D=20&&=0D=0A>=0D=0A>Th=
is=20new=20test=20can=20fail=20only=20if=20the=20routine=20is=20called=20af=
ter=20(or=20while)=20=0D=0A>the=20device=20is=20unconfigured=20or=20removed=
.=C2=A0=20But=20if=20a=20driver=20makes=20such=20a=20=0D=0A>call=20then=20t=
he=20driver=20is=20buggy.=C2=A0=20The=20proper=20solution=20is=20to=20fix=
=20the=20=0D=0A>driver,=20not=20add=20this=20test=20here.=0D=0A>=0D=0A>Besi=
des,=20this=20test=20has=20the=20same=20problem=20as=20the=20others=20you=
=20added=20above.=C2=A0=20=0D=0A>What=20happens=20if=20config->interface=5B=
i=5D=20gets=20set=20to=20NULL=20right=20here?=0D=0A>=0D=0A>Alan=20Stern=0D=
=0A>=0D=0A=0D=0AAll=20above=20changes=20resolve=20existing=20issue=20and=20=
at=20USB=20core=20level,=20it=20will=20avoid=20simillar=20race=20conditions=
=20for=20all=20others.=0D=0A=0D=0A=0D=0A>>=20+=20=C2=A0=20=C2=A0=20=C2=A0=
=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=
=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0config->interface=5Bi=5D->altsett=
ing=5B0=5D=0D=0A>>=20+=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=
=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=
=20=C2=A0=20=C2=A0.desc.bInterfaceNumber=20=3D=3D=20ifnum)=20=7B=0D=0A>>=C2=
=A0=20=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=
=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0return=20config->interface=5Bi=5D;=
=0D=0A>>=20+=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=
=20=C2=A0=7D=0D=0A>>=20+=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=7D=0D=0A>>=C2=
=A0=20=0D=0A>>=C2=A0=20=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0return=20NULL;=
=0D=0A>>=C2=A0=20=7D=0D=0A>>=20--=20=0D=0A>>=202.34.1=0D=0A>>=20=0D=0A=0D=
=0A=0D=0A=C2=A0=0D=0A=0D=0A

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F225C76C632
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 09:14:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232714AbjHBHON (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 03:14:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232697AbjHBHOI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 03:14:08 -0400
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8222D172B
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 00:14:04 -0700 (PDT)
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20230802071401epoutp014ebab213ef955d4788b6690e6b658c00~3f4-7Viaj0609906099epoutp01a
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 07:14:01 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20230802071401epoutp014ebab213ef955d4788b6690e6b658c00~3f4-7Viaj0609906099epoutp01a
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1690960441;
        bh=vdidDrgoxFNtAU59G6U6meSnH4GCYp9SFmNJE4QDbRI=;
        h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
        b=Vf9iP9AmmY/7pGFjhnof1coqe3TPJEgGfjY+70PklDpvkgoWySMweqa3SPN70LqNU
         FAsWqeNlqNKn8EIJZFIYChbIYPrwyPeM2Vpi5t8uNhEh62JO4W0fAGLABwvfVjrSdr
         G6OgpXN1de6DiKwq3QGcZJbIq/HtIVySBo/DAvdM=
Received: from epsmges5p2new.samsung.com (unknown [182.195.42.74]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTP id
        20230802071400epcas5p3d63405bb1ea7cd890e97e28112438844~3f4-cZdfD0557305573epcas5p3D;
        Wed,  2 Aug 2023 07:14:00 +0000 (GMT)
X-AuditID: b6c32a4a-ec1fd7000000acda-b3-64ca02385d02
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        58.8C.44250.8320AC46; Wed,  2 Aug 2023 16:14:00 +0900 (KST)
Mime-Version: 1.0
Subject: RE: Re: [PATCH] USB: Fix race condition during UVC webcam
 disconnect
Reply-To: aman.deep@samsung.com
Sender: AMAN DEEP <aman.deep@samsung.com>
From:   AMAN DEEP <aman.deep@samsung.com>
To:     Oliver Neukum <oneukum@suse.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        "mchehab@kernel.org" <mchehab@kernel.org>
CC:     "stern@rowland.harvard.edu" <stern@rowland.harvard.edu>,
        "laurent.pinchart@ideasonboard.com" 
        <laurent.pinchart@ideasonboard.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Anuj Gupta <anuj01.gupta@samsung.com>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <347f9810-a9b7-8ef0-0442-6d22261d3ff5@suse.com>
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20230802052245epcms5p1a526743669b21f2425edcd735bbf0292@epcms5p1>
Date:   Wed, 02 Aug 2023 10:52:45 +0530
X-CMS-MailID: 20230802052245epcms5p1a526743669b21f2425edcd735bbf0292
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrEKsWRmVeSWpSXmKPExsWy7bCmuq4F06kUg+sLTC2u3PSxaF68ns2i
        c+ISdovLu+awWfRs2MpqsWhZK7PFsk1/mCy6Hq9ks5jw+wKbA6fH7I6ZrB6bVnWyeeyfu4bd
        Y/bdH4wefVtWMXqs33KVxePzJrkA9igum5TUnMyy1CJ9uwSujHdLHzEWnEquWPz9N2MD46qE
        LkZODgkBE4mus1/Zuhi5OIQEdjNKtO1YzNLFyMHBKyAo8XeHMEiNsIC/xKNtf9lBbCEBeYnV
        jzYxQsQ1Jc5N+gYWZxNQlzj15yOYLSJQLjGh6w8LiM0s8IpJ4t4MYYhdvBIz2p+yQNjSEtuX
        bwWbwylgI3Hl83+ouKjEzdVv2WHs98fmM0LYIhKt984yQ9iCEg9+7oaKy0h0TNoB1VstMaH5
        OhPILxICLYwSdy5MhCoyl9j1czWYzSvgK/F00wpWEJtFQFXixXeQOAdQjYvEg4vKEDdrSyxb
        +JoZJMwM9OP6XfoQU2Qlpp5axwRRwifR+/sJE8xbO+bB2MoS729+gDpfUuLgpR6okz0kOu/e
        YoUE83FGiV1brzNOYFSYhQjpWUg2z0LYvICReRWjZGpBcW56arFpgVFearlecWJucWleul5y
        fu4mRnAy0vLawfjwwQe9Q4xMHIyHGCU4mJVEeKV/H08R4k1JrKxKLcqPLyrNSS0+xCjNwaIk
        zvu6dW6KkEB6YklqdmpqQWoRTJaJg1OqgUlA+4jZk9f6+tN3CIcFsEasKKxbw2NlWmrd0JUe
        z+w/Jdfboee9/IKyOZfPmjY6iPcGz52r/Hrp3qeFn1gCDm7SbRf8ab+m/HXVnejKtJ5f29/o
        Cvg0tNefTNtw98S3X0xXFwS5fNPS12LaaLjDWMNgiswS33Lud48WzvU1f7Bjfuus6FnrGl9M
        43lXc1D7fOTrgzWib42avPXSdijfvvjjtXj53BRfW2n5uh9Gz498sk8R+fpCU2BNW+lXybt9
        HBM+ChRMZtyx94bSdo0c9xTx560pmjP320elvPq6/lTjfzHNb7e1TqSu/mq3eapjV0/2m5xa
        K+XQUKdszpQrqRP/+nTvsa5w/DsrR/D0BCWW4oxEQy3mouJEAIMrGsi1AwAA
X-CMS-RootMailID: 20230720113203epcas5p1eb52bec9c076d1a2f3dac5e317d0361b
References: <347f9810-a9b7-8ef0-0442-6d22261d3ff5@suse.com>
        <20230728045935epcms5p8f40b56f2c9100c7ea280c6f26b40d4fb@epcms5p8>
        <CGME20230720113203epcas5p1eb52bec9c076d1a2f3dac5e317d0361b@epcms5p1>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Oliver,


Thanks for analysis. I got your point about changes required in UVC driver =
to handle this race condition.=20
Alan and Greg also pointed it out, so i tried to handle this race condition=
 in UVC driver.
I am testing my new changes done in only UVC driver to resolve this issue.
After checking new patch for this race condition, I will share it.


>>On 28.07.23 06:59, AMAN DEEP wrote:
>
>Hi,
>
>> =5B1-221.1822=5D=C2=A0=5B=C2=A0=20=C2=A0=20msg:=C2=A04788=5D=C2=A0PC=C2=
=A0is=C2=A0at=C2=A0usb_ifnum_to_if+0x30/0x74=C2=A0=5Busbcore=5D=0D=0A>=0D=
=0A>This=20has=20to=20fail=20if=20the=20device=20is=20gone,=20but=20the=20q=
uestion=20is=20why=20the=20driver=0D=0A>is=20doing=20this.=20Hence=20we=20n=
eed=20to=20look=20at=20the=20backtrace.=0D=0A>=0D=0A>>=20=5B1-221.1822=5D=
=C2=A0=5B=C2=A0=20=C2=A0=20msg:=C2=A04788=5D=C2=A0LR=C2=A0is=C2=A0at=C2=A00=
x5=0D=0A>>=20=5B1-221.1822=5D=C2=A0=5B=C2=A0=20=C2=A0=20msg:=C2=A04788=5D=
=C2=A0pc=C2=A0:=C2=A0=5B<bede1300>=5D=C2=A0=20=C2=A0=20lr=C2=A0:=C2=A0=5B<0=
0000005>=5D=C2=A0=20=C2=A0=20psr:=C2=A020000113=0D=0A>>=20=5B1-221.1822=5D=
=C2=A0=5B=C2=A0=20=C2=A0=20msg:=C2=A04788=5D=C2=A0sp=C2=A0:=C2=A0ca443c18=
=C2=A0=20ip=C2=A0:=C2=A0ca443c28=C2=A0=20fp=C2=A0:=C2=A0ca443c24=0D=0A>>=20=
=5B1-221.1822=5D=C2=A0=5B=C2=A0=20=C2=A0=20msg:=C2=A04788=5D=C2=A0r10:=C2=
=A0e668b6c8=C2=A0=20r9=C2=A0:=C2=A000000000=C2=A0=20r8=C2=A0:=C2=A0e668b7e0=
=0D=0A>>=20=5B1-221.1822=5D=C2=A0=5B=C2=A0=20=C2=A0=20msg:=C2=A04788=5D=C2=
=A0r7=C2=A0:=C2=A0e7b78880=C2=A0=20r6=C2=A0:=C2=A0bf1d9db0=C2=A0=20r5=C2=A0=
:=C2=A0e668b6c8=C2=A0=20r4=C2=A0:=C2=A0e690c000=0D=0A>>=20=5B1-221.1822=5D=
=C2=A0=5B=C2=A0=20=C2=A0=20msg:=C2=A04788=5D=C2=A0r3=C2=A0:=C2=A000002000=
=C2=A0=20r2=C2=A0:=C2=A0e696ac40=C2=A0=20r1=C2=A0:=C2=A000000001=C2=A0=20r0=
=C2=A0:=C2=A000000000=0D=0A>>=20=5B1-221.1822=5D=C2=A0=5B=C2=A0=20=C2=A0=20=
msg:=C2=A04788=5D=C2=A0Flags:=C2=A0nzCv=C2=A0=20IRQs=C2=A0on=C2=A0=20FIQs=
=C2=A0on=C2=A0=20Mode=C2=A0SVC_32=C2=A0=20ISA=C2=A0ARM=C2=A0=20Segment=C2=
=A0user=0D=0A>>=20=5B1-221.1822=5D=C2=A0=5B=C2=A0=20=C2=A0=20msg:=C2=A04788=
=5D=C2=A0Control:=C2=A030c5383d=C2=A0=20Table:=C2=A0261f8a80=C2=A0=20DAC:=
=C2=A0e45d65d5=0D=0A>>=20=5B1-221.1822=5D=C2=A0=5B=C2=A0=20=C2=A0=20msg:=C2=
=A04788=5D=C2=A0Process=C2=A0msg=C2=A0(pid:=C2=A04788,=C2=A0stack=C2=A0limi=
t=C2=A0=3D=C2=A00xa0153238)=0D=0A>>=20=5B1-221.1822=5D=C2=A0=5B=C2=A0=20=C2=
=A0=20msg:=C2=A04788=5D=C2=A0Stack:=C2=A0(0xca443c18=C2=A0to=C2=A00xca44400=
0)=0D=0A>>=20=5B1-221.1822=5D=C2=A0=5B=C2=A0=20=C2=A0=20msg:=C2=A04788=5D=
=C2=A03c00:=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=
=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=
=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=
=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0ca443c64=C2=A0ca443c28=0D=0A>>=20=5B1-2=
21.1822=5D=C2=A0=5B=C2=A0=20=C2=A0=20msg:=C2=A04788=5D=C2=A03c20:=C2=A0bede=
e6e4=C2=A0bede12dc=C2=A000000000=C2=A0bee0ae78=C2=A0ca443c54=C2=A0ca443c40=
=C2=A0c083c894=C2=A0e7b78880=0D=0A>>=20=5B1-221.1822=5D=C2=A0=5B=C2=A0=20=
=C2=A0=20msg:=C2=A04788=5D=C2=A03c40:=C2=A0e6b88340=C2=A000000000=C2=A0bee0=
ae78=C2=A000000001=C2=A0e690c000=C2=A0e668b6c8=C2=A0ca443cb4=C2=A0ca443c68=
=0D=0A>>=20=5B1-221.1822=5D=C2=A0=5B=C2=A0=20=C2=A0=20msg:=C2=A04788=5D=C2=
=A03c60:=C2=A0bedf22ac=C2=A0bedee64c=C2=A0e5cf1508=C2=A0e5cf1508=C2=A0e5cf0=
000=C2=A0e5cf0330=C2=A000000001=C2=A0e5cf0330=0D=0A>>=20=5B1-221.1822=5D=C2=
=A0=5B=C2=A0=20=C2=A0=20msg:=C2=A04788=5D=C2=A03c80:=C2=A0ca443ca4=C2=A0ca4=
43c90=C2=A0c083c894=C2=A0e5cf0000=C2=A0e5cf0330=C2=A000000001=C2=A0e5cf0330=
=C2=A000000000=0D=0A>>=20=5B1-221.1822=5D=C2=A0=5B=C2=A0=20=C2=A0=20msg:=C2=
=A04788=5D=C2=A03ca0:=C2=A000000001=C2=A0c08d1b3c=C2=A0ca443ccc=C2=A0ca443c=
b8=C2=A0bfb3f958=C2=A0bedf1ff4=C2=A0e5cf0330=C2=A0e5cf0330=0D=0A>>=20=5B1-2=
21.1822=5D=C2=A0=5B=C2=A0=20=C2=A0=20msg:=C2=A04788=5D=C2=A03cc0:=C2=A0ca44=
3ce4=C2=A0ca443cd0=C2=A0bfb3a024=C2=A0bfb3f8a8=C2=A0e5cf0330=C2=A0e5cf0330=
=C2=A0ca443d14=C2=A0ca443ce8=0D=0A>>=20=5B1-221.1823=5D=C2=A0=5B=C2=A0=20=
=C2=A0=20msg:=C2=A04788=5D=C2=A03ce0:=C2=A0be3661e0=C2=A0bfb3a004=C2=A00000=
0001=C2=A0e5cf0330=C2=A0e5cf0330=C2=A000000001=C2=A0c05d6260=C2=A000000000=
=0D=0A>>=20=5B1-221.1823=5D=C2=A0=5B=C2=A0=20=C2=A0=20msg:=C2=A04788=5D=C2=
=A03d00:=C2=A000000001=C2=A0c08d1b3c=C2=A0ca443d2c=C2=A0ca443d18=C2=A0be367=
994=C2=A0be3661b4=C2=A0e5cf0484=C2=A0e5cf0330=0D=0A>>=20=5B1-221.1823=5D=C2=
=A0=5B=C2=A0=20=C2=A0=20msg:=C2=A04788=5D=C2=A03d20:=C2=A0ca443d3c=C2=A0ca4=
43d30=C2=A0be37e3e4=C2=A0be367978=C2=A0ca443d5c=C2=A0ca443d40=C2=A0bfb3a518=
=C2=A0be37e3cc=0D=0A>>=20=5B1-221.1823=5D=C2=A0=5B=C2=A0=20=C2=A0=20msg:=C2=
=A04788=5D=C2=A03d40:=C2=A0e5cf030c=C2=A0e5cf0000=C2=A000000001=C2=A0c05d62=
60=C2=A0ca443d7c=C2=A0ca443d60=C2=A0bfb3b628=C2=A0bfb3a4f0=0D=0A>>=20=5B1-2=
21.1823=5D=C2=A0=5B=C2=A0=20=C2=A0=20msg:=C2=A04788=5D=C2=A03d60:=C2=A0bfb3=
b5e8=C2=A040045613=C2=A000000000=C2=A0c05d6260=C2=A0ca443d94=C2=A0ca443d80=
=C2=A0c05d6288=C2=A0bfb3b5f4=0D=0A>>=20=5B1-221.1823=5D=C2=A0=5B=C2=A0=20=
=C2=A0=20msg:=C2=A04788=5D=C2=A03d80:=C2=A0e5cf0010=C2=A040045613=C2=A0ca44=
3dfc=C2=A0ca443d98=C2=A0c05d9b84=C2=A0c05d626c=C2=A000000068=C2=A0ca443deb=
=0D=0A>>=20=5B1-221.1823=5D=C2=A0=5B=C2=A0=20=C2=A0=20msg:=C2=A04788=5D=C2=
=A03da0:=C2=A0c08d1b3c=C2=A000000001=C2=A0ca443e24=C2=A0bfb44680=C2=A000000=
000=C2=A0e2fa3780=C2=A0c01a926c=C2=A0031e1090=0D=0A>>=20=5B1-221.1823=5D=C2=
=A0=5B=C2=A0=20=C2=A0=20msg:=C2=A04788=5D=C2=A03dc0:=C2=A0ca443df4=C2=A0fff=
fffff=C2=A0c01e0048=C2=A00000072c=C2=A0000012b4=C2=A000000000=C2=A040045613=
=C2=A000000000=0D=0A>>=20=5B1-221.1823=5D=C2=A0=5B=C2=A0=20=C2=A0=20msg:=C2=
=A04788=5D=C2=A03de0:=C2=A000000000=C2=A000000001=C2=A000000004=C2=A0ca443e=
24=C2=A0ca443ed4=C2=A0ca443e00=C2=A0c05db320=C2=A0c05d9a04=0D=0A>>=20=5B1-2=
21.1823=5D=C2=A0=5B=C2=A0=20=C2=A0=20msg:=C2=A04788=5D=C2=A03e00:=C2=A00000=
0000=C2=A000000000=C2=A0c05d99f8=C2=A0e77a6700=C2=A0ab8fd26c=C2=A000000000=
=C2=A000000000=C2=A000000000=0D=0A>>=20=5B1-221.1823=5D=C2=A0=5B=C2=A0=20=
=C2=A0=20msg:=C2=A04788=5D=C2=A03e20:=C2=A0ca443f60=C2=A000000001=C2=A0ca44=
3ee0=C2=A000000000=C2=A0ca443e9c=C2=A0ca443e40=C2=A0c02390a8=C2=A0be211e84=
=0D=0A>>=20=5B1-221.1823=5D=C2=A0=5B=C2=A0=20=C2=A0=20msg:=C2=A04788=5D=C2=
=A03e40:=C2=A000000000=C2=A000000001=C2=A0e2861600=C2=A000000000=C2=A000000=
000=C2=A000000000=C2=A000000000=C2=A000000000=0D=0A>>=20=5B1-221.1823=5D=C2=
=A0=5B=C2=A0=20=C2=A0=20msg:=C2=A04788=5D=C2=A03e60:=C2=A000000000=C2=A0000=
00000=C2=A000000000=C2=A0c03681bc=C2=A000000008=C2=A000000000=C2=A0ca443ee0=
=C2=A0c0bbd748=0D=0A>>=20=5B1-221.1823=5D=C2=A0=5B=C2=A0=20=C2=A0=20msg:=C2=
=A04788=5D=C2=A03e80:=C2=A000000000=C2=A0c0be9a14=C2=A0ca443ef4=C2=A0000000=
02=C2=A0ca443ed4=C2=A0ca443ea0=C2=A0c03681bc=C2=A0c036790c=0D=0A>>=20=5B1-2=
21.1823=5D=C2=A0=5B=C2=A0=20=C2=A0=20msg:=C2=A04788=5D=C2=A03ea0:=C2=A0ca44=
3ef4=C2=A0c0bbd748=C2=A0e2861600=C2=A0c05db7dc=C2=A0e6695448=C2=A040045613=
=C2=A0ab8fd26c=C2=A0e77a6700=0D=0A>>=20=5B1-221.1823=5D=C2=A0=5B=C2=A0=20=
=C2=A0=20msg:=C2=A04788=5D=C2=A03ec0:=C2=A000000021=C2=A000000036=C2=A0ca44=
3ee4=C2=A0ca443ed8=C2=A0c05db7fc=C2=A0c05db0f8=C2=A0ca443efc=C2=A0ca443ee8=
=0D=0A>>=20=5B1-221.1823=5D=C2=A0=5B=C2=A0=20=C2=A0=20msg:=C2=A04788=5D=C2=
=A03ee0:=C2=A0c05d4728=C2=A0c05db7e8=C2=A0ab8fd26c=C2=A0e6695448=C2=A0ca443=
f6c=C2=A0ca443f00=C2=A0c02506a0=C2=A0c05d46e8=0D=0A>>=20=5B1-221.1823=5D=C2=
=A0=5B=C2=A0=20=C2=A0=20msg:=C2=A04788=5D=C2=A03f00:=C2=A0ca443f04=C2=A0c08=
a7a00=C2=A000000000=C2=A000000000=C2=A000000000=C2=A000000000=C2=A000000000=
=C2=A000000000=0D=0A>>=20=5B1-221.1823=5D=C2=A0=5B=C2=A0=20=C2=A0=20msg:=C2=
=A04788=5D=C2=A03f20:=C2=A000000000=C2=A000000000=C2=A000000000=C2=A0000000=
00=C2=A0ab8fd26c=C2=A0c0abb6ec=C2=A0ab8fd26c=C2=A0e77a6700=0D=0A>>=20=5B1-2=
21.1823=5D=C2=A0=5B=C2=A0=20=C2=A0=20msg:=C2=A04788=5D=C2=A03f40:=C2=A0ca44=
3f6c=C2=A0e77a6701=C2=A000000000=C2=A040045613=C2=A0ab8fd26c=C2=A0e77a6700=
=C2=A000000021=C2=A000000036=0D=0A>>=20=5B1-221.1824=5D=C2=A0=5B=C2=A0=20=
=C2=A0=20msg:=C2=A04788=5D=C2=A03f60:=C2=A0ca443f94=C2=A0ca443f70=C2=A0c025=
0b3c=C2=A0c02502fc=C2=A000000000=C2=A0000006f7=C2=A000000000=C2=A000000036=
=0D=0A>>=20=5B1-221.1824=5D=C2=A0=5B=C2=A0=20=C2=A0=20msg:=C2=A04788=5D=C2=
=A03f80:=C2=A0c000924c=C2=A0ca442000=C2=A0ca443fa4=C2=A0ca443f98=C2=A0c0250=
b78=C2=A0c0250adc=C2=A000000000=C2=A0ca443fa8=0D=0A>>=20=5B1-221.1824=5D=C2=
=A0=5B=C2=A0=20=C2=A0=20msg:=C2=A04788=5D=C2=A03fa0:=C2=A0c0009230=C2=A0c02=
50b6c=C2=A000000000=C2=A0000006f7=C2=A000000021=C2=A040045613=C2=A0ab8fd26c=
=C2=A000000021=0D=0A>>=20=5B1-221.1824=5D=C2=A0=5B=C2=A0=20=C2=A0=20msg:=C2=
=A04788=5D=C2=A03fc0:=C2=A000000000=C2=A0000006f7=C2=A000000000=C2=A0000000=
36=C2=A0abb79e30=C2=A000000000=C2=A000000001=C2=A0abb79e28=0D=0A>>=20=5B1-2=
21.1824=5D=C2=A0=5B=C2=A0=20=C2=A0=20msg:=C2=A04788=5D=C2=A03fe0:=C2=A0aeca=
607c=C2=A0ab8fd24c=C2=A0aec8e749=C2=A0b5f1ed1c=C2=A020000010=C2=A000000021=
=C2=A000000000=C2=A000000000=0D=0A>>=20=5B1-221.1824=5D=C2=A0=5B=C2=A0=20=
=C2=A0=20msg:=C2=A04788=5D=C2=A0Backtrace:=0D=0A>>=20=5B1-221.1824=5D=C2=A0=
=5B=C2=A0=20=C2=A0=20msg:=C2=A04788=5D=C2=A0=5B<bede12d0>=5D=C2=A0(usb_ifnu=
m_to_if=C2=A0=5Busbcore=5D)=C2=A0from=C2=A0=5B<bedee6e4>=5D=C2=A0(usb_hcd_a=
lloc_bandwidth+0xa4/0x564=C2=A0=5Busbcore=5D)=0D=0A>>=20=5B1-221.1824=5D=C2=
=A0=5B=C2=A0=20=C2=A0=20msg:=C2=A04788=5D=C2=A0=5B<bedee640>=5D=C2=A0(usb_h=
cd_alloc_bandwidth=C2=A0=5Busbcore=5D)=C2=A0from=C2=A0=5B<bedf22ac>=5D=C2=
=A0(usb_set_interface+0x2c4/0x61c=C2=A0=5Busbcore=5D)=0D=0A>=0D=0A>This=20i=
s=20the=20proximate=20cause.=0D=0A>=0D=0A>>=20=5B1-221.1824=5D=C2=A0=5B=C2=
=A0=20=C2=A0=20msg:=C2=A04788=5D=C2=A0=20r10:e668b6c8=C2=A0r9:e690c000=C2=
=A0r8:00000001=C2=A0r7:bee0ae78=C2=A0r6:00000000=C2=A0r5:e6b88340=0D=0A>>=
=20=5B1-221.1824=5D=C2=A0=5B=C2=A0=20=C2=A0=20msg:=C2=A04788=5D=C2=A0=20r4:=
e7b78880=0D=0A>>=20=5B1-221.1825=5D=C2=A0=5B=C2=A0=20=C2=A0=20msg:=C2=A0478=
8=5D=C2=A0=5B<bedf1fe8>=5D=C2=A0(usb_set_interface=C2=A0=5Busbcore=5D)=C2=
=A0from=C2=A0=5B<bfb3f958>=5D=C2=A0(uvc_video_stop_streaming+0xbc/0xc4=C2=
=A0=5Buvcvideo=5D)=0D=0A>>=20=5B1-221.1825=5D=C2=A0=5B=C2=A0=20=C2=A0=20msg=
:=C2=A04788=5D=C2=A0=20r10:c08d1b3c=C2=A0r9:00000001=C2=A0r8:00000000=C2=A0=
r7:e5cf0330=C2=A0r6:00000001=C2=A0r5:e5cf0330=0D=0A>>=20=5B1-221.1825=5D=C2=
=A0=5B=C2=A0=20=C2=A0=20msg:=C2=A04788=5D=C2=A0=20r4:e5cf0000=0D=0A>>=20=5B=
1-221.1825=5D=C2=A0=5B=C2=A0=20=C2=A0=20msg:=C2=A04788=5D=C2=A0=5B<bfb3f89c=
>=5D=C2=A0(uvc_video_stop_streaming=C2=A0=5Buvcvideo=5D)=C2=A0from=C2=A0=5B=
<bfb3a024>=5D=C2=A0(uvc_stop_streaming+0x2c/0x50=C2=A0=5Buvcvideo=5D)=0D=0A=
>=0D=0A>triggered=20from=20here=0D=0A>>=20=5B1-221.1826=5D=C2=A0=5B=C2=A0=
=20=C2=A0=20msg:=C2=A04788=5D=C2=A0=5B<bfb3b5e8>=5D=C2=A0(uvc_ioctl_streamo=
ff=C2=A0=5Buvcvideo=5D)=C2=A0from=C2=A0=5B<c05d6288>=5D=C2=A0(v4l_streamoff=
+0x28/0x2c)=0D=0A>>=20=5B1-221.1826=5D=C2=A0=5B=C2=A0=20=C2=A0=20msg:=C2=A0=
4788=5D=C2=A0=20r7:c05d6260=C2=A0r6:00000000=C2=A0r5:40045613=C2=A0r4:bfb3b=
5e8=0D=0A>=0D=0A>User=20space=20is=20trying=20to=20execute=20an=20ioctl()=
=20on=20a=20device=20whose=0D=0A>disconnect()=20method=20has=20run.=20A=20d=
river=20has=20to=20either=20prevent=20or=20fail=20such=20calls.=0D=0A>=C2=
=A0=20=0D=0A>>=20I=20thought=20this=20issue=20can=20occur=20with=20other=20=
devices=20in=20simillar=20race=20conditions=20so=20i=20thought=20it=20will=
=20be=20fixed=20for=20all=20drivers.=0D=0A>=0D=0A>No,=20this=20will=20not=
=20work.=20You=20are=20failing=20to=20take=20into=20consideration=0D=0A>tha=
t=20the=20life=20time=20of=20the=20device=20is=20different=20from=20its=20a=
ssociation=0D=0A>with=20a=20particular=20device=20driver.=0D=0A>=0D=0A>>=20=
Please=20suggest=20if=20we=20need=20to=20add=20locking=20mechanism=20to=20c=
over=20such=20cases.=0D=0A>>=20i=20will=20try=20accordingly.=0D=0A>=0D=0A>F=
or=20the=20reason=20I=20stated=20above=20this=20is=20not=20fixable=20with=
=20locking=0D=0A>at=20this=20level.=20The=20test=20for=20the=20device=20sta=
te=20is=20the=20wrong=20test.=0D=0A>Consequently=20no=20amount=20of=20locki=
ng=20can=20correct=20that.=20The=20conditions=0D=0A>only=20happen=20to=20co=
nincide=20because=20your=20testing=20replicates=20the=20most=0D=0A>common=
=20code=20path.=20It=20is=20not=20the=20only=20one.=0D=0A>=C2=A0=20=0D=0A>Y=
ou=20need=20to=20fix=20uvc_disconnect()=0D=0A>=0D=0A>=20=C2=A0=20=C2=A0=20=
=C2=A0=20=C2=A0HTH=0D=0A>=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=
=C2=A0=20=C2=A0=20=C2=A0Oliver=0D=0A>=0D=0A=0D=0AThanks,=0D=0AAman=20Deep=
=0D=0A

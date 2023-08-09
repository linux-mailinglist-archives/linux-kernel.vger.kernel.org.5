Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44D88775DA0
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 13:39:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234170AbjHILjd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 07:39:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234162AbjHILjc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 07:39:32 -0400
Received: from mail-vs1-xe2f.google.com (mail-vs1-xe2f.google.com [IPv6:2607:f8b0:4864:20::e2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FE65173A
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 04:39:31 -0700 (PDT)
Received: by mail-vs1-xe2f.google.com with SMTP id ada2fe7eead31-44768609e0bso2768872137.0
        for <linux-kernel@vger.kernel.org>; Wed, 09 Aug 2023 04:39:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1691581170; x=1692185970;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BRQ6NjZyQjeZDGl39p2pKwDouZef7V1LtBmtjwtmY04=;
        b=EcR5tUAsczpMHu0IDhF4TQYpPaLV6YPAhqpwuezKSPQhjv364J3Z5GDbkw2CrZ7iEh
         j9EsU5D8kGW9eElVqhhXVkPPoiLzs5b2Tb/5q9HqzVlUtamamGiGSe/DWfw2OQen99gx
         XmY6oOe7+e610HmaB28V/TuJ/stQXEs6c8HJU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691581170; x=1692185970;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BRQ6NjZyQjeZDGl39p2pKwDouZef7V1LtBmtjwtmY04=;
        b=F3Uqe91sC/xtfDsFb3iiAduG0cM7yiPQyBgXW826cIblsOG+xLOHKjjBo2vO0D0xLR
         7DRJNCDT1dF08ir7bxGzYeNKZP+hTaMdi/FkJwzOMrAuFBw9V65wA4ptYOVwntre7emm
         ZLXz5QvNdN7QN0Z8EqDqPHOB0Aoeq5V4s+DMljyCB276anGmavZxdPkQQq+y+4e9r29y
         1WwC0iUd2lvd6YdNGLbx6JX1+mb3vGKZBQX1vyQsEeBgo2Dp4A8OIL49ulCdhXC382pw
         sWhRm+TilKK4qMj/2jNX3NR4k5i1Kj32NNXKSwzafVMb/gUF+/+U2rXzs+Ii/bf57R+N
         4+SQ==
X-Gm-Message-State: AOJu0YxN2S2DX5TUVvQDt32Hcn+5PIgJIJqZHzH++2RmrysrkxYLli2a
        Q6BkQNukdYgHPDNZatu1DiTZ5trtoOh1Q74grRg=
X-Google-Smtp-Source: AGHT+IGgPrqzq50yxkAM0E9yLIvT+DmfNG4MdeKHrqtTOxT2msuE/UGH7Z13u9A+cCivMKWta43XTg==
X-Received: by 2002:a67:f9d2:0:b0:444:c236:547 with SMTP id c18-20020a67f9d2000000b00444c2360547mr2644910vsq.12.1691581170410;
        Wed, 09 Aug 2023 04:39:30 -0700 (PDT)
Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com. [209.85.221.181])
        by smtp.gmail.com with ESMTPSA id u4-20020ab05544000000b0079b10bf6bcdsm1981660uaa.25.2023.08.09.04.39.29
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Aug 2023 04:39:29 -0700 (PDT)
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-4872b26b352so1424240e0c.0
        for <linux-kernel@vger.kernel.org>; Wed, 09 Aug 2023 04:39:29 -0700 (PDT)
X-Received: by 2002:a1f:3fd7:0:b0:487:173d:63db with SMTP id
 m206-20020a1f3fd7000000b00487173d63dbmr3247087vka.4.1691581169152; Wed, 09
 Aug 2023 04:39:29 -0700 (PDT)
MIME-Version: 1.0
References: <20230728045935epcms5p8f40b56f2c9100c7ea280c6f26b40d4fb@epcms5p8>
 <CGME20230720113203epcas5p1eb52bec9c076d1a2f3dac5e317d0361b@epcms5p1>
 <347f9810-a9b7-8ef0-0442-6d22261d3ff5@suse.com> <20230802052245epcms5p1a526743669b21f2425edcd735bbf0292@epcms5p1>
In-Reply-To: <20230802052245epcms5p1a526743669b21f2425edcd735bbf0292@epcms5p1>
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Wed, 9 Aug 2023 13:39:18 +0200
X-Gmail-Original-Message-ID: <CANiDSCuzP7aBd5F71-52hb-SmNDc8S2f35N_kXRnw5RYS5Ecyg@mail.gmail.com>
Message-ID: <CANiDSCuzP7aBd5F71-52hb-SmNDc8S2f35N_kXRnw5RYS5Ecyg@mail.gmail.com>
Subject: Re: Re: [PATCH] USB: Fix race condition during UVC webcam disconnect
To:     aman.deep@samsung.com
Cc:     Oliver Neukum <oneukum@suse.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "stern@rowland.harvard.edu" <stern@rowland.harvard.edu>,
        "laurent.pinchart@ideasonboard.com" 
        <laurent.pinchart@ideasonboard.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Anuj Gupta <anuj01.gupta@samsung.com>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Aman

Could you check if this patchset fixes the problem for you
https://patchwork.linuxtv.org/project/linux-media/list/?series=10038 ?

Regards!


On Wed, 2 Aug 2023 at 09:56, AMAN DEEP <aman.deep@samsung.com> wrote:
>
>
> Hi Oliver,
>
>
> Thanks for analysis. I got your point about changes required in UVC driver to handle this race condition.
> Alan and Greg also pointed it out, so i tried to handle this race condition in UVC driver.
> I am testing my new changes done in only UVC driver to resolve this issue.
> After checking new patch for this race condition, I will share it.
>
>
> >>On 28.07.23 06:59, AMAN DEEP wrote:
> >
> >Hi,
> >
> >> [1-221.1822] [    msg: 4788] PC is at usb_ifnum_to_if+0x30/0x74 [usbcore]
> >
> >This has to fail if the device is gone, but the question is why the driver
> >is doing this. Hence we need to look at the backtrace.
> >
> >> [1-221.1822] [    msg: 4788] LR is at 0x5
> >> [1-221.1822] [    msg: 4788] pc : [<bede1300>]    lr : [<00000005>]    psr: 20000113
> >> [1-221.1822] [    msg: 4788] sp : ca443c18  ip : ca443c28  fp : ca443c24
> >> [1-221.1822] [    msg: 4788] r10: e668b6c8  r9 : 00000000  r8 : e668b7e0
> >> [1-221.1822] [    msg: 4788] r7 : e7b78880  r6 : bf1d9db0  r5 : e668b6c8  r4 : e690c000
> >> [1-221.1822] [    msg: 4788] r3 : 00002000  r2 : e696ac40  r1 : 00000001  r0 : 00000000
> >> [1-221.1822] [    msg: 4788] Flags: nzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment user
> >> [1-221.1822] [    msg: 4788] Control: 30c5383d  Table: 261f8a80  DAC: e45d65d5
> >> [1-221.1822] [    msg: 4788] Process msg (pid: 4788, stack limit = 0xa0153238)
> >> [1-221.1822] [    msg: 4788] Stack: (0xca443c18 to 0xca444000)
> >> [1-221.1822] [    msg: 4788] 3c00:                                                       ca443c64 ca443c28
> >> [1-221.1822] [    msg: 4788] 3c20: bedee6e4 bede12dc 00000000 bee0ae78 ca443c54 ca443c40 c083c894 e7b78880
> >> [1-221.1822] [    msg: 4788] 3c40: e6b88340 00000000 bee0ae78 00000001 e690c000 e668b6c8 ca443cb4 ca443c68
> >> [1-221.1822] [    msg: 4788] 3c60: bedf22ac bedee64c e5cf1508 e5cf1508 e5cf0000 e5cf0330 00000001 e5cf0330
> >> [1-221.1822] [    msg: 4788] 3c80: ca443ca4 ca443c90 c083c894 e5cf0000 e5cf0330 00000001 e5cf0330 00000000
> >> [1-221.1822] [    msg: 4788] 3ca0: 00000001 c08d1b3c ca443ccc ca443cb8 bfb3f958 bedf1ff4 e5cf0330 e5cf0330
> >> [1-221.1822] [    msg: 4788] 3cc0: ca443ce4 ca443cd0 bfb3a024 bfb3f8a8 e5cf0330 e5cf0330 ca443d14 ca443ce8
> >> [1-221.1823] [    msg: 4788] 3ce0: be3661e0 bfb3a004 00000001 e5cf0330 e5cf0330 00000001 c05d6260 00000000
> >> [1-221.1823] [    msg: 4788] 3d00: 00000001 c08d1b3c ca443d2c ca443d18 be367994 be3661b4 e5cf0484 e5cf0330
> >> [1-221.1823] [    msg: 4788] 3d20: ca443d3c ca443d30 be37e3e4 be367978 ca443d5c ca443d40 bfb3a518 be37e3cc
> >> [1-221.1823] [    msg: 4788] 3d40: e5cf030c e5cf0000 00000001 c05d6260 ca443d7c ca443d60 bfb3b628 bfb3a4f0
> >> [1-221.1823] [    msg: 4788] 3d60: bfb3b5e8 40045613 00000000 c05d6260 ca443d94 ca443d80 c05d6288 bfb3b5f4
> >> [1-221.1823] [    msg: 4788] 3d80: e5cf0010 40045613 ca443dfc ca443d98 c05d9b84 c05d626c 00000068 ca443deb
> >> [1-221.1823] [    msg: 4788] 3da0: c08d1b3c 00000001 ca443e24 bfb44680 00000000 e2fa3780 c01a926c 031e1090
> >> [1-221.1823] [    msg: 4788] 3dc0: ca443df4 ffffffff c01e0048 0000072c 000012b4 00000000 40045613 00000000
> >> [1-221.1823] [    msg: 4788] 3de0: 00000000 00000001 00000004 ca443e24 ca443ed4 ca443e00 c05db320 c05d9a04
> >> [1-221.1823] [    msg: 4788] 3e00: 00000000 00000000 c05d99f8 e77a6700 ab8fd26c 00000000 00000000 00000000
> >> [1-221.1823] [    msg: 4788] 3e20: ca443f60 00000001 ca443ee0 00000000 ca443e9c ca443e40 c02390a8 be211e84
> >> [1-221.1823] [    msg: 4788] 3e40: 00000000 00000001 e2861600 00000000 00000000 00000000 00000000 00000000
> >> [1-221.1823] [    msg: 4788] 3e60: 00000000 00000000 00000000 c03681bc 00000008 00000000 ca443ee0 c0bbd748
> >> [1-221.1823] [    msg: 4788] 3e80: 00000000 c0be9a14 ca443ef4 00000002 ca443ed4 ca443ea0 c03681bc c036790c
> >> [1-221.1823] [    msg: 4788] 3ea0: ca443ef4 c0bbd748 e2861600 c05db7dc e6695448 40045613 ab8fd26c e77a6700
> >> [1-221.1823] [    msg: 4788] 3ec0: 00000021 00000036 ca443ee4 ca443ed8 c05db7fc c05db0f8 ca443efc ca443ee8
> >> [1-221.1823] [    msg: 4788] 3ee0: c05d4728 c05db7e8 ab8fd26c e6695448 ca443f6c ca443f00 c02506a0 c05d46e8
> >> [1-221.1823] [    msg: 4788] 3f00: ca443f04 c08a7a00 00000000 00000000 00000000 00000000 00000000 00000000
> >> [1-221.1823] [    msg: 4788] 3f20: 00000000 00000000 00000000 00000000 ab8fd26c c0abb6ec ab8fd26c e77a6700
> >> [1-221.1823] [    msg: 4788] 3f40: ca443f6c e77a6701 00000000 40045613 ab8fd26c e77a6700 00000021 00000036
> >> [1-221.1824] [    msg: 4788] 3f60: ca443f94 ca443f70 c0250b3c c02502fc 00000000 000006f7 00000000 00000036
> >> [1-221.1824] [    msg: 4788] 3f80: c000924c ca442000 ca443fa4 ca443f98 c0250b78 c0250adc 00000000 ca443fa8
> >> [1-221.1824] [    msg: 4788] 3fa0: c0009230 c0250b6c 00000000 000006f7 00000021 40045613 ab8fd26c 00000021
> >> [1-221.1824] [    msg: 4788] 3fc0: 00000000 000006f7 00000000 00000036 abb79e30 00000000 00000001 abb79e28
> >> [1-221.1824] [    msg: 4788] 3fe0: aeca607c ab8fd24c aec8e749 b5f1ed1c 20000010 00000021 00000000 00000000
> >> [1-221.1824] [    msg: 4788] Backtrace:
> >> [1-221.1824] [    msg: 4788] [<bede12d0>] (usb_ifnum_to_if [usbcore]) from [<bedee6e4>] (usb_hcd_alloc_bandwidth+0xa4/0x564 [usbcore])
> >> [1-221.1824] [    msg: 4788] [<bedee640>] (usb_hcd_alloc_bandwidth [usbcore]) from [<bedf22ac>] (usb_set_interface+0x2c4/0x61c [usbcore])
> >
> >This is the proximate cause.
> >
> >> [1-221.1824] [    msg: 4788]  r10:e668b6c8 r9:e690c000 r8:00000001 r7:bee0ae78 r6:00000000 r5:e6b88340
> >> [1-221.1824] [    msg: 4788]  r4:e7b78880
> >> [1-221.1825] [    msg: 4788] [<bedf1fe8>] (usb_set_interface [usbcore]) from [<bfb3f958>] (uvc_video_stop_streaming+0xbc/0xc4 [uvcvideo])
> >> [1-221.1825] [    msg: 4788]  r10:c08d1b3c r9:00000001 r8:00000000 r7:e5cf0330 r6:00000001 r5:e5cf0330
> >> [1-221.1825] [    msg: 4788]  r4:e5cf0000
> >> [1-221.1825] [    msg: 4788] [<bfb3f89c>] (uvc_video_stop_streaming [uvcvideo]) from [<bfb3a024>] (uvc_stop_streaming+0x2c/0x50 [uvcvideo])
> >
> >triggered from here
> >> [1-221.1826] [    msg: 4788] [<bfb3b5e8>] (uvc_ioctl_streamoff [uvcvideo]) from [<c05d6288>] (v4l_streamoff+0x28/0x2c)
> >> [1-221.1826] [    msg: 4788]  r7:c05d6260 r6:00000000 r5:40045613 r4:bfb3b5e8
> >
> >User space is trying to execute an ioctl() on a device whose
> >disconnect() method has run. A driver has to either prevent or fail such calls.
> >
> >> I thought this issue can occur with other devices in simillar race conditions so i thought it will be fixed for all drivers.
> >
> >No, this will not work. You are failing to take into consideration
> >that the life time of the device is different from its association
> >with a particular device driver.
> >
> >> Please suggest if we need to add locking mechanism to cover such cases.
> >> i will try accordingly.
> >
> >For the reason I stated above this is not fixable with locking
> >at this level. The test for the device state is the wrong test.
> >Consequently no amount of locking can correct that. The conditions
> >only happen to conincide because your testing replicates the most
> >common code path. It is not the only one.
> >
> >You need to fix uvc_disconnect()
> >
> >        HTH
> >                Oliver
> >
>
> Thanks,
> Aman Deep
>


--
Ricardo Ribalda

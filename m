Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E54A77CEF6
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 17:20:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237901AbjHOPTc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 11:19:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237971AbjHOPTQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 11:19:16 -0400
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com [IPv6:2607:f8b0:4864:20::c2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BECB173C
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 08:18:55 -0700 (PDT)
Received: by mail-oo1-xc2e.google.com with SMTP id 006d021491bc7-56c7f47ec42so3958547eaf.2
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 08:18:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692112734; x=1692717534;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y3CRqLemgEUBP4zdbQ3kjUY5FyHbWQ2nJVCBDIJFBRI=;
        b=LjHHzTJOdbFKgZDi8pSe2tfhAyYlUJJF3WBqCeW5aY6Y/jWS+ZuhBYvP1x3wHUvsNX
         3Q1iHF0vcMhJfsdHbNMEGJFOCwr82EzNeh+cVONoqdHvVupXJUS3VQXz96+CULqjurpE
         Co7GcP8g3wzV+26Ny248zYjZohkEbFZVhz7Ii+qHFrT4yle8WUFXQjvYMw0nXHRJ1xvf
         h6A5J8vBBZciGfBuRHiycbDjPYM25Q9J+5SeXP4xW9wLlOLjy42s0MAtZhhi3a2nOHd6
         fwCsqcYcLHGlncW+SLwl01JWlbTQvZN+grGXuMctCs4aN+XOJdgwy8mpzdanQe7yKyoa
         BSKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692112734; x=1692717534;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y3CRqLemgEUBP4zdbQ3kjUY5FyHbWQ2nJVCBDIJFBRI=;
        b=WCNhv7umwJrIbuuo2mFJazWk8lqnMYqi08zN3rajRAjvWj5ZXoEdtoz2A/qkfq33Uf
         ZP7xG5N8o7fN3DGY5/XaERhEYiWKfpWd4BUn77jMReS2te40trKLKvS3SCSHilP743kU
         IPkptej6zxYq4FniSJx4K6B5bko9wcH6oBBtqdagHxjE++ShSRa+llPc9IMKp+hwRWU9
         Snc1j8ktSxzOfqAsEtNv6E1m5elzgZVNg4Qtk7KTj8ZuFWffjqy026loxG3lf84ra9BQ
         qHdQAxDw2COiv2sqziluIb9UNnAW6YGryB7T1vKMoScukB5250WwljlhGhP0o7jB30b7
         oLJg==
X-Gm-Message-State: AOJu0YxGkGSGx89b2U6jDoCjQd+akLHE2H9CcDqwjS1jLBnWLffEo+3y
        3xxEX82yMi556WbN695Xrz2eCf8zMwHlAzbNv/1MZRjw
X-Google-Smtp-Source: AGHT+IG3TaAG2ACrM9XWPxHA2ca2SZEDt+NEUm4/ZJ1aCvonoIA97JwhGCCYJJwO0OpmQCxuZ4wmIAJBkDXjj3d6YII=
X-Received: by 2002:a4a:d284:0:b0:563:625b:e02e with SMTP id
 h4-20020a4ad284000000b00563625be02emr10045848oos.9.1692112734212; Tue, 15 Aug
 2023 08:18:54 -0700 (PDT)
MIME-Version: 1.0
References: <461df15f.15e2d.189deaa6eed.Coremail.kvmluck@163.com>
 <38e69323-0185-32bb-2de1-8e5b36de2abc@tls.msk.ru> <3c1a93da.16493.189df040e16.Coremail.kvmluck@163.com>
 <20230810141335.GA2931656@fedora> <CAJSP0QX5Z=GFnjyGOgQ8hs6hkdUASznUPmuZJp11ViokSRZ0Tw@mail.gmail.com>
 <1c616fdb.17b27.189e26afed5.Coremail.kvmluck@163.com>
In-Reply-To: <1c616fdb.17b27.189e26afed5.Coremail.kvmluck@163.com>
From:   Stefan Hajnoczi <stefanha@gmail.com>
Date:   Tue, 15 Aug 2023 11:18:42 -0400
Message-ID: <CAJSP0QXjzxjXcsfLMsKQmOvuzRbqxpT70iGsSdDu+qANCd729w@mail.gmail.com>
Subject: Re: LTP test related to virtio releasing and reassigning resource
 leads to guest hung
To:     "longguang.yue" <kvmluck@163.com>
Cc:     Michael Tokarev <mjt@tls.msk.ru>,
        "mst@redhat.com" <mst@redhat.com>,
        qemu-devel <qemu-devel@nongnu.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Aug 2023 at 22:27, longguang.yue <kvmluck@163.com> wrote:
>
>
> =E4=B8=80=EF=BC=89
> Can you post the guest kernel messages (dmesg)? If the guest is hanging
> then it may be easiest to configure a serial console so the kernel
> messages are sent to the host where you can see them.
>
> Does the hang occur during the LTP code you linked or afterwards when
> the PCI device is bound to a virtio driver?
>
>
> >   I used conosle, the hang occurred afterwards.   dmesg shows that tpci=
 test is finished without error.
> LTP test case: https://github.com/linux-test-project/ltp/blob/522d7fba4af=
c84e07b252aa4cd91b241e81d6613/testcases/kernel/device-drivers/pci/tpci_kern=
el/ltp_tpci.c#L428
> kernel 5.10, qemu 6.2
>
> different guest-configuration tests show different results.  guest did no=
t crash if hung-task-panic=3D0, in my case  i enable hung-task-panic in ord=
er to trace.
>
> test case 1:
> xml machine pc,virtio disk, virtio net =E2=80=94=E2=80=94  guest's io hun=
g, network broke down, though console is avilable but io operation hung.
>
> #ps -aux| grep D
> root           7  0.0  0.0      0     0 ?        D    14:37   0:00 [kwork=
er/u16:0+flush-253:0]
> root         483  0.0  0.0      0     0 ?      D    14:37   0:00 [jbd2/vd=
a3-8]
>
> test case 2:
> xml machine q35,virtio/q35,scsi =E2=80=94=E2=80=94disk did not hung but n=
etwork broke down. ping errors though everything looks ok and no crash and =
no kernel error
>
>
>
> =E4=BA=8C=EF=BC=89
> I didn't see your original email so I missed the panic. I'd still like
> to see the earlier kernel messages before the panic in order to
> understand how the PCI device is bound.
>
> Is the vda device with hung I/O the same device that was accessed by
> the LTP test earlier? I guess the LTP test runs against the device and
> then the virtio driver binds to the device again afterwards?
>
> > the test is
> ```
> // iterate all devices
> =E2=80=A6=E2=80=A6
> for (i =3D 0; i < 7; ++i) {  // iterate current device's resources
>   if (r->flags & IORESOURCE_MEM &&
>   r->flags & IORESOURCE_PREFETCH) {
>   pci_release_resource(dev, i);
>   ret =3D pci_assign_resource(dev, i);
>   prk_info("assign resource to '%d', ret '%d'", i, ret);
>   rc |=3D (ret < 0 && ret !=3D -EBUSY) ? TFAIL : TPASS;
>   }
> }
> ```
> test does not do virtio device unbind and  bind.
> I only notice mem resource changed. see 'test-case 12'
>
> =E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=
=E2=80=94=E2=80=94=E2=80=94
> [   88.905705] ltp_tpci: test-case 12
> [   88.905706] ltp_tpci: assign resources
> [   88.905706] ltp_tpci: assign resource #0
> [   88.905707] ltp_tpci: name =3D 0000:00:07.0, flags =3D 262401, start 0=
xc080, end 0xc0ff
> [   88.905707] ltp_tpci: assign resource #1
> [   88.905708] ltp_tpci: name =3D 0000:00:07.0, flags =3D 262656, start 0=
xfebd4000, end 0xfebd4fff
> [   88.905709] ltp_tpci: assign resource #2
> [   88.905709] ltp_tpci: name =3D 0000:00:07.0, flags =3D 0, start 0x0, e=
nd 0x0
> [   88.905710] ltp_tpci: assign resource #3
> [   88.905710] ltp_tpci: name =3D 0000:00:07.0, flags =3D 0, start 0x0, e=
nd 0x0
> [   88.905711] ltp_tpci: assign resource #4
> [   88.905711] ltp_tpci: name =3D 0000:00:07.0, flags =3D 1319436, start =
0xfe00c000, end 0xfe00ffff
> [   88.905713] virtio-pci 0000:00:07.0: BAR 4: releasing [mem 0xfe00c000-=
0xfe00ffff 64bit pref]
> [   88.905715] virtio-pci 0000:00:07.0: BAR 4: assigned [mem 0x24000c000-=
0x24000ffff 64bit pref]
> [   88.906693] ltp_tpci: assign resource to '4', ret '0'
> [   88.906694] ltp_tpci: assign resource #5
> [   88.906694] ltp_tpci: name =3D (null), flags =3D 0, start 0x0, end 0x0
> [   88.906695] ltp_tpci: assign resource #6
> [   88.906695] ltp_tpci: name =3D 0000:00:07.0, flags =3D 0, start 0x0, e=
nd 0x0
>
> [   88.906800] ltp_tpci: test-case 13

I don't know. Maybe the test case is leaving the device is a state
that conflicts with the virtio drivers that are bound after testing
finishes.

One approach is to trace the PCI BAR accesses after the test runs and
compare against a trace when the tpci driver hasn't been loaded. That
way you might be able to find out what is different.

Stefan

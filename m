Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13171777C14
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 17:25:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234177AbjHJPZC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 11:25:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236086AbjHJPZA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 11:25:00 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 070212683
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 08:25:00 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id 46e09a7af769-6bca3588edbso927169a34.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 08:25:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691681099; x=1692285899;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pxV1ytHBtuwEj4BK9j4YrDkuqfRrb/9v0z1bR7ApUsg=;
        b=keSFfrxGvW9+vNTAeY+ZLLYXtTl076j9GB0mPdG7AjMWKWklL9M4JH0o6R6fEleA0u
         2Rsl8foXcpLkknJ3qdNh2ihYvxvfGyvf7RVyHBFOrJUBiH4suHRc2lpRfB8PA+HM8Qjv
         pOvybco23lVRrTemV89y5RN6vUCTxnVbwUkVJrRMsVPD9ZTuQKsoVreVehL6JsS5nDsD
         u1OFfmB5rzZi4tKzKpkeEQC9MkPCiLi7fvINowXgTZjl+JvcX0GU7gz6SscyeAwCtinz
         ddItWDoX5mveqdk4MxbAEH+CKtTLrik3UUn2+tTS1y6JkzDVhsuHar7ORJCeKKH11kbP
         UoTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691681099; x=1692285899;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pxV1ytHBtuwEj4BK9j4YrDkuqfRrb/9v0z1bR7ApUsg=;
        b=ZTvO8pCKSHPWaJQ/ezcIlvbM7y+b2jG+0N3UMollyoIvEP/LAoQTWsXZ++t1LupKI4
         ODqy2rxgZW0hbSsvqbZvI3lhRDlsUUfL6zvmxwTl9cbxfajuiEhhS+3t5yhvaCb8GoRS
         d15J4icU71/CHajQfLY+vScLoJoVrWcKvrxmiqq2JgYow54LlBfY75K4UaF3sfkysImi
         RolH6KPRz/FA++Fzar7cLy5ngbe8EcJFLa1QAC/bX5H5cj9+hg2UH9kDq78PbWb+u5Nn
         FoUs1pN/KkVyi60B6w0eE23FsbzjFiMKiER0Sg9ni9LX1f2VDU4i4SKN8dzlkyvlb8YW
         k2uA==
X-Gm-Message-State: AOJu0YxFRov3QVP1Zk5PDtjVGAPq1D7C31Yi2G2hkDByFWwUYj4/j/xC
        6TeBQzFL/Bs0BDkEn4IxuzpeLlGcwy0nHoo2Wco=
X-Google-Smtp-Source: AGHT+IGd7kCDLmQrnXgLm6RiEGZyVgclWpjJ1SRgzCRNZHbOmYNGHUdaSxNfNGlZ54CN/PtIrQs1X+d9JXyC+03nRX0=
X-Received: by 2002:a05:6870:3412:b0:1bf:dc26:4947 with SMTP id
 g18-20020a056870341200b001bfdc264947mr2944492oah.46.1691681099260; Thu, 10
 Aug 2023 08:24:59 -0700 (PDT)
MIME-Version: 1.0
References: <461df15f.15e2d.189deaa6eed.Coremail.kvmluck@163.com>
 <38e69323-0185-32bb-2de1-8e5b36de2abc@tls.msk.ru> <3c1a93da.16493.189df040e16.Coremail.kvmluck@163.com>
 <20230810141335.GA2931656@fedora>
In-Reply-To: <20230810141335.GA2931656@fedora>
From:   Stefan Hajnoczi <stefanha@gmail.com>
Date:   Thu, 10 Aug 2023 11:24:47 -0400
Message-ID: <CAJSP0QX5Z=GFnjyGOgQ8hs6hkdUASznUPmuZJp11ViokSRZ0Tw@mail.gmail.com>
Subject: Re: LTP test related to virtio releasing and reassigning resource
 leads to guest hung
To:     Stefan Hajnoczi <stefanha@redhat.com>
Cc:     "longguang.yue" <kvmluck@163.com>,
        Michael Tokarev <mjt@tls.msk.ru>,
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

On Thu, 10 Aug 2023 at 10:14, Stefan Hajnoczi <stefanha@redhat.com> wrote:
>
> On Thu, Aug 10, 2023 at 06:35:32PM +0800, longguang.yue wrote:
> > could you please give me some tips to diagnose?  I could do tests on qe=
mu 8.0, but product environment could not update.
> > I test on different kernel version 5.10.0-X, one is better and results =
show problem is more about host kernel  rather than qemu.
> >
> >
> > test cases are different combination of i440fx/q35 and virtio/scsi and =
kernel.
>
> Can you post the guest kernel messages (dmesg)? If the guest is hanging
> then it may be easiest to configure a serial console so the kernel
> messages are sent to the host where you can see them.
>
> Does the hang occur during the LTP code you linked or afterwards when
> the PCI device is bound to a virtio driver?

I didn't see your original email so I missed the panic. I'd still like
to see the earlier kernel messages before the panic in order to
understand how the PCI device is bound.

Is the vda device with hung I/O the same device that was accessed by
the LTP test earlier? I guess the LTP test runs against the device and
then the virtio driver binds to the device again afterwards?

>
> Which virtio device causes the problem?
>
> Can you describe the hang in more detail: is the guest still responsive
> (e.g. console or network)? Is the QEMU HMP/QMP monitor still responsive?
>
> Thanks,
> Stefan
>
> >
> >
> >
> >
> > thanks
> >
> >
> >
> >
> > ---- Replied Message ----
> > | From | Michael Tokarev<mjt@tls.msk.ru> |
> > | Date | 08/10/2023 17:08 |
> > | To | longguang.yue<kvmluck@163.com> ,
> > qemu-devel<qemu-devel@nongnu.org> ,
> > linux-kernel<linux-kernel@vger.kernel.org> |
> > | Subject | Re: LTP test related to virtio releasing and reassigning re=
source leads to guest hung |
> > 10.08.2023 11:57, longguang.yue wrote:
> > Hi, all:
> > A ltp test leads to guest hung(io hung), the test releases virtio devic=
e resource and then reassign.
> > I find device=E2=80=99s mem prefetchable resource 64-bit is changed.
> >
> > ltp
> > test: https://github.com/linux-test-project/ltp/blob/522d7fba4afc84e07b=
252aa4cd91b241e81d6613/testcases/kernel/device-drivers/pci/tpci_kernel/ltp_=
tpci.c#L428
> >
> > Do you know what cause the problem?
> >
> > Thanks very much.
> >
> > --------------------------
> > ENV: kernel 5.10.0, qemu 6.2
> >
> > Current qemu is 8.1 (well, almost, to be released this month;
> > previous release is 8.0 anyway).
> >
> > This might be interesting to test in a current version before
> > going any further.
> >
> > Thanks,
> >
> > /mjt

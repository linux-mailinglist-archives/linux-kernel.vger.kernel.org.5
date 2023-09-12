Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB30C79C956
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 10:09:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232354AbjILIJH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 04:09:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232011AbjILIJF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 04:09:05 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0C8710C3;
        Tue, 12 Sep 2023 01:09:00 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-501ce655fcbso8547805e87.2;
        Tue, 12 Sep 2023 01:09:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694506139; x=1695110939; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BRy58mtOMfLsnyOd5KeG4RjAf/fDpf2NPVmv4pRKN3U=;
        b=synp5sDsxiYJB6hXt2QIko5GmsZf7l3rEGA+uRtQiO/o+ouNMhfwUemlSqs6OuRLGi
         LZSlyXtWBYVBl8hiPYpWoMgAsvqa3V0NSrUjjSa7Y+fZRdgci4u5crAybgFT3baoNKS3
         BpXrjiOz/KwMHwozQg1bLEqsjzEcuuR8C9hs+9WyAx84rzXBXe1u4mYfhvbW2sgRtWa+
         Z2iDJdHzG7govOxV0Wu/ISkOqUSaXhsT6KSCz5wN0/LzzLD0bVXDiJyyjJv23T5cwpTy
         QO2+qjoZoxVBB2rHq+gAH51r0trrf5bGtav5/LPeF2L+29LlyVkjzi6ktE3ORXNFtXC+
         25sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694506139; x=1695110939;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BRy58mtOMfLsnyOd5KeG4RjAf/fDpf2NPVmv4pRKN3U=;
        b=AVf+hYvCKSNNuVZQNgtjiapaXJyQwniBwk9VHpos/SRYz0hE2OqxVTRVtPM8Tlu3KU
         l7vJC5dzKAkGNnFlTjO2SrGQp5NR/R9POYvNN4RdjZEq/2fzVeMhMJ02DHLsFEykLr39
         NByvDvhGaU3mrb/y/ES/ysXMWaYhPpgxvfI0TiC4bSQcT6InXN47a/GYwFN8+Zviiuqr
         T2Yc2xc2U0ucJrtexWJhmeGILsIgOQQGQbMJvvP7eqDCONfvxZRwW4PMGNrQ/Jo3HUms
         mMeqALy0mMfVG8n+m+MyGRLui04kKi4KKCkvbIsOeHKWAEgsWigU52xlXAOYRvh1fmGV
         Lc1g==
X-Gm-Message-State: AOJu0YyIaOTht1UIywO+ysGC91p2HMdURbMwtDfCd3j8FEjKClfmUHSJ
        RbM6UFAsI/gI0pf4Xpjn9QQZ0PjdwOfFQt7HOeM=
X-Google-Smtp-Source: AGHT+IFwDwJhrpy8HowhIBYcBi/whf/X/T3w9uKWfcXrLILoGcUMzinlah9wOUe1t9L08eJ9Z5UmcgaMaRFE2N9j4uo=
X-Received: by 2002:a05:6512:33c8:b0:502:a56b:65f7 with SMTP id
 d8-20020a05651233c800b00502a56b65f7mr8526287lfg.16.1694506138521; Tue, 12 Sep
 2023 01:08:58 -0700 (PDT)
MIME-Version: 1.0
References: <8af186ba-5f64-2102-8f9c-3969b0906893@gmail.com>
 <faa245bf-e925-45b0-9827-b0c9c117e06c@leemhuis.info> <ZPc8v9-lHF4jAcxL@kbusch-mbp>
In-Reply-To: <ZPc8v9-lHF4jAcxL@kbusch-mbp>
From:   =?UTF-8?Q?Cl=C3=A1udio_Sampaio?= <patola@gmail.com>
Date:   Tue, 12 Sep 2023 10:08:48 +0200
Message-ID: <CA+4wXKCAYM19H7n4TpbnrtRy_Yv1JOjT3CHVuxh_18Mb7NB4+A@mail.gmail.com>
Subject: Re: Fwd: Lexar NM790 SSDs are not recognized anymore after 6.1.50 LTS
To:     Keith Busch <kbusch@kernel.org>
Cc:     Linux regressions mailing list <regressions@lists.linux.dev>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux NVMe <linux-nvme@lists.infradead.org>,
        Linux Stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Keith... Just to give you guys a response concerning this, I'm
sorry for the late reply -- too much work. But yes, you are correct,
due to having tried patching the kernel in different days and too much
stuff going on at the same time, I applied this two-line patch to the
same source where I have applied the other patch that multiplies the
timeout by 2 and occurs at an earlier time on activation. I thought I
had an unpatched kernel at the time and ended up compiling it this
way. Sorry for the mistake, but I also saw that now there's a better
patch for the issue.

On Tue, Sep 5, 2023 at 4:35=E2=80=AFPM Keith Busch <kbusch@kernel.org> wrot=
e:
>
> On Tue, Sep 05, 2023 at 01:37:36PM +0200, Linux regression tracking (Thor=
sten Leemhuis) wrote:
> > On 04.09.23 13:07, Bagas Sanjaya wrote:
> > >
> > > I notice a regression report on Bugzilla [1]. Quoting from it:
> > >
> > >> I bought a new 4 TB Lexar NM790 and I was using kernel 6.3.13 at the=
 time. It wasn't recognized, with these messages in dmesg:
> > >>
> > >> [ 358.950147] nvme nvme0: pci function 0000:06:00.0
> > >> [ 358.958327] nvme nvme0: Device not ready; aborting initialisation,=
 CSTS=3D0x0
> > >>
> > >> My other NVMe appears correctly in the nvme list though.
> > >>
> > >>
> > >> So I tried using other kernels I had installed at the time: 6.3.7, 6=
.4.10, 6.5.0rc6, 6.5.0, 6.5.1 and none of these recognized the disk.
> > >> I installed the 6.1.50 lts kernel from arch repositories (I can comp=
ile my own too if this would be an issue) and then the device was correctly=
 recognized:
> > >>
> > >> [    4.654613] nvme 0000:06:00.0: platform quirk: setting simple sus=
pend
> > >> [    4.654632] nvme nvme0: pci function 0000:06:00.0
> > >> [    4.667290] nvme nvme0: allocated 40 MiB host memory buffer.
> > >> [    4.709473] nvme nvme0: 16/0/0 default/read/poll queues
> >
> > FWIW, the quoted mail missed one crucial detail:
> > """
> >  Claudio Sampaio 2023-09-02 19:04:29 UTC
> >
> > Adding the two lines
> >
> > =E2=94=82 3457   { PCI_DEVICE(0x1d97, 0x1602), /* Lexar NM790 */
> > =E2=94=82 3458   =E2=94=82 .driver_data =3D NVME_QUIRK_BOGUS_NID, },
> >
> > in file drivers/nvme/host/pci.c made my NVMe work correctly. Compiled a
> > new 6.5.1 kernel and everything works.
> > """
> >
> > @NVME maintainers: is there anything more you need from Claudio at this
> > point?
>
> Yes: it doesn't really make any sense. The report says the device
> stopped showing up with message:
>
>   nvme nvme0: Device not ready; aborting initialisation, CSTS=3D0x0
>
> That (a) happens long before the mentioned quirk is considered by the
> driver, and (b) the "quirk" behavior is now the default in 6.5 and
> several of the listed stable kernels anyway.
>
> It more likely sounds like the device is flaky and either never becomes
> ready due to some unspecified internal firmware condition, or
> inaccurately reports how long it actually needs to become ready in
> worst-case-scenario.



--=20
Cl=C3=A1udio "Patola" Sampaio
MakerLinux Labs - Campinas, SP
Resume Gmail - YOUTUBE!
Facebook - Facebook da MakerLinux - Lattes

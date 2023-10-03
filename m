Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59B137B68EC
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 14:26:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232435AbjJCM0F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 08:26:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231440AbjJCM0D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 08:26:03 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9686B8;
        Tue,  3 Oct 2023 05:25:58 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id 3f1490d57ef6-d8162698f0dso917009276.0;
        Tue, 03 Oct 2023 05:25:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696335958; x=1696940758; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LNO5GJBfVgDppnnjLs8Ey/aGvi+SY8q8n/RPtqg6Lb0=;
        b=hsK9jHxmOtLJ2VlYpbe5A0BRGU/6RDLVwpPRxUb0G1oC85PnNiA52gzFW2ObtQVlQL
         iQ2zTKF6rKkpISQFpKJ+X4dUzNmD9iFsSO4F+c58xpvoj3jcfsprEDV+bNrfeGVsDB4s
         yC4iZbmASYhXgWa2L0fw1DtJFzInEJBb8SDldCwtT+2weRTfVuDou98lFk6OUYiF1Phk
         5NkqUZE2W2rkVfrV6J37Sv/kdggOGseURs+SukdCAdTeyLXKhDDzHMS8EkhGrJ3acBhs
         zhWeFL11SZ/X4Pl/6ieo0fClJGLt3IzvHeOWOeJAdXbNpbkOUaZvOu26mYMjj6tk0COQ
         AZUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696335958; x=1696940758;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LNO5GJBfVgDppnnjLs8Ey/aGvi+SY8q8n/RPtqg6Lb0=;
        b=f+uOcryYhMYlLLC0HYOFWaCEY/jEsPMqwojaHDkpErDjlNufs/UIV937Z78TwvAeDK
         wz1WvxSX+ttvRaULy7Lod+BA4b+T15xcPbe2O3c2D6z0tCxwg6yZhnWT8t+vhtoNEonL
         FvFdxWu2fV6qwVug9n8yAgNUgIgdjW9IELcD16toWr6aWy//fLtKQRIihR3IVh8qf0DQ
         lwuk3OcRy+eRej2jNxWyxN9Czpl/i/uU+84XoRtyJbxwNb/u+QCdV1SeAqjDiLUrJDDl
         L4ffkfvI2gyB+QEq8rlilh1iziLxt9q3El2WBYuU+DndqnVOJW0VlpqtmClwo2p7Zl0w
         bqow==
X-Gm-Message-State: AOJu0YzD3/8uxZCcJ1PwrmK5CYbRE+oS0N2//prvH1T+eOMnwIFzX2TW
        Hx7TWYLX4QLamVrDLBmDxWMnQYq5ICmPWC9tdiw=
X-Google-Smtp-Source: AGHT+IH3vFPI8wkZPSB+huGryIAf1o97KjtxkawCjpbmFqLZ7a060PcmeyqhgyDquT7PF4ujt0bcej93HgDs77wHvAQ=
X-Received: by 2002:a05:6902:707:b0:d85:aa81:53f0 with SMTP id
 k7-20020a056902070700b00d85aa8153f0mr16641798ybt.4.1696335957740; Tue, 03 Oct
 2023 05:25:57 -0700 (PDT)
MIME-Version: 1.0
References: <CAH7-e5sb+kT_LRb1_y-c5JaFN0=KrrRT97otUPKzTCgzGsVdrQ@mail.gmail.com>
 <ZRtWcgiH5JhD5NU2@debian.me>
In-Reply-To: <ZRtWcgiH5JhD5NU2@debian.me>
From:   =?UTF-8?Q?Erik_Dob=C3=A1k?= <erik.dobak@gmail.com>
Date:   Tue, 3 Oct 2023 14:25:46 +0200
Message-ID: <CAH7-e5uspavg_VBJxKLOKJfU3nAq-OrPqzihF2opffY-ReiC-w@mail.gmail.com>
Subject: Re: bluetooth issues since kernel 6.4 - not discovering other bt
 devices - /linux/drivers/bluetooth/btusb.c
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Linux Stable <stable@vger.kernel.org>,
        Linux Bluetooth <linux-bluetooth@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Mediatek <linux-mediatek@lists.infradead.org>,
        Linux Regressions <regressions@lists.linux.dev>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        =?UTF-8?Q?Tomasz_Mo=C5=84?= <tomasz.mon@nordicsemi.no>
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

On Tue, 3 Oct 2023 at 01:47, Bagas Sanjaya <bagasdotme@gmail.com> wrote:
>
> On Sun, Oct 01, 2023 at 07:47:54AM +0200, Erik Dob=C3=A1k wrote:
> > Hello!
> >
> > I bought a new laptop fujitsu life book and everything is going fine
> > on artix just the bt makes trouble:
> >
> > /var/log/error.log
> > Sep 30 18:43:48 nexus bluetoothd[2266]:
> > src/adapter.c:reset_adv_monitors_complete() Failed to reset Adv
> > Monitors: Failed (0x03)
> > Sep 30 18:43:48 nexus bluetoothd[2266]: Failed to clear UUIDs: Failed (=
0x03)
> > Sep 30 18:43:48 nexus bluetoothd[2266]: Failed to add UUID: Failed (0x0=
3)
> > Sep 30 18:43:48 nexus bluetoothd[2266]: Failed to add UUID: Failed (0x0=
3)
> >
> > i searched a bit the webs and found a new commit at kernel org that
> > does do the trouble:
> > https://bugs.archlinux.org/task/78980
> >
> > follow the linkeys inside the commits there or read this one:
> >
> > ---------------before------------------------------------
> > /* interface numbers are hardcoded in the spec */
> >         if (intf->cur_altsetting->desc.bInterfaceNumber !=3D 0) {
> >                 if (!(id->driver_info & BTUSB_IFNUM_2))
> >                         return -ENODEV;
> >                 if (intf->cur_altsetting->desc.bInterfaceNumber !=3D 2)
> >                         return -ENODEV;
> >         }
> > -----------after----------------------------------------------------
> > if ((id->driver_info & BTUSB_IFNUM_2) &&
> >     (intf->cur_altsetting->desc.bInterfaceNumber !=3D 0) &&
> >     (intf->cur_altsetting->desc.bInterfaceNumber !=3D 2))
> > return -ENODEV;
> > --------------------------------------------------------
> >
> > the dude just hooked up 3 conditions in a row with && where before it
> > was 2 conditions in 1 condition. + the comment was removed.
> >
> >
>
> Try latest mainline first (currently v6.6-rc4). Because you have to
> compile your own kernel, please refer to
> Documentation/admin-guide/quickly-build-trimmed-linux.rst if you don't kn=
ow how to do the compilation.
>
> Also, don't top-post when replying; reply inline with appropriate context
> instead.
>
> Thanks.
>
> --
> An old man doll... just what I always wanted! - Clara

Hi i booted now into linux-6.6-rc4 and the issue is still there. No
bluetooth devices are discovered.
with this device: Bus 001 Device 004: ID 04c5:1670 Fujitsu, Ltd Bluetooth R=
adio

E

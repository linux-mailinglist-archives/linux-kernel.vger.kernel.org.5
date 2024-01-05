Return-Path: <linux-kernel+bounces-18004-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16CE08256D6
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 16:40:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4770D1C22FB1
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 15:40:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EDBB2E657;
	Fri,  5 Jan 2024 15:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rjv8vLSp"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8CA22E634;
	Fri,  5 Jan 2024 15:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2cce70ad1a3so21547821fa.1;
        Fri, 05 Jan 2024 07:40:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704469229; x=1705074029; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ydIbLEmZowGG9B8TAW5+HEhwyDa/x9zAWSy2CKRslyE=;
        b=Rjv8vLSp7rEz6iOA8yWjFOjKSWUQ0XX6jtC9Du7GrOGZOK3Pgk2YrwxL9RzW2U9jdn
         9kC2tDWZW4Lw7WAcOm7c6lsmcC2Gb0Nu6Gkr/klFzPaFAFbB2GKkbl7/oLn8kz1gYwgr
         Ms0cx42sKNwqM/y/S19QxzXsoJduGL7pQu33IVVYB82PXdAKCLVLPYK2bqlbPGArsdwy
         wgnIDcNqf5z0kzA6iCa3tDrY28S15fw41p6RLeXflMizI53EYZGPMyrlCSUQw0ltVEog
         IMJZewRjtjx1GF626FF8ObaAzLfu8YdoHhOCzuYwIOhSGvlbArbgH1tf17DU+eMMrwyE
         TUpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704469229; x=1705074029;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ydIbLEmZowGG9B8TAW5+HEhwyDa/x9zAWSy2CKRslyE=;
        b=U5F8769P20fH2NEpj5ESBLx8pyzwWFZGdhEXnnnd12LL4YIjzydhyen1JHtqbJk1OJ
         qWwoadkm/nM7zMep/A8qw0xFrJJhcXWOQb0wvYeK1mPpBcdy5Q3z7ptWf3Kb3OZulX6C
         ZvGRDwhXukAbEXV9W/ocPNoP6kIEIlAnAXy16rKEaC86troO7kwYoIS+T25rry51NBV0
         vI4m1yjNPZ08Q1AXMnUtNBOg1nP6AAgF00mDJ89h6cTViL4flp5TEbsn0UHIocAW5WDy
         JuizaYIdtV+twv63ySQsU10dwO666CQyp+PVD/NVJUIpX+wsBBn44ptms8x8rhVoRmhW
         DUQA==
X-Gm-Message-State: AOJu0Yw75iZtYBrGos8IFWDLSVxcFnZxZnMMH6qV6icFKufCoY0tEWih
	sniRYeeh9kX5t03XuODORf9J8gxCLJxFT0vx0EA=
X-Google-Smtp-Source: AGHT+IFHL0WycEXfsQJGWEqdT4ieJH6ykf8gPVVBCbOafOrvbF+l8QLAu9rZYDXICzcrmNWtEBJdvl9ljIIHpZHARVA=
X-Received: by 2002:a2e:9f53:0:b0:2cc:df53:5322 with SMTP id
 v19-20020a2e9f53000000b002ccdf535322mr1100079ljk.61.1704469228656; Fri, 05
 Jan 2024 07:40:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240104115453.1.Iaa08c695d3dcf819910ea723c3eb502935638172@changeid>
 <63d2b52d-8f0b-4456-896c-ecdaf835c65a@wanadoo.fr> <CABBYNZKo7sFQxE6cE=KTH6-DpL2NzpW7Yybdr49dhdih6+8dcg@mail.gmail.com>
In-Reply-To: <CABBYNZKo7sFQxE6cE=KTH6-DpL2NzpW7Yybdr49dhdih6+8dcg@mail.gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 5 Jan 2024 10:40:15 -0500
Message-ID: <CABBYNZ+BqXGcfpcLJZxC_9AO-2kiH4K8-yu3mgTq9uAxAMY09w@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: Avoid potential use-after-free in hci_error_reset
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: yinghsu@chromium.org, chromeos-bluetooth-upstreaming@chromium.org, 
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Jan 5, 2024 at 10:36=E2=80=AFAM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Christophe,
>
> On Fri, Jan 5, 2024 at 2:15=E2=80=AFAM Christophe JAILLET
> <christophe.jaillet@wanadoo.fr> wrote:
> >
> > Le 04/01/2024 =C3=A0 12:56, Ying Hsu a =C3=A9crit :
> > > While handling the HCI_EV_HARDWARE_ERROR event, if the underlying
> > > BT controller is not responding, the GPIO reset mechanism would
> > > free the hci_dev and lead to a use-after-free in hci_error_reset.
> > >
> > > Here's the call trace observed on a ChromeOS device with Intel AX201:
> > >     queue_work_on+0x3e/0x6c
> > >     __hci_cmd_sync_sk+0x2ee/0x4c0 [bluetooth <HASH:3b4a6>]
> > >     ? init_wait_entry+0x31/0x31
> > >     __hci_cmd_sync+0x16/0x20 [bluetooth <HASH:3b4a 6>]
> > >     hci_error_reset+0x4f/0xa4 [bluetooth <HASH:3b4a 6>]
> > >     process_one_work+0x1d8/0x33f
> > >     worker_thread+0x21b/0x373
> > >     kthread+0x13a/0x152
> > >     ? pr_cont_work+0x54/0x54
> > >     ? kthread_blkcg+0x31/0x31
> > >      ret_from_fork+0x1f/0x30
> > >
> > > This patch holds the reference count on the hci_dev while processing
> > > a HCI_EV_HARDWARE_ERROR event to avoid potential crash.
> > >
> > > Signed-off-by: Ying Hsu <yinghsu-F7+t8E8rja9g9hUCZPvPmw@public.gmane.=
org>
> > > ---
> > > Tested this commit on a chromebook with Intel BT controller.
> > >
> > >   net/bluetooth/hci_core.c | 2 ++
> > >   1 file changed, 2 insertions(+)
> > >
> > > diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> > > index 65601aa52e0d..a42417926028 100644
> > > --- a/net/bluetooth/hci_core.c
> > > +++ b/net/bluetooth/hci_core.c
> > > @@ -1049,6 +1049,7 @@ static void hci_error_reset(struct work_struct =
*work)
> > >   {
> > >       struct hci_dev *hdev =3D container_of(work, struct hci_dev, err=
or_reset);
> > >
> > > +     hci_dev_hold(hdev);
> > >       BT_DBG("%s", hdev->name);
> > >
> > >       if (hdev->hw_error)
> > > @@ -1060,6 +1061,7 @@ static void hci_error_reset(struct work_struct =
*work)
> > >               return;
> >
> >                  ^^^^^
> > Should we also call hci_dev_put() if we hit this return?
>
> Yep, I will fix that since Ive already pushed to bluetooth-next.

Here is the proposed change:

-       if (hci_dev_do_close(hdev))
-               return;
+       if (!hci_dev_do_close(hdev))
+               hci_dev_do_open(hdev);

-       hci_dev_do_open(hdev);
+       hci_dev_put(hdev);

> >
> > CJ
> >
> > >
> > >       hci_dev_do_open(hdev);
> > > +     hci_dev_put(hdev);
> > >   }
> > >
> > >   void hci_uuids_clear(struct hci_dev *hdev)
> >
>
>
> --
> Luiz Augusto von Dentz



--=20
Luiz Augusto von Dentz


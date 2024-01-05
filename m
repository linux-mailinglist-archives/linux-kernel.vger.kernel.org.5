Return-Path: <linux-kernel+bounces-18000-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C1C038256C7
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 16:37:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7159B283A30
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 15:37:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A54812E64B;
	Fri,  5 Jan 2024 15:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kc4nxtF9"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62DBD2E631;
	Fri,  5 Jan 2024 15:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2cd37c0b8e5so3795481fa.3;
        Fri, 05 Jan 2024 07:36:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704469011; x=1705073811; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Eap6Bv7UqsiZ31u/Bbi6NwynETu5hHY2qpNTg74+3d4=;
        b=Kc4nxtF9xb1ENTb1SiB2MbyxlpMycpuJr9KWN7U6dnxvT1TATB4ti1+YIgLZ4jQuyt
         9BnnRKN5wD9A91OWn3PgUxeDt7bM2WMeT+mEsYEHb2tmv4GLTXcN9IT1FB4EAGtOUrt/
         Ne4+TbKRlVE+Q9P+Ly+Jt91MjiccEEVrnxvfMXqYb+j+41LpuoYc4tUEB0wUA52KVzkw
         7ryhj3wakHPee/A/gvIS2yBJPrtoNScgP1ihGiSmDqK+DmYWj/OBol1kkSMFm3JbbF5m
         kEccfZOkg56F+oGaSGin+ZBChMMTb2FmEbu+f+RmQkAh/yBmx9Z3qp1KVjrv1oBJ68V5
         g1NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704469011; x=1705073811;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Eap6Bv7UqsiZ31u/Bbi6NwynETu5hHY2qpNTg74+3d4=;
        b=tTOh4LQ/0Ulae9/sAvJouIr35pr5LNAVOD8MFHrCmrl3u+QSvRHd7e/4o2nJG9EiTC
         95hM7iz6i2uWXMXkBsoNUTVaukYHyDxiPN8RtZYSdmcXjZk9sD1b4PobqCoYTd1hy9fj
         0XLc7QzIKloJ+bCF7A248LOtdk7qDQjenZUMysmVF/3ASc9KxYy63RyS6NDK2tfwApmI
         mPPJGTLOYmOYfjUy9EXQk393ayeySSreyrrlhNfZz57cfdE5eFw3vOTTIZcxrooMEr+h
         NQ7fPGCt8oCHrnaf9plBg39s8SKTL3of61pAI8VihutbfTP4x8MOI17vEI8yJhLOT/mg
         8+Ow==
X-Gm-Message-State: AOJu0YzIVewkjik5WdU2ivAdK44jl04/ztCFcDuUnkyxpxL6y9DHEZgt
	HuQCiXsuEjgT4zjk/2VdIIlXczLRdvmo+IvN+u5LTjWL
X-Google-Smtp-Source: AGHT+IHnBz59liJzs+MSy25Igle+CBetQ9tSFPPk+7JK285pupqmpXvdofpFsLeyyrsvX7WhWMNIv4k5uXcfWHOP+lg=
X-Received: by 2002:a05:651c:1992:b0:2cc:8e9d:1769 with SMTP id
 bx18-20020a05651c199200b002cc8e9d1769mr1382307ljb.95.1704469011248; Fri, 05
 Jan 2024 07:36:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240104115453.1.Iaa08c695d3dcf819910ea723c3eb502935638172@changeid>
 <63d2b52d-8f0b-4456-896c-ecdaf835c65a@wanadoo.fr>
In-Reply-To: <63d2b52d-8f0b-4456-896c-ecdaf835c65a@wanadoo.fr>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 5 Jan 2024 10:36:39 -0500
Message-ID: <CABBYNZKo7sFQxE6cE=KTH6-DpL2NzpW7Yybdr49dhdih6+8dcg@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: Avoid potential use-after-free in hci_error_reset
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: yinghsu@chromium.org, chromeos-bluetooth-upstreaming@chromium.org, 
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Christophe,

On Fri, Jan 5, 2024 at 2:15=E2=80=AFAM Christophe JAILLET
<christophe.jaillet@wanadoo.fr> wrote:
>
> Le 04/01/2024 =C3=A0 12:56, Ying Hsu a =C3=A9crit :
> > While handling the HCI_EV_HARDWARE_ERROR event, if the underlying
> > BT controller is not responding, the GPIO reset mechanism would
> > free the hci_dev and lead to a use-after-free in hci_error_reset.
> >
> > Here's the call trace observed on a ChromeOS device with Intel AX201:
> >     queue_work_on+0x3e/0x6c
> >     __hci_cmd_sync_sk+0x2ee/0x4c0 [bluetooth <HASH:3b4a6>]
> >     ? init_wait_entry+0x31/0x31
> >     __hci_cmd_sync+0x16/0x20 [bluetooth <HASH:3b4a 6>]
> >     hci_error_reset+0x4f/0xa4 [bluetooth <HASH:3b4a 6>]
> >     process_one_work+0x1d8/0x33f
> >     worker_thread+0x21b/0x373
> >     kthread+0x13a/0x152
> >     ? pr_cont_work+0x54/0x54
> >     ? kthread_blkcg+0x31/0x31
> >      ret_from_fork+0x1f/0x30
> >
> > This patch holds the reference count on the hci_dev while processing
> > a HCI_EV_HARDWARE_ERROR event to avoid potential crash.
> >
> > Signed-off-by: Ying Hsu <yinghsu-F7+t8E8rja9g9hUCZPvPmw@public.gmane.or=
g>
> > ---
> > Tested this commit on a chromebook with Intel BT controller.
> >
> >   net/bluetooth/hci_core.c | 2 ++
> >   1 file changed, 2 insertions(+)
> >
> > diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> > index 65601aa52e0d..a42417926028 100644
> > --- a/net/bluetooth/hci_core.c
> > +++ b/net/bluetooth/hci_core.c
> > @@ -1049,6 +1049,7 @@ static void hci_error_reset(struct work_struct *w=
ork)
> >   {
> >       struct hci_dev *hdev =3D container_of(work, struct hci_dev, error=
_reset);
> >
> > +     hci_dev_hold(hdev);
> >       BT_DBG("%s", hdev->name);
> >
> >       if (hdev->hw_error)
> > @@ -1060,6 +1061,7 @@ static void hci_error_reset(struct work_struct *w=
ork)
> >               return;
>
>                  ^^^^^
> Should we also call hci_dev_put() if we hit this return?

Yep, I will fix that since Ive already pushed to bluetooth-next.

>
> CJ
>
> >
> >       hci_dev_do_open(hdev);
> > +     hci_dev_put(hdev);
> >   }
> >
> >   void hci_uuids_clear(struct hci_dev *hdev)
>


--=20
Luiz Augusto von Dentz


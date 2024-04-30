Return-Path: <linux-kernel+bounces-164415-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 031AB8B7D62
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 18:46:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC600284C53
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 16:46:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFCD817A93B;
	Tue, 30 Apr 2024 16:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bX/9d2TH"
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 103DE173351;
	Tue, 30 Apr 2024 16:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714495573; cv=none; b=HNxf/vyDSszmLSlISlacMSJrnuSV0eVk+1YPc7eUbwP2Gkok61xEckChj1BagacrdaWXz6ydduLoVrvWafot+X8D/DFV+EAXhKxbMK22tVJYWWuAOSmaDvHvceTKWqQamY5ReetOelK5LfVTdLLNC/LOxsSGFaGnCQ4c3keyeTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714495573; c=relaxed/simple;
	bh=O3dax3FvRfKRm3yG5pK7wRJsbV9n+EUs4Fz+IcHaimQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fds+ElpEJ5sPtC/DRJRbvrcecEeT0frT0LEFrqJ+pfO1Vz0ZSbCbvyiZEPNEALBNsj2khG70hDUl96ZoOqwewmO8qS5HJ+s0qdJToAobb9iBUthvRTt6hhf2kiz7CJvWmHffDUBEGC26Yu5CXYQmQUYT7Hs02V6he5Xr+OkHwOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bX/9d2TH; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2d858501412so76367971fa.0;
        Tue, 30 Apr 2024 09:46:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714495570; x=1715100370; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PrwYgNV5s5c1UgIlteHTl7L1KmzOIUnzO8B2OPbUGBk=;
        b=bX/9d2THS/Psjx/PVFIexg1r/jRZIJt0o+nUwDTQ0Lqma82yQBUGzSCrmeWac1IiWu
         oJA8bnRESHQsDAt2nSfIDPcBcO2LYsnRMUdA+x4ymAge2E04cKTgvpWL1WDwGhUHwTrV
         5sqTNP3r4Jx/Z2lKdiTxBN1Ps+vVeIFHTF0OKtU6+8AeuoiG2/Pgq9FjaO5LDvJZJ93q
         BLLfWanOAl4hbGecwJTzhO2Alz0kTu6gNJZeJG2mGx8dbHAjcYg5vhiVc+WhswUnsYpK
         EEvsaWewKNkE4m6n2Xm9by/m52ZN6Qx6Cbp27KeBw4SjKi4t7zawxvPzYjVUX5nCDRrR
         H62A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714495570; x=1715100370;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PrwYgNV5s5c1UgIlteHTl7L1KmzOIUnzO8B2OPbUGBk=;
        b=JuEbXSpM9AZo5Sric7kYyu+sVObvusi/1a6MqgToWshP735oobMIpPodsPQDWJfysP
         9Dn3pstQhHI+JMzHET5rAZAUld5ejKSLYbla1LECth763Dhxi3fVXKULdxz2QCwC2TAa
         tXQcvTO1s0GgMSTwSfZqfpIg6/fyrcTEsZKFJ8Ks8GAb0pFp1q4dV4I2F67sut7Qu8ye
         qowNtcozSRIhLyhzh91uO8u+Cck6XBUQY0Xa95K6Bete3DwusSbCgl4cGx2yjUst3CuB
         C0G7TsNv/ETvlDqroeaoXUqJH8kNepJGqzYfzp6POAds0ZVtKCuLwJ3DPI/ivrpP5VKF
         ymaQ==
X-Forwarded-Encrypted: i=1; AJvYcCXt2ZGLiWGfQl5ezgD6UsmkL6tHoX0CB8bBgOCQ+Tg8G+oFLDGel1X7r7BKjj+u4LSyb6tn2ri+mttOSBSEsSapJieAD6Bzp4sL6bU+19/gMcLYMPUM6v13iKJsuxvu8YQzKi8IVQM5j1cmzoWB
X-Gm-Message-State: AOJu0YzuofUUuIf75DMnPC27x/Wl/MeEFD8+RQt0Y2BD9EFYXucajxK2
	AcbiL4yqrrDoVg2nL0h6a+1wthIfdsU2+Y7o3C3/YPikzOWxNtdjv7ybame7+nuvszguNxNse9U
	rCWn8TkZyEf5YqmD6kZkcM1rOE2pT8iX7
X-Google-Smtp-Source: AGHT+IF/j1uKE1m/SHLyKRrKlDW+QUU2bdopTAC/7gVcb4H2ZdgDSbqCxgKFRjeEW9+PHblNeNz6KQb32sUXEaAzlJo=
X-Received: by 2002:a05:651c:19aa:b0:2df:b2d5:590d with SMTP id
 bx42-20020a05651c19aa00b002dfb2d5590dmr210362ljb.10.1714495569815; Tue, 30
 Apr 2024 09:46:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240422152500.1.I8939e49084a6fef78496eb73edafdf3c2c4afbf4@changeid>
 <CABBYNZLCjrJUiVzNf53XYM-ZHWL6TZD4yFNtNGOuYi=6s5Q+OA@mail.gmail.com>
 <CAJQfnxHUW+MdJUp9VCrF2Nq_-JZrd7mKBR9NdDoo0SOvgH5WUQ@mail.gmail.com> <CANFp7mU2Chj_cZ_26kfM8TE1OToZzUeFKz61D7j-0ykMBQeG4A@mail.gmail.com>
In-Reply-To: <CANFp7mU2Chj_cZ_26kfM8TE1OToZzUeFKz61D7j-0ykMBQeG4A@mail.gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 30 Apr 2024 12:45:57 -0400
Message-ID: <CABBYNZJK6zyYYmi66prKMdF69HkwfhOvMeB0TnEcGYRLTTr2jw@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: btusb: Add debugfs to force toggling remote wakeup
To: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Cc: Archie Pusaka <apusaka@google.com>, linux-bluetooth <linux-bluetooth@vger.kernel.org>, 
	Johan Hedberg <johan.hedberg@gmail.com>, Marcel Holtmann <marcel@holtmann.org>, 
	CrosBT Upstreaming <chromeos-bluetooth-upstreaming@chromium.org>, 
	Archie Pusaka <apusaka@chromium.org>, Abhishek Pandit-Subedi <abhishekpandit@google.com>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Abhishek,

On Fri, Apr 26, 2024 at 1:04=E2=80=AFPM Abhishek Pandit-Subedi
<abhishekpandit@chromium.org> wrote:
>
> On Fri, Apr 26, 2024 at 2:08=E2=80=AFAM 'Archie Pusaka' via ChromeOS Blue=
tooth
> Upstreaming <chromeos-bluetooth-upstreaming@chromium.org> wrote:
> >
> > Hi Luiz,
> >
> > On Thu, 25 Apr 2024 at 03:05, Luiz Augusto von Dentz
> > <luiz.dentz@gmail.com> wrote:
> > >
> > > Hi Archie,
> > >
> > > On Mon, Apr 22, 2024 at 3:25=E2=80=AFAM Archie Pusaka <apusaka@google=
com> wrote:
> > > >
> > > > From: Archie Pusaka <apusaka@chromium.org>
> > > >
> > > > Sometimes we want the controller to not wake the host up, e.g. to
> > > > save the battery. Add some debugfs knobs to force the wake by BT
> > > > behavior.
> > > >
> > > > Signed-off-by: Archie Pusaka <apusaka@chromium.org>
> > > > Reviewed-by: Abhishek Pandit-Subedi <abhishekpandit@google.com>
> > > >
> > > > ---
> > > >
> > > >  drivers/bluetooth/btusb.c | 19 +++++++++++++++++++
> > > >  1 file changed, 19 insertions(+)
> > > >
> > > > diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> > > > index 8bede0a335668..846b15fc3c04c 100644
> > > > --- a/drivers/bluetooth/btusb.c
> > > > +++ b/drivers/bluetooth/btusb.c
> > > > @@ -873,6 +873,9 @@ struct btusb_data {
> > > >         unsigned cmd_timeout_cnt;
> > > >
> > > >         struct qca_dump_info qca_dump;
> > > > +
> > > > +       bool force_enable_remote_wake;
> > > > +       bool force_disable_remote_wake;
> > > >  };
> > > >
> > > >  static void btusb_reset(struct hci_dev *hdev)
> > > > @@ -4596,6 +4599,10 @@ static int btusb_probe(struct usb_interface =
*intf,
> > > >
> > > >         debugfs_create_file("force_poll_sync", 0644, hdev->debugfs,=
 data,
> > > >                             &force_poll_sync_fops);
> > > > +       debugfs_create_bool("force_enable_remote_wake", 0644, hdev-=
>debugfs,
> > > > +                           &data->force_enable_remote_wake);
> > > > +       debugfs_create_bool("force_disable_remote_wake", 0644, hdev=
->debugfs,
> > > > +                           &data->force_disable_remote_wake);
> > > >
> > > >         return 0;
> > > >
> > > > @@ -4702,6 +4709,18 @@ static int btusb_suspend(struct usb_interfac=
e *intf, pm_message_t message)
> > > >                 }
> > > >         }
> > > >
> > > > +       if (!PMSG_IS_AUTO(message)) {
> > > > +               if (data->force_enable_remote_wake) {
> > > > +                       data->udev->do_remote_wakeup =3D 1;
> > > > +                       if (test_bit(BTUSB_WAKEUP_AUTOSUSPEND, &dat=
a->flags))
> > > > +                               data->udev->reset_resume =3D 0;
> > > > +               } else if (data->force_disable_remote_wake) {
> > > > +                       data->udev->do_remote_wakeup =3D 0;
> > > > +                       if (test_bit(BTUSB_WAKEUP_AUTOSUSPEND, &dat=
a->flags))
> > > > +                               data->udev->reset_resume =3D 1;
> > > > +               }
> > > > +       }
> > > > +
> > > >         return 0;
> > > >  }
> > > >
> > > > --
> > > > 2.44.0.769.g3c40516874-goog
> > >
> > > There is a D-Bus interface available to overwrite the wakeup setting:
> > >
> > > https://github.com/bluez/bluez/blob/master/doc/org.bluez.Device.rst#b=
oolean-wakeallowed-readwrite
> > >
> > > Or do you want a master switch for it? On the other hand aren't we
> > > getting into the rfkill area if you really want to switch off radio
> > > activity while suspended? That seems like a better idea then just
> > > disable remote wakeup.
>
> This DBUS api is different from the quirk this is introducing.
>
> The `Wake Allowed` field in D-bus controls whether we add the address
> to the Classic Event Filter (HIDP) or LE Filter Accept List (HOGP) but
> not whether we allow wake at the transport level (which is why
> hdev->wakeup exists).
>
> This change specifically addresses a quirk with Realtek chipsets:
> RTL8822/RTL8852 will do "global shutdown" and power off Bluetooth if
> USB Remote Wake bit is not set. The USB remote_wake bit is normally
> set by the USB stack based on whether device_may_wakeup(udev) =3D=3D true=
.
> This means that RTL88x2 will lose power around suspend/resume if there
> are no wake capable devices connected.
>
> ChromeOS decided to use idle power and resume-time to determine
> whether to allow remote wake or not for these chipsets and we want to
> move this control to userspace so that we don't have to hold CHROMIUM
> patches in the kernel applying this policy (we want udev rules
> instead). RTL8852 gets force enabled remote wake because the
> RESET_RESUME behavior of this chip would otherwise increase our resume
> time >1s which breaks one of our platform requirements.
>
> The end-goal of these changes:
> * We detect RTL8822 or RTL8852 with udev and apply the right policy.
> * RTL8822 gets force_disable_remote_wake (idle power consumption too
> high otherwise)
> * RTL8852 gets force_enable_remote_wake (resume time too long otherwise)

Got it, but the suggestion was to instead of using
force_enable_remote_wake, which is sort of non-standard, why don't
Chrome OS simply use rkill interface to tell the driver to shutdown?
On resume then you can just unblock via rfkill that should have the
same result as using force_enable_remote_wake, well except if there is
a bug in the driver that is not handling rfkill as a 'global
shutdown', but then you need to fix the driver not introduce yet
another debugfs entry to bypass it.

> Hope this provides enough context for why this change is necessary.
>
> >
> > Yes, the initial idea was a master switch.
> > Thanks for your suggestions.
> > Let me discuss it with Abhishek.
> > >
> > > --
> > > Luiz Augusto von Dentz
> >
> > Thanks,
> > Archie
> >
> > --
> > You received this message because you are subscribed to the Google Grou=
ps "ChromeOS Bluetooth Upstreaming" group.
> > To unsubscribe from this group and stop receiving emails from it, send =
an email to chromeos-bluetooth-upstreaming+unsubscribe@chromium.org.
> > To post to this group, send email to chromeos-bluetooth-upstreaming@chr=
omium.org.
> > To view this discussion on the web visit https://groups.google.com/a/ch=
romium.org/d/msgid/chromeos-bluetooth-upstreaming/CAJQfnxHUW%2BMdJUp9VCrF2N=
q_-JZrd7mKBR9NdDoo0SOvgH5WUQ%40mail.gmail.com.



--=20
Luiz Augusto von Dentz


Return-Path: <linux-kernel+bounces-165608-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F2D568B8E89
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 18:52:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 21CC11C21394
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 16:52:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 169A111CAB;
	Wed,  1 May 2024 16:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l9Dndnjt"
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24109748D;
	Wed,  1 May 2024 16:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714582349; cv=none; b=IyN+1TEr75zHy91uC1Geg391aIWexew2ENolQW20krVLrb4JNU1P2B+x6vUKtZNLUsmzGAetkCQzCuyH1zTE0sQ8TFadxUXqJcjIKMytKkc7XGSe8wk7xsvnhPcVrengs6uzpYx5LF88NGIlJBpWFnVP8T6n02xrgbsOQDOYkiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714582349; c=relaxed/simple;
	bh=2EnY6jlUJdwfnq9vKIeMfPfdmHIS1mOXct0+S+bKfOM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Wh0eX6qWz0kJXy313ZCGGjvXlCInyk0nbc19INGsJ2beyebi7gsNmpNlId+M9C7CZARnbHVMMslgUcH6HltREc1xOdKVkEiX8kgf7FAEeXWMIfofmXn/08CrFnZmAC46lR2L3p5x/3W3mplB2Xzz1WX+cTNvOdejrxGBHKrxWo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l9Dndnjt; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2e1c09eff95so33021fa.1;
        Wed, 01 May 2024 09:52:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714582345; x=1715187145; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ERfpwxgCZf+sBZVMcgjD4HYC9mmOkZ9NslkItmGclBI=;
        b=l9DndnjtH92aVIp0VCLSjTWqC9782DQDkRJFbByVbiQa3nDrVpg2rWl0AY/XYBAQLg
         QUGBuLHLu9fMGP5QFVP0zDlDFjy2TFTBwPd3+EhSJ9S3F72xoHyAph4tuKPdSBjYOgTj
         3Jh2F1uwhQ5rijbljlwaQM2HU1pxEhmhVhgIJDQt4/4GWXGVPLsqxQYZb1vYB3+xs5zj
         T4mMWGJ36pnFdzD58GPq5ISpOaHKrpFKOrAEXspEvL1zUs51VzPwiQSju87JAD+vk39A
         YuW/XpGYNie6Tmqh3mlqXPWnoMHBv+a+3vvK5JmnvuXqIs9BasKEXky4wxnUuAFRSJWZ
         a+1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714582345; x=1715187145;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ERfpwxgCZf+sBZVMcgjD4HYC9mmOkZ9NslkItmGclBI=;
        b=lS4O2kfgsShkxjH5zx/6w+YGV2eJ3nSvrREOUivee5OPqNOVq6sj0j23JXFYYLkwnj
         219OUtaVwWrWvinkfbzalvoyPdM4HIjyE7AeXqyzVwo7uaJfULzPVR/dGdS5IPf03Eha
         6gk9PyoCVW0siDmrU2OMa1IZn1zMHQpr4oVar2L4pqdjiFfRtM2rojHYfayZj71zLfff
         vci8MTowQR5hqNTkJKvjexfJuF/h4kGt/V8UEBdGplhwEjE3zre3Z1U66WIYzcxMhYAY
         nqj49rE+Wht/2wsUsaoIxe55mE/uYfxFf9r4QgLn5Xkb9c4qSxqby6Lr3XCgv5XPaJev
         bCuQ==
X-Forwarded-Encrypted: i=1; AJvYcCXh5rtHMEgrY27ET1WARZirxvX/tRGyVDLaZGNzCLqa6AcjHDN+w9bPEfiMcYcD2tNwk0mjBr7U2IdoMr50ndHELt9ZJu3ITZrupAj+Q99WchOvR4hZtRRLvQLoGrQthdYVOXmOZsx1yiHuH3tI
X-Gm-Message-State: AOJu0YwQLdC+qZUM3S2yckgL58zbkjpzO50IczvEzR84OIcEPsMagI1v
	T6ZVtHMkwxfFNkp8OfstmA2eKdodxgeR+WPMeyYymkStvGGVftnt52fUQbaRDgwsZBk0hZ+SWVE
	GypmepnUeoBuG8Y0A/ivOOfT2Ag4=
X-Google-Smtp-Source: AGHT+IFFxpObw475ZTfxnUpPYNyknx7u3fyI1szOE6lb5MxCpukdzbx2u1R923UOhURn8q+hYfQ6fKafUowytSLdlKE=
X-Received: by 2002:a2e:9e58:0:b0:2e1:a40b:af28 with SMTP id
 g24-20020a2e9e58000000b002e1a40baf28mr56752ljk.18.1714582344911; Wed, 01 May
 2024 09:52:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240422152500.1.I8939e49084a6fef78496eb73edafdf3c2c4afbf4@changeid>
 <CABBYNZLCjrJUiVzNf53XYM-ZHWL6TZD4yFNtNGOuYi=6s5Q+OA@mail.gmail.com>
 <CAJQfnxHUW+MdJUp9VCrF2Nq_-JZrd7mKBR9NdDoo0SOvgH5WUQ@mail.gmail.com>
 <CANFp7mU2Chj_cZ_26kfM8TE1OToZzUeFKz61D7j-0ykMBQeG4A@mail.gmail.com>
 <CABBYNZJK6zyYYmi66prKMdF69HkwfhOvMeB0TnEcGYRLTTr2jw@mail.gmail.com> <CANFp7mWWYmm9gPrsDBho3sDGu5q_fQztR+LJJUWQ_Faw0QRXFQ@mail.gmail.com>
In-Reply-To: <CANFp7mWWYmm9gPrsDBho3sDGu5q_fQztR+LJJUWQ_Faw0QRXFQ@mail.gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 1 May 2024 12:52:12 -0400
Message-ID: <CABBYNZLtDc2MVh8f=2vLK6czfiz8wN=940exiw+fDv-fkNkqJA@mail.gmail.com>
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

On Wed, May 1, 2024 at 12:34=E2=80=AFPM Abhishek Pandit-Subedi
<abhishekpandit@chromium.org> wrote:
>
> On Tue, Apr 30, 2024 at 9:46=E2=80=AFAM Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
> >
> > Hi Abhishek,
> >
> > On Fri, Apr 26, 2024 at 1:04=E2=80=AFPM Abhishek Pandit-Subedi
> > <abhishekpandit@chromium.org> wrote:
> > >
> > > On Fri, Apr 26, 2024 at 2:08=E2=80=AFAM 'Archie Pusaka' via ChromeOS =
Bluetooth
> > > Upstreaming <chromeos-bluetooth-upstreaming@chromium.org> wrote:
> > > >
> > > > Hi Luiz,
> > > >
> > > > On Thu, 25 Apr 2024 at 03:05, Luiz Augusto von Dentz
> > > > <luiz.dentz@gmail.com> wrote:
> > > > >
> > > > > Hi Archie,
> > > > >
> > > > > On Mon, Apr 22, 2024 at 3:25=E2=80=AFAM Archie Pusaka <apusaka@go=
ogle.com> wrote:
> > > > > >
> > > > > > From: Archie Pusaka <apusaka@chromium.org>
> > > > > >
> > > > > > Sometimes we want the controller to not wake the host up, e.g. =
to
> > > > > > save the battery. Add some debugfs knobs to force the wake by B=
T
> > > > > > behavior.
> > > > > >
> > > > > > Signed-off-by: Archie Pusaka <apusaka@chromium.org>
> > > > > > Reviewed-by: Abhishek Pandit-Subedi <abhishekpandit@google.com>
> > > > > >
> > > > > > ---
> > > > > >
> > > > > >  drivers/bluetooth/btusb.c | 19 +++++++++++++++++++
> > > > > >  1 file changed, 19 insertions(+)
> > > > > >
> > > > > > diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btus=
b.c
> > > > > > index 8bede0a335668..846b15fc3c04c 100644
> > > > > > --- a/drivers/bluetooth/btusb.c
> > > > > > +++ b/drivers/bluetooth/btusb.c
> > > > > > @@ -873,6 +873,9 @@ struct btusb_data {
> > > > > >         unsigned cmd_timeout_cnt;
> > > > > >
> > > > > >         struct qca_dump_info qca_dump;
> > > > > > +
> > > > > > +       bool force_enable_remote_wake;
> > > > > > +       bool force_disable_remote_wake;
> > > > > >  };
> > > > > >
> > > > > >  static void btusb_reset(struct hci_dev *hdev)
> > > > > > @@ -4596,6 +4599,10 @@ static int btusb_probe(struct usb_interf=
ace *intf,
> > > > > >
> > > > > >         debugfs_create_file("force_poll_sync", 0644, hdev->debu=
gfs, data,
> > > > > >                             &force_poll_sync_fops);
> > > > > > +       debugfs_create_bool("force_enable_remote_wake", 0644, h=
dev->debugfs,
> > > > > > +                           &data->force_enable_remote_wake);
> > > > > > +       debugfs_create_bool("force_disable_remote_wake", 0644, =
hdev->debugfs,
> > > > > > +                           &data->force_disable_remote_wake);
> > > > > >
> > > > > >         return 0;
> > > > > >
> > > > > > @@ -4702,6 +4709,18 @@ static int btusb_suspend(struct usb_inte=
rface *intf, pm_message_t message)
> > > > > >                 }
> > > > > >         }
> > > > > >
> > > > > > +       if (!PMSG_IS_AUTO(message)) {
> > > > > > +               if (data->force_enable_remote_wake) {
> > > > > > +                       data->udev->do_remote_wakeup =3D 1;
> > > > > > +                       if (test_bit(BTUSB_WAKEUP_AUTOSUSPEND, =
&data->flags))
> > > > > > +                               data->udev->reset_resume =3D 0;
> > > > > > +               } else if (data->force_disable_remote_wake) {
> > > > > > +                       data->udev->do_remote_wakeup =3D 0;
> > > > > > +                       if (test_bit(BTUSB_WAKEUP_AUTOSUSPEND, =
&data->flags))
> > > > > > +                               data->udev->reset_resume =3D 1;
> > > > > > +               }
> > > > > > +       }
> > > > > > +
> > > > > >         return 0;
> > > > > >  }
> > > > > >
> > > > > > --
> > > > > > 2.44.0.769.g3c40516874-goog
> > > > >
> > > > > There is a D-Bus interface available to overwrite the wakeup sett=
ing:
> > > > >
> > > > > https://github.com/bluez/bluez/blob/master/doc/org.bluez.Device.r=
st#boolean-wakeallowed-readwrite
> > > > >
> > > > > Or do you want a master switch for it? On the other hand aren't w=
e
> > > > > getting into the rfkill area if you really want to switch off rad=
io
> > > > > activity while suspended? That seems like a better idea then just
> > > > > disable remote wakeup.
> > >
> > > This DBUS api is different from the quirk this is introducing.
> > >
> > > The `Wake Allowed` field in D-bus controls whether we add the address
> > > to the Classic Event Filter (HIDP) or LE Filter Accept List (HOGP) bu=
t
> > > not whether we allow wake at the transport level (which is why
> > > hdev->wakeup exists).
> > >
> > > This change specifically addresses a quirk with Realtek chipsets:
> > > RTL8822/RTL8852 will do "global shutdown" and power off Bluetooth if
> > > USB Remote Wake bit is not set. The USB remote_wake bit is normally
> > > set by the USB stack based on whether device_may_wakeup(udev) =3D=3D =
true.
> > > This means that RTL88x2 will lose power around suspend/resume if ther=
e
> > > are no wake capable devices connected.
> > >
> > > ChromeOS decided to use idle power and resume-time to determine
> > > whether to allow remote wake or not for these chipsets and we want to
> > > move this control to userspace so that we don't have to hold CHROMIUM
> > > patches in the kernel applying this policy (we want udev rules
> > > instead). RTL8852 gets force enabled remote wake because the
> > > RESET_RESUME behavior of this chip would otherwise increase our resum=
e
> > > time >1s which breaks one of our platform requirements.
> > >
> > > The end-goal of these changes:
> > > * We detect RTL8822 or RTL8852 with udev and apply the right policy.
> > > * RTL8822 gets force_disable_remote_wake (idle power consumption too
> > > high otherwise)
> > > * RTL8852 gets force_enable_remote_wake (resume time too long otherwi=
se)
> >
> > Got it, but the suggestion was to instead of using
> > force_enable_remote_wake, which is sort of non-standard, why don't
> > Chrome OS simply use rkill interface to tell the driver to shutdown?
> > On resume then you can just unblock via rfkill that should have the
> > same result as using force_enable_remote_wake, well except if there is
> > a bug in the driver that is not handling rfkill as a 'global
> > shutdown', but then you need to fix the driver not introduce yet
> > another debugfs entry to bypass it.
>
> Did you mean `force_disable_remote_wake`? rfkill will work for that
> around system suspend. We preferred not to do it because we don't use
> userspace suspend signals with Bluez today (preferring the kernel
> suspend notifier).

Yeah, that said rfkill has nothing to do with suspend afaik, it is
more for achieving flight mode and as far I know it is a kernel
interface.

> `force_enable_remote_wake` still needs debugfs as rfkill can't force
> an interface to stay awake as far as I know.

You mixing up, Im not saying to use rfkill to enable/disable wake
support, the remains the same, what changes is that if you want to
overwrite that it just use rfkill to block the traffic while suspended
that way wake being enable or not doesn't matter since the controller
radio shall be off if it is blocked.

>
> >
> > > Hope this provides enough context for why this change is necessary.
> > >
> > > >
> > > > Yes, the initial idea was a master switch.
> > > > Thanks for your suggestions.
> > > > Let me discuss it with Abhishek.
> > > > >
> > > > > --
> > > > > Luiz Augusto von Dentz
> > > >
> > > > Thanks,
> > > > Archie
> > > >
> > > > --
> > > > You received this message because you are subscribed to the Google =
Groups "ChromeOS Bluetooth Upstreaming" group.
> > > > To unsubscribe from this group and stop receiving emails from it, s=
end an email to chromeos-bluetooth-upstreaming+unsubscribe@chromium.org.
> > > > To post to this group, send email to chromeos-bluetooth-upstreaming=
@chromium.org.
> > > > To view this discussion on the web visit https://groups.google.com/=
a/chromium.org/d/msgid/chromeos-bluetooth-upstreaming/CAJQfnxHUW%2BMdJUp9VC=
rF2Nq_-JZrd7mKBR9NdDoo0SOvgH5WUQ%40mail.gmail.com.
> >
> >
> >
> > --
> > Luiz Augusto von Dentz



--=20
Luiz Augusto von Dentz


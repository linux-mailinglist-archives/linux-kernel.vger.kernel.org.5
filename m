Return-Path: <linux-kernel+bounces-24789-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9520682C291
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 16:11:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ACF3C1C21745
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 15:11:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5857C6EB45;
	Fri, 12 Jan 2024 15:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jJ2LKk2z"
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C820A6E2DD
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 15:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2cd65f803b7so51781871fa.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 07:11:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1705072259; x=1705677059; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m8c0Yp8f31j184o5cUbwQWo/MTPb1ianU9ZhYeuFp4g=;
        b=jJ2LKk2zk58ZjYzdWek3/MqJ+ECuqnAv7L0SV9af47m4fL083rY4cr1+XfCY3ZALdW
         uICDGoc/iSNknvbYhsjORaK5cV86mWO0Ah6AmPu1qflmbjPEe232hEKFKpUBpNyO2P7z
         pRvRS2prttM/9HJmXDchsIwVoOEYTZ6TawxDM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705072259; x=1705677059;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m8c0Yp8f31j184o5cUbwQWo/MTPb1ianU9ZhYeuFp4g=;
        b=k5hs9MhtbT5ktANuirg+eK59elktb9AVM1lNfL+gcJ92R5uDEZdOeBAYkiHYqhcg86
         fVufgwmZeDjqjxQ1AWliwCACajXhN/BfO/JH9WcFuibc1a/pN1j42/tYw0ePQClfwDpT
         GetugxAdurXo3QEKufViQKflz2sGtr5VKznB/VMP2cxJYgG7J9S35J0qRiOqg77kJu5x
         w2fuDkdlCCY2s63HUcuw72ngV4g5evkXNpBOttqeY3bAPHkCyYFWmZIkct8PAFls2+AI
         K0ZoVaNPZUrj1md4HSzsZ1vrZU3xOZYdciUZQDBn0hBXrQQ6uTRABQ9e366c9bw/RmeE
         vNug==
X-Gm-Message-State: AOJu0YzEuttryN0dhN+MasDxHeUuqdksOQGlllYdqzaKzLmpFRECu2Hw
	iRkU7v5xbKDoWFLd+CLBAkD9MBelgkS71hGpWw6jVmOAzX/B
X-Google-Smtp-Source: AGHT+IFVqzLLyGjfjk6nnLC3w+i9qs6a1PIOYb3Rbvq7LQ9cGpykngvg24amtaGcWL+WtHprES5E8k5fF/aD0XZ/UHw=
X-Received: by 2002:a2e:88d5:0:b0:2cc:5cd5:9664 with SMTP id
 a21-20020a2e88d5000000b002cc5cd59664mr771610ljk.95.1705072258713; Fri, 12 Jan
 2024 07:10:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230925163313.1.I55bfb5880d6755094a995d3ae44c13810ae98be4@changeid>
 <ZWF76ALANQwP_9b1@google.com> <CALNJtpUHHaq6g0wSuyaNBxtOE9kt6vDzdAGGu6j=JJdJmerDWQ@mail.gmail.com>
 <ZZ2eduF_h7lcBrSL@google.com> <CALNJtpWr0h+r3=R2scxyCGzgbZ1C6FiYrCGWW1_aSVPBdmNc3Q@mail.gmail.com>
 <005a6d3c-ffba-45df-bdc0-cb2d32e6b676@redhat.com>
In-Reply-To: <005a6d3c-ffba-45df-bdc0-cb2d32e6b676@redhat.com>
From: Jonathan Denose <jdenose@chromium.org>
Date: Fri, 12 Jan 2024 09:10:47 -0600
Message-ID: <CALNJtpUrevm6YXZjG=37H4vs4_1RbHsO6BgsoQbUjZQHzpSOJA@mail.gmail.com>
Subject: Re: [PATCH] Input: i8042 - add quirk for Lenovo ThinkPad T14 Gen 1
To: Hans de Goede <hdegoede@redhat.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, 
	Jonathan Denose <jdenose@google.com>, Huacai Chen <chenhuacai@kernel.org>, 
	Mattijs Korpershoek <mkorpershoek@baylibre.com>, Takashi Iwai <tiwai@suse.de>, 
	Werner Sembach <wse@tuxedocomputers.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hans,

On Thu, Jan 11, 2024 at 4:48=E2=80=AFAM Hans de Goede <hdegoede@redhat.com>=
 wrote:
>
> Hi Jonathan,
>
> On 1/11/24 00:42, Jonathan Denose wrote:
> > Dmitry,
> >
> > Sorry I forgot to reply all, so I'm resending my other email.
> >
> > On Tue, Jan 9, 2024 at 1:28=E2=80=AFPM Dmitry Torokhov
> > <dmitry.torokhov@gmail.com> wrote:
> >>
> >> Hi Jonathan,
> >>
> >> On Mon, Nov 27, 2023 at 10:38:57AM -0600, Jonathan Denose wrote:
> >>> Hi Dmitry
> >>>
> >>> On Fri, Nov 24, 2023 at 10:45=E2=80=AFPM Dmitry Torokhov
> >>> <dmitry.torokhov@gmail.com> wrote:
> >>>>
> >>>> Hi Jonathan,
> >>>>
> >>>> On Mon, Sep 25, 2023 at 04:33:20PM -0500, Jonathan Denose wrote:
> >>>>> The ThinkPad T14 Gen 1 touchpad works fine except that clicking
> >>>>> and dragging by tapping the touchpad or depressing the touchpad
> >>>>> do not work. Disabling PNP for controller setting discovery enables
> >>>>> click and drag without negatively impacting other touchpad features=
.
> >>>>
> >>>> I would like to understand more on how enabling PnP discovery for i8=
042
> >>>> affects the touchpad. Do you see it using different interrupt or IO
> >>>> ports? What protocol does the touchpad use with/without PnP? If the
> >>>> protocol is the same, do you see difference in the ranges (pressure,
> >>>> etc) reported by the device?
> >>>>
> >>>> Thanks.
> >>>>
> >>>> --
> >>>> Dmitry
> >>>
> >>> Without PnP discovery the touchpad is using the SynPS/2 protocol, wit=
h
> >>> PnP discovery, the touchpad is using the rmi4 protocol. Since the
> >>> protocols are different, so are the ranges but let me know if you
> >>> still want to see them.
> >>
> >> Thank you for this information. So it is not PnP discovery that appear=
s
> >> harmful in your case, but rather that legacy PS/2 mode appears to be
> >> working better than RMI4 for the device in question.
> >>
> >> I will note that the original enablement of RMI4 for T14 was done by
> >> Hans in [1]. Later T14 with AMD were added to the list of devices that
> >> should use RMI4 [2], however this was reverted in [3].
> >>
> >> Could you please tell me what exact device you are dealing with? What'=
s
> >> it ACPI ID?
> >>
> >> [1] https://lore.kernel.org/all/20201005114919.371592-1-hdegoede@redha=
t.com/
> >> [2] https://lore.kernel.org/r/20220318113949.32722-1-snafu109@gmail.co=
m
> >> [3] https://lore.kernel.org/r/20220920193936.8709-1-markpearson@lenovo=
com
> >>
> >> Thanks.
> >>
> >> --
> >> Dmitry
> >
> > Thanks for your reply!
> >
> > I'm not 100% sure which of these is the ACPI ID, but from `udevadm
> > info -e` there's:
> > N: Name=3D"Synaptics TM3471-020"
> > P: Phys=3Drmi4-00/input0
>
> To get the ACPI ID you need to run e.g. :``
>
> cat /sys/bus/serio/devices/serio1/firmware_id
>
> After reading the original bug report again I take back my
> Reviewed-by and I'm tending towards a nack for this.
>
> Jonathan upon re-reading things I think that your problem
> is more a case of user space mis-configuration then
> a kernel problem.
>
> You mention both tap-n-drag not working as well as click+drag
> not working.
>
> tap-n-drag is purely done in userspace and typically only
> works if tap-to-click is enabled in the touchpad configuration
> of your desktop environment.
>
> Click + drag requires you to use the bottom of the touchpad
> (the only part which actually clicks) as if there still were
> 2 physical buttons there and then click the touchpad down
> with 1 finger till it clicks and then drags with another
> finger (you can click+drag with one finger but the force
> required to keep the touchpad clicked down while dragging
> makes this uncomfortable to do).
>
> This will likely also only work if the mouse click emulation
> mode is set to "area" and not "fingers" with "fingers" being
> the default now. In GNOME you can configure
> the "click emulation mode" in the "tweaks" tools under
> "mouse & touchpad" (and tap to click is in the normal
> settings menu / control panel).
>
> If you have the click emulations set to fingers and
> then do the click with 1 finger + drag with another
> finger thing, I think the drag will turn into a
> right button drag instead of a left button drag which
> is likely why this is not working.
>
> You can check which mode you are in by seeing how
> you right click. If you right-click by pressing down
> in the right bottom corner of the touchpad then
> your userspace (libinput) config is set to areas,
> if you can right click anywhere by pressing down
> with 2 fingers at once then your click emulation
> is in fingers mode and this is likely why click-n-drag
> is not working.
>
> I have just dug up my T14 gen1 (Intel) and updated it
> to kernel 6.6.11 to rule out kernel regressions.
>
> And both click-n-drag and tap-n-drag (double-tap then
> drag) both work fine there with a touchpad with
> an ACPI id of LEN2068 as shown by
> cat /sys/bus/serio/devices/serio1/firmware_id
>
> (with the Desktop Environment configured for bottom
> area click emulation and tap-to-click enabled)
>
> As for why changing things back to synps2 works,
> I don't know. One guess is that you already configured
> the touchpad behavior of your desktop environment to
> your liking in the past and your desktop environment
> has remembered this only for the input device-name
> which is used in SynPS/2 mode and the different
> input device-name in RMI4 mode in new (new-ish)
> kernels causes the desktop environment to use
> default settings which are typically "fingers"
> click emulation and tap-to-click disabled.
>
> This can e.g. also happen if you have moved your
> disk (contents) over from an older machine. IIRC
> the SynPS/2 driver always used the same input
> device-name where as with RMI4 the name is tied
> to the actual laptop model.
>
> Regards,
>
> Hans
>
>

Thank you for your thorough reply. Based on what you've written, I
agree this sounds more like a user-space issue than a kernel issue. At
least that narrows it down for me, so I'll take a look at what could
be misconfigured in user-space.

Thanks so much for your help!
Jonathan


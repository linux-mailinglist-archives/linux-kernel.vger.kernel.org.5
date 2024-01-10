Return-Path: <linux-kernel+bounces-22604-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 436C982A04F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 19:34:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BD8F9B25DA0
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 18:34:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C9114D13B;
	Wed, 10 Jan 2024 18:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FMGBdkCd"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8EC81E4A6
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 18:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-557535489d0so5196932a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 10:34:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1704911682; x=1705516482; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h+79PBe1CaM3kL/+sGAaA8TQXREzbo/JCsExVphnqkI=;
        b=FMGBdkCdEs2wMT13KMcwWPv17EpuhZNsOyUmlaiWdMqRP+uqZYWvlqyHCDEN8nn1wZ
         B5r1umd+1bw95zhaBCXgTOKZt0/p/Kr6RgRKlLc9lBYY/7YCgeKG27bpA4NNkXB/dkja
         7/i3trOn1RIsHctNEvSRQwrZiCBhn6tbOB59A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704911682; x=1705516482;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h+79PBe1CaM3kL/+sGAaA8TQXREzbo/JCsExVphnqkI=;
        b=M1lAvBSZvvRDq+w7YQZMMjU7pjm9ko7XoT44vHpDvHcfxnQfH0vbAnJaFZhVOqDACs
         9nWRwAMF7rbMTFA81In7kwCdDUVeHoAPpQs+lMPPiKzHdlE3ixbHJbjOGE5Pf5yvRfVP
         8FRXLiL6Q8TSCmeTMGA/+CaWbuRK7k70wDHzo1Nm4GT7yKy39W0dVccwW+hJ3sy5dD2h
         nSBtYw+DzDfmiWSwFU3zea+2kGLkwMLlrwY4Vr13pQxBO9rYquOsqiKHg2R9hYsBvz0T
         SCv/l3UyWWGwKO597OpxWO+kdWL8wR91euTD+NkcMzQaZtmVkfSsyBtPo5kvZ8keHal2
         DxQQ==
X-Gm-Message-State: AOJu0YysQLoEu6NlfpsKhfYtsaVNkdClK7j8LQx1RXxQiqhXBwcvvxHy
	KXAVk3smb/MRRepYABfzC0iUUMZBMQlmJ4wyGvtM0OtKDl8LhO4=
X-Google-Smtp-Source: AGHT+IH3vx0er/dsL7RrZfuowWhy9N5xwrYGMGAyfC2fJQaKC6G6A8z0wJ5mlex31jaGSyIjf2OuGw==
X-Received: by 2002:a50:aa9b:0:b0:557:e00f:a499 with SMTP id q27-20020a50aa9b000000b00557e00fa499mr617796edc.78.1704911681875;
        Wed, 10 Jan 2024 10:34:41 -0800 (PST)
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com. [209.85.208.47])
        by smtp.gmail.com with ESMTPSA id x17-20020aa7d391000000b00556cf695da0sm2219373edq.78.2024.01.10.10.34.41
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Jan 2024 10:34:41 -0800 (PST)
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-553e36acfbaso891a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 10:34:41 -0800 (PST)
X-Received: by 2002:aa7:cd70:0:b0:557:1142:d5bb with SMTP id
 ca16-20020aa7cd70000000b005571142d5bbmr12737edb.4.1704911680835; Wed, 10 Jan
 2024 10:34:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240103003355.747335-1-kai.heng.feng@canonical.com>
 <CAD=FV=VmGNB5dP5WO7=txNDScNfhCDEsfFFivXqz+PH6rt=x8g@mail.gmail.com> <CAAd53p4gPkbDyNLiYGtcvqWwEgBqVhri+qgh+=Ha0xsVfYy92g@mail.gmail.com>
In-Reply-To: <CAAd53p4gPkbDyNLiYGtcvqWwEgBqVhri+qgh+=Ha0xsVfYy92g@mail.gmail.com>
From: Doug Anderson <dianders@chromium.org>
Date: Wed, 10 Jan 2024 10:34:23 -0800
X-Gmail-Original-Message-ID: <CAD=FV=WwCL0Z4rOMGD+i2zOTZMz6qi_Ctm_wWC2sbv0STGi8AQ@mail.gmail.com>
Message-ID: <CAD=FV=WwCL0Z4rOMGD+i2zOTZMz6qi_Ctm_wWC2sbv0STGi8AQ@mail.gmail.com>
Subject: Re: [PATCH] HID: i2c-hid: Remove SET_POWER SLEEP on system suspend
To: Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc: jikos@kernel.org, benjamin.tissoires@redhat.com, 
	Maxime Ripard <mripard@kernel.org>, =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
	Johan Hovold <johan+linaro@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Jan 9, 2024 at 11:31=E2=80=AFPM Kai-Heng Feng
<kai.heng.feng@canonical.com> wrote:
>
> > I'd also note that I'm really not sure what ChromeOS dark resume has
> > to do with anything here. Dark resume is used for certain types of
> > events that wakeup the system where we can identify that the event
> > shouldn't turn the screen on, then we do some processing, then we go
> > back to sleep. I'm nearly certain that a trackpad / touchscreen wakeup
> > event would never qualify for "dark resume". If we see a
> > trackpad/touchscreen event then we'll wakeup the system. If the system
> > is in a state where trackpad/touchscreen events shouldn't wake us up
> > then we disable those wakeups before going to suspend...
>
> Doesn't Dark Resume use wakeup count to decide whether the system
> should wake up or go back to suspend?
> For this case the input report is empty, hence wakeup count remains
> the same after the wakeup. I assumed Dark Resume will check the wakeup
> count and decide to put the system back to suspend.

Ah, I understand now. So you're saying that the issue wouldn't be so
bad (or maybe we wouldn't notice it) on systems with dark resume.
However, even with dark resume we're not in a super great shape. Doing
a dark resume isn't exactly a lightweight operation, since it can take
a bit of time to resume the system, realize that there were no wakeup
events, and then go back to sleep. I'm not a total expert on dark
resume, but I believe that even with dark resume, there may also be
artifacts that a user might notice (like perhaps USB devices powering
up or perhaps the suspend LED on the system showing that we're not in
suspend anymore).


> > It seems to me like the board you're testing on has some strange bug
> > and that bug should be fixed, or (in the worst case) you should send a
> > patch to detect this broken touchpad and disable wakeup for it.
>
> It's desired to keep the wakeup capability, disabling wakeup isn't ideal =
here.
> I'll write a patch to use touchpad specific quirk instead of applying
> the change universally.

Thanks! I'd also be curious if this is a problem for everyone with the
Cirque touchpad or if it's board-specific. I could imagine the
behavior you describe as coming about due to a missing or
misconfigured pull resistor on the IRQ line. ...or perhaps a pull
resistor pulling up to the wrong voltage rail...

-Doug


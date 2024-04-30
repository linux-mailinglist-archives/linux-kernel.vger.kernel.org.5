Return-Path: <linux-kernel+bounces-164772-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 378428B82A9
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 00:25:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 55DDC1C20D1D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 22:25:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9347D1BF6EC;
	Tue, 30 Apr 2024 22:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O4vXFDCP"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 329701BF6DA;
	Tue, 30 Apr 2024 22:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714515928; cv=none; b=EZH3UfrXuOdXMk6a9aldepyrFnNAH+uAKygKmwe60YxztbfRRVNmpUztYSHfEbfBtELxQIqTVWd8yByK6uHalSnGip6QfeGJq8nFkh8ZwyyGKtzxXdEP3pNPoUHfiMfzL7tTFWDf+mjVrp0rljx2GV+cuau2+VBaJt0jSjJFsyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714515928; c=relaxed/simple;
	bh=8wQbS0HtW1G12/bULIPofH/wDAspjZ0J1k+14mAxGV0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UHkVN62bxCJcGMrSy44rbcJXxcazFVYKWfPu3b8AN5SXeioHe5d4m0CQfxeXIb2KlJa0r9VA1nE8sq7kULigX9tep7/KHaudJF5xXjAOAQxYu0vNcxsO8evzSN7uVzVrYu1D+IzXSNuEJij57FmlR0yTLruf3cogSa91AUQhTJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O4vXFDCP; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-572a092dd2dso1354024a12.3;
        Tue, 30 Apr 2024 15:25:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714515925; x=1715120725; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bU8XHrXVaApssJUbb0fzQFt/80f/mSNrWGhMGvNJPA0=;
        b=O4vXFDCPQjsFhi301aejKJ7jYd9QV6YUDHrGbTChePv50opdSIwUzSZV5RDI/IEzJw
         A6qGtKDLnQjvkCCaaCZ1ohlkFXeQqPwj0nh7aMfge0/YZM1N2f0skiWYdqXGbqj1OH0i
         YZbnrL6UgMQIbdI/rrsEPb5VACs6gFJyiWtOeJtx7CMlpWlPg/k8/Ul+uigj0X8tTHhE
         flDmO7s9dJF1i37JgDKTyZoaDl7KenJ4MTzjyH0BA/2ZylpcuWGeTaCIR6ZjUNNOnEwN
         NYubkJChCdxffOxDc4xKOuGyxIvNSLhw9wiXGDVcC3JiHjOm5HvWy4oH/4GHLOsAaSL3
         hGwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714515925; x=1715120725;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bU8XHrXVaApssJUbb0fzQFt/80f/mSNrWGhMGvNJPA0=;
        b=ORhCBhytOLYDsmzodexwlmXhKH+vyZfQcV0mHXKcnT9ZlbUxHTMG+SwHhyo7ivjEDn
         OK5WF3cSxPOYc8wsBncQuesHQTHnOMH4WWBZ5b+6PwRZNxDa1dhptrOSpRdjwGWrAmFs
         Cq8gADjQp1z3awLPQbzNXVfZEJ9nQh75koL5ywijDRoCCosIm7ep/Ch4gCL9fXILuIYz
         DmY8GTge4WdVLmeG04Sk5RGmMYmsqSQm1FdSh96im6bvxXyNLb0UHfFKnA0LWuBWD53S
         LAMvzWf2TG6vcozf1aQ3vPEIPO3uAuRVL5vsMjy9RU/zCTMHOhJdxZJhLKPxL7wTUT3u
         RGjg==
X-Forwarded-Encrypted: i=1; AJvYcCUJVGaApomNRb2iHOOnI2guhGyBaR2zaCnWJT7m94yIPjd1/T5dfddZwxgngrtnvHW62C0/yxAwrdo1JPZL9bb3Kdze23VZOaH68wWq
X-Gm-Message-State: AOJu0YwiwzYDySkzf81XLdRvKMfkM/dOGdsJf+6dEQK1ok5SerSGmhy6
	N5tBxM404eZkQeI7IabHd1603ya1g2AvS/MqEY9qn1ecoHH8k63sLAidOPpjffByfgrOyOkm5Tu
	8OFd+VLR0dlEzOByMzKl5k/L6roPqQw==
X-Google-Smtp-Source: AGHT+IGU/W3NCpBWrMPDbOKQS6pp8kuC6a1q5Xw516sclT6WansCdO5hJ1jI8ns2L0JTPkymc3mPIKuqAvK4JwrSkB8=
X-Received: by 2002:a50:951c:0:b0:56e:2294:e2e6 with SMTP id
 u28-20020a50951c000000b0056e2294e2e6mr673539eda.26.1714515925299; Tue, 30 Apr
 2024 15:25:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZjAWMQCJdrxZkvkB@google.com> <CAKf6xpvzrCHAsbokGu_+7P0H=n4T=dsRN81msJjW6yVMcEZi6g@mail.gmail.com>
In-Reply-To: <CAKf6xpvzrCHAsbokGu_+7P0H=n4T=dsRN81msJjW6yVMcEZi6g@mail.gmail.com>
From: Jason Andryuk <jandryuk@gmail.com>
Date: Tue, 30 Apr 2024 18:25:13 -0400
Message-ID: <CAKf6xpsiLbZN=v2G052kuwPLNxmmbt4uoZAM21Zr+RtH0YD8kA@mail.gmail.com>
Subject: Re: [PATCH v2] Input: try trimming too long modalias strings
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>, 
	Benjamin Tissoires <benjamin.tissoires@redhat.com>, Peter Hutterer <peter.hutterer@who-t.net>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 29, 2024 at 9:04=E2=80=AFPM Jason Andryuk <jandryuk@gmail.com> =
wrote:
>
> On Mon, Apr 29, 2024 at 5:50=E2=80=AFPM Dmitry Torokhov
> <dmitry.torokhov@gmail.com> wrote:
> >
> > If an input device declares too many capability bits then modalias
> > string for such device may become too long and not fit into uevent
> > buffer, resulting in failure of sending said uevent. This, in turn,
> > may prevent userspace from recognizing existence of such devices.
> >
> > This is typically not a concern for real hardware devices as they have
> > limited number of keys, but happen with synthetic devices such as
> > ones created by xen-kbdfront driver, which creates devices as being
> > capable of delivering all possible keys, since it doesn't know what
> > keys the backend may produce.
> >
> > To deal with such devices input core will attempt to trim key data,
> > in the hope that the rest of modalias string will fit in the given
> > buffer. When trimming key data it will indicate that it is not
> > complete by placing "+," sign, resulting in conversions like this:
> >
> > old: k71,72,73,74,78,7A,7B,7C,7D,8E,9E,A4,AD,E0,E1,E4,F8,174,
> > new: k71,72,73,74,78,7A,7B,7C,+,
> >
> > This should allow existing udev rules continue to work with existing
> > devices, and will also allow writing more complex rules that would
> > recognize trimmed modalias and check input device characteristics by
> > other means (for example by parsing KEY=3D data in uevent or parsing
> > input device sysfs attributes).
> >
> > Note that the driver core may try adding more uevent environment
> > variables once input core is done adding its own, so when forming
> > modalias we can not use the entire available buffer, so we reduce
> > it by somewhat an arbitrary amount (96 bytes).
> >
> > Reported-by: Jason Andryuk <jandryuk@gmail.com>
> > Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
>
> Tested-by: Jason Andryuk <jandryuk@gmail.com>
>
> I don't have the gdm setup available to test, but loginctl looks good
> showing the Xen Virtual Keyboard assigned to a seat:
> # loginctl seat-status seat0
> seat0
>          Devices:
>                   =E2=94=9C=E2=94=80/sys/devices/LNXSYSTM:00/LNXPWRBN:00/=
input/input0
>                   =E2=94=82 input:input0 "Power Button"
>                   =E2=94=9C=E2=94=80/sys/devices/LNXSYSTM:00/LNXSLPBN:00/=
input/input1
>                   =E2=94=82 input:input1 "Sleep Button"
>                   =E2=94=9C=E2=94=80/sys/devices/platform/i8042/serio0/in=
put/input2
>                   =E2=94=82 input:input2 "AT Translated Set 2 keyboard"
>                   =E2=94=9C=E2=94=80/sys/devices/platform/i8042/serio1/in=
put/input4
>                   =E2=94=82 input:input4 "ImExPS/2 Generic Explorer Mouse=
"
>                   =E2=94=9C=E2=94=80/sys/devices/virtual/input/input5
>                   =E2=94=82 input:input5 "Xen Virtual Keyboard"
>                   =E2=94=82 =E2=94=94=E2=94=80/sys/devices/virtual/input/=
input5/event4
>                   =E2=94=82   input:event4
>                   =E2=94=94=E2=94=80/sys/devices/virtual/input/input6
>                     input:input6 "Xen Virtual Pointer"

What do you think about Cc: stable@vger.kernel.org?  I'd like to get
the Xen Keyboard working as widely as possible, so I'd like it
backported if possible.

Thanks,
Jason


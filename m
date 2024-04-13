Return-Path: <linux-kernel+bounces-143580-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 734178A3B11
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 07:09:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 95E311C21B92
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 05:09:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44CB51C6AF;
	Sat, 13 Apr 2024 05:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QBDZWn3N"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 117EA33EE;
	Sat, 13 Apr 2024 05:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712984936; cv=none; b=od6E46t5l5cBrloapfUu+zBEfh4yXO2GHuZW50V8maQVZMeNJMicIncwYnX/TeJ2YcJz3m02FmNUQx36dyLpo5F14JSC+eVqWiI/iXNRDbiguurVgfRInceVI9Ufbn3lB3vpbfwQqzrLCMNfpCiZwpFOZxJVs6nI6svP9SAI4Rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712984936; c=relaxed/simple;
	bh=bIQsW1CPYkILDa5kQaHHU3RJyOH+XS4wmaA2E+aT+gg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aGtySnda3HXTF1kqAck8Ia3pVe9vYHWlgNdLlASHZ3Gv3EURGL8knZefTL9cmitp4xKJ9BRPV8sFAWgHsPMg+GCekgR4aHV+llYMzn3NAqQ6xJ5NRGlP5BgLIn5MmVnzHrmhjNnD4pEqwGJI2Hga34Kn2K7pgpaJ2//Aq4Fwugw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QBDZWn3N; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a46a7208eedso211990766b.0;
        Fri, 12 Apr 2024 22:08:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712984933; x=1713589733; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5qvXKC5wSDQIOCusiNuNNePSI2BJ5XEbrAPDJxd5/Tg=;
        b=QBDZWn3N5Cn24lucqpOa/n4BaFh0xdHWx5P6f5kP6HCI4vMXIE4RgMitKTOxMW721H
         peXLcue3e3zRoz0irLGVEL/niRWBB7RGfsTMQ1ea9lRjagpid39bJrWKsW9oAqbEVkpT
         lXw2x9p1nmaDY8B7l5sw761mP/XJGYnFHXS9WLuunGIqPsrCRNEdn3Y30eNnH+L259zA
         9LB5uqE4M7E+lihqJCdbAoGhRZ55JFXhB7ToddpTlccEccpWOxhDCRKNDSF5/P3kBoRy
         K8v4nxbUky3i0GZWPeIzXSbWyJyUTLpl3vngACrYuXgTf1sysYh62J7+z7yz+COVHy2X
         jVGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712984933; x=1713589733;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5qvXKC5wSDQIOCusiNuNNePSI2BJ5XEbrAPDJxd5/Tg=;
        b=Ah6qovWUQH9rbjy5Y4MM/NY1izPZ7iulcEiQXPpBUfAGPMv6/JZImtb01TPs+LIhmH
         vrSB8O4uNGa7LzhOTKBi666wH23GXs1Bxzgo2PXW5ohBuWEPPPhWuKfG9Gvm5hqMk43h
         FUr7NmcovBP71oafBo3gh4uU6AZWjm613TX0QEm8YTSjHQmKQM2Ufh91ihzJyTEaN6zV
         HGI5f2ctb6afTgSuj7vgeKfLi794MZDBk/TOjFk/GdVuUrPI/+sbC/5umvgu6rXiD71H
         vY7S9jRkDr94XJeS6sRlMkL0+thYJ48rpiilZAON7FU7QUnRKkhgIoFmQtNir/1vDny0
         6RaA==
X-Forwarded-Encrypted: i=1; AJvYcCXZT6RtHHCYwcRmGhcX8aWLck+X+27ZbkLIXArhZ0Xcwdp6tqJYioB15J9GWlUypGTqmpWm7eVRqAvSzGEkBui1LYTG4qkmBxXv
X-Gm-Message-State: AOJu0Yyo2ghs4pJCEzTjJxpQ9q1sJM59F/7IjIZw9Wua82ZChdaR01YC
	zhjgXJURwgNs0YeuGVnrAV/wjI8t+WYrQKl0XeMkSslRrY89P3P69E+58dfYFn505Fhn5DgqpHi
	ikTihoMlp5By1FSiiWpySvQqMf2k=
X-Google-Smtp-Source: AGHT+IGKh+RYfATy6954GShJF3v9DULsqxBJRKGAlWRfY+c+BZC6LNV9ggXTF4m1a4bWYQWdBYzOINYKMo4T+B8lvtI=
X-Received: by 2002:a17:906:d54c:b0:a51:a09c:16a5 with SMTP id
 cr12-20020a170906d54c00b00a51a09c16a5mr2907887ejc.23.1712984933012; Fri, 12
 Apr 2024 22:08:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAEkJfYON+ry7xPx=AiLR9jzUNT+i_Va68ACajOC3HoacOfL1ig@mail.gmail.com>
 <92fe8e95-bc01-4d7d-9678-8cfc55cc4a7b@rowland.harvard.edu>
 <CAEkJfYORHKO16xT3DCS04JFzkquz6oZ5CdC2USJ5-c0WihAMXg@mail.gmail.com>
 <45e246ab-01e8-40b7-8ede-b47957df0d7b@rowland.harvard.edu>
 <CAEkJfYMjO+vMBGPcaLa51gjeKxFAJBrSa0t_iJUtauQD3DaK8w@mail.gmail.com> <69a6f4c9-6470-40d1-99f1-aaf532497d02@rowland.harvard.edu>
In-Reply-To: <69a6f4c9-6470-40d1-99f1-aaf532497d02@rowland.harvard.edu>
From: Sam Sun <samsun1006219@gmail.com>
Date: Sat, 13 Apr 2024 13:08:41 +0800
Message-ID: <CAEkJfYNJyyGhR9AAWc0V7o8i6pmS+OB=KSbh6XqVWAAGetS9hA@mail.gmail.com>
Subject: Re: [Linux kernel bug] general protection fault in disable_store
To: Alan Stern <stern@rowland.harvard.edu>
Cc: linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
	Greg KH <gregkh@linuxfoundation.org>, swboyd@chromium.org, ricardo@marliere.net, 
	hkallweit1@gmail.com, heikki.krogerus@linux.intel.com, 
	mathias.nyman@linux.intel.com, royluo@google.com, 
	syzkaller-bugs@googlegroups.com, xrivendell7@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 13, 2024 at 2:11=E2=80=AFAM Alan Stern <stern@rowland.harvard.e=
du> wrote:
>
> On Sat, Apr 13, 2024 at 12:26:07AM +0800, Sam Sun wrote:
> > On Fri, Apr 12, 2024 at 10:40=E2=80=AFPM Alan Stern <stern@rowland.harv=
ard.edu> wrote:
> > > I suspect the usb_hub_to_struct_hub() call is racing with the
> > > spinlock-protected region in hub_disconnect() (in hub.c).
> > >
> > > > If there is any other thing I could help, please let me know.
> > >
> > > Try the patch below.  It should eliminate that race, which hopefully
> > > will fix the problem.
>
> > I applied this patch and tried to execute several times, no more
> > kernel core dump in my environment. I think this bug is fixed by the
> > patch. But I do have one more question about it. Since it is a data
> > race bug, it has reproducibility issues originally. How can I confirm
> > if a racy bug is fixed by test? This kind of bug might still have a
> > race window but is harder to trigger. Just curious, not for this
> > patch. I think this patch eliminates the racy window.
>
> If you don't what what is racing, then testing cannot prove that a race
> is eliminated.  However, if you do know where a race occurs then it's
> easy to see how mutual exclusion can prevent the race from happening.
>
> In this case the bug might have had a different cause, something other
> than a race between usb_hub_to_struct_hub() and hub_disconnect().  If
> that's so then testing this patch would not be a definite proof that the
> bug is gone.  But if that race _is_ the cause of the bug then this patch
> will fix it -- you can see that just by reading the code with no need
> for testing.
>
> Besides, the patch is needed in any case because that race certainly
> _can_ occur.  And maybe not only on this pathway.
>

Thanks for explaining! I will check the related code next time.

> May I add your "Reported-and-tested-by:" to the patch?

Sure, thanks for your help!

Best Regards,
Yue


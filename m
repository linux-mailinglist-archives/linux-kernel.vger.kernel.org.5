Return-Path: <linux-kernel+bounces-22164-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2817B829A54
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 13:21:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7881FB23EA4
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 12:21:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A356482C6;
	Wed, 10 Jan 2024 12:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WqwrGhw2"
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AA3A3FB07;
	Wed, 10 Jan 2024 12:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-5e86fc3f1e2so36080527b3.0;
        Wed, 10 Jan 2024 04:20:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704889255; x=1705494055; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u/XOirxmS0fe3j5M8XRku3KwS+azLbDAKTxIaDOOT14=;
        b=WqwrGhw2XPa5MdOFJUuM/ttuWhal471USxxLd3ygIT/hq5Ziw1GJS8XM/YK2ugjuvs
         pq3RvDJW7HG6usLiricwvrrlPHPvdHSSsSfD7rOkT0Y+/HKhVkwErDg/fZi/zQ8uGiJZ
         zFf8Sl2L5AJ6UGkN6QP8FDn7z60P8Fd5K8IxydARoL9VLIbfuXqYFk+dtqdvGY5Y8bU0
         y9alE1QJRLGUMn9rwC8mhNV1YnXO8DlzkrBwtzKvRsLbpeXicIN6VNjXS4yEDvaN/+SB
         hVFDOPx44reBzTortPlHeYMIDVCJ5psz8MYQVMYEDE06723YzWCXWC4iG0bmnUenQkGH
         ieOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704889255; x=1705494055;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u/XOirxmS0fe3j5M8XRku3KwS+azLbDAKTxIaDOOT14=;
        b=xJU6CTm3bUlYONNkrT9AHy7c7A0/cgK+xJmxu9p9HVmxCXjB+jqDHFRJU8mhdwfmqp
         DHFvcX39ISdIpr0fqI+1Meo9whqiIzVj2NQAWwdqGRYgFt4aNaNqoFHB2Gsxj9C/1mE8
         DzwgvL4mDVbxJhmOugjrlBy6uzClac3biVe9pULq9ooU/FSWBLkE1axvtvD/WQ/8//zu
         1KHBA6/ANHcHBsucx2P4TJSlReSS1/+w61gIr/cWcPfOkfrdTBkO3E6l45iMbWHX9+p4
         YoXuX73GaSHdHZOT5Q/cjLNrzQzFrop9GveVsNN9ZBndfaKm5f/CMeweoR/ZclPteGRp
         ZwPQ==
X-Gm-Message-State: AOJu0Yyr+b/izqSXoGx1aEnHAn0A3/3xn1jjxDHmqEjH7zdYuh/ljvAA
	zGdZTjD61f5H0x1Lv6PNYG9MzPaBFgrZElnKziPM8oLu5Qw=
X-Google-Smtp-Source: AGHT+IGmh0w0a9gIrXitUOWSCXkUFS87CA4AASH+f6Om4lV3z6f70ohUq+jtlbcET5Ky3S/3zHPr/VJqX3DUHfVAUhs=
X-Received: by 2002:a81:8885:0:b0:5f1:3298:611 with SMTP id
 y127-20020a818885000000b005f132980611mr940074ywf.48.1704889255114; Wed, 10
 Jan 2024 04:20:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240109135952.77458-1-warthog618@gmail.com> <20240109135952.77458-2-warthog618@gmail.com>
 <CA+kSVo_347gS+w_7ZXFDi9qDtT1aw15qoWRJZAVSkfbHShz7kQ@mail.gmail.com>
In-Reply-To: <CA+kSVo_347gS+w_7ZXFDi9qDtT1aw15qoWRJZAVSkfbHShz7kQ@mail.gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 10 Jan 2024 14:20:18 +0200
Message-ID: <CAHp75VdQFE8aA0wmDZ6KSE8xfKptzXasQz=AdzQpSRr2gwt6wQ@mail.gmail.com>
Subject: Re: [PATCH 1/7] Documentation: gpio: add chardev userspace API documentation
To: Phil Howard <phil@gadgetoid.com>
Cc: Kent Gibson <warthog618@gmail.com>, linux-kernel@vger.kernel.org, 
	linux-gpio@vger.kernel.org, linux-doc@vger.kernel.org, brgl@bgdev.pl, 
	linus.walleij@linaro.org, andy@kernel.org, corbet@lwn.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 10, 2024 at 1:40=E2=80=AFPM Phil Howard <phil@gadgetoid.com> wr=
ote:
> On Tue, 9 Jan 2024 at 14:00, Kent Gibson <warthog618@gmail.com> wrote:

..

> > +   Read Documentation/driver-api/gpio/drivers-on-gpio.rst to avoid rei=
nventing
> > +   kernel wheels in userspace.
>
> I realise this is in part an emotional response, but very much
> "citation needed" on
> this one. While I believe Kernel drivers for things are a good idea, I
> don't believe
> userspace libraries are necessarily bad or wrong. They might be the first
> experience a future kernel dev has with hardware. Either way there are mu=
ltiple
> ecosystems of userspace drivers both existing and thriving right now, and=
 there
> are good reasons to reinvent kernel wheels in userspace.
>
> At least some of these reasons relate to the (incorrectly assumed)
> insurmountable
> nature of kernel development vs just throwing together some Python. Inclu=
ding
> this loaded language just serves to reinforce that.
>
> You catch more flies with honey than with vinegar, so I'd probably soften=
 to:
>
> Before abusing userspace APIs to bitbash drivers for your hardware you sh=
ould
> read Documentation/driver-api/gpio/drivers-on-gpio.rst to see if your dev=
ice has
> an existing kernel driver. If not, please consider contributing one.

I believe this note was motivated by the quite popular pyGPIO for RPi
and MRAA for some platforms, which are the examples of how _not_ do
things.

..

> > +Each chip supports a number of GPIO lines,
> > +:c:type:`chip.lines<gpiochip_info>`. Lines on the chip are identified =
by an
> > +``offset`` in the range from 0 to ``chip.lines - 1``, i.e. `[0,chip.li=
nes)`.
>
> I don't recognise this syntax "`[0,chip.lines)`", typo, or me being cluel=
ess?

It's called "open interval", a mathematical term.

..

> > +    -  -  ``EFAULT``

Wondering if these constants can be referenced via % and if it makes sense.

..

> > +The size of the kernel event buffer is fixed at the time of line reque=
st
> > +creation, and can be influenced by the
> > +:c:type:`request.event_buffer_size<gpio_v2_line_request>`.
> > +The default size is 16 times the number of lines requested.
>
> This might explain why I could never quite get high-speed pulse counting =
to feel
> right. Thank you!

GPIO is just not a good tool for this kind of measurement.

--=20
With Best Regards,
Andy Shevchenko


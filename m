Return-Path: <linux-kernel+bounces-18532-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BE31825ED4
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 09:09:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 323591C236DB
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 08:09:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1988B5386;
	Sat,  6 Jan 2024 08:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="h1/2hPlf"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D10C4426
	for <linux-kernel@vger.kernel.org>; Sat,  6 Jan 2024 08:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-680d1908fb2so2983076d6.3
        for <linux-kernel@vger.kernel.org>; Sat, 06 Jan 2024 00:09:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1704528564; x=1705133364; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SRZMYz5tGg2CVHgwSa5v03Ysex5vkTLyHVYkZh3pAH8=;
        b=h1/2hPlfrm7u4tIs4tcWqVqPXUsYxZqIbAACmwU6XKvwnCbQwMTqDwDCf90kzUdmfe
         p9FrU3l8OR4RSs2zajmmJdkGdhLz5d6DTRO8detHUB1X+bIvwdhZp4dJjbdDV8V7cLQA
         SctmH9bjB4+TFHpjqiH7MxOwz4EWiaJlmLdg1a7lmzsQ6rk2J2k2i8PjqtH4AoiWxXvM
         wfjJBbvhQZJOEkP0CwKoYytfySKoF6Rp1t6beCIvnMLsx+dd1ws6zuf2DN1J8Wp8PFJJ
         CBJ3ni6YNssLUdaNOvqmYqw3spp2G5McAfP1COezQVsGDXQzQucAhfEsQKs1a/2fjYFi
         J73w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704528564; x=1705133364;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SRZMYz5tGg2CVHgwSa5v03Ysex5vkTLyHVYkZh3pAH8=;
        b=gt6aHdtFact4gJN2UQ7t8AE9LtqpSIzLsRkJhaotgLAbpMoe/GqwBJLR9mAtPoLUcF
         2/zmkdSZOtqJp4+DD6F7aHym+PQXGLT3LP599tIOvEZX0p3VT8BqdsgSUEicJ0Fbw2sv
         kZXkhbXU2U6RAnyGMKZvkp7OMB0eXkLPu/1jUNPHPpPpd2Lo7JZnZBi5lVMS1IyZXoD2
         eNdPDNHwmMY4Jfd7vJbE7wLxiCYk8J7uDOmrEhqyX30EBdtzUC89kmk8/t5IQYmuJpzK
         4gatznIyKt9SMCcwKlwUI2sbeZM5sjL8+TviL2QAAQXwA5PMOKwxRMOGuY0ipvVIPwXv
         DFoQ==
X-Gm-Message-State: AOJu0Yy00Ci3N6R/rhREvYLNj5jGlhZcAhmIyuH1ZXkiSeb9T85qioxX
	JUW+0uierAI00/wBIm1ds1YITTutfWh49Mo6R0mROWUdOsLE
X-Google-Smtp-Source: AGHT+IGNZn0m8paKocQJUSZlQN8n6Znw04sRBC6kbmYiF977qlVZtYqLlwEq8RxKSplwZDYkh/s5529DAMXE8kyNF4M=
X-Received: by 2002:ad4:5b8b:0:b0:67f:2254:1629 with SMTP id
 11-20020ad45b8b000000b0067f22541629mr677963qvp.86.1704528563895; Sat, 06 Jan
 2024 00:09:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240104212439.3276458-1-maheshb@google.com> <ZZczNlXzM8lrZgH5@hoboy.vegasvil.org>
 <CAF2d9jga9oc4OST6PMU=C9rz_NDrURCcLGx-1tP31U00z63vbA@mail.gmail.com> <ZZjdUlaYyHZSiwSM@hoboy.vegasvil.org>
In-Reply-To: <ZZjdUlaYyHZSiwSM@hoboy.vegasvil.org>
From: =?UTF-8?B?TWFoZXNoIEJhbmRld2FyICjgpK7gpLngpYfgpLYg4KSs4KSC4KSh4KWH4KS14KS+4KSwKQ==?= <maheshb@google.com>
Date: Sat, 6 Jan 2024 00:08:57 -0800
Message-ID: <CAF2d9jhnsubL-sw792ZviSXrFB826G-U8OktdEMN1NCe5zuj0Q@mail.gmail.com>
Subject: Re: [PATCHv3 net-next 2/3] ptp: add ioctl interface for ptp_gettimex64any()
To: Richard Cochran <richardcochran@gmail.com>
Cc: Netdev <netdev@vger.kernel.org>, Linux <linux-kernel@vger.kernel.org>, 
	David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Jonathan Corbet <corbet@lwn.net>, John Stultz <jstultz@google.com>, Don Hatchett <hatch@google.com>, 
	Yuliang Li <yuliangli@google.com>, Mahesh Bandewar <mahesh@bandewar.net>, 
	Willem de Bruijn <willemb@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 5, 2024 at 8:55=E2=80=AFPM Richard Cochran <richardcochran@gmai=
l.com> wrote:
>
> On Fri, Jan 05, 2024 at 09:51:40AM -0800, Mahesh Bandewar (=E0=A4=AE=E0=
=A4=B9=E0=A5=87=E0=A4=B6 =E0=A4=AC=E0=A4=82=E0=A4=A1=E0=A5=87=E0=A4=B5=E0=
=A4=BE=E0=A4=B0) wrote:
>
> > POSIX clocks are employed in this series for syscall width
> > measurement, potentially leading to misunderstandings about
> > overlapping functionality. However, their roles are distinct and serve
> > different purposes.
>
> I don't see any difference in purposes.  The multi_clock_gettime call
> is a more general solution.  Thus it will obviate the need for any new
> PTP ioctls.
>

I disagree! NICs inherently benefit from bundled PTP devices due to
their superior low-latency, low-overhead, and precise TX/RX
timestamping capabilities. For demanding systems requiring increased
capacity, multiple NICs from various vendors are often deployed.
However, disciplining these diverse PTP devices across the host
demands a flexible approach; a general purpose syscall is not an
answer. The current PHC implementation using ioctls through exported
ptp devices (/dev/ptpX) provides a solid foundation that is per device
(/per NIC).

This series is providing another piece in an existing suite of methods
used for disciplining / precision tuning (along with adjfine, adjtime,
gettime etc.) This addition is to take that precision even further.

Having a general solution for posix timers is a nice addition.
However, expecting a general purpose syscall to eliminate need for
device ioctl is an unreasonable expectation.

Thanks,
--mahesh..

> Thanks,
> Richard


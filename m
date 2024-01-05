Return-Path: <linux-kernel+bounces-18147-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D30D782596E
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 18:52:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 415D51F22B69
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 17:52:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C3C4328CA;
	Fri,  5 Jan 2024 17:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="P/RP+rQ+"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A223328D0
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jan 2024 17:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-67f85fe5632so6155466d6.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jan 2024 09:52:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1704477127; x=1705081927; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WQGdqN4Kfk15tpyoA9m2c9B6GFS99Vf93jSd2R5n3Hw=;
        b=P/RP+rQ+zWoggbgn0PVtWoFaKrUYNmqXmeIOpvFLWl6VaTYgFeyxe3aPUJZVP822wc
         ndYR4L6eUiNMu2lyN9iRVkxsNQR/V8h3np15c0WqlZk6e7TUMZL9i+yPJueyo9HuUHuB
         f9wHpzrYe1g3X+rR2/mh7JSHxkHdk160mztVPhlTkpHGVmOVu5Etq5mjpBRtcqpYF8qc
         SyJAAZ76n71ofJP6fDbvz2h97GQIdFrPBlh3ZkgPdhTZB4KQQJeMd4KuzUlSK7VmwzmO
         j9QawZbJJawxWsHViYSyKRJ/CRCA7TDT0oFprnFhxxENzbo0AG24ijVa5kSKayFr7srq
         345g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704477127; x=1705081927;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WQGdqN4Kfk15tpyoA9m2c9B6GFS99Vf93jSd2R5n3Hw=;
        b=WHPlhKk0A1HdUaK/1E8ixqghQY1XcqNxkAg6WULNa7QFeojJfLLpTTWEtZ8uVceu6R
         VKVpRfTJHCJ+8cuM48u+Eqd+gYfMi9UgznkZfNGpXX7cLuCQrfD+hTjCG3dRE27+YKKz
         EuTrk2eQAXL+IWu5Wg5HezoDVvy5VfKqgMf/tkQXkpqvFKx08fiJu+4NQVgbBiladL57
         3l96Qy6OTeMujQOwosoC0IKS2qFAqQ1XsplHwcmnUD0JZygvFHWqVGxWgNCGnHdT/I42
         wcOB/dQYryWBagYERHhDYuEY6c5b5BSlpjIxfvkKZipyXkUusDC1TppVW+Erv40F5+vv
         qKFg==
X-Gm-Message-State: AOJu0YwS/yrY240xT2hsylgr4vGxsL1Ck5tVphzaJfYFY/H/JRG19lPj
	eQJhnhDg2YyzyfX/Bc6M5Fn/D4OD/ecado5Ak5NF+nkl2uUQ
X-Google-Smtp-Source: AGHT+IE90IxceJSGKiXicuQdISFFetHKGY9O0fote8zibDrvMDHy00OZx50Ky1T/9JY0JgTpTE929PJ/P+bIQR2+q6g=
X-Received: by 2002:a05:6214:2aae:b0:67f:8391:7d40 with SMTP id
 js14-20020a0562142aae00b0067f83917d40mr3062417qvb.51.1704477127304; Fri, 05
 Jan 2024 09:52:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240104212439.3276458-1-maheshb@google.com> <ZZczNlXzM8lrZgH5@hoboy.vegasvil.org>
In-Reply-To: <ZZczNlXzM8lrZgH5@hoboy.vegasvil.org>
From: =?UTF-8?B?TWFoZXNoIEJhbmRld2FyICjgpK7gpLngpYfgpLYg4KSs4KSC4KSh4KWH4KS14KS+4KSwKQ==?= <maheshb@google.com>
Date: Fri, 5 Jan 2024 09:51:40 -0800
Message-ID: <CAF2d9jga9oc4OST6PMU=C9rz_NDrURCcLGx-1tP31U00z63vbA@mail.gmail.com>
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

On Thu, Jan 4, 2024 at 2:37=E2=80=AFPM Richard Cochran <richardcochran@gmai=
l.com> wrote:
>
> On Thu, Jan 04, 2024 at 01:24:39PM -0800, Mahesh Bandewar wrote:
>
> > @@ -226,6 +238,8 @@ struct ptp_pin_desc {
> >       _IOWR(PTP_CLK_MAGIC, 18, struct ptp_sys_offset_extended)
> >  #define PTP_MASK_CLEAR_ALL  _IO(PTP_CLK_MAGIC, 19)
> >  #define PTP_MASK_EN_SINGLE  _IOW(PTP_CLK_MAGIC, 20, unsigned int)
> > +#define PTP_SYS_OFFSET_ANY \
> > +     _IOWR(PTP_CLK_MAGIC, 21, struct ptp_sys_offset_any)
>
> As I said before, this functionality really ought to be a new system call=
.
>
> Did you see these patch series posted on the list?
>
>  31.Dec'23 Sagi Maimon          [PATCH v4] posix-timers: add multi_clock_=
gettime system call
>  31.Dec'23 Andy Lutomirski      =E2=94=9C=E2=94=80>
>  01.Jan'24 Sagi Maimon          =E2=94=82 =E2=94=94=E2=94=80>
>  01.Jan'24 kernel test rob      =E2=94=9C=E2=94=80>
>  01.Jan'24 kernel test rob      =E2=94=94=E2=94=80>
>
>  02.Jan'24 Sagi Maimon          [PATCH v5] posix-timers: add multi_clock_=
gettime system call
>  02.Jan'24 Arnd Bergmann        =E2=94=9C=E2=94=80>
>  03.Jan'24 Sagi Maimon          =E2=94=82 =E2=94=94=E2=94=80>
>  04.Jan'24 kernel test rob      =E2=94=94=E2=94=80>
>
> I think this will be the way forward.
>
> Please review the multi_clock_gettime series and help refine it.
>

While multi_clock_gettime streamlines POSIX clock reads (defined in
posix-timers.h: struct k_time), this proposal targets precision
enhancements for PTP hardware clocks (defined in ptp_clock_kernel.h:
struct ptp_clock_info).

Key distinctions:
       1. Target clocks: multi_clock_gettime operates on POSIX clocks
(posix-timers.h), while this proposal focuses on PTP hardware clocks
(ptp_clock_kernel.h).
       2. Purpose: multi_clock_gettime addresses scheduling latencies
by consolidating multiple clock reads. This proposal aims to enhance
PTP clock-read precision by measuring syscall width.

POSIX clocks are employed in this series for syscall width
measurement, potentially leading to misunderstandings about
overlapping functionality. However, their roles are distinct and serve
different purposes.
Both approaches address time-related challenges, but with different
goals and techniques.
multi_clock_gettime optimizes scheduling efficiency for POSIX clocks,
while this proposal refines PTP hardware clock-read accuracy.
They complement each other, catering to diverse application needs
within the timekeeping domain.

Hope this helps.

Thanks,
--mahesh..

> Thanks,
> Richard
>


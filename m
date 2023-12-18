Return-Path: <linux-kernel+bounces-3912-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E5D081750A
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 16:17:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DE2AAB23B84
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 15:17:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3982242377;
	Mon, 18 Dec 2023 15:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="KGuuxqfn"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 556F83D568
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 15:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2cc6eecd319so15462771fa.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 07:16:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1702912596; x=1703517396; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PY60PN5C+lwGGC6WWMv45aexAZDh9La78/eVT3cI7Yo=;
        b=KGuuxqfnE2Fl9AWYcrhHSiYQ+vtdOHIwxPZExWiiadgMJw7pOrsbnrQosVW/DVt1D2
         g2XgiwedLoyts7jYZ1FUiBqXsHsBMo4Tp7w84vqjHS0YzhzsHnrxbm0YELq5bK2gYmKy
         VXRLhhKdKlN/28FBFPCJW75sV2/ZSeZIhxj2E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702912596; x=1703517396;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PY60PN5C+lwGGC6WWMv45aexAZDh9La78/eVT3cI7Yo=;
        b=wqpNqlHfqeCZUTvrrl9urKSw3VmAj0frg+b89fCMlJ0WJFRIBxCvXyiD9OhYwN+0Yo
         EFUuqtlMCjrlBXol3Zhj4XK8K90nMSEuooNyimSKJoSvQbO9oRahWijEEU0AdQfBtDNy
         c/zXiy1oV7rEPRNkq1xUkJSIac8kSlRsqcEkHewwTXWVzuhOIV5Ci8FYGTw/dy8EsWpe
         +FDUROI2rnfnxxfrTBirOgqELW7uvNrcXMff22Im1TAybW+FbkWXu8nmLDJLlW3GbCk2
         9EL+SNxPEuA+pmZTJjA5jPJl+BGqZu5dIpwtuM0+6Ie20qNX8UVa9Kap+YFtLIaT51V+
         bxzw==
X-Gm-Message-State: AOJu0YwaujTvDIVJdrUsCmKB9hpl7uM1w4AmHVzX1IAOsyHa/rLdUHUF
	ypYg1RAuJWn1Cz6jY+iGSZ0YeOWebCR+JLDu74ZZzRZ02ij8LeoN
X-Google-Smtp-Source: AGHT+IGjJop7oEsSX/3Ak4U+fYL3wpoY4UCc7Na0tU4gVge+P2pqeifmcNy+8SAGPVeT1XXEXmz03GvHhC95mdyNcWo=
X-Received: by 2002:a2e:95d8:0:b0:2cc:67ad:4153 with SMTP id
 y24-20020a2e95d8000000b002cc67ad4153mr1326894ljh.25.1702912596293; Mon, 18
 Dec 2023 07:16:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231211114346.1132386-1-stevensd@google.com> <2146e48d-5fb3-4444-81c5-9c8d8cb18811@redhat.com>
 <CAD=HUj7e9NaaYhos82JZoxhyX6J0bu+m0i7-_TqNbXiCDZ-Uxg@mail.gmail.com> <bc88dab5-e65a-401f-a44d-ad0c707c0f74@redhat.com>
In-Reply-To: <bc88dab5-e65a-401f-a44d-ad0c707c0f74@redhat.com>
From: David Stevens <stevensd@chromium.org>
Date: Mon, 18 Dec 2023 10:16:24 -0500
Message-ID: <CAD=HUj7h-cF929AbSL0bmZE7J=G1aQjZuYSgChPBkSGJ+wfoyQ@mail.gmail.com>
Subject: Re: [PATCH] virtio_balloon: stay awake while adjusting balloon
To: David Hildenbrand <david@redhat.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, virtualization@lists.linux-foundation.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 18, 2023 at 6:37=E2=80=AFAM David Hildenbrand <david@redhat.com=
> wrote:
>
> On 14.12.23 05:13, David Stevens wrote:
> > On Wed, Dec 13, 2023 at 5:44=E2=80=AFPM David Hildenbrand <david@redhat=
.com> wrote:
> >>
> >> On 11.12.23 12:43, David Stevens wrote:
> >>> From: David Stevens <stevensd@chromium.org>
> >>>
> >>
> >> Hi David,
> >>
> >>> Add a wakeup event for when the balloon is inflating or deflating.
> >>> Userspace can enable this wakeup event to prevent the system from
> >>> suspending while the balloon is being adjusted. This allows
> >>> /sys/power/wakeup_count to be used without breaking virtio_balloon's
> >>> cooperative memory management.
> >>
> >> Can you add/share some more details
> >
> > I'm working on enabling support for Linux s2Idle in our Android
> > virtual machine, to restrict apps from running in the background
> > without holding an Android partial wakelock. With the patch I recently
> > sent out [1], since crosvm advertises native PCI power management for
> > virtio devices, the Android guest can properly enter s2idle, and it
> > can be woken up by incoming IO. However, one of the remaining problems
> > is that when the host needs to reclaim memory from the guest via the
> > virtio-balloon, there is nothing preventing the guest from entering
> > s2idle before the balloon driver finishes returning memory to the
> > host.
>
> Thanks for the information. So you also want to wakeup the VM when
> wanting to get more memory from the VM?
>
> Using which mechanism would that wakeup happen? Likely not the device
> itself?

The wakeup would happen via the parent device's interrupt. I've sent a
new version of this patch that uses the parent device's wakeup event
instead of adding a new one.

> >
> > One alternative to this approach would be to add a virtballoon_suspend
> > callback to abort suspend if the balloon is inflating/adjusting.
> > However, it seems cleaner to just prevent suspend in the first place.
>
> Also, the PM notifier could also be used with very high priority, so the
> device would respond early to PM_SUSPEND_PREPARE.

One drawback of blocking suspend via a PM notifier is that the
behavior isn't configurable by userspace, whereas wakeup events can be
enabled/disabled by userspace.

-David


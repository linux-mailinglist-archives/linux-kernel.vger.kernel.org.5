Return-Path: <linux-kernel+bounces-3928-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 393E7817538
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 16:30:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5CAE3283D7D
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 15:30:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A62F93D549;
	Mon, 18 Dec 2023 15:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="SsIhLgq3"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52A3C3A1CD
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 15:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-50e3845abdaso1452993e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 07:30:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1702913424; x=1703518224; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PG0K7UPoSMBYTVf/4BeN4sLj8j0yHDIwZIH4KmzwU1Y=;
        b=SsIhLgq3qXPkF5uXARxgDujC1uCODid0W4DSZySZesKtxMPo9FDeFxof+FBenHlmPK
         eq4u2b+VRzb+B0CUxdmR9hyLduRBfiG7AoTqwyPJgADEoUavlCiPpQkFybqLmEuLS0y9
         xD+cXrLvByY1sTJy6UNl/5OlONhngiRZJjk1E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702913424; x=1703518224;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PG0K7UPoSMBYTVf/4BeN4sLj8j0yHDIwZIH4KmzwU1Y=;
        b=Em9JniR47csNugHoJs0xn02z0bGzwXtmsS2NVGVvdorZCwfzssKY12bVtd4+7WRLba
         SmL6/9ZFtEijk0eccZNAekvh18oMF9uZeK+LJQEkUKfdvNI331RJvVKhzje/0R3scnph
         7DxHGck0hpn2AzVcBzSgAnj/JtKQvyrzSeJdO86P7lkRyPdFTeOCTXGFDcwQ84qCfn1h
         KB8NNS2zBT1qqa6NQxvco5cCuTxObgFR9S45p2ZIrL1Tnleve2ZE9J1xyAL7H9c3Suox
         l8rOcWFkVu7uaqsV5VQvvxkkqLjfuDINNYqCLAHbPQpkpxvCQk/89bQVjocVbeOOBXgb
         ndjA==
X-Gm-Message-State: AOJu0YxzQf1rA7WWRnmI/4IrjSxGVyZFvjRg7XsdjP1o7wj/qNFJh0LH
	Nt/gZMuwDGQauShx6lXSuHQakyCuz4hvz187usVs4g==
X-Google-Smtp-Source: AGHT+IG7ioPSvk7odK8dBT0pCW2tc41P9y6yj1h99EeW3lSZFG0Zdz4kd95MRNuNhrGzwwRGUp9I6GLj+Q74re80cLw=
X-Received: by 2002:a05:6512:3b87:b0:50e:2cbd:cc50 with SMTP id
 g7-20020a0565123b8700b0050e2cbdcc50mr2142056lfv.23.1702913424387; Mon, 18 Dec
 2023 07:30:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231211114346.1132386-1-stevensd@google.com> <2146e48d-5fb3-4444-81c5-9c8d8cb18811@redhat.com>
 <CAD=HUj7e9NaaYhos82JZoxhyX6J0bu+m0i7-_TqNbXiCDZ-Uxg@mail.gmail.com>
 <bc88dab5-e65a-401f-a44d-ad0c707c0f74@redhat.com> <CAD=HUj7h-cF929AbSL0bmZE7J=G1aQjZuYSgChPBkSGJ+wfoyQ@mail.gmail.com>
 <2b8f4855-98f4-4515-bd5f-f93983d45714@redhat.com>
In-Reply-To: <2b8f4855-98f4-4515-bd5f-f93983d45714@redhat.com>
From: David Stevens <stevensd@chromium.org>
Date: Mon, 18 Dec 2023 10:30:13 -0500
Message-ID: <CAD=HUj5gZYBN=6Kk+jrva-VidHdU4YNXnVu+9R2p-HT3qEuKtg@mail.gmail.com>
Subject: Re: [PATCH] virtio_balloon: stay awake while adjusting balloon
To: David Hildenbrand <david@redhat.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, virtualization@lists.linux-foundation.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 18, 2023 at 10:18=E2=80=AFAM David Hildenbrand <david@redhat.co=
m> wrote:
>
> On 18.12.23 16:16, David Stevens wrote:
> > On Mon, Dec 18, 2023 at 6:37=E2=80=AFAM David Hildenbrand <david@redhat=
.com> wrote:
> >>
> >> On 14.12.23 05:13, David Stevens wrote:
> >>> On Wed, Dec 13, 2023 at 5:44=E2=80=AFPM David Hildenbrand <david@redh=
at.com> wrote:
> >>>>
> >>>> On 11.12.23 12:43, David Stevens wrote:
> >>>>> From: David Stevens <stevensd@chromium.org>
> >>>>>
> >>>>
> >>>> Hi David,
> >>>>
> >>>>> Add a wakeup event for when the balloon is inflating or deflating.
> >>>>> Userspace can enable this wakeup event to prevent the system from
> >>>>> suspending while the balloon is being adjusted. This allows
> >>>>> /sys/power/wakeup_count to be used without breaking virtio_balloon'=
s
> >>>>> cooperative memory management.
> >>>>
> >>>> Can you add/share some more details
> >>>
> >>> I'm working on enabling support for Linux s2Idle in our Android
> >>> virtual machine, to restrict apps from running in the background
> >>> without holding an Android partial wakelock. With the patch I recentl=
y
> >>> sent out [1], since crosvm advertises native PCI power management for
> >>> virtio devices, the Android guest can properly enter s2idle, and it
> >>> can be woken up by incoming IO. However, one of the remaining problem=
s
> >>> is that when the host needs to reclaim memory from the guest via the
> >>> virtio-balloon, there is nothing preventing the guest from entering
> >>> s2idle before the balloon driver finishes returning memory to the
> >>> host.
> >>
> >> Thanks for the information. So you also want to wakeup the VM when
> >> wanting to get more memory from the VM?
> >>
> >> Using which mechanism would that wakeup happen? Likely not the device
> >> itself?
> >
> > The wakeup would happen via the parent device's interrupt. I've sent a
> > new version of this patch that uses the parent device's wakeup event
> > instead of adding a new one.
> >
> >>>
> >>> One alternative to this approach would be to add a virtballoon_suspen=
d
> >>> callback to abort suspend if the balloon is inflating/adjusting.
> >>> However, it seems cleaner to just prevent suspend in the first place.
> >>
> >> Also, the PM notifier could also be used with very high priority, so t=
he
> >> device would respond early to PM_SUSPEND_PREPARE.
> >
> > One drawback of blocking suspend via a PM notifier is that the
> > behavior isn't configurable by userspace, whereas wakeup events can be
> > enabled/disabled by userspace.
>
> The question is if that behavior for the balloon is really worth it
> being configured by user space?

It seems to me that the current behavior of completely resetting the
virtio balloon in virtballoon_freeze is basically antithetical to the
power management integration I'm adding, where power management
doesn't interrupt the virtio balloon's operation at all. So if there
are any systems that are actually happy with the current power
management behavior, they probably don't want suspend to be blocked by
inflation/deflation.

-David


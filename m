Return-Path: <linux-kernel+bounces-133837-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D95E89A993
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 09:32:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14D4C283DBB
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 07:32:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C404225DA;
	Sat,  6 Apr 2024 07:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UfkW0fIo"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AF94A50
	for <linux-kernel@vger.kernel.org>; Sat,  6 Apr 2024 07:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712388771; cv=none; b=n76C1yjh41LgfON6tWnfwoSSprTKVzObfNKaaVDCp4OB5NvakbjjF6gdN+e9qoAGW19u0lqIRRwtuoDxHAv9iFHuoiLW0+aBuMBd/ksuDsVScNubYMqtG2orWBH2JNj8PzJfCRtukwGfYWI5JZQ23sRvnv8eZW94ivE11Od7WXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712388771; c=relaxed/simple;
	bh=NvlJkpe6XKljSOXj4+L2vY1E7yA0dzVePKq7ArdLk9U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jLszjHEq/dg3jkaKNx8fC3u6G3kyEX7rna9IuZTMKQTyR/RI0AaAmH6ZQ0gx1AiOPWPOzBwAOtLAO6IHESABK7sVDuMmRfewvNvCQKax8vvCW9lFyB2IoULxxEtvdqYz88TtjYnJNLhegK6QJqmuIhOcWgDnlsOnlnw6NNaSU9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UfkW0fIo; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a51addddbd4so119777766b.0
        for <linux-kernel@vger.kernel.org>; Sat, 06 Apr 2024 00:32:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712388769; x=1712993569; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=013IZU5d3S0NSE/vfboHFT2kND7XDrhmbJn2/miWjio=;
        b=UfkW0fIoxTO9rIOmzYHUczE3ZwdqRPiAzSZ61qp7n1lG5o6zJkpf4i5C+ru9qJPCpV
         tOuhqGWjEcwc2ZNfpB1aldMEzYAAzS0r5UJmKe+gdpbwg/v7xHl/0f6OYRaMLOR5IZOd
         fXG9Ail4dUlWp6ItYGlmkr5Nud/a3XYSWS+2k4mhS5+7FHY594ObY3ShMUKJRMjBSXhh
         nU0d8oQL7+/m4zPER0FcEquMpxinhN9v8m+Et8d/CPJcRlnysPeoRv8SJVgHWJBhqolr
         hBvPKiqp8MZabKM5qeBlVXPIJBbiDIkRD9Ztxa9rPBEhTGfymhCJeAcquzkbEmmu82Ug
         dw4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712388769; x=1712993569;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=013IZU5d3S0NSE/vfboHFT2kND7XDrhmbJn2/miWjio=;
        b=ikf0j8VQINDKyV/TJm6elZ+LhNzHRyudFtofB0cO7N4983vBqdNJjtg0IjG2qYhB3q
         ywjeb5XnFlASdDKWCgwECdYfwZLhmsWqFD3pfMLr0UZQT8DNuy+kCITTKUq9BwFxczNG
         u8r8zm9QQ8Xgstgo4pI9Uad8iQERgmUYimNzWsnSQTBvuUOCAK+cQfLoM01fhYCSSefq
         5Jo8+g+q/oH7mICda8v+hSHK6l5BoF7X6ks6A+KxoccBzc8uj1wytTGBfp2vo51YLtis
         w/v+5SZZJgh9FEBnUbz+CoZqAHN+18BR9hhFdQOi8DFkveuGK8lkwhslU8kvJg/TaXP4
         OVFw==
X-Forwarded-Encrypted: i=1; AJvYcCVoeNtPwI2NOLI2W8u94N9vAR2kx/rvnRjmPitGcuxdPUQPemr5oBbjDgru4U5Zsi2n5pal67jBgdLieNIT7q3NDHpTHNwZs1TQbAdn
X-Gm-Message-State: AOJu0YwI5n4i0m2IGBduLdmpM/uXUXQufDs5f1iUAids1nyeUZ1xR0mf
	8Tw4DL07WloRzmApIwh3VXfzvNQ+KUvY9CEBQG9nuvCiQ8UI2G1PpC1dL2+LUXZKLWc58EUn0wo
	2EFi2/RxiYrcsuLFF+QX7a2mThug=
X-Google-Smtp-Source: AGHT+IFfMYPeVHT6k5a4kWIko7MIMciS7wY1H9ZYhRPYpikHEHFMCapwLGgkvsgTPm9GQ6v8k595fKNbEsCUm3U4uEo=
X-Received: by 2002:a17:906:f909:b0:a47:3651:a302 with SMTP id
 lc9-20020a170906f90900b00a473651a302mr2066556ejb.42.1712388768454; Sat, 06
 Apr 2024 00:32:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240405152951.1531555-1-nunes.erico@gmail.com>
In-Reply-To: <20240405152951.1531555-1-nunes.erico@gmail.com>
From: Qiang Yu <yuq825@gmail.com>
Date: Sat, 6 Apr 2024 15:32:36 +0800
Message-ID: <CAKGbVbszmRpWfaXVjQ83RiFBapjent9UKM=JcGTMVsOk3bqJkQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] drm/lima: fix devfreq refcount imbalance for job timeouts
To: Erico Nunes <nunes.erico@gmail.com>
Cc: anarsoul@gmail.com, dri-devel@lists.freedesktop.org, 
	lima@lists.freedesktop.org, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	christian.koenig@amd.com, megi@xff.cz, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Serial is Reviewed-by: Qiang Yu <yuq825@gmail.com>

On Fri, Apr 5, 2024 at 11:31=E2=80=AFPM Erico Nunes <nunes.erico@gmail.com>=
 wrote:
>
> v1 reference:
> https://patchwork.freedesktop.org/series/131902/
>
> Changes v1 -> v2:
> - Split synchronize_irq of pp bcast irq change into (new) patch 2.
>
> Erico Nunes (3):
>   drm/lima: add mask irq callback to gp and pp
>   drm/lima: include pp bcast irq in timeout handler check
>   drm/lima: mask irqs in timeout path before hard reset
>
>  drivers/gpu/drm/lima/lima_bcast.c | 12 ++++++++++++
>  drivers/gpu/drm/lima/lima_bcast.h |  3 +++
>  drivers/gpu/drm/lima/lima_gp.c    |  8 ++++++++
>  drivers/gpu/drm/lima/lima_pp.c    | 18 ++++++++++++++++++
>  drivers/gpu/drm/lima/lima_sched.c |  9 +++++++++
>  drivers/gpu/drm/lima/lima_sched.h |  1 +
>  6 files changed, 51 insertions(+)
>
> --
> 2.44.0
>


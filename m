Return-Path: <linux-kernel+bounces-167140-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FEBD8BA4DE
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 03:22:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17209284741
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 01:22:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF93DF4F1;
	Fri,  3 May 2024 01:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gigaio-com.20230601.gappssmtp.com header.i=@gigaio-com.20230601.gappssmtp.com header.b="RJ8fSmiz"
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A685AC138
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 01:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714699361; cv=none; b=goEq2/sgP1clViHtyf7rmQgds2UFCRMLB6HUD5uQgaVOyFNjpl9zXd+hibCo3NvVMFvYMzNt+yPvI6xvUiJxNV+YBihEiyCCwitjM0BqUMrwcRvVreQURp3Y8u7mjzFNQfr/b+ACxhKmWOWJadR4YF6WCapsXaSvCo6FuStILoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714699361; c=relaxed/simple;
	bh=THq6Ze4gPUnRdVplVf82t5+be7u1nGQ6bRReSoZAFVY=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=CQupsfhz1i/oVXNxOz6g/2sR0Fa1F+EJNYkGxkMi3m2mBNwZnf8TIdW/xLDYOguvoaWtmmhJQTEekrgkNP0K7OdZEbKhgSSyiSQYJzKXhQwHUNkFMku0y7XeAKSDaWA20EqtRlOCZ+JATbLEV9g4BMdMZyfeZ7oVfhgiaWx+nvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gigaio.com; spf=pass smtp.mailfrom=gigaio.com; dkim=pass (2048-bit key) header.d=gigaio-com.20230601.gappssmtp.com header.i=@gigaio-com.20230601.gappssmtp.com header.b=RJ8fSmiz; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gigaio.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gigaio.com
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-6ee2fda66easo2695843a34.3
        for <linux-kernel@vger.kernel.org>; Thu, 02 May 2024 18:22:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gigaio-com.20230601.gappssmtp.com; s=20230601; t=1714699359; x=1715304159; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k3nkCSoTperPlX+PtC8qWAin0Hv01DoPF7+bPAgfSgA=;
        b=RJ8fSmizwW8Ri43tzpRG5Im75HX361c7DQsGdyZaVijbxOIg9jlmQIml0TzWlrQp/V
         MClaa+yqzy1Jf/oCwom2hHjegN3oUAhnkYTTITaQvEcp3hTXtkuhUElnHL7amTs3t3yj
         3w+moYdmVGSJ9cDBi9Rmn9n45k6F2+R3BJPBDzdvBhwZHG0eraIuZ4B+Nmf7IOTk9NUq
         cFtRt57e7a+kreIb1xXgP4shdE7tcaB/woFshL5Va/1HyOB9ecvtyByVtOd6MKV82apt
         wkULygsMUuM/3+g9GLpLZCtEdyqbkUAlhcBRLZe+GT6Tq0jYM9sfOpKNonIiMCD5mbh1
         7L/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714699359; x=1715304159;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k3nkCSoTperPlX+PtC8qWAin0Hv01DoPF7+bPAgfSgA=;
        b=uch3Bb2vsNX9UHpBB3mMhdm1VPHRZuB9LDsXsbPABRk96U+AUpu/ZPiG+0/Ula/h+t
         fK0+d0kUuzceuoRxM6oO4mOiJAfks6ENiHV1vbAHRWkxvnlio3zhg9SXHOjOngIlfllm
         SCbCA8Q4o8DILvQQkunYs/7QsHMNPa/OpDMQlOReTxz+vOx2KRp7thkjwpgcnvFbnF2i
         RFoe696gxldlvAPBn5Hv+YdjJVWduRbkAx/5r/E8Mgkk6SAmVDnY3bAWiSHM7WDYPO/x
         wnfU6iUnaRsHkCBCs9JOb6ezsn3xjdjdFayBJsPkCNsgbbNgYUoYKyECknceuNTIx2EZ
         +QBg==
X-Forwarded-Encrypted: i=1; AJvYcCV7IUdZC3/zHb/Tn6ai6PAXeBpB8w/xs9i+rAWK7hTLNJseqr3NxBLCtjUJh57sWB0sXKDG+1TU4Ri6MffbXwk/BwgCmWuOsjmD/ou9
X-Gm-Message-State: AOJu0YyoNeM8mwFOjj8y7VdEm11Gq6MaJYWRoiNoGiXNsgQsTU5V0G5t
	rr47zBG3vrVRdRceX7E31Ou2OeIiJjFcFSUETvBEWUjQQbppK+S6A0/YJylUENk=
X-Google-Smtp-Source: AGHT+IGYuWQGoJVifB5ByXnZOOtnc0jo+Gwcp8Ftoa0rZdJC9qXcD/CvZftAT0HRvOGe4Jw7d7sdMw==
X-Received: by 2002:a05:6830:3490:b0:6ea:30bc:a6b5 with SMTP id c16-20020a056830349000b006ea30bca6b5mr1921224otu.22.1714699358803;
        Thu, 02 May 2024 18:22:38 -0700 (PDT)
Received: from smtpclient.apple (45-31-42-85.lightspeed.sndgca.sbcglobal.net. [45.31.42.85])
        by smtp.gmail.com with ESMTPSA id d11-20020a656b8b000000b005f7ff496050sm1699721pgw.76.2024.05.02.18.22.37
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 May 2024 18:22:38 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.500.171.1.1\))
Subject: Re: [PATCH v6 0/4] drm: Use full allocated minor range for DRM
From: Eric Pilmore <epilmore@gigaio.com>
In-Reply-To: <20230724211428.3831636-1-michal.winiarski@intel.com>
Date: Thu, 2 May 2024 18:22:26 -0700
Cc: dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org,
 intel-gfx@lists.freedesktop.org,
 David Airlie <airlied@linux.ie>,
 Daniel Vetter <daniel@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Simon Ser <contact@emersion.fr>,
 Matthew Wilcox <willy@infradead.org>,
 Oded Gabbay <ogabbay@kernel.org>,
 =?utf-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 James Zhu <James.Zhu@amd.com>,
 Pekka Paalanen <pekka.paalanen@collabora.com>,
 Emil Velikov <emil.l.velikov@gmail.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <83E51798-5335-49AA-8211-60EC29577617@gigaio.com>
References: <20230724211428.3831636-1-michal.winiarski@intel.com>
To: =?utf-8?Q?Micha=C5=82_Winiarski?= <michal.winiarski@intel.com>
X-Mailer: Apple Mail (2.3774.500.171.1.1)



> On Jul 24, 2023, at 2:14=E2=80=AFPM, Micha=C5=82 Winiarski =
<michal.winiarski@intel.com> wrote:
>=20
> 64 DRM device nodes is not enough for everyone.
> Upgrade it to ~512K (which definitely is more than enough).
>=20
> To allow testing userspace support for >64 devices, add additional DRM
> modparam (force_extended_minors) which causes DRM to skip allocating =
minors
> in 0-192 range.
> Additionally - convert minors to use XArray instead of IDR to simplify =
the
> locking.
>=20
> v1 -> v2:
> Don't touch DRM_MINOR_CONTROL and its range (Simon Ser)
>=20
> v2 -> v3:
> Don't use legacy scheme for >=3D192 minor range (Dave Airlie)
> Add modparam for testing (Dave Airlie)
> Add lockdep annotation for IDR (Daniel Vetter)
>=20
> v3 -> v4:
> Convert from IDR to XArray (Matthew Wilcox)
>=20
> v4 -> v5:
> Fixup IDR to XArray conversion (Matthew Wilcox)
>=20
> v5 -> v6:
> Also convert Accel to XArray
> Rename skip_legacy_minors to force_extended_minors
>=20
> Micha=C5=82 Winiarski (4):
>  drm: Use XArray instead of IDR for minors
>  accel: Use XArray instead of IDR for minors
>  drm: Expand max DRM device number to full MINORBITS
>  drm: Introduce force_extended_minors modparam
>=20
> drivers/accel/drm_accel.c      | 110 +++------------------------------
> drivers/gpu/drm/drm_drv.c      | 105 ++++++++++++++++---------------
> drivers/gpu/drm/drm_file.c     |   2 +-
> drivers/gpu/drm/drm_internal.h |   4 --
> include/drm/drm_accel.h        |  18 +-----
> include/drm/drm_file.h         |   5 ++
> 6 files changed, 69 insertions(+), 175 deletions(-)
>=20
> --=20
> 2.41.0
>=20


Hi Michal,

What is the status on this patch? Did it ever get accepted upstream?
If so, what release? I don=E2=80=99t see the changes in the latest Linux =
kernel.
I am working on a system that involves a large number of GPUs, where
each GPU consumes a number of DRM devices. As such, I=E2=80=99m easily
exceeding the current limit of 64 in the (6.6) kernel. To workaround =
this issue,
I have temporarily picked up this patch which is doing the trick, but =
now
I=E2=80=99m wondering if this patch has seen the light of day in the =
Linux kernel.

Thanks for any info!

Regards,
Eric



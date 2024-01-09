Return-Path: <linux-kernel+bounces-21049-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79CC182890A
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 16:31:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 81EEFB2392C
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 15:31:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2479C39FE6;
	Tue,  9 Jan 2024 15:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S3Xc8aoZ"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 087E639AD5;
	Tue,  9 Jan 2024 15:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-55719cdc0e1so3483532a12.1;
        Tue, 09 Jan 2024 07:31:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704814278; x=1705419078; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PxBXHYFAM9hT0OPdpUiDaQH1QeZpaAp07NJ8WhXUbqI=;
        b=S3Xc8aoZZNpHFSldBJefvBVkUBMCWa1y1yNNxYeQfE/hUmWGHbTD2ku90TH4hlBSGS
         MHpbsGqSpmCHSx4N2HUahJIECbhLpomd/0bi5Y9sm/U4VnIFKtEMDqTGGZE3Vostbyay
         eJxiutr/VFyseKU7P1z4zNghyZQ3keje+7IJiiDigjHhwdkCRyZ8HK/SZU3996ItEot2
         T1pPFhGyv1hapcP2MmmJkaLswayG4LI4UapJE3zW2J83ZeEMN0h2IWSI97XVtguovW4c
         zfybgEAwOALh0539GMt8gkGgGupbG35nk0rItkoO3pqXn/s9Gmp349/TayScHmVMzKkD
         rk4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704814278; x=1705419078;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PxBXHYFAM9hT0OPdpUiDaQH1QeZpaAp07NJ8WhXUbqI=;
        b=o5URns1UxysY2Whxo8et7vIQj07aZ0pUe/0Ik7bgvtztyEgh7fUfC2sryuXacD2H15
         Re0U16r6TQ4aF0PW00fiqVjugTHs6vrJ1oBXQXGUyXVeGmaOkbCtroPkGqidbdnkvKnc
         amUcL1BCDRJA3KuL0TFNWe1a7Lfei6b3nE7lxKS+1+S9/Uahw7Aj2IUTwt+OTF7xdDbg
         CoyXmQhclap2Odwzw2sQVx99KoUlY3H4XZJVMFkQBmefl66RTUM9n2tMDRGNmrZPSs9Y
         iE7mj683/bvEu+5CTowXi96/lUUwO/8NtA9UlR98mKpUHV8ZQ64xb3eA3m5btmpRdRlc
         3Qvg==
X-Gm-Message-State: AOJu0YxrMN06fERUH6ynVMYyegbSjIneUNTTNVwwyd1MYyBIePJ4Pdy9
	FrnCzprlUinNuu1R1RlzPpOdwj5qluRTOaCohro=
X-Google-Smtp-Source: AGHT+IGZyO4AEfnMfLYPKR2LNX1qm2urfpVyDpvn02M9tLIi+tBjOPpZ/2hQu1bO1hbBogEOEOu71wclHwHHjR9FC0U=
X-Received: by 2002:a50:934a:0:b0:557:375e:6dfa with SMTP id
 n10-20020a50934a000000b00557375e6dfamr3382250eda.13.1704814278180; Tue, 09
 Jan 2024 07:31:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240108195016.156583-1-robdclark@gmail.com> <454873e5-1b5a-28d3-ffed-c1e502898d17@quicinc.com>
 <CAF6AEGuVk=a-SwHyVwqOew-+WAdH1Gt011H50kvkSBe1j5ri_A@mail.gmail.com>
In-Reply-To: <CAF6AEGuVk=a-SwHyVwqOew-+WAdH1Gt011H50kvkSBe1j5ri_A@mail.gmail.com>
From: Rob Clark <robdclark@gmail.com>
Date: Tue, 9 Jan 2024 07:31:06 -0800
Message-ID: <CAF6AEGs7NxB2ox+JMW0tP_XOkFie=f=w1sWSQjTUM8AZQ0V3TQ@mail.gmail.com>
Subject: Re: [PATCH] drm/ci: Add msm tests
To: Abhinav Kumar <quic_abhinavk@quicinc.com>
Cc: dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
	linux-arm-msm@vger.kernel.org, Rob Clark <robdclark@chromium.org>, 
	Helen Koike <helen.koike@collabora.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 8, 2024 at 6:13=E2=80=AFPM Rob Clark <robdclark@gmail.com> wrot=
e:
>
> On Mon, Jan 8, 2024 at 2:58=E2=80=AFPM Abhinav Kumar <quic_abhinavk@quici=
nc.com> wrote:
> >
> >
> >
> > On 1/8/2024 11:50 AM, Rob Clark wrote:
> > > From: Rob Clark <robdclark@chromium.org>
> > >
> > > The msm tests should skip on non-msm hw, so I think it should be safe=
 to
> > > enable everywhere.
> > >
> > > Signed-off-by: Rob Clark <robdclark@chromium.org>
> > > ---
> > >   drivers/gpu/drm/ci/testlist.txt | 49 ++++++++++++++++++++++++++++++=
+++
> > >   1 file changed, 49 insertions(+)
> > >
> >
> > I do see that all these tests use igt_msm_dev_open() to make sure it
> > opens only the MSM card.
> >
> > But if igt_msm_dev_open() fails, I dont see a igt_require() on some of
> > the tests to skip them. So how will it safely skip on non-msm HW?
> >
> > Unless i am missing something here ....
>
> hmm, at the time I added the initial msm tests, and
> igt_msm_dev_open(), I verified that they skipped on intel.. but since
> then I'd switched from intel to sc8280xp device for primary dev
> device, so I'd need to re-test to remember how it works.  If these
> aren't skipping on !msm, it is a bug

I double checked, these tests skip in drm_open_driver() with "No known
gpu found for chipset flags 0x64 (msm)", so no problem to run them on
all CI runners.

BR,
-R


> BR,
> -R
>
> > > diff --git a/drivers/gpu/drm/ci/testlist.txt b/drivers/gpu/drm/ci/tes=
tlist.txt
> > > index f82cd90372f4..eaeb751bb0ad 100644
> > > --- a/drivers/gpu/drm/ci/testlist.txt
> > > +++ b/drivers/gpu/drm/ci/testlist.txt
> > > @@ -2910,3 +2910,52 @@ kms_writeback@writeback-invalid-parameters
> > >   kms_writeback@writeback-fb-id
> > >   kms_writeback@writeback-check-output
> > >   prime_mmap_kms@buffer-sharing
> > > +msm_shrink@copy-gpu-sanitycheck-8
> > > +msm_shrink@copy-gpu-sanitycheck-32
> > > +msm_shrink@copy-gpu-8
> > > +msm_shrink@copy-gpu-32
> > > +msm_shrink@copy-gpu-madvise-8
> > > +msm_shrink@copy-gpu-madvise-32
> > > +msm_shrink@copy-gpu-oom-8
> > > +msm_shrink@copy-gpu-oom-32
> > > +msm_shrink@copy-mmap-sanitycheck-8
> > > +msm_shrink@copy-mmap-sanitycheck-32
> > > +msm_shrink@copy-mmap-8
> > > +msm_shrink@copy-mmap-32
> > > +msm_shrink@copy-mmap-madvise-8
> > > +msm_shrink@copy-mmap-madvise-32
> > > +msm_shrink@copy-mmap-oom-8
> > > +msm_shrink@copy-mmap-oom-32
> > > +msm_shrink@copy-mmap-dmabuf-sanitycheck-8
> > > +msm_shrink@copy-mmap-dmabuf-sanitycheck-32
> > > +msm_shrink@copy-mmap-dmabuf-8
> > > +msm_shrink@copy-mmap-dmabuf-32
> > > +msm_shrink@copy-mmap-dmabuf-madvise-8
> > > +msm_shrink@copy-mmap-dmabuf-madvise-32
> > > +msm_shrink@copy-mmap-dmabuf-oom-8
> > > +msm_shrink@copy-mmap-dmabuf-oom-32
> > > +msm_mapping@ring
> > > +msm_mapping@sqefw
> > > +msm_mapping@shadow
> > > +msm_submitoverhead@submitbench-10-bos
> > > +msm_submitoverhead@submitbench-10-bos-no-implicit-sync
> > > +msm_submitoverhead@submitbench-100-bos
> > > +msm_submitoverhead@submitbench-100-bos-no-implicit-sync
> > > +msm_submitoverhead@submitbench-250-bos
> > > +msm_submitoverhead@submitbench-250-bos-no-implicit-sync
> > > +msm_submitoverhead@submitbench-500-bos
> > > +msm_submitoverhead@submitbench-500-bos-no-implicit-sync
> > > +msm_submitoverhead@submitbench-1000-bos
> > > +msm_submitoverhead@submitbench-1000-bos-no-implicit-sync
> > > +msm_recovery@hangcheck
> > > +msm_recovery@gpu-fault
> > > +msm_recovery@gpu-fault-parallel
> > > +msm_recovery@iova-fault
> > > +msm_submit@empty-submit
> > > +msm_submit@invalid-queue-submit
> > > +msm_submit@invalid-flags-submit
> > > +msm_submit@invalid-in-fence-submit
> > > +msm_submit@invalid-duplicate-bo-submit
> > > +msm_submit@invalid-cmd-idx-submit
> > > +msm_submit@invalid-cmd-type-submit
> > > +msm_submit@valid-submit


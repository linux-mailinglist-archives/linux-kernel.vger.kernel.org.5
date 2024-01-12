Return-Path: <linux-kernel+bounces-24908-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EBE9582C487
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 18:14:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 09AF21C22252
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 17:14:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95EE72260E;
	Fri, 12 Jan 2024 17:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nmh6/Z7s"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EA2222606;
	Fri, 12 Jan 2024 17:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-557bfc7f7b4so9527655a12.0;
        Fri, 12 Jan 2024 09:14:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705079676; x=1705684476; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gkRip5P/CSH4Zjga6g7Ad+NhClHoMzovsmKSyhbUtXI=;
        b=Nmh6/Z7sMOOWiVD7SBEno5YLeBNngSkGArrgJ8cWt6xMQdNuEtHQPuHmJiuYP7HjV0
         PhKXVEpA3jAT2aBjv9DlM5n9rzNLjQCkqKYqEI8oE/1FkV8znN0MwmTFuBSA0bQLbgN+
         zKSu6+lPzfTUMRU8woUpwBsEPTXeOzV0O7kR6JEKacSUHgOnbW0QLcJVk8h+sffCRpHT
         ev7cNoMzkB5B0bZOBOk2evGFA7egZbo4HdEnd+Km+Pi9OIjQYcEIbDLcJjLXdiPPovpe
         Uu4E69NeefoXKVqgCnN7TbLBBlUUds+2sTSqlpbUFqhnqK+8op0z7k9j6HahNHL04tPu
         u0dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705079676; x=1705684476;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gkRip5P/CSH4Zjga6g7Ad+NhClHoMzovsmKSyhbUtXI=;
        b=a4Qyrf8DpymFOnj7BwI47tu5AE+k9mcJ7bH8h90VeEyIEQoKo0LrX7X0Kvt/8JdZvw
         XcQOtxHQREXhybyxtCJaJRfkiwbgtXSMvzCyHgf0t0qF9lQO8lLa6maTDLUH20x1Ds1J
         r2Hwbs2UOY4EYLu98X3NuT+jCIOsLP9p/9sSnooU94ljSoMJD3MSjOAXU1g2QkYH4v1k
         +iI1yyLthBNiynJBAxlVbMwO/4M5iCjkHYxUcNd/t1JRi/30FSTJ/Y3PTcz2WAKVb33P
         y6INEIb3j7V1I+v0KoIJYd33IeU4ayqfT/hzMpKaSPGea7rm0x+OmKR13h9NPFJSjG8Z
         UOKA==
X-Gm-Message-State: AOJu0YwhODHmN6RD+GcByoi7yRsLz4LdS+RkwXILREaw1p+gYXbry6B2
	tX9N56O8WkW3w9tR3gCKNKsbfJ0aE5l5GXk7/iM=
X-Google-Smtp-Source: AGHT+IF9IMPBk8V3jyU215rKqdmijeXsvs7Ngpeca5FQb7pvIGZgTeR2+krrbELKgsorLRv1yVbITGICkSbSxw/uz2Q=
X-Received: by 2002:a50:9fab:0:b0:558:b5d0:e77a with SMTP id
 c40-20020a509fab000000b00558b5d0e77amr1925498edf.36.1705079676202; Fri, 12
 Jan 2024 09:14:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240108195016.156583-1-robdclark@gmail.com> <27e64458-7cb1-99a4-f67e-60d911f28f44@collabora.com>
 <CAF6AEGvBFdXe9rHjbwWv9eLUMv2YEP7cfMoXcWgZ30Wn4LzOjw@mail.gmail.com>
In-Reply-To: <CAF6AEGvBFdXe9rHjbwWv9eLUMv2YEP7cfMoXcWgZ30Wn4LzOjw@mail.gmail.com>
From: Rob Clark <robdclark@gmail.com>
Date: Fri, 12 Jan 2024 09:14:24 -0800
Message-ID: <CAF6AEGuXi1wTbE0j6FmSnqw_EVUYSdnk5WeFL6abD=zeNutPpg@mail.gmail.com>
Subject: Re: [PATCH] drm/ci: Add msm tests
To: Vignesh Raman <vignesh.raman@collabora.com>
Cc: dri-devel@lists.freedesktop.org, Rob Clark <robdclark@chromium.org>, 
	Daniel Vetter <daniel@ffwll.ch>, linux-arm-msm@vger.kernel.org, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	open list <linux-kernel@vger.kernel.org>, Maxime Ripard <mripard@kernel.org>, 
	Helen Koike <helen.koike@collabora.com>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, freedreno@lists.freedesktop.org, 
	Daniel Stone <daniel@fooishbar.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 12, 2024 at 7:57=E2=80=AFAM Rob Clark <robdclark@gmail.com> wro=
te:
>
> On Fri, Jan 12, 2024 at 3:42=E2=80=AFAM Vignesh Raman
> <vignesh.raman@collabora.com> wrote:
> >
> > Hi Rob,
> >
> >
> > On 09/01/24 01:20, Rob Clark wrote:
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
> >
> > I tested this patch with latest drm-misc/drm-misc-next and there was
> > some failures seen for the newly added msm tests. I have updated the
> > xfails with below commit,
> >
> > https://gitlab.freedesktop.org/vigneshraman/linux/-/commit/d012893597a6=
61d6ebbb755bf2607dfb055524a1
> >
> > I will notify the maintainers about the flaky tests, update the url in
> > the flakes.txt, and submit a separate patch for this change.

Oh, you should probably move msm_mapping@* to skips on sdm845.  I had
a closer look at those, and they are failing due to a bootloader/fw
issue.  We work around this in mesa CI with these two patches:

https://gitlab.freedesktop.org/gfx-ci/linux/-/commit/4b49f902ec6f2bb382cbbf=
489870573f4b43371e
https://gitlab.freedesktop.org/gfx-ci/linux/-/commit/38cdf4c5559771e2474ae0=
fecef8469f65147bc1

But given that sdm845 is similar to sc7180 as far as kernel gpu
driver, it is probably just better to skip these on sdm845 (with a
comment referring to the hack patches we use in mesa CI)

BR,
-R

>
> Thanks, it looks like you also have a relatively recent igt (there
> were some msm_submit fails until I fixed the test)..
>
> BR,
> -R
>
> > Regards,
> > Vignesh


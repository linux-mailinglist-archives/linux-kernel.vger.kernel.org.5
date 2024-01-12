Return-Path: <linux-kernel+bounces-24832-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B33D782C328
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 16:58:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7A149B22E5A
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 15:58:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38A0473178;
	Fri, 12 Jan 2024 15:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iipc3rQa"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF9456EB45;
	Fri, 12 Jan 2024 15:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-558b5f4cf2dso1487356a12.2;
        Fri, 12 Jan 2024 07:57:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705075069; x=1705679869; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i3LR7JHWsG5WnJs6U2d88UYiHWMdGc0ZzpsAbd+9k2w=;
        b=iipc3rQa3Sk1LCIO80zGODnnts7uWVKjRwdVFTUo2cOpxRRGIxuZdcxopFdrduBrsd
         KlpH2dg4sAdYAOIOXRx5IDm9wIL2ayvQGHC6uUjD8vygN9+AZzkOCDCTf9g2bcOn/h5r
         M81cPHiO3bZ5VbdMPjrkq2Vs6cUsGH5xuJN9gK1VNH5REnKP0trOLSELIPBUn3Ax/lBm
         DNMEKoJJz6R2Z4Gms7CYkaeyZBuKygj1aK5RBAnGXoz2CK14zbvFMDLv3mOCb6Z7KJqq
         HXEZRMykHBxMvxx1ZNsjPTQQuDN87AYyX8uy/59uXDvrhXVQMy/L2dgJatM7h0AQOWqU
         cHmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705075069; x=1705679869;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i3LR7JHWsG5WnJs6U2d88UYiHWMdGc0ZzpsAbd+9k2w=;
        b=Qtgn/pxuGt5XMHBtsQS64gqqOfFHf/8d3MrwARnn7p1iXtsz2v49u8g5UosiyPXWuL
         N33w+68O7I5dLEku6cp163PFAYiZU7F3jW0MSMTLnVhVlEYYw5j6Wcr6MI80MuxH0IiC
         cSMzS2mIGSrGkulQ+e2eJqk7M8GLT3VRjUOCyMWIdXnKHP42UkaEVoYysnC3TTo3VcYL
         Mzo00nomXWlbTVZxXPF4p4b0kmLSQE52nn5bQ9DGBWib3HcgyXDCPMRKHynwfGVVLVGV
         ffpRImLouonuUASAuEyqNU/rn9ujXKcp2cNlB5aGCiu1E7u3ZgOtfo4n8MWVScaIDIDv
         f4Ow==
X-Gm-Message-State: AOJu0Yxttzx2r4CIAd/iQzPhWo8JYyVxTIGtv7gFll/B0qQG4iQsRvip
	2J7tGHtXMOnlNmWoj0y/cPfbvjWtxzYLlwObdaw=
X-Google-Smtp-Source: AGHT+IFmoeegZBMTNiFZZdCfLc9xHzLnK5XjPQ27p3qgMhoQ0YPlLF9quVd/qIxt91xPL0cwv3QoAAEuGj2nXPJ7Hy8=
X-Received: by 2002:aa7:c549:0:b0:558:83e5:9937 with SMTP id
 s9-20020aa7c549000000b0055883e59937mr734942edr.8.1705075068823; Fri, 12 Jan
 2024 07:57:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240108195016.156583-1-robdclark@gmail.com> <27e64458-7cb1-99a4-f67e-60d911f28f44@collabora.com>
In-Reply-To: <27e64458-7cb1-99a4-f67e-60d911f28f44@collabora.com>
From: Rob Clark <robdclark@gmail.com>
Date: Fri, 12 Jan 2024 07:57:36 -0800
Message-ID: <CAF6AEGvBFdXe9rHjbwWv9eLUMv2YEP7cfMoXcWgZ30Wn4LzOjw@mail.gmail.com>
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

On Fri, Jan 12, 2024 at 3:42=E2=80=AFAM Vignesh Raman
<vignesh.raman@collabora.com> wrote:
>
> Hi Rob,
>
>
> On 09/01/24 01:20, Rob Clark wrote:
> > From: Rob Clark <robdclark@chromium.org>
> >
> > The msm tests should skip on non-msm hw, so I think it should be safe t=
o
> > enable everywhere.
> >
> > Signed-off-by: Rob Clark <robdclark@chromium.org>
> > ---
> >   drivers/gpu/drm/ci/testlist.txt | 49 ++++++++++++++++++++++++++++++++=
+
> >   1 file changed, 49 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/ci/testlist.txt b/drivers/gpu/drm/ci/testl=
ist.txt
> > index f82cd90372f4..eaeb751bb0ad 100644
> > --- a/drivers/gpu/drm/ci/testlist.txt
> > +++ b/drivers/gpu/drm/ci/testlist.txt
> > @@ -2910,3 +2910,52 @@ kms_writeback@writeback-invalid-parameters
> >   kms_writeback@writeback-fb-id
> >   kms_writeback@writeback-check-output
> >   prime_mmap_kms@buffer-sharing
> > +msm_shrink@copy-gpu-sanitycheck-8
> > +msm_shrink@copy-gpu-sanitycheck-32
> > +msm_shrink@copy-gpu-8
> > +msm_shrink@copy-gpu-32
> > +msm_shrink@copy-gpu-madvise-8
> > +msm_shrink@copy-gpu-madvise-32
> > +msm_shrink@copy-gpu-oom-8
> > +msm_shrink@copy-gpu-oom-32
> > +msm_shrink@copy-mmap-sanitycheck-8
> > +msm_shrink@copy-mmap-sanitycheck-32
> > +msm_shrink@copy-mmap-8
> > +msm_shrink@copy-mmap-32
> > +msm_shrink@copy-mmap-madvise-8
> > +msm_shrink@copy-mmap-madvise-32
> > +msm_shrink@copy-mmap-oom-8
> > +msm_shrink@copy-mmap-oom-32
> > +msm_shrink@copy-mmap-dmabuf-sanitycheck-8
> > +msm_shrink@copy-mmap-dmabuf-sanitycheck-32
> > +msm_shrink@copy-mmap-dmabuf-8
> > +msm_shrink@copy-mmap-dmabuf-32
> > +msm_shrink@copy-mmap-dmabuf-madvise-8
> > +msm_shrink@copy-mmap-dmabuf-madvise-32
> > +msm_shrink@copy-mmap-dmabuf-oom-8
> > +msm_shrink@copy-mmap-dmabuf-oom-32
> > +msm_mapping@ring
> > +msm_mapping@sqefw
> > +msm_mapping@shadow
> > +msm_submitoverhead@submitbench-10-bos
> > +msm_submitoverhead@submitbench-10-bos-no-implicit-sync
> > +msm_submitoverhead@submitbench-100-bos
> > +msm_submitoverhead@submitbench-100-bos-no-implicit-sync
> > +msm_submitoverhead@submitbench-250-bos
> > +msm_submitoverhead@submitbench-250-bos-no-implicit-sync
> > +msm_submitoverhead@submitbench-500-bos
> > +msm_submitoverhead@submitbench-500-bos-no-implicit-sync
> > +msm_submitoverhead@submitbench-1000-bos
> > +msm_submitoverhead@submitbench-1000-bos-no-implicit-sync
> > +msm_recovery@hangcheck
> > +msm_recovery@gpu-fault
> > +msm_recovery@gpu-fault-parallel
> > +msm_recovery@iova-fault
> > +msm_submit@empty-submit
> > +msm_submit@invalid-queue-submit
> > +msm_submit@invalid-flags-submit
> > +msm_submit@invalid-in-fence-submit
> > +msm_submit@invalid-duplicate-bo-submit
> > +msm_submit@invalid-cmd-idx-submit
> > +msm_submit@invalid-cmd-type-submit
> > +msm_submit@valid-submit
>
> I tested this patch with latest drm-misc/drm-misc-next and there was
> some failures seen for the newly added msm tests. I have updated the
> xfails with below commit,
>
> https://gitlab.freedesktop.org/vigneshraman/linux/-/commit/d012893597a661=
d6ebbb755bf2607dfb055524a1
>
> I will notify the maintainers about the flaky tests, update the url in
> the flakes.txt, and submit a separate patch for this change.

Thanks, it looks like you also have a relatively recent igt (there
were some msm_submit fails until I fixed the test)..

BR,
-R

> Regards,
> Vignesh


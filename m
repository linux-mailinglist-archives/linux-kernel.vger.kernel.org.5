Return-Path: <linux-kernel+bounces-20281-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90A4E827CC5
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 03:13:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0DECE285573
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 02:13:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9ADF2912;
	Tue,  9 Jan 2024 02:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iL1m7Rrq"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C27B28E8;
	Tue,  9 Jan 2024 02:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-55770379ed4so2307866a12.3;
        Mon, 08 Jan 2024 18:13:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704766394; x=1705371194; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GanZIXSi0lvbqxqGS2oZbCZuJ/1CzDIHjm38iw98S94=;
        b=iL1m7Rrq3PHVXP+sA7DVmJbgbgTNyLZonBjlYNaNAn6QVqrgyfl73DEWsCihzGoWrk
         hKYkO/4QpdwCCjchrQsEUVog6RkPC5pYJs5kh1VZSYX/4bM3egKRIuNCpGFrZEZJ5vWQ
         wI1uGSD1ICfid7u/ZEXEQi+dHGbtEZNNV2gT5fgXZPlgEucDk47EShGYvEyISPMRBLJz
         9t2jhaOSocTCSJLslx0fJ5CkQNHcUW5xd5EaKlcRtxSGtWZ+YIRscYuKCCovy9Wkrsxr
         ZTXoWr70GPVQqlMCIz5MtlDSyv4ddeoHGj09epUFrBCTR68RkKO0vqqwbTUP9vuN0hDB
         6UxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704766394; x=1705371194;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GanZIXSi0lvbqxqGS2oZbCZuJ/1CzDIHjm38iw98S94=;
        b=nqMFwfVAf/U3nn5y/Vrg7hnNYIo38jOjaHF0eSfw7TPWzesLZEiGQDoO8J41gWs3aH
         SH1lHuWQVyqBBzXTF9lmHVHdx6d9KJlgeMV+jHX99tJxLZh+vD76gLS63tPZwhC34WSd
         qMuy06BdPJTY2LsWcikTI/PXU11mPfy+VMaY7OC9rpbXDqYgIUzB+sT51vPq20VhN+vt
         0s2L2vqQHM3XTFzvx8C4DVUqpFeFWcTANo6Nywye4FqlvxrMi2CvT4enYa6iyYm8Cykw
         Zj43BAsMi3L8HPayiZgpTKjOBGG0wHeGFMrno0nI/iNUKEwq+JUotyZSsYfr3qCD0AT7
         z9Fg==
X-Gm-Message-State: AOJu0YzCn7ZyaATJY+OgnvcWS8dFzPDamIU607dBCrpdIXDN0mMjJs1n
	zicvSrtDZ2XY90De1+jO5oWVvPV8b/bIh5hR3xQ=
X-Google-Smtp-Source: AGHT+IHbPrN1RypImXOGgmrR3yfC9TeGq1oGmnJ6HbhZRd3v/jJrYwKGt00TwH3VeZzUkZlvncohucMcaq2bQKMhXzM=
X-Received: by 2002:a50:9993:0:b0:556:e686:ba4 with SMTP id
 m19-20020a509993000000b00556e6860ba4mr2112395edb.84.1704766393585; Mon, 08
 Jan 2024 18:13:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240108195016.156583-1-robdclark@gmail.com> <454873e5-1b5a-28d3-ffed-c1e502898d17@quicinc.com>
In-Reply-To: <454873e5-1b5a-28d3-ffed-c1e502898d17@quicinc.com>
From: Rob Clark <robdclark@gmail.com>
Date: Mon, 8 Jan 2024 18:13:01 -0800
Message-ID: <CAF6AEGuVk=a-SwHyVwqOew-+WAdH1Gt011H50kvkSBe1j5ri_A@mail.gmail.com>
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

On Mon, Jan 8, 2024 at 2:58=E2=80=AFPM Abhinav Kumar <quic_abhinavk@quicinc=
com> wrote:
>
>
>
> On 1/8/2024 11:50 AM, Rob Clark wrote:
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
>
> I do see that all these tests use igt_msm_dev_open() to make sure it
> opens only the MSM card.
>
> But if igt_msm_dev_open() fails, I dont see a igt_require() on some of
> the tests to skip them. So how will it safely skip on non-msm HW?
>
> Unless i am missing something here ....

hmm, at the time I added the initial msm tests, and
igt_msm_dev_open(), I verified that they skipped on intel.. but since
then I'd switched from intel to sc8280xp device for primary dev
device, so I'd need to re-test to remember how it works.  If these
aren't skipping on !msm, it is a bug

BR,
-R

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


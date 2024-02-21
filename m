Return-Path: <linux-kernel+bounces-74273-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 673D585D1EC
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 08:57:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89E361C240D2
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 07:57:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 725D73B787;
	Wed, 21 Feb 2024 07:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Hw98evi+"
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5AA63A269
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 07:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708502253; cv=none; b=nSxn02tdItNQEYwX68SZD9bhSt78E0zTFNraW2S5+z7E3LYFbXEfoJ2mPf2kwZNSFbj7mF5hHwbn4Ey8lFZy0VOz3nHb/5iEld7sOxVK5i57uFQr0JilKOQa1nUTpL0/G6NQq/kNa2kJxyDDE1BeEs3qRsjznTKRJrDor3OaDmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708502253; c=relaxed/simple;
	bh=AB54ClpKXDvpnrBLD+hTBZ/toGRg4PgxYjTpJQsitZk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WDx92jmuo+kUyFqWJGpLIU3Dqc5ZBWQoIQsBbRpUND5S+NiWZzXev8wCzXgzo2z4JA9txXKuCea5sWm/KdeJlmp76DJ1sJeqZGMkYbBYNhNgcW4SvKOLYCWm1QpkjqaQIOJIK7pPHN3vG81MJwPTWqMAJajaeZ3Yck03HuPAchY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Hw98evi+; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2d1094b5568so83437401fa.1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 23:57:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708502250; x=1709107050; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rIlfzaJtbpobJhT/QtQhJEs40EZRm7KSI11K44WZ/H0=;
        b=Hw98evi+Cbg3rz8tEpW4wffNzcGFFMwRwoz32v+o4tipPkNuhYivUJ6GCqhhh2MjVY
         Z6lxFS0nvxpn5FiiD7ZozJHK2I2eo8EWDgv0eRXw0aGpLNFjxZC/DuF71X4kLUOu4qcp
         TeQqhbFU5yDqpMaOM4loKpiXcQ/iNhS/R7kgDj3l32TEnNYZzUc4q2dIv2qYG9ky71z1
         CXZAsinK/hqbm0gkT08bJupJd+URmqQNcd3Jyx7J8CceJ8YJMcP1eT0mQKla8P4tNMNi
         FGEQ2QXjG2/5fgsXipEXr9p8+X+bNnbE9ZD81f1DzKlMLbaiGALEhXftNvnPIbtFx6xx
         MzjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708502250; x=1709107050;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rIlfzaJtbpobJhT/QtQhJEs40EZRm7KSI11K44WZ/H0=;
        b=RGDq1sTMaYFaPcK351KkG6fFvH7bCgBZo5YefOWvBdeCfR2uuxJWP675TnMAD8HGWL
         NS2gjSvuU2hqaSSwIyyVxw9Ld+IfMCabKCU0jufOuQa5t7snO9un4ABO3b/cDezDyav0
         RijLZebZFQeNcGydkILOtjjtzNoCsyxEexZ+1AgQZ9Lfo0LOrnMwcFCUMzV5oiu/zRpO
         WFPiR+6JUf+YNq6neNgchizJJPZ6HbIB7NEl5wka01adt76GMTYel4PZ6t+a8Z9epqYb
         ewZD4v5FVDliq3Pu/rvpDCKVyKyZldzO0/9vT8G9QH/JanLptCawwkdiP7TtZs3v/a/b
         45Kg==
X-Forwarded-Encrypted: i=1; AJvYcCU1GYz7kgJivYWiqDEAXuqKQ9na/f/iB5cAMs0VSmZgjR+BW5CZulzls/O1KOmtqRue3Bzd/pQ+TTs0z6czM1EieOsrN0/TPt1P+3NQ
X-Gm-Message-State: AOJu0YzJF8M1QwH6s85VoIx7tgYKt8vZJrpdZdNQv1uvHOBB0vwfQiGD
	wIn5ZeRhdV86zZh3/lbfIH6AWuEky7noWo8dtQSaoF6+r2I10++h/Zg/+vg9Q+R6KIGDiHacwWK
	KXccXZ5/eimnHlr/PRCQGLcU4IPFvJN/rf4k5Mg==
X-Google-Smtp-Source: AGHT+IFU9WdK5/zq4/rMxq2vlJNHhDSBEpgmu0q9In/YQA3as7Vz1CeWQcIVD/rwNBkHvTjNoYwp7+qN/PhC5L8OlwI=
X-Received: by 2002:a2e:9256:0:b0:2d2:51c9:ef4e with SMTP id
 v22-20020a2e9256000000b002d251c9ef4emr1078626ljg.11.1708502250005; Tue, 20
 Feb 2024 23:57:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240221061832.430-1-zhangfei.gao@linaro.org> <BN9PR11MB52763F2A7B45747622C9B17D8C572@BN9PR11MB5276.namprd11.prod.outlook.com>
In-Reply-To: <BN9PR11MB52763F2A7B45747622C9B17D8C572@BN9PR11MB5276.namprd11.prod.outlook.com>
From: Zhangfei Gao <zhangfei.gao@linaro.org>
Date: Wed, 21 Feb 2024 15:57:18 +0800
Message-ID: <CABQgh9G5QLY6_EHQiRVP=02-ONdcPQA6w-ryaN9OosdvhRoxyg@mail.gmail.com>
Subject: Re: [PATCH] iommu: Fix iommu_sva_bind_device to the same domain
To: "Tian, Kevin" <kevin.tian@intel.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	jean-philippe <jean-philippe@linaro.org>, Jason Gunthorpe <jgg@nvidia.com>, 
	"baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>, "Zhang, Tina" <tina.zhang@intel.com>, 
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, 21 Feb 2024 at 15:09, Tian, Kevin <kevin.tian@intel.com> wrote:
>
> > From: Zhangfei Gao <zhangfei.gao@linaro.org>
> > Sent: Wednesday, February 21, 2024 2:19 PM
> >
> > The accelerator dev can provide multi-queue and bind to
> > the same domain in multi-thread for better performance,
> > and domain refcount takes care of it.
> >
> > 'commit 092edaddb660 ("iommu: Support mm PASID 1:n with sva domains")'
> > removes the possibility, so fix it
> >
> > Fixs: '092edaddb660 ("iommu: Support mm PASID 1:n with sva domains")'
> > Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
> > ---
> >  drivers/iommu/iommu-sva.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/iommu/iommu-sva.c b/drivers/iommu/iommu-sva.c
> > index c3fc9201d0be..a95c8f3a5407 100644
> > --- a/drivers/iommu/iommu-sva.c
> > +++ b/drivers/iommu/iommu-sva.c
> > @@ -91,7 +91,7 @@ struct iommu_sva *iommu_sva_bind_device(struct
> > device *dev, struct mm_struct *mm
> >       /* Search for an existing domain. */
> >       list_for_each_entry(domain, &mm->iommu_mm->sva_domains,
> > next) {
> >               ret = iommu_attach_device_pasid(domain, dev, iommu_mm-
> > >pasid);
> > -             if (!ret) {
> > +             if (!ret || ret == -EBUSY) {
> >                       domain->users++;
> >                       goto out;
>
> -EBUSY is not a right indicator for reuse.
>
> It may simply indicate that the pasid has been used for other purposes
> e.g. attached to a domain different from what the caller expects here.

Thanks Kevin.

How about this

diff --git a/drivers/iommu/iommu-sva.c b/drivers/iommu/iommu-sva.c
index c3fc9201d0be..20b232c7675d 100644
--- a/drivers/iommu/iommu-sva.c
+++ b/drivers/iommu/iommu-sva.c
@@ -141,8 +141,8 @@ void iommu_sva_unbind_device(struct iommu_sva *handle)
        struct device *dev = handle->dev;

        mutex_lock(&iommu_sva_lock);
-       iommu_detach_device_pasid(domain, dev, iommu_mm->pasid);
        if (--domain->users == 0) {
+               iommu_detach_device_pasid(domain, dev, iommu_mm->pasid);
                list_del(&domain->next);
                iommu_domain_free(domain);
        }

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index d14413916f93..a16ade93db25 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -3551,7 +3551,7 @@ int iommu_attach_device_pasid(struct iommu_domain *domain,
        mutex_lock(&group->mutex);
        curr = xa_cmpxchg(&group->pasid_array, pasid, NULL, domain, GFP_KERNEL);
        if (curr) {
-               ret = xa_err(curr) ? : -EBUSY;
+               ret = xa_err(curr) ? : 0;
                goto out_unlock;
        }

if pasid is already attached, does not treat as error,
and domain->user++ in iommu_sva_bind_device.

Thanks


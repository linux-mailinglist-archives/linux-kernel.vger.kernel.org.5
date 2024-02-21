Return-Path: <linux-kernel+bounces-74315-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D67D85D2AD
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 09:39:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37C31284F1E
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 08:39:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A98EE3C499;
	Wed, 21 Feb 2024 08:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PILavZoz"
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14FAA3C493
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 08:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708504790; cv=none; b=CPBv4C4eub0iemf6NGwy36nRndjX9Q97dInNwqKfjgVdZJQ8BPzSu/pnz938G6z25Om/UH0ezcgy+x/mEoLlWWnB2qdM8h1BuhPL2LbfdnHXVfuTF8ul+c+HFDGP58N3YBowmhj6zqMrKdxu7KkL8ZNLMajCiOJu7Lv92VuTi0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708504790; c=relaxed/simple;
	bh=GUsh6EFsJ7PPrJAD0y3jO+1W1vxjRmmaExeG14jW4aA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D7hR7SVOSeGcgkFIEj9SC5/uD1CM3G/Rb7qpFKIw/6Tg6Hm+dqzPGwBzuL6gbs5gcFBJl6mCV0T9FVRimT0f6N/nB0x6tKHoJglIp90IutQZGIDXkUayEeHz0wag1RSv8jKWm34MzX6CiaOkWmV/u72PfJq9Rtqx7a7cGNijnog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=PILavZoz; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2d204e102a9so81441101fa.0
        for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 00:39:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708504786; x=1709109586; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5JFbebWnaOELZUkqxAEj6ANGpA9qZ0u3+xyV8xOnxaw=;
        b=PILavZoz3pyY1OOjMzzYVHTQ1ob1fo+MyEqtB0EJ7swj/UzLkMDYaTiP+n61v0rC7K
         oSYNLs8w+GbtrtMxe66p/VSuavlQNRrMexNwOQnGInQuZX0/2GEXzUtA3/seJFpLYiNk
         RBPgOmArfT90TRsnnxzToYhdAIiCF0fDDgaC8hLzjaKZ+446BObLtI0l0sVM50KY1AZg
         Qrj7IPRGYMaIm7dGNwp1jmH9SDC0pZiNsMkosVyaqzlTMgh0wNOSGgOL6b8/ZbmtZ0PM
         7qPqj1GUnCzDlXuVOkRyPYKNyZ+osA9pxo1HVT5PwLDMEOxX5xGvOTnR/yajYXclzPsN
         A2Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708504786; x=1709109586;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5JFbebWnaOELZUkqxAEj6ANGpA9qZ0u3+xyV8xOnxaw=;
        b=VvlGoZUPRrU9whVHFVYIg3SWYF3s0dvyRo1/8kTI8X1+UMXlRMmEAVoj9sajEabzoo
         CbJ69N+I0SqBQXzJhhZwlPUZEFBRML4BxDQMrT/4p6O6ZhuHKvMYXNjzJ7XV7k8PQL3+
         HR/XJob6MI4d0l/aJEvV7rytTesfc51zI8TSD9LAjIyvSLcT+q+PV5x7fedhd8UQkHJM
         k0/NGcgEIKpRQiH/IbWpc9MUO1y+Hu6x9T0GkIMM3TFz2qSkpqN4vg9hHM6IaDXNddpr
         q2YMUusW9eXzzEhGH8dzKX9SzC+Mhv883qiJzNTbU6k91sMZ2NrWmAIDBULUFxiMVpPu
         dPXg==
X-Forwarded-Encrypted: i=1; AJvYcCUxq4mFRZNha0J6hCr56RfA/gdfi1SRHGv9ZL+zlj5mStUkgf97qChbP8IquMlusRBIGZWqWnJVxNvmEXRJRAAEBQFpHd/bCnG1fUBZ
X-Gm-Message-State: AOJu0YxPL52wdaSs8AM4HcABIH9YAhfq1ViYpM/NO8056ZrdCahkc6Q5
	bfPVkvhrPtUEV3Z+WABoFqvU+111F6+h5abDcEhOr4u2IRZI6J4w3x58Jb78GlGU5lb4fl2IPKq
	CKxgfU8+6Xv0VI/o7itYoiNoPIhPpMMk7l8Wbkw==
X-Google-Smtp-Source: AGHT+IGaTNqW+dKRPVQ9KBU0Ci5gQ2Vz28gYpqB2lxGWQ/iKjd38xYAWHvl+7So3L6vVJc6Cuthmp1ZXWdegVKrdl6U=
X-Received: by 2002:a2e:be21:0:b0:2d2:289f:16f7 with SMTP id
 z33-20020a2ebe21000000b002d2289f16f7mr8827955ljq.49.1708504786146; Wed, 21
 Feb 2024 00:39:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240221061832.430-1-zhangfei.gao@linaro.org> <MW5PR11MB5881E20A89840306C977F3FA89572@MW5PR11MB5881.namprd11.prod.outlook.com>
In-Reply-To: <MW5PR11MB5881E20A89840306C977F3FA89572@MW5PR11MB5881.namprd11.prod.outlook.com>
From: Zhangfei Gao <zhangfei.gao@linaro.org>
Date: Wed, 21 Feb 2024 16:39:34 +0800
Message-ID: <CABQgh9FVe4MRCoSrxnbjr2kqfd-_N2JovD-12CB3BSV5YSFj8g@mail.gmail.com>
Subject: Re: [PATCH] iommu: Fix iommu_sva_bind_device to the same domain
To: "Zhang, Tina" <tina.zhang@intel.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	jean-philippe <jean-philippe@linaro.org>, Jason Gunthorpe <jgg@nvidia.com>, 
	"baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>, "iommu@lists.linux.dev" <iommu@lists.linux.dev>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, 21 Feb 2024 at 15:59, Zhang, Tina <tina.zhang@intel.com> wrote:
>
> Hi,
>
> > -----Original Message-----
> > From: Zhangfei Gao <zhangfei.gao@linaro.org>
> > Sent: Wednesday, February 21, 2024 2:19 PM
> > To: Joerg Roedel <joro@8bytes.org>; Will Deacon <will@kernel.org>; jean-
> > philippe <jean-philippe@linaro.org>; Jason Gunthorpe <jgg@nvidia.com>;
> > baolu.lu@linux.intel.com; Zhang, Tina <tina.zhang@intel.com>
> > Cc: iommu@lists.linux.dev; linux-kernel@vger.kernel.org; Zhangfei Gao
> > <zhangfei.gao@linaro.org>
> > Subject: [PATCH] iommu: Fix iommu_sva_bind_device to the same domain
> >
> > The accelerator dev can provide multi-queue and bind to the same domain in
> > multi-thread for better performance, and domain refcount takes care of it.
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
> > diff --git a/drivers/iommu/iommu-sva.c b/drivers/iommu/iommu-sva.c index
> > c3fc9201d0be..a95c8f3a5407 100644
> > --- a/drivers/iommu/iommu-sva.c
> > +++ b/drivers/iommu/iommu-sva.c
> > @@ -91,7 +91,7 @@ struct iommu_sva *iommu_sva_bind_device(struct
> > device *dev, struct mm_struct *mm
> >       /* Search for an existing domain. */
> >       list_for_each_entry(domain, &mm->iommu_mm->sva_domains, next)
> > {
> >               ret = iommu_attach_device_pasid(domain, dev, iommu_mm-
> > >pasid);
> > -             if (!ret) {
> > +             if (!ret || ret == -EBUSY) {
> If rebinding is allowed, how could IOMMU core know if this invocation is intended (like the multi-thread case mentioned in the commit message) or is mistakenly invoked?

I think it is the purpose of refcount, it should be no difference
whether same device or not.
Even different dev, IOMMU core can not make sure it is intended or
mistakenly invoked.

Add the limitation does not make sense.

Thanks


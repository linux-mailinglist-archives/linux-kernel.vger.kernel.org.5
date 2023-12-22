Return-Path: <linux-kernel+bounces-9474-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DFC781C62C
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 09:04:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D5707B23EBD
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 08:04:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1D1AC8EE;
	Fri, 22 Dec 2023 08:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DIK+4UVE"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8884C8CB
	for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 08:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-5cddc5455aeso750308a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 00:04:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703232279; x=1703837079; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RSJGTieZTI2o0XNImVzDExdWiaBLLH2frf+am817yDs=;
        b=DIK+4UVEmzYGON5DLK734XjhPX/R9z2rYbKBvZeusdjXLx9aZFYm7/iPcPknNSLzaK
         okNaL1u/4DD406V2uHhpasiY+pYZ9PhEIBOf4m5c3E3/c9KopX6HPS37t/YEqagdSYIT
         rTehCjXL8cs9NzT+/DxHpUWLXtPvDezHMIdvKPFXB6FQdo7gw+FylhBBdAECvgwB3o1J
         LLOs/XD+6tLtT8lcdIqjyZNdmGFSdD4Aaji/gcmaaWAScju+cBxassg13EkpEHe6HTE4
         Jm3LPCmTblehK9iq1KbH0mYkdosRkONubpguDkZtzCuSuW8dMLq/QOj/YuiDQnFCrB01
         AvhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703232279; x=1703837079;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RSJGTieZTI2o0XNImVzDExdWiaBLLH2frf+am817yDs=;
        b=IVGQcWhLnLtUHsbeMOe0vCrwmT+u3VBuxG07nOV8NehL51Gi77sJnDyjnfVAvJ5dbp
         n854p+1BHUx89eV3GeDifLmEAkuvBVIByNuILsWL5CmGAi10rBr04V3CGSqe9B5f9QqH
         7nQZWxizk+jftQbpGkfb9O3SoyFDgjJos5HQt4MdELAfzwbCnKqRkVIh6CqwKzIPmQiK
         wn7dhW8f5FVeWfMNf67H2jIUkr6wkndOsmMvEXoGtD+H8LPLSd3asbxcYg+pFw11fAH5
         pVsZyVEbxC/bKdIi1GaWSglm1kjTo6yUNtWG/q9ppfqsKE/ofHvOHCZcyTZ6YcqnYQQO
         ArvQ==
X-Gm-Message-State: AOJu0YyExELYPuOFXrpTa+lqyMqrDvoK/BYETDX1TMwQJr+PUyY5W+0L
	GRM9RBrlYf95AMtqedYUsYKaSB01qDaBpjYB9m8=
X-Google-Smtp-Source: AGHT+IEc3IToo0Ff46xmxPIkTd/vUXm0oliknG8/LzraNAEXPxu5LOz9KyzMZlk47hbt9oxK97Z3KS2fTvsqX6Gj7LI=
X-Received: by 2002:a05:6a20:8f28:b0:190:13db:f460 with SMTP id
 b40-20020a056a208f2800b0019013dbf460mr683061pzk.9.1703232279065; Fri, 22 Dec
 2023 00:04:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231220072529.1036099-1-tj@kernel.org> <CAJhGHyACBBW5wnYTTz7S+AgLMhLYOsfxTnN6VHodCgECqEFeEg@mail.gmail.com>
 <ZYTDz10ohj0kokum@mtj.duckdns.org>
In-Reply-To: <ZYTDz10ohj0kokum@mtj.duckdns.org>
From: Lai Jiangshan <jiangshanlai@gmail.com>
Date: Fri, 22 Dec 2023 16:04:27 +0800
Message-ID: <CAJhGHyDyWBCSH_41cU7TokbDTE=vknLjLKYMQUtN8LyUsvg9dw@mail.gmail.com>
Subject: Re: [PATCHSET wq/for-6.8] workqueue: Implement system-wide max_active
 for unbound workqueues
To: Tejun Heo <tj@kernel.org>
Cc: linux-kernel@vger.kernel.org, Naohiro.Aota@wdc.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 22, 2023 at 7:01=E2=80=AFAM Tejun Heo <tj@kernel.org> wrote:
>
> Hello, Lai.
>
> On Wed, Dec 20, 2023 at 05:20:18PM +0800, Lai Jiangshan wrote:
> > The patchset seems complicated to me.  For me, reverting a bit to the b=
ehavior
> > of 636b927eba5b ("workqueue: Make unbound workqueues to use per-cpu
> > pool_workqueues"), like the following code (untested, just for showing
> > the idea),
> > seems simpler.
> >
> > max_active will have the same behavior as before if the wq is configure=
d
> > with WQ_AFFN_NUMA. For WQ_AFFN_{CPU|SMT|CACHE}, the problem
> > isn't fixed.
>
> Yeah, it is complicated but the complications come from the fact that the
> domain we count nr_active can't match the worker_pools, and that's becaus=
e
> unbound workqueue behavior is noticeably worse if we let them roam across=
 L3
> boundaries on modern processors with multiple chiplets or otherwise
> segmented L3 caches.
>
> We need WQ_AFFN_CACHE to behave well on these chips and max_active
> enforcement breaks if we keep them tied to pool in such cases, so I'm afr=
aid
> our hands are tied here. The hardware has changed and we have to adapt to
> it. In this case, that comes at the cost of extra complexity to divorce
> max_active enforcement domain from worker_pool boundaries.
>

Hello, Tejun

The current "max_active enforcement domain" is just a historical
accident.  IMO, it is
better to change the semantics of max_active and the related alloc_workqueu=
e()
callers rather than add a large bulk of complicated code. Most of
alloc_workqueue()
are called with max_active=3D0, so it is feasible.

Thanks
Lai


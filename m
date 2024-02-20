Return-Path: <linux-kernel+bounces-72464-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E57685B3D9
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 08:22:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B14561C222E6
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 07:22:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87A125A4CF;
	Tue, 20 Feb 2024 07:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SLmjuL5s"
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85FD41E484
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 07:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708413759; cv=none; b=njBUow1AslFhDk8yqvCpPjkxD93FePz4nrPQ5syHBB2jxY/DedNhtsamQVv4mMKGC1cNY8/tcj3nZLz/sghUElKElRoiIku/djXn++ANir/p2RS0/Y02R+xK0bp+qbWQm1HYh2gHGnqtvgkobkXdnykVCPLwHEeZ4CCF33lqrtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708413759; c=relaxed/simple;
	bh=b222vclvkob3NRCk9QxpOicxtpPvY4cxVAORXbafAEg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QtWNDAmAXbRcgaj3KqBAvrzvnGsg30PXCKvhpo6XQfEfjAhNZBGClbdAguo4H5E0wRWUuzd5KMnyV6uEfhIS7toCzdjBqemDTG18XaemFDj6Nuyp3neAMxj/IZ+O8in9HdzWycttROwpGUqBWV/ekw9r8lXG0xiznDcOjp0khzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SLmjuL5s; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-5ce2aada130so4557232a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 23:22:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708413758; x=1709018558; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wxod4qrRSfYk+sPpZkKiGMAWRb398s7OUCfWg5ArY5k=;
        b=SLmjuL5s4aUgrq66gwjJDH/zfi6Rs3yjoU0XbfnOxoaE+KsQnT9Uh589yDPG+2pHbV
         7J3mwm+c0KkjWv41a6krON5NrCa2FLMMNXHDyNpvSqkhMNxYmxMH/BcI0jCX/XsL8E/w
         OHQISKWJTHaBw0W46hwVjs1p5zgQkk4sQGqqE7pclo0XFBNLaFTMLUoqB1rIo/6KrzCL
         9WuM5W7wlRYeZIto09LdY3aaSNJxyZs44A3ftdiytTrq9u+Tpe7ayeFtZTvNU3KFMo8G
         iroUZ+XsTbHRBN3rvSvHi0m/5u0OJ38/BXpuE5egFfJTrUz5l0r6Z6AH4e84bE0D5/hj
         FoDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708413758; x=1709018558;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wxod4qrRSfYk+sPpZkKiGMAWRb398s7OUCfWg5ArY5k=;
        b=B3LPWU3iOdbGIQxTq6k1IQfMtBBt5g1PFgcVzPoQMM6PkLafjqTHNpphsXirOcyHaX
         II62MbTDsrBP5qKr0C8BgR50y2YHz5oBXoUP7RTH2eEagEB1FA893Y8gugOGt+7tA8Fg
         95EYrNNADB/GmGFR25B/hP5IutrgNxpEuwWaa4F8xLlgc4gVx6/fVuY2G8aIAVD9HEbU
         zKBLKIlCi+5bH6N7ju0tDtmxxFGtcfPJrIGEm1QqSfy5CU61xE1wx7WacHD3VuWGf2FV
         9ZKzlWMY+h8zVdRrY+PBHIAWVK5ZWjPg/Bnoaqylk5GoC33rNW76FKuGe4HSrYADCSqV
         KZqw==
X-Forwarded-Encrypted: i=1; AJvYcCXYnLmhuTvYGa7Vsb14TwzElloiPQFmWMyz51HWLfE4KPweG7HpCyxJEbnhFwfGOR2wKds+nQdKofBDCj2RcwcduBGYHmEfWMcViwgR
X-Gm-Message-State: AOJu0YwJAR6RYQFxcZQ/AOZ/mASnqAC57vHpEdnsyzegKF9MoW/wjyOv
	DJVQgXmK950xzA+d3p6zdGyuWFmKq1ovWpjd1qlm6L/sFIcKbKl13/uarhzsgRDyUnKMCr2QTJA
	XJq7V0TWUPVm47FHM9df8utCVSg4=
X-Google-Smtp-Source: AGHT+IHFyPnzJ+FY3E/QF/DJJfxhj95ctTCNR1GxAEYwPIDldsoCmLsYLkoPqJ+wUV/c+Qac2yb9u9Wy60Y3slvKN38=
X-Received: by 2002:a05:6a20:9f43:b0:1a0:a61d:1230 with SMTP id
 ml3-20020a056a209f4300b001a0a61d1230mr5005465pzb.23.1708413757633; Mon, 19
 Feb 2024 23:22:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240216180559.208276-1-tj@kernel.org> <20240216180559.208276-13-tj@kernel.org>
In-Reply-To: <20240216180559.208276-13-tj@kernel.org>
From: Lai Jiangshan <jiangshanlai@gmail.com>
Date: Tue, 20 Feb 2024 15:22:26 +0800
Message-ID: <CAJhGHyCOgrU9TC9o97LpvAEL2p+Dgt=uN0mo01Gr7HadVSD-Ag@mail.gmail.com>
Subject: Re: [PATCH 12/17] workqueue: Implement disable/enable for (delayed)
 work items
To: Tejun Heo <tj@kernel.org>
Cc: torvalds@linux-foundation.org, linux-kernel@vger.kernel.org, 
	allen.lkml@gmail.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello, Tejun

On Sat, Feb 17, 2024 at 2:06=E2=80=AFAM Tejun Heo <tj@kernel.org> wrote:

> - A work item carries 10bit disable count in work->data while not queued.
>   The access to the count is synchronized by the PENDING bit like all oth=
er
>   parts of work->data.

It is 16bit disable count in the code.


> @@ -2417,7 +2437,8 @@ bool queue_work_on(int cpu, struct workqueue_struct=
 *wq,
>
>         local_irq_save(irq_flags);
>
> -       if (!test_and_set_bit(WORK_STRUCT_PENDING_BIT, work_data_bits(wor=
k))) {
> +       if (!test_and_set_bit(WORK_STRUCT_PENDING_BIT, work_data_bits(wor=
k)) &&
> +           !clear_pending_if_disabled(work)) {
>                 __queue_work(cpu, wq, work);
>                 ret =3D true;
>         }
> @@ -2577,7 +2598,8 @@ bool queue_delayed_work_on(int cpu, struct workqueu=
e_struct *wq,
>         /* read the comment in __queue_work() */
>         local_irq_save(irq_flags);
>
> -       if (!test_and_set_bit(WORK_STRUCT_PENDING_BIT, work_data_bits(wor=
k))) {
> +       if (!test_and_set_bit(WORK_STRUCT_PENDING_BIT, work_data_bits(wor=
k)) &&
> +           !clear_pending_if_disabled(work)) {
>                 __queue_delayed_work(cpu, wq, dwork, delay);
>                 ret =3D true;
>         }

It misses the same handling  at queue_work_node() and queue_rcu_work().

But it is bad idea to cancel or disable rcu work since it can be possibly
in the rcu's waiting list.

> @@ -4173,20 +4195,46 @@ bool flush_rcu_work(struct rcu_work *rwork)
>  }
>  EXPORT_SYMBOL(flush_rcu_work);
>

Thanks
Lai


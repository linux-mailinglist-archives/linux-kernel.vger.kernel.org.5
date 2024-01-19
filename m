Return-Path: <linux-kernel+bounces-30869-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF70983254E
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 08:54:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E1F4D1C2321C
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 07:54:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65FE8D52F;
	Fri, 19 Jan 2024 07:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i+yDnlwM"
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55622D51D
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 07:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705650879; cv=none; b=WfrRfF+7iBflWT3VBMC6nY8jse5FatXMydbaHLBubHcMUjZL5OxL4eHeYHyeh8+Ayggu7sWlhPvEze4YFvNRrrCuHRwEPr/kWxlspmU24J5AHbhkxRn9DlAfqacUr7wzLINzb8VmUMHRjq/Ik6zaeiL93RmrBS6Rd/mjNuk0Exs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705650879; c=relaxed/simple;
	bh=TLOwFX5jrZQPs0bsz+ewRSds7tHas/I4TQYyYrmiAVA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G2TRSPuRbmFwTaYWNxCs80hqt5PpZScwzS2nRCKB+jtgfFKMJpdegWIpYbPX49JIxQn8bGAcXarvVDtjOgc9ag3rZC2lR7vPoKPj3z2CHzceVUYhaxSxduY2Lv88FiYBfUWzQk0tNQqJaiHCxVo0lBr9xHZTDF2M2Q7lk0KPNS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i+yDnlwM; arc=none smtp.client-ip=209.85.161.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-5986cb7bb61so244681eaf.2
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 23:54:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705650877; x=1706255677; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=COoGIXfr6UuCD5ySliHbcFQ0LgxljeOpnTvSGfYRES4=;
        b=i+yDnlwMfBQUKgHJibqmtBxjoAxBLCCulEBL7B7gvjZxokQp8AFWYrmHsS+QaVze3R
         rMqn2JxQNM7KTsZAVSbzCecQhMBj5Q9CIyIrcmjth3+JTMkVzw6ExnnbF3laKeCrLd7p
         4hweME1fe/i6g7IadEMDmJkvTvEIfZHs9bUSDqOv5O9BuJSDSR28tbJeqCXPyFuuw6+H
         R2FjNc9A+cpe7h8uhtNLPqmzg4RF6ijEqy/VeTHoSWiW346Mp8Sw4MY8BpwVMIPdfjml
         yuEnsJYnQESl67O4K7De24nKFDYRha6R3AM98DtNnwmwVdGQ2pqLnGmXEDwJ0vMt4BXO
         wH1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705650877; x=1706255677;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=COoGIXfr6UuCD5ySliHbcFQ0LgxljeOpnTvSGfYRES4=;
        b=E4AXzuljF2EAZjtbK2czzfJMyvkK8g/uKWAfgz5S4I1KiOwMz9SIELOKEHBWjNZv+q
         hnGs9gWX75BE2WRL8+argdlJXJ3TZCg0vj5h8DI1ndn0s2SX10qCFWXM3QflCuiHCO5c
         LvQVlKHOameNwaw1YCeahcm9Awwjpw0XApj4iKXnTZaVUVMkBZQIEmxBBboB4ZWpKsU7
         vqK/3Kki4+9k5wauN2Ff6wuAIiLo8AQXYWiyXr30M87Dnfax4KDixTCHcVDmNmFPXSrx
         C1GxyNShHtXbKGuPIUNB87iTZkNTuWy0d3Pe3/LbtRENJOzYMI/Vms8rFsc1hlD1pYZ9
         x0+g==
X-Gm-Message-State: AOJu0YwA1IH9NOna64R9PP7XXFj3iT5Aclu9QnfLj/i0n9sIecGAEyoi
	zRI3ymjHbrYn6RQFoGfLJfhVhMWOpml2PYXLuUTtnMScxZMQI935M9gvnLV0Y/q/P90LhzYqJgN
	EaJ7UEPfimsIo0LlhEyLZQhT8Rn4wb+nqH6g=
X-Google-Smtp-Source: AGHT+IEjUQ3LrRcxhTtaE3exkNfb4mbyDL24JPTA8fu2zGjfi1Bk8d7VtTsbarybo2zT+cT93SCNaCzJyqM2KrbUpWw=
X-Received: by 2002:a05:6359:328c:b0:176:35c:9ed8 with SMTP id
 rk12-20020a056359328c00b00176035c9ed8mr1993981rwb.23.1705650877243; Thu, 18
 Jan 2024 23:54:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240113002911.406791-1-tj@kernel.org> <20240113002911.406791-10-tj@kernel.org>
In-Reply-To: <20240113002911.406791-10-tj@kernel.org>
From: Lai Jiangshan <jiangshanlai@gmail.com>
Date: Fri, 19 Jan 2024 15:54:24 +0800
Message-ID: <CAJhGHyDaNCoXaK4g4fKg3vfBYuQ7r+e8TT8ObrtT3nBcTeeuMg@mail.gmail.com>
Subject: Re: [PATCH 9/9] workqueue: Implement system-wide nr_active
 enforcement for unbound workqueues
To: Tejun Heo <tj@kernel.org>
Cc: linux-kernel@vger.kernel.org, Naohiro.Aota@wdc.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello, Tejun

On Sat, Jan 13, 2024 at 8:29=E2=80=AFAM Tejun Heo <tj@kernel.org> wrote:
> + */
> +static int wq_node_max_active(struct workqueue_struct *wq, int node)
> +{
> +       int min_active =3D READ_ONCE(wq->min_active);
> +       int max_active =3D READ_ONCE(wq->max_active);
> +       int node_max_active;
> +
> +       if (node =3D=3D NUMA_NO_NODE)
> +               return min_active;
> +
> +       node_max_active =3D DIV_ROUND_UP(max_active * node_nr_cpus[node],
> +                                      num_online_cpus());

node_nr_cpus[node] and num_online_cpus() are global values, they might
not suitable
for this particular workqueue and might cause skewed proportions.

the cache values:

pwq->pool->attrs->pool_nr_online_cpus =3D
cpumask_weight_and(pwq->pool->attrs->__pod_cpumask, cpu_online_mask);

wq->wq_nr_online_cpus =3D
cpumask_weight_and(wq->unbound_attrs->cpumask,  cpu_online_mask);

can be used instead. They can be calculated at creation and cpuhotplug.
pool_nr_online_cpus doesn't contribute to the pool's hash value.

Or the result of wq_node_max_active() can be cached in struct wq_node_nr_ac=
tive,
see the comment next.

> -static bool pwq_tryinc_nr_active(struct pool_workqueue *pwq)
> +static bool pwq_tryinc_nr_active(struct pool_workqueue *pwq, bool fill)
>  {
>         struct workqueue_struct *wq =3D pwq->wq;
>         struct worker_pool *pool =3D pwq->pool;
>         struct wq_node_nr_active *nna =3D wq_node_nr_active(wq, pool->nod=
e);
> -       bool obtained;
> +       bool obtained =3D false;
> +       int node_max_active;
>
>         lockdep_assert_held(&pool->lock);
>
> -       obtained =3D pwq->nr_active < READ_ONCE(wq->max_active);
> +       if (!nna) {
> +               /* per-cpu workqueue, pwq->nr_active is sufficient */
> +               obtained =3D pwq->nr_active < READ_ONCE(wq->max_active);
> +               goto out;
> +       }
> +
> +       /*
> +        * Unbound workqueue uses per-node shared nr_active $nna. If @pwq=
 is
> +        * already waiting on $nna, pwq_dec_nr_active() will maintain the
> +        * concurrency level. Don't jump the line.
> +        *
> +        * We need to ignore the pending test after max_active has increa=
sed as
> +        * pwq_dec_nr_active() can only maintain the concurrency level bu=
t not
> +        * increase it. This is indicated by @fill.
> +        */
> +       if (!list_empty(&pwq->pending_node) && likely(!fill))
> +               goto out;
> +
> +       node_max_active =3D wq_node_max_active(wq, pool->node);

It is a hot path for unbound workqueues, I think the result of
wq_node_max_active()
should be cached in struct wq_node_nr_active.

The result be calculated at creation, cpuhotplug, and changing max_active.


>
>  /**
>   * pwq_activate_first_inactive - Activate the first inactive work item o=
n a pwq
>   * @pwq: pool_workqueue of interest
> + * @fill: max_active may have increased, try to increase concurrency lev=
el

I think it is also legitimate to increase the concurrency level ASAP
when called from try_to_grab_pending() path.

Thanks
Lai


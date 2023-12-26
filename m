Return-Path: <linux-kernel+bounces-11434-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F09A81E636
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 10:14:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C6BAEB21D85
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 09:14:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D9804D110;
	Tue, 26 Dec 2023 09:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="akXipQlY"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32A044D109
	for <linux-kernel@vger.kernel.org>; Tue, 26 Dec 2023 09:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-28659348677so2727827a91.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Dec 2023 01:13:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703582031; x=1704186831; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g7QSJxelIZH4MlI/W09hKVF90XdVYg5Vx6AY6Oldr9I=;
        b=akXipQlYhUqqLcIwJMgYsUCDMLgf+dad45YQBdgDTzY5iUZDKO6rZGG3CTemXbtNaU
         pxIJo9Ej3Yplt7fjaIb7FTdcCU2JfjI1ILcHswGX/50TEBcIZ88wSICDeWhG/MkFFDSi
         MiyNOGEHlYMGsdm1L3rG/ew+8X4MMqoEXiZQ91AN04scyQFXWIcPlkMmRJFWMD0a2q+p
         iAA2UaiTb/ft6wuNCtGiEDbZonvB3V8/wFIBPkMMwKe6+bC1KsxtFjJ1gztdzWLhtllz
         H+HpG2Na5nTuDFv9dT1zXYIQ8tykfw3Ek2ZIJ7vuJ9wtuYIBF4faKjtuA+rBYszxzE4s
         hxEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703582031; x=1704186831;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g7QSJxelIZH4MlI/W09hKVF90XdVYg5Vx6AY6Oldr9I=;
        b=kGak4ALU2vnEqJ/GjjpM0reWSD5f01gTAjLTmaExOQ3vde1WiTp99BMP8e4Ja8FJwS
         kvLpz+yjczVV1QAReuTgIHxOBqRV2Ya/M9hhgY9XsVb7h6vabwL3RVbepPavZQWUt5LB
         c/nmlwnKDVjHnNXBzwQi9YUl0JZtHyKS7m9edflmvP3QdcTqAgIkFHh0HqmsMeaDjevq
         Hb312RB2wBsP3b8wY+B+IJYDJ1+e+H2bRqUedqeh4ykCMaVdSShF6sRhWLv1IQYFcXs8
         LWkoJcVcX09sm8aGj+Z+YhPjBpPNbL2Ko23t/dKU84QqLqlVK2zJNJzBdXEz9RiFP9Gw
         R9yA==
X-Gm-Message-State: AOJu0YwMLrOsPyX1OJkp+28jFwKiousIkV+QZU44advo2fwiuXb58JCv
	pXX2IG6n4GX0UMH+iLNo7cUN/lL1TNYGpY19Ae8pgt5k
X-Google-Smtp-Source: AGHT+IEOfcHJrcMXvoP0vdskNa7HcmS6SE9UpaTlMZqKQ1DzmGeIFGOVlo3Ms3z+tuh/iDsG1/spcsXJyG4xh1vyalk=
X-Received: by 2002:a17:90b:1810:b0:28c:5ed:d50e with SMTP id
 lw16-20020a17090b181000b0028c05edd50emr7908412pjb.34.1703582031450; Tue, 26
 Dec 2023 01:13:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231220072529.1036099-1-tj@kernel.org> <20231220072529.1036099-2-tj@kernel.org>
In-Reply-To: <20231220072529.1036099-2-tj@kernel.org>
From: Lai Jiangshan <jiangshanlai@gmail.com>
Date: Tue, 26 Dec 2023 17:13:40 +0800
Message-ID: <CAJhGHyB-8hU7W9HV1ctD67Q9d9o+tmhesYqtBcMEmO1+taF=cw@mail.gmail.com>
Subject: Re: [PATCH 01/10] workqueue: Move pwq->max_active to wq->max_active
To: Tejun Heo <tj@kernel.org>
Cc: linux-kernel@vger.kernel.org, Naohiro.Aota@wdc.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 20, 2023 at 3:25=E2=80=AFPM Tejun Heo <tj@kernel.org> wrote:

> +static void wq_adjust_max_active(struct workqueue_struct *wq)
> +{
> +       struct pool_workqueue *pwq;
> +
> +       lockdep_assert_held(&wq->mutex);
> +
> +       if ((wq->flags & WQ_FREEZABLE) && workqueue_freezing) {
> +               wq->max_active =3D 0;
> +               return;
> +       }
> +
> +       if (wq->max_active =3D=3D wq->saved_max_active)
> +               return;
> +
> +       wq->max_active =3D wq->saved_max_active;
> +

If a work item gets queued now, it will get scheduled earlier than a
previous queued one which is still in the inactive list.

To solve it, I recommend adding wq->queue_max_active which will be
updated after the following code and used only when queue_work().
But it requires round-robin through PWQs the second time after
wq->queue_max_active is updated to catch the new inactivated items.

Or just keep pwq->max_active and will be
updated after activating inactivated items and used only when queue_work().


> +       for_each_pwq(pwq, wq) {
> +               unsigned long flags;
> +
> +               /* this function can be called during early boot w/ irq d=
isabled */
> +               raw_spin_lock_irqsave(&pwq->pool->lock, flags);
> +
> +               while (!list_empty(&pwq->inactive_works) &&
> +                      pwq->nr_active < wq->max_active)
> +                       pwq_activate_first_inactive(pwq);
> +
> +               kick_pool(pwq->pool);
> +
> +               raw_spin_unlock_irqrestore(&pwq->pool->lock, flags);
> +       }
> +}
> +


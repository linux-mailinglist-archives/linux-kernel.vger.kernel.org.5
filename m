Return-Path: <linux-kernel+bounces-93234-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 162E4872C9C
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 03:16:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A88181F24AB2
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 02:16:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBEABD29B;
	Wed,  6 Mar 2024 02:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S79MatNa"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA96B803;
	Wed,  6 Mar 2024 02:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709691358; cv=none; b=rsfnZRwGX4U6bkoasfdicYvze4stDkUMQB4S80l7SWTuTxI4BTYvWt4jVHxRIwbS36s/0rsIUvOqs7FdcOqACqbtl0oMRSNmTdzK8TwKQkJry+7NY71VaMWaG4vofxtnjoqfB/8ptRrqOjPKSQUI6i3du137k1PHoYfj732ewOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709691358; c=relaxed/simple;
	bh=zsT1art2pa9FxkggI3wINywVEeEIWQ8MMv5Okw6/BJ0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L6EDTYWjm0Kj67vy8y+MmHdWiHQVKofTd2yR4JRUMPwRRRNvH88qwwIfqXuhX5Y3G48V50MpigzDVxvUJMfzntTMOeeSJQu0NjJ8/e/rKWvPrMSOER8pneOlV6h17FXet9NUTWeFT6jYxxldILFQOTk+QQIe7ZyDOlsqbXQVFQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S79MatNa; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-6e62c65865cso358240b3a.2;
        Tue, 05 Mar 2024 18:15:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709691356; x=1710296156; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=y6Qx3X0GLi0+l77gIQgv6THAb5CE72jUcqwfVwLAq2E=;
        b=S79MatNaGVbNG38M2db3uH0asz9cRGk4vAAOl6RGU88qjSfoNvJnyhhJ7FURscSVr8
         DWUj7U1RNcfeltnDvREqwjh5F1F9/h34IRxXAY/Zmy8+vl+KTBZvn4sT6MDI8rAOsOAH
         eq5ba0kCPnCZ2g5eN/cERwBAZ4TrEb4145F4Zcu4Q+f6TW/u98/uIYs0ksa0NX9+IZOp
         kClxk5vKYKYwoVm2cgG9tDkQ+kh0Tbhbm3GCt2wMrLerBR4pM0I6l/1vhigvef8k1HqW
         pInRHtwmFuTGdw2hz3I7fV+v+KwtIbXn98jJ54+mjEoQuyvQt7qBbah9QWrJK1/L/DKB
         EuPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709691356; x=1710296156;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y6Qx3X0GLi0+l77gIQgv6THAb5CE72jUcqwfVwLAq2E=;
        b=rtFZc3q7cCK4fCXIrQkZmnJ5AfAc2gitIxE5Bd9F5zZ7Q3bemohEjD+SlTN5mAq+Eh
         8sZDbj8pGwYeACUOdJATen7KCj+0Tu9PX6pqm9pm6kbH2emddsy6CXE35a16uKm1VUn4
         TdaDt0P0WhD9taEZz/qnonwOitJsQaigaYvthsDfThD0Yr80Aj9j0FAt2u0PGPQm7vQ8
         TBU7QGbADIbopv6UErGEPC4P7XitkdnHFjeGN19cCDW6mpi6hNunZqkeXgG+ykKC5rSO
         /54gKyzbJs6oTlfIOSeYaBV9+glVYyRXuJh6IyEVDjeTdJjAc756mwnX5b3UnX7RNABl
         ssYw==
X-Forwarded-Encrypted: i=1; AJvYcCXDhGjeEHlwWcIJh39kK14jNHW9PE/K0/uZUZ7ST+K7P6VAlaEVl/Muv7csFU4a+7mJ/X6+hyzhuEhYo4FAhfTXbsaQ+ECSW/G293cOGcsFE+e2KsIuG+4V7uEYMY+8L5RR
X-Gm-Message-State: AOJu0Yygi4lnk04/IP070tEQHlQvbvmhjBom0z5CTbdrupG0wPFfj4eN
	cJUkkt6KCljtg3w2vGrj8WKZka2v4xtz6q2w4gGl6rVBY1Xfo2n8MBl8Etc1w/J6WvmO12Awf5H
	eQOqX5GYlvrXVmRKFaexdhThtcwU=
X-Google-Smtp-Source: AGHT+IFP0PrYA9dEBRvX8TusnjWb7U1g5JIK+cYOvxhHC1/RXfsHFb2OAND0NXWpIn+Hdk4GnKm/sKX8MsAyuQKGOhI=
X-Received: by 2002:a05:6a20:4386:b0:1a1:4d3d:e221 with SMTP id
 i6-20020a056a20438600b001a14d3de221mr4955222pzl.58.1709691355996; Tue, 05 Mar
 2024 18:15:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240305195720.42687-1-urezki@gmail.com> <20240305195720.42687-2-urezki@gmail.com>
In-Reply-To: <20240305195720.42687-2-urezki@gmail.com>
From: Z qiang <qiang.zhang1211@gmail.com>
Date: Wed, 6 Mar 2024 10:15:44 +0800
Message-ID: <CALm+0cWiOfKR=Gci0dj=z4gT4vSbZ=ZzMfo+CxLZCFQzL1bjfQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] rcu: Allocate WQ with WQ_MEM_RECLAIM bit set
To: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Cc: "Paul E . McKenney" <paulmck@kernel.org>, RCU <rcu@vger.kernel.org>, 
	Neeraj upadhyay <Neeraj.Upadhyay@amd.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Hillf Danton <hdanton@sina.com>, Joel Fernandes <joel@joelfernandes.org>, 
	LKML <linux-kernel@vger.kernel.org>, 
	Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>, Frederic Weisbecker <frederic@kernel.org>
Content-Type: text/plain; charset="UTF-8"

>
> synchronize_rcu() users have to be processed regardless
> of memory pressure so our private WQ needs to have at least
> one execution context what WQ_MEM_RECLAIM flag guarantees.
>
> Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> ---
>  kernel/rcu/tree.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index 475647620b12..59881a68dd26 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -1581,6 +1581,7 @@ static void rcu_sr_put_wait_head(struct llist_node *node)
>  /* Disabled by default. */
>  static int rcu_normal_wake_from_gp;
>  module_param(rcu_normal_wake_from_gp, int, 0644);
> +static struct workqueue_struct *sync_wq;
>
>  static void rcu_sr_normal_complete(struct llist_node *node)
>  {
> @@ -1679,7 +1680,7 @@ static void rcu_sr_normal_gp_cleanup(void)
>          * of outstanding users(if still left) and releasing wait-heads
>          * added by rcu_sr_normal_gp_init() call.
>          */
> -       queue_work(system_highpri_wq, &rcu_state.srs_cleanup_work);
> +       queue_work(sync_wq, &rcu_state.srs_cleanup_work);
>  }
>
>  /*
> @@ -5584,6 +5585,9 @@ void __init rcu_init(void)
>         rcu_gp_wq = alloc_workqueue("rcu_gp", WQ_MEM_RECLAIM, 0);
>         WARN_ON(!rcu_gp_wq);
>
> +       sync_wq = alloc_workqueue("sync_wq", WQ_MEM_RECLAIM, 0);

Why was WQ_HIGHPRI removed?

Thanks
Zqiang


> +       WARN_ON(!sync_wq);
> +
>         /* Fill in default value for rcutree.qovld boot parameter. */
>         /* -After- the rcu_node ->lock fields are initialized! */
>         if (qovld < 0)
> --
> 2.39.2
>
>


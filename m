Return-Path: <linux-kernel+bounces-80469-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E6CF18668C1
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 04:29:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 862181F21BBB
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 03:29:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C8441AACA;
	Mon, 26 Feb 2024 03:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Waze6uPe"
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C660199B8;
	Mon, 26 Feb 2024 03:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708918151; cv=none; b=fvGJ/nILcHfM+G6nwD//rSF5/K9XiQRG0gyXzajFcR+8LkG64LT7lOF5j8dOybYwvJNne5fee+A3hdXw0pEVcY/bjZkAK/28WuqUnaNWbxq8I03q/heCxk+EPA2e6YoKEbtY4c7KvPgbJc3kS9WrS1WFaFEKvAghmZp+m7JUgoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708918151; c=relaxed/simple;
	bh=x8zovaulEn/HAH7bnMcnnBNDnCrVZhsSYOA2M6ZtQdM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OORJyR8zKClTq7Pb9IcEKuJGz0iQLZu8++rGQ6BLtFwFl+9FG6dYB+UQLz+yuUp9Rua6TORmXnEuHshdgJA8XqSKwWCjguY+UjxPmE+mjtd0dMcRAcV8AbF04flA1B51FOAVmlobYvV5S97nbtRUK9n5TWtAwhFkM8C7s7AtYLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Waze6uPe; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-5dbd519bde6so2055052a12.1;
        Sun, 25 Feb 2024 19:29:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708918149; x=1709522949; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=dX0LOLTCVBgnueFQ0+1Jh8NOec5bVPxQjq+vsdWNMPo=;
        b=Waze6uPea5UYKpPvxc5h2kLqqUf/q/oH6CwtyYYVMUBXnau50kELx1PhQsRKAmM9nv
         aqcBYl82m8uZejt8Jq4FHTGP36I9bPC5qQfTb0cAYMUKcYzn/PpYLlxCL8fCbTiA+4jD
         lqWYE+qedkQ16C+MudhmKYNlJxx0J9qXYTcd7pVqDAMsBKnnG7GmTna5h65VPedhbNAy
         q879GTToCFV7CmihrFlqM1m1F1hZeGlOgbxcbwYUeJ28KERHI6ZENKP+5DyBi2U3slDv
         sSNX1DzPfbSmX+36ieSXX64mFAte3MNkphYCL34F9l6Jq1mFfeGnDI6z2EkCRd7LTSBy
         /VIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708918149; x=1709522949;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dX0LOLTCVBgnueFQ0+1Jh8NOec5bVPxQjq+vsdWNMPo=;
        b=MPN2ioPC4t0ionkk2r5EJdWr0s1muGK8A9I1E5g/ruNGR1LvtJ6a8H2y7ySuYX6UNU
         /tQ7hZ9OhTCgrBWb+rF7cjOGlWRwW6/fGhBQG6OTNcRmSbPmJKYK6qfOOxjO5lZeEyVB
         iPj+2zzXYgj2OGKBRNkOwIrByGrJfjvDb9OxMnVQjAe6Jdmo5jyBJJJPnVlaOLBFz5K+
         uRzT3rbxr2OUV8ma+3xXc6C1RG3Nj1kMVeldVcm62lS65e+AupVN3puViP+r10uHaQGL
         2hZ0FA0sGk1fUk184bHnYdl03UOToW8RyNjDjZiCM3Iy1LGst5+6eofuY1IYdAXwK/bd
         zk8Q==
X-Forwarded-Encrypted: i=1; AJvYcCWBApz36cdaCJQ6LlSnSla5TVAREv6bOeF20jqWDI/ZG7KLhg9ynn4L+jc5HdCZbPsaKWLvtqGzQ9FOyiS3jm4Ah+VnUtdnhfRtk5Re
X-Gm-Message-State: AOJu0YwEWXT+vdjACjqcqqSjyz5J5UDEu18afdliaJV1rMyu5+j0wDOt
	D8uFWlEFtdmEsJ82rX/oHHVodDa+X9cOZy4VFES7NbX0Z/11qHMgMdPGVZksFQTptF3ht9YEKip
	J0wNJ4J2mVkUdK7sXpMXzhsNowB0=
X-Google-Smtp-Source: AGHT+IEGiWfxPhpAJXl4R4BVI8PJmsNMNoSFGJRQFemsPm/bE/+hoNW9UPf873MzRrKPlHla7TRzIwYnBZMXABr01VU=
X-Received: by 2002:a17:90a:d489:b0:299:3f45:bd57 with SMTP id
 s9-20020a17090ad48900b002993f45bd57mr2806327pju.30.1708918149411; Sun, 25 Feb
 2024 19:29:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240226032439.26359-1-qiang.zhang1211@gmail.com>
In-Reply-To: <20240226032439.26359-1-qiang.zhang1211@gmail.com>
From: Z qiang <qiang.zhang1211@gmail.com>
Date: Mon, 26 Feb 2024 11:28:57 +0800
Message-ID: <CALm+0cXvWG2cP2sECzF9JGyUvvp0bBgSXA8NbGf896iMQEcCuA@mail.gmail.com>
Subject: Re: [PATCH] rcu-tasks: Fix the comments for tasks_rcu_exit_srcu_stall_timer
To: paulmck@kernel.org, frederic@kernel.org, neeraj.upadhyay@kernel.org, 
	joel@joelfernandes.org
Cc: rcu@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

>
> The synchronize_srcu() has been removed by commit("rcu-tasks: Eliminate
> deadlocks involving do_exit() and RCU tasks") in rcu_tasks_postscan.
> This commit therefore fix the comments of tasks_rcu_exit_srcu_stall_timer.
>
> Signed-off-by: Zqiang <qiang.zhang1211@gmail.com>
> ---
>  kernel/rcu/tasks.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
> index 78d74c81cc24..d5319bbe8c98 100644
> --- a/kernel/rcu/tasks.h
> +++ b/kernel/rcu/tasks.h
> @@ -150,7 +150,7 @@ static struct rcu_tasks rt_name =                                                   \
>
>  #ifdef CONFIG_TASKS_RCU
>
> -/* Report delay in synchronize_srcu() completion in rcu_tasks_postscan(). */
> +/* Report delay of scan exiting tasklist in rcu_tasks_postscan(). */
>  static void tasks_rcu_exit_srcu_stall(struct timer_list *unused);
>  static DEFINE_TIMER(tasks_rcu_exit_srcu_stall_timer, tasks_rcu_exit_srcu_stall);

Is this timer not necessary? any thoughts?

Thanks
Zqiang


>  #endif
> --
> 2.17.1
>


Return-Path: <linux-kernel+bounces-21877-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DE368295CC
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 10:08:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8F6E285B06
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 09:08:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAE583E47B;
	Wed, 10 Jan 2024 09:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Suk6RJz1"
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 900763C470
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 09:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-3bbce1202ebso3712389b6e.2
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 01:08:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704877704; x=1705482504; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ym61WoMwdcoWNDlZgG+Gv8v0SjajwyUWgyswEpOFxwo=;
        b=Suk6RJz1YSIw2pNzjCac5sVt7VIlY1cY8daq+GM6rNT0iCoIEFIDDkSsPasOlt8u7l
         GvbjtmBxPL0BRtXTtFtgWzR/uYke53dOCOzLka+qiiLaHz1KEx4LMw/uw2CRiCOugl9/
         0243PVv1WDM2/3lui46qsIsFKv43CM6tZ50X2cir0jpYOTFqD7/GLsWd0ehSB/r4nXXF
         NHUB82gAHFuZqXRrzKP7+m/G3D62fsCO9sKKez/jU3GjK4jayVI+ihZW4Vgt2OA1kC7a
         DAijnSLiQ9JfiOyPIPGSKY/SwQ84MXQXNsiB+GPa1DxcuFdhIw5EDCF0inheMtQA/fRB
         oUAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704877704; x=1705482504;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ym61WoMwdcoWNDlZgG+Gv8v0SjajwyUWgyswEpOFxwo=;
        b=LeqicF/shjjhBIGWSCDsv3owOm02JNq/fFnGrO1hb4+as5638a9B1CAg3QwXCJTbic
         HQHm07ID+cki5o6/JvjE4nGMma9u9N0FLL9FJlQeL7t3ZviM1Eo2BzZxpPxYeaRmuEUo
         4zCqCf4pLcFAIzL5UW6ErW7g27gg+bcxPFYiK5HJmJXqpyO23Ehqb8Rb4Rw2GtTI4ism
         W6zpv0o66q/0Zn5shx9CD5dumnh0lakX5rPSxi1ZF8Q9TZK5qJa7inPSdejh9Kg4QXTd
         kXlY/krVWEdr7ppfwL8kqQFQ8DOzj+1W69TR2a8nD6UcyUA3QHGEPwIiDHYLOJQiTsfi
         q8pg==
X-Gm-Message-State: AOJu0YyalGNTneM0HCJbzJD97y92popMCLiESPFB8t++BQK1p0ubYYq6
	H0E1E6hSuJWqeWpAbGPQFyQ+TedIMN4nI01cBso=
X-Google-Smtp-Source: AGHT+IGTpLlK8CnR71lDZ67+JW2ozXwa96qeIzqjWJscWmyiIqNmVmT2z+Hi8sqFJQkcGrYGXm52JjfyK8qdhG3aGCc=
X-Received: by 2002:a05:6808:1295:b0:3bd:1ff9:b430 with SMTP id
 a21-20020a056808129500b003bd1ff9b430mr859343oiw.61.1704877703750; Wed, 10 Jan
 2024 01:08:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <9bed61e4-7c08-4c61-a7e4-bdd39335cec1@redhat.com> <20240110032724.3339-1-xuewen.yan@unisoc.com>
In-Reply-To: <20240110032724.3339-1-xuewen.yan@unisoc.com>
From: Lai Jiangshan <jiangshanlai@gmail.com>
Date: Wed, 10 Jan 2024 17:08:12 +0800
Message-ID: <CAJhGHyCPCLhQ_70g+JFRc=r6MdYZb-qMkJF9NhZgi88ygo2R1w@mail.gmail.com>
Subject: Re: [PATCH v2] workqueue: Add rcu lock check after work execute end
To: Xuewen Yan <xuewen.yan@unisoc.com>
Cc: tj@kernel.org, longman@redhat.com, ke.wang@unisoc.com, 
	xuewen.yan94@gmail.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 10, 2024 at 11:27=E2=80=AFAM Xuewen Yan <xuewen.yan@unisoc.com>=
 wrote:
>
> Now the workqueue just check the atomic and lock after
> work execute end. However, sometimes, drivers's work
> may don't unlock rcu after call rcu_read_lock().
> And as a result, it would cause rcu stall, but the rcu stall warning
> can not dump the work func, because the work has finished.
>
> In order to quickly discover those works that do not call
> rcu_read_unlock after rcu_read_lock(). Add the rcu lock check.
>
> Use rcu_preempt_depth() to check the work's rcu status,
> Normally, this value is 0. If this value is bigger than 0,
> it means the work are still holding rcu lock.
> At this time, we print err info and print the work func.
>
> Signed-off-by: Xuewen Yan <xuewen.yan@unisoc.com>
> ---
> V2:
> - move check to unlikely() helper (Longman)
> ---
>  kernel/workqueue.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/kernel/workqueue.c b/kernel/workqueue.c
> index 2989b57e154a..c2a73364f5ad 100644

Reviewed-by: Lai Jiangshan <jiangshanlai@gmail.com>

> --- a/kernel/workqueue.c
> +++ b/kernel/workqueue.c
> @@ -2634,11 +2634,12 @@ __acquires(&pool->lock)
>         lock_map_release(&lockdep_map);
>         lock_map_release(&pwq->wq->lockdep_map);
>
> -       if (unlikely(in_atomic() || lockdep_depth(current) > 0)) {
> -               pr_err("BUG: workqueue leaked lock or atomic: %s/0x%08x/%=
d\n"
> +       if (unlikely(in_atomic() || lockdep_depth(current) > 0 ||
> +               rcu_preempt_depth() > 0)) {
> +               pr_err("BUG: workqueue leaked lock or atomic: %s/0x%08x/%=
d/%d\n"
>                        "     last function: %ps\n",
> -                      current->comm, preempt_count(), task_pid_nr(curren=
t),
> -                      worker->current_func);
> +                      current->comm, preempt_count(), rcu_preempt_depth(=
),
> +                      task_pid_nr(current), worker->current_func);
>                 debug_show_held_locks(current);
>                 dump_stack();
>         }
> --
> 2.25.1
>


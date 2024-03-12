Return-Path: <linux-kernel+bounces-99861-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4660D878E78
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 07:10:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DAB9DB21B21
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 06:10:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E05C032C84;
	Tue, 12 Mar 2024 06:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kLvn/sNX"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F01A2B2D7
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 06:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710223844; cv=none; b=I66gWhKupu15H+HKjq1yVd/lV9bTklTIVgYXZ6/s7W69DPyYHTXnHci9hpMNIXS07CiMtAu3fszA+jkmouOIqKgeCI2Y50SNkPqI0E5ymAA6IRstbDRR+bipdz45WZ1PVtobu75i9o57wMcb15/O49A5Y6dBn9b31DLgNoN6dT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710223844; c=relaxed/simple;
	bh=ybFLnM3llydQ6uM4aNUokd81z0UHkzUojJ+qFgNSA7I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mTKsoSORk8lW9rfROuV13yIjPag1SYoVM1XXJsvVUWq+RSBjcd4fUBy/8T5h2kgz1YCW+rbLmibiUNJCHXNX6IxRLyuCWfjIC9y050CxgOWQ3kfNFHRSeyELhSJQtLaop+DYiLhSSpBLfyj8H1Vsa9DHQU/VpR4GyFzk3DTwVdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kLvn/sNX; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-33e94c12cfaso1667607f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 23:10:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710223841; x=1710828641; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZUZJaWEEzxX+GNg6McoSX4YnqqxS5sF5DN1FsZZbsHc=;
        b=kLvn/sNXYVmWqo512ANyBiLcjl92WNGy4Krm3uWBmH4SrpcF48Bif2VDwY+J9wEfSx
         Vf2ixCaZyxLRpmXwVujiOGFH0b6VMN/fd8NnS+ZSX4B1wHB3YlI/ivYNrfwvAkt5V0Zg
         4kknmz/aHvI5LuOIf3WyuubNk8xAa7gBn1s8KxWF32YJymqqJ/kFhTBwH3IEfpAuje6s
         v3UvoF7Z+UxIZaanbW9QS5bHUMgABhp/Cq1hytG/8D8blygyOsAcRQDHw9e5O5Ul334S
         k5czx8Ev2mAqyTKfgU4djGOnWW9SmVwnXWya//9c03GIKri3igidujJMKBDQS03SXdJ1
         FWIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710223841; x=1710828641;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZUZJaWEEzxX+GNg6McoSX4YnqqxS5sF5DN1FsZZbsHc=;
        b=Ah9SX5kcalUM4ovvWtfoD/QybW3z1TPsL6zHP2nX2OpGUO/qU3Ppe9lxl5P2VcEU6z
         0defBYdAkbaYXecJi9vK9XZW0s4q5NOukGWyvWKlIxntWGQ/+HWXa+4zOI0Q3rCVlIw8
         QT36A1Q51iaU0dm6EoPI8p9T+L5re7jj7kczL4I8che0zk5wLlA524+KRh1h/mSm84MG
         Nii/xwf0Dmer4MfT8uHBpZp3VonxRx/xC6NK1CpNymEORt5RhWxvCpTvYVfW2czF1E24
         OLA+M5RGxT+x2wHNgdWyLwJZS8w9Wh8YEzGKslz3s9ddCojbU4FHbKbq6yqOurZsqQdQ
         UFag==
X-Gm-Message-State: AOJu0YzS3qGGIGIWFq/kqx9q/tfyH5IQF50QenW4/ZgqYCtRoUwWHAfZ
	EOt63nsst5jLk8dkh2Aekwhx64MJaOXCx3/MufyyJnoid8B2CwD5
X-Google-Smtp-Source: AGHT+IFhII0RnVeDG2q6voezxZ9wRRSKVU98hetONcUAJ3/c9K8So8Nln049xG0eBMfqizF1HbGzoA==
X-Received: by 2002:a05:6000:1866:b0:33e:818e:d05d with SMTP id d6-20020a056000186600b0033e818ed05dmr2362205wri.35.1710223840554;
        Mon, 11 Mar 2024 23:10:40 -0700 (PDT)
Received: from Levi-MacBook-Pro.local (host86-137-203-168.range86-137.btcentralplus.com. [86.137.203.168])
        by smtp.gmail.com with ESMTPSA id bq30-20020a5d5a1e000000b0033ea499c645sm973409wrb.4.2024.03.11.23.10.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Mar 2024 23:10:40 -0700 (PDT)
Date: Tue, 12 Mar 2024 06:10:38 +0000
From: "levi.yun" <ppbuk5246@gmail.com>
To: hannes@cmpxchg.org, surenb@google.com, peterz@infradead.org,
	mingo@redhat.com, juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] psi: Fix avg trigger being fired unexpectedly.
Message-ID: <Ze_x3kovSFe4z9SO@Levi-MacBook-Pro.local>
References: <20240226211237.48415-1-ppbuk5246@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240226211237.48415-1-ppbuk5246@gmail.com>

Gentle ping..

On Mon, Feb 26, 2024 at 09:12:37PM +0000, Levi Yun wrote:
> commit 915a087e4c473("psi: Fix trigger being fired unexpectedly at initial")
> fixes unexpected event fired when group->total accumulated for PSI_POLL.
> But, for PSI_AVGS, win->value should be initialized with group->total[PSI_AVGS].
> Moreover, to get exact initial value for win->value, it should be set
> under each trigger lock to avoid concurrent changes to group->total[].
>
> Signed-off-by: Levi Yun <ppbuk5246@gmail.com>
> Acked-by: Suren Baghdasaryan <surenb@google.com>
> ---
> v2: Fix commit message.
> ---
>  kernel/sched/psi.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
> index 7b4aa5809c0f..e7f66ab2ad3e 100644
> --- a/kernel/sched/psi.c
> +++ b/kernel/sched/psi.c
> @@ -1323,9 +1323,6 @@ struct psi_trigger *psi_trigger_create(struct psi_group *group, char *buf,
>  	t->state = state;
>  	t->threshold = threshold_us * NSEC_PER_USEC;
>  	t->win.size = window_us * NSEC_PER_USEC;
> -	window_reset(&t->win, sched_clock(),
> -			group->total[PSI_POLL][t->state], 0);
> -
>  	t->event = 0;
>  	t->last_event_time = 0;
>  	t->of = of;
> @@ -1336,6 +1333,8 @@ struct psi_trigger *psi_trigger_create(struct psi_group *group, char *buf,
>
>  	if (privileged) {
>  		mutex_lock(&group->rtpoll_trigger_lock);
> +		window_reset(&t->win, sched_clock(),
> +				group->total[PSI_POLL][t->state], 0);
>
>  		if (!rcu_access_pointer(group->rtpoll_task)) {
>  			struct task_struct *task;
> @@ -1361,6 +1360,9 @@ struct psi_trigger *psi_trigger_create(struct psi_group *group, char *buf,
>  	} else {
>  		mutex_lock(&group->avgs_lock);
>
> +		window_reset(&t->win, sched_clock(),
> +				group->total[PSI_AVGS][t->state], 0);
> +
>  		list_add(&t->node, &group->avg_triggers);
>  		group->avg_nr_triggers[t->state]++;
>
> --
> 2.39.2


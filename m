Return-Path: <linux-kernel+bounces-15294-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1E438229D5
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 10:01:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E4A3285150
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 09:01:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 214F5182AB;
	Wed,  3 Jan 2024 09:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lqAUSpyi"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 602E518624
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jan 2024 09:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-28bc8540299so4555930a91.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jan 2024 01:01:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704272506; x=1704877306; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xGznX7WYH4v+IstE717/QjOXmBKiMPgM0a6SaDcyCWk=;
        b=lqAUSpyi/IeRW1wDUrAtf6WbQXckWuP1dKSxW8EeCsne5eYNwq3rKDAcx7njA3o4FR
         JuAFJ8esMxw2mJH88SXACreOp/RP7gxXl4MDOmvH5hKccUyPcqb+ArlvzC32KAAM9TcY
         9kQbjzp0bSZkh3kFesZonrQGjYFIQg3Tu72zVUZYre/AO73q/Iv23bkZ6xjvpllZgbqK
         zphV1I4MOfNwJN10D3bB98sbmIw2Kz8GDKuugvWft+GVZmPW1o9gptAuR0l0B996H50R
         sXYw1hJcAgPI2E6oj+Ub/meXUn/zMfzZjicI1jyFFt3heshQQOST4bmwSfGzoArfk6nM
         IDfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704272506; x=1704877306;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xGznX7WYH4v+IstE717/QjOXmBKiMPgM0a6SaDcyCWk=;
        b=j4bks23Z/d9LOJLEqKoAEyaz/NLX5Yj3Cz1CqZI/lLvB78HrmKyi7C/KMTW9P1gv9d
         XYtYect6Qf3M7O5pZSryQaRxKX07CxNl4rjZo1xNxhwHa+UrbS5XazwPhf7HJcy2B8Zz
         rtqEnC+H9/fmVnAGNt4MwviFRaiZpJmhkMvFXfhqJUjdYl0e3By40+xhQLalhIiU+cgz
         09Cu1pXhbabNlQM7zqx9gGgoRHh8JaLygiWt3X9S+LZZULSRKyc4v6X2a6G19cW+vo0+
         kR2/lNUlctk4mxRmQBiFpHWec0oZlJAATZGcQ0IhkRslnBdZIfPbSrp1kiOvlI3QfsVw
         k51A==
X-Gm-Message-State: AOJu0YwnykYmmilzrmegG490KZcD2ZtPj0FD23VxFC995tUIEUo3Fo7q
	x225fB8WywRcoBvJn8bxvh+bj9SdorK+5Htci4Q=
X-Google-Smtp-Source: AGHT+IG/TkHGlE+KCz5Q/N6IXzIbXU6XAISaGjcot6U+D8okXS9K4oQuxa4lymqzb7V2xEeJ8eDWoMsZYJCoNthYcao=
X-Received: by 2002:a17:90b:1192:b0:28b:92da:a028 with SMTP id
 gk18-20020a17090b119200b0028b92daa028mr6639721pjb.60.1704272505529; Wed, 03
 Jan 2024 01:01:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231227145143.2399-3-jiangshanlai@gmail.com> <202401031025.95761451-oliver.sang@intel.com>
In-Reply-To: <202401031025.95761451-oliver.sang@intel.com>
From: Lai Jiangshan <jiangshanlai@gmail.com>
Date: Wed, 3 Jan 2024 17:01:33 +0800
Message-ID: <CAJhGHyAsg+AOY4GEE4m-7YA7YPf0hzqMgWTAVsr31Ob49VVXyw@mail.gmail.com>
Subject: Re: [PATCH 2/7] workqueue: Share the same PWQ for the CPUs of a pod
To: kernel test robot <oliver.sang@intel.com>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com, linux-kernel@vger.kernel.org, 
	Tejun Heo <tj@kernel.org>, Naohiro.Aota@wdc.com, 
	Lai Jiangshan <jiangshan.ljs@antgroup.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 3, 2024 at 10:55=E2=80=AFAM kernel test robot <oliver.sang@inte=
l.com> wrote:


Hello 0-DAY CI Kernel Test Team

> If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <oliver.sang@intel.com>
> | Closes: https://lore.kernel.org/oe-lkp/202401031025.95761451-oliver.san=
g@intel.com
>
>
> [   30.471685][    T1] ------------[ cut here ]------------
> [ 30.476998][ T1] WARNING: CPU: 111 PID: 1 at kernel/workqueue.c:4842 des=
troy_workqueue (kernel/workqueue.c:4842 (discriminator 1))

It hits the check here

        if ((pwq !=3D pwq->wq->dfl_pwq) && (pwq->refcnt > 1))
                return true;

Not only is the default pwq installed multiple times, but also other pwqs
with this patch.

Maybe pwq->installed_refcnt needs to be introduced to fix it.

Thanks
Lai


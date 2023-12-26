Return-Path: <linux-kernel+bounces-11677-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7393F81E9D8
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 21:07:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5AF21C22073
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 20:07:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EAFBF4F8;
	Tue, 26 Dec 2023 20:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MlIpRTM9"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72CDEF4E1
	for <linux-kernel@vger.kernel.org>; Tue, 26 Dec 2023 20:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1d3aa0321b5so38096965ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Dec 2023 12:06:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703621213; x=1704226013; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GlJrDfGXlC8aDxhiickf9+UJIH5+CIJx7SEuHxHkX6Y=;
        b=MlIpRTM9jmZGMCyktyYxXkTBzXZokbgg6Ar6/o1ZwZ11a7/vK0Lp7tBDF3wEEASS+w
         DgwT4gDDlAPgnH5hdSVpaI7UZCZOG7I1F4QYFh448W6QmCdKHU/P5bQxfe+enRU8Vufj
         eQN4jXAUpak96Y1j+OUPqWjm8KiVC2cA2D1PxQBpcSnj/402D/0cYhBNJxuCxumV8kOL
         Db/lxwTcIcS+2ErD7MMwx+o3EOEiuYAICXn+XCgjUvudNptGca7KFq4HP40asaUU5w0S
         xjsEMnWVowKfShxpQiDCTxo52f58l1NUXmjnnhLgJ/u0ZoO5VqkpwWv1Upwc8EwpEcrE
         8bCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703621213; x=1704226013;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GlJrDfGXlC8aDxhiickf9+UJIH5+CIJx7SEuHxHkX6Y=;
        b=QcO1uKQaQb1y3k7+r8onoaM/k0P9JmE2sDBL5HZPYLagdMb7W/jFqLNsxLZlZToFiW
         jbS0nRCVjodRtbgn9vIpSETJcgc7ciE5vTZnpMhPhwsjpgvhc/yQVITv0/W5Q0onwXKF
         9Dd99Gzno6hP2YFtPl6nTMKlbVG9RDBWkBmAO0lrlYVNLkh2ucT6NEczhAgcWIdP5Xpk
         bnxOhd3blihT36rJ13xZyHJOjFfCB0sbkynxKpwq3yiXzMy2MIgAFOYY4gFzo7TpUw8g
         R9DwP66Lg2ZTuQb+gvePn7zMex+cZ9Mo6aig2WqOT3fgm1kbVEuhohuKMVfgx/eP9lFH
         5dgg==
X-Gm-Message-State: AOJu0YygknYIefaKo24HyaqZmEKFwJYEhbCOutEmUO9jpkAbyA5mJ4uX
	ywiYSbc8TMkDZ3Ok8b9DiBkU+p3Tsd8zFA==
X-Google-Smtp-Source: AGHT+IE5gyyGCz++veMCaqN5pRReaOCb60Hil68MhSHp/D1d/LW8iIANmxNHMuWOadL2/WXLSXGv2A==
X-Received: by 2002:a17:902:b097:b0:1d3:fb6e:f392 with SMTP id p23-20020a170902b09700b001d3fb6ef392mr7711397plr.14.1703621212569;
        Tue, 26 Dec 2023 12:06:52 -0800 (PST)
Received: from localhost ([121.174.67.130])
        by smtp.gmail.com with ESMTPSA id o17-20020a170902779100b001d09c539c96sm10362790pll.229.2023.12.26.12.06.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Dec 2023 12:06:52 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date: Wed, 27 Dec 2023 05:06:48 +0900
From: Tejun Heo <tj@kernel.org>
To: Lai Jiangshan <jiangshanlai@gmail.com>
Cc: linux-kernel@vger.kernel.org, Naohiro.Aota@wdc.com,
	kernel-team@meta.com
Subject: Re: [PATCH 04/10] workqueue: Move nr_active handling into helpers
Message-ID: <ZYsyWIVDoSFj9_ii@mtj.duckdns.org>
References: <20231220072529.1036099-1-tj@kernel.org>
 <20231220072529.1036099-5-tj@kernel.org>
 <CAJhGHyC4Qj7t=Emd65556r_g0fUbf9LWEA-1OKuwaDFTz8O50g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJhGHyC4Qj7t=Emd65556r_g0fUbf9LWEA-1OKuwaDFTz8O50g@mail.gmail.com>

On Tue, Dec 26, 2023 at 05:12:55PM +0800, Lai Jiangshan wrote:
> On Wed, Dec 20, 2023 at 3:25 PM Tejun Heo <tj@kernel.org> wrote:
> 
> > +static bool pwq_tryinc_nr_active(struct pool_workqueue *pwq)
> >  {
> > -       struct work_struct *work = list_first_entry(&pwq->inactive_works,
> > -                                                   struct work_struct, entry);
> > +       struct workqueue_struct *wq = pwq->wq;
> > +       struct worker_pool *pool = pwq->pool;
> > +       bool obtained;
> >
> > -       pwq_activate_work(pwq, work);
> > +       lockdep_assert_held(&pool->lock);
> > +
> > +       obtained = pwq->nr_active < wq->max_active;
> 
> It is better to use READ_ONCE(wq->max_active) here in case
> the compiler issues code to calculate "obtained" multi-time.
> 
> Theoretically, READ_ONCE(wq->max_active) is recommended
> from the patch1 in pwq_dec_nr_in_flight() and __queue_work()
> since there is no wq->mutex for them.

Yeah, good point. Lemme add WRITE/READ_ONCE() around max_active accesses.

Thanks.

-- 
tejun


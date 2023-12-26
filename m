Return-Path: <linux-kernel+bounces-11680-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 648B981E9DF
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 21:12:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 190691F22A2F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 20:12:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2639A442A;
	Tue, 26 Dec 2023 20:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="abyX8BZR"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33CAD23A8
	for <linux-kernel@vger.kernel.org>; Tue, 26 Dec 2023 20:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-35fff22678eso3972985ab.3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Dec 2023 12:12:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703621563; x=1704226363; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wJwIYEsVQViKfIj+EecPznBxiNi/eUaLQ/D4NQhs5lo=;
        b=abyX8BZR2waicXr1AWAE0qjnFIc0lUKXX5eC3v08xZaQMHJi3SxUCkUkmWxwD4U1a/
         6yzbci6oLg6V0aRxzrvNrtDqF2plxxXQhtuPMG6r2hiEzHhfI7RyFOnmS51yKvXEj4Jt
         sotnFeeH//GSRe2fu/bFPMPfcUerliZpVsHgPC4heNyd1dxCtw0ubaDLj5Pdce9L6+Ra
         ONhtKexFaYTF6AomohYeO8hsnuIgEHeiK3ribVAtYTux5JJ3fr5nHfmg/txHQn/9HQWg
         URqo/aeC0lej5OlJls2YbSXt/45pSaxwM5bPOB+xsjVlsXDhliwI4sjfUSB6SDgNtTts
         UstQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703621563; x=1704226363;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wJwIYEsVQViKfIj+EecPznBxiNi/eUaLQ/D4NQhs5lo=;
        b=hIjxHfKJuIYYY6zHmdts8Xjs3m+70Tjkefk5SRN6fs4SJ3HgIsBiX5B0l7++TfE/Iv
         hEhG17MV+xTpOcxGuHvQzzS9mIOCOn4aCXlawkZuYCEzzfGXa11CVM9l1NHR2eE8A9WS
         V+40GumdaQQb7wV2I2QR+FFbxO70Qk7Ybj0HVI8Nazl3kj/+zRRV0rhj7EJKFWcwGnaI
         CV8CMq1SUAoVh6gKoaDJscu5BH/UsAQg0l4EsggxkjjkOJJ8LVqtQEbh3AvgD/FGZUTn
         3Tq99XoG1GixE6fZ1CTm6aSG9dvMaM3M14Uy2kXOlXlOg16CnBN4v0NtA/JfnIw2JM/w
         sDpg==
X-Gm-Message-State: AOJu0Yx6Wy+QuYu0BMRdccv63nWrG3tBSpl6zD4UbPKmmHe+EoFW8Nne
	YDS6lePYIaKGGCuE/nkwuPs=
X-Google-Smtp-Source: AGHT+IGscuyC7yFXNjB+qpge9YXspd1U6Eti9QSJahYkFu74iBUE9OTYCdyFKyG2+QI24lndGxYajg==
X-Received: by 2002:a05:6e02:5:b0:360:d9c:8777 with SMTP id bb5-20020a056e02000500b003600d9c8777mr2130339ilb.8.1703621563154;
        Tue, 26 Dec 2023 12:12:43 -0800 (PST)
Received: from localhost ([121.174.67.130])
        by smtp.gmail.com with ESMTPSA id jg13-20020a17090326cd00b001d398876f5esm10500002plb.121.2023.12.26.12.12.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Dec 2023 12:12:42 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date: Wed, 27 Dec 2023 05:12:40 +0900
From: Tejun Heo <tj@kernel.org>
To: Lai Jiangshan <jiangshanlai@gmail.com>
Cc: linux-kernel@vger.kernel.org, Naohiro.Aota@wdc.com,
	kernel-team@meta.com
Subject: Re: [PATCH 08/10] workqueue: Introduce struct wq_node_nr_active
Message-ID: <ZYszuHEX6Pb-K4Au@mtj.duckdns.org>
References: <20231220072529.1036099-1-tj@kernel.org>
 <20231220072529.1036099-9-tj@kernel.org>
 <CAJhGHyC_9JemZdv4Gp4XG7BqLc72bS1uM8xv9vpQtSsyhefZvQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJhGHyC_9JemZdv4Gp4XG7BqLc72bS1uM8xv9vpQtSsyhefZvQ@mail.gmail.com>

On Tue, Dec 26, 2023 at 05:14:18PM +0800, Lai Jiangshan wrote:
> On Wed, Dec 20, 2023 at 3:26 PM Tejun Heo <tj@kernel.org> wrote:
> 
> > @@ -1498,12 +1539,21 @@ static bool pwq_tryinc_nr_active(struct pool_workqueue *pwq)
> >  {
> >         struct workqueue_struct *wq = pwq->wq;
> >         struct worker_pool *pool = pwq->pool;
> > -       bool obtained;
> > +       struct wq_node_nr_active *nna = wq_node_nr_active(wq, pool->node);
> > +       bool obtained = false;
> >
> >         lockdep_assert_held(&pool->lock);
> >
> > -       obtained = pwq->nr_active < wq->max_active;
> > +       if (!nna) {
> > +               /* per-cpu workqueue, pwq->nr_active is sufficient */
> > +               obtained = pwq->nr_active < wq->max_active;
> > +               goto out;
> > +       }
> 
> For unbound workqueue, it is not checked against wq->max_active anymore
> and it is increased unconditionally.  Is it by design?

Ah, I made a mistake while splitting the patches. This gets added by a later
patch but this step should have an explicit check against wq->max_active.
Lemme add a check for the unbound path.

Thanks.

-- 
tejun


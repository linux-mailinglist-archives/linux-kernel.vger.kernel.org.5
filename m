Return-Path: <linux-kernel+bounces-11676-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FBC081E9D5
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 21:07:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31D371F22A6F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 20:07:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6326C4C89;
	Tue, 26 Dec 2023 20:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XW6b6OMZ"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5442C4C6D
	for <linux-kernel@vger.kernel.org>; Tue, 26 Dec 2023 20:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1d4751dcb56so2036875ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Dec 2023 12:05:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703621151; x=1704225951; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aambpf80hLN6U6ZAK3OoXRau7bcqwxmaExyUmVSQbBs=;
        b=XW6b6OMZFLMPGnbXWFTzXMQcJpzqo6sks2JRkHnrkuWv/xXR00YaVZeFMrSUkQ6TEN
         rYvz5i7skowfniU03h78kyNb86aKfLuPtTvi6APTO23ajHJo+pd23zHnXge14EIkUiPr
         Sk4LLyPybeSrkrc/gxSwihViVC7V98kOikbyqQegTOQFgvAr9aon8wSOEQvDEGAfSX7c
         TM7ZtVa6Ffx5oEXDecJPCMBDUmUi97RLMEAaZZF1k1CFiVAbAll8y9xMbA9mvGTYtY44
         4sP8IhzXEqqL3J7PakvdqFEzbWbmL9GBRkcvEGykf1MPyVkc9P4rQHJ9/p4s2c1vwnte
         2D8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703621151; x=1704225951;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aambpf80hLN6U6ZAK3OoXRau7bcqwxmaExyUmVSQbBs=;
        b=bXDGWSG1CEBfi5X2wLuu+7W6FmLB7vCBAT/ZjQ4oiNfbtGrSGmNs0gNcbzzJoc96ow
         u4oK8QCEkMZdInYXvpiVIll3HgCnZX6bUssALwwjRo+SsnEY6S8v1X8GySgIbBKqzLdT
         aXyZ77fToaRzlTVWBzWl8PlVLb7JU6lJPJ+auMX7m13VO+yu6d1+5442t5NU3k/IJaJZ
         QKk1znwLvHDm7bP6jsLMma3pU9G/fZ4M6IGoXZRPCC7pDYy/J5s6zINFMAqbwsvsAM/Y
         2OnMWBeboutLZqumpbU3RtmHHsT2ATYq0+J26BP0V/V/fhpieC06f/pCXZNfyhSioXPV
         1nww==
X-Gm-Message-State: AOJu0YztCcrHrBGvt9b3KbfV/b0OduiWWBaK2gqdpq7rPxkLWmSk3NOr
	/7fzXgqFwpu4xE9mK8vdC6M=
X-Google-Smtp-Source: AGHT+IFfBBhneh8TEjLgoywROWAmQJEYM04sn7+T39UIpzdim2rUiWz76hrb3ir73ECq2mpecmoogg==
X-Received: by 2002:a17:903:22c9:b0:1d4:4a0f:a6b0 with SMTP id y9-20020a17090322c900b001d44a0fa6b0mr1456841plg.16.1703621151399;
        Tue, 26 Dec 2023 12:05:51 -0800 (PST)
Received: from localhost ([121.174.67.130])
        by smtp.gmail.com with ESMTPSA id z16-20020a170903019000b001d0b6caddbasm10327405plg.291.2023.12.26.12.05.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Dec 2023 12:05:51 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date: Wed, 27 Dec 2023 05:05:49 +0900
From: Tejun Heo <tj@kernel.org>
To: Lai Jiangshan <jiangshanlai@gmail.com>
Cc: linux-kernel@vger.kernel.org, Naohiro.Aota@wdc.com,
	kernel-team@meta.com
Subject: Re: [PATCH 01/10] workqueue: Move pwq->max_active to wq->max_active
Message-ID: <ZYsyHZg6tMAtMp4Q@mtj.duckdns.org>
References: <20231220072529.1036099-1-tj@kernel.org>
 <20231220072529.1036099-2-tj@kernel.org>
 <CAJhGHyB-8hU7W9HV1ctD67Q9d9o+tmhesYqtBcMEmO1+taF=cw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJhGHyB-8hU7W9HV1ctD67Q9d9o+tmhesYqtBcMEmO1+taF=cw@mail.gmail.com>

Hello,

On Tue, Dec 26, 2023 at 05:13:40PM +0800, Lai Jiangshan wrote:
> On Wed, Dec 20, 2023 at 3:25 PM Tejun Heo <tj@kernel.org> wrote:
> 
> > +static void wq_adjust_max_active(struct workqueue_struct *wq)
> > +{
> > +       struct pool_workqueue *pwq;
> > +
> > +       lockdep_assert_held(&wq->mutex);
> > +
> > +       if ((wq->flags & WQ_FREEZABLE) && workqueue_freezing) {
> > +               wq->max_active = 0;
> > +               return;
> > +       }
> > +
> > +       if (wq->max_active == wq->saved_max_active)
> > +               return;
> > +
> > +       wq->max_active = wq->saved_max_active;
> > +
> 
> If a work item gets queued now, it will get scheduled earlier than a
> previous queued one which is still in the inactive list.

Is that a problem tho? There's no execution order guarantee except for
ordered workqueues which is not affected by this. In a later change, we
switch to list of pending pwqs instead of work items and the issue ordering
is lost anyway. This isn't a significant departure from previous behaviors
either given that there has never been ordering across pwq boundaries.

> To solve it, I recommend adding wq->queue_max_active which will be
> updated after the following code and used only when queue_work().
> But it requires round-robin through PWQs the second time after
> wq->queue_max_active is updated to catch the new inactivated items.

I'm reluctant to add complications for this given that it's not a real
problem to begin with and the operation is pretty cold.

> Or just keep pwq->max_active and will be
> updated after activating inactivated items and used only when queue_work().

This probably is simpler but would make things more complicated. I'm not
sure it's worth it.

Thanks.

-- 
tejun


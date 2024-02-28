Return-Path: <linux-kernel+bounces-85462-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DC10586B662
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 18:49:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6CDE7B209AB
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 17:49:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AD4215DBB9;
	Wed, 28 Feb 2024 17:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h1LC6XBg"
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2727215D5B7
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 17:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709142584; cv=none; b=s+SO9eCsf2u1iKaEU5SocWwheKcDByFwEy2Qrz6Uqn15wgzHwy4McR0+5lj4AXx+iI6Ew6SDbUC4H0c2crmVWGIkhrAvnu+5D4FLBsk/Xu4OKNROb7Inl4W3bgFkYKhmRqGKI2jtxpez+tIt8XaKTQ9DS/QjtIF9XCytI3HqS5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709142584; c=relaxed/simple;
	bh=aiCpn8taUPG/6hfrOL8LNXsnDnTILZ8krDHWgQRwNro=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eLI/+xnLVUNhtYwppCqfvKc7oocilSOZQEnnfXh+nFV3eMT3fDtpTSyc5APlDkikKneVbImdzupdxbSoBBJwUcz7VEn9NL6rkopO7A2tAX8C3/VYMRAI0ZzawLx7KH9f2L7mSqcQS6JJiPWpltdnCiBicv9BnSz+zhqzFeFq4vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h1LC6XBg; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-5d8ddbac4fbso4786475a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 09:49:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709142582; x=1709747382; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Wgce8+IUX8Vf5KfeSFtRbdPzreT5vev/67WMk2LksWQ=;
        b=h1LC6XBgDbQmcjsxROxNbMnLHtYfayEM9JPZV/niySYIMlauYzvBBugCC4u8EdOUWW
         J4EhmEisqdw9HcNnPn4ZISYngevHZjK1JMdr35N3Fr1MHdzOcSbAsscmiSaL/4wsxk1H
         BbJ4fKe2gXcNi+5FSFq2mCy5GzsKftJQgD9WGYD21cypOduxls/UQPM0a8IyR6o9N1+W
         qsz1Gzs8lH1hrlcl+Sm/htCmeKwZK6N1KSKo+rBZlf7e9if/C4K9sXyiflaWnpbqBvau
         ZAPqNpidgE+iuQNK7a9aXuXBhM4o8ei8z7LT35CsNNq+Hxm0p9ip96WBppTacMaO3483
         bf5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709142582; x=1709747382;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wgce8+IUX8Vf5KfeSFtRbdPzreT5vev/67WMk2LksWQ=;
        b=u7T0Q/OPG8GjUf0ZrgbMnar9yFBw7Bwgo8Lp9jfVLFQq8tfIYpr/UEzSS0+R4G4JWw
         hAo965/fedgAG5+mBkiT+VOcUb0DbXk1OCudvWEs0wIxXcmc+0/tMgyBovPgx/kuWETc
         1/FBjnPGCgClEWrXU4Dk0mqtRvuSxqawesHqpoJk7EJQqUXyh6SOOMLsr65gyTrPGj51
         6nBFX3sxTNUiWcHxwP87Ug4U8A7bYjTzvTrnZ6djfDZeD7WRE74OEarYkRTqKGYXWBD0
         8g2IMtKd6nZuXWpFb/M3dca2pCrMaHJn1n8KZv5B97wDACQ1hHfy+57k/vr6Mdyas/m+
         v8XQ==
X-Forwarded-Encrypted: i=1; AJvYcCWJUsrRW7sUTYaSf5KzyJU+HQ8P+q3T5FIaq4/R6pUmJjatpn/xYazkangGBtwRgrGj2eMpCg9jKZVvGbvUkUsbWAMfsAJtNMdT90aY
X-Gm-Message-State: AOJu0YxXk4aLXWZffEecse6spewZu/yij1G2VBjd8dbHbSQHDKvozPUM
	krsGZ6Lv5idDiJRx6htHdtKCK4UE1kZa0zkiS3Y5FJnpNTmqgXU27nqAO+M90ls=
X-Google-Smtp-Source: AGHT+IFrbgcODsI93neMpf5uYp7MPA+5JofzcKT075cEsL12XFmUFW97EhrMLw9KUEoFCsAzQhHvZA==
X-Received: by 2002:a05:6a20:9e4a:b0:19e:9a97:cb12 with SMTP id mt10-20020a056a209e4a00b0019e9a97cb12mr6735384pzb.54.1709142582484;
        Wed, 28 Feb 2024 09:49:42 -0800 (PST)
Received: from localhost ([2620:10d:c090:400::5:8305])
        by smtp.gmail.com with ESMTPSA id v22-20020a170902e8d600b001d7057c2fbasm3596413plg.100.2024.02.28.09.49.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 09:49:42 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date: Wed, 28 Feb 2024 07:49:40 -1000
From: Tejun Heo <tj@kernel.org>
To: Allen <allen.lkml@gmail.com>
Cc: jiangshanlai@gmail.com, torvalds@linux-foundation.org,
	linux-kernel@vger.kernel.org, kernel-team@meta.com,
	boqun.feng@gmail.com, tglx@linutronix.de, peterz@infradead.org,
	romain.perier@gmail.com, mingo@kernel.org
Subject: Re: [PATCH 6/6] r8152: Convert from tasklet to BH workqueue
Message-ID: <Zd9yNByiBMcPxWbU@slm.duckdns.org>
References: <20240227172852.2386358-1-tj@kernel.org>
 <20240227172852.2386358-7-tj@kernel.org>
 <CAOMdWSLVDaN_XFD6Ov-=6VrH4wyBz-0wq_L3EzgdsJ5zJi47qQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOMdWSLVDaN_XFD6Ov-=6VrH4wyBz-0wq_L3EzgdsJ5zJi47qQ@mail.gmail.com>

Hello,

On Wed, Feb 28, 2024 at 09:33:40AM -0800, Allen wrote:
> > @@ -6971,7 +6972,7 @@ static int rtl8152_open(struct net_device *netdev)
> >                 goto out_unlock;
> >         }
> >         napi_enable(&tp->napi);
> > -       tasklet_enable(&tp->tx_tl);
> > +       enable_work(&tp->tx_work);
> 
>   I think we are missing queue_work() above, right?
> 
>    To avoid such situations, could we combine enable_work() + queue_work(),
> into a single API?

Here, the device is newly being opened and the work item is just disabled
from the init. So, it doesn't need queueing.

> Perhaps, something like:
> 
> static inline bool enable_and_queue_work(struct workqueue_struct *wq,
> struct work_struct *work)
> {
>        if (enable_work(work))
>        {
>              queue_work(wq, work);
>              return true;
>        }
>        return false;
> }

That said, this may still be nice to have.

Thanks.

-- 
tejun


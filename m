Return-Path: <linux-kernel+bounces-56507-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 347A984CAFE
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 14:04:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF4B81F24141
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 13:04:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AB79768EF;
	Wed,  7 Feb 2024 13:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Ly1NyYWw"
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E09176059
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 13:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707311067; cv=none; b=u51nrFvK9NVj00QmqZ88VwfojWBDc+jlq8aI33UT24J+IN4Pfep7XSJqSfc0xlCspE6Rq8xx9Z7NaxCOCFQm7vnq62OfiBWqkIwIVn6G/v6t9VObEn27Rm940IkosfZNyHhzmxVFEfWQJAGeYI26Kb6HJtwjNf10Hf6hXB8o2Q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707311067; c=relaxed/simple;
	bh=gF3VcFxFiD1RkU0fj7v758VcLFQYwRIBzb5HxhOKpHI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i0teppka2aaboTmsR1/HhaGTRzDQ+qFlbHBE0ux/zt8REYJEG3Ouv9hL9zjcY2b8TC5imTqtaAQrwnCIQtM3zjb7fjhQfjvH+F9QzFPcQgsmf8kpB9iYMLcimxHPm1C2D01gKwpHbRL1szIvoAsHHQ7nJQ9mgSAhL70JEcQD9K4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Ly1NyYWw; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2cf3a095ba6so5330961fa.2
        for <linux-kernel@vger.kernel.org>; Wed, 07 Feb 2024 05:04:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1707311062; x=1707915862; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=x6nGer9hwb9V43aQD6TonkhwKDUWxh83YWENmNzzbSY=;
        b=Ly1NyYWwqqoWISfqFxNwYRuQ7nfXcB5WZAAFEFBxejzslmLjOYVK4huguYAmXYkBwB
         axtPW3pl3MXo40i6xMEu6lEvsWypzDmmlVbXLGg+GXGU2/YF7S739XEQ4ba8AVPm1ENB
         yMkaPrkvwTMEIMpUEylIPJQHShkLX8Sg1VkXBdCdnLlQKo7YWzkPmoLfxQ1/KWGxEAfJ
         rgAJq4N3zkXgJSorYfVV55LEH8guGa+TNt+HXWplf9uVvK+z7cm2xl59hgoZ/vWZ1BtI
         4sjQIJN/MgWcpP+NgJcx0umvCATEU2UZcZ00mFNPiRnm9gQqATxZ8xX56Qjc+vhSM9Us
         GXOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707311062; x=1707915862;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x6nGer9hwb9V43aQD6TonkhwKDUWxh83YWENmNzzbSY=;
        b=TGKP9V25ruNv97Ea/qXB+m3Zf7+veJqAoMKEB4ni7ItWfoSHfl9PvCFXPnJRqj160c
         j9QISNznRp1k2yrstNdRIUsZ13oNfuvvZP+7hG0Wg9zxuFl4u2uakku9cVzqqF//4sLM
         ydTAOEbqozyqhKx8Yp76wXE9ini3pQecAwvbrEWWCgKliwhyntkq0ZV8r0DobgfitxYE
         5YayVwpHvpdtRDB5xiCFEg4hml5cxg9CwMSw6AVt01EvS67LU2W2qUimJWzZX5+zufsX
         GczR4G9l5ExAJ2LgOXJjgBA1PxeBT7Rh07rOgfuveP/78MQoI5ZeNeeQoSBGPp9TaC+v
         yNVQ==
X-Forwarded-Encrypted: i=1; AJvYcCXySsHyFLx+GXBWzSiEk16dXpl7FZTO0Btj+jGMWINr97SU37ZJGY3yH17yb8uLcHC48yeiMbs1sbQHyzVSRWdxIAR4SgnmlE6TnjHt
X-Gm-Message-State: AOJu0YxAeP//5TXc3VPWemVVKShdw/xUMmbZNP9XQLNmkUKVLWmNT7wr
	+vZfA0R8B17Evqe3duNppf7Xa7kH1w7Qk/FpmzsLClOZHCijFQLeS8g0KC3thxg=
X-Google-Smtp-Source: AGHT+IFa0TVQIyUrSr4Ml/8FzQljm+HC3iMmztZAcNrfAUEAfc/EMyOWvqQqFubU8RqoS137xa3qXg==
X-Received: by 2002:a2e:910d:0:b0:2d0:a829:6fc7 with SMTP id m13-20020a2e910d000000b002d0a8296fc7mr3948254ljg.5.1707311062085;
        Wed, 07 Feb 2024 05:04:22 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXSL7zY7t194MdDq+81ZXKHFIS8Ji5rW8CtbLG9nXUarAre6Ke7qVaYJDL9lJS4Ks/6d1XfArD13+20dqJgCLUU1ltgncJxiLrddVDdFGXwle9jsGfKLw1/5pnfrlOo5f4B/usZIb7O5WTvYv289KWQAKzD/QpxbXAYc9ordgBRm/xn45DiLEDby58oZggW60OqskgBVybZUFFdzgjaN3d71C1+ey7pd2JS9+Jtp/GbAY4=
Received: from alley ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id n5-20020a056402434500b00560c43b48f4sm637082edc.10.2024.02.07.05.04.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 05:04:21 -0800 (PST)
Date: Wed, 7 Feb 2024 14:04:20 +0100
From: Petr Mladek <pmladek@suse.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Douglas Anderson <dianders@chromium.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Li Zhe <lizhe.67@bytedance.com>, Pingfan Liu <kernelfans@gmail.com>,
	Lecopzer Chen <lecopzer.chen@mediatek.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] watchdog: Better handling of concurrent lockups
Message-ID: <ZcN_1DOwE4D6jrra@alley>
References: <20231220211640.2023645-1-dianders@chromium.org>
 <ZcIGKU8sxti38Kok@alley>
 <87ttmlan1d.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ttmlan1d.fsf@jogness.linutronix.de>

On Tue 2024-02-06 11:51:50, John Ogness wrote:
> On 2024-02-06, Petr Mladek <pmladek@suse.com> wrote:
> > I have just got an idea how to make printk_cpu_sync_get_irqsave()
> > less error prone for deadlock on the panic() CPU. The idea is
> > to ignore the lock or give up locking after a timeout on
> > the panic CPU.
> 
> This idea is out of scope for this series. But it is something we should
> think about. The issue has always been a possible problem in panic().
> 
> > AFAIK, the lock is currently used only to serialize related
> > printk() calls. The only risk is that some messages might be
> > interleaved when it is ignored.
> >
> > I am not sure if this is a good idea though. It might create
> > another risk when the lock gets used to serialize more
> > things in the future and a race might create a real problem.
> 
> With the printk series we are currently working on [0], only the panic
> CPU can store new printk messages anyway. So there would be nothing to
> synchronize against (and it could be safely ignored).

Right.

> kgdb uses the same technique to quiesce the CPUs. It does not use the
> printk_cpu_sync for this, but it is an example of a possible future
> usage not related to printk.
> 
> My vote is to make it a NOP for the panic CPU and then keep an eye on
> any future uses.
Sounds good.

> Should I add this to v4 of [0]?

Let's not complicate this series any more. It is almost ready ;-)
We could do it by a separate patch in top of it or in another
patchset.

> 
> [0] https://lore.kernel.org/lkml/20231214214201.499426-1-john.ogness@linutronix.de

Best Regards,
Petr


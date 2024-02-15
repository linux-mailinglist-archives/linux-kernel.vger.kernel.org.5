Return-Path: <linux-kernel+bounces-66780-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E8A8856171
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 12:24:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A16C828CDAC
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 11:24:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BF7712B164;
	Thu, 15 Feb 2024 11:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yk+KcGsj"
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD037129A75
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 11:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707996264; cv=none; b=noqLmGtH23FtKInLZ8LrQcLLg3SAqYTFvNwjMKQJKNVYxPU2Asgl/qNnWxCE9nMU3i7Q1WNYAN/e7P+LUza0W13QjObXDDCRV2dsdHOCVooOqwoXY2TwLw9sIaAU5L3ycYa3yjfvfeQ4MbMdavgheRRF1jOChRBPyV/bH/hWGEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707996264; c=relaxed/simple;
	bh=8/cqgdjfAA9vbQDSXhoBCgJJt5pWwZaYkylGiTCzCSI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iZfKsRsSt0zfdErlAEnVzW/zePoz41lgXWeD6CoLWQZLOsploemhanGaVl1C7+3kZpvU5cftGiAuY9X3VOivhs9tRIbR4bEx3ddNLWx5J81DhxDB6AQkxxkNlE2ZbL2vs6RcFvA9hZnD3cMOSfBXiv9W2R4z0gGguG4OQ75Ztvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yk+KcGsj; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-6002317a427so6846197b3.2
        for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 03:24:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707996262; x=1708601062; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8/cqgdjfAA9vbQDSXhoBCgJJt5pWwZaYkylGiTCzCSI=;
        b=yk+KcGsjZc3fgKWeHy03nmiDmcKbpEKaqhZh18R3wl9fKIh+f2C1cGXyT3hDNxfVzf
         8dkjFnrV3clI5eVkigz3sBbv50m1bgeApukwZfSeTBpZTH380qfPzKrUXQJezpf5BFbe
         9tgb3aIZZOtqR0sYrm7F38Vw+7JqyyvPf6DGVg3pEmm/UeFN1YuLEAM7L0t40clg0B9u
         bjpUYabJnRo7SdALXbANgLk2toT4AU7v7fQ7ha9fSyicQ6999pFDJXdsGVxaamEzwkNu
         rAr2ZRHSughH0giU4lb+gU82yigGvxwmBc4mwdcK9lBmK0p4Zg5HNwyWbQVH2r2O8XFd
         y6FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707996262; x=1708601062;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8/cqgdjfAA9vbQDSXhoBCgJJt5pWwZaYkylGiTCzCSI=;
        b=eCaDWyfTiHcqZ6osAhjRR14VEfmT7kD1NFbnyMXdDHyyNQAC+Q1uH13jsBeEiDzfEX
         UJwZVSjVtDa3iL9nYnvjjW2XxWu71GSnmcc36oZFyuizToTGt2KzmBYhKR3A01+NgWvX
         DkjV33slZSkSoW+jxk2Ga7nOlYo6ll3FxznsFW9cpaxaLJ21iJes2zLfLCnpnYBhJZv5
         V6xEdt9aT6Cp7HeEkWiFKY0zFNx1+EXGm25WYiDw95XmKbmLhF2jPfSnGVPNxfGYU7gn
         KhGOxdm8LY21VQpR+jzZXUBFCJxFXkmnsRiVTlPfZ57q3Oih9ILeEa7pZnzSuRpwXby1
         XRwQ==
X-Gm-Message-State: AOJu0YxcpkjhCmzH6Ga6Gtlh5fj/wzJwYCqy3XFi5IYlTFqFdsjxuYG+
	3Olg7yOha6nha7UW4+pjwBDUzifmAofuRgZlBN5icfHS1vZoy0YCMm/qZn4n3RHbc5LhxO/Qlfw
	8Wt/9ZFSTKq+JALrVpwp/4BzI/qwj5y5Y46NXmA==
X-Google-Smtp-Source: AGHT+IFWcLAdcbU+HCgyjLlEqrhDNrrjnDJYKBkC/huA8/nA1ZU5acI7+OzcCbFzBiQmR42LNFZIpguI5jPHUqZnnIQ=
X-Received: by 2002:a81:498b:0:b0:607:76ab:c87c with SMTP id
 w133-20020a81498b000000b0060776abc87cmr1302022ywa.11.1707996261795; Thu, 15
 Feb 2024 03:24:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <875xyqg2yr.ffs@tglx> <79fadb9b-c4c8-4727-b812-7e519556cce1@linaro.org>
In-Reply-To: <79fadb9b-c4c8-4727-b812-7e519556cce1@linaro.org>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 15 Feb 2024 12:23:46 +0100
Message-ID: <CAPDyKFoynM_gN=tzsWnE_xAgmy6R8Hie-_yO5zoJTjwNjR38Hg@mail.gmail.com>
Subject: Re: [RFD] Remove irq_timings
To: Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, 
	Daniel Bristot de Oliveira <bristot@redhat.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 14 Feb 2024 at 22:39, Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
>
>
> Hi Thomas,
>
>
> On 14/02/2024 22:17, Thomas Gleixner wrote:
> > Daniel!
> >
> > It's 7 years now that we merged irq timings into the kernel, but we
> > still have zero users for this.

Wow, is it really 7 years since then. :-)

> >
> > I'm tempted to declare this experiment failed and remove the whole thing
> > for good.
> >
> > Comments?
>
> I worked on an irq cpuidle governor which had better results than the
> menu governor and equal than the teo governor. But I never succeed to
> have better results without putting some arbitrary when computing the
> next event.
>
> At one moment, Daniel Bristot de Oliveira (Cc'ed) was thinking to may be
> use it for the deadline scheduler.
>
> Ulf (Cc'ed) may be has a plan for the next event for the CPU cluster.

Yes, I still have that plan, but haven't been able to run some real tests yet.

>
> But if no one has plan to use it, there is no good reason to keep it and
> I'm fine if we remove it.

Besides that the code isn't really used at the moment, is it also
blocking us from doing some cleanup/refactoring or other related code?

Kind regards
Uffe


Return-Path: <linux-kernel+bounces-73551-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A9A9485C40A
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 19:53:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 990731C22C70
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 18:53:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DCFD12FF7E;
	Tue, 20 Feb 2024 18:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GfHewyEH"
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 335A27867A
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 18:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708455198; cv=none; b=H40IKyb7Vjo7xt73APRNkGETjroq2eVAd6wqZ2512bBjmIOOu6/mrfgAMc3zGfBpeUlEyVWtRpNfEVWl26k8W4qZrmiBoLKMIbeYMsfL/S6bIbWT6mdmJ4zZybse0wgESqBrsuAPmvg95O2Fm73wfSYHrnteg6BoNlxb3o1KYbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708455198; c=relaxed/simple;
	bh=9XtmEqIEhWLyi5e53vZ7ChMcMzhZ+IkTAB6tuKaF2A0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fuoBOx5+9vihl0Ul0CCjfHfsVGniLuG24UEpuBdngzj8HuGnq9bSyLOs+O/fEO0ndXUduU3alg/X6CLj9D4HaZHtdMGycf64Qk4KoHiwn4gNBfZqEEk6u96NLRBfDoOzgh71vfULIv4KfkOlbJ/O0HBuHsQAGlSrY1wbKcGZIHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GfHewyEH; arc=none smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-59fc4d05861so1460313eaf.2
        for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 10:53:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708455196; x=1709059996; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eV3QWgNfLUReB9MaFXoi49crbwUJzuqvx+v6XG5KhCI=;
        b=GfHewyEHvjiudPcUe/2kh5ldx3059oqYa09MzxPXaljWwKRIqvBRxAJxiuLkeIhEt2
         11klYQ5g8BQpaVnKAHKUp+XiU2BM0gXY86bnDd3mjKfFsNQVcJinIelHkldOBWZna4Xy
         Pnd+6pfpkCpgeGeKqMqBJ475qtdUQcQ89NZ3/rEfZP2qfD1uMgK/p0uKUy/sarHYLLuY
         njnKV8p9sbOxxyUnlLFsisMrwvGq8DJoUcZIV8VJn30j+0PiW5klVdesRmSBmGzhBT2j
         Sk4kGT9E3v9rdmg0DpupztWjcwItDdF30RuaDAVA2BXb2eY/zaugC8+BDrbqnq0aVrKz
         59gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708455196; x=1709059996;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eV3QWgNfLUReB9MaFXoi49crbwUJzuqvx+v6XG5KhCI=;
        b=DrRBKu0bvGhts6b+9lpp7Hjool1JD5WYyyCUyAzQkB7A7x97xrWhQg/dM9l3Dba8ov
         M28g8p3XYGG/0D/+olPCaLc0vhYQflfJz1QfVSngeJttt9dz4QdDmOYbQJModkUzF4PM
         9CHBDvK7Q027C2V8VEbZRACSkH7xkI6f0SGM12EBrZzXjPgcCub70n5H9KBQOwMb7VC5
         xJGOgt3fwdChu7j5ncAiYi4iAyrDyQ8F7vrHY8u/XstVKrpDhvySEnP/VYW2kJ5tJ+n7
         u/zC2BRASQYDJ0NxG0IH/gfWIXQ45hmveRa5eXYceWIhqzceT28OIYn3CL5hqCBLzoLa
         XIOg==
X-Forwarded-Encrypted: i=1; AJvYcCWUPwDZj+shMbFVka7w2V2D6gll+11N+BJRJpCXuML2SPyOO8M4HZRMY+ZjpTc6l6V0sm9+V3cg6YqWgBhnUEPtbF0XUHVLXJN7cvXR
X-Gm-Message-State: AOJu0YzDrP21qIIm09yW7groAJkg8heTQHWjpvKFz220o5/u0+h/NHql
	920vXg+xryMvAI4xnrePS86/g8/H+RX3ptRFY9JQJ0RpwyMYXmp+tYHenHfst6c=
X-Google-Smtp-Source: AGHT+IEEzpEQF8Ea6gZV0llvuow6GZLZPOjZ6rN/O8R8/oleBCGpUZEHNmoSVWPIznRwK9PN6ThSqA==
X-Received: by 2002:a05:6358:2493:b0:17b:567d:a670 with SMTP id m19-20020a056358249300b0017b567da670mr261326rwc.8.1708455196113;
        Tue, 20 Feb 2024 10:53:16 -0800 (PST)
Received: from localhost (dhcp-141-239-158-86.hawaiiantel.net. [141.239.158.86])
        by smtp.gmail.com with ESMTPSA id w65-20020a636244000000b005dc5289c4edsm6887025pgb.64.2024.02.20.10.53.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 10:53:15 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date: Tue, 20 Feb 2024 08:53:14 -1000
From: Tejun Heo <tj@kernel.org>
To: Lai Jiangshan <jiangshanlai@gmail.com>
Cc: torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
	allen.lkml@gmail.com, kernel-team@meta.com
Subject: Re: [PATCH 13/17] workqueue: Remove WORK_OFFQ_CANCELING
Message-ID: <ZdT1GghILBWPMfLV@slm.duckdns.org>
References: <20240216180559.208276-1-tj@kernel.org>
 <20240216180559.208276-14-tj@kernel.org>
 <CAJhGHyBHsu_o02eZ4HWHhuFVXtVUR-sH_W8gFXw7QbLOBm+k+g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJhGHyBHsu_o02eZ4HWHhuFVXtVUR-sH_W8gFXw7QbLOBm+k+g@mail.gmail.com>

On Tue, Feb 20, 2024 at 03:23:53PM +0800, Lai Jiangshan wrote:
> Hello, Tejun
> 
> On Sat, Feb 17, 2024 at 2:06 AM Tejun Heo <tj@kernel.org> wrote:
> 
> > @@ -2631,19 +2567,13 @@ bool mod_delayed_work_on(int cpu, struct workqueue_struct *wq,
> >                          struct delayed_work *dwork, unsigned long delay)
> >  {
> >         unsigned long irq_flags;
> > -       int ret;
> > +       bool ret;
> >
> > -       do {
> > -               ret = try_to_grab_pending(&dwork->work, WORK_CANCEL_DELAYED,
> > -                                         &irq_flags);
> > -       } while (unlikely(ret == -EAGAIN));
> > +       ret = work_grab_pending(&dwork->work, WORK_CANCEL_DELAYED, &irq_flags);
> >
> > -       if (likely(ret >= 0)) {
> > -               __queue_delayed_work(cpu, wq, dwork, delay);
> > -               local_irq_restore(irq_flags);
> > -       }
> > +       __queue_delayed_work(cpu, wq, dwork, delay);
> 
> The disable count has to be checked before queuing it.

Ah, right, this also needs a clear_pending_if_disabled() call.

Thanks.

-- 
tejun


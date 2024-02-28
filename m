Return-Path: <linux-kernel+bounces-85493-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 47BE086B69E
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 19:01:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F1C931F25AA2
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 18:01:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58C7479B9E;
	Wed, 28 Feb 2024 18:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KIPC+xsb"
Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com [209.85.222.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3137779B91
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 18:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709143223; cv=none; b=sM7DOdYERrB9p5b9/r9G9pocr7BF9wANRKxafIsfXErgh2g4jMyjt90cB+6evrjJM3vvu+OYM92r1NjZgmFmTGUY9UG72HppITNMma/LiKzoDSS1f3UiQp0m2rou+J/yo8sNLETC7KBZb6aNQb9BoqCQmJKYziBBioqDo8uzCik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709143223; c=relaxed/simple;
	bh=b9zRhYvv4PXca3piPorvZ5+a2QRM6gh45nB1FAsuTlw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OE2JNFxX/LnYbqjQplwpLH9luB7SdnpFLHsxwA5kG+G7rnRPDQQp9OLZhqL8pJ0bCFvY+0VWKuvCLoCCdaTIXhfTjWSmPFJNlnN44oHa2b5Xx30RUX4w9wwq20/YanL/3F+zLMzZIy4E2LtkDSFnq2mqYeqA46/dChdNTSQ7sNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KIPC+xsb; arc=none smtp.client-ip=209.85.222.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f53.google.com with SMTP id a1e0cc1a2514c-7da6e831977so1058373241.1
        for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 10:00:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709143221; x=1709748021; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=J4sA0rtgSj+9+qXLbdIB1immx/WztoPHP7M0OTv8GAU=;
        b=KIPC+xsbt4MKT/Yhhp9kE4mNcfMWSSF2BFeTKrOb0qfYABqQ6+bWwfBLu2n0ALYtsv
         CtMMIejcLmTXibEY93kNtEDlATKaEHjGt+vc75TnqqWQfSMO4Sc7YBVOxxy0EGb137kp
         cnr8dSOD0ZC1iTV+pa/XqLuIesTHo+qBNHZUl52ueGxz5MnmmIU02fMgv39Ez0F6t/ln
         kjJli6sV5obihoduBWrMoRn1ytsT207fBfteojrt30tglzT98siyWSxsvB0fXkZ55EKq
         f88tIArtLI7c8bWHgLXDvQnC7BL67hgol5qYWg4Vq6Av53G7jnJBlhalJSLBpr0J3ovL
         o3OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709143221; x=1709748021;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J4sA0rtgSj+9+qXLbdIB1immx/WztoPHP7M0OTv8GAU=;
        b=oZ4QmX21iniBkD3s+n7SAXKjfkryKqWPEhr+xkoxB/IulEm9qbE5kK6Bw/Ceo8exnm
         4g4agOEDryXvJR775fxDQTNjpuE96enyP73FsT0BnW/3Y9vOfNfFe8ep828ftwZPWSln
         lzS0vGso/ICG9Xt3FauHSg0GoUTWGMYHphVPEj/TU2D73qzQutPOiLrbhATSvpXrau6a
         OmZF7kFNPbhiT6bcz08XEewFMENQbkHa059rqJUWpmTP/bV2bUSHLo7jpjHE30rMCwst
         vxuBarPZBgmRzmxnIYZX+QtJ+PAo7OAZioESxHceGyKtTlXidudkiXkJ/UDJ2sYmxkNX
         5oQQ==
X-Forwarded-Encrypted: i=1; AJvYcCVt4pcfwICj0FMXPfP0g7TDVqqHcMDsqtN7wUAt0Pyfs1oCx6ppOkcdMBekjWWlX4UpOz2nfzGZ0eSKq/cbS1wT1kULDPMo87Ey+sPm
X-Gm-Message-State: AOJu0Yw8yAlq76zs+qjTY94fCE8HzO1U57ti/kzlxydowlr+saPDL1l9
	v8F0eFZSYYMWkzt3lj//KEDBwWOLJU939WVCE725zSlE/LWiMUkQkBE95eNgrJxksR6gErW5wQa
	G4I3F+f5YvHHEley9DfH+pBmf/8GT/X7F
X-Google-Smtp-Source: AGHT+IGDxwNO38LaKSkKz71BL0SKZWSzSEvlLrRn6Vd4Rz45iveoXvYeoieF4XSxNSJfXFRV/Ik5JwH8G/FiOsuguI0=
X-Received: by 2002:a67:b608:0:b0:472:623b:75bc with SMTP id
 d8-20020a67b608000000b00472623b75bcmr337913vsm.10.1709143221159; Wed, 28 Feb
 2024 10:00:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240227172852.2386358-1-tj@kernel.org> <20240227172852.2386358-7-tj@kernel.org>
 <CAOMdWSLVDaN_XFD6Ov-=6VrH4wyBz-0wq_L3EzgdsJ5zJi47qQ@mail.gmail.com> <Zd9yNByiBMcPxWbU@slm.duckdns.org>
In-Reply-To: <Zd9yNByiBMcPxWbU@slm.duckdns.org>
From: Allen <allen.lkml@gmail.com>
Date: Wed, 28 Feb 2024 10:00:08 -0800
Message-ID: <CAOMdWSJX43mqaSWaoVkNep9zJjr+v6OXup9YK9EuA_CWH+wThA@mail.gmail.com>
Subject: Re: [PATCH 6/6] r8152: Convert from tasklet to BH workqueue
To: Tejun Heo <tj@kernel.org>
Cc: jiangshanlai@gmail.com, torvalds@linux-foundation.org, 
	linux-kernel@vger.kernel.org, kernel-team@meta.com, boqun.feng@gmail.com, 
	tglx@linutronix.de, peterz@infradead.org, romain.perier@gmail.com, 
	mingo@kernel.org
Content-Type: text/plain; charset="UTF-8"

> > > @@ -6971,7 +6972,7 @@ static int rtl8152_open(struct net_device *netdev)
> > >                 goto out_unlock;
> > >         }
> > >         napi_enable(&tp->napi);
> > > -       tasklet_enable(&tp->tx_tl);
> > > +       enable_work(&tp->tx_work);
> >
> >   I think we are missing queue_work() above, right?
> >
> >    To avoid such situations, could we combine enable_work() + queue_work(),
> > into a single API?
>
> Here, the device is newly being opened and the work item is just disabled
> from the init. So, it doesn't need queueing.
>

Ah, my bad. Thanks for pointing it out.

> > Perhaps, something like:
> >
> > static inline bool enable_and_queue_work(struct workqueue_struct *wq,
> > struct work_struct *work)
> > {
> >        if (enable_work(work))
> >        {
> >              queue_work(wq, work);
> >              return true;
> >        }
> >        return false;
> > }
>
> That said, this may still be nice to have.
>

 If the above is okay, I could send out a patch. Please let me know.

Thanks.


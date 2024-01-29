Return-Path: <linux-kernel+bounces-42676-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2469A8404C6
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 13:15:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B734C1F238DD
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 12:15:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8DDD5FEE5;
	Mon, 29 Jan 2024 12:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="eymzkr+1"
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8C392F41
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 12:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706530548; cv=none; b=u0vRbJJ4P2E+uyC246WSyO6kpTMIv+sIXtKRnPtTAn4Fp0MQGwUjPSIJFM1TsZ0zEUczj/zJ7c7sHXNK6UDgLWpK8M4gXgr+2pgZX/3p0vqV2gcgad/nw3EeTPoh/+s1xi8kfdw4c+nnUhdFHQcTitmFY/P9lYpkG5YGqGHv0Ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706530548; c=relaxed/simple;
	bh=beSEpMwWPhoXPG21YOXXQgt1VNjIWZ1tYR3wUsAzp44=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=c9LKko2YzzhPClNGkMME1Ec1jzY+ABNhMnj4FxkO3QY+8/TQF15lAEaftwUwB5iEAstVmpF9xt8LdNtUre6xjpSxMhq78TUDXW+m5pRfOVbWpSPeuYTASHsdk41hwzsbt85rnuzFOlpb80PPn3uzwRDQ9zLNkILE6w2iGi0oZII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=eymzkr+1; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com [209.85.208.71])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id B52DA3F131
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 12:15:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1706530543;
	bh=SaRR+cA5aioFaC6rHkjuNEVQCXHh/LCdTL3vZh7l9Dc=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type;
	b=eymzkr+1b3xldoWCGrNHMslbgf+d97XdFX1QFWRi854taBNE13cXjw4vvPD16Ma/R
	 Z/uiSwGB+6pyluRXlc4YUxdJZG5mmpsXGbTpNP6k5XzreRarY6teLW7VhVEAzEhlje
	 3+ny9OeakWRCLOIqCzMyeDF0YVqca7LXaU5MCjBcO8seXgfFJxRP++nPRznr1Cf96U
	 /6H8zR3kCethE7YzwjjofoaJ4w94WnXMfNhzjBb3RxaUUQ0mMjhoOhXv5LSb8/cAId
	 Bp0o+VEMF49THHx+GsqBIoR276ZYj8leITb7NG4qp9BsckgEXVN11D1fbwsRFrabSM
	 19gQOatRHmSzw==
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-558b04cb660so1340582a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 04:15:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706530543; x=1707135343;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SaRR+cA5aioFaC6rHkjuNEVQCXHh/LCdTL3vZh7l9Dc=;
        b=nA70hai5odDVRB6a0NodzkoB427PfE5nNRqXYHxqW/kb5gyJp2EfLeVgAJ54ZqrfTB
         I4N/JhVkC5KgQ97g1BjMjn8I7hdicBx6+z8Z8+tWHxVcTGx6yb553i+f04rwzeUWebuY
         qCXOtgBob+girEd3dI5WiMkWy3vG1FBC81ABRIZflSinTYmHDXLQrTmJOeuyiRtYzyf0
         wc88xwCeak6a+83I/6fSfDgGfgLW5VEGNN4xbJa1UahWO3eSb7KJgulhm/s+OamS6v++
         YhejVmoDwRCi2NXTBFrsJ3pSL/LatcC7hGInWYgLo0JnAN8HI3CrjmJh49IEt75koxSk
         8uYQ==
X-Gm-Message-State: AOJu0Yz5AlLAilyKS3yTAlcxCyxJWsX2kIV7LWz5o/IH0xlGnm4/dojB
	iWGo93tq8dgAgAPY0c8fO+sTj/qkp5cYgnS4OInTKEdOvvDesxt9/4xM35wBRyT8gIAxbzeZMW1
	5V7IRC/+qK6SBtiE73y3IvZ+BK2y6GnPfyvhsZqpXdpphaY455j7mHYqqlyfGtantumPc/aVxD2
	9xcA==
X-Received: by 2002:aa7:dc0f:0:b0:55c:d474:56dc with SMTP id b15-20020aa7dc0f000000b0055cd47456dcmr3504327edu.39.1706530543436;
        Mon, 29 Jan 2024 04:15:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEE1UPnji4HFFHIfmLwUcudfhejZixFf7AfaUc8q8iJEaCdy+QPERSuFFEev3B3r0IdQz2X+g==
X-Received: by 2002:aa7:dc0f:0:b0:55c:d474:56dc with SMTP id b15-20020aa7dc0f000000b0055cd47456dcmr3504315edu.39.1706530543167;
        Mon, 29 Jan 2024 04:15:43 -0800 (PST)
Received: from amikhalitsyn ([91.64.72.41])
        by smtp.gmail.com with ESMTPSA id cs10-20020a0564020c4a00b0055d37af4d20sm3576492edb.74.2024.01.29.04.15.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 04:15:42 -0800 (PST)
Date: Mon, 29 Jan 2024 13:15:41 +0100
From: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
To: Christian Brauner <brauner@kernel.org>
Cc: mszeredi@redhat.com, Miklos Szeredi <miklos@szeredi.hu>,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 3/3] fuse: __kuid_val/__kgid_val helpers in
 fuse_fill_attr_from_inode()
Message-Id: <20240129131541.a5005f1ec36b0424dfdb69af@canonical.com>
In-Reply-To: <20240108-ramponiert-lernziel-86f5e0926c3c@brauner>
References: <20240105152129.196824-1-aleksandr.mikhalitsyn@canonical.com>
	<20240105152129.196824-4-aleksandr.mikhalitsyn@canonical.com>
	<20240108-ramponiert-lernziel-86f5e0926c3c@brauner>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 8 Jan 2024 12:37:07 +0100
Christian Brauner <brauner@kernel.org> wrote:

> On Fri, Jan 05, 2024 at 04:21:29PM +0100, Alexander Mikhalitsyn wrote:
> > For the sake of consistency, let's use these helpers to extract
> > {u,g}id_t values from k{u,g}id_t ones.
> > 
> > There are no functional changes, just to make code cleaner.
> > 
> > Cc: Christian Brauner <brauner@kernel.org>
> > Cc: Miklos Szeredi <miklos@szeredi.hu>
> > Cc: <linux-fsdevel@vger.kernel.org>
> > Cc: <linux-kernel@vger.kernel.org>
> > Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
> > ---
> 
> Looks good to me,
> Reviewed-by: Christian Brauner <brauner@kernel.org>

Thanks!

Kind regards,
Alex


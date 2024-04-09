Return-Path: <linux-kernel+bounces-136379-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8481F89D369
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 09:40:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B57BD1C20DB7
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 07:40:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63A8F7C0B0;
	Tue,  9 Apr 2024 07:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gkAWRL0/"
Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com [209.85.217.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AAE37BB11;
	Tue,  9 Apr 2024 07:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712648436; cv=none; b=AmTgOpC84/9X9/2e8zPIZQw5/kp/z6ax2hRBIj2P6uZre8fP5jOZiLCugPxmwbsIzLe6ZfOdaKb34p7pVyMgwc+vYyS7nRNsgnhsMxiYm0tW+h1kJaukGA0KDY+60Xy/GKIudsVCL1NwceerhBH2oKo1REP5CKJgowupz0S2/s8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712648436; c=relaxed/simple;
	bh=T+kVyCD13WqgXMbGlr6VkGVa7e5lF0dFumHpcs/pip4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lZ53saWuuUVF7eh/IuKls3A/U6MuHnwkAK1PCT6G0B6p5SOcZBnKeJkt0lNJSI8v4qZBAUgu+npY3b9oL6qAjysW7QNsFvL1kvkgymrsfNG7k2lNivrLx8aZaGb0mWllhw9CUpwCgfjBY0c49lS0tnE3EHJhDREBxdyZNZzipQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gkAWRL0/; arc=none smtp.client-ip=209.85.217.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f51.google.com with SMTP id ada2fe7eead31-479e45cc9e7so1173270137.3;
        Tue, 09 Apr 2024 00:40:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712648434; x=1713253234; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TmueZZ/TgRqG/Abm7dlKNI/NPPBB7vzNyARyvdhWIAE=;
        b=gkAWRL0/eOOZ3v5+8wHvsLRNgu7G15ws4BXTW4nRc2SjhKcnBoscDa3s0yEBKqWC2O
         Ao0+QXTc2wYyjTuwLSf9yhdWNP6dMjzXNvwEYP3dcdAIPZU8TgApfd+CO0vMYfpm3U2P
         X0RsYlG9dEbB7Hb4wuylUmZ1d44awU9K5lpHvF2620wGW5cGoDA+yGvk2mpY6DqP5+/+
         p7/vE0GCSNssCEfteQ2yhc4GypHfYVMgClxrJfRyAzBzskcdsbtuQsBBACERj51atH5W
         p+SCGEWTALjSJ/bGqne5/nhTCOkrtHZBZJXepnF2H0sDnLMfFMZJIo6qZKwi5X8kmwBH
         T7Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712648434; x=1713253234;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TmueZZ/TgRqG/Abm7dlKNI/NPPBB7vzNyARyvdhWIAE=;
        b=IvD7rq598c3fVFfqad7wMMLp3zq0ALZdkGjwCKA8Nu5dbuIt/a7rLsbevpuzf4e+pR
         7KF7MGMg4FL07PLFBQrNnfzj5V63Ockzsr582r0zt/LjtAh77NiK2UhzOOBW1bfK15g+
         x+SizdttsuL8u6dPOj7qv+W6f7QZmg46hpmYuDeC27d/UbgFwr3LIhLCacg4dCfBnuLg
         JKJFyZCFUmng48ejXRfQQqevdWS503091bwzdBk5R2kn4CRyGPUJ2voHFodDteXO87a7
         KGsDeY04BZWngukUhO/T1jGjTkPY8tTy5JHJTFFkjnqtNIPdTHNKvGBCa5qnHCKcbdha
         199Q==
X-Forwarded-Encrypted: i=1; AJvYcCWqaUX23RAmd9joJjZidVUGjKPnOUmpQYEF0KT8GtJBGr3tliKGAF5mI+hNWUFK2Ki6c6WpAjiGPMJ4dSqg7fZMKTp/nr7+Kv4lMCzislP24tRxhEH1rf3czoVdoRpg2MH3sgz3NGQ7gr/Ufp0AFw==
X-Gm-Message-State: AOJu0Yy6yvElWKLEfUiBVXoeGUF4IafUch86zup3QP2uBXV6v9lXfaIA
	xxUfKkfy4A9SZ9z4kb7AD8QsC1HNecq2SahDsDCPKIAbQf9DSFXs
X-Google-Smtp-Source: AGHT+IG3vI6K7uhDq48kW4SnkdV6jqRwQS04RT5JGyGivzvgtxR4HljqBSzLe74eTA2OZPDdRnVtfA==
X-Received: by 2002:a05:6102:fa8:b0:479:c455:c021 with SMTP id e40-20020a0561020fa800b00479c455c021mr10045890vsv.35.1712648433813;
        Tue, 09 Apr 2024 00:40:33 -0700 (PDT)
Received: from gmail.com (1F2EF1A5.nat.pool.telekom.hu. [31.46.241.165])
        by smtp.gmail.com with ESMTPSA id e9-20020a67b649000000b0046ed66a9051sm1441225vsm.17.2024.04.09.00.40.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Apr 2024 00:40:33 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Tue, 9 Apr 2024 09:40:29 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCHSET 0/9] Sync tools headers with the kernel source
Message-ID: <ZhTw7e+sy0wfzgR5@gmail.com>
References: <20240408185520.1550865-1-namhyung@kernel.org>
 <ZhRB4BULj1Y1f1TN@x1>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZhRB4BULj1Y1f1TN@x1>


* Arnaldo Carvalho de Melo <acme@kernel.org> wrote:

> On Mon, Apr 08, 2024 at 11:55:11AM -0700, Namhyung Kim wrote:
> > Hello,
> > 
> > I'm gonna carry these changes on the perf tools tree.  I'll update the
> > vhost.h once it lands on the mainline.
> 
> Humm, maybe its not a good idea to do that this cycle?

Maybe it's just me, but I've been looking sadly at all the header warnings 
for months. :-) Would be better to keep them in sync with a bit higher 
frequency, IMO - which would reduce the pain and churn rate:

> >  16 files changed, 809 insertions(+), 740 deletions(-)

That's like about a year of changes missed? An update once per cycle and 
this wouldn't be nearly as painful, right?

Thanks,

	Ingo


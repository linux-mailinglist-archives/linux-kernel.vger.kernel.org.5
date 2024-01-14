Return-Path: <linux-kernel+bounces-25478-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46B6482D0E0
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jan 2024 15:20:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9610282251
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jan 2024 14:20:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC99923D2;
	Sun, 14 Jan 2024 14:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fKA48/2Q"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 211A323BC;
	Sun, 14 Jan 2024 14:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1d427518d52so57545345ad.0;
        Sun, 14 Jan 2024 06:20:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705242002; x=1705846802; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gtafRdDX1KPPk8LDrTZjwEYrzHp2ogBbEYR2dmJ/5nM=;
        b=fKA48/2QF/x4anRSKqPEjSvrbwKGmii+Ti/0Eq7uPG+YDqfFmgfVCKJx4r4baztAPe
         C9vC9sAPjHzUWr6HcXZEe1lCnJVbCiYKTgyT9WoTLbHzgsVLEVHGOhzCUs9FbCeIIL51
         9hPVJi25cGh8aeleeVHFhRxTwTphjPqG+Lh9ZiYQh1BOnPINOg7Cl4edfAFFaMMb4/WI
         EOU78I/LGwlfU1WZgzNLsSkwY9KxxBNn93nOFPXwFYlvnAy2VwILhuUZQyen1EuaFjnl
         JbrPl0kHBvlPBr0qE34njLBK4rJrnhq1kmVtRfPHJbfw+QJxDW/lAcgvgCxQ9Ulc25iS
         uImw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705242002; x=1705846802;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gtafRdDX1KPPk8LDrTZjwEYrzHp2ogBbEYR2dmJ/5nM=;
        b=r4bCu/qhiMx8YvCqtZCzBws5PfP9Ne96NJTDPrTX58GyPF82WmIyxmNzd/TvnQQPvT
         hAJFYKfxJwzk2QS2aC6k4ebU6KM3oCpl9gIo2T74bV7SIWsXYnwRPPoCnjkU5ucODnCx
         TQb73CaPpNwiVL/CtE0GbI0F0SWCr4B/HC+m7PHA6ivlknetZ5rmBhR1HEqeASZ/Metd
         1XgXKkhAHxO5U1lRG5LKFmMxVsEPWiumDLPgIfbFmTuYeAf+FIJdFa0Vmk+Fr22wjr9I
         x0GqtyOjeVgPgXydJkFrdqMNDPryPi6BKnrD93xWrTPh2U5tgeH+0peQowsHJ2QLD8iC
         +mXg==
X-Gm-Message-State: AOJu0YzU6A3UQmvRA6AkrTngxgVZakmVqk44Y5TyXvsw6Eqtoh3iIq0r
	60N3XZngtHFvabwN1RRZy8o=
X-Google-Smtp-Source: AGHT+IHON/ba7BJlURy7ZKVMNQmvS5Vrkn+9Zev/oWacyJsE3xJdSda5ULrlFwSPGZUzXZm0v58owA==
X-Received: by 2002:a17:902:d489:b0:1d4:e22f:8424 with SMTP id c9-20020a170902d48900b001d4e22f8424mr4810187plg.55.1705242002002;
        Sun, 14 Jan 2024 06:20:02 -0800 (PST)
Received: from rigel (60-241-235-125.tpgi.com.au. [60.241.235.125])
        by smtp.gmail.com with ESMTPSA id u6-20020a17090282c600b001cc2ebd2c2csm6069834plz.256.2024.01.14.06.19.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Jan 2024 06:20:01 -0800 (PST)
Date: Sun, 14 Jan 2024 22:19:57 +0800
From: Kent Gibson <warthog618@gmail.com>
To: Andy Shevchenko <andy@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, brgl@bgdev.pl,
	linus.walleij@linaro.org
Subject: Re: [PATCH 0/5] gpio: uapi: documentation improvements
Message-ID: <20240114141957.GA99741@rigel>
References: <20240109140221.77725-1-warthog618@gmail.com>
 <ZaPrbi6GxqlfysWe@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZaPrbi6GxqlfysWe@smile.fi.intel.com>

On Sun, Jan 14, 2024 at 04:10:54PM +0200, Andy Shevchenko wrote:
> On Tue, Jan 09, 2024 at 10:02:16PM +0800, Kent Gibson wrote:
> > This is a series of minor clarifications and formatting tidy ups for
> > the GPIO uAPI kernel doc.
> >
> > The series is intended as a companion to my character device
> > uAPI documentation series, but makes sense on its own too.
> >
> > The patches are self contained and trivial so not much to add here.
>
> Reviewed-by: Andy Shevchenko <andy@kernel.org>
>
> for patches starting from the second one.
>
> The first one I personally don't understand why, but I'm not a native speaker!
> I believe, it's correct, although the original version seems okay to me.
>

The problem isn't the language, unless you mean I'm explaining poorly, it
is the logic.  The original says "zero or negative value means error", but
in case of an error the kernel does not actually set the fd.  So if the
user sends a request containing a positive fd they might incorrectly infer
that the positive fd being returned implies success.

The new wording is that the returned fd is only valid on success.

And thanks for the review.

Cheers,
Kent.


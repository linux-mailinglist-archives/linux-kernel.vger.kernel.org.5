Return-Path: <linux-kernel+bounces-154848-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 03A318AE1F4
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 12:17:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 54A27B213C9
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 10:17:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9233460EDC;
	Tue, 23 Apr 2024 10:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="crq1AuMC"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 442BF5FB9B
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 10:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713867460; cv=none; b=G09c67RKwAyMTBvXkyWyvjwFYDuaA3FJzUvlCJEgsTwlkB2kTr7PlJaLYhqvklpEOkPlLqBr0oTjUTRYDTrTMlfvHdnNkVKrFpdKr9WX9wJx3whBpiSsdZGr85ki0KtY0kxu4O7ZrP/Jcpb4aQ4pTMnKAtB1rSmNJrOJhj2QehI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713867460; c=relaxed/simple;
	bh=q4VWRz/40QiECpb4Mc718+dcBLauo45GEnaZwLcwvDU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q9vexiJsIw4fFM00+HN6+ainK8RbiTf7x3oUm7q/A4s6hNJhFZdnkh0yYNSLBvo5k+L8MlC75HcmVyzpAJPC429RJof9Fk3judNdB+hBkgN2gCtTKhYR5mIwBO/J2QrCyZig6bD/LCZ4V7Gyk1b5mjbeCgWu6QuBvWD9/PsgK04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=crq1AuMC; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-41aa2f6ff2dso7034515e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 03:17:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713867456; x=1714472256; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=WSIhEkyuGlAKLZqnsx6pwNHAFthAMdp875SAIfIKU9Y=;
        b=crq1AuMCn0QTY/DMPLUJ6UahTbupEMnlZtjK6ru0mhNRpQjZkSyIH8vacgO3G/WxZ9
         84D/bFS8nymisGiJ+TVpXMKn/TmNg3Vu4LWYpJNz2encXBuvLUQNaXwWM2XxNi/LCvaQ
         mflJgJdIQOXFbwq7A/KVWMLzhn7XJhcLGkLzFXYhIaviAfRz9rmH7l5Z42gqyjtWjk3j
         v8cnHU/EPLgnkgD1c3QnnBNXddUDpcjxdX7ZSBHQP7x0kXQWVUijqEbLjPJ+Ck5xDJnm
         p0b6W9Az6gN57R2x++Hgyt8gf2x33/Wg5va0X2BfvA34GkCy10tSEyeOj230lU8RQ+2F
         9w6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713867456; x=1714472256;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WSIhEkyuGlAKLZqnsx6pwNHAFthAMdp875SAIfIKU9Y=;
        b=O67jn9RWDHxNq/SKANhsPxSxN1WwoNi86tCuxtXFIYKQxxDc4aYjSF8u4YGpq6Kt0s
         qJMS1NpcV0+KWlKeFi1gPoZMKmAu/ZwkInVpbPW75ayLAMmfl3Ybkomv9n8TC2csgQ0J
         +ntHz/vuSJL3oKfr4Mg/kyB/irMG/5Tr6qqxORV4oUvNYTNcboloP5IRGmSjzgfX4JG8
         lUsvYGfSQFM8wVuiSViyzNHeW7hdXCzo4yoLkBdWYs83S7l3yKGiA1EH5YdHfJM4AFqK
         Xn5Ga/kAvHcygev1izj1+eIW0k2vua1+AnkTaVOZ05eCzBhKFLU1pgM3mSSPONcgeEpA
         UMqg==
X-Forwarded-Encrypted: i=1; AJvYcCVuRVdlwZNAkrDM5iT+ZP0MWY44ZqCPC7KkCGoVwlB7jKdjVrAHb7/3L8yE/kUenrYluLNOaNaNvdE8HNX3TnT2vMs6qgTPhmaZQQIm
X-Gm-Message-State: AOJu0YxUwwBExKXrvKIbBMWWTXuwLSLOOdFvupRkUqdL14giUnbex+Ak
	r+o/vTsY4GOmbi5X/FNLRdc/qUXCpFlaZttCz5fCnWUTLuN+3ldqJvo6bYV1Y0c=
X-Google-Smtp-Source: AGHT+IG1QPul9ff/agjnfVb1zx0R1tS4WbYQ6DGw9mfuJGNwEgeOG9LlcF2fpwcDxX4nEz6RCXCQZw==
X-Received: by 2002:a05:600c:5008:b0:41a:81be:3e5e with SMTP id n8-20020a05600c500800b0041a81be3e5emr2823760wmr.22.1713867456447;
        Tue, 23 Apr 2024 03:17:36 -0700 (PDT)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id v11-20020a05600c444b00b00418d5b16f85sm19577127wmn.21.2024.04.23.03.17.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Apr 2024 03:17:35 -0700 (PDT)
Date: Tue, 23 Apr 2024 11:17:34 +0100
From: Daniel Thompson <daniel.thompson@linaro.org>
To: Doug Anderson <dianders@chromium.org>
Cc: Jason Wessel <jason.wessel@windriver.com>,
	kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org,
	Justin Stitt <justinstitt@google.com>, stable@vger.kernel.org
Subject: Re: [PATCH v2 1/7] kdb: Fix buffer overflow during tab-complete
Message-ID: <20240423101734.GA1567803@aspen.lan>
References: <20240422-kgdb_read_refactor-v2-0-ed51f7d145fe@linaro.org>
 <20240422-kgdb_read_refactor-v2-1-ed51f7d145fe@linaro.org>
 <CAD=FV=VrOSN8VFaRwH-k4wCLm6Xb=zJyozJac+ijzhDvH8BYxA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAD=FV=VrOSN8VFaRwH-k4wCLm6Xb=zJyozJac+ijzhDvH8BYxA@mail.gmail.com>

On Mon, Apr 22, 2024 at 04:51:49PM -0700, Doug Anderson wrote:
> Hi,
>
> On Mon, Apr 22, 2024 at 9:37 AM Daniel Thompson
> <daniel.thompson@linaro.org> wrote:
> >
> > Currently, when the user attempts symbol completion with the Tab key, kdb
> > will use strncpy() to insert the completed symbol into the command buffer.
> > Unfortunately it passes the size of the source buffer rather than the
> > destination to strncpy() with predictably horrible results. Most obviously
> > if the command buffer is already full but cp, the cursor position, is in
> > the middle of the buffer, then we will write past the end of the supplied
> > buffer.
> >
> > Fix this by replacing the dubious strncpy() calls with memmove()/memcpy()
> > calls plus explicit boundary checks to make sure we have enough space
> > before we start moving characters around.
> >
> > Reported-by: Justin Stitt <justinstitt@google.com>
> > Closes: https://lore.kernel.org/all/CAFhGd8qESuuifuHsNjFPR-Va3P80bxrw+LqvC8deA8GziUJLpw@mail.gmail.com/
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
> > ---
> >  kernel/debug/kdb/kdb_io.c | 21 +++++++++++++--------
> >  1 file changed, 13 insertions(+), 8 deletions(-)
>
> Boy, this function (and especially the tab handling) is hard to read.

Too right. I even rewrote it using offsets rather than pointers at one
point (it didn't really make it much clearer so I dropped that for now).


> I spent a bit of time trying to grok it and, as far as I can tell,
> your patch makes things better and I don't see any bugs.
>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>

Thanks!

Daniel.


Return-Path: <linux-kernel+bounces-73888-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C611685CD2A
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 01:56:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A51A11C22939
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 00:56:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B29A20E3;
	Wed, 21 Feb 2024 00:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rjc63krm"
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 351821851;
	Wed, 21 Feb 2024 00:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708476961; cv=none; b=PGNhD6xrywqJ75jost0R6GSdNF50Szk/nYJrO73SxJTv8bPB4GIz74KbJx3dHOqsePshNyNgJscgEIFO/qhr42cKTMW242ahHcmLeaDkLIQh7Nyx1rE7T91I+YmMExgspj7Aps4bg+ccR+voiyA5J4Q4xg37Ywk70BtbSTCurkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708476961; c=relaxed/simple;
	bh=h59A0nTdMaS4QknwwTF1iUgQxO7ZN7Hhiedyja68IoA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i5fEOKnL2ihBzGrHo29k6+a/Fg5fcYWBzgoSzgSEnZEJtDYKSL3Ru1xxof25H6+vrf8EsjqfQDy5+6IAp46BkHQ+8r1cnZ+M5cgDM6mfY6GS6Dv9QYRq8M21cljECZlF5zmMCoy9nYBEKfM5X8yqegtccJfDo5lbJqbGtigM7TE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rjc63krm; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-3c1593b82acso1488101b6e.0;
        Tue, 20 Feb 2024 16:55:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708476959; x=1709081759; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xbjrdBYSMSwTJFCNzhO+Z2LsLT583lrbV5fyqTeY+XA=;
        b=Rjc63krmidw/Yyq/Br1y2IuNlURYOajSGAi3FtH05P67g58mvw/vBnK59SHIIpHLUJ
         5tihZzaTRY6qzLhL4nmNFpt6UHZvVsGx0dT92IS387nJrKZ6bUe5vjYj0un5OM5OyfBk
         3BrSrDpxC3l/utJ+hrcA9DQTtwRXytzdac9VMiKOG3z5d0wDKtL9rWKQqvcP08B1G/bm
         apgHGKxwDt6tz7t63pbvdAdZURVrNjz/AcKRcNrSWv2E6nCQMlEjJi4QdtFWPlHG0iQx
         JQvxG5z5wrXGbKru6mtGmC6kd7iPQNPZsE5pU0vo4+7eooY2QCLMSWCfu/GhXymmhLL5
         tRVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708476959; x=1709081759;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xbjrdBYSMSwTJFCNzhO+Z2LsLT583lrbV5fyqTeY+XA=;
        b=rSMpCWk/T2Df0mF+iP87ALLE4dLeOtLlQA+UFOYGPCvB12OBkNaVHqqxA7xbjYQfpS
         yiXS+BAT0j//HxDpl+3hPxpo+VPYP7gAt3bJA+85avYG2h2Gw3Wp4jBFl8tELEs5F/hx
         8e5YAGlO3WMCw8x38njCFG1Y7UF+lkcSY7+GgphSQZ+y6nymmN4jVk1qjW5Yj/6ET+rI
         T4JgqF2BOLy+Jpx04euEcq0Bsl6x5o/++kCsn0nb73O45ZequVWlOkEKflcc/iRA3/Q+
         xRj/JBMml5tHe5qAWGpgA6WcuQDkIpaD+b3KGnZ0x4uHRtQAfAj5rD5GKJefayBpdB3k
         QZNg==
X-Forwarded-Encrypted: i=1; AJvYcCXOQmPdOcxJ31490t9e48Z8LBkJLnipA66MszAbvOdv1NT7fkCYshK+TDhQLdo3NBfMgAUmlyIf/a+mgAVbCMIzVQ3Mi23V2eI4ZX143TQJpcrxVRcLSxZYadW+6aDHxW0JRBnlUg9Fpg==
X-Gm-Message-State: AOJu0Yzy9/y3jf186xI/ecZqnMeqqjIKz1Omfgqc2mseTqguohrrprlt
	x+DVJq/tHa3suZobDWJ7rckXysaNe4WIVn+LDXpHIZKNtiKRcBEo
X-Google-Smtp-Source: AGHT+IFlU7LrKI7VOyrfBior6ztLkrCMZihaVPFxiVnZL5Rgokt2/ol7hhYNSt0YU93vVPl35sWq6A==
X-Received: by 2002:a05:6808:1987:b0:3c1:67e5:90fb with SMTP id bj7-20020a056808198700b003c167e590fbmr3312383oib.50.1708476959196;
        Tue, 20 Feb 2024 16:55:59 -0800 (PST)
Received: from rigel ([220.235.35.85])
        by smtp.gmail.com with ESMTPSA id i4-20020a62c104000000b006de050cf904sm7508723pfg.22.2024.02.20.16.55.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 16:55:58 -0800 (PST)
Date: Wed, 21 Feb 2024 08:55:53 +0800
From: Kent Gibson <warthog618@gmail.com>
To: Herve Codina <herve.codina@bootlin.com>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>,
	Linus Walleij <linus.walleij@linaro.org>,
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH 2/2] gpiolib: cdev: release IRQs when the gpio chip
 device is removed
Message-ID: <20240221005553.GA41819@rigel>
References: <20240220111019.133697-1-herve.codina@bootlin.com>
 <20240220111019.133697-3-herve.codina@bootlin.com>
 <20240220142959.GA244726@rigel>
 <20240220192657.3dd9480c@bootlin.com>
 <20240221002555.GA3311@rigel>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240221002555.GA3311@rigel>

On Wed, Feb 21, 2024 at 08:25:55AM +0800, Kent Gibson wrote:
> On Tue, Feb 20, 2024 at 07:26:57PM +0100, Herve Codina wrote:
> > Hi Kent,
> >
> >
> > I probably missed something but I don't see this use after free.
> > Can you give me some details/pointers ?
> >
>
> What is to prevent userspace releasing the request and freeing the
> linereq while you use it?  The use after free is anywhere that is
> possible.
>

To answer my own question - the notifier call chain itself will prevent
that - linereq_free() will get blocked on the notifier chain semaphore
until the notifier call returns. So there is no use after free problem.

My bad - sorry for the added confusion.

Cheers,
Kent.


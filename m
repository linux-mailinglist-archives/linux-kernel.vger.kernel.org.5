Return-Path: <linux-kernel+bounces-21785-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D498E82943F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 08:25:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8225B1F26FE5
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 07:25:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3470A39AF6;
	Wed, 10 Jan 2024 07:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="USndf0YW"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB96039851
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 07:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-40d60c49ee7so43638335e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jan 2024 23:25:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704871534; x=1705476334; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fWHgi0F8aOvhuEosvb59tpcR7vgfsaa1QjiQKlh8T8c=;
        b=USndf0YWNXB1/So0G5UmJaVBPvTXqb8foRjCyeQF1ACooHBJtx9TvB2M4eo7Um+xjU
         QeG7rtxrFR805laRRLanii1YkQpVkp/wDHO9HYJ5uTU4aPmj/tSreUCNLuLKwHQk+Ydy
         3u5jdIIVXIkxPzNfbsQbUOQpbp0M9fmMzS3psiNn20DL67errExJ+K0duoWE9VLb1TQG
         ejRNkqKX346wUdXYsNKOJsiEWBnCJuJVhHrhD0WwPeXV+ptbQLUjtfpVE7/x2IkInBUa
         z2KlSu970qLuNMBOgPpN9eaCipg4Dyd2C11tWjJQksYu4Z0m6IAtiJT9nfM6YNjSk8T5
         DjKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704871534; x=1705476334;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fWHgi0F8aOvhuEosvb59tpcR7vgfsaa1QjiQKlh8T8c=;
        b=QLvTDZvMPwa04EmUM2ooaJCp577X8KXFticy4A2NXomvliypFVpUKB4fPViTRNIV/H
         AiMZEaA3hiMnAmTZ7tnJf0xiO7qG/K+inPTXiW2nJs1vJwHdrCJQs7UYwP+3nrVJwNBe
         BTFgK3w3EcnSv6iZSA1KKltWwUN8Y68Sq1qsMuCjnYYvOwWBen2kcwqvUBE8P+Ua4gAM
         1ZFHyDCuFs8tu/W892NoErAG3L57aYb6uF8F8+dyoKvDgJUWnczGDfmlHK2K01IAAZOw
         GccL0Oz6TatSRugUYiQ8vD/qcE9y+9BniFGFcIt5+Hr8j3yNEfqoZijYi39nhEGqosfi
         Z2og==
X-Gm-Message-State: AOJu0YwROb8LLrW26y5XQWMVhADZHun3NXI8kP5TQayHdOkSgiN7/tkV
	OvUjedRZjqPTywCxGVPDnn1v53TzPRvuCg==
X-Google-Smtp-Source: AGHT+IHANMSbivIIgcWx2RXwxuFOolpQOL/cdhqJYkwRqfeLQYHfc9Fl/CSMTqne1Q8Lc1/X8WznlA==
X-Received: by 2002:a7b:ca55:0:b0:40e:4d1b:27e0 with SMTP id m21-20020a7bca55000000b0040e4d1b27e0mr296350wml.20.1704871534018;
        Tue, 09 Jan 2024 23:25:34 -0800 (PST)
Received: from localhost ([102.140.209.237])
        by smtp.gmail.com with ESMTPSA id p23-20020a05600c205700b0040e526bd5fdsm378493wmg.1.2024.01.09.23.25.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jan 2024 23:25:33 -0800 (PST)
Date: Wed, 10 Jan 2024 10:25:30 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Ariel Silver <arielsilver77@gmail.com>
Cc: forest@alittletooquiet.net, gregkh@linuxfoundation.org,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Staging: vt6655: Fix sparse warning. Restricted cast.
Message-ID: <b62deb16-daa0-412e-8e11-bf45b88d3107@moroto.mountain>
References: <20240109072704.44582-1-arielsilver77@gmail.com>
 <d6489a61-3985-4fc2-9eda-333ea8fa02ae@moroto.mountain>
 <CACKMdf=Kppts=NzTVsNNuFcYge2HU+vG83b2C2QNyPEsiFHnkw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACKMdf=Kppts=NzTVsNNuFcYge2HU+vG83b2C2QNyPEsiFHnkw@mail.gmail.com>

Hm...  This stuff is more broken than I realized when I first looked at
it.  And the truth is that I don't know the hardware so I can't say
exactly what the fix is.  Probably best to just leave it alone for now...

On Wed, Jan 10, 2024 at 08:25:33AM +0200, Ariel Silver wrote:
> >> Hello Dan and thank you for the quick response. Much appreciated!
> >> 1) I am probably wrong, but as I see it, the current code assumes that
> >> 'CARDqGetTSFOffset' returns a little endian value.
> >> So it calls 'qwTSFOffset =  le64_to_cpu(qwTSFOffset)'. However digging in
> >> the code of 'CARDqGetTSFOffset' I don't see a reason to assume that.
> >> Which in my opinion can cuase a bad endianness cast on big endianness
> >> systems.

You're actually correct.

But the thing is that le64_to_cpu() and cpu_to_le64() do the exactly the
same thing.  If the hardware is little endian they do nothing, but if
the hardware is big endian they call bswap_64().  The only difference is
how a human reader understands it and for git annotations.

What I suspect is that we should be passing little endian data to
iowrite32().  In other words we should change the le64_to_cpu() to
cpu_to_le64().  This wouldn't change how the code works, it would just
change how it is annotated.  However, on the other hand, I see plenty of
examples where it's passing CPU endian data to iowrite32() so maybe we
should get rid of the conversion instead.  Who knows?

I suspect is that this driver has never worked on big endian CPUs...

I would say let's not change this until we're more sure what's going on.
And probably if we make changes that affect runtime as opposed to just
modifying endian annotations, then that needs to be tested.

regards,
dan carpenter



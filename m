Return-Path: <linux-kernel+bounces-161774-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C5438B5102
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 08:09:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EE303B22632
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 06:09:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D339E10788;
	Mon, 29 Apr 2024 06:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZyLZ0FPU"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A6FC10A13
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 06:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714370912; cv=none; b=X7mWDoEUIQtrmxxofJYQeVzdP6hEE+fEfxxVRDRuBS91XVCCG2MtOSLPaCZE0Kmt1Y3oj9qiYhkHaWiJpbgIXj0H0J3GkujXzLwkLYbKo+Q1HAH0o4HcWgehYud97XIYDnJmN0EE16f0/Nv54zy21W/2w5a7LCH4qpI6VQn+VMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714370912; c=relaxed/simple;
	bh=G7TJdPY3qO2t92qGYbMZeZhZTuxjKGLg9eU1x0YjY10=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=faVR6GML1B2nC5/oUuEL3M4sn3y7Gn204H2F2qwds9ZymYKhd6Ls5MHwMLfaYWH3HhxtR5FFxGDQ1oBj2aPhJnZ/hubSqw+cap+0hNZOZ1R8luLS7UUD3exmV7FKjE+EXE1gTLV9Pe2jJm2RnEB1EyHgLCrWwnsx5nR5pfpHFAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ZyLZ0FPU; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-56e47843cc7so3876095a12.0
        for <linux-kernel@vger.kernel.org>; Sun, 28 Apr 2024 23:08:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714370909; x=1714975709; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pvCfGDKq3NkKQAZVcl3gvcyNhlZM/4Uefp4v92bTZ8E=;
        b=ZyLZ0FPU4n+cG1abmoWrih9jSVtdKwbw45Wy2UQREyArXF1+TRVQG3jYPOEF5zYp4e
         iSphrrqM9wvG7RE/ABRKqn8Tx5YLfHWnoiuIAooTP8JG60JPxRLH1/7z52n5ZuBbduV6
         mudnjnOWZl43OlP3jFvYrIob4bjqsCuHJLoA2JLSsEtr1IFPGqvfTH+0IgA2emc8aldy
         1md2tiBpCLdNE/SzgODf5UeTu1UKRZWbCk2fUlBiWniC2EaQ7+iRXjNuhwDfGgAc8Erc
         dWrDpXwVlRHRwp54BPm3YfAd4O0KCv2lWOxFauHKEqaOJzYTTb6Df4+eoOFY8u5iOnPV
         cSBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714370909; x=1714975709;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pvCfGDKq3NkKQAZVcl3gvcyNhlZM/4Uefp4v92bTZ8E=;
        b=Punve5LxPdC/6UBT1nZfRusMsPpi18v0DfhDlokvjHXfa3YLJXey27ihlBmEXAbuWc
         edrcPeC4swLMVpp/JoXmarXI9TH9AliqoIF60SxJqpH9jxRIih1eVcZc35DVY5HNZvY/
         gNOW3mJmV3EPS1yLdwlHQf87zgx4UzmALFV45hYM9eBZxWM6cIK+5N9Hso1atog/wX4N
         hpjZmvczytsCTMdVfQ1Z9cMrDkdn9fQ0HVd+O0SBTxrSHyTVN3qbQlp8R6y+MS/1cyEG
         uKEYa45jMBCe8lbFz2/MFQL/plVpKdNLApH7e4rJDQXGYh1hJaUypSYWG6fN2U38/N7A
         ItlA==
X-Forwarded-Encrypted: i=1; AJvYcCUPHBAseaD6GU45Tck9yvFS0rzx3fVPqg6T2jSL12ITT5AaGhS+GMyLzhURxfUlPvR8ncjiKLu9Iw5gIzIp+qIQRRnHpcyH1Q+LP0ce
X-Gm-Message-State: AOJu0YwSLmlTDN4DlhNe0+IYM84mW5vY++yjbHaz+W+HPWed96YItVnV
	3ruJ+omZnbCYETav/NmFgxJmLBiqVyQutp76PzyIzqvhVBvxOoe8E4NoXZ/1jMg=
X-Google-Smtp-Source: AGHT+IGXHWZJ0k9VgResxd/8nAAasZ5KzykP6pPgXMGjd/2HPcVWuqQtBjRpxFXW+yVkCtBfMc2gcA==
X-Received: by 2002:a50:d496:0:b0:571:d380:95fd with SMTP id s22-20020a50d496000000b00571d38095fdmr5722874edi.28.1714370908456;
        Sun, 28 Apr 2024 23:08:28 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id v10-20020a056402184a00b005722cb1dd6fsm5920503edy.27.2024.04.28.23.08.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Apr 2024 23:08:28 -0700 (PDT)
Date: Mon, 29 Apr 2024 09:08:24 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: Christoph Lameter <cl@linux.com>, Peter Zijlstra <peterz@infradead.org>,
	Pekka Enberg <penberg@kernel.org>,
	David Rientjes <rientjes@google.com>,
	Joonsoo Kim <iamjoonsoo.kim@lge.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Vlastimil Babka <vbabka@suse.cz>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH] mm/slab: make __free(kfree) accept error pointers
Message-ID: <571761df-fe50-49e8-8d56-65fbdec9a185@moroto.mountain>
References: <285fee25-b447-47a1-9e00-3deb8f9af53e@moroto.mountain>
 <Zi8N66yehahl6D59@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zi8N66yehahl6D59@casper.infradead.org>

On Mon, Apr 29, 2024 at 04:03:07AM +0100, Matthew Wilcox wrote:
> > diff --git a/include/linux/slab.h b/include/linux/slab.h
> > index 4cc37ef22aae..5f5766219375 100644
> > --- a/include/linux/slab.h
> > +++ b/include/linux/slab.h
> > @@ -279,7 +279,7 @@ void kfree(const void *objp);
> >  void kfree_sensitive(const void *objp);
> >  size_t __ksize(const void *objp);
> >  
> > -DEFINE_FREE(kfree, void *, if (_T) kfree(_T))
> > +DEFINE_FREE(kfree, void *, if (!IS_ERR_OR_NULL(_T)) kfree(_T))
> 
> Wait, why do we check 'if (_T)' at all?  kfree() already handles NULL
> pointers just fine.  I wouldn't be averse to making it handle error
> pointers either.
> 
> > -DEFINE_FREE(kvfree, void *, if (_T) kvfree(_T))
> > +DEFINE_FREE(kvfree, void *, if (!IS_ERR_OR_NULL(_T)) kvfree(_T))
> 
> Ditto kvfree().  Fixing kfree() would fix both of these.

I've always thought freeing pointers that have not been allocated is
sloppy so I like that kfree() doesn't allow error pointers.  We always
catch it before it reaches production and that teaches people better
habbits.  Personally, I like how free_netdev() only accepts valid
pointers.

But I won't fight you on that if you want to change it.  People have
discussed this in the past, but no one has actually sent the patch.  It
would probably be merged.

The __free() stuff is different because it's supposed to be transparent.

Btw, I'm hoping we can officially declare small allocations as NOFAIL so
then we can start doing allocations in the declaration block and remove
the error checking and the cleanup.

#define __ALLOC(p) p __free(kfree) = kmalloc(sizeof(*p), GFP_SMALL)
#define __ZALLOC(p) p __free(kfree) = kzalloc(sizeof(*p), GFP_SMALL)

	struct foo *__ZALLOC(p);

regards,
dan carpenter


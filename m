Return-Path: <linux-kernel+bounces-22642-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D04382A0D6
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 20:07:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 723D31C2100E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 19:07:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 719964D107;
	Wed, 10 Jan 2024 19:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oGvqgTZ+"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D3843FB33
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 19:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-40d5336986cso58417225e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 11:07:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704913658; x=1705518458; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+P+xtDPwcW5Zm5Sc54Zw2llE/L7aQj0xQovZZhL7NkQ=;
        b=oGvqgTZ+JwBFhUDlM/eSPcQBXFf8eOSdeuLauP7A4I/1wAK3mVCU62g6JBATi686Sv
         efXvnkdRjBxN4ouEnHxGIQ+J0Ea6WJPJs2sTF1IEsiIs28kKlS4ThYXPhrF7dYGTVRFo
         iN0EN74ZdY1Ogv1ZB5fqO2adKNG4pACPmjdjJ665XB4r/hShI2gLwO/PpYpHW9eRvdEO
         tpmh+B5SJdwa5zo4iL8h0S6zlAG6OQL4UQfH9YROFOSkR9wgTmwww2Exj2/8l3IAH9Ag
         mcjcRxoJVApkDVOseXIl3hw9+GOBkE5AHYlUMjgc7TmWQgMR5PhmQcyR9NwbdWvLvuHL
         gXjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704913658; x=1705518458;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+P+xtDPwcW5Zm5Sc54Zw2llE/L7aQj0xQovZZhL7NkQ=;
        b=d/bU24xnySgbSBggmZmjrZaJ4WvVC7ya9MMg/o6uJZiFlEjr1vU8F+mr14t7nNha+y
         UHOmXUNaWqF6GfwKxew4/QRf4jw1Z66mhDcQHe6NX+va/5TyrCjFlGeT6d3lQofX3lbK
         eOmhjObpzDIETx+R14EyguyI/PXrzVa7o8GP9DMSS8KayDucR2AMZJ4qdFntjNc9bWd5
         lrdHgAp077RskkhktHeTMKnHWDd1XbDF9GDRpckvZOBPL33qUlgGNt+8DXujeUlSS5Va
         rVL4gBqhCmmJJlyphKcLkCrEOhIsDVrydYDj40d7hvB5osfM4zawBx7chfUoJTk5tU1Z
         v16w==
X-Gm-Message-State: AOJu0YyFaCKbDgEjCzZFC+bnlFr/WzvgVrEx3iqOXa/pHScqlrRcOI/7
	prn3LWrz8rES14PLZnHfGqHxFX4O9xnHnw==
X-Google-Smtp-Source: AGHT+IFpLbItD8Z0qoB13nhD+qE/NzgQAw7SjExTsvUdRvHQVeLo7hpj5s59mQtb2/k4pxwcECaNkQ==
X-Received: by 2002:a05:600c:1908:b0:40e:45a3:dcb7 with SMTP id j8-20020a05600c190800b0040e45a3dcb7mr769999wmq.116.1704913658186;
        Wed, 10 Jan 2024 11:07:38 -0800 (PST)
Received: from localhost ([102.140.209.237])
        by smtp.gmail.com with ESMTPSA id z6-20020a05600c0a0600b0040e49045e0asm3102410wmp.48.2024.01.10.11.07.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jan 2024 11:07:38 -0800 (PST)
Date: Wed, 10 Jan 2024 22:07:34 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: David Howells <dhowells@redhat.com>
Cc: Jeff Layton <jlayton@kernel.org>, linux-cachefs@redhat.com,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] netfs, fscache: Prevent Oops in fscache_put_cache()
Message-ID: <6ec71521-66ec-4da8-ad3e-2037cdde4287@moroto.mountain>
References: <9872f991-56a8-4915-b9b0-53accd6db0ef@moroto.mountain>
 <1788108.1704913300@warthog.procyon.org.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1788108.1704913300@warthog.procyon.org.uk>

On Wed, Jan 10, 2024 at 07:01:40PM +0000, David Howells wrote:
> Dan Carpenter <dan.carpenter@linaro.org> wrote:
> 
> >  	zero = __refcount_dec_and_test(&cache->ref, &ref);
> > -	trace_fscache_cache(debug_id, ref - 1, where);
> > +	trace_fscache_cache(cache->debug_id, ref - 1, where);
> 
> You can't do that if !zero.  cache may be deallocated between the two lines.

Ah...  Right.  I misread what was going on in the latter part of the
function.  Sorry, I'll resend.

regards,
dan carpenter



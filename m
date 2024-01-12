Return-Path: <linux-kernel+bounces-24665-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A54082BFFE
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 13:50:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BFEBD1F24A6F
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 12:50:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 655C95D744;
	Fri, 12 Jan 2024 12:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hIYUIJtj"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E80041C67
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 12:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3367601a301so5434118f8f.2
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 04:50:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705063807; x=1705668607; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ffDVakycpQ7cBopIWY9dBvwcHA+X2IQ9A3mW/X1FrhM=;
        b=hIYUIJtjccgYIWeij0u5a7U68yOaLxWxzB0M9RK+aZwIyckVFyQ5oZXL8MfRs5IM/J
         WppvpCirjX3NeLDJfaXymuTCRLlCZmFPUDQbEcuTDuH6MEK/SCvj++UzH1DPfSUWAbtM
         PTeCMMT3T2VjhWDyD8ABP6ggo2rAqFly2ykorLbErlBxS0HUlTHpPdP1NdR8aHFqa19M
         ijWWDMxLoTd971Pg+87hbw9e3eYoJpWscHbBecXS16gKYZKaluCMcQ2byekNwUWUZftG
         OqiF5Nac56TPsOcICwBU4+J3I6D8SzdwE7fiySzXfr0z3XjCferSWSQRCmlKjH5gX5m7
         gL5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705063807; x=1705668607;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ffDVakycpQ7cBopIWY9dBvwcHA+X2IQ9A3mW/X1FrhM=;
        b=GpQxipKG3nd7KVRR2mNufAJDQ1pOXiqEiLhWmL3+bvieaoWOAbKMovdHw4KGz6Mxst
         wGwlbwuoRgEKCwkmM7j8tghohR1dH8njmqELZGNSrd7ptHq8X2SxUpmd9VKahpnE0UFp
         EG+QxHKI6cy7JZ/WPix+J/ItnLeXweOhQORV0tlQnx9vDJHdgfC4zKvA0LWRAVKupRnR
         6DI8W/HTdzkoKThcAMMC9AkJpsE45gxdt6GP8nz8tcifrtu3wjC/x3LmsYTG88xW5uls
         ++63KiS9TAqw2Y/44NSCRtgGiai/hfp56OF1LpIQ20P45KShKgnWLCZ+IdeEMni0ZCV/
         FbLA==
X-Gm-Message-State: AOJu0Yynv2/K9ZNL7lEojZsuIr5rLc80H3iv6XWhdODQBE6Nk7O7F9yU
	WNxQgXY/2gRcsyjg/gg8TRqkUetQpH8QBA==
X-Google-Smtp-Source: AGHT+IFqG8iW47ztXesp0uGo1KR3R417Z/migyPS8NUDKfnP4qmV7pf4b8COGkOfXagiPz51h/CpSA==
X-Received: by 2002:a05:600c:358e:b0:40e:3cab:ef76 with SMTP id p14-20020a05600c358e00b0040e3cabef76mr455609wmq.117.1705063807082;
        Fri, 12 Jan 2024 04:50:07 -0800 (PST)
Received: from localhost ([102.140.209.237])
        by smtp.gmail.com with ESMTPSA id d11-20020adfa34b000000b00336e15fbc85sm3807205wrb.82.2024.01.12.04.50.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jan 2024 04:50:06 -0800 (PST)
Date: Fri, 12 Jan 2024 15:49:59 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: David Laight <David.Laight@aculab.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	'Andy Shevchenko' <andriy.shevchenko@linux.intel.com>,
	'Andrew Morton' <akpm@linux-foundation.org>,
	"'Matthew Wilcox (Oracle)'" <willy@infradead.org>,
	'Christoph Hellwig' <hch@infradead.org>,
	"'Jason A. Donenfeld'" <Jason@zx2c4.com>
Subject: Re: [PATCH next v4 1/5] minmax: Add umin(a, b) and umax(a, b)
Message-ID: <737627fd-b68b-4c9d-8700-f0e0d6d9cec8@moroto.mountain>
References: <b97faef60ad24922b530241c5d7c933c@AcuMS.aculab.com>
 <41d93ca827a248698ec64bf57e0c05a5@AcuMS.aculab.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41d93ca827a248698ec64bf57e0c05a5@AcuMS.aculab.com>

On Mon, Sep 18, 2023 at 08:16:30AM +0000, David Laight wrote:
> +/**
> + * umin - return minimum of two non-negative values
> + *   Signed types are zero extended to match a larger unsigned type.
> + * @x: first value
> + * @y: second value
> + */
> +#define umin(x, y)	\
> +	__careful_cmp((x) + 0u + 0ul + 0ull, (y) + 0u + 0ul + 0ull, <)

Why do we match "a larger unsigned type" instead of ULL_MAX?  Presumably
it helps performance somehow...  I agree that it's probably fine but I
would be more comfortable if it skipped UINT_MAX and jumped directly to
ULONG_MAX.  These days 4 gigs is small potatoes.  The vmalloc() function
can allocate 4G so we've had integer overflow bugs with this before.

regards,
dan carpenter



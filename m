Return-Path: <linux-kernel+bounces-84869-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CA97786ACD7
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 12:20:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EEDE11C23310
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 11:20:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 670C8139596;
	Wed, 28 Feb 2024 11:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="ZgpveGg4"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 145DA12D74F
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 11:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709119221; cv=none; b=S6XQamTf2hIQxBRFZTE+9eLljecmP/clk8sIm9pv281YnkgKQN+7dV0mn3j5habx9z4XrCz43Lab2PP8RybrJCGy1q24op99lyZ0lJRDpWpx7BVNakCFq7mT+mW259YZaBVb5pmVi15hjIjJrQ+VTU5VM/uAZl8aMVPgU6nIvGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709119221; c=relaxed/simple;
	bh=9Pjb8ad1dWopeClTm1dO7F0uJkozJKBfGd87+TqwJvU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m38Il1HiItCC0Upzp5LUXVRrYwKDg/2bTBKcSPGBY6kQ3d2qNQAeZn72v1zN1pmMp2EGSbblvjy9rjnLcy2ur91YEmJfClPWXIlR4/chd+MiuDUdt8EDjusrslkTZSI5hP07NkTtWVwrbGwB/wjmhS1D257UZKT3qupfMcpgNCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=ZgpveGg4; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a3f893ad5f4so740940466b.2
        for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 03:20:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1709119216; x=1709724016; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jIUrY9KDv7usIWFJU72QBMyWmzWFvkj4Y1/FWWb0GFA=;
        b=ZgpveGg4xq/XgoyEYabBsRbocLVbwIaU6J4I/pjURJ7F06gAUewxgoAkz2st/LXfIf
         KOxqsVg3IRdHxp1ZJWiZFZpOJKjX217TuwaWRgG6Eia0HhoBtMKGD+Lw4L9DdSlYm0mb
         Epc6CXVh1wTDcgZJLBN1Y3YS865iAlswWnXqiIE21JoQVT1W30lcsjm/4cv/JmEaznt0
         SXxWhKls53pjjqtR6KaxJKxOYceWs7nKzeXqZL3tZviN08IfmLppCztTnxAwA83WdOx+
         jcU8os0Ab12/beMB/pnCx7yQJ1mi1WeMkg+19MBKEgsaH2/1uwKOjEj2fustWV3oDe+u
         u/Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709119216; x=1709724016;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jIUrY9KDv7usIWFJU72QBMyWmzWFvkj4Y1/FWWb0GFA=;
        b=V3WP/q3Y50IW9In7EAXFxHJfY3gACqkJi1C6txorn3cRGL2M89c/yI88cnDQRFO0UH
         9vSWJnC5fcej9viznsi1K8OKuFkHId1XrouRkqrgeJEBQDWzP5wp0vxEXyVXzrA5Ooks
         59H2IBNaxl7aHI0Ns/QhrDV5rRW2+LalkF+/f7p3EKzboYAv6Y6Hx6hrYgbW8yEmzatY
         cvZodE7HRw254p8lgQ3IMH29sUi10J/mg9lXOS+yeL81u11GW0psT6gowx9ZeF32OtEj
         TWfRfQbfsGQSgRXRL5bHvAPU6H26h/4kqI/0jxYUIu8lCesxSTNkOBggEY8iCX6HEysZ
         efgg==
X-Forwarded-Encrypted: i=1; AJvYcCXAyZ8jy/obAefDZriGpCww+PxB4hWDN1GLTilgUR1WTNtjOKK8VOhfu++889Jnvt86SQkD2oSOjZkSY2yX4ioxjq7Ghq3xMQhmX2mr
X-Gm-Message-State: AOJu0YyKDPZhgpc7FD3+2zbx/9ZJ8G1wsSqiP2F2S0a92gPtRSetg/ks
	2es/HnRiogTFC0ZZA4oS2Y6FFZ1KZ/rqmUO0g/prwB6b3j8WYEAs14sZluCQofE=
X-Google-Smtp-Source: AGHT+IFSmAlyL49e7kuOHG3BsunXaZMk/Ik8ctahiZAzhUx4+Z5ypejavGk3mJum5OZeWHK50T0qhg==
X-Received: by 2002:a17:906:131a:b0:a43:9ad1:f1d2 with SMTP id w26-20020a170906131a00b00a439ad1f1d2mr3638380ejb.1.1709119216393;
        Wed, 28 Feb 2024 03:20:16 -0800 (PST)
Received: from alley ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id kf5-20020a17090776c500b00a438d594d3esm1732203ejc.217.2024.02.28.03.20.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 03:20:16 -0800 (PST)
Date: Wed, 28 Feb 2024 12:20:14 +0100
From: Petr Mladek <pmladek@suse.com>
To: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: Matthew Wilcox <willy@infradead.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] Printing numbers in SI units
Message-ID: <Zd8W7mGt1KnIUOtn@alley>
References: <ZbFd5TZ_pi7q3hso@casper.infradead.org>
 <94713e86-30a8-4828-959d-bd95800149e4@rasmusvillemoes.dk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <94713e86-30a8-4828-959d-bd95800149e4@rasmusvillemoes.dk>

On Wed 2024-01-24 23:43:15, Rasmus Villemoes wrote:
> On 24/01/2024 19.58, Matthew Wilcox wrote:
> > I was looking at hugetlbfs and it has several snippets of code like
> > this:
> > 
> >         string_get_size(huge_page_size(h), 1, STRING_UNITS_2, buf, 32);
> >         pr_warn("HugeTLB: allocating %u of page size %s failed node%d.  Only allocated %lu hugepages.\n",
> >                 h->max_huge_pages_node[nid], buf, nid, i);
> > 
> > That's not terribly ergonomic, so I wondered if I could do better.
> > Unfortunately, I decided to do it using the SPECIAL flag which GCC
> > warns about.  But I've written the code now, so I'm sending it out in
> > case anybody has a better idea for how to incorporate it.
> 
> Well, something that gcc will warn about with Wformat isn't gonna fly,
> obviously. But my man page also mentions ' as a possible flag for d
> conversions:
> 
>        '      For decimal conversion (i, d, u, f, F, g, G) the output is
> to be grouped with thousands'
>               grouping characters if the locale information indicates any.
> 
> Obviously, our printf wouldn't implement that, but "grouping by
> (roughly) 1000s" is kinda related to what you want the output to be, so
> it seems apt. The man page also says "Note that many versions of gcc(1)
> cannot parse this option and will issue a warning.", but I think that's
> an ancient and irrelevant note. None of the gcc (or clang) versions
> godbolt knows about give that warning.

I am personally not a big fan of using random printf() modifiers for
a non-standard behavior.

For me, it is much easier to look up what string_get_size() does.
The alternative would be to check "man 3 printf" just to realize that
%#d or %'d does something else in the kernel. And where the hell is
the behavior documented. I know it but how many others do?

And if I wanted to use it in a new code then I would not expect
that it is supported by vsprintf() kernel implementation. I would
try to find it in the existing string helpers and get sad that
it is not there.

I see only 18 users:

$> git grep string_get_size | grep -v -e  test -e string_helpers | wc -l
18


> I'm not really sure the implementation should imply a trailing B; that
> might as well be included in the format string itself - perhaps the
> quantity is bits, so a lowercase b is better, or perhaps it's some
> frequency so the user wants Hz.
> 
> As for frequency, one would probably prefer the real, 1000^n, SI
> prefixes and not the IEC 1024^n ones, and regardless, I think there
> should be some way of doing both STRING_UNITS_2 and STRING_UNITS_10. At
> first I thought one could distinguish by using either one or two ', but
> gcc does warn for repeated flags. Two options I can think of: (a)
> Overload the precision, so a precision p >= 10 means STRING_UNITS_10
> with actual precision being p-10 (and yes, by all means cap that at 2).

Yet another non-standard behavior.

> (b) Currently %i and %d are completely equivalent, we could make them
> different in case a ' flag is present and make one do the 2^n and other
> the 10^n.

Same here.

IMHO, this "feature" would add more harm than good. And it is not worth it.

Best Regards,
Petr


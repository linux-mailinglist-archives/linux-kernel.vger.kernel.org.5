Return-Path: <linux-kernel+bounces-32402-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AEF94835B46
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 07:55:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66B5528368A
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 06:55:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBD39DDB8;
	Mon, 22 Jan 2024 06:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xbzs7y+9"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 762D0F4EB
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 06:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705906518; cv=none; b=SX2XYPJqVXrfNRS+xIjUIKZ6CluRClRxSOZeqqfCorNRjAtoOUFySzdn+gK7gsZg/JAwQeOArFh2Rafqf90nxdMMp2HxxBRd6fYT6I0+AXhql5ODiRwGxVrlpJLKUqKZBX+iRp2GtTzw9hEbDvxWtelKv6494kkGnEsbbcrrvOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705906518; c=relaxed/simple;
	bh=kurIw7V3rZKMF/Ht1fnXn8epEvVoc15GU/v6IoSqneU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g/lQrX9C2QQ7qz+EbajVDuGovl1dMbZVOH9y9g2WJth5v42HkTOrcUbJBfDBIsz+ddG/0QSSGdmSja/QfkIYcgi8x7+eoGyPbeVS2kwgwE3L0hfwODlfJI01Va10pv++M/d53UIxfkbmVraSR0R3qgvJbekM5nmfdWwl+JBes+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xbzs7y+9; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-40e775695c6so28326235e9.3
        for <linux-kernel@vger.kernel.org>; Sun, 21 Jan 2024 22:55:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705906515; x=1706511315; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8aUJC8rG/vO3bD1rTOQLhtvB4t4NcN5TufneLFrEaCo=;
        b=xbzs7y+9pWSdOgRktONzsIqxbYnumGP7nzwQGoMk1ZJiR73IDv8pbkwRVYIUZDzsy1
         VPefcV9epAkqtlBqVlmHLchqUhLec4Fc5LShEBIHusHPgxpOhHaVNNV4EU7pOoOrw+0h
         BLAvUo42jjgn152CzvRxIT2ZFwgWxU+IDW5RVKq7nplk6IIt+S8+63PySMplHn+njNhN
         Qzf9xbfMozsEUVfGYdhbWn38HCfbhkKGPZxiUVqQRcr8kpSFYJYPCyARzWFMdfFB26Qi
         9cVr2LdOdtdJ9Twxhlz4Zs84j0dQWx8avQxVqk2TMaByGgaPsRw8MLgyyPpzUL0/WEn2
         gnhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705906515; x=1706511315;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8aUJC8rG/vO3bD1rTOQLhtvB4t4NcN5TufneLFrEaCo=;
        b=eeJPvenLsb/cqIzL4z8Mk94Hh3CJR7sWvuFQPEnO9hQElENctdTZn+E6H8G3p3i13O
         wb+/pUYF8fE79k+o7aUfXqcw467UDhPZwaeByXoN8EVxZBFtbBZgjRrbLRFWM6PIBgHO
         CddZATh4+TTP4/g1+qYCqNnnS82pErH81XJz/FqusN2lkZ5GUl5vLsiuUQX2pw3f8KnG
         INTsdYVqUHGipHrCIA7Z7R12Bghr+Rx845MeWSPNJqx4WmUgSVyrJxWzkCkmtrq0APC0
         MeuKRWxHdzsezLPLN9D7QrntEIBvlYyCwbMAdR76JPR7SE4TAlcWSMqN8Q+/9l5EuPJE
         UcuA==
X-Gm-Message-State: AOJu0YxBO9l7Ywuv/lsQeFitPOAR/NF53k+wjcJVnmg5G52MZ8YA5Pzf
	gcoMorazYN/Jt92FmXC27lUGz4iKYSGJ6c1W4lFahY4TxFN8CQfqzaj3+xSazmw=
X-Google-Smtp-Source: AGHT+IGfn4IAtpvCRksZdJ+qY0f4oJppo8bUr5RyWi7AbO/2NfJDVKSiGSy1jFwXSGGedSZzJIOsgA==
X-Received: by 2002:a05:600c:6002:b0:40e:ae0b:62ee with SMTP id az2-20020a05600c600200b0040eae0b62eemr387119wmb.56.1705906514724;
        Sun, 21 Jan 2024 22:55:14 -0800 (PST)
Received: from localhost ([102.140.209.237])
        by smtp.gmail.com with ESMTPSA id u21-20020a05600c139500b0040e4a7a7ca3sm38018916wmf.43.2024.01.21.22.55.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Jan 2024 22:55:14 -0800 (PST)
Date: Mon, 22 Jan 2024 09:55:11 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Erick Archer <erick.archer@gmx.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Franziska Naepelt <franziska.naepelt@googlemail.com>,
	Hans de Goede <hdegoede@redhat.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Jeff Johnson <quic_jjohnson@quicinc.com>,
	Aloka Dixit <quic_alokad@quicinc.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8723bs: Use kcalloc() instead of kzalloc()
Message-ID: <a5d8a5f1-432d-46f0-84fe-7b5b22ff5f32@moroto.mountain>
References: <20240119173900.11035-1-erick.archer@gmx.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240119173900.11035-1-erick.archer@gmx.com>

On Fri, Jan 19, 2024 at 06:39:00PM +0100, Erick Archer wrote:
> As noted in the "Deprecated Interfaces, Language Features, Attributes,
> and Conventions" documentation [1], size calculations (especially
> multiplication) should not be performed in memory allocator (or similar)
> function arguments due to the risk of them overflowing. This could lead
> to values wrapping around and a smaller allocation being made than the
> caller was expecting. Using those allocations could lead to linear
> overflows of heap memory and other misbehaviors.
> 
> So, use the purpose specific kcalloc() function instead of the argument
> count * size in the kzalloc() function.
> 
> Also, it is preferred to use sizeof(*pointer) instead of sizeof(type)
> due to the type of the variable can change and one needs not change the
> former (unlike the latter).
> 
> Link: https://www.kernel.org/doc/html/next/process/deprecated.html#open-coded-arithmetic-in-allocator-arguments [1]
> Link: https://github.com/KSPP/linux/issues/162
> Signed-off-by: Erick Archer <erick.archer@gmx.com>

I quite often write responses to patches and then never send them.  I
wrote this response and debated sending it but in the end I decided to
send it because you have sent multiple patches.  If you had only sent
one patch then I wouldn't have bothered.

Generally, commit messages should say what the user visible effects of
a patch are.  Sometimes with these sorts of commits, it's hard to
determine the effect.  For example, Kees went through and changed dozens
or hundreds of these allocations to use safer constructs and we don't
necessarily expect him to audit all the code.  They should already have
been fine, but it's better to be safe.

However in this case obviously the patch is small and just by glancing
at it we can see that it has no effect on rutime.

But if someone is reviewing patches with "git log" instead of
"git log -p" they aren't going to see the patch. I can almost always
figure out what a commit does without looking at the commit message,
that doesn't mean that the commit messages are unnecessary.

So I really prefer if commit message say, "This commit is just to make
static checkers happy and to make the code more readable.  It has no
effect on runtime."  The commit message you wrote is way more scary than
is warranted.  Here is my proposed commit message:

"We are trying to get rid of all multiplications from allocation
functions to prevent integer overflows.  Here the multiplication is
obviously safe, but using kcalloc() is more appropriate and improves
readability.  This patch has no effect on runtime behavior."

regards,
dan carpenter



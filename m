Return-Path: <linux-kernel+bounces-76727-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A24B785FB9F
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 15:52:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 441621F236D7
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 14:52:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77DEF1482EA;
	Thu, 22 Feb 2024 14:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YLs4moyt"
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61B4B3DB9A
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 14:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708613515; cv=none; b=Wy0r8lXQRS7bprk+LDZJLcXqxgEKw3tws1ungZTF16C8rkR26zJjnr43GbLGF14hto+B6X4ZOV679399KmSTHN32I4KKs0DNfSWT84KL6FCXw1uvwKhANNMH5UfhB6Oyr6z86leDz9EGYlqwgurdDjOaWjp93+sc2MALJbA6qkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708613515; c=relaxed/simple;
	bh=qOKtklnA2Fte+EaioXXEuy/iElgHZ66rRb0Ul9+Ufic=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XFHi7lPec5CFTfC1KXhf+SIYtCaLnJkJpNjatnyb25F17IXk4Bq/QWmRyGbt1VpgfoGC8UqJP3GJt07tI9YEHxeyW1YXfJL+dFY3CG4PgCyJ3rfgeYXgDSjwK0B0hcNt1f647ZOQWnmTx2zm9qTtL9tHxadiUgUSMdOlx0EraAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YLs4moyt; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-dcc80d6004bso2095687276.0
        for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 06:51:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708613513; x=1709218313; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OJ2JByNJlE66i73qtao/0q2KrYChhoP3YXn1jnSur1E=;
        b=YLs4moytQsKK6y6orlO2BbU/UQCkeIdF8w2216s34ZlX1CV0BF6RELT3sRhI1Ieizc
         pGe0xfbcnuel25o6puxEkxs6cIQMg7Dm0gWpthYxozLj5D5ZJST9VL8kwB98AvCub4Li
         5/MjQtZwjju9VNQsCLXrbZOX5A8kJgvvsLp2yFmcQ0L+YhpGHU3Dk0QwZCWdJTJYyNn5
         00kT4BzP5y7Ol1ZFr9yPGMWsq6qJPkdPAnksyLO6W7mecqg7fGWVvCAu3GuFfd3rb7nG
         K7i0IQhgdj0ODwLGp/+QlN/VmIRcJJ27BFsBW1yJzd9Tp1dFsh+FE+jXzqP7OkVcGs/n
         LzbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708613513; x=1709218313;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OJ2JByNJlE66i73qtao/0q2KrYChhoP3YXn1jnSur1E=;
        b=lMX75TpSqcID1As80Lm5HlhuJufD66OaViqAhcTiqfYz9MY9bLw9W2fe3pxj6TKXy6
         0+nPVcjLLggoD1YgosQ/Wt5Jzd64NJSFRXVgVWlZDe+Umu1XsYLoj8QpUa17m4dAYmzs
         /yLKn9RJyM3QlCS5C4op8Du2U4aijZUdAvs1lCio2ykwwnCA0gOWNLfxG0EvpDfTqGb4
         i5N/8OaNl/A9GMq7jIIUqERRdc9iuQ3puxme34cs53Uwy0pZ4T2A3i4FSt9MUkHYUgnQ
         NivI2kw81JWqdkT0jMrZe0Zgiflacm4Z3P71ycdOX2MFv1/DgJHn4rqE3aOWni6QZFoh
         vRrg==
X-Gm-Message-State: AOJu0Yxj6601g8jaoH9J17jnWzk3zwqp9QmwaaRCzPUU1prt0Au3Wtnt
	NCs7ZTfrZibKVb5qwyjq9hVB1oYoNa8DD47PGWWgwve1YgCCl/kZrs8APMSQ0Pk=
X-Google-Smtp-Source: AGHT+IH54S4llmEMLtI0lCa40dhvFy/UZ9kCu89NGNN2HWU/bgqgeQAH0DpiGHYURTWMgtF+pv3x4g==
X-Received: by 2002:a25:a125:0:b0:dcc:a5dc:e9d6 with SMTP id z34-20020a25a125000000b00dcca5dce9d6mr2434580ybh.30.1708613513187;
        Thu, 22 Feb 2024 06:51:53 -0800 (PST)
Received: from localhost ([2601:586:d030:4ea3:8dfa:1e5f:80e2:c7c])
        by smtp.gmail.com with ESMTPSA id q9-20020a25f909000000b00dcdb3dffa3dsm2761141ybe.39.2024.02.22.06.51.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 06:51:52 -0800 (PST)
Date: Thu, 22 Feb 2024 06:51:52 -0800
From: Yury Norov <yury.norov@gmail.com>
To: Lucas De Marchi <lucas.demarchi@intel.com>
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	intel-xe@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
	Jani Nikula <jani.nikula@intel.com>
Subject: Re: Re: [PATCH v3 2/3] bits: Introduce fixed-type BIT
Message-ID: <ZddfiNP5qGWNDtiT@yury-ThinkPad>
References: <20240208074521.577076-1-lucas.demarchi@intel.com>
 <20240208074521.577076-3-lucas.demarchi@intel.com>
 <ZcZYhZbLyzSXX8PU@yury-ThinkPad>
 <erg2ymp6raf7ru5ggj4hrrhet4i762msoqa2ronv4znfhlkc6o@nxu6ygtdfmrj>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <erg2ymp6raf7ru5ggj4hrrhet4i762msoqa2ronv4znfhlkc6o@nxu6ygtdfmrj>

On Mon, Feb 19, 2024 at 11:13:57PM -0600, Lucas De Marchi wrote:
> On Fri, Feb 09, 2024 at 08:53:25AM -0800, Yury Norov wrote:
> > On Wed, Feb 07, 2024 at 11:45:20PM -0800, Lucas De Marchi wrote:
> > > Implement fixed-type BIT() to help drivers add stricter checks, like was
> > > done for GENMASK.
> > > 
> > > Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
> > > Acked-by: Jani Nikula <jani.nikula@intel.com>
> > 
> > So I get v1 from Jan.23 in my mailbox, and this one is v3. Did I miss
> > a v2? Anyways, please bear my reviewed-by from v1 for this patch.
> 
> Jan 23 was actually the v2 and I missed the subject prefix.
> 
> My understanding was that you were going to apply this through some
> bitmap tree, but checking MAINTAINERS now it seems there's no git tree
> associated.  So I will just add your r-b and merge this through
> drm-xe.

I've got a bitmap-related branch. I can move this series in there if
you prefer. At your discretion.

https://github.com/norov/linux/tree/bitmap_for_next

Thanks,
Yury


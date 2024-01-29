Return-Path: <linux-kernel+bounces-42966-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A7277840960
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 16:11:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C67711C224F0
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 15:11:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35E021534E6;
	Mon, 29 Jan 2024 15:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z5/nU4/k"
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 091AB152DEC
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 15:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706541082; cv=none; b=M5ayeHWDVA+ru3xIi5HMwogMu2KrhBEVLsY7L+Z9b0ku2XMQXOqcjWOrnAszOkGgEFFZxk0UJs2EKM7YkKdhbncbQUCNgutAKmkPnPpu53nJ/G/9qmueQVPLBhAVXS/ThNiLg7B+VunrUzPKPwLE4BW5ksDczvYby3XgTQB4s08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706541082; c=relaxed/simple;
	bh=S8XexM/U3KFJ2Lr9jik3D+Pv3hC4dUuF/SeClqv99P0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ri34plS92gqW8VWtXqBM1qmO0wCt/0lbHnZpSnLvhEt9jvwEfDvgQDyJkNy/iMJC4ydn5LtsTWfVoXhZ5N/WLIqYWQrpZIpGeToplgp/+gu9pLLo1lF5Gs/CaHJDNMIPVkj4ThQIo+wi8Me/0nTEXCtEac9ggUPBiWk76quwQqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z5/nU4/k; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-dc22ade26d8so2409554276.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 07:11:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706541080; x=1707145880; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=UyBI2+8L21ywPJPux+Uv+p4ig16OrBVzk8ATobFMmGw=;
        b=Z5/nU4/kuPLi8Gw75BTXnIWijMOCHJUNdxejjT6tHlI2sWyzJ6UH/J897hB9y09xnd
         gD9s/AIm5VxrUrjKuSKliLZ8iyHzlPJg/WWRdVquXSqCtaAnpiQN69dQrf2tvsZJCsC1
         lSoqmtnbe+6WMsSOdg2EHTKres7152r/8PSEbp+Scchu97m49KPXUmrCIi2w9ak1x2kQ
         UWt/TVF3skCYJAuUUERecam2VeC66df5gIWd/CZygpVD1tccOMfw3T2O1f+MWbLuQ4i9
         8UzdAkBKZQJbwhzaVbQWDC/gUho3n+wIQ7l6Jb7tPjXUI4EymG1uvm8jgthdfJL77BkI
         xxEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706541080; x=1707145880;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UyBI2+8L21ywPJPux+Uv+p4ig16OrBVzk8ATobFMmGw=;
        b=lhOG1vfEWSPefoGOJdRI1mwj6sTBWRqxILqbOT3ve4Bj2VKusChyVQyetdAnclMxq7
         4UGxiyvHZlnSsqQTcOVELsatPL7y3Dni9CiAuIw0g9nV8piHqRhGqbg68KmRIwedXzvW
         kreMG3Wvt88FFhGS4CSMWeASyv8m5AydJHDymbZZv8S7UjmQ+tjVa7GynJTSFVY8wpre
         EdPndHYVE7ObFgpxm35diKOzN+e8KN7IjXLA/LbP9xw4cimrkh93jWWUEECW82d40+kZ
         sxXfMEX+piRby+OpeTMPn0aGR30nTe4SQDaev96wH5m6MLxLk0Pd+9i45506jC5d/glP
         Mx/g==
X-Gm-Message-State: AOJu0YyVqd9osTv00VlQjSQf914FtVJ94VgHoWfiMVHcd5Lljfss3sSx
	DtlybflwDGlElASMhu1rFNtOjtpGu1dU1p980XDW/rNhGc32XUuxAVwqV4UQIkA=
X-Google-Smtp-Source: AGHT+IH6s9vU8wXBWDMvXY5IJ1/1w2lOaFFb2+TzOnPFlDReNgorwWtIdEbPiAsxJhHbD0OsJTnBwg==
X-Received: by 2002:a5b:87:0:b0:dc2:2b1a:7246 with SMTP id b7-20020a5b0087000000b00dc22b1a7246mr2822490ybp.123.1706541078294;
        Mon, 29 Jan 2024 07:11:18 -0800 (PST)
Received: from localhost ([2601:344:8301:57f0:6dcf:e3a4:263a:17d6])
        by smtp.gmail.com with ESMTPSA id u100-20020a25ab6d000000b00dc22fa579c5sm2320375ybi.45.2024.01.29.07.11.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 07:11:17 -0800 (PST)
Date: Mon, 29 Jan 2024 07:11:17 -0800
From: Yury Norov <yury.norov@gmail.com>
To: Lucas De Marchi <lucas.demarchi@intel.com>
Cc: intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	intel-xe@lists.freedesktop.org
Subject: Re: Re: Re: [PATCH 1/3] bits: introduce fixed-type genmasks
Message-ID: <ZbfAFZ4J5Gncb/xc@yury-ThinkPad>
References: <20240124050205.3646390-1-lucas.demarchi@intel.com>
 <20240124050205.3646390-2-lucas.demarchi@intel.com>
 <87v87jkvrx.fsf@intel.com>
 <gvkvihpcc45275idrfukjqbvgem767evrux5sx5lnh5hofqemk@ppbkcauitvwb>
 <ZbEsfl0tGLY+xJl0@yury-ThinkPad>
 <yro4nl7ryt6ckxpkctkaao6sd7j4533w2u66ae4kecpu6riszl@lj5sspyvapwq>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <yro4nl7ryt6ckxpkctkaao6sd7j4533w2u66ae4kecpu6riszl@lj5sspyvapwq>

On Mon, Jan 29, 2024 at 08:49:35AM -0600, Lucas De Marchi wrote:
> On Wed, Jan 24, 2024 at 07:27:58AM -0800, Yury Norov wrote:
> > On Wed, Jan 24, 2024 at 08:03:53AM -0600, Lucas De Marchi wrote:
> > > On Wed, Jan 24, 2024 at 09:58:26AM +0200, Jani Nikula wrote:
> > > > On Tue, 23 Jan 2024, Lucas De Marchi <lucas.demarchi@intel.com> wrote:
> > > > > From: Yury Norov <yury.norov@gmail.com>
> > > > >
> > > > > Generalize __GENMASK() to support different types, and implement
> > > > > fixed-types versions of GENMASK() based on it. The fixed-type version
> > > > > allows more strict checks to the min/max values accepted, which is
> > > > > useful for defining registers like implemented by i915 and xe drivers
> > > > > with their REG_GENMASK*() macros.
> > > >
> > > > Mmh, the commit message says the fixed-type version allows more strict
> > > > checks, but none are actually added. GENMASK_INPUT_CHECK() remains the
> > > > same.
> > > >
> > > > Compared to the i915 and xe versions, this is more lax now. You could
> > > > specify GENMASK_U32(63,32) without complaints.
> > > 
> > > Doing this on top of the this series:
> > > 
> > > -#define   XELPDP_PORT_M2P_COMMAND_TYPE_MASK            REG_GENMASK(30, 27)
> > > +#define   XELPDP_PORT_M2P_COMMAND_TYPE_MASK            REG_GENMASK(62, 32)
> > > 
> > > and I do get a build failure:
> > > 
> > > ../drivers/gpu/drm/i915/display/intel_cx0_phy.c: In function ‘__intel_cx0_read_once’:
> > > ../include/linux/bits.h:41:31: error: left shift count >= width of type [-Werror=shift-count-overflow]
> > >    41 |          (((t)~0ULL - ((t)(1) << (l)) + 1) & \
> > >       |                               ^~
> > 
> > I would better include this in commit message to avoid people's
> > confusion. If it comes to v2, can you please do it and mention that
> > this trick relies on shift-count-overflow compiler check?
> 
> either that or an explicit check as it was suggested. What's your
> preference?

Let's put a comment in the code. An argument that shift-count-overflow
may be disabled sounds more like a speculation unless we have a solid
example of a build system where the error is disabled for a good sane
reason, but possible GENMASK() overflow is still considered dangerous.

GENMASK() is all about bit shifts, so shift-related error is something
I'd expect when using GENMASK().

Also, the macro is widely used in the kernel:

        yury:linux$ git grep GENMASK | wc -l
        26879

Explicit check would add pressure on the compiler for nothing. 

Thanks,
Yury


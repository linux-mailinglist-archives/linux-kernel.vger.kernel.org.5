Return-Path: <linux-kernel+bounces-68095-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC8638575EE
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 07:23:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 074221C222A9
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 06:23:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D075413FF5;
	Fri, 16 Feb 2024 06:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kZ/URTLy"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B233134BD
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 06:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708064634; cv=none; b=G6cpBz8D7Rb8hCffgxq81z4WIVyIMpMix3VgbzyrUnDwtgcOiE/iJbG9D0KAYDY4GiVkoj1q+spPPtEvI7Milv6tNx8UuzRVX732pJYGGKSAifdbzHohWXrJQHwJUi6k0wQi6Ee0JLe9r4LtWy8E0i7FRC9vcH1G6sFjVttJTQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708064634; c=relaxed/simple;
	bh=ap/AL4lHqZzJD3EPHrLC+i1FRpn+6ST6a8n/eXsj+LM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N6DMnUn7bwgKn47JBLUmYd7QvzZaNug83dBTEKLbRR3zATKClPPvwCWkcezi2H5KIuwrvda+9Id3G39bkYE/n7q1iFpdHeEwEVVMmC+8PS8xpDnXOkV8OrquOSUobdmR/B0a3dWU1f1bvqPzbi4OYqWRSYg9H5DHxejJGVcnEFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kZ/URTLy; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-33cddf4b4b5so1209493f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 22:23:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708064631; x=1708669431; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ULnf0Z09ErzJv2F7WbwiQD8y1ATNtggEr2XiUFYMGWQ=;
        b=kZ/URTLyo4lWSCtKt/6r9Yhp2MLVXSNuRFL1Te55dwuylRs5kANWeZHyhjqZUPtD6x
         p7d8vRQek34amCqGUZqE2BtLu1DeP2Z/uvWVfpeMOwsaTsv+/0uFxUgpp7D2ui8SiBGj
         tkpkT2gB8keNFpkld3CkFdxNLkry6OfZj37t8RCttKZfF9fh4J6N8ZwSDTdOsflffzjo
         FD6r8IfZzAHDC2WgSdzlwsu5GLEbPS/rO4cvi8RoiF0vkUxJ6mmmeDoUsfIlyU/woFlU
         YJ7ymsnQXYzUa94VDAeMqHE+2Ok3nJqxzI2i8o/067+eLt8LwPhTIFjn50xVSz5v2swY
         XU+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708064631; x=1708669431;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ULnf0Z09ErzJv2F7WbwiQD8y1ATNtggEr2XiUFYMGWQ=;
        b=tLHUYNjgbEUaL1jeLF+79qwVJHoKjIpckItelAcnKgnJZTb4U1QhvJSKRXkvKJ7W4C
         XzAcNlpD3oF4uWIzrylXvYH3alvieScYJB/p+oaRGhreU51kuP72X6bwM1GvKF6a650V
         vyjfhKACdGV2t9IGWYdv0Br7FcH62jUQlch5jxxlYa4MjWC9PK5klIQo59JO1TCMaLp0
         wuK29/V4Y6OjUqEH8OfEVLpVgMoignNUPclGnc1jv58yxwcii6hxw1q99P7lqnv3byo3
         BZEHn3Ez6uX2Xj0jEXooZxHh+VgMBClwRhP/CerNkO7CJDklcDqWO7/uwUR6n0CAN1Rr
         Hudg==
X-Forwarded-Encrypted: i=1; AJvYcCWPHPCNUBxuoIsUoe9Wm2vwlDBuBjK7KzvyTBmi54+o+n7EAgl78b4XMFoVJT0BlPPyvsnDIN5hZoF5rpWnqm6pO7gVSJO+G8ubwaYS
X-Gm-Message-State: AOJu0YxiJSoByNpwGiL+R62lGJpLBR1crBJ+3QVqJXunPkdzG50twIMC
	SpuS8jXN073Fu1R4BTKJTKkA5zqkD4+ZTHRtIs5DgCGogDgilxo=
X-Google-Smtp-Source: AGHT+IEFpRRluIj/VNQ0ddoJrREHJO8NwODHJ49Yy8tONDulEsaSpT8rB/bDu00rmTtoMmv68HMUcg==
X-Received: by 2002:adf:fdc6:0:b0:33c:f4fc:b91b with SMTP id i6-20020adffdc6000000b0033cf4fcb91bmr3185444wrs.52.1708064630631;
        Thu, 15 Feb 2024 22:23:50 -0800 (PST)
Received: from p183 ([46.53.248.67])
        by smtp.gmail.com with ESMTPSA id bt21-20020a056000081500b0033d1f25b798sm567514wrb.82.2024.02.15.22.23.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Feb 2024 22:23:50 -0800 (PST)
Date: Fri, 16 Feb 2024 09:23:48 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Michal Wajdeczko <michal.wajdeczko@intel.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-kernel@vger.kernel.org, Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Jani Nikula <jani.nikula@intel.com>
Subject: Re: [RFC] include/linux/make_type.h: Helpers for making u16/u32/u64
 values
Message-ID: <bfb4c75e-8031-4dde-b881-21bdb238b802@p183>
References: <ffa107dd-23dd-47e0-b3bb-06c60ca3e2e2@p183>
 <Zcz5GmAtPbdInWJU@smile.fi.intel.com>
 <cee345b1-a5aa-41bb-acb7-9b2aaef5bfb5@p183>
 <53297b2e-b7ff-4b92-b937-116cadaf8b6d@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <53297b2e-b7ff-4b92-b937-116cadaf8b6d@intel.com>

On Wed, Feb 14, 2024 at 06:55:38PM +0100, Michal Wajdeczko wrote:
> 
> 
> On 14.02.2024 18:39, Alexey Dobriyan wrote:
> > On Wed, Feb 14, 2024 at 07:32:10PM +0200, Andy Shevchenko wrote:
> >> On Wed, Feb 14, 2024 at 08:20:55PM +0300, Alexey Dobriyan wrote:
> 
> ...
> 
> > 
> > Thirdly, there were no users posted.
> 
> for make_u64() there is already one at [1]
> [1]
> https://elixir.bootlin.com/linux/v6.8-rc4/source/drivers/gpu/drm/xe/xe_gt_pagefault.c#L555

OK, this one doesn't truncate too.

Honestly wordpath.h _sucks_ as a name.

I'd go with stdint.h, at least this name is known from userspace.


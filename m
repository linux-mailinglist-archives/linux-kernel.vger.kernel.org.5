Return-Path: <linux-kernel+bounces-97643-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B1DE876CFA
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 23:20:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B98E22831FC
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 22:20:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43B0960259;
	Fri,  8 Mar 2024 22:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="knv80yvg"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E758D5FBB9;
	Fri,  8 Mar 2024 22:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709936414; cv=none; b=OphKReKatFwjjXt0JDJBuiqwBydyUdBtSD4lOK6xD6TMJCmoj1vKJqGiYMJ4JEZ+LgkUu9LEiuXcp39Qc+Qk/q9Pg0OlTEhUfpjG5n4n+GNa8CRIllHP3F2HoH5iQqLdLXRROg7O0nJ8/v/QPxSN3ddFvqDQtCznsT6Sm4D//qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709936414; c=relaxed/simple;
	bh=UvaPv/XPHrH2WNEAzYheoSrYhZzFwh6ItrrN3RRyQiE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q/cyq5tFvl1P7/lCBjphgBsnVrgz6AtdmQ5/L4K/mG2P044EYXHx5gIW9Te5kQJ8W59zGnQSYunPM5B62P8bEKXcB+eMOYOdW8ZGbIlPoZRYLj0s351UV6ekuZPW9zufj2sy1OkL+fqziitt2FxoLAbovt8SkJp0KS27lwFR+FA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=knv80yvg; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4131b27cda2so6810585e9.0;
        Fri, 08 Mar 2024 14:20:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709936411; x=1710541211; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=j62oPnIVjNXEkLwc6x1vxDDwPNWZwfNz/IeZcBMO0U4=;
        b=knv80yvgtBCQpRL2YuxAIGifr8ASeIS/rdaX8xYUeomB6RzgWw2SaFzZBMwtZX56me
         5Ycw1xgFcc1BOSJtX7BQKORXCJfdenz+vZrGVhMJD0Yet727Jwx/oeBCWAxitvJxjUEE
         OhREW57TvV/6izeW18WgC1q9vY2JIIg/Eg+SySVvH2gkzoAhesi9J+c0gdc4KBeBU2B3
         yrtCBki9DQ6izg+tGsQJ7f6GSFkpLkfFUPG49l58kz2GEcQ8qi7aV66oMubnOtURQ/qi
         2tf7BLQXjQrwMLdyXsYUGWgAnv5bSVSoEK53Z3Gp4NKzvXOGxd+a0KkolVoNhwOqSLZQ
         SYJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709936411; x=1710541211;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j62oPnIVjNXEkLwc6x1vxDDwPNWZwfNz/IeZcBMO0U4=;
        b=XsKQxoDs72k0LZNwAnjywxcs77B9+FbOiwWe/CQ1A1LsmR/HiiNYI4qVwl/QymsZzb
         NRLwptfGA+RDpmTxlVWYIpQ3xwcNAh5EMsIRgEnT2CnHYsSLMD+cfrz5QA9xjlcr3+bQ
         Nf+Rh9aXMk6QYitnz9/H6UPziwYy+SteoVldrxD39sjwu8mXSRO56If1RWH5YnjMtX2s
         LTT+kmnVvDoSrVrCErGSEtNGe/cmtSJWy9UymS/6owHLX9X+EmW/GWfW3s/v4NK9pszC
         PQEnkuLp8+E+/6Rtw+zYJ/CcGIsRtAdGQrDsyw6ZcZjtN9ikpXf3Ev89B97K5OJgb1cI
         aUvw==
X-Forwarded-Encrypted: i=1; AJvYcCUC1ZkLeJJ7L6OEmFVWuRSGSp41e//8OoI+JRe+FvaU1psN/I0BREjRnhGZ6ayJhSQhPv8bIpNgqg8GVEyKIxY0uJCO5G8WSckhDjBgLMRCMVxnCwG0+vCSPFOm7yrohsutyAg/NDmfvjusDa37TUKYQ36rVlpTf2rsmUwE0srHe+dd4d/1+bfp9weXwKTSw38+7M7biE+dQ4G9dSZZXpElYj0=
X-Gm-Message-State: AOJu0YzSA5NiEEpVz04TU5PjpGldr6ZjdFc/40x8aePM9c/XppGhf8Wx
	DV9CaqlG5lsELA+bgOikmjB2Jrg1kQalvl2S5IkaolT52AupjuzY
X-Google-Smtp-Source: AGHT+IE5arD0uaO0cShKSZUbPrmiaI8REwNOOjBGWARkTT+WqsPSIbayV70MjZcasIR3uWjdwQ0JcQ==
X-Received: by 2002:a05:600c:ccb:b0:413:1438:cbd4 with SMTP id fk11-20020a05600c0ccb00b004131438cbd4mr359744wmb.17.1709936410844;
        Fri, 08 Mar 2024 14:20:10 -0800 (PST)
Received: from localhost (cpc1-brnt4-2-0-cust862.4-2.cable.virginm.net. [86.9.131.95])
        by smtp.gmail.com with ESMTPSA id hg6-20020a05600c538600b00412c8117a34sm608258wmb.47.2024.03.08.14.20.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Mar 2024 14:20:09 -0800 (PST)
Date: Fri, 8 Mar 2024 22:20:08 +0000
From: Stafford Horne <shorne@gmail.com>
To: Oreoluwa Babatunde <quic_obabatun@quicinc.com>
Cc: chenhuacai@kernel.org, jonas@southpole.se,
	stefan.kristiansson@saunalahti.fi, ysato@users.sourceforge.jp,
	dalias@libc.org, glaubitz@physik.fu-berlin.de, robh+dt@kernel.org,
	frowand.list@gmail.com, linux-openrisc@vger.kernel.org,
	loongarch@lists.linux.dev, linux-sh@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	kernel@quicinc.com
Subject: Re: [PATCH 0/3] Restructure init sequence to set aside reserved
 memory earlier
Message-ID: <ZeuPGOzPpOuUFTwF@antec>
References: <1707524971-146908-1-git-send-email-quic_obabatun@quicinc.com>
 <467b8479-dfd8-43a4-92eb-d19dc65989cd@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <467b8479-dfd8-43a4-92eb-d19dc65989cd@quicinc.com>

On Tue, Mar 05, 2024 at 10:59:20AM -0800, Oreoluwa Babatunde wrote:
> 
> On 2/9/2024 4:29 PM, Oreoluwa Babatunde wrote:
> > The loongarch, openric, and sh architectures allocate memory from
> > memblock before it gets the chance to set aside reserved memory regions.
> > This means that there is a possibility for memblock to allocate from
> > memory regions that are supposed to be reserved.
> >
> > This series makes changes to the arch specific setup code to call the
> > functions responsible for setting aside the reserved memory regions earlier
> > in the init sequence.
> > Hence, by the time memblock starts being used to allocate memory, the
> > reserved memory regions should already be set aside, and it will no
> > longer be possible for allocations to come from them.
> >
> > I am currnetly using an arm64 device, and so I will need assistance from
> > the relevant arch maintainers to help check if this breaks anything from
> > compilation to device bootup.
> >
> > Oreoluwa Babatunde (3):
> >   loongarch: Call arch_mem_init() before platform_init() in the init
> >     sequence
> >   openrisc: Call setup_memory() earlier in the init sequence
> >   sh: Call paging_init() earlier in the init sequence
> >
> >  arch/loongarch/kernel/setup.c | 2 +-
> >  arch/openrisc/kernel/setup.c  | 6 +++---
> >  arch/sh/kernel/setup.c        | 4 ++--
> >  3 files changed, 6 insertions(+), 6 deletions(-)
> Hello,
> 
> Loongarch patch has already merged for this, but review is still pending
> from openrisc and sh architectures.
> Could someone please comment on these?

Hello,

The OpenRISC patch looks fine to me.  I will test it out.  Sorry, I thought you
were getting this merged via other means.

-Stafford


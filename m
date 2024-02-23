Return-Path: <linux-kernel+bounces-78151-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9125C860F95
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 11:40:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B4F001C20D59
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 10:40:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0D177E11F;
	Fri, 23 Feb 2024 10:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nASo6j/Q"
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C2EF65189;
	Fri, 23 Feb 2024 10:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708684716; cv=none; b=b6ZvXzXr8kbAv7iTy01RK0Z25i35ZgFd6XzjU1lV9rXd6eWf47jSx/eovAxNrfWgMVCYfZrZqeOGHHBjv7Ut/xO/qvntzXGdwsvbrhOcNCuWgcgPMaVLyeZnGio2mBgfYirvuTz+MlSyou92Fd77PPH65kgLCRyHvC3f3Gmr+q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708684716; c=relaxed/simple;
	bh=QcWBpdOAclhBD0UhHITKuuNy+yVht+AsnbDVGXTP5cY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fa56oJUwj589f9yOP8ZrjszMHMLtEXRvBh6yaP9j5CCvQP5/UPffW7N5+xASxzy1VkLPr1jxRfL54ESVMmGgclBdn82bC1Pw+sXh/W7FbW3P5HgCEaJdJvGkhuY1EFdTwLN8n4HEsXMcTS/NI58KRruNWwFNQ7tP5RTosWy/YIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nASo6j/Q; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2d2531294faso10885781fa.2;
        Fri, 23 Feb 2024 02:38:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708684713; x=1709289513; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/57iE9xUzM64VCgKGcdjUD3L2vELMa70jtDbB0tJr/8=;
        b=nASo6j/QnM3J+/uZ6z182gXz82tj7qM/MIqaTj07SNWeyZVG+pUAZgrPVvfwAT2V6D
         LLQut8Lz41WyCgBXFJpUUVzFbOwzTTx/niaGNQFvNDuYeRHSW43Wh9WYzkMtegMrG5qI
         RM8IZPR+A/15rqdPFQ2y65xpuW4D0NcBh04/1wbyvxSrxr7RwcRqTOwD8dCSFqZDiXas
         dY4oceS0RU5FPeSKMjMJciSCJukXXlZcARxyDxFMiOKWFigrn+RBJJqq+iyPMPOr7VWM
         KHtFmXmaqbZuxYOBOB5P4eYJO/6kZc4RsJGciWhCe3COrg9EzLSDDdIQ18LMtRoKEWkn
         W3Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708684713; x=1709289513;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/57iE9xUzM64VCgKGcdjUD3L2vELMa70jtDbB0tJr/8=;
        b=XmkF5d0iU0qwFXMpT1c6kmBvmF85Yvc4zC+Q4qYwLsZw+JByDwHdvtKBgKLUsbkLYs
         gLopVoMINAk01yb/kViQi9xVylhsFZDvnS1dR9lzw4uzCEMtgRry/XYwzTRTfvdQ06Zb
         6waYt3GgqiY7soyir40eWnUofbwcBXGXWkN42x1UpdrKRcDmY/bCBHdNVIjQpA+yxBwM
         NSv2cdVAmJ2OlNCj8QxNQVj+hmr7y8UqoSrzp/OTd2vvt7upCcTNkP22hEHdE1FkHa+T
         3skhvx1/+H0geZbEnqVQhbDJ6jU4Vg6w4A8J0w2ifaLIxyOv1rjJXPBgvlVJ2oWum1uO
         fH2A==
X-Forwarded-Encrypted: i=1; AJvYcCWcD7YvBb/V02BgxwTDO95NQuOoCd3ar6XqR5IZhi7VsQH3DOFcQjie0IXdUJsSLoecw8iIJChXmKfrTSm09+DNOMzT9LBCggE7b5Soq7C4EtMZr+IZcTWQhRRxNB46R7ir0mmJmK7kiH0UPfAsoMfHkjvzdyPc8KyS8pQXNz1U0MLMPAkavg==
X-Gm-Message-State: AOJu0YzoQMj++90VSF+JHD5Rb246QfRXfhivRSrWLN1SDPzs7kATQQuc
	zLJEAT3VQFTHlwIu+5RAhyOB5aHng8zeNXbTtqscgLQGwfLAKc/h
X-Google-Smtp-Source: AGHT+IH2eeoej2njYTlxALagRPYMimWjHDV8O5gqpwHYmZj98ZuyF9R3SzzOFKStwi3/sm9G3GkbfA==
X-Received: by 2002:a05:6512:3b9c:b0:512:d6b4:9622 with SMTP id g28-20020a0565123b9c00b00512d6b49622mr1373111lfv.69.1708684712932;
        Fri, 23 Feb 2024 02:38:32 -0800 (PST)
Received: from mobilestation ([95.79.226.168])
        by smtp.gmail.com with ESMTPSA id g15-20020a0565123b8f00b00512d16a68e0sm1000300lfv.120.2024.02.23.02.38.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Feb 2024 02:38:32 -0800 (PST)
Date: Fri, 23 Feb 2024 13:38:30 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Jiri Slaby <jirislaby@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Jiaxun Yang <jiaxun.yang@flygoat.com>, Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>, 
	Stephen Rothwell <sfr@rothwell.id.au>, Andrew Morton <akpm@linux-foundation.org>, 
	linux-mips@vger.kernel.org, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] mips: cm: Add CM GCR and L2-sync base address
 getters declarations
Message-ID: <pf6cvzper4g5364nqhd4wd2pmlkyygoymobeqduulpslcjhyy6@kf66z7chjbl3>
References: <20240215171740.14550-1-fancer.lancer@gmail.com>
 <20240215171740.14550-3-fancer.lancer@gmail.com>
 <ZdTgSZRTDkakekkd@alpha.franken.de>
 <difioxc7b7e2ic2p4om36l6vu4vkud6qa6t3aeikxzkhlqhgqb@zsx3dmjcofw4>
 <ZdhgGRknaFmxKvfI@alpha.franken.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZdhgGRknaFmxKvfI@alpha.franken.de>

On Fri, Feb 23, 2024 at 10:06:33AM +0100, Thomas Bogendoerfer wrote:
> On Wed, Feb 21, 2024 at 09:39:58PM +0300, Serge Semin wrote:
> > On Tue, Feb 20, 2024 at 06:24:25PM +0100, Thomas Bogendoerfer wrote:
> > > On Thu, Feb 15, 2024 at 08:17:27PM +0300, Serge Semin wrote:
> > > > Based on the design pattern utilized in the CM GCR and L2-sync base
> > > > address getters implementation the platform-specific code is capable to
> > > > re-define the getters and re-use the weakly defined initial versions. But
> > > > since the re-definition is supposed to be done in another source file the
> > > > interface methods have been globally defined which in its turn causes the
> > > > "no previous prototype" warning printed should the re-definition is
> > > > finally introduced. Since without the global declarations the pattern can
> > > > be considered as incomplete and causing the warning printed, fix it by
> > > > providing the respective methods prototype declarations in
> > > > "arch/mips/include/asm/mips-cm.h".
> > > > 
> > > > Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
> > > > 
> > > > ---
> > > > 
> > > > Note as I mentioned in the previous patch, since the weak implementation
> > > > of the getters isn't utilized other than as a default implementation of
> > > > the original methods, we can convert the denoted pattern to a simple
> > > > __weak attributed methods. Let me know if that would be more preferable.
> > > 
> > 
> > > how about simply remove __mips_cm_l2sync_phys_base() and do everything
> > > via mips_cm_phys_base(). And at the moment without anyone overriding
> > > mips_cm_phys_base I tend to keep static without __weak. If someone
> > > needs, we can change it. Does this make sense ?
> > 
> > To be honest my arch code (not submitted yet) do override the
> > mips_cm_l2sync_phys_base() method. The memory just behind the CM2
> 
> that's fine, I just wanted to know a reason for having it provided as
> weak symbol.
> 
> > What about instead of that I'll just convert both mips_cm_phys_base()
> > and mips_cm_l2sync_phys_base() to being defined with the underscored
> > methods body and assign the __weak attribute to them?
> 
> works for me ;-) I'll pick patch 3/4 of this series, so no need to
> resend them.

Ok. Thanks. I'll submit the respective patch(es) in a several days.

-Serge(y)

> 
> Thomas.
> 
> -- 
> Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
> good idea.                                                [ RFC1925, 2.3 ]


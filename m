Return-Path: <linux-kernel+bounces-75321-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D703685E67F
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 19:40:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4B6DFB26712
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 18:40:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63A7985650;
	Wed, 21 Feb 2024 18:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hEssLoV1"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF51882D97;
	Wed, 21 Feb 2024 18:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708540806; cv=none; b=HnRDqiubAOxeCSjZ6uaxptdpJx8WHo+nR7wzuytceR2imRJMoTYebA/Ho2nj2fSgNRHSfY5wJbpeGQFwpMem4//HAEeDYVDzCHkyVv7FCnkHiZVXmwhy/MFWqedipPd120HccM8/rvwR8z8c1FqIW8nH0phRkspnY9/T8I6BnW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708540806; c=relaxed/simple;
	bh=77+yJArpD4qpYuTJYgfzGu+AM0EsB8mycpVWQGHji2w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HDFn61QIDzwf+5td99ZTkJ2iKilDXLXg/+aU0weLK66iVEZ++UIKXjlCBL5hzn7p9hZQYRelpp19ygSFY7ZXJ8kAWK8/Omv+XmzZ8TKIsKSq3vJuFe8906uPXtE3j6vh0tKutvx9OHD9TbxOTvpyER27eXo5ImOPBRuWnXwni9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hEssLoV1; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-512cba0f953so2093291e87.2;
        Wed, 21 Feb 2024 10:40:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708540802; x=1709145602; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LoHmCjovbaBBFrzsFwzqZ152wtgCp5m6C9inbTCfJo4=;
        b=hEssLoV1bgpUK3ShoUNWmVMi/qY8tmdsf5PsnZoZUBJDFgV5V/Y9VizelnSV7pVrKl
         YuoHfgc2AIW1KqkSOyQgtmIJx/GezRxTwxq2j9GhbOTTaaSRd6MvAKaNfCWe+N3BhZcK
         +9XzIE0sYxhViG2s20GVVRzcBNILTRNCUb70/oanxqaBOKJIvVO7BVE0eCcb5G/hvK1e
         ZOT5NT8zsY/3BOO3an1Fnsd/vVwwTcOtQx+4sg5xW3xSGUIndBwz/espbrd0UIDUhvQx
         PIp8woOC6LQw+/Gn8U0PbbWhaUWmfNEQIgu/mj+V4gTa/h8gSz0DWrOrBJOCa5Ce5CsU
         w/vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708540802; x=1709145602;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LoHmCjovbaBBFrzsFwzqZ152wtgCp5m6C9inbTCfJo4=;
        b=mpGg25LbhA6HJ+OY2d8NdYWiWdS0VhHuEWEj4TVUcSwi1vuqqNsOb3xqnvjKSVRsY2
         RgBUvzdSaMYKalcqXkQgdhAScUlTiv4zpqIhuuKz8IYboRJWJ+OBTJ4tPJs6twK8mEHt
         pnLRea58ZppyT9al2a9VCr5cagOgO9o5IWz8DJYqXp+bS8+CdBgyW5nzGhmq7L05Lk4+
         LbJwrgFtaYX0SxEU7+KBsf6gJFD+6H2XqNXodqh19cpsspRsmTn2mLImyW9GrsoiQb18
         GKY4mm71EM7qBKAFHMLg4McD8f4EQCtpNfNBGXUiN8X3eH44JG4q9KgklkRheyqJQUHt
         Eu4A==
X-Forwarded-Encrypted: i=1; AJvYcCX5/FZNpRE2RP6t3omNnCSXJNM6HAEWlNr5AMP76eaINszPdWpEoAgqhEyt4pES9p+JOntdQPmn0521OUwVr2zdm0uW0m02XhY/TB4H6nrCSuqa/k9KSDEeIYnBxo0q74jObqQK0o8Pq5bKO6yusCDuv/HANpTuAGx1XTkCdiU14bcv1iw8vg==
X-Gm-Message-State: AOJu0YzTzsKrjEsUS02awx6n96ZNWcqJ36fk0sUn8AC/nkqg4lBxd5OB
	fzeyPYSdZxqqT49kCy8VmfgcZcOnNWdYkEEkOv8pDIO7im9/x/jd
X-Google-Smtp-Source: AGHT+IFQdg0rPzpbCTxt7YY/k8nhp9mR1Q4dWOetKUCqjjty0eyBkdC1Ae+mLcUg7lr00zV65Mchcw==
X-Received: by 2002:ac2:4c41:0:b0:512:b4cf:ae3 with SMTP id o1-20020ac24c41000000b00512b4cf0ae3mr8077237lfk.19.1708540802133;
        Wed, 21 Feb 2024 10:40:02 -0800 (PST)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id h24-20020a19ca58000000b00512d495ef0bsm310184lfj.113.2024.02.21.10.40.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Feb 2024 10:40:01 -0800 (PST)
Date: Wed, 21 Feb 2024 21:39:58 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Jiri Slaby <jirislaby@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Jiaxun Yang <jiaxun.yang@flygoat.com>, Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>, 
	Stephen Rothwell <sfr@rothwell.id.au>, Andrew Morton <akpm@linux-foundation.org>, 
	linux-mips@vger.kernel.org, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] mips: cm: Add CM GCR and L2-sync base address
 getters declarations
Message-ID: <difioxc7b7e2ic2p4om36l6vu4vkud6qa6t3aeikxzkhlqhgqb@zsx3dmjcofw4>
References: <20240215171740.14550-1-fancer.lancer@gmail.com>
 <20240215171740.14550-3-fancer.lancer@gmail.com>
 <ZdTgSZRTDkakekkd@alpha.franken.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZdTgSZRTDkakekkd@alpha.franken.de>

On Tue, Feb 20, 2024 at 06:24:25PM +0100, Thomas Bogendoerfer wrote:
> On Thu, Feb 15, 2024 at 08:17:27PM +0300, Serge Semin wrote:
> > Based on the design pattern utilized in the CM GCR and L2-sync base
> > address getters implementation the platform-specific code is capable to
> > re-define the getters and re-use the weakly defined initial versions. But
> > since the re-definition is supposed to be done in another source file the
> > interface methods have been globally defined which in its turn causes the
> > "no previous prototype" warning printed should the re-definition is
> > finally introduced. Since without the global declarations the pattern can
> > be considered as incomplete and causing the warning printed, fix it by
> > providing the respective methods prototype declarations in
> > "arch/mips/include/asm/mips-cm.h".
> > 
> > Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
> > 
> > ---
> > 
> > Note as I mentioned in the previous patch, since the weak implementation
> > of the getters isn't utilized other than as a default implementation of
> > the original methods, we can convert the denoted pattern to a simple
> > __weak attributed methods. Let me know if that would be more preferable.
> 

> how about simply remove __mips_cm_l2sync_phys_base() and do everything
> via mips_cm_phys_base(). And at the moment without anyone overriding
> mips_cm_phys_base I tend to keep static without __weak. If someone
> needs, we can change it. Does this make sense ?

To be honest my arch code (not submitted yet) do override the
mips_cm_l2sync_phys_base() method. The memory just behind the CM2
region is hardwired for the EEPROM mapping. So the default
__mips_cm_l2sync_phys_base() implementation selecting the L2-sync with
(mips_cm_phys_base() + MIPS_CM_GCR_SIZE) isn't suitable for my
platform.

Note what you suggest will require the CM and CM L2-sync probe code
logic redevelopment. The mips_cm_phys_base() method is currently
dedicated for a single purpose: return the CM GCR physical base address.
So is the mips_cm_l2sync_phys_base() method. Merging the later method
into the former one will cause the mips_cm_phys_base() function
looking less neat. We will also require to have the mips_cm_probe()
method keeping the CM L2-sync physical base addresses around and then
passing it to mips_cm_probe_l2sync() or having the later method
embedded into mips_cm_probe(). All of that won't look as good as the
current implementation.

What about instead of that I'll just convert both mips_cm_phys_base()
and mips_cm_l2sync_phys_base() to being defined with the underscored
methods body and assign the __weak attribute to them?

-Serge(y)

> 
> Thomas.
> 
> -- 
> Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
> good idea.                                                [ RFC1925, 2.3 ]


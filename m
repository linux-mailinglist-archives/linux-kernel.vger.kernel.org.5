Return-Path: <linux-kernel+bounces-136494-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 26DCC89D4BC
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 10:42:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 204A11F291E9
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 08:42:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 656317E794;
	Tue,  9 Apr 2024 08:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="niQ0i668"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D4571EA6E
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 08:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712652139; cv=none; b=L96J52swlPJOPp1RfuubOGp+4yI0yiVICPEeSDBnC9rw2ABomjDyKC8mUOTFQzJiQuWoY9nngFZrodx3km4e5HtTdYi2IVlllj1BSgi4B33vR3Ngt76dg56jR/I6b0xLZoyCuHiU4ABkGVW8hDjZuTS1QBeKluoyWETyM0mNRDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712652139; c=relaxed/simple;
	bh=OunbLQg/Bt0NQZwIrgN1upoh3E2WELOEmAQSI9u6z04=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F5PD75lnJrsY0EP6WcBWgAkv1970hASzmB66i2xduLw60Jbk0cpw68v8uGk/4vhFwhnpD5z82z6MzETJ9pVXtk9MhIXMwSYcseHCwySvorYQKtSbdiNGVO/9pMONpaoBjoeZ2cyg6fy5BOOPkmgfZrpWAktq4hw8P6BM+HHK4HE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=niQ0i668; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a51a1c8d931so469139566b.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2024 01:42:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712652136; x=1713256936; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L8rf82IQCyfI7tQ6ip4On1i6SqbjEwwyBl2EsvThjlM=;
        b=niQ0i668m4dI4OgYN2vxLYHvqijvptya8LpMMpN+eY0dmdWRv1MUoCGUYm5tH+N3Bx
         TERTMoC3ffFjxYzNxLAPoR7HBus6Hgt/vX9fdNqVwltGTa7YUIwBY1yP4j9d9p/CYXIu
         78ShJQto/Nv9+O6MU5tDEKLA1mBwhLMU2W8N2j3WEp8noUT5dsCefEriwXBlIL0LjZhx
         wyId25w1I0xRKSCgooXEiJyR7LKyEjKrQxPczWkJxdRC1BbT4p1fzQJ5VrGJDc7COC14
         zpCQK9cYk5ojH43tezNq5RjZ5JVErr4erMnm2pWwZt7yR6q4DU52M981LQFqMMxWm2mj
         /ruQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712652136; x=1713256936;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L8rf82IQCyfI7tQ6ip4On1i6SqbjEwwyBl2EsvThjlM=;
        b=h/a8CiD/zo5gNeM1MfAGM0htLc7yhYyXGLgZXqX8KRA6PNUbawgtxQnBxxzv9wGkvV
         HS6PzA7uyu2GT5r4Og0XFaM38tu0ma2jAC29HrVemBNXqFVeO7MRcLTUCx6yKAVFzLxZ
         dX9MZIxoy9pqr7ZVvRgguXGzZrWcED5iLP3Lgpf6p8/M0rt0vjN3WBnUECzlyF+mbe8j
         QJgDJ7NA3YGyigolBNQ/MDkXlcCi50yFU8iZK6wE4kRQCOW9vfvaHrpl+MWKTT6mxHYi
         rsiXV64mAsUptFJeBAJhxKyoxj9EuABuVrKEMZkwjXKMfBuljOkbepVAY9el9yytkJ/U
         OorA==
X-Forwarded-Encrypted: i=1; AJvYcCW9TokjvLei3dSKFdESwJA8cEdvwQeoYKwQvB1Imp7KcZW3TJJ2Z0LXhr+/WRwIqRxBiQHj5e4YMfXo+rxJmWp7aD2VjhzJMySyvuAo
X-Gm-Message-State: AOJu0Yy31EsuWYzZRAaw06IrAU7+KL2+kF6MvDUEsvZTJyTAmxEyvN65
	sdEKHFqaQXriqY8DRQV6fYVyqdHRQBz1O/I3CXBy4+MB3hXtoOww
X-Google-Smtp-Source: AGHT+IFLCcsIQyu5UU20xtqgEZVg9jwvsMoFdvzAuDr5FSnpg4fL2eZmZffEbdmD6WoWbAmn1z+Rsg==
X-Received: by 2002:a17:907:ea8:b0:a4e:d43:dc4b with SMTP id ho40-20020a1709070ea800b00a4e0d43dc4bmr9478655ejc.58.1712652135767;
        Tue, 09 Apr 2024 01:42:15 -0700 (PDT)
Received: from gmail.com (1F2EF1A5.nat.pool.telekom.hu. [31.46.241.165])
        by smtp.gmail.com with ESMTPSA id qx3-20020a170906fcc300b00a4e26377bf1sm5497508ejb.175.2024.04.09.01.42.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Apr 2024 01:42:15 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Tue, 9 Apr 2024 10:42:13 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Alexey Dobriyan <adobriyan@gmail.com>, mingo@redhat.com, bp@alien8.de,
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
	linux-kernel@vger.kernel.org, peterz@infradead.org,
	Jonathan.Cameron@huawei.com, linuxarm@huawei.com,
	linux@roeck-us.net
Subject: Re: [PATCH 1/2] x86/cpu/topology: don't write to immutable
 cpu_present_mask
Message-ID: <ZhT/ZTdRN+Gxfe8S@gmail.com>
References: <20240407152643.3245-1-adobriyan@gmail.com>
 <87ttkc6kwx.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ttkc6kwx.ffs@tglx>


* Thomas Gleixner <tglx@linutronix.de> wrote:

> On Sun, Apr 07 2024 at 18:26, Alexey Dobriyan wrote:
> > Workaround the following oops:
> >
> > 	topology_hotplug_apic
> > 	topo_set_cpuids
> > 		set_cpu_possible(cpu, true);
> > 		// write to __ro_after_init section after init
> 
> Duh, yes.
> 
> > adobriyan: I'm not sure what's going on, can it set unset bit here?
> > If not, then why does it repeat the job and set already set bits.
> >
> > Anyhow, let's not oops peoples' machines for now.
> 
> Adding a bandaid to paper over the non-understood real problem is
> definitely not a good plan. I take this patch as a bug report.
> 
> Proper fix below.

BTW., independently of the fix, warning about a too late set_cpu_possible() 
might still make sense - clearly it *can* be called too late by 
architecture init code :-)

It's not a performance-sensitive function in any case, so the extra 
debugging code might not hurt.

Thanks,

	Ingo


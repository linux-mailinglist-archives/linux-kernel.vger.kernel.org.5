Return-Path: <linux-kernel+bounces-75246-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0588F85E52F
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 19:08:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE6E62849FC
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 18:08:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4273485264;
	Wed, 21 Feb 2024 18:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KrYPdTNF"
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED82D33F7
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 18:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708538902; cv=none; b=P5tSSvhS7t9cOxQPYADy8Wyu45a4QgN7e+wHuMi4h1ABH5mrmIlitIIDoU5nlwtQGyxEhNG7gFT8jQpNHxzyN1zDQt/FFQjSbEGz2+CRl8St1troJNcZHrq2G7A/0xU0jSNEZX6d8YSP0Zc+CBrQIbVtpSvSpnXPVrFsK2q/2b8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708538902; c=relaxed/simple;
	bh=1p/8NvuyZYpCVrfbqqK5Vg//TA2N3vASs0mwKJR9M4E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JYSWyotW0AnN40ZKpzb2FbMLRcSX4/06Ms+G9FXYqhGIrQU7KieXxIgELKwpL8bFgIghsqe4Wu01J6PWav/yz2ZPOsag/GlIsbmdIXTtwd36rwBELkqopE6c6S29Ox/tbKjWLQ251iIxG1slIetsUegrJzxxhobn8CFBAuzRaEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=acm.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KrYPdTNF; arc=none smtp.client-ip=209.85.161.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-59fe5b77c0cso495669eaf.0
        for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 10:08:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708538900; x=1709143700; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:reply-to:message-id:subject:cc:to:from:date
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=yE3xYE9b0PADKF8ltORqAx3XVvlJ9P1Y3jeB29+/qOg=;
        b=KrYPdTNFkodRXXKs8yXEMlhmZnBt1nm6XYeTal7c2A6HopzoVU5NQMcK/Uo1qpE5QJ
         cnQeDU1gT7cIOHJUrmF7VcyDeOAhBiyobIBLZu67lz/iRQpdKDEU5I/fYhIJUCvoJcVr
         CJd/vHJeFfv6IKCf8qfXE5XygrqjBLFZezjLkx1bC4Y9znqLuFDYka2D7B3CKrRaMb3W
         rYv11GZkWGfJBamkq2Rt5CR1imRgGFBIPvSrDBLkF7OfEUT/sIS01cQ1YFRdHS1ag5T/
         9Dd2tEM/zFpdF/VKZ5nfiabfRjoiTVlLNJoHRVseh869/AfNCISqy8W8s3fFOyB8w0y5
         efug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708538900; x=1709143700;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:reply-to:message-id:subject:cc:to:from:date
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yE3xYE9b0PADKF8ltORqAx3XVvlJ9P1Y3jeB29+/qOg=;
        b=drGHfZskDBvSz0W2P8VGat12uu011HAiFQK/on61fhHUPEaT/FVpt6yl4xoi11GJ10
         bbnQMX5mLZya3PDR2vDLgb4gXSS5utRHbB0FVyYzIYSvnAqOviL04tQvWEjHGXmRIj3p
         UaiQ8w7zKrLGioTG6tKBmH9JRtNaJrzNfWTRQF9rI11K/UC9CKtiGpEc85ephyqKC9xC
         4ZkJAYw8wqpRtKxcCfsd1syIKB/CVFP7xpclFNtCAkhhksN9loQJP+yQBEpUO7esJzy6
         yZlcoo5rvF2C62dOm2E4607qcZ+COEF9GTdg8bm1iAfIYjnkpFLN2c6Hw37q5RkSWk7b
         mvXw==
X-Forwarded-Encrypted: i=1; AJvYcCXIcnxd/jdRbBr+K3CCFbISD6DuqyrUMS4otB2m0O4TQRjSj5hCEjotQxkUuWZtGysNm13b5x+VpG0J9lXdZnvLMhqgyWqTRnjd3CwB
X-Gm-Message-State: AOJu0YzI0o7DNYjOVtoz0GD3NXJJYC/TUZmkGQ3bbjZrkjsQ2s3elNsW
	6Nrry2B3UWtjBuRPU0VgdxDjbnEuC+YbWtukcT6PYXIe4dhRP3A=
X-Google-Smtp-Source: AGHT+IE7Jl89TMdslT9Xstr1epQWCcXolp3sqaBdeNYzQrNiseiNxKWZkq7GYlWCsP8bfbZaGYK6yg==
X-Received: by 2002:a4a:d2ce:0:b0:5a0:2a9:574b with SMTP id j14-20020a4ad2ce000000b005a002a9574bmr5993289oos.9.1708538899972;
        Wed, 21 Feb 2024 10:08:19 -0800 (PST)
Received: from serve.minyard.net (serve.minyard.net. [2001:470:b8f6:1b::1])
        by smtp.gmail.com with ESMTPSA id g6-20020a9d6206000000b006e2df00aaa8sm1665305otj.70.2024.02.21.10.08.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Feb 2024 10:08:19 -0800 (PST)
Sender: Corey Minyard <tcminyard@gmail.com>
Received: from mail.minyard.net (unknown [IPv6:2001:470:b8f6:1d::35])
	by serve.minyard.net (Postfix) with ESMTPSA id 412431800B8;
	Wed, 21 Feb 2024 18:08:18 +0000 (UTC)
Date: Wed, 21 Feb 2024 12:08:16 -0600
From: Corey Minyard <minyard@acm.org>
To: Andrew Geissler <geissonator@gmail.com>
Cc: Andrew Jeffery <andrew@codeconstruct.com.au>,
	Paul Menzel <pmenzel@molgen.mpg.de>, Joel Stanley <joel@jms.id.au>,
	openipmi-developer@lists.sourceforge.net,
	Linux ARM <linux-arm-kernel@lists.infradead.org>,
	linux-aspeed <linux-aspeed@lists.ozlabs.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	openbmc@lists.ozlabs.org
Subject: Re: [PATCH] ipmi: kcs: Update OBF poll timeout to reduce latency
Message-ID: <ZdY8EDfeePse3c1s@mail.minyard.net>
Reply-To: minyard@acm.org
References: <20240220123615.963916-1-geissonator@gmail.com>
 <a9169894-6972-49c0-a1d4-d80863f5b511@molgen.mpg.de>
 <ZdT+eThnYqb3iawF@mail.minyard.net>
 <9680ad7d7a48fc36a0572dc2286a1229a29341fe.camel@codeconstruct.com.au>
 <527F52AB-0070-43EA-BE82-945280CA2AEE@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <527F52AB-0070-43EA-BE82-945280CA2AEE@gmail.com>

On Wed, Feb 21, 2024 at 10:57:38AM -0600, Andrew Geissler wrote:
> 
> 
> > On Feb 20, 2024, at 4:36 PM, Andrew Jeffery <andrew@codeconstruct.com.au> wrote:
> > 
> > On Tue, 2024-02-20 at 13:33 -0600, Corey Minyard wrote:
> >> On Tue, Feb 20, 2024 at 04:51:21PM +0100, Paul Menzel wrote:
> >>> Dear Andrew,
> >> 
> >> It's because increasing that number causes it to poll longer for the
> >> event, the host takes longer than 100us to generate the event, and if
> >> the event is missed the time when it is checked again is very long.
> >> 
> >> Polling for 100us is already pretty extreme. 200us is really too long.
> >> 
> >> The real problem is that there is no interrupt for this.  I'd also guess
> >> there is no interrupt on the host side, because that would solve this
> >> problem, too, as it would certainly get around to handling the interupt
> >> in 100us.  I'm assuming the host driver is not the Linux driver, as it
> >> should also handle this in a timely manner, even when polling.
> > 
> > I expect the issues Andrew G is observing are with the Power10 boot
> > firmware. The boot firmware only polls. The runtime firmware enables
> > interrupts.
> 
> Yep, this is with the low level host boot firmware.
> Also, further testing over night showed that 200us wasn’t enough for
> our larger Everest P10 machines, I needed to go to 300us. As we
> were struggling to allow 200us, I assume 300us is going to be a no-go.

It seems odd to me that firmware polling would be an issue.  Usually,
with firmware, you have it just spinning waiting for something.  At
least in the firmware I worked with.

I'm not familiar with this firmware, though, maybe it has timers and
such and parallel execution.  Can this be fixed on the firmware side?

> 
> >> 
> > 
> >> 
> >> The right way to fix this is probably to do the same thing the host side
> >> Linux driver does.  It has a kernel thread that is kicked off to do
> >> this.  Unfortunately, that's more complicated to implement, but it
> >> avoids polling in this location (which causes latency issues on the BMC
> >> side) and lets you poll longer without causing issues.
> > 
> > In Andrew G's case he's talking MCTP over KCS using a vendor-defined
> > transport binding (that also leverages LPC FWH cycles for bulk data
> > transfers)[1]. I think it could have taken more inspiration from the
> > IPMI KCS protocol: It might be worth an experiment to write the dummy
> > command value to IDR from the host side after each ODR read to signal
> > the host's clearing of OBF (no interrupt for the BMC) with an IBF
> > (which does interrupt the BMC). And doing the obverse for the BMC. Some
> > brief thought suggests that if the dummy value is read there's no need
> > to send a dummy value in reply (as it's an indicator to read the status
> > register). With that the need for the spin here (or on the host side)
> > is reduced at the cost of some constant protocol overhead.
> > 
> 
> Thanks for the quick reviews and ideas.
> I’ll see if I can find someone on the team to help out with Andrew J’s
> thoughts and if that doesn’t work, look into the kernel thread idea.

I don't really understand Andrew J's ideas very well, but hopefully they
help.  The kernel thread idea is fairly complicated to implement, and
there has been an impetus in the kernel to not create new kernel
threads.  But there just has to be a good reason, and this probably is
one.  We worked on it a lot in the IPMI host driver to tune it and got
it to a point where it provided decent performance without causing power
management issues.  When I first read the title I was worried it was
talking about this code; I'm lothe to touch it for fear of breaking
things.

-corey


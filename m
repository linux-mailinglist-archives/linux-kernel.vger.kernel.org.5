Return-Path: <linux-kernel+bounces-73600-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A148F85C4E3
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 20:33:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF16B1C20CEC
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 19:33:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA27713AA2E;
	Tue, 20 Feb 2024 19:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XSgOUlMc"
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78ADB76C89
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 19:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708457599; cv=none; b=um/VdrYQGiVCPpeH1fGNB4se8CaXsOCIkTkQ4MQv3wED44jqJuf5aStsE2kosrMWPfBqVVVX6B9IDDaJTeSBe0OeCr7Qneh4t8BPEdo9ZlfaWl4ctoXOz9oeGlnsI2wLUCn4MmWYhnwoii3NwNv4EsbkQf7S/uHIbD0sd7G6KHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708457599; c=relaxed/simple;
	bh=yvIzS2ahY5OnxSFO8t2O3freKUbpqCNop/CU+BDbILI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YCHCgNyxnScFar0zfNO7QZACv4JftfIcSAhNpFu2doXimCyqbWgHunctwG22MiLJmSBvxpTnXyo3kpdpQt9qrBS3z4nBMcUtC41P0vkz0Xl4Rg/k6wAFIH/sOhHKNlSRbcsyYgDomBA4zvSXrdDprivEAL1zP8Jay41TW3WRQeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=acm.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XSgOUlMc; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-6e2de202d9aso2423715a34.0
        for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 11:33:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708457596; x=1709062396; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:reply-to:message-id:subject:cc:to:from:date
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=hS/yuuA0H0X0W3262oNsyvTh2OxC1cjSVmh94D2fzDk=;
        b=XSgOUlMciER8hbVJ7tuV9uENh2VcHWjR6ao4qkqMwUN7kLzOZiLgLzWIkHMWrme2a0
         wiAjHh2u7SzxGptBRC7KlZNVjraxfLo3s/FH6+YnBXLPn6N6r9y6VWzBPK2YYhVaYElX
         SWo2UxE4ar0eBslfiZoj5FP9zjfFJ5e19SQ8LQjDNmEwlLCsEsgMYPAJ27P/Kd6jwSQF
         XMsI3LOUHsVqzSudu+Dv82kzxVYMmCPZBRdq4oZPF6ZsQf0yX0QgicJznwEBAuActegz
         qmrUflBp6vHksWTaTY0xk50jSd4BgzYWaZK4SP5kZxKqiTDk2Jfkf+TJvoxafbmXsJRX
         7OUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708457596; x=1709062396;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:reply-to:message-id:subject:cc:to:from:date
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hS/yuuA0H0X0W3262oNsyvTh2OxC1cjSVmh94D2fzDk=;
        b=Uqu9FpHhS8exHnpZncNG540EpY8ATC/mSiFkoywfOGY7E2eiq8BdZDxCtzmKG4AMl9
         Nu4bLt/IxZm2XrZ+sNUEbvWKofsKi6DKm+CM4u7KrboKP+deGLMDfiizPXCnTod8Zh23
         zkhcl/XxnHxUq7weTTMihaD4ZC0/WxkaLFl8nYy+UVRX19D8c2Y+cu7cqe/UHP5tRY/6
         J5NfBy6wyIX0/IT990zS/t4pb+vWpdw2KnwrEhHmzgJ0iH9BCZNJGfwscwX2WW16gWg3
         tF6xrjinwSu6ypaT3Sf9DWfWtV5DAcEqh0GBxalAkLoV9JswA5n/W+c0+MrgXHXw+9nA
         pUCw==
X-Forwarded-Encrypted: i=1; AJvYcCVeqJMyMGU7tUkvoy/XpSgDy1UmVUpvihEMb2cwGeJqXmXFpfwDkueqf4cBx3JCHrR+KLWSjHu6KCg3+8227WZADmAENHX7hbqKqhX5
X-Gm-Message-State: AOJu0YzIkFgNZeY4Xmy0oRdpZsdszKnoKG6ma6eld0vvetvDpd8RyYq8
	WORQAu9woi63jNgie23/+O5pYKB/0lQdzbcIbM2hCfCV2pyCMbU=
X-Google-Smtp-Source: AGHT+IG0hvt7fjbOEHQV8Nc2TWDmcMMjAJb0h6TKL9fNKwRKKCsDYjVbD6Wcn8GBqzXJtVr8GhRs5Q==
X-Received: by 2002:a05:6830:3d0d:b0:6e1:43a4:c412 with SMTP id eu13-20020a0568303d0d00b006e143a4c412mr15820908otb.32.1708457596316;
        Tue, 20 Feb 2024 11:33:16 -0800 (PST)
Received: from serve.minyard.net (serve.minyard.net. [2001:470:b8f6:1b::1])
        by smtp.gmail.com with ESMTPSA id j19-20020a9d7d93000000b006e2e7cb1da2sm1346756otn.66.2024.02.20.11.33.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 11:33:15 -0800 (PST)
Sender: Corey Minyard <tcminyard@gmail.com>
Received: from mail.minyard.net (unknown [172.59.123.64])
	by serve.minyard.net (Postfix) with ESMTPSA id A27C61800BF;
	Tue, 20 Feb 2024 19:33:14 +0000 (UTC)
Date: Tue, 20 Feb 2024 13:33:13 -0600
From: Corey Minyard <minyard@acm.org>
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: Andrew Geissler <geissonator@gmail.com>, joel@jms.id.au,
	andrew@codeconstruct.com.au,
	openipmi-developer@lists.sourceforge.net,
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org,
	Andrew Geissler <geissonator@yahoo.com>
Subject: Re: [PATCH] ipmi: kcs: Update OBF poll timeout to reduce latency
Message-ID: <ZdT+eThnYqb3iawF@mail.minyard.net>
Reply-To: minyard@acm.org
References: <20240220123615.963916-1-geissonator@gmail.com>
 <a9169894-6972-49c0-a1d4-d80863f5b511@molgen.mpg.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a9169894-6972-49c0-a1d4-d80863f5b511@molgen.mpg.de>

On Tue, Feb 20, 2024 at 04:51:21PM +0100, Paul Menzel wrote:
> Dear Andrew,
> 
> 
> Thank you for your patch. Some style suggestions.
> 
> Am 20.02.24 um 13:36 schrieb Andrew Geissler:
> > From: Andrew Geissler <geissonator@yahoo.com>
> 
> (Oh no, Yahoo. (ignore))
> 
> You could be more specific in the git commit message by using *Double*:
> 
> > ipmi: kcs: Double OBF poll timeout to reduce latency
> 
> > ipmi: kcs: Double OBF poll timeout to 200 us to reduce latency
> 
> > Commit f90bc0f97f2b ("ipmi: kcs: Poll OBF briefly to reduce OBE
> > latency") introduced an optimization to poll when the host has

I assume that removing that patch doesn't fix the issue, it would only
make it worse, right?

> > read the output data register (ODR). Testing has shown that the 100us
> > timeout was not always enough. When we miss that 100us window, it
> > results in 10x the time to get the next message from the BMC to the
> > host. When you're sending 100's of messages between the BMC and Host,
> 
> I do not understand, how this poll timeout can result in such an increase,
> and why a quite big timeout hurts, but I do not know the implementation.

It's because increasing that number causes it to poll longer for the
event, the host takes longer than 100us to generate the event, and if
the event is missed the time when it is checked again is very long.

Polling for 100us is already pretty extreme. 200us is really too long.

The real problem is that there is no interrupt for this.  I'd also guess
there is no interrupt on the host side, because that would solve this
problem, too, as it would certainly get around to handling the interupt
in 100us.  I'm assuming the host driver is not the Linux driver, as it
should also handle this in a timely manner, even when polling.

If people want hardware to perform well, they ought to design it and not
expect software to fix all the problems.

The right way to fix this is probably to do the same thing the host side
Linux driver does.  It has a kernel thread that is kicked off to do
this.  Unfortunately, that's more complicated to implement, but it
avoids polling in this location (which causes latency issues on the BMC
side) and lets you poll longer without causing issues.

I'll let the people who maintain that code comment.

-corey

> 
> > this results in a server boot taking 50% longer for IBM P10 machines.
> > 
> > Started with 1000 and worked it down until the issue started to reoccur.
> > 200 was the sweet spot in my testing. 150 showed the issue
> > intermittently.
> 
> I’d add a blank line here.
> 
> > Signed-off-by: Andrew Geissler <geissonator@yahoo.com>
> > ---
> >   drivers/char/ipmi/kcs_bmc_aspeed.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/char/ipmi/kcs_bmc_aspeed.c b/drivers/char/ipmi/kcs_bmc_aspeed.c
> > index 72640da55380..af1eae6153f6 100644
> > --- a/drivers/char/ipmi/kcs_bmc_aspeed.c
> > +++ b/drivers/char/ipmi/kcs_bmc_aspeed.c
> > @@ -422,7 +422,7 @@ static void aspeed_kcs_irq_mask_update(struct kcs_bmc_device *kcs_bmc, u8 mask,
> >   			 * missed the event.
> >   			 */
> >   			rc = read_poll_timeout_atomic(aspeed_kcs_inb, str,
> > -						      !(str & KCS_BMC_STR_OBF), 1, 100, false,
> > +						      !(str & KCS_BMC_STR_OBF), 1, 200, false,
> >   						      &priv->kcs_bmc, priv->kcs_bmc.ioreg.str);
> >   			/* Time for the slow path? */
> >   			if (rc == -ETIMEDOUT)
> 
> 
> Kind regards,
> 
> Paul


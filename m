Return-Path: <linux-kernel+bounces-139554-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A10BB8A0453
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 02:02:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C0AFA1C22B96
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 00:02:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EC372CA7;
	Thu, 11 Apr 2024 00:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g2dUieEy"
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5248E63D;
	Thu, 11 Apr 2024 00:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712793733; cv=none; b=H31xp9vhebqFn37emuIWmwWA3Dw0nlwUBSbZqEoHoJRkxtmU8jnsyk056lO0wH/AZlKu8VVXP9AAlroet4uNRdTZiNWNEbbIJpqfMhfbKh/YQTNhyC4v2r9qCEqVY6hysKmN77PcSZbbd7w1WQk0TJa9Jle5aIgU9u4KP+yh9xI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712793733; c=relaxed/simple;
	bh=OSTd7Qy7f+1f9UZ9ao6IxRPViSiIVpqybSuKe7pfrC8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e1E9nOaqLaPBpOEaXGQSmyUjLJcv5IBGr4J5Jf1sb0ZKZK+DjH6DZfcZylzQapan4t0E1QBsUWtOt9qTnnvYANqgT2jou5B3XxTeBVTg9Wnn+r3duCjhMCaR2bPCYDkHDxYAZrFVVxVeNp+AbgmvUZdMVFtwUX8EqVQbX3pmTlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g2dUieEy; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2a519ac18b3so2723268a91.2;
        Wed, 10 Apr 2024 17:02:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712793731; x=1713398531; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wfrCZroFultv+MXju5r6SP+mW/5Hc70daHzU+zkVS5Y=;
        b=g2dUieEyKmmRwjQeLqhovjUrnvb+etJ0UyZ3pJAw94R/+pIFPENRx/mfXe59E3+Kjb
         rzSKcaSLXBI9noM6FBHNd/JUMus9z2W6xDFw5R2ZC8QpMbn3TEf0OK8ieiQaidVI859L
         ZUkXAEn9UPm5n6cwqO872VdcSGXakSkuB5Pf+f4iGPk084hj1eT2nomr4uPNwjn1WGYP
         yoqDEnmiK/eH597QFP2/6W5Ov8hXkvko+by6Jqd9Pq7r/ECjmvWSD9lCAVzzuLSv6/Vx
         nyOpLfJHs8ZtmvZHC+rbFzrExKIuY5Xn54FYamlwH5+be+f4CTDCZdSUhfgguyyNQ83H
         HfQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712793731; x=1713398531;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wfrCZroFultv+MXju5r6SP+mW/5Hc70daHzU+zkVS5Y=;
        b=odvjd/U5v75KVmXhlHf8OU1VmnBV/jIZV/ItWRsQ88P1ei05YVGoWZOgJwQWwIzCLj
         ONqWGhBuSVRMMdKnzViuie/316coDLfqhL820mOw1cPI7Yp1SCSWtbLI10hEcstHtTTP
         pGaz5BLYlircK0GYB6k9ApnDl6q+gpPiQIZCeQS+wyVPiSmdBZZTuIaDvQcOnLsXo1Al
         TU4QfaOa1of52ZFoevg4X9FYmsZ+t+dupv2iaUQeLXHuQRYTwyCM9ZNePP2qZCYWewFl
         IK94SiYFggDIzqjH0KtUF3n4YqF2+Iod5a1oVSpsWuNasfwn9otoFO9KrcdBjCiHLmfu
         ciIQ==
X-Forwarded-Encrypted: i=1; AJvYcCUJqB6x0FmN1MT3vgjMvmDK9O8PaXtmc5XlKrdxNwWvzNUwZXU8Z1GHUaf22XeMKFq8oAld/wzMhE+aHVsGxJI5JeWuNh/+gsChGHpepMhjQFGYR66sYpHkYRIlXoNfhmjf/qz1gNJ3rN1Va2QfIdd6Rcjzclcpz9ro73vgPLBAUDcYpL2OMNkJWOfqww/X
X-Gm-Message-State: AOJu0Yz6DXAeVC2EhJBvUS5TKWlIlan8mmJq6w0i1LkZPnZAL2Rh6Tff
	QxjhBt0sunQK/wqo7ORrvFKAc0l4iIGhZSaBrN1Jl7ne5X3cL5Nr
X-Google-Smtp-Source: AGHT+IGigq1nRlAG3wzK4rdyckpZKJucY604QtyMnvFuJC/poZuw8R8R2TYwxexL8XTYjwY++6JkRA==
X-Received: by 2002:a17:90a:d484:b0:2a5:d0cf:3ef with SMTP id s4-20020a17090ad48400b002a5d0cf03efmr3096746pju.37.1712793731204;
        Wed, 10 Apr 2024 17:02:11 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:60da:41be:a28d:f612])
        by smtp.gmail.com with ESMTPSA id h16-20020a17090a051000b002a2e4b593cdsm2079501pjh.51.2024.04.10.17.02.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Apr 2024 17:02:10 -0700 (PDT)
Date: Wed, 10 Apr 2024 17:02:08 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Mark Pearson <mpearson-lenovo@squebb.ca>
Cc: Peter Hutterer <peter.hutterer@redhat.com>,
	Hans de Goede <hdegoede@redhat.com>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Henrique de Moraes Holschuh <hmh@hmh.eng.br>,
	ibm-acpi-devel@lists.sourceforge.net,
	"platform-driver-x86@vger.kernel.org" <platform-driver-x86@vger.kernel.org>,
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
	Nitin Joshi1 <njoshi1@lenovo.com>,
	Vishnu Sankar <vsankar@lenovo.com>
Subject: Re: [PATCH 1/4] Input: Add trackpoint doubletap and system debug
 info keycodes
Message-ID: <ZhcogDESvZmUPEEf@google.com>
References: <mpearson-lenovo@squebb.ca>
 <20240324210817.192033-1-mpearson-lenovo@squebb.ca>
 <20240324210817.192033-2-mpearson-lenovo@squebb.ca>
 <ZhR-WPx7dgKxziMb@google.com>
 <f3342c0b-fb31-4323-aede-7fb02192cf44@redhat.com>
 <ZhW3Wbn4YSGFBgfS@google.com>
 <ZhXpZe1Gm5e4xP6r@google.com>
 <92ee5cb2-565e-413c-b968-81393a9211c4@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <92ee5cb2-565e-413c-b968-81393a9211c4@app.fastmail.com>

On Tue, Apr 09, 2024 at 10:17:05PM -0400, Mark Pearson wrote:
> Hi Dmitry
> 
> On Tue, Apr 9, 2024, at 9:20 PM, Dmitry Torokhov wrote:
> > On Tue, Apr 09, 2024 at 02:47:05PM -0700, Dmitry Torokhov wrote:
> >> On Tue, Apr 09, 2024 at 03:23:52PM +1000, Peter Hutterer wrote:
> >> > On 09/04/2024 09:31, Dmitry Torokhov wrote:
> >> > > Hi Mark,
> >> > > 
> >> > > On Sun, Mar 24, 2024 at 05:07:58PM -0400, Mark Pearson wrote:
> >> > > > Add support for new input events on Lenovo laptops that need exporting to
> >> > > > user space.
> >> > > > 
> >> > > > Lenovo trackpoints are adding the ability to generate a doubletap event.
> >> > > > Add a new keycode to allow this to be used by userspace.
> >> > > 
> >> > > What is the intended meaning of this keycode? How does it differ from
> >> > > the driver sending BTN_LEFT press/release twice?
> >> > > > 
> >> > > > Lenovo support is using FN+N with Windows to collect needed details for
> >> > > > support cases. Add a keycode so that we'll be able to provide similar
> >> > > > support on Linux.
> >> > > 
> >> > > Is there a userspace consumer for this?
> >> > 
> >> > Funnily enough XKB has had a keysym for this for decades but it's not
> >> > hooked up anywhere due to the way it's pointer keys accessibility
> >> > feature was implemented. Theory is that most of userspace just needs
> >> > to patch the various pieces together for the new evdev code + keysym,
> >> > it's not really any different to handling a volume key (except this
> >> > one needs to be assignable).
> >> 
> >> What is the keysym? If we can make them relatable to each other that
> >> would be good. Or maybe we could find a matching usage from HID usage
> >> tables...
> >
> > I was looking through the existing codes and I see:
> >
> > #define KEY_INFO		0x166	/* AL OEM Features/Tips/Tutorial */
> >
> > We also have KEY_VENDOR used in a few drivers/plafrom/x86, including
> > thinkkpad_acpi.c and I wonder if it would be suitable for this vendor
> > specific debug info collection application (which I honestly doubt will
> > materialize).
> >
> 
> That's a somewhat disappointing note on your doubts, is that based on
> anything? Just wondering what we've done to deserve that criticism.

Sorry, this was not meant as a criticism really, but you mentioned
yourself that there isn't anything in the works yet, you just have some
plans.

For such a project to succeed Lenovo needs to invest into selling
devices with Linux as a primary operating system, and it has to be
consumer segment (or small business, because for corporate they
typically roll their own support channels). The case of retrofitting
Linux onto a that device originally came with Windows OS rarely gets
much if any response from the normal support channels.

Is this something that is actually happening?

> 
> That aside, I guess KEY_INFO or KEY_VENDOR could be a good fit (I
> personally don't think KEY_CONFIG matches well), but I would be
> worried about clashing with existing functionality.
> 
> Peter - do you have any opinion from the user space side of things, or
> are these likely unused? KEY_VENDOR seems the safer bet to me (but I
> don't love it).
> 
> Dmitry - What are the downsides or concerns of introducing a new code?
> I'd like to evaluate that against the potential to cause conflicts by
> re-using existing codes. If you feel strongly about it then I'll defer
> to your judgement, but I'd like to understand better the context.

The keycode space is finite and extending bitmaps leads to more memory
consumption and weird breakages (like uevent generation exceeding 4K
memory page resulting in failures). I am trying to balance need for new
keycodes with how likely they are to be used.

Thanks.

-- 
Dmitry


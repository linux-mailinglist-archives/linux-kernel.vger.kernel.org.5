Return-Path: <linux-kernel+bounces-145770-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FEF88A5A92
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 21:32:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E13B41F2343A
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 19:32:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98877156644;
	Mon, 15 Apr 2024 19:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CC8eOsYt"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F95713AA22;
	Mon, 15 Apr 2024 19:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713209550; cv=none; b=TnZJZiuqL8If/T3Tza4cYA2DipvxShjUmZo0DOYYXzv3eaeSxwGlDuBWyNBGyO9fKh5kl98TIbTM86z6wUSeoGQ+z2hKv7mB2Jz0ZZpiVKGiSJZ5JoXMN0NW9c+J1gTZv+4/FQOElo7I4H7zu4uBWBMhDoW3sqhlcbVU/N7SJOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713209550; c=relaxed/simple;
	bh=0VPKlFuoyuYr0HpXEhpfS2WZF705amdVfc3Dht5CDcI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LlA3XidD91l0ZEWY1N4tNeTSa2+dXb1z294FO5Wp7FSurdWZRsGccusXQW3mlKQFJ9c/DOOF+lqH0blyrYr9vw3lLxTiSMKVdyvjVcjnp/4Kn0rmP1MaFDlEGft3LafXRspWkfoiuxMquH3HyJCSmISC+Z/vY5hcdt/fuHPclmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CC8eOsYt; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1e4c4fb6af3so19466275ad.0;
        Mon, 15 Apr 2024 12:32:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713209549; x=1713814349; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=b0+MOt3vSWNQouVSTzHujQlq5+ecBPB0jEZqFyyUync=;
        b=CC8eOsYta/gDJbCiy/VLbbB+vq/wcbWV0XQbF8qv1+XG+qSzc2T7QgJC35aai10mHe
         QaW/pOEA4QjenwHs9qE8mQmxozwjFptSFt/skx+nL0JUvHTVLW1LI6V27Nzt262XoK6p
         D3gGT1P78efbHhBcOlGQoVIJbJhWaYkRNeq+YcPJBtpFFaKUUCuPeO3duLDjDna75Uyw
         yM6NBfATd+fYfAc6dCRbF4RL6teiudXf2Kl5iP3aZJ3BN4jVHQCXuG6V6E/TJ5Zlfy3z
         YIe4oqZQdQsyBViiXltLD3SMtpcseRg5j12cVsFYBjAgliw9tcJnYRHSHXcO2z1MvBhE
         o7fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713209549; x=1713814349;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b0+MOt3vSWNQouVSTzHujQlq5+ecBPB0jEZqFyyUync=;
        b=XVc6dNDACuGuLWOmyH8Qu/hXxUPFNeisMhRiwgVQlb8EJeGmEHTd3meOUd4WLeNGuv
         d5hTBmx1npgXWUuN3Bcys3J8SB9xuaUsTZM9AdXMUWMm4IfslaeuGltLL7pBFWloEAW2
         dkKgEta/n5cw7iBgUDARcaDLSXa291mXBpyNmzrCUW4MFwWwA0AV/zL+WlY9Dm4XbA7X
         KZ3J+9lFWk+Ulq2ch9F85Cx1CJZtsmtHmLMxx5VDlx9t6YkDczF8Kw4sKZm3bEpvqGw1
         J/ctGxLIJDcqQ047hZM21VCWYgTTik81L49m69SgpVy9azR5dbEQMnXSp577K2jXe7fP
         xDyw==
X-Forwarded-Encrypted: i=1; AJvYcCWJjwHhn8iXpQb26UC+HxWJoddjiGRAYY+nrHAkgwN4akOZcnaEs7kIDVhqq7pl+/kuvNat23c0CFuyZCOTy3VOYGpQVozvt7xxMTc+IT2Fu1UD9HakqOYZbjutUEmVzTzl++uxDLjOAy6cjO37H+EW2paSZr2rAEfBbNPkYf2aOSM5mEHEGvadR6eunJTv
X-Gm-Message-State: AOJu0Ywwk6jhXZeepXtrTtonkF/NFMMsprOnwaufdhGqeoIniRug9UhE
	rrbvDoeR0005xs2UZHMPUU4Judh6g/bJUWZARzhl72cPaz2t1AbA
X-Google-Smtp-Source: AGHT+IFFGBYX7GrgIkithXjMOEcbpKE8/IR7l+wZD008b+p7zqgJ8+k53Kd1ZAZbZR/LHaAS+oLqAw==
X-Received: by 2002:a17:902:bd42:b0:1e4:6253:2f15 with SMTP id b2-20020a170902bd4200b001e462532f15mr2727plx.16.1713209548567;
        Mon, 15 Apr 2024 12:32:28 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:fbbe:421b:9296:f28c])
        by smtp.gmail.com with ESMTPSA id z13-20020a170903018d00b001e22860c32asm8227094plg.143.2024.04.15.12.32.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Apr 2024 12:32:28 -0700 (PDT)
Date: Mon, 15 Apr 2024 12:32:25 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Peter Hutterer <peter.hutterer@redhat.com>
Cc: Mark Pearson <mpearson-lenovo@squebb.ca>, hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com, hmh@hmh.eng.br,
	ibm-acpi-devel@lists.sourceforge.net,
	platform-driver-x86@vger.kernel.org, linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org, njoshi1@lenovo.com,
	vsankar@lenovo.com
Subject: Re: [PATCH 1/4] Input: Add trackpoint doubletap and system debug
 info keycodes
Message-ID: <Zh2AySQR93GNvoaL@google.com>
References: <mpearson-lenovo@squebb.ca>
 <20240324210817.192033-1-mpearson-lenovo@squebb.ca>
 <20240324210817.192033-2-mpearson-lenovo@squebb.ca>
 <ZhR-WPx7dgKxziMb@google.com>
 <f3342c0b-fb31-4323-aede-7fb02192cf44@redhat.com>
 <ZhW3Wbn4YSGFBgfS@google.com>
 <ZhXpZe1Gm5e4xP6r@google.com>
 <5fe3b171-afc0-47de-802c-28470ce40674@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5fe3b171-afc0-47de-802c-28470ce40674@redhat.com>

On Wed, Apr 10, 2024 at 02:32:56PM +1000, Peter Hutterer wrote:
> On 10/04/2024 11:20, Dmitry Torokhov wrote:
> > On Tue, Apr 09, 2024 at 02:47:05PM -0700, Dmitry Torokhov wrote:
> > > On Tue, Apr 09, 2024 at 03:23:52PM +1000, Peter Hutterer wrote:
> > > > On 09/04/2024 09:31, Dmitry Torokhov wrote:
> > > > > Hi Mark,
> > > > > 
> > > > > On Sun, Mar 24, 2024 at 05:07:58PM -0400, Mark Pearson wrote:
> > > > > > Add support for new input events on Lenovo laptops that need exporting to
> > > > > > user space.
> > > > > > 
> > > > > > Lenovo trackpoints are adding the ability to generate a doubletap event.
> > > > > > Add a new keycode to allow this to be used by userspace.
> > > > > 
> > > > > What is the intended meaning of this keycode? How does it differ from
> > > > > the driver sending BTN_LEFT press/release twice?
> > > > > > 
> > > > > > Lenovo support is using FN+N with Windows to collect needed details for
> > > > > > support cases. Add a keycode so that we'll be able to provide similar
> > > > > > support on Linux.
> > > > > 
> > > > > Is there a userspace consumer for this?
> > > > 
> > > > Funnily enough XKB has had a keysym for this for decades but it's not
> > > > hooked up anywhere due to the way it's pointer keys accessibility
> > > > feature was implemented. Theory is that most of userspace just needs
> > > > to patch the various pieces together for the new evdev code + keysym,
> > > > it's not really any different to handling a volume key (except this
> > > > one needs to be assignable).
> > > 
> > > What is the keysym? If we can make them relatable to each other that
> > > would be good. Or maybe we could find a matching usage from HID usage
> > > tables...
> 
> There's a set of  XK_Pointer_ keysyms defined in X11/keysym.h,
> including XK_Pointer_DblClick1 and XK_Pointer_DblClickDefault.
> Unfortunately they're not hooked up to anything atm, see this draft
> MR:
> https://gitlab.freedesktop.org/xkeyboard-config/xkeyboard-config/-/merge_requests/659
> Because they're not hooked up anywhere they'll also need to be hooked
> into the client space, same as the various XF86FooBar symbols we've
> added over the years.
> 
> If we were to add KEY_DOUBLECLICK we can patch xkeyboard-config to
> bind that to the existing XK_Pointer_DblClickDefault symbol (it would
> get XF86DoubleClick assigned by the current automated scripts), so in
> theory that key would work like any other key with that symbol
> assigned.
> 
> > I was looking through the existing codes and I see:
> > 
> > #define KEY_INFO		0x166	/* AL OEM Features/Tips/Tutorial */
> > 
> > We also have KEY_VENDOR used in a few drivers/plafrom/x86, including
> > thinkkpad_acpi.c and I wonder if it would be suitable for this vendor
> > specific debug info collection application (which I honestly doubt will
> > materialize).
> 
> fwiw, I suggested KEY_DOUBLECLICK because that is the action the user
> takes. Whether that starts a particular application is mostly a
> question of configuration, defaulting to something that emulates a
> double-click seems prudent though. And if someone wants to remap that
> to the compose key that'd be trivial too then.

I think whether to create and use KEY_DOUBLECLICK is very much depends
if we associate this with the pointer somehow, or if we keep it as a
completely separate action.

If we continue with KEY_DOUBLECLICK then we need to try and define what
exactly it means to the applications. Actually same goes if we want
another new keycode.

As far as easy remapping, I think one can map this to KEY_RESERVED and
then remap to whatever they want, you do not need to have a new keycode
for that.

Thanks.

-- 
Dmitry


Return-Path: <linux-kernel+bounces-137790-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 201CE89E7AF
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 03:20:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 315431C21D96
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 01:20:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D9191388;
	Wed, 10 Apr 2024 01:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eqJWULE1"
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2466A55;
	Wed, 10 Apr 2024 01:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712712043; cv=none; b=bmgNgop745olrvRT+jCbQoh2m5DUaeVDoc5QD4ckADlc67iRpx7w58XbCjgYd+7t5njXaUjbQ8IeCLaC+WzUxleTboq7hj+lIa96qZ6et/Zzgj4iQPYSM/iIhmMdsslXDv6COAi5nbvyHjluBNrm8w9oUvwURLwJKnjkZfHr3ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712712043; c=relaxed/simple;
	bh=WYwBnUqBZdkk7+EUdgehwAHSCavj8b4ZE6c6EKFu8nc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uf/E6au/NFf2BfQV+yHeapI+yCxj951Vtx73HImIvIEFbNFUST91ZK5JA+kfVezeD5Wa726dXHLm+95BXZg29ZtZvUeEnp1A6zJrD66oWiXHT9Q0UJjfaF4PSmANLVZdkv9/tC575SzvO+ytFJhIb/NPtZfB2L+dch/ROqpnUkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eqJWULE1; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-6ea1ef9e4e9so940491a34.1;
        Tue, 09 Apr 2024 18:20:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712712041; x=1713316841; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZtBWhAwcpxshXjsjFh4lr39Z4uP+VFkhOv/GkXZ9HYU=;
        b=eqJWULE11RT30XtK8DSl3t0j4pw6CcS9UbdvOeINhIsk/ECKRzDygEpSqYbrB/uEU8
         d5eboqpZFhMY6Cs6E73XPZqSQOln72olPPeWukcN1i+s4Rs/yQnEDE8Wt1mlVq+qPgNl
         eRj0MArClmTb3Ie8fCafBUegYQNBYXjlCV5wX5M4GZTqVYoPSFnbKw1OyOWo7esn7XqS
         1nW3RRnBq2rcy3+5HN0FPm0Q9hHlGoTDI3n+d+rh9oS6cWfXeGmAe96ibhXclVardtH/
         hjsWwzAfnF0HgJMs6ScQwu2pwCmwrjWujgu3gD0LcX8GW8in6yH0reiGDHLiaW+7SVKQ
         DbDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712712041; x=1713316841;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZtBWhAwcpxshXjsjFh4lr39Z4uP+VFkhOv/GkXZ9HYU=;
        b=G5A2KvsuYh8P5LQPs1OoXiGrkPXxm98UmEbgyAu3C196A8Vjy59Q8Cx//W7rVzRLqb
         Pe7RtmVV4yhHMLMGs5wEdVPiQLFRc/oNZqIa3mAIfuskVgpg9u0XG5kyh+eaqC8pjeL6
         /4SV8CjNTlGmssowvGAPH7jR5HUMTi7203tn2s121q78um+07Wdcj6wxrTwuzZMWYol2
         Oy0tb7s1p09H6PZZijkUdrna9DjJZ2zZNE4n5j/026xT3wJUXkxp3SWqKI8GergIO6/0
         19YLGOQif8hXn5nC9YW2m8u0Kn0XVKZBhY/Z71zxykATMRyJSkavKuHu32ryFDruRnHW
         kisw==
X-Forwarded-Encrypted: i=1; AJvYcCUTvg5p+6pVS9a1mcLWlN49k4ZawwZ4+KVCLBWgrwJN4AdJRNY6KS5MYi0oUYMzaF5duUaJYxrXCE+FrrkFiaNKkUk/kn/a9bPyH0VlXfiTKYVRY5lfCU6q9O74e6GaR9+UfiqQHsAzd3pCqaIenca0CR0hCqGHWXc5JEZEuC6fJMXiKV4g1aXEWD1cntXM
X-Gm-Message-State: AOJu0YwKFss6AH+vrgLGP1HS7J7CDjSNDXaPRvXU+ILz63B/WTpeTAUN
	aITVwTRMvTM3Ot5cBeZYmnkE9cr1DRskoM9BaOFR53Hn1W0XJgEI
X-Google-Smtp-Source: AGHT+IF1CU1GiDckwdk9ehAdoDCsxO4V5wtdnDbbOZxdT+PqMZjd7i9DgsLROxcMaHW7w+oc2VFU/Q==
X-Received: by 2002:a9d:6c83:0:b0:6ea:2343:9869 with SMTP id c3-20020a9d6c83000000b006ea23439869mr1534691otr.20.1712712040713;
        Tue, 09 Apr 2024 18:20:40 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:6c8c:a143:d391:6ace])
        by smtp.gmail.com with ESMTPSA id r16-20020a632050000000b005f05c88c149sm8742632pgm.71.2024.04.09.18.20.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Apr 2024 18:20:40 -0700 (PDT)
Date: Tue, 9 Apr 2024 18:20:37 -0700
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
Message-ID: <ZhXpZe1Gm5e4xP6r@google.com>
References: <mpearson-lenovo@squebb.ca>
 <20240324210817.192033-1-mpearson-lenovo@squebb.ca>
 <20240324210817.192033-2-mpearson-lenovo@squebb.ca>
 <ZhR-WPx7dgKxziMb@google.com>
 <f3342c0b-fb31-4323-aede-7fb02192cf44@redhat.com>
 <ZhW3Wbn4YSGFBgfS@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZhW3Wbn4YSGFBgfS@google.com>

On Tue, Apr 09, 2024 at 02:47:05PM -0700, Dmitry Torokhov wrote:
> On Tue, Apr 09, 2024 at 03:23:52PM +1000, Peter Hutterer wrote:
> > On 09/04/2024 09:31, Dmitry Torokhov wrote:
> > > Hi Mark,
> > > 
> > > On Sun, Mar 24, 2024 at 05:07:58PM -0400, Mark Pearson wrote:
> > > > Add support for new input events on Lenovo laptops that need exporting to
> > > > user space.
> > > > 
> > > > Lenovo trackpoints are adding the ability to generate a doubletap event.
> > > > Add a new keycode to allow this to be used by userspace.
> > > 
> > > What is the intended meaning of this keycode? How does it differ from
> > > the driver sending BTN_LEFT press/release twice?
> > > > 
> > > > Lenovo support is using FN+N with Windows to collect needed details for
> > > > support cases. Add a keycode so that we'll be able to provide similar
> > > > support on Linux.
> > > 
> > > Is there a userspace consumer for this?
> > 
> > Funnily enough XKB has had a keysym for this for decades but it's not
> > hooked up anywhere due to the way it's pointer keys accessibility
> > feature was implemented. Theory is that most of userspace just needs
> > to patch the various pieces together for the new evdev code + keysym,
> > it's not really any different to handling a volume key (except this
> > one needs to be assignable).
> 
> What is the keysym? If we can make them relatable to each other that
> would be good. Or maybe we could find a matching usage from HID usage
> tables...

I was looking through the existing codes and I see:

#define KEY_INFO		0x166	/* AL OEM Features/Tips/Tutorial */

We also have KEY_VENDOR used in a few drivers/plafrom/x86, including
thinkkpad_acpi.c and I wonder if it would be suitable for this vendor
specific debug info collection application (which I honestly doubt will
materialize).

Thanks.

-- 
Dmitry


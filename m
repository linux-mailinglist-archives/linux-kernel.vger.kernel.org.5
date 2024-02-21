Return-Path: <linux-kernel+bounces-74981-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2334285E0B6
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 16:14:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD973284F64
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 15:14:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D817680040;
	Wed, 21 Feb 2024 15:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gehiR7Qs"
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D49F7BB01;
	Wed, 21 Feb 2024 15:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708528480; cv=none; b=V/2oObmk3FAjpZ8Rv8O9SSUqEHW5AUYasAV6Yk39FkH9DLrU45sr4Fm/5/Wj+TWZwDNsqI97ZNi6cyKrn4ab6tYjrHeE7jkoMiaF+A7vkTlHpW3qe9uPd06yuQ0BwUawbkWWl1P/z3hHX58i57hQ0/GKrBi/QrXOmYg78VbGCM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708528480; c=relaxed/simple;
	bh=4oIgzmTnY/f+LqXpj9qdpe6DmOvhzWKH1oK8K1bmV4k=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 MIME-Version:Content-Type; b=E95h+2AMO35WBB+nE85dmu+TMref39wFwNA21+R5CGSs4Sgtj4T/N9bT5NIH+x59VJrXXyx8cCP1x0kCUWytQxOSeQw/5Id0TNr1EwEqzLqTvyAwEVnhT252Ei1IBW6bDCRkVTMCOd4QyKGT33segFCmlRLH7igqajLdlAisVlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gehiR7Qs; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2d10ad265d5so74426401fa.0;
        Wed, 21 Feb 2024 07:14:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708528476; x=1709133276; darn=vger.kernel.org;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=8aiLu7q/d1kLi9vrNcF4koy98Ognr5U6JqF7jArnIv0=;
        b=gehiR7QsrEBWvEh6yLWVtN5gc7Sje/tQxt8UTRFDzFZH/atqR88CZyVh2ZQpL5Qx1y
         bk0uktBYC60WV+pNTdgU78lf/KM/Mlfy9mJmXG+0H/W/lFfckJlQhd6xFL0c1RZlDR5H
         sCdtzsKRWCIFsufOV82juGCYk3kcSITT9mPeoGoZDN3ziILvdFuGq3Yufiv93044xHmq
         P6ni4cBBPzgY1AlJARvhTXOkypt/AbZRGfczQXeR2iejI7AAbh1+IvBHsEHEfevZQXsK
         fxGzTCeIthXNdiSeDdrfruXyq/jW1u4FyoQfrDmTkd8spF74WliAwXxct0Gv2z+nxZej
         KZjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708528476; x=1709133276;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8aiLu7q/d1kLi9vrNcF4koy98Ognr5U6JqF7jArnIv0=;
        b=IZf3oiiiaycOkJynjZFxiU6jeb696yw72DPQsncm2KkJr45yNdBaZSEyCo3eEwZSY0
         X1C6PA28XM/D7nmn0BVtvF/zL7IVKpQYZp6df7sdFSkVo61i6viEAo8g8yWeXqTIzAO5
         T3XV7sUeYC6iK+1mTsT/s2MD4nEXhOoMYAfCWLa6oOwmw56W4ASSCevKTAT1bDavP6fX
         9Aze2OCTPGNU2nz9bds0/RsmzpsBFIRCNVuuC/UXLrD9qoAECa8EHaJ8SAbtO9BudWPb
         Q4BtXqeMeEXAASzgY6I7RaN4DO+4YRbqKIflEwJnxkGiOccXqmVWX5914Y78+ZzUgN5H
         wQGg==
X-Forwarded-Encrypted: i=1; AJvYcCVtqRitLCqfqshXqMV6LUGKZjBVGE65BHXxHD2os5NgrV9Z5ksXazJzWpaVc4KRQKbfAEopYyUCi73nAyekxQJLO8maJ6NbOXTkKRpD
X-Gm-Message-State: AOJu0YxHfe0moeS4EHmVFylj02+2ksah2TZULbDQwETTh9169oXgbUa6
	bq3YBWkF+HJD4WdtGJGScZyiZMndiGD6jRFDvO4Z6SA+56UapQIq
X-Google-Smtp-Source: AGHT+IEwqe4rMPKuEDPXCGIJg2V9EGKVv2j1bAOM5XSPPWHMgMrhMpQz6mDxQG1f2JAVsoF3RxHEgQ==
X-Received: by 2002:ac2:592c:0:b0:512:b00f:a55e with SMTP id v12-20020ac2592c000000b00512b00fa55emr5715394lfi.13.1708528476184;
        Wed, 21 Feb 2024 07:14:36 -0800 (PST)
Received: from razdolb ([89.208.103.172])
        by smtp.gmail.com with ESMTPSA id q6-20020ac246e6000000b00511ae6442a2sm1700184lfo.0.2024.02.21.07.14.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Feb 2024 07:14:35 -0800 (PST)
References: <20231218174042.794012-1-mike.rudenko@gmail.com>
User-agent: mu4e 1.10.8; emacs 29.2.50
From: Mikhail Rudenko <mike.rudenko@gmail.com>
To: Mikhail Rudenko <mike.rudenko@gmail.com>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, Sakari Ailus
 <sakari.ailus@linux.intel.com>, Laurent Pinchart
 <laurent.pinchart@ideasonboard.com>, Jacopo Mondi <jacopo@jmondi.org>,
 Tommaso Merciai <tomm.merciai@gmail.com>, Christophe JAILLET
 <christophe.jaillet@wanadoo.fr>, Dave Stevenson
 <dave.stevenson@raspberrypi.com>, Mauro Carvalho Chehab
 <mchehab@kernel.org>
Subject: Re: [PATCH v2 00/20] Omnivision OV4689 refactoring and improvements
Date: Wed, 21 Feb 2024 18:02:15 +0300
In-reply-to: <20231218174042.794012-1-mike.rudenko@gmail.com>
Message-ID: <87o7c9q27c.fsf@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain


Hi,

On 2023-12-18 at 20:40 +03, Mikhail Rudenko <mike.rudenko@gmail.com> wrote:

> Hi,
>
> This series contains refactoring and new features implementation for
> the Omnivision OV4689 sensor driver. Specifically, patches 1, 2, 3, 5,
> 6, 10, 15, 16, 18, and 19 are refactorings, and are not supposed to
> introduce any functional change. Patches 4 and 7 perform migration to
> CCI helpers and subdevice active state respectively, and should not
> introduce any hardware- and/or user-visible change either. Patch 8
> fixes a possible race condition due to v4l2_async_register_subdev_sensor
> being called too early in ov4689_probe, and patch 9 migrates power
> management to PM autosuspend.
>
> Patches 11-14 expose more sensor controls to the userspace, such as
> (read-write) HBLANK, VFLIP/HFLIP, digital gain, and color
> balance. Patch 17 implements configurable analogue crop rectangle via
> .set_selection callback. And finally, patch 20 enables 2x2 binning
> option. It should be noted that publicly available sensor
> documentation is lacking description of many registers and their value
> ranges, so a lot of values had to be found by experimentation.

Gentle ping on this series. Anything I can do to help getting it
reviewed and merged? Maybe split patches 15-20 which implement cropping
and binning and change the driver away from register list based model
into a separate series? Anyone?

> Changes in v2:
> - collect Laurent's r-b's
> - squash together "CCI conversion" and "Set gain in one 16 bit write"
> - use ctrl->val in ov4689_set_ctrl
> - rename try_fmt to fmt in ov4689_init_cfg and drop corresponding comment
> - rebase on top of media-stage and rename init_cfg->init_state
> - sort register definitions by address throughout the whole series
> - fix number of controls hint in v4l2_ctrl_handler_init
> - make all hexadecimal constants lowercase
> - disable runtime pm in probe error path
> - implement pm autosuspend
>
> Mikhail Rudenko (20):
>   media: i2c: ov4689: Clean up and annotate the register table
>   media: i2c: ov4689: Sort register definitions by address
>   media: i2c: ov4689: Fix typo in a comment
>   media: i2c: ov4689: CCI conversion
>   media: i2c: ov4689: Remove i2c_client from ov4689 struct
>   media: i2c: ov4689: Refactor ov4689_set_ctrl
>   media: i2c: ov4689: Use sub-device active state
>   media: i2c: ov4689: Enable runtime PM before registering sub-device
>   media: i2c: ov4689: Use runtime PM autosuspend
>   media: i2c: ov4689: Remove max_fps field from struct ov4689_mode
>   media: i2c: ov4689: Make horizontal blanking configurable
>   media: i2c: ov4689: Implement vflip/hflip controls
>   media: i2c: ov4689: Implement digital gain control
>   media: i2c: ov4689: Implement manual color balance controls
>   media: i2c: ov4689: Move pixel array size out of struct ov4689_mode
>   media: i2c: ov4689: Set timing registers programmatically
>   media: i2c: ov4689: Configurable analogue crop
>   media: i2c: ov4689: Eliminate struct ov4689_mode
>   media: i2c: ov4689: Refactor ov4689_s_stream
>   media: i2c: ov4689: Implement 2x2 binning
>
>  drivers/media/i2c/Kconfig  |   1 +
>  drivers/media/i2c/ov4689.c | 964 +++++++++++++++++++++++--------------
>  2 files changed, 592 insertions(+), 373 deletions(-)


--
Best regards,
Mikhail Rudenko


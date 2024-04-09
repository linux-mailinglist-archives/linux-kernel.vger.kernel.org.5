Return-Path: <linux-kernel+bounces-137655-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EBAA89E527
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 23:47:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A13801C22841
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 21:47:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AF63158A3A;
	Tue,  9 Apr 2024 21:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zo+eTNCB"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59AB36A342;
	Tue,  9 Apr 2024 21:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712699230; cv=none; b=noMGkIrUfAzi7tBLAzM8Rcfkp01x5CE+ozJJAAZyr2GkK+6EHwPy3qExwyQaTjpFTLgkuZ0B7YamiET1Wk893YFt66TvZoI740pmNgXjRNVYRnMgWwXI+aKzfPpfHLLvK+lT3pM6vB3HDgrTzBnTOJIX75OSn/TalyhEiyQwvpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712699230; c=relaxed/simple;
	bh=wR57uFwYE/K06eHef43ZXZf9HQ28hXkJFfydCJ1lIdw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n2P0zuu2h0tJHzp2Hadxil8ZsXND00jN1qNhxpCLyJ/eERaXkfY14LzYYD74YVgI/f8wof60sT26VPg+e1YiKwxLWc50mh+yxEc9LVTgC3wXRGGSu8aCejRH0TxY80v5knMVOuiDWJdFJq251rZBMtUKgbroPHObRk8bYOE3EUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zo+eTNCB; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-6eaf1005fcaso4210455b3a.3;
        Tue, 09 Apr 2024 14:47:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712699229; x=1713304029; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+o+B5YhePemCqfLG1nDv/Zdx5bIr2DP7esNue6DPpZI=;
        b=Zo+eTNCBQi8r899toTeUMquHHg4QRCB4lz1sXujDRwMeNopaNUqWSY4JmV7FIfPJA2
         /rSV/mzV6Qr2lqLOxxMsnQlIecookGuYmAFSsB6ER3RjZG6wjpYaD0xOT6eYhWGoPr2W
         jfnjXOjn77mnacLjdvpcRyJI1A52Nvi8MyoocTja1FThJpfIuIk7AkCds4Q24OqbJ+dj
         +NmLROlXCvBm7z1hkRKhdoLfhk7Zx/UJfVz3l0BfPvQ43cmWztE6Ggz+Y0V+s25cavCv
         GOKU9NUOplaBnCrUUfZEQk37SGNmRTeMbDsyATCeME/hwMiBl1R7Ovd7zkLL9KggSf3B
         b09Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712699229; x=1713304029;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+o+B5YhePemCqfLG1nDv/Zdx5bIr2DP7esNue6DPpZI=;
        b=KGJW3McbBz9JK/BXZCjsizB7CoJAsuWjji5VrCLm4nMLxhdnlPzflRKej73n2V0bSd
         qti8XeahLq0i2g99D3rBmok0llS7xfkXes9lKOPXzC7S1Sl5etSzGU73UG/zExjo7DsS
         Q9hj/N5ZD1ybgbzHEL2yRbo6RBIL2YJF1QEGE0NqmXSpssfoX5R9cNMJVgEwJU8PRSNz
         yHrFLmiA1Ivt8D76MQm9HgztwtgQCOsgKLgh+ZvfBkv7Es3q5FxSYfDVchwbu1q7pvQc
         dDfn0i5HLtOfVM7IHwhGik4jvHnVdOK00qF2pDmdZ2Px5YBG2ac4YbatJlTwlVOL/iJq
         SuHg==
X-Forwarded-Encrypted: i=1; AJvYcCXfoEhVxEQk/8bpHDoXTn6ewIQSOCbjraXKoTDwf7nQEKaEa2A/UhLr29eWYbY+8O0xNnePeYeHBRz6NuFya+OnySv7R1S+rr9KvYMJKAeLNCfJ33l8AD/tAl+OurjRaIWcOMV9pZMklPwlJyrk6Jv+JXqPDxEutcTA9eHTy3syG+j0ruCao0Ni3gGPb2dK
X-Gm-Message-State: AOJu0YwWRs+8MOv1f+haJJdrRjV9IuESNCEyUpcwbG1f8cDkqSyunCe9
	TAhLN0GOPp2Nj6h2YmdOvJsICuJ8MrSa/io/L+VvjTexUFlJhjFJ
X-Google-Smtp-Source: AGHT+IE0AXDZ7mxhBIKI2K2SwHTXzzxrPsmCVAkqpJSqBbHwVMwvEk7JTbahLXe3AbavTrD0Zc148Q==
X-Received: by 2002:a05:6a20:2591:b0:1a9:3287:9180 with SMTP id k17-20020a056a20259100b001a932879180mr1283441pzd.52.1712699228456;
        Tue, 09 Apr 2024 14:47:08 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:6c8c:a143:d391:6ace])
        by smtp.gmail.com with ESMTPSA id x23-20020a17090a165700b0029b59bf77b4sm76638pje.42.2024.04.09.14.47.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Apr 2024 14:47:08 -0700 (PDT)
Date: Tue, 9 Apr 2024 14:47:05 -0700
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
Message-ID: <ZhW3Wbn4YSGFBgfS@google.com>
References: <mpearson-lenovo@squebb.ca>
 <20240324210817.192033-1-mpearson-lenovo@squebb.ca>
 <20240324210817.192033-2-mpearson-lenovo@squebb.ca>
 <ZhR-WPx7dgKxziMb@google.com>
 <f3342c0b-fb31-4323-aede-7fb02192cf44@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f3342c0b-fb31-4323-aede-7fb02192cf44@redhat.com>

On Tue, Apr 09, 2024 at 03:23:52PM +1000, Peter Hutterer wrote:
> On 09/04/2024 09:31, Dmitry Torokhov wrote:
> > Hi Mark,
> > 
> > On Sun, Mar 24, 2024 at 05:07:58PM -0400, Mark Pearson wrote:
> > > Add support for new input events on Lenovo laptops that need exporting to
> > > user space.
> > > 
> > > Lenovo trackpoints are adding the ability to generate a doubletap event.
> > > Add a new keycode to allow this to be used by userspace.
> > 
> > What is the intended meaning of this keycode? How does it differ from
> > the driver sending BTN_LEFT press/release twice?
> > > 
> > > Lenovo support is using FN+N with Windows to collect needed details for
> > > support cases. Add a keycode so that we'll be able to provide similar
> > > support on Linux.
> > 
> > Is there a userspace consumer for this?
> 
> Funnily enough XKB has had a keysym for this for decades but it's not
> hooked up anywhere due to the way it's pointer keys accessibility
> feature was implemented. Theory is that most of userspace just needs
> to patch the various pieces together for the new evdev code + keysym,
> it's not really any different to handling a volume key (except this
> one needs to be assignable).

What is the keysym? If we can make them relatable to each other that
would be good. Or maybe we could find a matching usage from HID usage
tables...

Thanks.

-- 
Dmitry


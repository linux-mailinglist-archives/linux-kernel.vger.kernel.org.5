Return-Path: <linux-kernel+bounces-145819-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D4E88A5B50
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 21:48:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8FD3288036
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 19:48:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6277C15747B;
	Mon, 15 Apr 2024 19:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VfNJHtKd"
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3584F156C41;
	Mon, 15 Apr 2024 19:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713209743; cv=none; b=hzLE5LGuCmPOzOqJ1Hlt8yTmPIlgLvEMA+7NEQK7osjoBM5/gWYz/mSqdgnNqjhox3nJ4KleWv1AYOyR7yClimdzYXSFKK47Q7wHY8ohirmOMFNBfi2gbkWHTkBJ1Qh5Y2EtDk8+ksO7BRi1VicqPW5va9iufBtF3nQNrrpccFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713209743; c=relaxed/simple;
	bh=8EX9vmvsTGxNX9SVhHyJdmgIv/WnqRU21dYjDwHUtF8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EpwBxtcF2A1N9fI4kTUkakuGEjrPuq26srbTIMMF4kP+FfYTMHDLbc0n7wCI/hPQe/WihGIS1o5uZ1oZK0N7J3hNWPE0nx3uujk5OVo1MWmqMXwWA/lES8CqlW6wbpM8929kggO5cN6rhIE3qIrShlQ2iEM0eJWwFUaKbFeq/xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VfNJHtKd; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-5cddfe0cb64so1990508a12.0;
        Mon, 15 Apr 2024 12:35:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713209741; x=1713814541; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sd4qBFIurZa5789oJ4pvkqFdJ4TBJxMcpEKz1P+zoD0=;
        b=VfNJHtKdZzNq0qT03dOryB/36fl2YhvWuS3bFQlk85Mhh5MyPuwhHIbFJjcNqoKwH5
         MM9FQacihPkzwvJL09B2UsiRyABjEZ1g4T0mGPzoOATtCw+Wjm4v6GzHVj6mDVvtfmT6
         i1tbMxTCy6lE9fSMKhWwrBkvAX8PDuIyTUtONP6s0AmydgE2yuPH8XjTB1d4V0IHpMmA
         RNPRydbG55ffASmwOxQjqrVx8fdW8nm2g2wQ+lX09JKOwVRjNEErB3zyIhSKi7qT4vlY
         IQp1VxLVHaCZcim/PPg3du68YS+GYw3YJdXvTUp70Z6y3F98xZs1TrWURU6Aa97M9ZUI
         q6hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713209741; x=1713814541;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sd4qBFIurZa5789oJ4pvkqFdJ4TBJxMcpEKz1P+zoD0=;
        b=q68BpWwzSzwBNhXe5DKH9D23/R4x22DJTPFEgylAFdsn5na1PvHprPp1+X4TVOht/v
         Zjm1pIfWQU/w9XlShMO3a+HYs/Gm3idk5XNpcNI+NsCEuC6Yu4CR5SFl0QHEuaogll4d
         rzWARl78e4vQn3QN5Esny0GdUSMBb+J6N6qFV9LfzvvZCX1R4E94k/44dJB65UM35qC6
         Heg6K08bmCjgOL0kSh9mCy2l3cqugwCnNH1X2qENIibkAjfybLnjy/BCpePtI+Pys/6r
         HyyxG/pUrsn0NUM8ERgJnuvw8VmPpQ4RsoBMF8IPRLawYvTJCTp9fasySfdSfiYgMciW
         ZT5A==
X-Forwarded-Encrypted: i=1; AJvYcCUyQSCnvK71f9K6zqMmjflzlvYBgFtj+CcMsYAaqRMpQ9VP4P5Id+M9p/wXO/4ztDesSHgMK+aO8wt7xFL9UsuzXH2yIrQe9ANEdny/+uCIBoikWFu/7IHKs+/TdjSGzP7PWJvZsiwYyY9M18zVVmtodi7KXaXKtmYKe/B2kqTVuuqXhC/rFigxK8rLBMsq
X-Gm-Message-State: AOJu0Yw6oTT7EK4cqkOq4/HiJslfghyWfBkBxYgSh5ZQT4j2E60znFKD
	lt7L16V8TrJNuFXSKSjwM5QXPQ4z4vcCX9+O6sePvhwdKdmKmZVg
X-Google-Smtp-Source: AGHT+IFabnZRTyhqLVGYWMvVkqnmtYHiS7EWkfO/PgwPKxuTL3HJma9hI1ZyOLqgDvF7jruScYa42g==
X-Received: by 2002:a17:90a:c8e:b0:2a0:3dc3:8a8b with SMTP id v14-20020a17090a0c8e00b002a03dc38a8bmr7471492pja.47.1713209741258;
        Mon, 15 Apr 2024 12:35:41 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:fbbe:421b:9296:f28c])
        by smtp.gmail.com with ESMTPSA id y15-20020a17090a600f00b0029c49ed3974sm7383306pji.37.2024.04.15.12.35.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Apr 2024 12:35:40 -0700 (PDT)
Date: Mon, 15 Apr 2024 12:35:38 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Hans de Goede <hdegoede@redhat.com>
Cc: Mark Pearson <mpearson-lenovo@squebb.ca>,
	Peter Hutterer <peter.hutterer@redhat.com>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Henrique de Moraes Holschuh <hmh@hmh.eng.br>,
	ibm-acpi-devel@lists.sourceforge.net,
	"platform-driver-x86@vger.kernel.org" <platform-driver-x86@vger.kernel.org>,
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
	Nitin Joshi1 <njoshi1@lenovo.com>,
	Vishnu Sankar <vsankar@lenovo.com>
Subject: Re: [PATCH 1/4] Input: Add trackpoint doubletap and system debug
 info keycodes
Message-ID: <Zh2BiqQdM7_n-Ih4@google.com>
References: <mpearson-lenovo@squebb.ca>
 <20240324210817.192033-1-mpearson-lenovo@squebb.ca>
 <20240324210817.192033-2-mpearson-lenovo@squebb.ca>
 <ZhR-WPx7dgKxziMb@google.com>
 <f3342c0b-fb31-4323-aede-7fb02192cf44@redhat.com>
 <ZhW3Wbn4YSGFBgfS@google.com>
 <ZhXpZe1Gm5e4xP6r@google.com>
 <92ee5cb2-565e-413c-b968-81393a9211c4@app.fastmail.com>
 <ZhcogDESvZmUPEEf@google.com>
 <411e6353-16ef-455b-98fa-2d38bb7bf9bd@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <411e6353-16ef-455b-98fa-2d38bb7bf9bd@redhat.com>

On Thu, Apr 11, 2024 at 02:30:35PM +0200, Hans de Goede wrote:
> Hi Dmitry,
> 
> On 4/11/24 2:02 AM, Dmitry Torokhov wrote:
> > On Tue, Apr 09, 2024 at 10:17:05PM -0400, Mark Pearson wrote:
> >> Hi Dmitry
> >>
> >> On Tue, Apr 9, 2024, at 9:20 PM, Dmitry Torokhov wrote:
> >>> On Tue, Apr 09, 2024 at 02:47:05PM -0700, Dmitry Torokhov wrote:
> >>>> On Tue, Apr 09, 2024 at 03:23:52PM +1000, Peter Hutterer wrote:
> >>>>> On 09/04/2024 09:31, Dmitry Torokhov wrote:
> >>>>>> Hi Mark,
> >>>>>>
> >>>>>> On Sun, Mar 24, 2024 at 05:07:58PM -0400, Mark Pearson wrote:
> >>>>>>> Add support for new input events on Lenovo laptops that need exporting to
> >>>>>>> user space.
> >>>>>>>
> >>>>>>> Lenovo trackpoints are adding the ability to generate a doubletap event.
> >>>>>>> Add a new keycode to allow this to be used by userspace.
> >>>>>>
> >>>>>> What is the intended meaning of this keycode? How does it differ from
> >>>>>> the driver sending BTN_LEFT press/release twice?
> >>>>>>>
> >>>>>>> Lenovo support is using FN+N with Windows to collect needed details for
> >>>>>>> support cases. Add a keycode so that we'll be able to provide similar
> >>>>>>> support on Linux.
> >>>>>>
> >>>>>> Is there a userspace consumer for this?
> >>>>>
> >>>>> Funnily enough XKB has had a keysym for this for decades but it's not
> >>>>> hooked up anywhere due to the way it's pointer keys accessibility
> >>>>> feature was implemented. Theory is that most of userspace just needs
> >>>>> to patch the various pieces together for the new evdev code + keysym,
> >>>>> it's not really any different to handling a volume key (except this
> >>>>> one needs to be assignable).
> >>>>
> >>>> What is the keysym? If we can make them relatable to each other that
> >>>> would be good. Or maybe we could find a matching usage from HID usage
> >>>> tables...
> >>>
> >>> I was looking through the existing codes and I see:
> >>>
> >>> #define KEY_INFO		0x166	/* AL OEM Features/Tips/Tutorial */
> >>>
> >>> We also have KEY_VENDOR used in a few drivers/plafrom/x86, including
> >>> thinkkpad_acpi.c and I wonder if it would be suitable for this vendor
> >>> specific debug info collection application (which I honestly doubt will
> >>> materialize).
> >>>
> >>
> >> That's a somewhat disappointing note on your doubts, is that based on
> >> anything? Just wondering what we've done to deserve that criticism.
> > 
> > Sorry, this was not meant as a criticism really, but you mentioned
> > yourself that there isn't anything in the works yet, you just have some
> > plans.
> > 
> > For such a project to succeed Lenovo needs to invest into selling
> > devices with Linux as a primary operating system, and it has to be
> > consumer segment (or small business, because for corporate they
> > typically roll their own support channels). The case of retrofitting
> > Linux onto a that device originally came with Windows OS rarely gets
> > much if any response from the normal support channels.
> > 
> > Is this something that is actually happening?
> 
> Yes, Lenovo is actually offering Fedora as an OS choice when
> ordering ThinkPads directly from their website in many countries
> including when ordering as a consumer.

Ah, very nice, I was not aware of this.

> 
> And unlike other vendor's Linux preloads which often use a kernel
> with downstream laptop specific changes these laptops are running
> unmodified Fedora kernels, which themselves are almost pristine
> upstream kernels.
> 
> Lenovo (Mark) has been really good the last couple of years in
> making sure that their hw just works with mainline kernels without
> any downstream vendor specific patches.
> 
> >> That aside, I guess KEY_INFO or KEY_VENDOR could be a good fit (I
> >> personally don't think KEY_CONFIG matches well), but I would be
> >> worried about clashing with existing functionality.
> 
> Using KEY_INFO / KEY_VENDOR works for me too. So maybe we should
> just go with one of those 2 ?

It looks like Mark's preference is KEY_VENDOR, so let's go with it?

Thanks.

-- 
Dmitry


Return-Path: <linux-kernel+bounces-145852-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 924FB8A5BD6
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 21:57:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B50431C2141A
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 19:57:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31EF11591F5;
	Mon, 15 Apr 2024 19:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EauUdL+g"
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C730615885D;
	Mon, 15 Apr 2024 19:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713210925; cv=none; b=hRJbSeYtVjr7eak2JM1cdGIs/20SC3bqtc1jp+kXvqZVsGBPN4IMb+nxt86ikl5Y6ccDIDvsPF3brRMeUsHMroXHkhrr96DaJoVFvaJhuwnBxbyqWEBDOy2Ee2QYVCR46JQUxTYU3BZv6ZtR7lfp6pNTIKqw4R5YN6EuQSaIm2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713210925; c=relaxed/simple;
	bh=ARAOqrIDibtoeRNfze5y9nA4xxZwROTg7nQXiXeve8g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QVZn2ZzupaJ12qV1d7+vE76ux5i2yYFmLWMlFo0KDXj19d91XYLAk5dr1oYnQt6KleSKZP/4IunFGEYOT3JG79mqXGC0QHwFkLF37Jtu/rm1qpbcY8EOaxRGK6JHIYON2i1BNeJmSBp40gLt4eD0nyFZ6FQjyYdDiZlYDwNi1C4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EauUdL+g; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-61804067da0so37023207b3.0;
        Mon, 15 Apr 2024 12:55:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713210923; x=1713815723; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=C1pl77BkD4En2MiZRh8WnQAXld8tFBoXMAu8EB3HVBc=;
        b=EauUdL+gxXQkLAvmKANIh0HxUVyA2wqC+Y8vfwPiNZLNaNuqHruetC2NxccWIrRal1
         YvsJbSD18blO/zZnKhx/d22afbTElMhCuE1PaIBU5PH9ei4dQt3InMrxIsxL5kXlX/I8
         ShSQyKYKizQ8ZQfqvWhJS1lEZJDoDcPvWesF7w+c/HvZElpPptP2ln3IGM5FG09MZ7SI
         0kQul5iyuA1MFk+FDvwhevgMBWQXN946Tn7ecVLLuWdS9rlX71Xm83Y26xYqgoN+TVdt
         +76OSmLb/i3ZmIdpwySfKPrgWqdZ69jJp/yOPRJAb/psIZdf4dWecAyxwwtqAXCoLLkK
         xALw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713210923; x=1713815723;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C1pl77BkD4En2MiZRh8WnQAXld8tFBoXMAu8EB3HVBc=;
        b=EgM77fA0pEjF12o+pbsE88W/fPxWefWpN9vQCWPSWJTHEN3AU9xevpkCq5wUvNoa+L
         lJDHhHYytpjNPkUSFDafO6SXkQheGkZn7swg6dUk1khu/ceVtkDcc7VjGk9DiLZ9qr4h
         yoaLQJrdQa8BXCINbeMP6WShqvcT2Dvu5R4/PL86Utbik0JGiysT/m6GmQJvKEzFEB1U
         y4h8sZzzmShVUvtKSvNxLI6f6TRxXG1SjuBHLv3029BTZ+2Yyk1TgW/wqfFotulyzHSg
         RCDNPXVk83ds9zublokbInXCH8rUPXBg0zxlNuMxdgKc9YNNNA+UafY34gziGGxQi0Ne
         HFoA==
X-Forwarded-Encrypted: i=1; AJvYcCW/4pO0SxH+UhgLLNprEam4QXo0yu5RXmGcANDGcew+/C69jGNJL2nOXD4RKbSd81FMPzDlnlRc1WsTvm4zYXZuockE4DgKH9dGiVHsXf/hwraj7bjAhJXP6MlLwRsZbOyKx7q8ci0LAIbBmKNs8eN1tNv8JEyhMu1rvncpjaMapQaMc7HFbj6M5vttrzgX
X-Gm-Message-State: AOJu0Yxx3kZYY7s17RlTVsoT4W7Wzf14sz8Hyku7KzrpjvAIAQfl5dQW
	cIt65kkxfcSQ7yppahF1kpLeN0KYQ6VEOyFw+TZoLGxOeuRa+8Ui
X-Google-Smtp-Source: AGHT+IERCVnlJIMh4ivcoxOfXGoxhmge+g0KbXB8gsJiO9uDfwAdGUEnPwvVQ5uMCzumWCx10dtO+Q==
X-Received: by 2002:a25:848c:0:b0:dcc:f2a4:153e with SMTP id v12-20020a25848c000000b00dccf2a4153emr10642256ybk.46.1713210922427;
        Mon, 15 Apr 2024 12:55:22 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:fbbe:421b:9296:f28c])
        by smtp.gmail.com with ESMTPSA id u1-20020a25c401000000b00dcd56356c80sm2188395ybf.47.2024.04.15.12.55.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Apr 2024 12:55:22 -0700 (PDT)
Date: Mon, 15 Apr 2024 12:55:18 -0700
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
Message-ID: <Zh2GJmbHBbPxwztX@google.com>
References: <20240324210817.192033-2-mpearson-lenovo@squebb.ca>
 <ZhR-WPx7dgKxziMb@google.com>
 <f3342c0b-fb31-4323-aede-7fb02192cf44@redhat.com>
 <ZhW3Wbn4YSGFBgfS@google.com>
 <ZhXpZe1Gm5e4xP6r@google.com>
 <92ee5cb2-565e-413c-b968-81393a9211c4@app.fastmail.com>
 <ZhcogDESvZmUPEEf@google.com>
 <411e6353-16ef-455b-98fa-2d38bb7bf9bd@redhat.com>
 <Zh2BiqQdM7_n-Ih4@google.com>
 <15507b66-723d-443c-aaae-c0097d16ef0a@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15507b66-723d-443c-aaae-c0097d16ef0a@redhat.com>

On Mon, Apr 15, 2024 at 09:47:10PM +0200, Hans de Goede wrote:
> Hi,
> 
> On 4/15/24 9:35 PM, Dmitry Torokhov wrote:
> > On Thu, Apr 11, 2024 at 02:30:35PM +0200, Hans de Goede wrote:
> >> Hi Dmitry,
> >>
> >> On 4/11/24 2:02 AM, Dmitry Torokhov wrote:
> >>> On Tue, Apr 09, 2024 at 10:17:05PM -0400, Mark Pearson wrote:
> >>>> Hi Dmitry
> >>>>
> >>>> On Tue, Apr 9, 2024, at 9:20 PM, Dmitry Torokhov wrote:
> >>>>> On Tue, Apr 09, 2024 at 02:47:05PM -0700, Dmitry Torokhov wrote:
> >>>>>> On Tue, Apr 09, 2024 at 03:23:52PM +1000, Peter Hutterer wrote:
> >>>>>>> On 09/04/2024 09:31, Dmitry Torokhov wrote:
> >>>>>>>> Hi Mark,
> >>>>>>>>
> >>>>>>>> On Sun, Mar 24, 2024 at 05:07:58PM -0400, Mark Pearson wrote:
> >>>>>>>>> Add support for new input events on Lenovo laptops that need exporting to
> >>>>>>>>> user space.
> >>>>>>>>>
> >>>>>>>>> Lenovo trackpoints are adding the ability to generate a doubletap event.
> >>>>>>>>> Add a new keycode to allow this to be used by userspace.
> >>>>>>>>
> >>>>>>>> What is the intended meaning of this keycode? How does it differ from
> >>>>>>>> the driver sending BTN_LEFT press/release twice?
> >>>>>>>>>
> >>>>>>>>> Lenovo support is using FN+N with Windows to collect needed details for
> >>>>>>>>> support cases. Add a keycode so that we'll be able to provide similar
> >>>>>>>>> support on Linux.
> >>>>>>>>
> >>>>>>>> Is there a userspace consumer for this?
> >>>>>>>
> >>>>>>> Funnily enough XKB has had a keysym for this for decades but it's not
> >>>>>>> hooked up anywhere due to the way it's pointer keys accessibility
> >>>>>>> feature was implemented. Theory is that most of userspace just needs
> >>>>>>> to patch the various pieces together for the new evdev code + keysym,
> >>>>>>> it's not really any different to handling a volume key (except this
> >>>>>>> one needs to be assignable).
> >>>>>>
> >>>>>> What is the keysym? If we can make them relatable to each other that
> >>>>>> would be good. Or maybe we could find a matching usage from HID usage
> >>>>>> tables...
> >>>>>
> >>>>> I was looking through the existing codes and I see:
> >>>>>
> >>>>> #define KEY_INFO		0x166	/* AL OEM Features/Tips/Tutorial */
> >>>>>
> >>>>> We also have KEY_VENDOR used in a few drivers/plafrom/x86, including
> >>>>> thinkkpad_acpi.c and I wonder if it would be suitable for this vendor
> >>>>> specific debug info collection application (which I honestly doubt will
> >>>>> materialize).
> >>>>>
> >>>>
> >>>> That's a somewhat disappointing note on your doubts, is that based on
> >>>> anything? Just wondering what we've done to deserve that criticism.
> >>>
> >>> Sorry, this was not meant as a criticism really, but you mentioned
> >>> yourself that there isn't anything in the works yet, you just have some
> >>> plans.
> >>>
> >>> For such a project to succeed Lenovo needs to invest into selling
> >>> devices with Linux as a primary operating system, and it has to be
> >>> consumer segment (or small business, because for corporate they
> >>> typically roll their own support channels). The case of retrofitting
> >>> Linux onto a that device originally came with Windows OS rarely gets
> >>> much if any response from the normal support channels.
> >>>
> >>> Is this something that is actually happening?
> >>
> >> Yes, Lenovo is actually offering Fedora as an OS choice when
> >> ordering ThinkPads directly from their website in many countries
> >> including when ordering as a consumer.
> > 
> > Ah, very nice, I was not aware of this.
> > 
> >>
> >> And unlike other vendor's Linux preloads which often use a kernel
> >> with downstream laptop specific changes these laptops are running
> >> unmodified Fedora kernels, which themselves are almost pristine
> >> upstream kernels.
> >>
> >> Lenovo (Mark) has been really good the last couple of years in
> >> making sure that their hw just works with mainline kernels without
> >> any downstream vendor specific patches.
> >>
> >>>> That aside, I guess KEY_INFO or KEY_VENDOR could be a good fit (I
> >>>> personally don't think KEY_CONFIG matches well), but I would be
> >>>> worried about clashing with existing functionality.
> >>
> >> Using KEY_INFO / KEY_VENDOR works for me too. So maybe we should
> >> just go with one of those 2 ?
> > 
> > It looks like Mark's preference is KEY_VENDOR, so let's go with it?
> 
> Ack KEY_VENDOR sounds good to me for the doubletap on the trackpoint event.
> 
> What about the new Fn + N keycombo which also generates a WMI
> event which we want to translate to a key code to launch a
> (to be written) debug-info collecting app for when the customer
> calls Lenovo support.
> 
> Mark suggested a new KEY_SYS_DEBUG_INFO for that. So do we use:
> 
> #define KEY_INFO                0x166   /* AL OEM Features/Tips/Tutorial */
> 
> for this, or do we define a new keycode ?
> 
> Mark would using KEY_INFO for this work for you.
> 
> Dmitry any opinion on this ?

No, my understanding is that Mark was OK with using KEY_VENDOR for Fn+N
combination that is supposed to start the utility that would collect
the debug info.

For double click there is still the discussion whether to have
KEY_DOUBLECLICK (which I think will need to be tied to the pointer
device somehow), or something else, like KEY_CONFIG or a new keycode if
we continue keeping it separate from the pointer operations and match
Windows behavior which invokes Lenovo configuration utility.

Thanks.

-- 
Dmitry


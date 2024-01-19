Return-Path: <linux-kernel+bounces-30884-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CE0983257A
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 09:13:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9DFE4B2243A
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 08:13:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61D03125C1;
	Fri, 19 Jan 2024 08:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xo0hVXfL"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CC57DDAB;
	Fri, 19 Jan 2024 08:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705652015; cv=none; b=Hax2w9lbPDaEosNd4KaIx37ZFuWd7ebaXFMUIKrpw4rGqT0oNzkIydi3MDiO+jDbixZy1+YdSZ/W8ZkcSgLHiz8bLMvZf/qRjOWkT1/eiKAiLdS+gADm0ZIJJuLx4aSXPNFbBYhu8Fz5aTmqtJeHiRYSqO7FMplFdYV+BrcMNpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705652015; c=relaxed/simple;
	bh=UahqVqM3JBOxpq4zFQmkBUy5zu7nEiUADTkUEncGEdU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jnl88t4tuIPnM5YjVN4l/DtA3NB+4J5YDoPJ8Um0aTuFDKnCAcYiZmTftB8C5bzh4PurZGDvlUh1BTh8M/YGi6+l4df+16z5oOU6mhgI7W6kkA3eubHAeZn/pmYPnnvYzpCC7eNRj6X6DqeH9Me/VfiOdPso9v+7AcMJXB6YHPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xo0hVXfL; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1d5cdb4a444so4191765ad.1;
        Fri, 19 Jan 2024 00:13:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705652014; x=1706256814; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=bWIUa8grGZ6qMtkdYnja/ujmQxTTZOY4hekmMuMez50=;
        b=Xo0hVXfL0KklpTbDoFTtBOeJlZUCPOfs384DhmvNakMGTl3k7KJJGhMWXveGGJRHKV
         B0CmMcgyXuh5qJ+x7kXUvd58QFIOzSOozCe3D9+Y38AdO1Gi1NTm8BT0wfrSM2XNiYdq
         XnDNNA2sMgvvh25saEc7CjhUbi/VC2oWxEj8dBjN97IXFSqqZNJtLAkshB/Dbxz+jYr8
         tYcJtm2cn5ztkX/mkkoHJtEOZ0n1dlIb4b3bBXoPguiOib/UJfsjf1oDAfN9A26WCk7Y
         lrhspZ1wynAJiHrtlc0y4lWNmvtZfHfJIwgfM1HRbTgQiI1zrZ6+2bVquen6cxSMNfWq
         KtjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705652014; x=1706256814;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bWIUa8grGZ6qMtkdYnja/ujmQxTTZOY4hekmMuMez50=;
        b=o22pPk/gp+0r30Ds8VbMCCDp3Rmhjr44UCzoXWfrX0ZUzriNEyDSzoO8U+B5rU6cR4
         s7DO5U+vomCpX31cb6mhlMrhVai9f/N4bxC+ovK00dZVp+YmarJnKxSJ0xlOqanZ1D4h
         zva/+4aRSvTzJui5POjGBd2odO/FMzT4v1LgjfHCSXuAevS2RtgEg4NzAxCZla4BNJYy
         ft0lXsQ7/jug2HcisLn+ZvRhdPbP3SAUyKpEF978ZS4GMp+O9XVkb+wmXMmckNALQ75z
         sj7JNpdeFoxGhYWA/M9zevoMfX0W9myRqaUKGqe5kwYwTxAJDW1ovuCHyrF1RE3Sl1yc
         mQRw==
X-Gm-Message-State: AOJu0Ywoit8APgjfeBaJ/OoZ813arZRJgC1hExxgJ71bnYlLiCd6AQjT
	+po5l1Kn6TVxq9V6RRpvpgP2JuqcSnogBiSvteq4W1vHtUZNg1UvJbtEiUmT
X-Google-Smtp-Source: AGHT+IGwPP+nORDZfwLHv8lo1KAHyYWdbUn5sfvkZ9EhS2YXheyZqZsey8KcJ1nmwbtVODOGlBdoEw==
X-Received: by 2002:a17:903:244d:b0:1d4:e0e:fa1b with SMTP id l13-20020a170903244d00b001d40e0efa1bmr2706430pls.57.1705652013703;
        Fri, 19 Jan 2024 00:13:33 -0800 (PST)
Received: from google.com ([2620:15c:9d:2:f04f:73f4:b79:a70c])
        by smtp.gmail.com with ESMTPSA id w6-20020a170902d3c600b001d71356f16asm490167plb.289.2024.01.19.00.13.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jan 2024 00:13:33 -0800 (PST)
Date: Fri, 19 Jan 2024 00:13:30 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: =?utf-8?B?4piG4piF4piGIFRpbmcg4piG4piF4piG?= Shen <phoenixshen@google.com>
Cc: Ting Shen <phoenixshen@chromium.org>,
	LKML <linux-kernel@vger.kernel.org>, fshao@chromium.org,
	Benson Leung <bleung@chromium.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Guenter Roeck <groeck@chromium.org>,
	Tzung-Bi Shih <tzungbi@kernel.org>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
	chrome-platform@lists.linux.dev,
	joewu =?utf-8?B?KOWQs+S7suaMryk=?= <joewu@msi.com>,
	linux-input@vger.kernel.org
Subject: Re: [PATCH] Input: cros_ec_keyb: add support for base attached event
Message-ID: <ZaovKvmhEsEO41ti@google.com>
References: <20240118085310.1139545-1-phoenixshen@google.com>
 <ZalmGi_Zlm9HLoBy@google.com>
 <CAM106_uNOrpiovEuuyr2yUGXFpQqAiE_GQRFh2_j7v58cEvWbw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAM106_uNOrpiovEuuyr2yUGXFpQqAiE_GQRFh2_j7v58cEvWbw@mail.gmail.com>

On Fri, Jan 19, 2024 at 03:47:32PM +0800, ☆★☆ Ting ☆★☆ Shen wrote:
> On Fri, Jan 19, 2024 at 1:55 AM Dmitry Torokhov <dmitry.torokhov@gmail.com>
> wrote:
> 
> > Hi Ting,
> >
> > On Thu, Jan 18, 2024 at 04:52:43PM +0800, Ting Shen wrote:
> > > This CL maps ChromeOS EC's BASE_ATTACHED event to SW_DOCK,
> >
> > As far as I know none of the Chrome OS devices support classic docking
> > station (not talking about the new USB-C/TB ones).
> >
> > > to allow userspace detect that a keyboard is attached to the
> > > detachable device.
> >
> > Are we planning to have detachable keyboard that is not USB?
> >
> Yes this is for a non-USB keyboard. The keyboard is connected to EC, and EC
> forwards input events to the host.
> 
> >
> > EC_MKBP_BASE_ATTACHED is processed by hid-google-hammer driver and,
> > together with the USB connector state, is used to form SW_TABLET_MODE.
> > The reason just the USB state was not enough is because the keyboard
> > could be attached to the lid "other way around" to be used as a stand.
> > In that configuration USB connection was not active. However userspace
> > still needed to know about this to activate tablet version of the UI.
> >
> > Please provide more information why you want this to be exposed via
> > cros_ec_keyb driver.
> >
> > Thanks.
> >
> 
> The main purpose of this patch is to have some signal to trigger the
> firmware updater (hammerd), EC_MKBP_BASE_ATTACHED seems suitable.
> EC_MKBP_TABLET_MODE is also usable but may be too noisy, it fires whenever
> the user flips the keyboard.

I think this can be solved in userspace. You may consider emitting
uevent when seeing EC_MKBP_BASE_ATTACHED from the EC. SW_DOCK input event
is not really suitable here as it indicated a docking station being
attached.

Thanks.

-- 
Dmitry


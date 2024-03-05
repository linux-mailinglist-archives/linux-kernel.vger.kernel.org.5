Return-Path: <linux-kernel+bounces-91486-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C862F87123F
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 02:15:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6959DB21369
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 01:15:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A749125DC;
	Tue,  5 Mar 2024 01:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fJTNe2Gu"
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75F58111A5;
	Tue,  5 Mar 2024 01:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709601344; cv=none; b=sQlH6YiaOdP/sEjnk7Zx6/mDjBbrYiiI2LwlRXNPnLYDE9MshLQIbhm4mZhzt/5YYMegCGO0e3c9734p1znWda5CHEVrlEcOVVuooeAyDu4gBVzeJ3aLeV3ultTLpSfcSDBJjRGX1Pm5Vz8WbKDPzWCvHCMV2hgiLZ3fNl4CJl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709601344; c=relaxed/simple;
	bh=rNYrYnUDeiQThIlOLf7GZzdLyTpjLYQxAmN0MpVAUGQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KzJvpzv/V3rHtGj2aJUC6OPGR1L5Aa17Wxrgpl/ZMcst+GoMTNPqs4Mmy+TfAWh9kjtmfD6+i3NQz4u76I/fIvsd89qVBg7FegnlYzPdeMqBus8kRgKwHeG59GZ3oQofNqVQXmXPSzZnipIafapQ5o0I1h+DR4X5Z9CTQUUcryA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fJTNe2Gu; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-5e4b775e1d6so1658487a12.1;
        Mon, 04 Mar 2024 17:15:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709601342; x=1710206142; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=a97puSPee8NDveftoKysQGZs9RYm6VyTGxwyRsunH+Y=;
        b=fJTNe2Gub27MurvKcTXhyF1QFNQQodU+fu9T+cxVNmcVr0ZGwHN7vKgI3GZFs3QPRn
         8gzFd0Wqw/A63jkpXVCHU0Pg1rA/WSzlCDder89OAXwz2wcdbIPym6HrfDhhEjg4j4dD
         QDGzlnBhxSt41ocP3TceN5KDiCTFiuMsZPLyIMk1wB7e/8hW154+/sS50f80vVT+LYlw
         AewTiOr13/hnOBqaOV3AF0Q+ZwYVap/B2smBMULkS1VstT3uSiSP4NSY2o9SKeq0Gcki
         djHloygETtD9KTvOB3ftF2K46/mQgRkoec/+lwTyW5Sr9kIQS4kADiK5dyV3sD7CLiYI
         2cOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709601342; x=1710206142;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a97puSPee8NDveftoKysQGZs9RYm6VyTGxwyRsunH+Y=;
        b=B+7Kzc6de6fBRAi8ZB75AA6xY64fhK37XsJFX4yvmn1KLpLNE1AN48AAUNZ1SZUw+o
         vb62cxbmCTQv99SIbstBrJZ9ucjeDZjT1fD1B2h0nu97BaedD8ZI/9VuqRDf2wo9iZJL
         WPok+0uxyooYiUMbRJ0lYcyEBr/YioMrQZ0lN42YYK9QTUpJLwYCInf6EVshmkvI6AUk
         mLS2jf8xg5FfEAUiEaQVXpM3eiTlUu+PMbPM7LC2Kq9nNx4jAOyCPTyYL97ykT2JKunL
         fsFmr2JP73lR2iQgdIm1gpnIRWhIh75Yvq2OA5o3o0+EGMv/Os3TJBZI6C+N2eRQxOWB
         ERAQ==
X-Forwarded-Encrypted: i=1; AJvYcCUQj8bJcdax/i8Lhwc3BJA3cDpKybJlGu0Iko26B4fVGXOIiT57zSBcGKUjo9I5roC2O/CyjAMFYZySzD+/LX6dfNgzOz5U1bo4QSTMdGxUbyQbrCQL+OC/eIm+N/N5kPTrUoEqGXj0qnk=
X-Gm-Message-State: AOJu0Yz9jI6X7P6ux6hUQwfdn+qsVSqtEJbYIqXlOM3xzXQBH5jQ11Dr
	ypIvjdti8L9PRnab/+ND/KlPzqr+1CI9OITlIHWDUsjwNaWzH1bl
X-Google-Smtp-Source: AGHT+IGf/n6nOjCwoUrmBtzH0Ck54FjovaK9aQfF83w1GFO/2lpWpRKOz6N0/J/WgsAWRf4Tx45MzQ==
X-Received: by 2002:a17:90a:9601:b0:29b:9e1:2fb0 with SMTP id v1-20020a17090a960100b0029b09e12fb0mr1416148pjo.0.1709601342390;
        Mon, 04 Mar 2024 17:15:42 -0800 (PST)
Received: from google.com ([2620:15c:9d:2:a5d5:fe74:fba8:86b5])
        by smtp.gmail.com with ESMTPSA id p4-20020a17090b010400b0029af35db43csm8520610pjz.43.2024.03.04.17.15.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 17:15:42 -0800 (PST)
Date: Mon, 4 Mar 2024 17:15:39 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>,
	Javier Carrasco <javier.carrasco@wolfvision.net>,
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
	regressions@lists.linux.dev, Henrik Rydberg <rydberg@euromail.se>,
	John Horan <knasher@gmail.com>
Subject: Re: [REGRESSION] Missing bcm5974 touchpad on Macbooks
Message-ID: <ZeZyO7RUGyC8BRKP@google.com>
References: <87sf161jjc.wl-tiwai@suse.de>
 <6ef6c5bf-e6e5-4711-81c6-6ae41de2e61e@wolfvision.net>
 <874jdm17yt.wl-tiwai@suse.de>
 <449417ca-aae1-4868-a96f-a99ac5d187d6@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <449417ca-aae1-4868-a96f-a99ac5d187d6@gmail.com>

On Mon, Mar 04, 2024 at 09:21:19PM +0100, Javier Carrasco wrote:
> 
> There is indeed an interrupt endpoint with address 0x81, but the driver
> defines bInterfaceProtocol = 2 (Mouse), and the endpoint in that
> interface is 0x84:
> 
> #define BCM5974_DEVICE(prod) {					\
> 	.match_flags = (USB_DEVICE_ID_MATCH_DEVICE |		\
> 			USB_DEVICE_ID_MATCH_INT_CLASS |		\
> 			USB_DEVICE_ID_MATCH_INT_PROTOCOL),	\
> 	.idVendor = USB_VENDOR_ID_APPLE,			\
> 	.idProduct = (prod),					\
> 	.bInterfaceClass = USB_INTERFACE_CLASS_HID,		\
> 	.bInterfaceProtocol = USB_INTERFACE_PROTOCOL_MOUSE	\
> }
> 
> where USB_INTERFACE_PROTOCOL_MOUSE = 2.
> 
> 
> My interpretation is that the driver is checking if the endpoint with
> address 0x81 form the interface with bInterfaceProtocol = 2 (that is the
> last interface of the list, the one with bInterfaceNumber = 2), but it
> is not found, because its only endpoint has a different address (0x84).
> 
> Interestingly, 0x84 is the address given to the endpoint of the button
> interface. The button interface should not be relevant for Macbook 5,1
> (TYPE 2 in the driver), according to 43f482b48d03 ("Input: bcm5974 -
> only setup button urb for TYPE1 devices").
> 
> If that is true, does anyone know why bInterfaceProtocol is always set
> to USB_INTERFACE_PROTOCOL_MOUSE, and why the driver works anyway with
> bEndpointAddress = 0x81 for the trackpad? The urb setup for 0x84 is only
> executed for TYPE 1 devices, and the mouse interface does not have an
> endpoint with address 0x81. Or am I missing something?

The driver is naughty, it binds to the 3rd interface (bInterfaceNumber
2) but actually pokes into the 2nd interface with endpoint 0x84 without
actually claiming it. Your check expects that the endpoint belongs to
the interface that the driver binds to and thus fails.

> 
> We could revert the patch in question, but I see no reason why checking
> an expected interrupt endpoint should cause trouble. It looks like there
> is something fishy going on.

Yes, the driver needs to claim both interfaces and when checking use the
right one. I will revert the patch for now given that it causes
regression and we can try fixing it again.

Thanks.

-- 
Dmitry


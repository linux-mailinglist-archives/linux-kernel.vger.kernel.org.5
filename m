Return-Path: <linux-kernel+bounces-98117-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 308FF877552
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 05:53:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 53071B21BAE
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 04:53:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 656891118E;
	Sun, 10 Mar 2024 04:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AusT9Wk4"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33E0525601;
	Sun, 10 Mar 2024 04:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710046348; cv=none; b=gQwlq0Y9tiTMZg4yYzXSLLHm8am1MBu7CBViMPsQRpZa9aqBCmtcPPpRNacWLMLlLjUg1LhWqgYQ7ZVLLPAjsKso9TcAjyz77CmZtAJQdILxKouFWHQEf+r41P7WraCdnK8Wtfbej/O0TD8255BJz0es+Lz18lh/bpWX9LvEcAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710046348; c=relaxed/simple;
	bh=Sn6sR3bYWe6Nd/XuPwoEl1cdtJZl2cYMod8tFFFbuSQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rwbLHyuGfgZrIkD0QHgu4em30BjAAKnyC2NmT8jHBPEdKGVmV/Gt3YPADrEyiKEdt4oGBlYtq7CpkOJ7M922JBkMcDpFw68hLKdbnBuCUpEnwrmpDuSLgfeGvMj5oaE7/VYUBXns7iGtTVZHk8fQQDBc7Dfu9ur8MjgsJ3Cy39s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AusT9Wk4; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1dd5df90170so22082635ad.0;
        Sat, 09 Mar 2024 20:52:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710046346; x=1710651146; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=aHIvcn7AWPBiXWsyJb6YwJ3JRVnwhyEpRx+UlxGbkis=;
        b=AusT9Wk4GrSKeW7uxwXn9hvvuWIxhyZpjkNBErHcqm2PxCdhRiNI+D8KNCNrsyJL2F
         Lrw80KEvA086kXY3JxaPflYQAPeVKY2hr4YIfIkw/vGih0R1h9xkKk7cXCo3nTVb9yO9
         1W55tKoesyqgS/PNnlkzF0ckhyxHMiB03IOHo5LCxvRlDm9jLKCnXV/371ydlrRCqZ24
         fAUPV/is//sLOwA14DiS6ZrhIUzXNdkE2s0ga0uD8YW+NrfqqnGMiGPBugUePOXAiJme
         GHUHgbEhZKXR547UCPhGj8/wLvQE1Q0VY21w58Y1ZStiOWOBTZz1jvGNVIb7zYFcw1TP
         jSlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710046346; x=1710651146;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aHIvcn7AWPBiXWsyJb6YwJ3JRVnwhyEpRx+UlxGbkis=;
        b=JOdKlPTf6FqCJrzp29/qexggjvxuiTc9L24eVn2Pp9SVZyw3IcODzNGVqXc2CHeqwO
         MfrXbUvLVOf6aRmmUqnathfgC1sgOWXS83J6diOoHzHKRktHCjZtBqL2wh1WIbcR0KRy
         hA2U7j7Fcj39a5ELt36ByNQREEQpje1CKfs9geMoQcL1+qubdsIZPdeLI34iub7XjShO
         nwISkjY/gcucoLK/g8+hx7fOMetmGKTFILXs1xJ4/66StbWhAWGoclaxKfz627Q/Az9F
         Dq7nmjuhGeVIfpXmvr5jrzfRmsQ7hUW5SbeK6d7RuAZWCvJDunlJvBzM6QeHKciltf6N
         zqfQ==
X-Forwarded-Encrypted: i=1; AJvYcCUFRymvhO5ugBPMpBeDHzHr9v47hrdNviHRO+EfWIIJNk3y3IodSsTT183FudR+0+lCHrVxCTPRSgyK8ZP2Xytv0FiMf4/hJfR+agALe7ZRniwPHLmBOgC2N3v1u9yfvzG8PqSZuF9ip4YXEhvb3jAYRIhjMhl/y8Dkt3S9ujVrz0Ti6RB5cl/Nk54yiRNJ
X-Gm-Message-State: AOJu0Yzf/uXtL9dshPVGx1g+92VyNmOms12EdEHhhmdmSD5nMEa4SRfP
	FD4Qlfc9fvW+S2YCz5qQI7x+0mJdL2nwbdaiXi7y5OIOQbcOHX3p
X-Google-Smtp-Source: AGHT+IHPmIUFExhU5+iMgA2v1/ZxLA9FJn0c+62vsv8uXlWeSO5qOHy3iiJHLoSbarcfOZGEE7qfwQ==
X-Received: by 2002:a17:902:c94f:b0:1dd:66e6:ec81 with SMTP id i15-20020a170902c94f00b001dd66e6ec81mr4534285pla.18.1710046346342;
        Sat, 09 Mar 2024 20:52:26 -0800 (PST)
Received: from google.com ([2620:15c:9d:2:5296:fec3:1fa8:a601])
        by smtp.gmail.com with ESMTPSA id q21-20020a170902c75500b001dc96b19616sm2077531plq.66.2024.03.09.20.52.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Mar 2024 20:52:25 -0800 (PST)
Date: Sat, 9 Mar 2024 20:52:23 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Armin Wolf <W_Armin@gmx.de>
Cc: =?utf-8?B?6Im+6LaF?= <aichao@kylinos.cn>,
	hdegoede <hdegoede@redhat.com>,
	"ilpo.jarvinen" <ilpo.jarvinen@linux.intel.com>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	platform-driver-x86 <platform-driver-x86@vger.kernel.org>,
	linux-input@vger.kernel.org
Subject: Re: [PATCH v5] platform/x86: add lenovo wmi camera button driver
Message-ID: <Ze08hwqt9fNMFQa8@google.com>
References: <1vk29ojvhrf-1vk4tk6plf0@nsmail7.0.0--kylin--1>
 <c07dedf3-175c-4748-b6d3-e1effe9cad41@gmx.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c07dedf3-175c-4748-b6d3-e1effe9cad41@gmx.de>

On Fri, Mar 08, 2024 at 05:15:48PM +0100, Armin Wolf wrote:
> Am 08.03.24 um 09:40 schrieb 艾超:
> 
> > Hi
> > 
> >     thanks for your help.
> > 
> > > Is there a way to determine the current state of the camera switch
> > without having
> > > to wait for an WMI event?
> > 
> > There is no other way to detemine the current state of the camera
> > switch without
> > 
> > a WMI event.
> > 
> > 
> > > If its not possible to determine the current state of the camera
> > switch, then your
> > > driver has to defer the initialization of the input device until it
> > knows the current
> > > state of the camera switch. Otherwise the initial switch state
> > reported by the
> > > input device might be wrong.
> > 
> > > In this case, that means your driver must initialize the input
> > device when receiving
> > > a valid WMI event for the first time.
> > 
> > > Basically when your driver receives a WMI event, it has to check if
> > the input device
> > > is already initialized. If this is not the case, then the input
> > device is initialized.
> > > Please protect this check and the input device initialization with a
> > mutex, since WMI
> > > event handling is multithreaded.
> > 
> > 
> > This Camera is a UVC device, and the Carema device is already
> > initialized before the WMI
> > 
> > event .  Whether the camera switch is on or off, we can used lsusb to
> > check the Camera.

It depends on which drivers are built-in and which are modules. The fact
that on one distribution WMI happens to enumerate after PCI/USB is just
a stroke of luck.

> > 
> > This wmi-camera driver only need to report the current state of the
> > camera switch.
> > 
> > 
> > Thanks.
> > 
> >     Ai Chao
> > 
> I see, so userspace will notice when the camera is disabled. Since the camera disappears from
> the USB bus when the switch is activated, i wonder if SW_CAMERA_LENS_COVER is the right thing
> to use in this case after all.
> 
> I CCed the maintainer of the input subsystem so that he can maybe provide some advise.
> I for example would, taking the above information above the UVC device into account, say that
> KEY_CAMERA_ACCESS_ENABLE/KEY_CAMERA_ACCESS_DISABLE is more suitable. Then userspace has to
> keep track of the camera state (through lsusb for example).

KEY_CAMERA_ACCESS_ENABLE/KEY_CAMERA_ACCESS_DISABLE is supposed to affect
all cameras connected to the system (HUTRR72: "The proposal is to add a
set of new Usage IDs to the Consumer Page (0x0C) to control programmatic
access to *all* camera devices connected to a computer." - emphasis
mine).

SW_CAMERA_LENS_COVER is useful when camera is always present but may be
covered.

If I understand this correctly the camera disappears from the bus and
reappears again when enabled. In this case why do you need the key event
at all? Are you planning on having a "stub" for the camera so that
userspace believes that the camera is always present but may be not
operational?

Thanks.

-- 
Dmitry


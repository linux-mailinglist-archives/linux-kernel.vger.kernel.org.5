Return-Path: <linux-kernel+bounces-165704-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A819B8B8FF8
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 21:12:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F29A284811
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 19:12:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDA91160877;
	Wed,  1 May 2024 19:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FebS1O+D"
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAF4837E;
	Wed,  1 May 2024 19:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714590715; cv=none; b=gRK02dpDm3m+YHp+b5yo1y59EVqKYgrrYOtcJiTkJ/zNz12gSSwn0GbqKOvczN55dPpTt8UyY0hJIDbEk5cSI1obLHetu6sAbBWTXIsYoJ3yf2nyU6ewg9NyIS6MASHawEwBOz7aGEXgN0xIZQP2WYUr3OhI4a/Tq4DRjCTYBP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714590715; c=relaxed/simple;
	bh=tMQZV9fHGSGxPJBBtUnKfp2Inz9V/QY8CXv91C6xmiU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IGwolYnkSohWYhY34QtfN6x9TXENvkIzYKVar4iHmHzwH3oKA5UDy+RGOR38kEJwSHqRl3Unp42Yhw677Ey/D0dfiH9m5LWSL/gCqdckA30k3DTfwPyAm4RBRMQ4wg99P5aL0ovZEY/PLp9cs2lZP9iwX4w64woM8a1sWzpRqZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FebS1O+D; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2b33e342c03so608884a91.0;
        Wed, 01 May 2024 12:11:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714590713; x=1715195513; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=wRf2rHKBPCLYia00jxfTeMnUCgUqm7QyU6rnSroHoWY=;
        b=FebS1O+D4/jI+LWR8j9dLBMLfZYbVFyyif+9Z4YCIK7A1oAGQ2mpHOPHiLF7CXwsxX
         kdBIQCymR0oNxsA9Q+Dpj/+uvvjFkQA3W9BNRsz70Eh5S54hyoKV48Gy6QOVtxH8oDjq
         GNN734Yk8yjiS8pHuvUyf3X0jYkVCRftLggPaPzkCitZ0mwqzdhD3AipODcwpbIDP6Uy
         qh728XdMpzpbl5tTkh1scpMAaDfER2dIHsoa88re9a+G5lfZNZwjCWV0IDOrtZ1/vIKN
         wOILsUSW0aenQa8K6xoljPya+9bxLge000vgFBT1Dadu/5BChlpyp+Rw7x0Y7W8+0P2+
         HU5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714590713; x=1715195513;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wRf2rHKBPCLYia00jxfTeMnUCgUqm7QyU6rnSroHoWY=;
        b=A6KyVRDAxKOokeZ+uyDQ0wCMzcD6C9WKBJnGZRAWkDnYixktofs//4i+L81MWIGeCW
         Ls7c9346Jl8m9jTECAXoKfu6nG7EcAVCDw3k5m8DcOYSH6G6LEMpIld18xcTGAhvvTq7
         h27DbkPMTZ1fgsTVZV7sNODzI4WVR/cl5PvRpC9IIhJ4x+mgPlMojxphg2HAD4MiwsI5
         gWkVBGCwQhPgQdEE2a0Q2qlDEvrqgB60VQfLlyWCrJyIMbRoanoyMTjSTm9I+Khd8nNY
         vdB6TOb8mnZJcx0jbh/S1nu6s0a5nEgsEtAsX2faQUGlZ69GSfjR98YxT/0IE2wkR6YJ
         lJMg==
X-Forwarded-Encrypted: i=1; AJvYcCVVOgisx9Np1sjwXhr+OF+bEdRUpPmjqsr/abwVV/8F7knBbh24qm/YFtBgDtJVrSQi+2EyORRUA6Ch2yyInVfxx8NAD0UMkmULLzT0
X-Gm-Message-State: AOJu0YzEHCd0KqKxzn5GvgkG2MvUqC90gES65h42Yt5LQglgRuT+Do+/
	fmb7C9dKLjJHr+ytjhVi4ChLkBEeBa/PbsEOmqOxN9zhCTejjG1u
X-Google-Smtp-Source: AGHT+IGGgphCUXgegkHhqB4uM36UDoxOGPvxxub2dK7Go0WZGERBSZn/RJudjnUX1UyL8qlwBfxS7g==
X-Received: by 2002:a17:90b:609:b0:2a2:7a00:f101 with SMTP id gb9-20020a17090b060900b002a27a00f101mr3180196pjb.47.1714590712812;
        Wed, 01 May 2024 12:11:52 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:1cb4:dd50:d6f1:6308])
        by smtp.gmail.com with ESMTPSA id sz15-20020a17090b2d4f00b002aff85b97dfsm1680453pjb.27.2024.05.01.12.11.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 May 2024 12:11:52 -0700 (PDT)
Date: Wed, 1 May 2024 12:11:49 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Jason Andryuk <jandryuk@gmail.com>
Cc: linux-input@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>,
	Benjamin Tissoires <benjamin.tissoires@redhat.com>,
	Peter Hutterer <peter.hutterer@who-t.net>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] Input: try trimming too long modalias strings
Message-ID: <ZjKT9QYB1ScvYeIo@google.com>
References: <ZjAWMQCJdrxZkvkB@google.com>
 <CAKf6xpvzrCHAsbokGu_+7P0H=n4T=dsRN81msJjW6yVMcEZi6g@mail.gmail.com>
 <CAKf6xpsiLbZN=v2G052kuwPLNxmmbt4uoZAM21Zr+RtH0YD8kA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKf6xpsiLbZN=v2G052kuwPLNxmmbt4uoZAM21Zr+RtH0YD8kA@mail.gmail.com>

On Tue, Apr 30, 2024 at 06:25:13PM -0400, Jason Andryuk wrote:
> On Mon, Apr 29, 2024 at 9:04 PM Jason Andryuk <jandryuk@gmail.com> wrote:
> >
> > On Mon, Apr 29, 2024 at 5:50 PM Dmitry Torokhov
> > <dmitry.torokhov@gmail.com> wrote:
> > >
> > > If an input device declares too many capability bits then modalias
> > > string for such device may become too long and not fit into uevent
> > > buffer, resulting in failure of sending said uevent. This, in turn,
> > > may prevent userspace from recognizing existence of such devices.
> > >
> > > This is typically not a concern for real hardware devices as they have
> > > limited number of keys, but happen with synthetic devices such as
> > > ones created by xen-kbdfront driver, which creates devices as being
> > > capable of delivering all possible keys, since it doesn't know what
> > > keys the backend may produce.
> > >
> > > To deal with such devices input core will attempt to trim key data,
> > > in the hope that the rest of modalias string will fit in the given
> > > buffer. When trimming key data it will indicate that it is not
> > > complete by placing "+," sign, resulting in conversions like this:
> > >
> > > old: k71,72,73,74,78,7A,7B,7C,7D,8E,9E,A4,AD,E0,E1,E4,F8,174,
> > > new: k71,72,73,74,78,7A,7B,7C,+,
> > >
> > > This should allow existing udev rules continue to work with existing
> > > devices, and will also allow writing more complex rules that would
> > > recognize trimmed modalias and check input device characteristics by
> > > other means (for example by parsing KEY= data in uevent or parsing
> > > input device sysfs attributes).
> > >
> > > Note that the driver core may try adding more uevent environment
> > > variables once input core is done adding its own, so when forming
> > > modalias we can not use the entire available buffer, so we reduce
> > > it by somewhat an arbitrary amount (96 bytes).
> > >
> > > Reported-by: Jason Andryuk <jandryuk@gmail.com>
> > > Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> >
> > Tested-by: Jason Andryuk <jandryuk@gmail.com>
> >
> > I don't have the gdm setup available to test, but loginctl looks good
> > showing the Xen Virtual Keyboard assigned to a seat:
> > # loginctl seat-status seat0
> > seat0
> >          Devices:
> >                   ├─/sys/devices/LNXSYSTM:00/LNXPWRBN:00/input/input0
> >                   │ input:input0 "Power Button"
> >                   ├─/sys/devices/LNXSYSTM:00/LNXSLPBN:00/input/input1
> >                   │ input:input1 "Sleep Button"
> >                   ├─/sys/devices/platform/i8042/serio0/input/input2
> >                   │ input:input2 "AT Translated Set 2 keyboard"
> >                   ├─/sys/devices/platform/i8042/serio1/input/input4
> >                   │ input:input4 "ImExPS/2 Generic Explorer Mouse"
> >                   ├─/sys/devices/virtual/input/input5
> >                   │ input:input5 "Xen Virtual Keyboard"
> >                   │ └─/sys/devices/virtual/input/input5/event4
> >                   │   input:event4
> >                   └─/sys/devices/virtual/input/input6
> >                     input:input6 "Xen Virtual Pointer"
> 
> What do you think about Cc: stable@vger.kernel.org?  I'd like to get
> the Xen Keyboard working as widely as possible, so I'd like it
> backported if possible.

I am open to it, but I'd like Benjamin/Hans to take a look at this
as well (I see Peter already gave his Reviewed-by).

Thanks.

-- 
Dmitry


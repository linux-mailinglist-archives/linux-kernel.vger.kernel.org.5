Return-Path: <linux-kernel+bounces-161221-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C212B8B492F
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 04:10:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F39E41C212BA
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 02:10:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BB8E1388;
	Sun, 28 Apr 2024 02:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZFFtIqwJ"
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62BDDEC3;
	Sun, 28 Apr 2024 02:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714270227; cv=none; b=mhfIsEBWS80VjZemaFCU3aQ8SgwzL+8fQKtRsOu4cr11la7vBrBTI6XG3RVT9aorS0W5ZBwChCfVncHJnGKC3TH6XfvLoUiXZ9lZOdAmUilLK1EXVq9gZGr4Nkm8YmNNDwBgIk0fgiNtJYwUA6fMmOJD91lxP54jRM9xl/CfPmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714270227; c=relaxed/simple;
	bh=S1XhC3u9AqpFw3u9Er+XVwtdDw0mxtPrtq8EE9lfrEc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=peVWP5H1hBfZf4+oAdEws3oWKqBgDO5jWntPRxQBpgV2Q3nF74Gy/V7dgaC9rLqs+nJ66xWh4IdzrgUTWUqklbdmwXx9k0kqJgaIQ1lG5rh2FVYBuGWV3/dVjxUc3HtbmeTQ5W3GGI+iYZM7CN+3yqXHPwnvNL4H6Lq01dj+oMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZFFtIqwJ; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-3c74fd6fb92so2384467b6e.3;
        Sat, 27 Apr 2024 19:10:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714270225; x=1714875025; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=j25O0uJoaqNnY/ehouxnDjRK54rAQQT8GHfQlfgnn4s=;
        b=ZFFtIqwJa2UYh4MVPIjHXiPAsxfWYg9llmDIdd8WqtKxEycIGDBSSEHnT/Z/x6JOEl
         35FxtZT9Q+7OGaRkGoPkZ3II8j0oCOn3X8H/xdduZVIuXTBVkLMn2Vkf4YTM2ilOqrnf
         rlxLr8U0nstKMjr7f8RjI9iMdlj/IpLA+JpP6Lzbkunp0yXpDUaw4LmPjSOpvgLQMpKK
         SroOoapECFAu4oeNVR70i0AZNUfdutqrJCxbMIi/ILrbFBAqjV9fZs6tsFtMUPqaQfRp
         +PXEuKWqsdiqKb0u5UwPINIx42Q8EIsWYsTjVMwHV14lLh+rylpwSQGzXOkfk6sP1CkE
         KNSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714270225; x=1714875025;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=j25O0uJoaqNnY/ehouxnDjRK54rAQQT8GHfQlfgnn4s=;
        b=sTRZyTQC4d13TNAyRbqVS6Wji3OxGezyDR45cZ2XYBGMSCbyvt4QE2xMRb4XmoUZZS
         3MS1UqCfpZNM5DFeR5UMXyIeySD59C5PxYQbWKQ+/PwFOSecHLLjCdaLI1gaoCPQxzsU
         kN3wxW7+lt3OQWr4Y+XkB2HEOcvpPqu9mX16+wODSvkO+akQWkUkFC8A7ni2Wv7Dbahl
         5oAU36EppYZFXRzjXYHd487zlYYk+dPkx3YHZCMvPxKBJ7Iltk5juepsZrY+i91OJli/
         stG8rCMLT6cO0WYcNNHORm+5/MhHPARkywVq5s66y/GXLfzszG6SMZizuUvnKffgXOR2
         IktQ==
X-Forwarded-Encrypted: i=1; AJvYcCV/V4xOC1EStMP4wKlTEdLAc2ruN0zQyfe+Q2mGlDw7wUq9NKe07my+Sxl1cgK/1awifelrgi+ZCmdyF+K8nlbW81HtddvA7lp5gA2TyGqUQthF46XGy/kPOscneuXM/jLTwls=
X-Gm-Message-State: AOJu0YxqRAI3I5umVdorFUZNkgXALoyjU/3Me8dSKwDp31OtLC9XhBPQ
	0GXN5Xj3tgC+vIFBxhji6F0Z9tEhyqN1AA0OWurP0FhGJgbK/CRp
X-Google-Smtp-Source: AGHT+IHtX6yRgJyzoddZByQyAWFPvLNk2129HSIFKQBNavTxch+yNcgxHbPrMp8a0EE9DUC+bfmMSQ==
X-Received: by 2002:a54:4512:0:b0:3c8:2be2:7833 with SMTP id l18-20020a544512000000b003c82be27833mr8183995oil.37.1714270225235;
        Sat, 27 Apr 2024 19:10:25 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:5ae9:912b:8980:d67c])
        by smtp.gmail.com with ESMTPSA id j22-20020a056a00235600b006ea7d877191sm16963376pfj.2.2024.04.27.19.10.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Apr 2024 19:10:24 -0700 (PDT)
Date: Sat, 27 Apr 2024 19:10:22 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Jason Andryuk <jandryuk@gmail.com>
Cc: linux-kernel@vger.kernel.org, Phillip Susi <phill@thesusis.net>,
	stable@vger.kernel.org,
	Mattijs Korpershoek <mkorpershoek@baylibre.com>,
	linux-input@vger.kernel.org,
	xen-devel <xen-devel@lists.xenproject.org>,
	Juergen Gross <jgross@suse.com>
Subject: Re: [PATCH v3] Input: xen-kbdfront - drop keys to shrink modalias
Message-ID: <Zi2wDivw7XBuNnj-@google.com>
References: <20231011193444.81254-1-jandryuk@gmail.com>
 <CAKf6xpuJe6Cza6bow3QxDGf1viu0kish7Y8YRN8haXL1oEF3HA@mail.gmail.com>
 <CAKf6xpv2oDpPB3wWh=Fz_ahDVgmvw2MSj_q3RYqQ8NG6km5Tuw@mail.gmail.com>
 <ZgWxYvQH4A_Vh1i4@google.com>
 <CAKf6xpu+8Uh263NqKm1qFkYG9VzHH-p4UZ=x+Fm+-SHR7J5=wQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKf6xpu+8Uh263NqKm1qFkYG9VzHH-p4UZ=x+Fm+-SHR7J5=wQ@mail.gmail.com>

Hi Jason,

On Sun, Apr 21, 2024 at 07:57:24PM -0400, Jason Andryuk wrote:
> Hi Dmitry,
> 
> On Thu, Mar 28, 2024 at 2:05 PM Dmitry Torokhov
> <dmitry.torokhov@gmail.com> wrote:
> >
> > Hi Jason,
> >
> > On Wed, Mar 20, 2024 at 01:42:27PM -0400, Jason Andryuk wrote:
> > > Hi Dmitry,
> > >
> > > Do you have any feedback, or can you pick up this patch?  It solves a
> > > real issue affecting udev, which crashes the Debian installer and
> > > breaks the mouse for Gnome.
> > >
> > > Or would you be okay if this patch went in via the Xen tree?
> >
> > I'd rather not. Could you please ping me in 2 weeks on this. I promise
> > we find a solution before the next release.
> 
> It's been ~3 weeks.  Any ideas?
> 
> If you think this patch should be pursued in this form, I'd like to
> post a v4 that adds BTN_DPAD_{UP,DOWN,LEFT,RIGHT} on the off chance
> someone wants to use a controller.  I dropped them initially since
> they are not keyboard keys, but button presses are delivered through
> the keyboard.  Hence, they should be included.

I do not think suppressing random keys in the driver is a good idea,
because we may fill up what you currently consider as gaps, and
people will be confused why certain events are not being delivered.

I just posted a patch (you are CCed) that attempts to trim too long 
modalias strings, please take a look and see if that solves your issue.

Thanks.

-- 
Dmitry


Return-Path: <linux-kernel+bounces-9770-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DFB281CB26
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 15:12:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B3A76B2144D
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 14:12:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65EB21C6B6;
	Fri, 22 Dec 2023 14:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="STpIxPPR"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94BE21C693;
	Fri, 22 Dec 2023 14:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1d41bb4da91so3226665ad.0;
        Fri, 22 Dec 2023 06:12:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703254347; x=1703859147; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=TskB6em0ocvTargEDFcD5G0O4xeSFVLyNkdQ5H3hjGo=;
        b=STpIxPPRKRz772kmCfEG23b4jJKpXzdwUxuNz8SJqjAFdYaKTlc2uvTL5Ni9UOmsBf
         H+HAuP65lXnG64Vd9OriESgsb1M0A7+yJzIoy0LWzsoTq2vrxt6xgE3n6ee+2XXaKC5S
         xyiChlwtfBG3c2vD2bGxPIf5If5Skpf/ZJFLYxCut++XsSzNRxiBwoaa7vNXlM0AYVpp
         rTXqpvLiYT6bo4Bu460584zyiSuvObs1OT8scLrTsJpxcuyUBAG7GBqoD1J2PfcCYr5i
         FBin1cP9Ljl3LFrDstUSPsMKIVX5Uij7saKPji1I+zLMcyLU5k/Vy0mU/8CLKN5jT/eZ
         RHdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703254347; x=1703859147;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TskB6em0ocvTargEDFcD5G0O4xeSFVLyNkdQ5H3hjGo=;
        b=i37nBC+UEYhvBF6vljHhKwyPIVt3q4MP8Da+L8zf0/jFaO4dfYLJmA4WMiI15yPQUy
         9pZZram2x3i2wx2wgXCMJPWNAG2ZEnXnq1P7pxmpkGHVkW4gLyMKUvDFecQEHyxI+goR
         DJPde5yqyVxAZAuszO4+9tlEhjlhiJJnCLGn9fzifpnysC/yFrHDCkOhy2EJPtEk6nTR
         iefXF8PZtpxcf1TLWDju3TqFmFUWPHqWwnv1YVvfyzfsRU6FZT2oR2tUdEhcmGe9L3Om
         3BPMCrg5nNnaZpflv0gOTR5AZOZ+FNcD1toT7KUouQkjnPu6sqqjBsetGBiQvLJvDhgz
         X/Ow==
X-Gm-Message-State: AOJu0YyrTtRa8jFZDJFVkaAuAH5dil2tQO5MkwuMTnhDKRLQIi/+1XlQ
	g5rRJpQS7dBRIrKEHeIRGRw=
X-Google-Smtp-Source: AGHT+IFxLt9bLrpqg6GFD0HTlBdFwTP/cz4FXzA9un2OiN48hpbC1FvfopisJQJ2JP4kAFYSqsQF4w==
X-Received: by 2002:a17:90b:517:b0:28b:e74b:6c05 with SMTP id r23-20020a17090b051700b0028be74b6c05mr799869pjz.24.1703254346739;
        Fri, 22 Dec 2023 06:12:26 -0800 (PST)
Received: from rigel (60-241-235-125.tpgi.com.au. [60.241.235.125])
        by smtp.gmail.com with ESMTPSA id sh18-20020a17090b525200b0028ae9cb6ce0sm7673652pjb.6.2023.12.22.06.12.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Dec 2023 06:12:26 -0800 (PST)
Date: Fri, 22 Dec 2023 22:12:21 +0800
From: Kent Gibson <warthog618@gmail.com>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: andy@kernel.org, linux-kernel@vger.kernel.org,
	linux-gpio@vger.kernel.org, linus.walleij@linaro.org
Subject: Re: [PATCH v2 5/5] gpiolib: cdev: replace locking wrappers for
 gpio_device with guards
Message-ID: <ZYWZRWvwBTdKNHF-@rigel>
References: <20231221012040.17763-1-warthog618@gmail.com>
 <20231221012040.17763-6-warthog618@gmail.com>
 <ZYReZI_TnX1MyvP7@smile.fi.intel.com>
 <ZYTcn-UX0TUM5P9O@rigel>
 <CAMRc=MfNme1VavLNnX9whjgohNCs4Q5qADByX8c_tdw05UVYUA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMRc=MfNme1VavLNnX9whjgohNCs4Q5qADByX8c_tdw05UVYUA@mail.gmail.com>

On Fri, Dec 22, 2023 at 03:05:41PM +0100, Bartosz Golaszewski wrote:
> On Fri, Dec 22, 2023 at 1:47 AM Kent Gibson <warthog618@gmail.com> wrote:
> >
> > On Thu, Dec 21, 2023 at 05:48:52PM +0200, Andy Shevchenko wrote:
> > > On Thu, Dec 21, 2023 at 09:20:40AM +0800, Kent Gibson wrote:
> > > > Replace the wrapping functions that inhibit removal of the gpio chip
> > >
> > > GPIO
> > >
> >
> > Bart, I don't care either way and not enough to respin a v3.
> > If it bothers you could you fix it on the way in?
> >
>
> Sure!
>
> > That is if you aren't too busy reversing xmas trees ;-).
> >
>
> Joke's on you, I actually do find them easier to read and try to use
> them everywhere in new code I write. :)
>

Oh, I agree - it is more readable.  It just seems very timely that Andy
keeps griping about them not being inverted.

Cheers,
Kent.


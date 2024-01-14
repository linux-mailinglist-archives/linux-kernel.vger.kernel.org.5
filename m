Return-Path: <linux-kernel+bounces-25461-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 100CE82D0A6
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jan 2024 13:55:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B9A161F21953
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jan 2024 12:55:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 833EF23A6;
	Sun, 14 Jan 2024 12:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FcFUiW5z"
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AC2020EE;
	Sun, 14 Jan 2024 12:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f43.google.com with SMTP id ca18e2360f4ac-7bf2a89c273so65744839f.3;
        Sun, 14 Jan 2024 04:55:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705236924; x=1705841724; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=BxXhDrDTWUWugV/3PD/CLnM+3ZJaWXO6/qqmveyyw2s=;
        b=FcFUiW5zccsjxUI3rXkeUg/GI0Ir5sRHxTCDN6/V1py1FHfDyPGJUAo+Y4oV4Ltt85
         BWoQ/X0XqJ9NYdypaHKxSHnXu8A+ZlBFDZ8kz+qnhgkwI78kLAhjxRlcmD68HRBLE1fO
         x45PeSKsEuRVkIG7y0qPAccUGqnhzJU6xHVcC+H0s4qerDvNDilAM8syJUhtLNTq/pPc
         VMYguCWNlvJ9y7KSMyI9CNdirC5QLt396lmyXpbe7o3LjB9ND2q6pj4y/Q5qavjC7SLH
         UKktZ6af890HelFJNiIXRohFlJBg0q82p9Hmk9KR0fvEPgdXrHzqqWKg/wBJSvkDortM
         ILDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705236924; x=1705841724;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BxXhDrDTWUWugV/3PD/CLnM+3ZJaWXO6/qqmveyyw2s=;
        b=fkAHreBaRYdbWK/UGScCuJ9SZtG7Ebsh44GLokkLB7+V253c5XGiyKA4EfEo5Lu0s0
         l29yTx7fAFaEnqNx1J3vgwZgpwqgpRyZePP39JW11pqIkguEnPkJxceFlejiTjq5PbD/
         PLlp2sCgMSquqTR7xY6mSqOvIeImkrlFxy9Jns4l4bV4OqyUVSWTNywIv81HCMvFXtbV
         85yWQLmAPPomOrhc5SgcDdPQfWmCx1cl6t1or/u326yoF+ZO43JOQldrX7Lhvhw7sTVS
         +11xl3RrMVNaqUbMiAUyy8x5q2mD1WSqa2+KTHNSu43BQQW+sMNUx53s62706ORcG7Cv
         O19A==
X-Gm-Message-State: AOJu0YxIS1A3E3CfoSrO/FpUKrRZz3liJjCGXyUowM9VfORnYo84wvJ9
	Tc/BizLlyZ3qvDubq8zqhVg=
X-Google-Smtp-Source: AGHT+IEqA+EUhfPIJP6O62E5SzB1wSRXCemRkOGSmfdzDTcwYj6XTg/mhHVe2+m8V2ZtTJT0RHz9Fw==
X-Received: by 2002:a6b:720d:0:b0:7be:e321:764 with SMTP id n13-20020a6b720d000000b007bee3210764mr6032344ioc.24.1705236924601;
        Sun, 14 Jan 2024 04:55:24 -0800 (PST)
Received: from rigel (60-241-235-125.tpgi.com.au. [60.241.235.125])
        by smtp.gmail.com with ESMTPSA id z3-20020a170903018300b001c61073b076sm5985845plg.144.2024.01.14.04.55.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Jan 2024 04:55:24 -0800 (PST)
Date: Sun, 14 Jan 2024 20:55:18 +0800
From: Kent Gibson <warthog618@gmail.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
	linux-doc@vger.kernel.org, brgl@bgdev.pl, linus.walleij@linaro.org,
	andy@kernel.org, corbet@lwn.net
Subject: Re: [PATCH 0/7] Documentation: gpio: add character device userspace
 API documentation
Message-ID: <20240114125518.GA84351@rigel>
References: <20240109135952.77458-1-warthog618@gmail.com>
 <20240114024724.GA20870@rigel>
 <CAHp75VeN25Q+7nTM0f3MWnU99Y0MZJjxBLfMxJJhAyWcBq8W7w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHp75VeN25Q+7nTM0f3MWnU99Y0MZJjxBLfMxJJhAyWcBq8W7w@mail.gmail.com>

On Sun, Jan 14, 2024 at 02:01:29PM +0200, Andy Shevchenko wrote:
> On Sun, Jan 14, 2024 at 4:47 AM Kent Gibson <warthog618@gmail.com> wrote:
> > On Tue, Jan 09, 2024 at 09:59:45PM +0800, Kent Gibson wrote:
> > > My new year's resolution was to improve the documentation of the
> > > character device API and gpio in general, so here we are.
>
> ...
>
> > While preparing the v2 version of this series, I'm now wondering
> > if this should be changed to "obsolete" rather than "deprecated", to
> > better fit with the interface lifecycle, to indicate there is an
> > alternative, and to emphasise that it is scheduled for removal.
> > i.e. from a userspace perspective "obsolete" is the clearer term.
> >
> > Is that a change worth making?
>
> From my p.o.v. yes, as it makes it consistent with what we already
> have in the sysfs/obsolete.
>

Ok then, I'll incorporate it into v2.

Cheers,
Kent.


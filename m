Return-Path: <linux-kernel+bounces-123296-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DDEC189063A
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 17:49:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 94D221F27FB7
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 16:49:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C8EB3D55B;
	Thu, 28 Mar 2024 16:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FBKp0cH6"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94CA1225D0
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 16:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711644311; cv=none; b=UdI693lebZsiRiNYKLThwz+vr//DddgTevCcCJT4LDos64rLQMCCPsZ1uRq69tFvZoA3zsfYAZ1mjcd0yGu5pCGwBCTearCuFcDZCF0aSWb6GwMLowmbKdggEjC7hrVi8mERakfV5pG+N2S2acPxHZMbCkg18b++8eqWQ68ieVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711644311; c=relaxed/simple;
	bh=/Zja/MFSFGzAJAXJparFQCQuW62bnc3U1YwOvbEie24=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LAcGxgtq+BSmnA5S1ksBrKSOc9FRUwwyd/mxV/YGNQPvWNBWwNl9Bzta/hn2nKwq348vtrAD9r74zNClryYxB523rgrfZTiWpsrl7hLYYQ8V6xGJ7iNlWzaX4QxlPKWwccT1MJD4NGedHUCQkVmThn8TTv2upqG1L3hsHzHfYYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FBKp0cH6; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-56c36f8f932so3943355a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 09:45:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711644308; x=1712249108; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9i7dgEJFTBVALJHo9iymqx4jH03OiP2GHtz27o4I/YA=;
        b=FBKp0cH6JBI5BTwRg4YB1wQnoUJwePw10SH6p1CtR2lTZtZgzOKFIAfDTGISK0Falw
         qONzuR8MS+Tm30ysJ7aHuOW4BAcgmEEra/wWDys/lxw34Qe37S9iNZ3n8TBechxlH1N8
         81+lvMEisjylwiB1xfaUB/o+QNILhxOQ47MeGAjMZS8QjsktFiibvmkM++3HHicKBiyN
         6dfTt6wctjjp5TkTj284IloxfxA18brkCY7LK+HMavjOU0iuAoeQeIL79qUVOUiIbWF5
         o1ZoPyGmOUYmtyJ0r0pH6eqwJAPB+FH4TUk3jRHwvbq4JZNKMj49zWNyT+CKdJuNN5ZO
         SXMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711644308; x=1712249108;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9i7dgEJFTBVALJHo9iymqx4jH03OiP2GHtz27o4I/YA=;
        b=iVuVj+1RvHhMEo3erXFC5fSbTLpN9g0Q6Row8YAGHrvyeMo+kQBD9A2VZWflCF6M+7
         b19js0mpnL4h5zuj9/49bdxyJO8in6+hWNHs0m4sF2J5X0nF3d9Y93TjJEOqK8Kbeiti
         5PePDh+aRHh1+7MCjlDevq6f1BQfoV/HP5CcpXCRMijRs5JzhZv/HzcJHzsP7zZzQKII
         c/b3WCetpiqUSCNu4gx01pK5UDEQz/zL6vAvBbje7mCUJrQF1PKIGKSVKvkHYFUAmcon
         zePHynCQlneYkxK2gtGbH0GbWsL9zDREktvqIAOSEPI7K9umj+Kdq3jZ1V0D2zrt54Iu
         NsKg==
X-Forwarded-Encrypted: i=1; AJvYcCXk7Jz094ZvSTcEeweVKz7Hzvx4l8e225kAEY5uM1S/CygPHuB81TtgXGJkYrgNt7RpwUs2wskZi5kghYO8SU6iUiI0mnV2OeBw/hSq
X-Gm-Message-State: AOJu0YwjU/MewGBsdFad1tIZQsxrHSJOl+zgzbNPpQo+VWJBw8E16FeN
	GcwJk4+PAAcMGQvM8khgyWe5OKwPHGY5flSBpcapyy59yO2Pp5vE+g1v/l+Xn/8=
X-Google-Smtp-Source: AGHT+IE0k8W/uLy+pu3KFmEyPFgRSutvM+32xUNhKooZng/RRL2AQD0j9iJCAcXm19WSPYGUAycJqQ==
X-Received: by 2002:a17:906:388a:b0:a46:852e:2a63 with SMTP id q10-20020a170906388a00b00a46852e2a63mr2269137ejd.29.1711644307845;
        Thu, 28 Mar 2024 09:45:07 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id r18-20020a170906c29200b00a4e2a1146f8sm343291ejz.48.2024.03.28.09.45.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Mar 2024 09:45:07 -0700 (PDT)
Date: Thu, 28 Mar 2024 19:45:03 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: Aleksandr Mishin <amishin@t-argos.ru>, Keerthy <j-keerthy@ti.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>, "Andrew F. Davis" <afd@ti.com>,
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: Re: [PATCH] gpio: davinci: Fix potential buffer overflow
Message-ID: <cbfb9094-2574-4e00-b401-1ddd81a2850b@moroto.mountain>
References: <20240328091021.18027-1-amishin@t-argos.ru>
 <b2c6bc3e-11c5-4a20-8a30-666821ab2613@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b2c6bc3e-11c5-4a20-8a30-666821ab2613@intel.com>

On Thu, Mar 28, 2024 at 04:27:24PM +0100, Alexander Lobakin wrote:
> > diff --git a/drivers/gpio/gpio-davinci.c b/drivers/gpio/gpio-davinci.c
> > index bb499e362912..b65df1f2b83f 100644
> > --- a/drivers/gpio/gpio-davinci.c
> > +++ b/drivers/gpio/gpio-davinci.c
> > @@ -257,6 +257,9 @@ static int davinci_gpio_probe(struct platform_device *pdev)
> >  	spin_lock_init(&chips->lock);
> >  
> >  	nbank = DIV_ROUND_UP(ngpio, 32);
> > +    if (nbank > MAX_REGS_BANKS || nbank > 5) {
> > +        nbank = MAX_REGS_BANKS < 5 ? MAX_REGS_BANKS : 5;
> > +	}
> 
> Static analysis warnings make no sense until you provide a reliable way
> to trigger the problem on real systems.

This patch isn't correct, but we merge a few static checker fixes every
day.

regards,
dan carpenter


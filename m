Return-Path: <linux-kernel+bounces-151913-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 254338AB5AD
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 21:43:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60A6D1C21B6F
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 19:43:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0C4E13C913;
	Fri, 19 Apr 2024 19:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ArDITvpK"
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E60B1DA26
	for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 19:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713555825; cv=none; b=UylDchgD/ayWxnpM1aFDzbEb5mT3tOxIQwIpd1/w08lsOVNkszyUeRiSvQUI8GYIiIw8zdlqowXsOinZ+IIRSjYrdP6SSPqDeaoG8Q6R5HZuL02VOXSXVIUslHaYG9pcZVzmTVnRpPCpRaF3uaWUrY50Eqt4zl5OlxqVqd4p4H0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713555825; c=relaxed/simple;
	bh=/umTCUxm8+W904+v+ViwAy21eFv5gR2kI/1bx+ePXvk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fptR1VybwR3kEeroLrhdMvhE6EUbIY9tz1xuQRsq6s3R+GWLRr57J8V9fzfb9goEqVn85DVolWbcZTDe0udUtt4oG/ioFnzG746ZXT0+PgEe/djzDNl1QYa/Kff2ClYQPPbaeDhABxVaoilrQOpc1HiJAQ66yTHcpAg3hJwIGGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ArDITvpK; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2d8863d8a6eso36374101fa.3
        for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 12:43:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713555822; x=1714160622; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9n8w+k/Rz2KhRS1lWM0onkwMbYnSnsUvM19FbIPwAXY=;
        b=ArDITvpKJtKjPzAoNhL0fIePDl8EJqty6ikRCam+jkXo7yhyBHp4reTCdsOX0kpmvI
         PjEz/3qosFtMfhmPiSv+QkxjsO3A1E/7Nv7eBorshSAFHjRRLPZ+HO5PkVrJ9hF+HlFA
         kv5w8N/CA/E0y4YWb/PEf/JNwN3ZFj4bHTBi99u8+RIgDF2SvvTljSJIEkDSF1Lc6JWd
         aiRqPc8V70wL0amnGjNNletP2EUjPC4Na95iywa2oS5GFQ4zk9CWqC3uM8nY1O/+t3k5
         WzZ6ke2sSJO5mybyAyB6cocDRLgBMrMR7fMOFd+iWm7p/kw9kXzGpjhB29EoSMU+l0St
         Q3ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713555822; x=1714160622;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9n8w+k/Rz2KhRS1lWM0onkwMbYnSnsUvM19FbIPwAXY=;
        b=QdbftQi45WjjIU+O45PtAMpBhKXsCRvC40O55v35EfI+ZvGXTpSozFJCVwmSqu2YCZ
         ZPRYVsmQgKfKPvNQKWYbGpKa4rsV0rMrcDIk9gBv2NcZHPnfz/+zqHYNuHZ0T8wT7pMD
         L1RdXLU+xV5SBPsHV+flbgSGsukRwFWT68lFCR4FwULzRbFUMKvtCjANLWwUdtgVfrzT
         V5fIOyAkGdbhpZ23THlFP+wz0H+Sp4+6R1RyUihTXJtK8KEfNwqHo3vS8RKhaSxL8vag
         BsrQ6afUtcZZA/PFot0x23cssBJbAYRM3dzUM2MGUPwnTRoueYBijmSryxqfAb+X5478
         HsBQ==
X-Forwarded-Encrypted: i=1; AJvYcCWtDUhQxP3vC8WZMPPT3rIvfsGc5wyzEGzukvUyw6Ocv1CjbOsz6sNiy9ENrQBMMzPHrgOAWcAmtxC8yWT64cft4fXobUsNc8oluZIJ
X-Gm-Message-State: AOJu0Yz+EdhFxVSDFkIEFifA6pFpdlaPqz8QU2S+2yHNqveDMlhiHAds
	5ulSfJ7MU7MQsjU0NeIrs4ziNCIlOcuYXcCyzXkXr/paoB+NZG7Trt9wOppK/YA=
X-Google-Smtp-Source: AGHT+IGcBUNiOzrCx5bOhksZzXhutpA6zE+59J4ho4DswlvXGTgc/C2PjsXBWOqbG5K4nsFd3zM/2g==
X-Received: by 2002:a2e:8195:0:b0:2da:4bf:ab14 with SMTP id e21-20020a2e8195000000b002da04bfab14mr2470965ljg.45.1713555821866;
        Fri, 19 Apr 2024 12:43:41 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::8a5])
        by smtp.gmail.com with ESMTPSA id u35-20020a05651c142300b002dd1279c133sm36469lje.10.2024.04.19.12.43.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Apr 2024 12:43:41 -0700 (PDT)
Date: Fri, 19 Apr 2024 22:43:39 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Shresth Prasad <shresthprasad7@gmail.com>
Cc: daniel.thompson@linaro.org, deller@gmx.de, 
	dri-devel@lists.freedesktop.org, javier.carrasco.cruz@gmail.com, jingoohan1@gmail.com, 
	julia.lawall@inria.fr, lee@kernel.org, linux-fbdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, skhan@linuxfoundation.org
Subject: Re: [PATCH][next] drivers: video: Simplify device_node cleanup using
 __free
Message-ID: <yelspf4hfmmj3lnk3exyc6tm2lrsqlet623q2s5zrm2unba6nw@43ewuqdzckdg>
References: <20240419111613.GA12884@aspen.lan>
 <819a56c3-bbaf-4d5e-87de-78c1312c56d1@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <819a56c3-bbaf-4d5e-87de-78c1312c56d1@gmail.com>

On Sat, Apr 20, 2024 at 12:22:41AM +0530, Shresth Prasad wrote:
> 
> > Please fix the subject line to be "backlight: <driver>: ...". I came
> > very close to deleting this patch without reading it ;-) .
> 
> Really sorry about that, I'll fix it.
> 
> > Do we need to get dev->of_node at all? The device, which we are
> > borrowing, already owns a reference to the node so I don't see
> > any point in this function taking an extra one.
> >
> > So why not simply make this:
> >
> >     struct device_node *np = dev->of_node;
> 
> Looking at it again, I'm not sure why the call to `of_node_put` is there in the first place. I think removing it will be fine.
> 
> I'll fix both of these issues and send a patch v2.

Just a stupid quesiton: on which platform was this patch tested?

-- 
With best wishes
Dmitry


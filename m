Return-Path: <linux-kernel+bounces-111665-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 842AB886F41
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 15:59:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED9A01F23EAC
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 14:59:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B69053E35;
	Fri, 22 Mar 2024 14:58:09 +0000 (UTC)
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D123524DF;
	Fri, 22 Mar 2024 14:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711119489; cv=none; b=WczjTYvS9v4BLwzo5k4PFm/TSyjLQ3xaOOhSJBt7/p1ctE9MAKb4Bd6oAKhsACSxC0krKPlhyIM+WmCz/TvqsPvSNg9eTMo3iQPnJRVXQjI612vi35L2ApWJ6RJjdMJKeOJxtHJqymBtF6+/LZoxSRbmvyr9yMNE9kfpfoTpmbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711119489; c=relaxed/simple;
	bh=685WdBxw0GOy/a0oTxvU+HyP265MQxO4nlLlheBUxR0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b8taLitRzsyge7tvhLR+ABWe7vFN83rGAf73jFNBuiiQJEEJP0WXhVOZYvcHIteQixYwDZO1ABtdvI5+XTtopIfappPeuCdO0gepHFvJjGDLM8lg7hxC6sdOKcYC5YkgaMyySrCYJMObokZ8wwoJItjI6DaTPB0KlcRXg7pccMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-513d23be0b6so2664822e87.0;
        Fri, 22 Mar 2024 07:58:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711119485; x=1711724285;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=avF4Td+5sDoAM4wZ/tsgIe8phCBwKRX1SbsfID3iEnY=;
        b=iVvpEzLtfVqc33ud9rkUQWqYdSQdRu5fcSm3Jm3cpyiA20uPQZwm5y0TgJx9Hu/xNr
         lWI9PuD5Bxzz54UV29HP1uJQp5etwmQ/TiZd5yBkHFe0xzhvz5NvUXMnyUSn7HFH5Qzd
         nm17febbuxfqGCekAvXxvRV+sBKwLxr/O/Icyu71vFKzqixyB2AECjCWcpCZMsnsFDhq
         FVqnVHSbwiNOXWkX5lwY80jtrhtIZuF3Z9q04BogsneSSfKsbWIEO86Zva4V7LV8cu7C
         inSaGSUs46dmJZEL76jDidknUQh64iUAR2sWBDbkIPFHliXDEIozQfQ1iHuilu7h/Pn4
         I0bQ==
X-Forwarded-Encrypted: i=1; AJvYcCV+6uAFtgfSvGixg3ctwuA7UvPJjwifLhpiFQUuNvqJqX/GXwhOEKOtaSjzkmTdBFOq0nRFyGDVrmdtvJTNSM07nFSfrIWKj08tnavb37E2NIh+urciTJsMrcWDQSmD5i2gq2G3EWXLi/puBko=
X-Gm-Message-State: AOJu0YyAe/Qqe9recl5tZQJuVfKkVqGW2GeEXuViomgp3wFRMYUkXUdF
	h6uoFnt/YTZxa8RcNnHyXjtF7cdOcTcw1H8fiwLH+WsKNSOQ34Wc
X-Google-Smtp-Source: AGHT+IGMJBLo25QPNpSET5oDNLsq0cOYHxH7EFzxe+KeRHX7TPHuh19xx4qN1EKC/FYZuU9cxgRfaA==
X-Received: by 2002:ac2:546d:0:b0:513:cab1:354b with SMTP id e13-20020ac2546d000000b00513cab1354bmr1898523lfn.41.1711119485063;
        Fri, 22 Mar 2024 07:58:05 -0700 (PDT)
Received: from gmail.com (fwdproxy-lla-120.fbsv.net. [2a03:2880:30ff:78::face:b00c])
        by smtp.gmail.com with ESMTPSA id r16-20020a170906351000b00a46cddf1efbsm1092197eja.29.2024.03.22.07.58.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Mar 2024 07:58:04 -0700 (PDT)
Date: Fri, 22 Mar 2024 07:58:02 -0700
From: Breno Leitao <leitao@debian.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Jeff Johnson <quic_jjohnson@quicinc.com>, Kalle Valo <kvalo@kernel.org>,
	Jeff Johnson <jjohnson@kernel.org>, keescook@chromium.org,
	"open list:NETWORKING DRIVERS (WIRELESS)" <linux-wireless@vger.kernel.org>,
	"open list:QUALCOMM ATHEROS ATH10K WIRELESS DRIVER" <ath10k@lists.infradead.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ath10k: allocate dummy net_device dynamically
Message-ID: <Zf2ceu2O47lLbKU3@gmail.com>
References: <20240319104754.2535294-1-leitao@debian.org>
 <9fcdb857-da62-4832-ae11-043fe993e4ad@quicinc.com>
 <20240321072821.59f56757@kernel.org>
 <5039256c-03eb-4cda-8d11-49e4561cf1ef@quicinc.com>
 <20240321151744.246ce2d0@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240321151744.246ce2d0@kernel.org>

Hello Jakub,

On Thu, Mar 21, 2024 at 03:17:44PM -0700, Jakub Kicinski wrote:
> On Thu, 21 Mar 2024 15:02:39 -0700 Jeff Johnson wrote:
> > >> As suggested there we should just use kmalloc/kfree to match the existing logic.  
> > > 
> > > Please no. There is no magic here. alloc + free must match whether
> > > you're using magic object alloc wrapper (alloc_netdev()) or straight
> > > up kzalloc().  
> > 
> > Based upon the ath11k patch there must be something going on with
> > alloc_netdev()/free_netdev() that doesn't occur when these aren't used.
> 
> Looks like init_dummy_netdev wipes the netdev structure clean, so I
> don't think we can use it directly as the setup function, Breno :(

Before my patch,  init_dummy_netdev was being also used. The patch was
basically replacing the init_dummy_netdev by alloc_netdev() with will
call "setup(dev);" later. 

-               init_dummy_netdev(&irq_grp->napi_ndev);
+               irq_grp->napi_ndev = alloc_netdev(0, "dummy", NET_NAME_UNKNOWN,
+                                                 init_dummy_netdev);

I am wondering if alloc_netdev() is messing with something instead of
init_dummy_netdev().

Also, Kalle's crash is during rmmod, and not during initialization.
getting NULL after free_netdev() is called.

> Maybe we should add a new helper to "alloc dummy netdev" which can
> call alloc_netdev() with right arguments and do necessary init?

What are the right arguments in this case?

Thanks!


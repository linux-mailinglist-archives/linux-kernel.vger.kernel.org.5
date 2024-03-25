Return-Path: <linux-kernel+bounces-117707-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9E3588AEAC
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 19:42:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 076AA1C60D0C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 18:42:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDFA0535AB;
	Mon, 25 Mar 2024 18:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Qi2sAHgg"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F2F35676A
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 18:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711391321; cv=none; b=IXx4JmFMlUXh9R9pcJvrqyuPUgKBvnVh6jxlc6V4sdijw+EkoF1XOZwafI5+3oHfJAmBQrd85gHyIS8c3ohCCNYz7DMYV9MkGPSw5/xbEf4DUjPEfyTzB+v9EfPatV3Px19n216FHZlbRVeaK1JDWTlB3nm9t16VnG5QpYv6iRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711391321; c=relaxed/simple;
	bh=0HOnkjXWwiDTZizF5waT1rnlf2JjeQP7eZRutOD0bT8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gGt/ylk1OEwNtrUN9q7nN/TBzTMT1fgJlVo90/tjftxKiB+Ao0r3Cn8j/OjqoqjHk781F04lkqPh01rbWnQzSnEIwermWDpHo94CClmzNxLVDdPYkV4JOzn7ayIs+46PS/DClDbfdGDnYX8nIb/VxK/frRU0oq48dsjpK16W2SQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Qi2sAHgg; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-513d599dbabso6116775e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 11:28:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711391317; x=1711996117; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kiunE8pTzAniAwJdofUTsPhWLKKG+ApktTjbMuShmFk=;
        b=Qi2sAHgg3apWcmsNi08xOLdfTGZLDR+uH30vv+aCrp+ybMhCsiMCvIrTyoNc0lARTa
         +3Xf3dhEJUtflFpdAvNa7Ut5PK0nFSMoyMg2sXhSlXrKPxlQDSWSv8ASTE0+RbKT+SJi
         qxWyEPjhvs16mxncaY8r4X9QfxNgpQZx+VqgZNIyOs6RQpn/4sMiMxTrx22VvBUFlbmD
         SA11FVYky/5ZEs2RkEWrJN7R2Ox6+fOIswzbSBTgAUZL2C3LuhxCx6MaDSQUkqpwBI01
         FinWwR7CVubRyk+x28kV2xMzj/+VpGscxdScn3qvwmIjQlm2DSXQW0jDqJhl8QUKxoZq
         EKgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711391317; x=1711996117;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kiunE8pTzAniAwJdofUTsPhWLKKG+ApktTjbMuShmFk=;
        b=VGnjSKwTQnRoQRfTffT/U9vraVyjWa5K3zocSdd2+ZPMPokcPyCKADUVtMWjix1RUU
         KJLve4gdAKxYVg4JAmaW4I2XNVwbw1G3bDMtp44eZfU9kL6LPXq9ohTVj6zZKWtlOhpE
         TjGrnuUeSuy7/WCmrV2xVMQo/mj+oteN/gVxQVB3vITkiUiCavVP3UCe1x6HEiQdchS8
         eBoa0Hy9YEazeQsAJ1lujpNlE1CggCSq5lvLwJ3d0gUl8VrECn4osjSVIRYzg3Bu4arZ
         Y/gxj5QGaOK4szOm/m2rsM6+FBDWaP5rmKRd3Rmeu9HYuIpSRcqMVjFvi8sBGFTii7by
         qlQg==
X-Forwarded-Encrypted: i=1; AJvYcCWqL51hHKpytBeF7xZMpi3/OFqbnm+IEVYlp6V4tLlSNCqMsVv2TyUEutVnbmnLW4+AufbW9gATo4kH+EQNHTprFkYYMCr3Z8irCpIB
X-Gm-Message-State: AOJu0YwHA5cE/mKaNQOkoGF53l7gfel38Os+T98cobBgQNU7J8LdsIBO
	FQgiOhTsFvtgz2th3JeqCRzjj364oFHX81YjkqCQZPO4gX+BZ+/FWa0MIz3wKNc=
X-Google-Smtp-Source: AGHT+IGoVm3Ms3hw3viEDchx01zbvJmITmSDfRih31jEvDnsXz7YGpYu7TX3K8XBiq6vcJl9uiKhfg==
X-Received: by 2002:a05:6512:e86:b0:515:aa18:4b0a with SMTP id bi6-20020a0565120e8600b00515aa184b0amr4057714lfb.25.1711391317300;
        Mon, 25 Mar 2024 11:28:37 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id a10-20020a170906244a00b00a46ab5aaffcsm3320007ejb.178.2024.03.25.11.28.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Mar 2024 11:28:37 -0700 (PDT)
Date: Mon, 25 Mar 2024 21:28:32 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Boqun Feng <boqun.feng@gmail.com>, rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] rcu: mollify sparse with RCU guard
Message-ID: <35355d02-3eef-4860-847b-b7bbf05f4a31@moroto.mountain>
References: <20240325101626.41584-2-johannes@sipsolutions.net>
 <ZgGnuFJiTX5laS7c@boqun-archlinux>
 <055111792727869a98c1fa693014e0b6f5d256ea.camel@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <055111792727869a98c1fa693014e0b6f5d256ea.camel@sipsolutions.net>

On Mon, Mar 25, 2024 at 05:41:22PM +0100, Johannes Berg wrote:
> Also __acquire()/__release() are just empty macros without __CHECKER__.
> So not sure the indirection really is warranted for this special case.
> 
> I can add a comment in there, I guess, something like
> 
>  /* sparse doesn't actually "call" cleanup functions */
> 
> perhaps. That reminds me I forgot to CC Dan ...
> 

These are Sparse warnings, not Smatch warning... Smatch doesn't use any
of the Sparse locking annotations.  Smatch handles cleanup basically
correctly at this point.

regards,
dan carpenter



Return-Path: <linux-kernel+bounces-52750-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ABCB849C44
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 14:54:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 085E02822B6
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 13:54:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4C2121379;
	Mon,  5 Feb 2024 13:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ET41eN6M"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80AB022EE0;
	Mon,  5 Feb 2024 13:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707141241; cv=none; b=PlGdfYRWJD1bMwdg4Wyq6k1GrjQjR6sBwVQlO78vQhtGsDficeuBzIObSPakyQeAP6ATpZGKSonDjyK5ox0u0SntQSuByz6LQos/FIouqopEKFy4xSY8yWWTFMjKeMoN6r8MveMDVXilvYKM+9BwaNyx0efKVpqylQvAqK7G7Cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707141241; c=relaxed/simple;
	bh=f648wEW8Rvm4NKQat1t4yGsYZI6+ObAURygqAcDOgF4=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RsGEJcnbVb6iyFU46XPVY7ifJiNN7LavqBx1/5gOQDFNGELXVUAVf1qVT2cMXHMWWOyDnaN7qOnskoPOaNAO5GLhRoCsdHApdZbJ73SJeiJtzv7CuTqKZLwElDsMVDJSKFAtrKtgJ4n/oT0NBfktWZKFomt2wYnCfEuaf4lyJII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ET41eN6M; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-40fdcae97e7so6147165e9.1;
        Mon, 05 Feb 2024 05:53:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707141237; x=1707746037; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=30yadIsDStHvOTrhktHdJDsPyIBrn+aKYbB/Yn8bu0M=;
        b=ET41eN6M6WIY8u6KkLyeHCbMITBbPLFCXyAqy/HdomGlQ65oy17Dfrlb0yBrp7L8bd
         SCLifYctnKpSGEw1iLQKDQ+AN/4xs9w4IjPSSH0U34Y3JP3QjhFMCAlpzhgAM9oJrNo4
         7fjmNtceEFZrBuwmGMq7oCMXVs+p0TqTtqvt4B2sn8C41nGvVf99dQs/j/7dVt8ov0Vb
         MxBkmXF3KasWYpDp7rOOyHPmV+b280TiZkC6VyoIIqvfWe8IufKWnXmR7XH5jcrbAs8X
         YNMsEVRWwcotSxD+JYhG6trdLkFu+epzVEvWh9XeQazbdjvX24fI5eJpmQadwaSoFxL8
         1pVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707141237; x=1707746037;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=30yadIsDStHvOTrhktHdJDsPyIBrn+aKYbB/Yn8bu0M=;
        b=wulBVWVKj4ep5M6j/Xxw1fHeYOK4pf7m40ctVnyBGU7yiAJQbn6iGPudDHHcj8INJ2
         zYlLk/koGsDI81Hj+3z4MV4adCaRJ2v7voPK6oC+YFBjTsXyjpgEx/y4dZ8tZDZKax9e
         U9qhF5+A4dm16ypucYNMgXHMOm3tkSzUbtIp/pYPYd0L/BybY38A7trb4bflS+BwiuLi
         KKRyXjmejCFV/KdRdEDpQPtSBq32ctZs3X4c6CFNJwMnL0PJCnTEVBWfBgwBckzj96ZR
         4Rd7GoV2O/pjapGSapZjIJuX95uUfQEnv7RGuB4GH7bWxRrAxCbTJegBPi2HYcGmdgsW
         gUDQ==
X-Gm-Message-State: AOJu0Yz9MzHeHmOxUpoE8of9HseO5EpfQUsct8D6sccBITztoDfSswpi
	KLjjSmN/z9KKGwlCB9kBolwo2AXCUSvaL5Is9pT+ESQ+KyQzArBo
X-Google-Smtp-Source: AGHT+IFmgTvn6TSYIIQiJRsnUkPWETIb7bkywt067eIUtWA1QczsGaff9vPSvZm8aRGuuHrk6D0IMQ==
X-Received: by 2002:adf:e242:0:b0:33b:24c:ace6 with SMTP id bl2-20020adfe242000000b0033b024cace6mr6842518wrb.11.1707141237328;
        Mon, 05 Feb 2024 05:53:57 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUBy9InCGZO8lypAvB8CCJY5Ve7O6UknUG+AOmL8yj6r3jo1RufBWA3rtJcIuUpmljRqx3nOI968M0nDFGi32NN1CqpAUJbwpSpjlnBSN0KsKXCkE6PxuGePmiCoaR5Bj3SBXTK5n9YewH9ddG82nMXECYDK1tUCaFJ6XaynUgpHbjgTs9CHFgluk582mUiVWG42h2Jf7Hr5NdV+focdawPETFZkZGIRKEamEGyijuwuvQf4DT2a/GKOxPHvHJ2OlKqYr5jBoUaHSEd75dWy3k+2XI4cU4Q96FC8or5lFtD5AjQ8LC5h3kVgZe1eR9Gp/139FSIjl4=
Received: from Ansuel-xps. (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.gmail.com with ESMTPSA id u7-20020adfa187000000b0033b421e651csm926538wru.37.2024.02.05.05.53.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 05:53:56 -0800 (PST)
Message-ID: <65c0e874.df0a0220.257a.43b1@mx.google.com>
X-Google-Original-Message-ID: <ZcDocaeTz8GCOYFi@Ansuel-xps.>
Date: Mon, 5 Feb 2024 14:53:53 +0100
From: Christian Marangi <ansuelsmth@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Lee Jones <lee@kernel.org>, Pavel Machek <pavel@ucw.cz>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Daniel Golle <daniel@makrotopia.org>,
	Li Zetao <lizetao1@huawei.com>, linux-leds@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] leds: trigger: netdev: Fix kernel panic on interface
 rename trig notify
References: <20240203235413.1146-1-ansuelsmth@gmail.com>
 <8d51f09b-e6d2-4ee1-9e7d-b545d561798a@lunn.ch>
 <20240205085007.GA19855@google.com>
 <2cf84815-f9b6-4a0a-a3b4-d23628a89aa4@lunn.ch>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2cf84815-f9b6-4a0a-a3b4-d23628a89aa4@lunn.ch>

On Mon, Feb 05, 2024 at 02:41:46PM +0100, Andrew Lunn wrote:
> > > This should have 'net' in the subject line, to indicate which tree its
> > > for.
> > 
> > No, it shouldn't.
> > 
> > Contributors aren't obliged to know anything about merging strategies.
> 
> With netdev, we tend to assume they do, or at least can contribute to
> the discussion. They often know about any dependencies etc which could
> influence the decision. When there are multiple subsystem maintainers
> involved, i tend to use To: to indicate the maintainer i think should
> merge the patch, and Cc: for the rest.
>

I'm always a bit confused when I have to send patch to mixed subsystem
(not the case but for net trigger it's almost that). Sorry for the
confusion/noise.

> > Why does this need to go in via net?
> 
> It does not, as far as i'm aware. Christian, do you know of any
> reason?
> 

This is strictly a fix, no dependency or anything like that. Maybe using
net as target would make this faster to merge (since net is for fix only
and this has to be backported) than using leds-next?

Again if needed I can send v2 with the correct tag for net subsystem if
better.

-- 
	Ansuel


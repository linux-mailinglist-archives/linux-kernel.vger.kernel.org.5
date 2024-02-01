Return-Path: <linux-kernel+bounces-47863-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0A0D8453DF
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 10:30:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 833D5B220ED
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 09:30:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08BFC15B0F9;
	Thu,  1 Feb 2024 09:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FHwRg8MB"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B039015AAB9;
	Thu,  1 Feb 2024 09:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706779793; cv=none; b=Dd5boGBfVCychg2s2cvNehrSdC2BQ7mJAe/4EMDnKMRgM0mZgKqllhxzX3oR5QEuYaFgd44ISial0B2mGl/XJw4nRvErENhokQRvoH4Z/mT4Cm9jdu9ZpHS9F64zwComNFGobpfk3y3itonGMuX/zNRhMTDB9/gUzBPFhKKCdD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706779793; c=relaxed/simple;
	bh=+NCwuuUEC8gh4wddwJD1ZoXxyVyQK76LQS+PgiYO2+g=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BWF4TTGOLbE2HPkofwtXghHTmELIPH/Y7PU0WIYokOEmYLWpbtl4AGr+H6iIRH01wh4hshWTXryXgREAicAePBN88cET1EDdFj6k2iiR+Et68VDdncrbE7TrBclZne1wIaa+Isf8MUI+GF+UUIcu20RETB0+EeKzszRpgog56TQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FHwRg8MB; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-51124d86022so1133758e87.0;
        Thu, 01 Feb 2024 01:29:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706779789; x=1707384589; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=gR2SCc4BIE8sv2cc5ChJ04+ZAy4Os5pvthMcTA+RFl4=;
        b=FHwRg8MBbZz9LTfqahu/eeaEIoEL2gZun3E5ETN0LDqIh3ssanfBB4adiY4/emZMrQ
         knFxAwUaA8RfhZTlrgCZVxO7KV3ChwZ3+zk7ArnTNi3akAavIrAD5tSeNKMwtJ26FLge
         EHgiEZQ2N/TlzlrJynns/8ZjuFXU24/HSDxfMkz+lzOf+nXhTNM7brCALny4BICGY3tD
         ByXDYXf8WrVgzDhbW3D76T+MVd9e74m3KkL9+9N+cf7qhfwCvTxqkKwlRr0XPOpX7r6k
         PKnhkxE2I8rp095ta8kFngzPKjGqFB1cCHBpumGmvCG1Ihja35wRyd3Gb8r8jwS4fJ1s
         E4DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706779789; x=1707384589;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gR2SCc4BIE8sv2cc5ChJ04+ZAy4Os5pvthMcTA+RFl4=;
        b=iTn1SNxFeyHfL7qT2eL8sHAjafTcWZY1bowsL9zOMv1R9BKqPPnH2stft7H4cOEnD2
         +fXEqyu4xRCvl4VpO8CvFYUoFLOc5IMM2miiX79icew7VETo5tDQDVaKyHVHCZ4QtAM3
         czoBMqYqvEE1NbdLJ/m746pUUYOKvc6jOa8SFre3UYXi17+sPdCiyk4BFhh8Fw57+lYd
         3bYt5Uk3pNoz59CpxLjeLsEQQVQPxHd/lariZiv+vBSAkeKatr6px2Y1MX01vXJCygtA
         P2x+PwbAaaOJnyJtyC1YSQIH6vCkYBw2sFJwayL3reXftQOWlsoBFtyYTyFmP0RkHcZi
         /jZA==
X-Gm-Message-State: AOJu0YyVOBGEne3W/V7dZJHe50cFsEkl6ItstmVAxdKCpYNVy0EkUo7D
	1hZBuAcTq16uGKw8HgMIq4ixyixoMFpBeXKiLpE3sXZUJpTwV5d0
X-Google-Smtp-Source: AGHT+IFbfqsdGNQ6Wd46t2iNvuziOkb8PC1smvpxI4cq1BjUl4UTFC/HQ0I0EBborC1Ks4Nt1NmrTQ==
X-Received: by 2002:a05:6512:21c1:b0:50e:6b5d:5976 with SMTP id d1-20020a05651221c100b0050e6b5d5976mr1296346lft.40.1706779789357;
        Thu, 01 Feb 2024 01:29:49 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWqnYUTtWXGe3JQ3yFJz0StJ0H2XP76LgcJO3yNTUDd3r5jlndDZgz1LhqosHGqFg1UCaI8VuwW7z73Ynx1FhROro2avzqUVaiRi/6RKSKsKqN4ZtOZLRTtIoqO14upwk8SulrX4cdu3+lBVdfrQ+dppF7DHp5BQ1TOmwjZUixp
Received: from akanner-r14. ([77.222.24.25])
        by smtp.gmail.com with ESMTPSA id b25-20020a196719000000b0050e74ec73f6sm2177203lfc.124.2024.02.01.01.29.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Feb 2024 01:29:48 -0800 (PST)
Message-ID: <65bb648c.190a0220.d431d.4f63@mx.google.com>
X-Google-Original-Message-ID: <ZbtkigG3xRB/hSto@akanner-r14.>
Date: Thu, 1 Feb 2024 12:29:46 +0300
From: Andrew Kanner <andrew.kanner@gmail.com>
To: Christoph Hellwig <hch@lst.de>
Cc: mcgrof@kernel.org, linux-modules@vger.kernel.org,
	linux-kernel@vger.kernel.org, mchehab@kernel.org
Subject: Re: [PATCH v1] module.h: define __symbol_get_gpl() as a regular
 __symbol_get()
References: <20240131190251.4668-1-andrew.kanner@gmail.com>
 <20240201052958.GA14943@lst.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240201052958.GA14943@lst.de>

On Thu, Feb 01, 2024 at 06:29:58AM +0100, Christoph Hellwig wrote:
> On Wed, Jan 31, 2024 at 10:02:52PM +0300, Andrew Kanner wrote:
> > Prototype for __symbol_get_gpl() was introduced in the initial git
> > commit 1da177e4c3f4 ("Linux-2.6.12-rc2"), but was not used after that.
> > 
> > In commit 9011e49d54dc ("modules: only allow symbol_get of
> > EXPORT_SYMBOL_GPL modules") Christoph Hellwig switched __symbol_get()
> > to process GPL symbols only, most likely this is what
> > __symbol_get_gpl() was designed to do.
> > 
> > We might either define __symbol_get_gpl() as __symbol_get() or remove
> > it completely as suggested by Mauro Carvalho Chehab.
> 
> Just remove it, there is no need to keep unused funtionality around.
> 
> Btw, where did the discussion start?  I hope you're not trying to
> add new symbol_get users?
> 

Of course not, no new users needed.

I haven't discussed it directly. I found the unused __symbol_get_gpl()
myself, but during investigation of wether it was ever used somewhere
found the old patch series suggested by Mauro Carvalho Chehab (in Cc).

Link: https://lore.kernel.org/lkml/5f001015990a76c0da35a4c3cf08e457ec353ab2.1652113087.git.mchehab@kernel.org/

The patch series is from 2022 and not merged. You can take [PATCH v6
1/4] which removes the unused symbol from the link.

Or I can resend v2 with my commit msg. But not sure about how it works
in such a case - will adding Suggested-by tag (if no objections from
Mauro) with the Link be ok?

-- 
Andrew Kanner


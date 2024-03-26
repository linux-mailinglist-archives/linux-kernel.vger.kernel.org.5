Return-Path: <linux-kernel+bounces-118438-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D748388BADD
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 07:59:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B3A41F3A9A9
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 06:59:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60397129A65;
	Tue, 26 Mar 2024 06:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FMnBGkri"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB46B12880F;
	Tue, 26 Mar 2024 06:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711436378; cv=none; b=dGr0L78DABJ/Ml/rPtnM0q5fLgazIclofUn5vgxYyw8ZPulpX+Sgyc4JedwY/cqF6FzQPHcPQyQwT66h3M/XQHH+XXUGwlhArEOgZLRj8JKPBB8y+RTHHZ3beat9BgFofVH7aXmrA2deE1iAcH0J2e3MzkbZg1VSosuwWF/9zmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711436378; c=relaxed/simple;
	bh=9bnvoj6q4JRR1lYLLkAWD4fYP4y91/3k3df/uRd0GKA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n8IkCyglfd4aK8epBqD6Whm+8lsziBjlgfgRMbJWnycNs3xZ0FmM7RiY6K1a8eTI5cXkGqp81fA565TC0zrtoqnAtmSlGDNn2w2Ikolx+2ZSoi6G22Rr2FrAc4KSqTrVPEUJub6pT8vDVqHNcqf/3YHyrBxxOT9xhtIVmoY4t2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FMnBGkri; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-513d599dbabso6763975e87.1;
        Mon, 25 Mar 2024 23:59:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711436375; x=1712041175; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Adrz2UKt91HT9UEqTQ/lxgqrvfLugF+WBz3CLKokIek=;
        b=FMnBGkrinYL2PBCPQke2aEI5hw10ATWLqtpVWFVpYcMIIgZz/px6p6JH1tho/5pi9U
         YBbBPOrrBZ3RxuuPCjlevxgGjoOYKKxEZdhD2VnrZpGTxBm3PRVok4sdyky80f/yJrcF
         fwucQf9T/+sqYEqZxj8tJ/PWKCn8HaZXzHCBZ8dpRXz4RWV9kvLNeYSac1mBbrXtTu37
         A+Vy2L1EHIxoNibw3jNXlyGEEb0+TypwTBJTcOBUyrBuB009Uj6ucXrtiBU+Qkmw2ktb
         4jLu3KlBUJo/6NBbj3PHnIqlAY88gNgQKfJEhPjvaQJGPTF70u8q35JXHO5NvlSuLv+1
         goEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711436375; x=1712041175;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Adrz2UKt91HT9UEqTQ/lxgqrvfLugF+WBz3CLKokIek=;
        b=YtGsvlE+HpGqphO9nn/bj6Brcol0/H1PXOoWBCP/al+2KY9JYD9AyFK7yWRJ0sfxcq
         +xwZIh1N0WOusC5dISqHussSKupBy3kbQMFwxg1/HBtBPs7qO15iBUegPFVwDjPpXgjw
         i5nZQB0xMZ2kXBEjBSqZ32ZZ2H+d0xDnaACxR9Audy9mThB6ZBzzDjRtEnC+IWH0zMCp
         d6+ySpUTUISV23zum/8mMR6zB1Sl+HxPU3udVMV5+UCByhnlfjl+FOPQBgym+kUYuipi
         dRgAtzKSOC4nGEdpnE5WCawId6zkNfHZPGTo2WtMHWbIqfisyuxHpbmP1Fk56ph4Y/PF
         o3sA==
X-Forwarded-Encrypted: i=1; AJvYcCX2KN4vJhpZJKlWr3wVNTrNWeBaU3RCvgM0Q/fKpyL2IqO6Yj68lWiQU4GKOQxMcXUCPs+5Xax1/oc69KxMIvnS4zfERSx0
X-Gm-Message-State: AOJu0YxEO03hQVnm6fJ9EA1aqbL4mkT+sD5taVfJ6m1Lk/QiJxHt1zdK
	rLBIOMaYPGKGZl3kaTpZNoF5xRBLWVOofQq4U2UA99tTDCTq1EXX5EsDms1tBXg=
X-Google-Smtp-Source: AGHT+IHJULcSjGY+2bfyPb37+1IpdGS93hSu6EOR2DCrF3wM3B3CsDCg0CoiF9OxOaVfokBUw/D5uA==
X-Received: by 2002:ac2:562d:0:b0:513:3214:ae03 with SMTP id b13-20020ac2562d000000b005133214ae03mr5392450lff.69.1711436374672;
        Mon, 25 Mar 2024 23:59:34 -0700 (PDT)
Received: from eldamar.lan (c-82-192-242-114.customer.ggaweb.ch. [82.192.242.114])
        by smtp.gmail.com with ESMTPSA id e7-20020adfc847000000b0033ec91c9eadsm11320418wrh.53.2024.03.25.23.59.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Mar 2024 23:59:32 -0700 (PDT)
Sender: Salvatore Bonaccorso <salvatore.bonaccorso@gmail.com>
Received: by eldamar.lan (Postfix, from userid 1000)
	id F3A67BE2EE8; Tue, 26 Mar 2024 07:59:31 +0100 (CET)
Date: Tue, 26 Mar 2024 07:59:31 +0100
From: Salvatore Bonaccorso <carnil@debian.org>
To: Sasha Levin <sashal@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	torvalds@linux-foundation.org, akpm@linux-foundation.org,
	linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
	lkft-triage@lists.linaro.org, pavel@denx.de,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 5.10 00/73] 5.10.213-rc1 review
Message-ID: <ZgJyUxKgKhjVTqI5@eldamar.lan>
References: <20240313164640.616049-1-sashal@kernel.org>
 <ZfNwZ2dqQfw3Fsxe@eldamar.lan>
 <ZfSV6RVweBOlKZW_@sashalap>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZfSV6RVweBOlKZW_@sashalap>

Hi Sasha,

On Fri, Mar 15, 2024 at 02:39:37PM -0400, Sasha Levin wrote:
> On Thu, Mar 14, 2024 at 10:47:19PM +0100, Salvatore Bonaccorso wrote:
> > Hi Sasha,
> > 
> > On Wed, Mar 13, 2024 at 12:45:27PM -0400, Sasha Levin wrote:
> > > 
> > > This is the start of the stable review cycle for the 5.10.213 release.
> > > There are 73 patches in this series, all will be posted as a response
> > > to this one.  If anyone has any issues with these being applied, please
> > > let me know.
> > > 
> > > Responses should be made by Fri Mar 15 04:46:39 PM UTC 2024.
> > > Anything received after that time might be too late.
> > 
> > This one still has the problem with the documentation build and does
> > not yet include:
> > 
> > https://lore.kernel.org/regressions/ZeZAHnzlmZoAhkqW@eldamar.lan/
> > 
> > Can you pick it up as well?
> 
> I'll pick it up for the next release cycle, thanks!

Did something went wrong here? I do not see in in the current review
for 5.10.214-rc2. Can you still pick it for 5.10.214 to get
documentation build working?

Thanks a lot already,

Regards,
Salvatore


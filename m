Return-Path: <linux-kernel+bounces-60729-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 082458508F9
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 13:30:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6BBBB1F2147B
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 12:30:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC9DB5B1FD;
	Sun, 11 Feb 2024 12:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P/wnW/73"
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6B9B59B77;
	Sun, 11 Feb 2024 12:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707654610; cv=none; b=lrvFcZEQB1U1w6TdqH76v7L22Xghcp0zBeaAV/qfEBl1LzDf7kRJfyvQqbqa4RlE45JmAfq0p8mBw4jQEzySkKn/ek0ipUHfrBnaN2wVY2RNz+ABKFlYYCXBNKZR+/1Hx4xYAndDrz3Zd1bKoq2wmGbpRAxrxy5l77Sr47wjI9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707654610; c=relaxed/simple;
	bh=ky+RAWf8J8vXkQ6HF5HH603Fg0/+EkBj84w84UXqyY4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lEXyUFUQOlVn/SzD96AGMLbWDLs8aP9Zab0qFMVPAbqlR5hwJSSEyxZIGdQ2JK9lO7PMNM+HxRlWBhGzeArBjP/knUvEtqmmHVAP8ZI7uLR186x78RvY6+qcHx27woS80rw1PVl3kkWwl/DCnwxw/e9hAC9EbSa7xzTHq0o6gsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P/wnW/73; arc=none smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-3bfdb84c0ebso1109101b6e.1;
        Sun, 11 Feb 2024 04:30:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707654607; x=1708259407; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yY1B5EOzgtD2gnfK4gYntuGm53FWM/Oxlr8jej3jl3g=;
        b=P/wnW/73+i6FUruOE679x/7LB3UejkU92aLoXbcYLr2mjWEiBXyiSojDzM1YdsE2XV
         +V9m3qdA4TvZIiaQ8lLIPs/otd4e0PZbM1CXTL0p1e0iCjpMpcR8znRv/oV+PhS7z5lp
         3Fgbq3hgsvxvDa+SPoK6FHRyhVyiKXjAqyXd137GRhn9scMl2q/hwf/EJf2z9lyU0bDJ
         IrJgyi+oEp06EDiCHtFdWtvaa6JrPLsaRnH1aSt5Vq5cAC2Hq5fndGpSVJwTbNCgXlFv
         GjBzguLaROD35KMhq2cPR6aDMaJUxM2kOnnwnoAcsIUHnmvm0+11jib256fth2/R13ib
         6igg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707654607; x=1708259407;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yY1B5EOzgtD2gnfK4gYntuGm53FWM/Oxlr8jej3jl3g=;
        b=lgixtSQpdTitFJ4KnzKWo5lW8xxS5V45FTJyJJkmq+4dvE+gKqviAHXOsefVInp/eu
         TbPQ6FdGCTn0mMbk27gItbiC2NYm/QYWGGkg6GVRd1f6OjLC/NuOHWIlf1hTxgszdQkU
         rRYAYd4Q3Sh94F1FSt5SgfHDCgn7kBsPnGcU11PHSSvG7dHJ5gisY6Rl8786u5x2D0zW
         nBJMNSfSEuZDUeOEltUq2CsW8p76zuTtyi7PMmhwzOGhD9gnsb2Dg7YMFpzOk2Xre6iv
         Nffq1e10wju0f1Jlo8j7BNrEfa7tHGbbGAouddLvgzxHFCV9W3ukGHcCKvCSKyqC38fg
         hGOg==
X-Forwarded-Encrypted: i=1; AJvYcCXm1UhGA9NBdpqmEOjo3QMlyppwm4ppjqfEwqDX3fL0ksX4B1qYtBEGyxTLlqVLXnt7kBBOIOgirE+Nj+LzmwdYQRP1KNbTi6spalRtPOr4Ce1PXInj+ZgbiUp+B0Tu/LzcBoaT8l4CLhXSSCItCEDgXcYOo3Lb8o13ksKVe1JAiPeHnwo=
X-Gm-Message-State: AOJu0YwjRCWlv8lbBVTl8mb5g5MqrhybSKOhJ7TCn6jrorkGK+l2EAtN
	BIeBnR1McEcvTgesv7Kt9PhRu8TIQbN4UnFjQdXGNNCivf0G/OSZ
X-Google-Smtp-Source: AGHT+IF35wU7oQHIL1WAqzc2rw7d/zu+t9GZ4FvO8SQu/9DFopyNSSZKv+8ggBOG/7GT5mlted3Y9A==
X-Received: by 2002:a05:6808:140d:b0:3bf:f233:faed with SMTP id w13-20020a056808140d00b003bff233faedmr4915160oiv.39.1707654607542;
        Sun, 11 Feb 2024 04:30:07 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVGidnzGiLsb6tQWbD8jVvfID7bmIWxsQ7LOgUorrYLJEaiUrJv0xahtK6LablJrNmqpUrSXEnBalbh+qvMv3LF8MyasuPWlrR+/sxfTT3q1+tI0GyXxJ+F7VRvMRBR0QVpkcu4f4XjIh3xXzYbHaGJOF3iIJpt6QC10BAh/wq0+w0Q6LUKK/5SrRvUUfZRr5jXkW2j2ZfUiGmzdLeulJE6myhcW1jIY1cxrp2MtF3MN61TEXExikyVwXxKG58nXb2vdo9e6cDRsHfp9wudgSWy3yBGcRsId7OHh80dUEkYv/0esOS+VUwz27bjyrajRMZKMzn1gqwMvdATdxYIreljqMOSWYC2Ln4AVY9fykPdXY0dortluwrhM3bxQZG5pWFDJqqIy1l1uRxSGFYaoWH0JQWgVo+AbX+K7jpk7x5vJ0Vq0qOsMRmLcwfQEMo8unz+kTx8CwLEyd3AnyDMlMSZzfMMWjXo67+1DWDz6JKKVuHaB8VY
Received: from primary ([174.95.13.129])
        by smtp.gmail.com with ESMTPSA id ch7-20020a0561300c8700b007d2eba3ad17sm653128uab.24.2024.02.11.04.30.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Feb 2024 04:30:06 -0800 (PST)
Date: Sun, 11 Feb 2024 07:29:56 -0500
From: Abdel Alkuor <alkuor@gmail.com>
To: Lee Jones <lee@kernel.org>
Cc: Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Lukas Bulwahn <lukas.bulwahn@gmail.com>,
	Jean-Jacques Hiblot <jjhiblot@traphandler.com>,
	ChiYuan Huang <cy_huang@richtek.com>,
	=?utf-8?B?QW5kcsOp?= Apitzsch <git@apitzsch.eu>,
	Alice Chen <alice_chen@richtek.com>,
	Jacek Anaszewski <jacek.anaszewski@gmail.com>,
	ChiaEn Wu <chiaen_wu@richtek.com>, linux-kernel@vger.kernel.org,
	linux-leds@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 2/2] leds: Add NCP5623 multi-led driver
Message-ID: <Zci9xE5uHRJGMg5q@primary>
References: <20240203175910.301099-1-alkuor@gmail.com>
 <20240203175910.301099-2-alkuor@gmail.com>
 <20240208130115.GM689448@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240208130115.GM689448@google.com>

On Thu, Feb 08, 2024 at 01:01:15PM +0000, Lee Jones wrote:
> On Sat, 03 Feb 2024, Abdel Alkuor wrote:
>
Hi Lee,

Please check the inline comment. All other comments will be addressed
in v2.

> > +What:		/sys/class/leds/<led>/dim_step
> 
> The step principle seems a bit arbitrary.
> 
> Why not provide the time directly?
> 
> dim_step_delay?
> 
> I already see documentation for risetime and falltime.
> 
> Perhaps that will omit the need for both direction and step?
>
I'm going to drop off both and use risetime and falltime. That being
said, the documented risetime and falltime for lm3533 use steps instead of
entering the time directly. This is my first time doing this, should I document
risetime/falltime in sysfs-class-led-multicolor-driver-ncp5623? or should
I update risetime/falltime in sysfs-class-led-driver-lm3533 to reflect
risetime/falltime for ncp5623?
> > +Date:		Feb 2024
> > +KernelVersion:	6.8
> > +Contact:	Abdel Alkuor <alkuor@gmail.com>
> > +Description:
> > +		Set gradual dimming time.
> > +
> > +		==== ======== ==== ======== ==== ========
> > +		Step Time(ms) Step Time(ms) Step Time(ms)
> > +		0     0       11   88       22   176
> > +		1     8       12   96       23   184
> > +		2     16      13   104      24   192
> > +		3     24      14   112      25   200
> > +		4     32      15   120      26   208
> > +		5     40      16   128      27   216
> > +		6     48      17   136      28   224
> > +		7     56      18   144      29   232
> > +		8     64      19   152      30   240
> > +		9     72      20   160      31   248
> > +		10    80      21   168
> > +		==== ======== ==== ======== ==== ========

Thanks,
Abdel


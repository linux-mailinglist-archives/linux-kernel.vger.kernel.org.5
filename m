Return-Path: <linux-kernel+bounces-103863-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 54B0F87C5E0
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 00:23:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 85E451C2149B
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 23:23:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C06C101F2;
	Thu, 14 Mar 2024 23:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TGGDFYBv"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D62EE7483;
	Thu, 14 Mar 2024 23:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710458575; cv=none; b=oolDQ4cDvWQHpZFnJsNWciU6/pwDaeyLgLozkHak19nVV4d8XbnNPeZctr1Ate+7aKeNMD4WeWyczrgp0IkUgcV6A1TbLLYVCRDeMAmXVbMjnCeWXcp34X60KvBMhD/ChH/Zj7ylaskIbSScr6H2XiDZs8f1c5MGaRvy8v1H1wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710458575; c=relaxed/simple;
	bh=ebW77Cq0ykeHSF9zIHkxJMfuD/RbWc017L6+v1WhjMQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QYHCDydZVsPQ+A/dzuO89mpl4J/gn77dwIVBQRguxRf/J1qgWQqHZdEvBgpHv3MrJVG2ZU71aCRjjDuiBHCPrGdt5N4D8XsUUhEt7Fy7dblQgCKNXYD0dO4f9uz4VEssxP0H+e2TF/HSjiLgkYz6FTdd9YOVz+vfU+Z9N6ievo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TGGDFYBv; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-413fead1b46so2571795e9.1;
        Thu, 14 Mar 2024 16:22:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710458572; x=1711063372; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ebW77Cq0ykeHSF9zIHkxJMfuD/RbWc017L6+v1WhjMQ=;
        b=TGGDFYBvxg6YlJskrCBmyyrJhGIVrZUfG8CyTwuutKBujgNhK2dh8usdxYG4cASbwV
         74XuBZwl3Z3Nlp8Iz7xps2xRANAU+tLUeVZP2ABycQWIqN5SsYbiqknsl7zNxmA6e2js
         ZRGAY4+m+eo8vJGU27QSz1Jtq56EbPJ9h9pXwCV0eVMUfxt2XSZe2Gi0biIwRa9xWFun
         YenLJbUCATZzNFOiFVGFqNhQAaxDIWRuqi/vGHyf5XfoDkwus87OZT2G86LdtzjGWkow
         LbtUEVk3pp7D+tKWAFeTWgNTLns17DV26lri4jKybp7Q6p2/vSW0Nc2FLsF/FwPs8IJv
         FPLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710458572; x=1711063372;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ebW77Cq0ykeHSF9zIHkxJMfuD/RbWc017L6+v1WhjMQ=;
        b=FehFGCtSCQmXtuE8/DsfoYblwaMlQUR2aarqyIzVF5PhSJfvlLAakxPXhgmu/rrFxv
         wnJah3F4VAJKWf7HVaa3qE+2N0La8wMUwyMuhFblvu8Gt9zZABKZkMtalWcSscR+LvOl
         d/GKRKM8X1vwjshYOa+/mU+sjG8eP21L+j3cXOd/RBs4OslvqNDs291PbU2p5d9f+v9M
         MPVCmVzYm4ah2+S3/n+zKYiuTGPOiERtv/pkeTAbI2mitbq/RQaB9Cg5tIYFLCcuql+v
         NXfI3kGfkyyNoEa+dp+SKtcKk87C57SrFcqIM/thChcSMhYKDS+UtjAbQJIajD2JzJkF
         IGSQ==
X-Forwarded-Encrypted: i=1; AJvYcCU5yGYXIXsglo9E5Jz/jP5sozARgME+TMnRv9NxMO6MSuhl1ESTe+LtkO4n+2c0a2ivjaThcR6cFFTnoKFok+yG60863m82ie+gQksFD1IRqW51XEDb1BlwJO/zFfICmEzTELDVZqGj
X-Gm-Message-State: AOJu0YwiCudaEb9yya+vz5xyNQfeG1SxV2El7NHOzR9pTmHPpHrkSYIb
	YNBGfAUH+PVuTKx6Hr/JALqfrLBhXkApjAv1K/SdilPK7zgzCTFk
X-Google-Smtp-Source: AGHT+IHP+5rR0w7iVPHwmOrHbWmRoWOvQOKIUQFMX2LfaxWlPCOCYj036Y71am2TSqcuO8uWlpWzfQ==
X-Received: by 2002:a05:600c:19c9:b0:413:1f65:ec19 with SMTP id u9-20020a05600c19c900b004131f65ec19mr2413383wmq.37.1710458571916;
        Thu, 14 Mar 2024 16:22:51 -0700 (PDT)
Received: from [192.168.90.166] (121.red-83-37-9.dynamicip.rima-tde.net. [83.37.9.121])
        by smtp.gmail.com with ESMTPSA id u8-20020a5d4688000000b0033e3c4e600asm1777808wrq.7.2024.03.14.16.22.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Mar 2024 16:22:51 -0700 (PDT)
Message-ID: <46389801aeb20f18affed86d979aff7a62cf36d5.camel@gmail.com>
Subject: Re: [PATCH v2 4/6] iio: pressure: Simplify and make more clear
 temperature readings
From: Angel Iglesias <ang.iglesiasg@gmail.com>
To: Vasileios Amoiridis <vassilisamir@gmail.com>, Jonathan Cameron
	 <jic23@kernel.org>
Cc: lars@metafoo.de, andriy.shevchenko@linux.intel.com, 
	mazziesaccount@gmail.com, ak@it-klinger.de, petre.rodan@subdimension.ro, 
	linus.walleij@linaro.org, phil@raspberrypi.com, 579lpy@gmail.com, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Fri, 15 Mar 2024 00:22:50 +0100
In-Reply-To: <20240314201718.GD1964894@vamoiridPC>
References: <20240313174007.1934983-1-vassilisamir@gmail.com>
	 <20240313174007.1934983-5-vassilisamir@gmail.com>
	 <20240314150959.585367b5@jic23-huawei>
	 <20240314201718.GD1964894@vamoiridPC>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (by Flathub.org) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-03-14 at 21:17 +0100, Vasileios Amoiridis wrote:
> On Thu, Mar 14, 2024 at 03:09:59PM +0000, Jonathan Cameron wrote:
> > On Wed, 13 Mar 2024 18:40:05 +0100
> > Vasileios Amoiridis <vassilisamir@gmail.com> wrote:
> >=20
> > > The read_press/read_humid functions need the updated t_fine value
> > > in order to calculate the current pressure/humidity. Temperature
> > > reads should be removed from the read_press/read_humid functions
> > > and should be placed in the oneshot captures before the pressure
> > > and humidity reads. This makes the code more intuitive.
> > >=20
> > > Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
> >=20
> > To me this makes the use of these calls less obvious than they were
> > previously.=C2=A0 The calls are made close to where t_fine is used and
> > don't have to go via the indirection of chip_info.
> >=20
> > So I disagree. I think this change makes the code a lot less
> > clear.
> >=20
>=20
> This was mainly driven by the fact that I wanted to avoid reading
> the temperature 3 times in case temp, press and humid are enabled
> and there are consecutive buffer readings. But thank you for the
> proposal I really appreciate it!
>=20

Hi, just a side note reflecting on this. Depending on your sampling frequen=
cy
and registers data shadowing, to avoid compensating with different samples
between readings, we should be doing burst readings to get a bundle of the
temperature+pressure and/or humidity.
On the bmp/bme280 and bmp380 this can be done as registers are contiguous o=
n the
memory. On the bmp580 this is not a problem as the values are already
compensated, you`ll get always the latest reading.

Kind regard,
Angel


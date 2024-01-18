Return-Path: <linux-kernel+bounces-30143-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DD6B831A5B
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 14:18:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C14861C22821
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 13:18:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA1CE2575E;
	Thu, 18 Jan 2024 13:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hMlQWnJw"
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B56D525757;
	Thu, 18 Jan 2024 13:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705583753; cv=none; b=Ee77hH3tF69pYyaXdlugTteO8UiiVUw0PkeFr48r1Efd4qo/Ose8ly7Xf6HnI7jHQnUQ51bFraWXhXXN0bhicqan7kv5RRd4qOcpJTSbEC2Q7I+g1IqAjVeWZSMQXeX6TYTkWAFH8WPleFYDIbvOaaJk2I+GEUr4124c8ei3YZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705583753; c=relaxed/simple;
	bh=gawuwuYzbbmDzTZtAr7RJ6aRIEt4uhR05OLZfhfBC7Q=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:Date:
	 From:To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:In-Reply-To; b=ZVJGalSYn+uTYcaOXLkqVq2iFCo+oKvU7BfAlhJzaX0FBwjYMHgK4jxJaXYfFB24b+SwD5vfuwGeDv7FCM4qSrCh6cuJR1nImAsmF5PG71Tjmbf7NjUtlE69SZjaptmUecWDZ1Rg3oWTp+niHoA31S5imXsCLCvh1GI/a6SwYtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hMlQWnJw; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-5bdbe2de25fso9606455a12.3;
        Thu, 18 Jan 2024 05:15:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705583751; x=1706188551; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=QvBNGC4E6LYR3uClPzVRaPdL+XA4Ac8k7SXynano+4o=;
        b=hMlQWnJwUJx+uZoFvcuFjhQeaL2i+2bRz5ruVq9ndoI/7sb1b/WH28YF93y4m2DuZr
         Q94ChiVWQMmJyfZPOqoMcvp3fm9tWr93gWDxojO9M17JSvL5NOT9tcLEWgSy5lB2ZEfp
         D90wNu+uDWqob6UatnfQcjqYxvo/vyg/x7w01CaES3j7CfUivTwy81UWwtzSClpJ6LIb
         WWBhqhIlBq4yKqFyOR2sTz3OXZZuhWu7ihX8LOdfRobP7TRe3GmLdFabF7qalyHbgrpB
         sUpJD8iuoBPkwQSb7g4qNE+yI+sBMzSVAV9aqPRy6f4jyEs//CDvuEakZj/3FX5yE93R
         vtfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705583751; x=1706188551;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QvBNGC4E6LYR3uClPzVRaPdL+XA4Ac8k7SXynano+4o=;
        b=OBwIWRyZiaG4HYU85w4pW3Qsz6s9F9xdYP5H+3Yk19uE2QE4O0wYHX7xESOs3m5Nss
         GJj+oR8JEGVIUNXLBLTUx7DFyizX4AH6LC7K3cdFTq84xnn+ZTUbTu5vKWFaHdDieP6s
         ZjBo38X32Jy4kBDp6Yli40e6dwFskYHKYoOk2xkr2l276WBq5/6KybGb/Z9W2b8xaiDy
         796EvbkyqFP/wwPNOWU265q0qsXq1XQjtCLYqYI98XzR++4Iu+aoKZ6UgXe/1tjxFmYn
         ymetOt8ewqKP8RG6artd3oC+pfHBLQbECWpjh6u0056GxqVsw4T71wUyx9Sy29wdGvav
         T1wg==
X-Gm-Message-State: AOJu0YwswFij3YAAn2bwhzokWDxfXt1SNScWYcJoH1LDA6YlUn0RVwH1
	gFtlKhnbbpx46wzMsDJKUxzTBwdNSPePKOWXhwPOwYQRd0iWKG1p
X-Google-Smtp-Source: AGHT+IHAVONmZ6+MFMXj+43/FB2TEST5KD9+09fDp0qwlttgosGJA3EFA9LZaeTjch4C4eCgsQgSYA==
X-Received: by 2002:a05:6a21:6d91:b0:196:ae4b:e007 with SMTP id wl17-20020a056a216d9100b00196ae4be007mr887739pzb.116.1705583750952;
        Thu, 18 Jan 2024 05:15:50 -0800 (PST)
Received: from rigel (194-223-183-150.tpgi.com.au. [194.223.183.150])
        by smtp.gmail.com with ESMTPSA id z189-20020a6333c6000000b005c66a7d70fdsm1455523pgz.61.2024.01.18.05.15.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jan 2024 05:15:50 -0800 (PST)
Date: Thu, 18 Jan 2024 21:15:44 +0800
From: Kent Gibson <warthog618@gmail.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Hugo Villeneuve <hugo@hugovil.com>, Bartosz Golaszewski <brgl@bgdev.pl>,
	gregkh@linuxfoundation.org, jirislaby@kernel.org,
	cosmin.tanislav@analog.com, shc_work@mail.ru,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>
Subject: Re: [PATCH 15/18] serial: max310x: replace ENOTSUPP with preferred
 EOPNOTSUPP (checkpatch)
Message-ID: <20240118131544.GA151488@rigel>
References: <20240117223856.2303475-1-hugo@hugovil.com>
 <20240117223856.2303475-16-hugo@hugovil.com>
 <CAHp75Ve5PYQTRdxcffdQvYWJ-iwvfEHfMnL-vhs_mv7yg+GJ5Q@mail.gmail.com>
 <20240117185909.78bb633ea090f74de9f4f3b7@hugovil.com>
 <CAHp75Vc5mePmXaAbsex6=tHeLSfSj5gZiE4_DQ0-5R-4h6=U5w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHp75Vc5mePmXaAbsex6=tHeLSfSj5gZiE4_DQ0-5R-4h6=U5w@mail.gmail.com>

On Thu, Jan 18, 2024 at 10:59:34AM +0200, Andy Shevchenko wrote:
> On Thu, Jan 18, 2024 at 1:59 AM Hugo Villeneuve <hugo@hugovil.com> wrote:
> > On Thu, 18 Jan 2024 01:24:11 +0200
> > Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
> > > On Thu, Jan 18, 2024 at 12:39 AM Hugo Villeneuve <hugo@hugovil.com> wrote:
>
> ...
>
> > > > Fixes the following checkpatch warning:
> > > >
> > > >     WARNING: ENOTSUPP is not a SUSV4 error code, prefer EOPNOTSUPP
> > >
> > > NAK.
> > > It's a false positive.
> > >
> > > > According to include/linux/errno.h, ENOTSUPP is
> > > > "Defined for the NFSv3 protocol", so replace it with preferred EOPNOTSUPP.
> > >
> > > The GPIO subsystem uses this internal error code internally. User
> > > space won't get it, so users may not see this one.
> >
> > Hi Andy,
> > I will drop the patch then.
> >
> > What about adding a comment to prevent future fixes?
> >
> > -               return -ENOTSUPP;
> > +               return -ENOTSUPP; /*
> > +                                  * ENOTSUPP is used for backward compatibility
> > +                                  * with GPIO subsystem.
> > +                                  */
>
> It's kinda useless to add it to a single (GPIO) driver.
> Rather it needs to be mentioned somewhere between
> https://www.kernel.org/doc/html/latest/driver-api/gpio/index.html.
>
> +Cc: Kent, Bart. It seems we have a handful of drivers violating this
> (basically following what checkpatch says) and GPIO not documenting
> this specific error code and its scope. Did I miss anything?
>

You are correct - the GPIO subsystem is expecting ENOTSUPP if the config
is not supported.  In some cases it absorbs the failure or emulates the
feature instead (open drain/source, debounce). Returning EOPNOTSUPP
would be unfortunate, so checkpatch is not being helpful here.

And don't get me started on the gpio_chip interface contract being too
vague.

There are a handful of ways this could be addressed (documentation,
checkpatch, handle either, switch to EOPNOTSUPP, ... or some combination),
but making that call is definitely in Bart's court.

Cheers,
Kent.


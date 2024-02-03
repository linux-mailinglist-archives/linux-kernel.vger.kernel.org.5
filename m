Return-Path: <linux-kernel+bounces-51122-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8799C8486CE
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 15:47:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9424A1C218EA
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 14:47:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4D375DF30;
	Sat,  3 Feb 2024 14:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cjk56h6j"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4E6B5DF2D;
	Sat,  3 Feb 2024 14:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706971671; cv=none; b=mDZl0G1gZqlM9hei+YCll5rvNSR5lEMnk6BWvyZe5igqOgCtDyXJ9j7m/JYNWOyPRzyzIaOaOXI/zXl2uExIKHJopHkJribXoxP75BnR2RXR4X9765bLB2A2hH87Ts0JoRJgypkxB6xxVXUIR4rTXf48gCLH8dMLQOmieEn+dL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706971671; c=relaxed/simple;
	bh=WrS2dcRTC+HzvMmzg/s2XGKCnqH0wn3Hvzn2UHEQrtU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hC9qNRgwgP9fetPn+Vi6hj/eVKr+Xvyc6hmtSG15v0ikRHjzBQ3PkATsJa0aYSDG1gqFiPloffgabcrNuUiksYqSgwwVQW18m0VCQ3wOGMTakTR/ottu4NOkex/Lx4EvnwwIlaTfhhAzof/sGrTu9C404ZWZKApwj3/EfqdZKW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cjk56h6j; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a293f2280c7so407650466b.1;
        Sat, 03 Feb 2024 06:47:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706971668; x=1707576468; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=eRjq0vxoeki2EVXduIrXDp/xRaLd0/tV0fmL5o/CtZU=;
        b=Cjk56h6jebczyUGyG+i1odwJLOSsCy2zODysCIfrlBFIULmF15bKu3QfnauS8wSNY2
         8SYmNIllgh/Efg7XXX/ONP1RpJzvne8U1bR+4BCArMrabHFxWbIqOndbTuHbLKDwQaKg
         s8EgAZ0rCGm5mno768wSWez2hSp/PYWQDa1mzxXSd8NYdOeJn2ZwEjtXwetiJgesrbmB
         iUNFjW92Z1yAQZ9VCUv459H1tpqPlDGNSjD7j3LhN8njQh9iPw1nwXbPBtk+RkuloHh0
         xdCT10B9U9dt7Jvjybs4Syg37wAgPMQx22yrYmXQl7wzhbsA5oNWNhQ+ztYGlVlvG1xw
         VF9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706971668; x=1707576468;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eRjq0vxoeki2EVXduIrXDp/xRaLd0/tV0fmL5o/CtZU=;
        b=amCldfmGAoFnEPYDjvK9spnz75Hu47zd/fPTnBWDtoLGneEB+RWJ03HFFZ7ZT8HtwQ
         Szi/JyWRCsZlVGyOutnZi+4yn7Rw/+qPTWaom/ObjIR+NrdE5++3nvcUQDTsw8sDSbvw
         HkLh3pdwQJeRZKfob+mOkdYPbuHeznjEf19pxJhYW6LJsNNVV17EtAy5KO200C61Gz4P
         RvkqAYZY5/CDqdJeOCtg9IzebgJSStQ4RkyG1n7t/xJzzs6kPw12u3f5YjKEtF3svkg5
         mET0zrNcdtnYzw8YJ75G71AuA76+3kMBx8TaYf2JgQ7NViDED5cuxS2nkyqJwCuTZ8Un
         r4cA==
X-Gm-Message-State: AOJu0YzMPktJIH4fyRbdLTBZ98xub0PujZhq7T30qiZf1nlT4BlcTEZb
	ayFkFGvAT+2/VhUZLvTCNvl2A3PWNBNh8CekbQtoKdiaX5I3AJYN
X-Google-Smtp-Source: AGHT+IGE6DABkG8x2Nv55ospLGaqAybgGoB6FkqdrK1Ov2gOggp9L9XyiNNvRGyvV8x/p4yRWLXcMw==
X-Received: by 2002:a17:906:f146:b0:a35:2758:2297 with SMTP id gw6-20020a170906f14600b00a3527582297mr8411080ejb.3.1706971667521;
        Sat, 03 Feb 2024 06:47:47 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWo3LS3C24frWvrF7osr3cyhgMUBfuScmMvSMEPUDA3xuRS9hyytPyArswyppFytFgvvSVx03aSXBf3ztzzR+KBV/Tj/KFOHQochUJgbPbWRExgij0o8T7IvjGFYBWMLDO//fcwkk/mR0/eCq0yiSNBOsgxSZXRhQOC+1/R5L8SJuhfG06bEiUJfjyGif+7nyZICQPV3iMnyTDBvjjNt/oEjocIZoTTvcftOg==
Received: from debian ([93.184.186.109])
        by smtp.gmail.com with ESMTPSA id hu21-20020a170907a09500b00a34b15c5cedsm2086034ejc.170.2024.02.03.06.47.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Feb 2024 06:47:47 -0800 (PST)
Date: Sat, 3 Feb 2024 15:47:45 +0100
From: Dimitri Fedrau <dima.fedrau@gmail.com>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: 579lpy@gmail.com, javier.carrasco.cruz@gmail.com, jic23@kernel.org,
	lars@metafoo.de, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: humidity: hdc3020: add threshold events support
Message-ID: <20240203144745.GB3727@debian>
References: <20240203090530.53374-1-dima.fedrau@gmail.com>
 <236dc9db-8525-413e-a77b-54df198c86f5@wanadoo.fr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <236dc9db-8525-413e-a77b-54df198c86f5@wanadoo.fr>

Am Sat, Feb 03, 2024 at 10:58:24AM +0100 schrieb Christophe JAILLET:
> Le 03/02/2024 à 10:05, Dimitri Fedrau a écrit :
>[...]
> > diff --git a/drivers/iio/humidity/hdc3020.c b/drivers/iio/humidity/hdc3020.c
> > index ed70415512f6..1cdff7af4ca8 100644
> > --- a/drivers/iio/humidity/hdc3020.c
> > +++ b/drivers/iio/humidity/hdc3020.c
> > @@ -16,16 +16,27 @@
> >   #include <linux/init.h>
> >   #include <linux/module.h>
> >   #include <linux/mutex.h>
> > +#include <linux/interrupt.h>
> 
> Nit: alphabetical order could be kept
>
Will fix it.
> >   #include <asm/unaligned.h>
> >   #include <linux/iio/iio.h>
> > +#include <linux/iio/events.h>
> 
> Nit: same
> 
> ...
> 
Will fix it.
> > +static const u8 HDC3020_R_T_RH_THRESH_LOW[2] = { 0xE1, 0x02 };
> > +static const u8 HDC3020_R_R_RH_THRESH_LOW_CLR[2] = { 0xE1, 0x09 };
> 
> I don't know what the R and T are for, but shoukld this be
> HDC3020_R_T_RH_THRESH_LOW_CLR to match other adjacent line?
>
You are right, should match the others. Will fix it.
> > +static const u8 HDC3020_R_T_RH_THRESH_HIGH_CLR[2] = { 0xE1, 0x14 };
> > +static const u8 HDC3020_R_T_RH_THRESH_HIGH[2] = { 0xE1, 0x1F };
> 
> ...
>
>[...]
> Maybe something like:
>   #define MIN_TEMP -45 (or -40)
>   #define MAX_TEMP 120
> in order to avoid hard coded constant?
> 
Will add the constants, thanks.
>[...]

Best regards,
Dimitri


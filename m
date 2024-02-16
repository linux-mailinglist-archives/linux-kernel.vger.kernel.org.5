Return-Path: <linux-kernel+bounces-69325-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C581B858768
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 21:44:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 24206B233D8
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 20:44:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2557F145B21;
	Fri, 16 Feb 2024 20:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M3l+wyup"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C75B3182AE;
	Fri, 16 Feb 2024 20:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708115723; cv=none; b=dqOwhhu9fHgv+olRscXNOmIEAUq+snxYORMePQF8r9zBWYE4OcdYKx9ni0iyAkC6SKOzqIYMoqdKAJOGMoZ0e8vF3npBrXp48XZxb2i8K2EshZjDTDHH9esfmNWT4uA39vjHmBtX+cWEvpdw7niz0r7gI6T2w6Q5FPLDd7XWOKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708115723; c=relaxed/simple;
	bh=d1kvsnY+i3/79QuX9GnmOA91SAoq1YJ2xM3GsrHQo3Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jLcmdftjhM//sP5aNt3DacshVb6uH6MbcAo0KoNgSggjh5Hxp9+11BS2XX3icX3w2EBqkrFZyk2YGJ9kuM216pyrBxIGzJpaxextidXWdnERs0DRIqclOAi2ihpwbDMb7MTCI0TFBtnQ7s40N7nheRDXZcXVMXsDwEXlXJxG5ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M3l+wyup; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-563d696ce87so2243877a12.0;
        Fri, 16 Feb 2024 12:35:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708115720; x=1708720520; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pDLA75UjQAxOkxvZrlVtcXR5fr4DbWusKaA9AorON8s=;
        b=M3l+wyup3qgNpXgPiiMyR1Bdp1YFof2m0lzSDlHmnOSHT0e1mdSKzIgRgwMI0nE/oH
         JRNzt29jUbWsjYw48sm73S8wwfccf2CZZe1CB6MEYICLGDVKAEhiOuDDcBtxrMemlXcL
         Sqf5u5UEXWfdcJxq7mwYJM2ICDvE2JwmVSUD5LUcrBqN/AAYTRdwiPvHDabAi+EQITs2
         pMfUPckxFPI7NuaQIjsCVZFXjFM5A9CigocDVmjEsqVbUdRLfAEiq5+nkClKugpG7JDp
         lXm5PcD+7eyRCrQ791XxKCW2sMqBgch5QiZEwuAoArPzSmq65d5s+M0bQxFaMwGDJqQT
         w6ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708115720; x=1708720520;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pDLA75UjQAxOkxvZrlVtcXR5fr4DbWusKaA9AorON8s=;
        b=hUqcD9Cib6DPf7XnVWvFgt5AfdjsUzBE4z06vgr/EHaynJfNd8RuOQuQnsiQcI6qBY
         LKhgd5v1Rqvnpi46qDU8hs6YuGpckxqRaASTZOwT2c9V3IMxrfE67JTAAcX7QEtI/nwq
         Q64qc6clAsHU/yaF/VMJ/wl5Msgvi0yPifg9MIrFwAMaK6SJitElpKBBB3eI67LHb7+a
         fXHnhbxrjebpYOQ3pCvJz5tuL5LYtxg8rinPa7AAeOq/S/0vjZzmUJbFf1mAquQpUzaI
         ZkOjgzp3V9GH6OONRXt2mV+RBhuTXeQ18E4TofIxHoitulsLDskY+qM4/7nf6irjob3m
         CEKw==
X-Forwarded-Encrypted: i=1; AJvYcCU4vvXcjlNzb1dhwdGP5yqTIS/26cwGAnWfWg2YBepAXmHCO99hjPbDYxv/kS3uuzFkLVzmReEiik0cPcxCZiHRXclYuDBAYdU+uF7Xp96+jfAjkJl4F12EpLxQejbXuCNSz+R3XGDm
X-Gm-Message-State: AOJu0Yyq7UYojFvG7mD93RNx3TuILlOln0O0dqnKRlWZslo7dzhi+wG1
	W21IoGXmuS68VrG/Vhex5d+d7DecNshPMSQynCksJwYJK5djSh9R
X-Google-Smtp-Source: AGHT+IFxhy6+E5InlYD7r9n/mmvzPDfI1EyVK6LfOBvV69CeGT0Cg7ONhAa2DGjj3ktf0hI/cmll0w==
X-Received: by 2002:a05:6402:b1a:b0:562:b64f:164c with SMTP id bm26-20020a0564020b1a00b00562b64f164cmr6668964edb.0.1708115719839;
        Fri, 16 Feb 2024 12:35:19 -0800 (PST)
Received: from debian ([93.184.186.109])
        by smtp.gmail.com with ESMTPSA id w22-20020aa7dcd6000000b00563918a48cfsm319282edu.40.2024.02.16.12.35.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Feb 2024 12:35:19 -0800 (PST)
Date: Fri, 16 Feb 2024 21:35:16 +0100
From: Dimitri Fedrau <dima.fedrau@gmail.com>
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, Nuno Sa <nuno.sa@analog.com>,
	Li peiyu <579lpy@gmail.com>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 3/3] iio: humidity: hdc3020: add threshold events
 support
Message-ID: <20240216203516.GA3873@debian>
References: <20240214085350.19382-1-dima.fedrau@gmail.com>
 <20240214085350.19382-4-dima.fedrau@gmail.com>
 <b159b10b-513f-4116-b2ef-faf6741dc3b6@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b159b10b-513f-4116-b2ef-faf6741dc3b6@gmail.com>

Am Thu, Feb 15, 2024 at 12:18:41AM +0100 schrieb Javier Carrasco:
> On 14.02.24 09:53, Dimitri Fedrau wrote:
> > Add threshold events support for temperature and relative humidity. To
> > enable them the higher and lower threshold registers must be programmed
> > and the higher threshold must be greater then or equal to the lower
> > threshold. Otherwise the event is disabled. Invalid hysteresis values
> > are ignored by the device. There is no further configuration possible.
> > 
> > Tested by setting thresholds/hysteresis and turning the heater on/off.
> > Used iio_event_monitor in tools/iio to catch events while constantly
> > displaying temperature and humidity values.
> > 
> > Signed-off-by: Dimitri Fedrau <dima.fedrau@gmail.com>
> > ---
> 
> Hi Dimitri,
>
Hi Javier,

> now that the decimal part is used, the resolution loss is within the
> ranges mentioned in the datasheet.
> 
> For the records: the truncated values lead to alerts slightly lower than
> the target alerts. Therefore, measured values below the "comfort zone"
> defined by the user (but close to the low alert) will not trigger
> events. The other way around is "more secure" because the target comfort
> zone is guaranteed:
> 
> -------- High val -> event (as expected)
> 
> ******** Target High Alert
> 
> -------- Meas -> **event** (still in target comfort zone)
> 
> ######## Truncated High Alert
> 
> ...
> 
> ******** Target Low Alert
> 
> -------- Meas -> **no event** (out of target comfort zone)
> 
> ######## Truncated Low Alert
> 
> -------- Meas -> event (as expected)
> 
> But as I said, the resolution loss is in the valid range anyway:
> 
> Tested-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
> 
> Thank you for adding this feature.
>
thanks for testing.

Best regards,
Dimitri Fedrau


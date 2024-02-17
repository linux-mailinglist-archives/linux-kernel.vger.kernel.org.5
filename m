Return-Path: <linux-kernel+bounces-70099-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 17611859309
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 22:49:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4A022B21F47
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 21:49:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C055480030;
	Sat, 17 Feb 2024 21:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gCY0M1n7"
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA7117E782;
	Sat, 17 Feb 2024 21:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708206582; cv=none; b=LL+jTsFtUvbom1jzW0DPaDm6Pr/WKFk6rBuc+q731W1rasOat2HDHM1MGtVVnmrQXsuT9196Q9/JFxsUk0UHSnnlccOXfrWbkp7VeBmvNvpzYP7nmFIna2XT1OTW74S0M9Cl2uWJHew+yK2rwipYL/sXAo4EfvvfRAOXG3Vje98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708206582; c=relaxed/simple;
	bh=wB7CDGUJaK3t8ceS2065mNEi6YkAIcqs94ldRZprQoU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=InV1DJo01AR/MKidj83mRmONfK8vIbXf2HHlHFEUfgdrcGeuEfy3G85HruMoOvj3v5JLsOTEaEwS6fFHQBzd7TIoqLdP5J9chXy/zq40QQ/Ech47I3SmeSUvL1WfY1iglCI+1D44R++Xm+C+fQfRIihmEdH68oCqU7Y3W/d3GOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gCY0M1n7; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-7872ade6f0aso112831885a.1;
        Sat, 17 Feb 2024 13:49:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708206579; x=1708811379; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Yff5w2/dX+NyP9bba4N2dTBCRUtR6XFZyKeb2OHw1L8=;
        b=gCY0M1n7tDqWL4iMPRg3fxKaZOVj9+ly2PBRYccWBwTqSdZLQcKCg4aU9tDoNHM5A9
         qUD/eHNIqdrPKiXTa17ydJXy8qAi0xVq7rqI4jwPrhhWrHz7nsdcffIADahEDeg/fybt
         qErae63HWHZUu9+BZdw+nnpeSUK+zUV0NO566/30U3ivbWoRS4rSdChk/xC/fIxzbgFK
         ATGpvj1g2lEezqJzamT8PNfsqY4nDIZyNyrDjvO22yV51FGqyzmcvSM5rbIRUurNejiY
         rmA2L4p+cnCVs+9ZsrKFXFduejWZVLu8CDG1xkiSaqP3qhDUKp5qAtSh2ixo7kq0BaCP
         +vEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708206579; x=1708811379;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yff5w2/dX+NyP9bba4N2dTBCRUtR6XFZyKeb2OHw1L8=;
        b=qi+dEyUgpl4q6TtyN+BNl+RisETtJOrlt0TLJOklbV6mv0JZSlJNfBW04ZKnts38Y0
         5MEj5cVY0ErACkrPlHmbthfmLaEXMm9UDtOaEC5UDT+SQR1hEw3S7/Pkt6szHqE37w70
         kKER2W++C7N3zCM04+ifUUVisc2xoRNAbcvKKUKSMgsEzmX61Au/WhSqwagkWL3KnDmi
         r08wOzChVtBpWappURJ7UYZ1ScIEQRoBhmzFDkJj1beAytPImX7IvpDK9M5nyDx8OpWO
         vCKzwfvDxF0bez+P6UFd6nLcRNw0JCqON+pg+lBsnmKzckN13EmQLM8b1fJ2US4oivnK
         svxw==
X-Forwarded-Encrypted: i=1; AJvYcCW2b58GmSnC5BkT2uvvGm4HfbkHb+bHMXnog7078Y/+p5frkWTy9nXlE0jsEcheGI6iR9LWoqwDV0ylxsYQWaLbG5jVxj6qBbICB8feVZ1VPvnv/gZ6dsth5ZhiWP+kO6uFO8RkGTbLsplWg5htl9jA+w+nc7K7k7hRbfDT0cqxBZOTCHY=
X-Gm-Message-State: AOJu0YxHTA51r7J/0ZguswvAAu4S4ZKDpXkKepL4mC0tgVOgKUU1zsA9
	YMskp6cQC6E2eqv09utB258tlLESv9TXdyTO+oBmZCIaQeeyiNc0
X-Google-Smtp-Source: AGHT+IEpJf8kG9va0jB/Qx0L+/bPcH/+drdkhi4V/gEWRNCpo4MV5hJi0SE++Qig9xyxcxd0+ndO9Q==
X-Received: by 2002:a05:620a:468a:b0:787:3c10:f17f with SMTP id bq10-20020a05620a468a00b007873c10f17fmr9066402qkb.61.1708206579597;
        Sat, 17 Feb 2024 13:49:39 -0800 (PST)
Received: from abdel ([174.95.13.129])
        by smtp.gmail.com with ESMTPSA id h25-20020a05620a10b900b007873c8f1b7bsm1132854qkk.62.2024.02.17.13.49.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Feb 2024 13:49:39 -0800 (PST)
Date: Sat, 17 Feb 2024 16:49:28 -0500
From: Abdel Alkuor <alkuor@gmail.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Lukas Bulwahn <lukas.bulwahn@gmail.com>,
	Jean-Jacques Hiblot <jjhiblot@traphandler.com>,
	ChiYuan Huang <cy_huang@richtek.com>,
	=?utf-8?B?QW5kcsOp?= Apitzsch <git@apitzsch.eu>,
	Jacek Anaszewski <jacek.anaszewski@gmail.com>,
	ChiaEn Wu <chiaen_wu@richtek.com>, linux-kernel@vger.kernel.org,
	linux-leds@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 2/2] leds: Add NCP5623 multi-led driver
Message-ID: <ZdEp6LuUBI1oMf0z@abdel>
References: <20240203175910.301099-1-alkuor@gmail.com>
 <20240203175910.301099-2-alkuor@gmail.com>
 <Zcsz7x1rXgYP3e7b@duo.ucw.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zcsz7x1rXgYP3e7b@duo.ucw.cz>

On Tue, Feb 13, 2024 at 10:18:39AM +0100, Pavel Machek wrote:
Hi Pavel,
> > +What:		/sys/class/leds/<led>/dim_step
> 
> You are reinventing hardware_pattern trigger. NAK.
> 
> I suggest you add basic support first, then look at hardware pattern
> trigger and add that support in separate patch.
>
This makes a lot of sense and simplifies the driver.

I'd like to add the hardware pattern as part of this patch as it is already
implemented previously but I needed to do some clean up :)

Thanks,
Abdel




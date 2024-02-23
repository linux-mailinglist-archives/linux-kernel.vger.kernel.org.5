Return-Path: <linux-kernel+bounces-77953-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27389860D41
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 09:53:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4A6C9B2218A
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 08:53:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 442D622EF6;
	Fri, 23 Feb 2024 08:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="PXuVHDv7"
Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com [209.85.222.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE8901B81E
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 08:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708678375; cv=none; b=L6kk23CpBfN1MHoBWwCZz055hkj/DcSiiqq0l1AdP6san9CR/jeamUolfV+Teh+7XFRTK49u8pQoSURIn1eckhIFDYxyPeGYpy/zyED2b+Z5lAVxsWtBgtKyzH6UuKI7d7sp/f2J6eHUT97MzWDhiI/xMHqqWS8E1cbjHI3bT0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708678375; c=relaxed/simple;
	bh=g3DztYcYHBisCopsdrxWdHuka4aOsmyFRpTwNGTdka8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ddoEX4xI1YbEnYw9FfEs+avrncfHOxc3G8Zt0RbHfWkNdcrB4wFErUGNIRM/yzhiztpxAsFrYYvqicqfvfDvZeOk4uQ+7k/+V6VewKVWRV6VIhc5ro84b7pEgvD9fkXBpL08HVokYZBfpXbQzrul5G5i4q8GSdTbpMFA/aNei54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=PXuVHDv7; arc=none smtp.client-ip=209.85.222.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-ua1-f48.google.com with SMTP id a1e0cc1a2514c-7d5bbbe5844so323788241.0
        for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 00:52:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1708678372; x=1709283172; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g3DztYcYHBisCopsdrxWdHuka4aOsmyFRpTwNGTdka8=;
        b=PXuVHDv7ttgoKljLtHg1q5B2kI53x9Zt8MkfSZNgfj6OagxkIH7wVgo3VUcvrXwatM
         sjvFhCwKWNOyfwUwYJXnu+De/hhwogYjJy+/gWDRG22UBOrW4OtfKXE/9jzH1Acaj4TW
         6TnUAYytwkWn2U87LsfvlnpKqD6fBn8Dyl5NUe2F8nDoARgFIBK64H8qyV2m+n6BEAuT
         OtzjQRDsodZT1NO81BFBu17T4AX6pTAIebzAKUQ78JUaJQ6QT90XbGHJwfGsU7pOfSWq
         OMQ4labVFxydeatcxAvpo0eU8eLYzlWJ26W+gPJacFaq59GL6Zrft23gdjXO9PoGhqPI
         Licg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708678372; x=1709283172;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g3DztYcYHBisCopsdrxWdHuka4aOsmyFRpTwNGTdka8=;
        b=FOHwI3/HW1M7EJxWzmo+D5Uxw+ojoqNCFFe1w75/QrrLHGbpB0DW4Raps5X6UDXeV5
         TRetKQ13/mx7+ty++CN+tpR3F8gx2EIq5Zp1QqnervM4zG6gOVn8lbI1KTL0hQdHKjsM
         Lcf8rVF19WQV3tN5CNXsfVG4EYO/oz/1VI49QH8/8tNekzRChSkh4a0k0D/sYJt2SMvD
         o81kCEDEERtoigoaN/uI+95ZgR0zK8KfebgMThO0qAzpQVY70thE+CyEn/YZFgV5MHjD
         fUyFH1Z/g8PdFNA3urN6H09nM8blrbXtMcJSmVJvQD9aYO7W22D0xEXif9Bs50P/HtEx
         9Izg==
X-Forwarded-Encrypted: i=1; AJvYcCXKYf7//PP09kCWlMlVMdgXfBZ5RRcTIcdA5slBEc3D57mgxah4/56AG1RvNLShObNY+zTq3tUhrjCDUjHrtErj3Ca36X/hqPiS31UE
X-Gm-Message-State: AOJu0YyYGPD7dz+DOHS/TmB9P2oezTH4oVBmLDyWAIM8D9Sm8TK5Uq9V
	jqjeGwbZcs0SUneAyERHMbOivMhkkHgUXy5h65oJuqYuDLcRx8kvl9VEVTDAolewmwLiJfxyy86
	1DjTcryYiH+OlWqjC07h67xWKx4RCIqF+sQfxkg==
X-Google-Smtp-Source: AGHT+IGaNMTtSVEdubH2GbnyG0AR5Hk5HfywbHtxHiKnvps0Jai1ymSs8LeNhk2vr7Lhe8k1UI9Z3510AGzVnVThweE=
X-Received: by 2002:a67:b649:0:b0:470:498e:7e67 with SMTP id
 e9-20020a67b649000000b00470498e7e67mr1328030vsm.19.1708678372633; Fri, 23 Feb
 2024 00:52:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240214104506.16771-1-brgl@bgdev.pl>
In-Reply-To: <20240214104506.16771-1-brgl@bgdev.pl>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Fri, 23 Feb 2024 09:52:41 +0100
Message-ID: <CAMRc=McYim_fkvatZTSzXa04-=7OQ73PjMVh951uR_engoE94A@mail.gmail.com>
Subject: Re: [PATCH] gpio: sim: add lockdep asserts
To: Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <brgl@bgdev.pl>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 14, 2024 at 11:45=E2=80=AFAM Bartosz Golaszewski <brgl@bgdev.pl=
> wrote:
>
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> We have three functions in gpio-sim that are called with the device lock
> already held. We use the "_unlocked" suffix in their names to indicate
> that. This has proven to be confusing though as the naming convention in
> the kernel varies between using "_locked" or "_unlocked" for this
> purpose. Naming convention also doesn't enforce anything. Let's remove
> the suffix and add lockdep annotation at the top of these functions.
>
> This makes it clear the function requires a lock to be held (and which
> one specifically!) as well as results in a warning if it's not the case.
> The only place where the information is lost is the place where the
> function is called but the caller doesn't care about that information
> anyway.
>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---

Patch queued for next.

Bart


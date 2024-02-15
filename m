Return-Path: <linux-kernel+bounces-66834-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 044F9856221
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 12:49:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD47D1F276E7
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 11:49:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0EEC12B14C;
	Thu, 15 Feb 2024 11:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vKlbrH81"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AA7212B146
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 11:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707997749; cv=none; b=CihPeTLthdlF/RSX53J5E5CmkdIC2RJRoNsIZ+MJncUcuojSOpIWaK0Ku23ss7/7v8sXX1HHuWJbG0wKX5l8YCEoo0c5PmhQjAl3WQph+5PXn8IMULLaKk68ZqpxK2DXOxKWhS7IJRYe10610Ycg2lJXsovKMzfFhCqAzPbZvhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707997749; c=relaxed/simple;
	bh=PMdqF4BxnLzSwd0JYe63JOfvhqT8FaZryFeHRQWW11s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zbl9mG2BKpHaeR/qPizwnS74dFZTvcXx0cZBxy04Okoyb0mZBqolpbvsgiqOshy0fMwcWqqIZ1xeut+Pyt8FbLWGfu/baDg4B/XtI0Ie1AzZ27m8Y79H/++woR9iDdrdXtT8KvwL1+9oWjgrQBw4UZq5fFBG2/TsBjfxgAVBXaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vKlbrH81; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-411d76c9ce3so6404385e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 03:49:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707997745; x=1708602545; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=PMdqF4BxnLzSwd0JYe63JOfvhqT8FaZryFeHRQWW11s=;
        b=vKlbrH81Q+fNYSZKaT93vsQazhllFw8PvlBaU03WUt0/++t49vHhlKe0JNGETVRW2s
         kpR7EZ8M+YM02cLkCmX87qdi/NqoewiErV7xTEOalX5BATkMLfrM0dEAZxv84Rq6JYNW
         JqPvkLSMR+re/+fyZT0LHags8GPH11gzWMPLz8UKwR/DG1MpTg7DItUfEaPQVEJR5U9a
         ihYZFgbAHaOyID1M1P1C+ahOICc1r2hTWtyFU4UxyN1vMPocW7vm374UjYtCOXwc4wab
         QQmFKHhUR1EJxyOOdakdtCLw66r6hysdLkxBne8cGhk4MuhUwL7o+lJY3PNlXBxmLqif
         D+HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707997745; x=1708602545;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PMdqF4BxnLzSwd0JYe63JOfvhqT8FaZryFeHRQWW11s=;
        b=n3+ZHAyZOjE4bXACoe/4jhkgvFsKvUra94IYxJofWqkqCw5CF4/oTQtFXGgUiVFw3/
         LmWTPyEaYyR1o+Ch+tX1CN+hZ8DKHnGe52X1YMV8ljRJ0cq9SHeAWjWxINEf+X788dX5
         cdajsXNtIWftA3cR2kKym32D9hqh+BeVv8b7r0607PqPDwxdBZIsIwzMKvGjkqOnADzH
         aYjdWRmvrv+VxqrV0YVQQ17pIpunx/TCQr8gqHecY/bQ/yxi4IJZ1lyyKU/mBOJRJGEw
         3U0lOstOo2MGErbaFelor9zIV/KKfe6mx2Ct8m3UvLRj58otNCt3x/HDISZL1GmdXaum
         wBBQ==
X-Forwarded-Encrypted: i=1; AJvYcCWLl+wKXzWmzQFR8dmzFyPpNNF71M/CWQ2ajb/uqlkCIuLkrIGgS+7u+m40/OuDdkD4KKwND8jxip0DDW/AvyMe59OZ4oFNJk8qH4gw
X-Gm-Message-State: AOJu0Yxsrg8H84F2o5Fg9MLELWbCmx+zQP1FH3No4/1PSbiOm3OLCaXm
	FkrEesNl26ktlaba8EkVIfo//huzBVXUAfcCJ3u/ke+EJ/Q0t4kUulvoG7Ui9Ik=
X-Google-Smtp-Source: AGHT+IEPqfe0lQU32GGuFkM16RloqQWYNuLy7eiEqCzQNMdjhgJO3HI8g7e/KPfBuJeESwNfUgFUDQ==
X-Received: by 2002:a05:600c:470b:b0:40e:a32c:988d with SMTP id v11-20020a05600c470b00b0040ea32c988dmr1202419wmo.4.1707997745749;
        Thu, 15 Feb 2024 03:49:05 -0800 (PST)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id n15-20020a7bcbcf000000b0041076fc2a61sm4778156wmi.5.2024.02.15.03.49.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Feb 2024 03:49:05 -0800 (PST)
Date: Thu, 15 Feb 2024 11:49:03 +0000
From: Daniel Thompson <daniel.thompson@linaro.org>
To: Duje =?utf-8?Q?Mihanovi=C4=87?= <duje.mihanovic@skole.hr>
Cc: Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Arnd Bergmann <arnd@arndb.de>, Flavio Suligoi <f.suligoi@asem.it>,
	Hans de Goede <hdegoede@redhat.com>,
	Jianhua Lu <lujianhua000@gmail.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Helge Deller <deller@gmx.de>, Jingoo Han <jingoohan1@gmail.com>,
	Karel Balej <balejk@matfyz.cz>, dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-leds@vger.kernel.org
Subject: Re: [PATCH 1/2] Revert "leds: Only descend into leds directory when
 CONFIG_NEW_LEDS is set"
Message-ID: <20240215114903.GF9758@aspen.lan>
References: <20240212-expresswire-deps-v1-0-685ad10cd693@skole.hr>
 <20240212-expresswire-deps-v1-1-685ad10cd693@skole.hr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240212-expresswire-deps-v1-1-685ad10cd693@skole.hr>

On Mon, Feb 12, 2024 at 09:03:25PM +0100, Duje Mihanović wrote:
> This reverts commit b1ae40a5db6191c42e2e45d726407096f030ee08.
>
> The ExpressWire library introduced in 25ae5f5f4168 ("leds: Introduce
> ExpressWire library") does not depend on NEW_LEDS, but without this
> revert it would never get compiled if NEW_LEDS is not enabled. Revert
> this commit to allow the library to be compiled.
>
> Link: https://lore.kernel.org/2cacd8dc-6150-4aa2-af9e-830a202fb0a8@app.fastmail.com
> Suggested-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Duje Mihanović <duje.mihanovic@skole.hr>

Interesting that this could be a revert!

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>


Daniel.


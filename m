Return-Path: <linux-kernel+bounces-151972-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB3218AB66E
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 23:29:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB4F01C20A41
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 21:29:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C90913C913;
	Fri, 19 Apr 2024 21:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Il34BblI"
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 193CD10961
	for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 21:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713562169; cv=none; b=mKRjD7L4+1ravTP7LAGwsErUyig6XkuU1M1fNGZVZR4rLED/67AOyqj4bFZ6P3K4G09i5QICNlXOI90AXwWP0sDHB7+LSzXj+QASc65JIORj6f8ytYhwS9Io/ZIN0HLN/AghfiUImht1DhN4JqAnv0/wjQNk7RwSn6+EuOTz8ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713562169; c=relaxed/simple;
	bh=2GysBCBET65HJHpPRbD59HZPSuc6WYob58y8/gPNikI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p33EASULL+D5vyFLQhk3zQPSaXlM2EoytNSICBYrOLDXsu/gMUdK5qObRZLvjV7yGY8OjIPppzUkUu8PH67vfQ2U98VyEAAzwxrPnYLJGWT1Qrf3bAFUyzq/W1wyxnmvCkhzAskyEUhpbIM8ljrn5H4I2AzMnKgQ/4B86RWqgC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Il34BblI; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-de46da8ced2so2339200276.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 14:29:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713562167; x=1714166967; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=IIpOYqRh88R0i8LNHu4obmBeVHXo+nptZ2aPcWVTDA4=;
        b=Il34BblIAlN9mkQWFsF4xuAFQ9o70L3F/AfqIdT6G4+COQ4nWSvD4MPPMilKZumz66
         AMNgTDK13/+gv2Tx3DjyqQkRNchFCfEMyf/gtFLBg2BpmyyaOOl5z+ZqPgbvIJ4ur2x8
         614F6AI9GAKdn4MX1bEzHbOZOEuV+aaJSvhvz3be4rxUA94jXe+cIr+sOIKJDoBjmUxJ
         pMY2h2YWaadbZNYdUgsXZF3yy3PqH9A2fQzJ20D679rSFtGIAiDE4CtZWkIJrs/6tpru
         ovDhJh9iRtZNQ8bbH9JoZBQWSZB2/H7h+73FDa3ChxYRt2DR4K3mMfXdMroo50hfyIUQ
         a66A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713562167; x=1714166967;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IIpOYqRh88R0i8LNHu4obmBeVHXo+nptZ2aPcWVTDA4=;
        b=wkPRFRXVZLyzoUdI55Xhs+zRLZD/1M+KbEeoroLH02YMOSjN7jrKcemmkljiSgPGqG
         0pwaUFpDjRmKxJC23USWsmkIKNpnh2OXQF2c/KCAxYe0Jh6OBo3zZ/pY1WRoXSh8O0om
         Ae/2KYLa32GbEViPtkIQGH8OBfLPZHB4+wa/gFvk5JQGIN2KLQmV2RDhAjcuQUsBNg5g
         uj2N3tipWRS5SIvbhn1zkzIR/axQtA4H+gTksJq3izfeJNQc5UE7UdOlU/gpr+ADHwZL
         xVyMQxZUgp8E7HOkmbjvxNvNvxRGYt/d4X9CBf6nD28xctzgqrj2gYRrQmEQC+PXn+SE
         Cg2Q==
X-Forwarded-Encrypted: i=1; AJvYcCXumU/aWbIKMUP7BW0QGE2J4u75ody/FWmpMvztQgD33WCxds8DLu3OI0ft9+k/qvio/ulI+wtIZCamgO0RvDOgBRFUxVR85w09Hhty
X-Gm-Message-State: AOJu0Yxb1C7mNRL49vrPDeZRMpEhok9tz+2N2YJVtupZkCFdYSWj6IWM
	5bA/aSqV2NDypfbnqMWVoKRGXql7bQIja1U8H/GKGyfcm1ALaUUEw8twu/pbPo40Wso8tlsitbB
	+uM/W1wuMszp5yQViOhlPQmMmfwPbpnM2VPADIXYYfBN33O1t62M=
X-Google-Smtp-Source: AGHT+IFq6P5+bwPZWKT2aKGN9XWl5zccC4LReC5Jg0mx18NS/M+8Z3JsMrOAqUuEy0c78dMpwxt2/HmMqmBo1470aWc=
X-Received: by 2002:a25:83ca:0:b0:ddd:6964:40c with SMTP id
 v10-20020a2583ca000000b00ddd6964040cmr3061330ybm.50.1713562167179; Fri, 19
 Apr 2024 14:29:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <02a101da9227$bda04cb0$38e0e610$@trustnetic.com>
In-Reply-To: <02a101da9227$bda04cb0$38e0e610$@trustnetic.com>
From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Date: Fri, 19 Apr 2024 23:29:16 +0200
Message-ID: <CACMJSeuGu4nCVsbSnTrJwEdU+RF0BKHbzS7A9Cf2CiM_stJPzg@mail.gmail.com>
Subject: Re: [PATCH v3 00/24] gpio: rework locking and object life-time control
To: Jiawen Wu <jiawenwu@trustnetic.com>
Cc: brgl@bgdev.pl, andriy.shevchenko@linux.intel.com, elder@linaro.org, 
	geert+renesas@glider.be, linus.walleij@linaro.org, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, paulmck@kernel.org, warthog618@gmail.com, 
	wsa@the-dreams.de
Content-Type: text/plain; charset="UTF-8"

On Fri, 19 Apr 2024 at 09:04, Jiawen Wu <jiawenwu@trustnetic.com> wrote:
>
> Hi Bartosz Golaszewski,
>
> I ran into a kernel crash problem when I pull the latest net-next.git, and
> finally it was found that is caused by this patch series merged.
>
> The kernel crashed because I got gpio=0 when I called irq_find_mapping()
> and then struct irq_data *d=null, as my driver describes:
>
>         int gpio = irq_find_mapping(gc->irq.domain, hwirq);
>         struct irq_data *d = irq_get_irq_data(gpio);
>
>         txgbe_gpio_irq_ack(d);
>
> The deeper positioning is this line in __irq_resolve_mapping().
>
>         data = rcu_dereference(domain->revmap[hwirq]);
>
> So, is it the addition of SRCU infrastructure that causes this issue?
>

This is irq-specific RCU that I did not add in the GPIO series. Please
provide us with more information. Bisect to the exact commit causing
the issue and post the kernel log (we don't know what kind of crash
you trigger and what the stack trace is).

Bart


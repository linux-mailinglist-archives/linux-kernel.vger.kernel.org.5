Return-Path: <linux-kernel+bounces-92501-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4318C87213F
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 15:14:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6736B1C2198F
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 14:14:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14AC38662B;
	Tue,  5 Mar 2024 14:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="g0eJx3wl"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0E1255E59
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 14:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709648084; cv=none; b=SEVgi8w4W17jWDk5lnYfKGwPVgelRFQINhuRGli2kgmc1i3KbwfFCIxnpHV7VG+0duZhONZXmm5jWp2wLX/6hLytueebJ7886m2omkGEPGhnGNx345vCs2E4eWtlvKRSpU6MZViBrKPfipY5Eu49UiZtbbOhsReC4RFT0QEfEfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709648084; c=relaxed/simple;
	bh=XBErKlVVtmn1WR410Z68CcZiMCuNgjRPgN2LT0AKjLI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DeEkBlEQRAA7jdlNx8s5uyU4zOLo4t0O3S6xoDct6T8NmEMl2LY/t2sdQJBdIKUtb6QWtbbhVxvOmm/HeGxtqdCiGqYPQ2rjw/xiV/NPP5WbOr9XLy71E+m2Ud2PKu7RUss5FiZ1vlylAOBEggonlroz9wa81nsaGy5pV4HDzzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=g0eJx3wl; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-412ee78edbbso3970765e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Mar 2024 06:14:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709648081; x=1710252881; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GYgKvUYtJLorfP27PNL3Gyz0XsuBP43h1RyjWIqFg8k=;
        b=g0eJx3wlLXUJE88UoghwS+LSPA3KuRHdX0ai8BrcCxT99yFdhCecf20DaRh1KDXji6
         DCHmWOyn+Sn9UlFnItK5ZjbehQD1k53XUQm4DiJMylkw0qjetJuUclQjzh55SmhtSk8O
         cnMRsyaM1j0qXlm7M9O0sj2N3aTlMkV4hMeAi+KCgi2KCiloKGjzvlWYNb9Xy3zOgvDA
         mt31FJQbDvhoB1KKfb/+noo8Wp0WrdgcpO3d3xKDWcGw7C4fB+752S/d+WRvwqT5BULd
         OmkbxCcASL7XJ5tWbV2kw9Da2XwjJngHe4YRNQziLV28TbC8FcXJeSuwPu4j5lSRhiUQ
         +nVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709648081; x=1710252881;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GYgKvUYtJLorfP27PNL3Gyz0XsuBP43h1RyjWIqFg8k=;
        b=ZZGxuUdkx3M8VCKvytfSvK/Xa8MqnKRzH45xLJFOPpU4XxcPDAnk1dsKJUpS8+Y76/
         9xyeLyIs06ORY1fxREpiqyPFzw7fAYHrBCCIBTj/PVHelwpmS78Wm5S3GQIIt6gu+IYT
         cjE3fgjfKcJUE3fKKhKDy71Qf+wy/Yx8qCyU0Xx3LQW9i3wqi4kEU6Q+7OrkJnBFQ2MY
         SZWtO2oQyndq27VvfxXGaO4WqmgD4zFb/SI1kfelCIy6vkZpfPAXmrPzeuAN5oSffVq9
         mZiNH5YDwKV1O8BgNovZ+liS02xrqFPo0n0/KbLUbOsViN10t1OPn3M3yDF160LtKmUU
         YT3Q==
X-Forwarded-Encrypted: i=1; AJvYcCV1e6HgaZEMCnztYcFpPZAWXhr/Su41349fcSem8xRnXpWw2AEOa9cPT8+ZrhTxWdeRE9uF5qcL5HK6yDdaYQGA22l3qrpHNtkUDwYD
X-Gm-Message-State: AOJu0Yz2reiUjs7r6lmi4z27yIKBvg/n9wlP9U2OIDeLlOFsxu6RKFwy
	eueV2eMTImw400+BHTeE1MhNVaiYMYbXlqL9jx+9Ng12LDxeP5y7oLk+1rQob2s=
X-Google-Smtp-Source: AGHT+IFiZvo+2Ed36XHb4D8FEGL8RTKDKh0WAHkFjCOZayTy5yg1kPzsgjoKPmq/i8S2Mnz6IL5Vzw==
X-Received: by 2002:a05:600c:5385:b0:412:eeb0:18db with SMTP id hg5-20020a05600c538500b00412eeb018dbmr1107845wmb.2.1709648081248;
        Tue, 05 Mar 2024 06:14:41 -0800 (PST)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id bt12-20020a056000080c00b0033e3a110d7fsm6645453wrb.71.2024.03.05.06.14.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Mar 2024 06:14:40 -0800 (PST)
Date: Tue, 5 Mar 2024 17:14:33 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: linus.walleij@linaro.org, brgl@bgdev.pl, linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org, patches@opensource.cirrus.com
Subject: Re: [PATCH] gpio: swnode: Don't use __free() on result of
 swnode_get_gpio_device()
Message-ID: <cbb40800-d01a-4e3b-bf36-6cfcb85b2796@moroto.mountain>
References: <20240304160320.1054811-1-ckeepax@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240304160320.1054811-1-ckeepax@opensource.cirrus.com>

On Mon, Mar 04, 2024 at 04:03:20PM +0000, Charles Keepax wrote:
> swnode_get_gpio_device() can return an error pointer, however
> gpio_device_put() is not able to accept error values. Thus using
> __free() will result in dereferencing an invalid pointer.
> 

No, this code works as-is.  The gpio_device_put() won't be called
directly, it will be called by a wrapper that checks for error pointers.
The __free() stuff is defined like this:

include/linux/gpio/driver.h
   655  DEFINE_FREE(gpio_device_put, struct gpio_device *,
   656              if (!IS_ERR_OR_NULL(_T)) gpio_device_put(_T))

So it handles error pointers correctly.

regards,
dan carpenter



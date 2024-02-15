Return-Path: <linux-kernel+bounces-66829-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 573A08561FA
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 12:45:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD2621F26D2C
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 11:45:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5416A12B144;
	Thu, 15 Feb 2024 11:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yk7bxDLh"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0926712AACF
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 11:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707997518; cv=none; b=pVfXHJaXFNdsgmb2ah4YD6LQJJd+Ios8OCf3Q9Gx0vNPkyCaRHcQbTYzueI2Im9z40QE0Mr+RXEchOuEqMCXNiqEIog529wfV5Za15+/HFIuc7soU7UFlVNVCKRZBJ7ew6S7eZuK4nFOdPXbaEvGrGixwMBMdguUfi1BXN0Wuz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707997518; c=relaxed/simple;
	bh=j7GNB4Q4AhYzbK2faRKG2Sks0J//rYWYKwaeX8FNhr0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M0ICY+c6ukwiwxAB7cjLMmhVee2jEzHfgQ7qMYtwKEEo6lxNM1ynB6fxjcAbspLEW1CccDUdAvO/tcbqg1Zo//syLx+grl3xR/BruSyJySxXilJeBXUJEj+WD9VnONz2l4qG2BTdAPnWhz8BdG6Uy2i2CRxQRm25Zly1YoxuDCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yk7bxDLh; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-33b29b5ea96so369879f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 03:45:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707997515; x=1708602315; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CAMbc/YPnpoMjMEiasdWUqQDRgzhyEzAGoC9QPe3Et4=;
        b=yk7bxDLh+0aVntbj0opPwQqsNce2qiqr2rrVq/aF28sPBaiQ+dMsuvMuOdJMsoC7JQ
         rgUBgEE0RxTL4YLfqs/NGC9jQKS5q66BdEvDaencMuWxfrEGO+SKt3dFBkMCgGjxqP2F
         E/YzBmneiJCE0OyH0nVkcWmsfULEUjdYznN8881jsFSEFjbyaOluGe/TFueVh8FIos1q
         XHLoeA3b+pt1ZXXvMIpDHlGI1sFeR9jT6iO6ffdKLt3XVSwm6nLjv316spUMo19Q+IT1
         VXvbli9A6oe8jSar7Frt2DiQDkdaLyEyjA7ARscmHD2uXDT7nDb45RKGtxMtO6Miu+0M
         nI7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707997515; x=1708602315;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CAMbc/YPnpoMjMEiasdWUqQDRgzhyEzAGoC9QPe3Et4=;
        b=erakoRUMGdz8OCE6sq2pcYoLFKdfDU3hijpiz3W4vI7TsYNzxUigZmAz1fQypsRxO8
         XfJqQqoyvisAHEokV6w3NsVd4isgkDB72wc0hAcGeG2z9MMRP2qEXJFuBEUHjsbba0S9
         m2Rgkwxc0EVpkIetFNPDek8LTfdN0UPtVnmbMqMck8v0ltNrPRl3m4JUOtelmkzIDhqm
         9wBslnPAnvwvpmnG3dlPKh7EHRbNDTXldgH+EcZ5+YT/OWlvKp0sG9SdqhKwUD3gyBPs
         7iyIK6FAPT1E1aWKugFLgaxPniErYlAuAc6cLIj15ntzBpuQSd4C2axThJHQl6RYLI+o
         e8Ag==
X-Forwarded-Encrypted: i=1; AJvYcCXA7d51Pk8uZ/UA4jQXJpY/XtbgDyNhoRdMXOEGL7irRVQRArBjK0AvtPELqxKnQP/nOHuViuf0ARtnu6VBvn5miY/YFkJ3SfbqNexu
X-Gm-Message-State: AOJu0YwWjxBNIkoZYPWWLWSkD6YTnA9ZIfayqE3DLSVPYgVWTdtecyKD
	WmLKj9dn8LbyRqZUmpi0H8awB0cJIFXYTiitPAqf91EhCH9mEfn6wDdy+IYDaPA=
X-Google-Smtp-Source: AGHT+IEgp8vZ+7lAbMO2u7bbQBv282Nn/wkCHud0PkjZdrb0T2lOyr54bPl93Gxx9sDkVIqYAtM6Xg==
X-Received: by 2002:a5d:4048:0:b0:33b:2138:623c with SMTP id w8-20020a5d4048000000b0033b2138623cmr4454343wrp.16.1707997515250;
        Thu, 15 Feb 2024 03:45:15 -0800 (PST)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id f22-20020a7bcd16000000b00411d1ce4f9dsm4823998wmj.34.2024.02.15.03.45.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Feb 2024 03:45:14 -0800 (PST)
Date: Thu, 15 Feb 2024 11:45:13 +0000
From: Daniel Thompson <daniel.thompson@linaro.org>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Fenglin Wu <quic_fenglinw@quicinc.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	ChiYuan Huang <cy_huang@richtek.com>,
	Duje =?utf-8?Q?Mihanovi=C4=87?= <duje.mihanovic@skole.hr>,
	Linus Walleij <linus.walleij@linaro.org>,
	linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] leds: ktd2692: add gpiolib dependency
Message-ID: <20240215114513.GD9758@aspen.lan>
References: <20240213165602.2230970-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240213165602.2230970-1-arnd@kernel.org>

On Tue, Feb 13, 2024 at 05:55:50PM +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
>
> The expresswire module requires gpiolib, so anything selecting it
> also needs this dependency:
>
> WARNING: unmet direct dependencies detected for LEDS_EXPRESSWIRE
>   Depends on [n]: NEW_LEDS [=y] && GPIOLIB [=n]
>   Selected by [y]:
>   - LEDS_KTD2692 [=y] && NEW_LEDS [=y] && LEDS_CLASS_FLASH [=y] && OF [=y]
>
> Fixes: e59a15af7aa6 ("leds: ktd2692: Convert to use ExpressWire library")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>


Daniel.


Return-Path: <linux-kernel+bounces-25726-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDB4B82D501
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 09:24:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5D228B20CF5
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 08:24:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5501063AD;
	Mon, 15 Jan 2024 08:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UUMqzTNz"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 664455C97
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 08:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705307052;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WdHL5Nw4L0E7LviK69bDEOS/TGajAce1+kECtONWdOQ=;
	b=UUMqzTNzA8YwpfeQNOTcFeDejrxF1OHzZTHWnzmfjEDWEqQrdsCpa/3xsHB3dWzD4mcle3
	SwQTtgqerLJsAPRy2iDsifopLt7UW6eV/9MpOl4LH2oC5CpvgDLIexoRG74kjNHYt7h1c0
	/eKecx7THtQHjGUqAtmSaHnxCwdlFEA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-197-XVr_iVrEM9ipj_dSsMeN3A-1; Mon, 15 Jan 2024 03:24:10 -0500
X-MC-Unique: XVr_iVrEM9ipj_dSsMeN3A-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-40e4caa37f5so49445795e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 00:24:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705307049; x=1705911849;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WdHL5Nw4L0E7LviK69bDEOS/TGajAce1+kECtONWdOQ=;
        b=lP48utkjT9WjFpoDBoMuGBIOlcxFusPRI4CmkZUSe5fql6biB6ENoxRsay55s2feOR
         r++rH2l03bUb8aKih2uphjbL7Af4wC/RkI/btaf1WMa0Ouog0DTF3fon3PC5av4i+VIg
         J367pOHLjA1dLaHN57LnKCkkvjrjZNtKBmPiqEpPh5owqJiVLWTFMNQdhclj/4xb9rTa
         EEw/wRMoW+4SeoIWyf+q23OvmbTyM5lppJBZeAiSZuVIPjxRjq084rZPsVPIb/O9/0w+
         Ar6dFNyLuL7Gu2mPDIqeUzGCcBWBfmDEF78JLYKzofuNvlfIuTG2SU4Fem5+Aa3sHw0+
         b8AQ==
X-Gm-Message-State: AOJu0YzHiC51WFXnIP4907tIEQp9/YQKumY90s6WTrmr4Gvnj8i6h9zg
	dHIJD/veRkRsGjqr9kotwgl4Ya4v0HHRf7h0QPsGkMzQKLyB7RlhmKQNYyyYR4ok2lCLhceZDl9
	z/UsBs8JssONPcUcKKdx6f31q3gH8Sbdn
X-Received: by 2002:a7b:ce89:0:b0:40e:616b:50f with SMTP id q9-20020a7bce89000000b0040e616b050fmr2463777wmj.141.1705307049669;
        Mon, 15 Jan 2024 00:24:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGBEbtq4O+FopQ6pQyQO1trt0NUo5+q0+USaIZPNgscLYIqA4FgDvQ2PPDGSn+Q3oE/+3Jcxg==
X-Received: by 2002:a7b:ce89:0:b0:40e:616b:50f with SMTP id q9-20020a7bce89000000b0040e616b050fmr2463771wmj.141.1705307049365;
        Mon, 15 Jan 2024 00:24:09 -0800 (PST)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id g21-20020a05600c311500b0040d30af488asm18874042wmo.40.2024.01.15.00.24.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jan 2024 00:24:09 -0800 (PST)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>, dri-devel@lists.freedesktop.org,
 linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Jingoo Han <jingoohan1@gmail.com>, Daniel Thompson
 <daniel.thompson@linaro.org>, Lee Jones <lee@kernel.org>, Helge Deller
 <deller@gmx.de>
Subject: Re: [PATCH v1 3/4] backlight: hx8357: Make use of dev_err_probe()
In-Reply-To: <20240114152759.1040563-4-andriy.shevchenko@linux.intel.com>
References: <20240114152759.1040563-1-andriy.shevchenko@linux.intel.com>
 <20240114152759.1040563-4-andriy.shevchenko@linux.intel.com>
Date: Mon, 15 Jan 2024 09:24:08 +0100
Message-ID: <875xzvovh3.fsf@minerva.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Andy Shevchenko <andriy.shevchenko@linux.intel.com> writes:

> Simplify the error handling in probe function by switching from
> dev_err() to dev_err_probe().
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat



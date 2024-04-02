Return-Path: <linux-kernel+bounces-128109-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 73D4A895641
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 16:10:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A0ED41C22B31
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 14:10:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D10E1292C9;
	Tue,  2 Apr 2024 14:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OY3OBIdS"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE32985C4E
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 14:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712066982; cv=none; b=io30CXnfnbYOe88U7BkldSVz8fxYuR9JwUv5BU+/CW7g0FVZJwt+4M85/JlPrHieYOPXH04gVddNrZBF1zXkZfdJulp86uIFPzRk2l165z5igtAzSLu1mdRwblnw6c2udtrc2j87O5u6j9EbalXdPCVOvNBX9fJOnYkYu6GAwpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712066982; c=relaxed/simple;
	bh=LTkw8G/UbnzbJ69YL6GosvdrYC0acddZdwlT7ImDQUo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jv/f/w5vMk12XelJpIMzP65DW6XXzXGJutVJsWv5bvPR5AQo+CJyYKRVNl/CbY6k0cGIs2iDX9P4LTPza+ltpH1hTafgGpNS7aCst736yKDEotsuY8hLl3csGJUxTuo9OKJ2pextfmwK7D0bbGAUWJWRIngjxOhc6LDik/Wbr60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OY3OBIdS; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a4e5ee91879so308391066b.3
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2024 07:09:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712066979; x=1712671779; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Pd+8DVN5G2IkVOB54fyerdrNg9YmjMKBL8xpHTKHGmI=;
        b=OY3OBIdSWblv0nToz3q181O1+CbQTm6FF84pyqm1+qlq+GLigNp3vbYxsrKcY8PbaE
         HUgIX3/Hvue1FpHH+qAf2ULOCGgBBqbI6JUJhFLJN2aIhRua7nrFECSp9h0cfagTp7gz
         7SOscx0ouyyzp24gon//1QVeB8L+s9o99V/r29hz4koQELs5EJtpG/j3zGxqYrp2ziJJ
         EbmNgOd2T/JeNwCMlm3o8kHHesf0uCuiSoNxnvnAA2sSODuQXXXOG4OFbcjRpSAvhW9U
         L9AhEBquNfemiOOOXU8mVTFjLDTJ352kw3Ul6row1abTE93QhH1m8jLm/fSK0x5lqZEl
         eZRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712066979; x=1712671779;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pd+8DVN5G2IkVOB54fyerdrNg9YmjMKBL8xpHTKHGmI=;
        b=S1PMRI55BkbuuD82952Xv3f7U6qTOLqLVJcZojUyuGc4wvBwFFUAAnbN9HigrYKQ8J
         vFObunUp/v2CWGmZ7xwJAaP883P7AsjFuuHFPAMKMUgna57Tbn9TQJ9nyejqVI8zfNuH
         I81osFzEgJnBjYQn5KqN/Pz2D0pooSmGuVHqXS3dQoxJKVKl54JrF1KfJNn9WldSPF/p
         qx1Pw+5I7NFMso+I29kbxrV25e1Urto1ljeF210wzp5HDGn1xE1XMUvw1lgumTD6TSgO
         fUA2WxWwXZfZb/l9Mu8bO5lGOhEtIZPZ2L+mhPNy+q5hIGcS8nBJzvmeRhovqeAZH7bD
         hfkg==
X-Forwarded-Encrypted: i=1; AJvYcCXnNZpmcCAuLYLwt4xqGl/XLp/WF3CeIhuEbAMS0mMGGGC4z8WHOZLxuCFAjRbsxvgQCYCYCgOScBcGw/MT4zVLAwx2/TZn98xCwZMd
X-Gm-Message-State: AOJu0Yx5O27Btg6igUBbRlre28aP/6hbwjO/RIrH6TSyoo1nnCd/gF4F
	ZqPcMo68zHVo1Dq282bUdODmCPO7gslaXB7fLtW4e9idSGnqowHfpN3L8j3LcNs=
X-Google-Smtp-Source: AGHT+IHULZd7aTRgJq9Vh0DgCgeBzmCZLRHFYYSFMf78XHwA50Pp9CV+gJCGmkGqv9CBrWjPGxHVeQ==
X-Received: by 2002:a17:907:7f12:b0:a4e:516b:2fea with SMTP id qf18-20020a1709077f1200b00a4e516b2feamr6665482ejc.50.1712066978929;
        Tue, 02 Apr 2024 07:09:38 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id q2-20020a170906b28200b00a4655976025sm6534890ejz.82.2024.04.02.07.09.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Apr 2024 07:09:38 -0700 (PDT)
Date: Tue, 2 Apr 2024 17:09:34 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Cristian Marussi <cristian.marussi@arm.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, linux-gpio@vger.kernel.org,
	Peng Fan <peng.fan@nxp.com>,
	Oleksii Moisieiev <oleksii_moisieiev@epam.com>
Subject: Re: [PATCH v7 4/4] pinctrl: Implementation of the generic
 scmi-pinctrl driver
Message-ID: <c5bdf039-c43b-4611-9f0b-81585e296206@moroto.mountain>
References: <20240402-pinctrl-scmi-v7-0-3ea519d12cf7@nxp.com>
 <20240402-pinctrl-scmi-v7-4-3ea519d12cf7@nxp.com>
 <ZgwGpZ6S13vjk8jh@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZgwGpZ6S13vjk8jh@smile.fi.intel.com>

On Tue, Apr 02, 2024 at 04:22:45PM +0300, Andy Shevchenko wrote:
> On Tue, Apr 02, 2024 at 10:22:24AM +0800, Peng Fan (OSS) wrote:
> > +static int pinctrl_scmi_get_pins(struct scmi_pinctrl *pmx,
> > +				 struct pinctrl_desc *desc)
> > +{
> > +	struct pinctrl_pin_desc *pins;
> > +	unsigned int npins;
> > +	int ret, i;
> > +
> > +	npins = pinctrl_ops->count_get(pmx->ph, PIN_TYPE);
> > +	/*
> > +	 * npins will never be zero, the scmi pinctrl driver has bailed out
> > +	 * if npins is zero.
> > +	 */
> 
> This is fragile, but at least it is documented.
> 

It was never clear to me where the crash would happen if npins was zero.
Does some part of pinctrl internals assume we have at least one pin?

It's nice to be able to allocate zero element arrays and generally it
works well in the kernel.  The one common bug with zero element arrays
has to do with strings.  Something like this (garbage) example:

	str = kmalloc(n_char, GFP_KERNEL);
	copy_from_user(str, user_ptr, n_char);
	str[n_char - 1] = '\0';

If the str is zero bytes long it will lead to an Oops when we add a NUL
terminator.

regards,
dan carpenter



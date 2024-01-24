Return-Path: <linux-kernel+bounces-37421-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F30E883AFD1
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 18:28:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D9201F21119
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 17:28:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F8CA1272CF;
	Wed, 24 Jan 2024 17:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UsqQX4ks"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D02851272B1
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 17:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706117051; cv=none; b=e4g6RHI/row6YsIzuTJ7784y5+pEcqQLz+smbSYUp4V1jJdwXr9tt6i7lACOsV648GPQnY/18iQRxfOTERcts6fM9PI6OakW0fLcGhsG8Enhr79xlZ2yDyiBg9gj23hezrfq2JqIGkTq7bV5Bmbp/SzYUQX7lQmjHYMQPvrktHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706117051; c=relaxed/simple;
	bh=84hQubybZvoHS0mUrUXrKWieYpnepVChvkMJ3NXWaC8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P2aW18ju50n6eDGS/iEZYwXZtfgQWWdRrDYWCOUsYvBwpcddMotP8gjWF9Vxf72DqaR7h+qZM9O5cmi4v2xZQdsjWwRaRO9poNNRhn94lq4Sb51PAxZDnr+cg3bRGMMZLrwxlGsvlZEJbxDANgrLS9W0MqJuPbV4Oz8drn2FOAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UsqQX4ks; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3394b892691so760532f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 09:24:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706117047; x=1706721847; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=84hQubybZvoHS0mUrUXrKWieYpnepVChvkMJ3NXWaC8=;
        b=UsqQX4ksPZxr49qaJQov2WigdgSmZqUjvUVjaTXTjHSt/GOx9OHW48gRmpVJAXztWb
         IPYK5LqpyPJZtdd3TO0sM0h6C0D4sIpKr9MsRBxNW8Gle+r5HLfM2hVj/xErg2sMWxzw
         PZD1i7p7wESWuW8EEKzOzUeDX/ppuDOLk6L6dBreirKTbC5OALKKjn9SN8hekHnCOHpA
         luEOA/EYVRnNJ2S3zRRJRUj6kUq6FowhzkEeHZr0b5DutUmjVddYHwvopP4Wx8MojXyO
         deK0D0E5zzRCvfUy5q582mqwuWPdUww6lijmKMNJOCDyEauuBtuhmFbJhutJBTo0/V+h
         BiOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706117047; x=1706721847;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=84hQubybZvoHS0mUrUXrKWieYpnepVChvkMJ3NXWaC8=;
        b=wR/H/ksWaxfmknSIKA7Kd/91TQD0VQpcuE7mNMDAvhMfWvjs4XPwhGRXvDGyHD00nu
         P7KfKV95CDwtaUGYETOCGuGv1xaeczufszJ729WEStkHC6ighLWfKchqmulupigG9GuY
         Ix8AvsjUbETMGm+Hz7V1vWuoZRZ3t+HpzMes6KqWKRpzfx2rDXnRD6EQSg1oaUY68dtC
         AvSSITSDekdYen9PzJBq2dVT2noykhZcmnIB2Ns3bCu+owPyfH7kbkNd+ZS5h0UglcO3
         sa6hOpkTRneZsVW/JAjDFGQ7ohgSnefdHSH8hLvLAVmusxm4EjdQT73mFHEpEIkCSibj
         1jtA==
X-Gm-Message-State: AOJu0Ywp32jJ/mObehG39GL0cPd2eV0o34avPBYRa10unr8mEg4LHgl0
	b1pbbunHdoU1rd/5r3zPk2cXWujBMYHzB1OTlXUZdeEwRFZEbKCUR0mdzNQjUw0=
X-Google-Smtp-Source: AGHT+IGy6q1uZqnQR6FI8b7VYbGDPfXt1pitVJGLsnDj4e3SXBqZHBNvvYPKioX8VWyL3ysKZeRqoQ==
X-Received: by 2002:adf:f4cf:0:b0:337:d6c8:1af5 with SMTP id h15-20020adff4cf000000b00337d6c81af5mr735025wrp.53.1706117047102;
        Wed, 24 Jan 2024 09:24:07 -0800 (PST)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id b13-20020a05600010cd00b003392c1f40acsm10493581wrx.28.2024.01.24.09.24.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 09:24:06 -0800 (PST)
Date: Wed, 24 Jan 2024 17:24:05 +0000
From: Daniel Thompson <daniel.thompson@linaro.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Lee Jones <lee@kernel.org>,
	Jingoo Han <jingoohan1@gmail.com>, Helge Deller <deller@gmx.de>
Subject: Re: [PATCH v1 3/4] backlight: hx8357: Make use of dev_err_probe()
Message-ID: <20240124172405.GA15881@aspen.lan>
References: <20240114152759.1040563-1-andriy.shevchenko@linux.intel.com>
 <20240114152759.1040563-4-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240114152759.1040563-4-andriy.shevchenko@linux.intel.com>

On Sun, Jan 14, 2024 at 05:25:10PM +0200, Andy Shevchenko wrote:
> Simplify the error handling in probe function by switching from
> dev_err() to dev_err_probe().
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>


Daniel.


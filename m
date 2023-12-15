Return-Path: <linux-kernel+bounces-1267-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 69E54814C98
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 17:12:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D72C01F24835
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 16:12:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FB113BB34;
	Fri, 15 Dec 2023 16:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OPJWHqEH"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0CA93EA68
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 16:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-40c3ca9472dso9104795e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 08:11:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702656686; x=1703261486; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xjfWYzWd4wgJGa/29WuHSyewFcHfkJSdAaMGHjnzo9k=;
        b=OPJWHqEHLifhdGtxPpe6nYNJDZlZzsujYbfwCFT7yAK8KI/9QrRjIRbwD1rfr1l2QK
         JKQf+zYHNdT8etZk7wAWu2fsCKZtDJPmON/a8XxopC1Vvn+PuB3iIT/naWkwbCG2YOLv
         yFYlXsBwYT5Ml8nlG1vR7RgjLN9p4x5wdDTf8O2HJF1VgxmbwM3DoPGl2tePfRhSAK44
         S7eDff60FYG+jy/xfRazRxc5/V7vjioSK8MSPP9m940uRq8rItwShJc6MfYIJqqJwcAQ
         kwpmK6N9dMAXgz5TJfG3JbfkKXoDxriG6LjKjY9mH+Coz6qgzqIhCtFeNmpVBm/2BAHz
         0zFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702656686; x=1703261486;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xjfWYzWd4wgJGa/29WuHSyewFcHfkJSdAaMGHjnzo9k=;
        b=hxnAOvTPt7IClXqjYLqP4Zv57m/hwP0T972sjRikOeObGRs/mL+TkBp4+1e23l450W
         zhQNmFDXDE5behipKbv0czQIcw6ri5l6MzHxhKJztHYPC2Y0GQfx5256oiHCovg2n4vc
         d9DWKL794UvZCe80+fOwpf7frFafYk9fU3Nl1h/IuLvxG8xcGXDJm3tdx4Vh6ug6nSx6
         cR+T7O6f/neKGSidYRatbW4nTWTLW8xbuJ9OldALbbrVLLadhAj9kxXoBVbBICgT/qL8
         FrDYu7g5v4rBM43BDDGc18/OY4LcH+U62SUuilP4fsjYTFioA6te8yxVp6EbzXInyhNC
         AsMg==
X-Gm-Message-State: AOJu0Yxt+3Z+U0LfijJ340tLySndeu0NR6DOZ/Us0gCxLLJCZLPc8CEH
	q7ZG+7hkbYbHpi55SBSlO8qcHdANMyoq+twv/6Q9Qw==
X-Google-Smtp-Source: AGHT+IEDPUTIQdX+5o6mWltMx2mWOny7j3VwgpyCppn/saZ1B0MQY8/3rkAc+pBFE95C0ol9B7s7/g==
X-Received: by 2002:a05:600c:2d4c:b0:405:1bbd:aa9c with SMTP id a12-20020a05600c2d4c00b004051bbdaa9cmr3616687wmg.34.1702656685924;
        Fri, 15 Dec 2023 08:11:25 -0800 (PST)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id l15-20020a05600c1d0f00b003feae747ff2sm32267141wms.35.2023.12.15.08.11.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Dec 2023 08:11:25 -0800 (PST)
Date: Fri, 15 Dec 2023 16:11:24 +0000
From: Daniel Thompson <daniel.thompson@linaro.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Flavio Suligoi <f.suligoi@asem.it>, dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Lee Jones <lee@kernel.org>, Jingoo Han <jingoohan1@gmail.com>,
	Helge Deller <deller@gmx.de>
Subject: Re: [PATCH v1 2/2] backlight: mp3309c: Utilise temporary variable
 for struct device
Message-ID: <20231215161124.GB662726@aspen.lan>
References: <20231214195158.1335727-1-andriy.shevchenko@linux.intel.com>
 <20231214195158.1335727-3-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231214195158.1335727-3-andriy.shevchenko@linux.intel.com>

On Thu, Dec 14, 2023 at 09:51:14PM +0200, Andy Shevchenko wrote:
> We have a temporary variable to keep pointer to struct device.
> Utilise it where it makes sense.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>


Daniel.


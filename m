Return-Path: <linux-kernel+bounces-24451-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03D2682BCBC
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 10:13:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A700C284DD0
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 09:13:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E325757309;
	Fri, 12 Jan 2024 09:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Q0mn+R2+"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 686CB57303
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 09:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-40e66315d93so3591075e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 01:13:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705050796; x=1705655596; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2GNCOaNf72ac1p4DJQFQCIdNNRWbinhqfQ3wnSBTC9o=;
        b=Q0mn+R2+YZDM8WVoc0EbIBprPnYbONqSEAClBPM0Qz63pc6CmGwqxQ4MvPyMmzJO0N
         l7jCA9jM/0Q2YK5ywXKOJe+1d9A9dzSzgC/+u6msnmUGpu9823BtfaYiv773Y3B4bqxq
         4x/4VepQLK6sYOE/rcdnaYEgaut/XHalUdXwv/OhI2LYsQxA4oiVTxfc7zm8LWEnPtc4
         xNG19VltjISlwyUqEZ2kfxLa+MvGFnL67IFpkBsFwii0KPv2GZo1I2BBfvAvzGK7XhYL
         Z6WWojzGI9SpjG4UsTVuOGciTCA0HCamz0Ff9Ehde1GVDYRv+i+0rvEzmnjzh7/02fLU
         +mXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705050796; x=1705655596;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2GNCOaNf72ac1p4DJQFQCIdNNRWbinhqfQ3wnSBTC9o=;
        b=Ru5Ei9CL6ugvZvYGOADd8hYTDdm2OtUxG2bxGH1YgyapvyuRqp/G6mpzV6hNVomKwi
         oB1FFs8c4HxRcG4wjQNM+daVgxncCRdEDeOK7Qni55OHMvbauRN7IKw6mDAl4jD71SkE
         wxG9TMRXSGdMnLbPrHRWUAN+yVxVYOE9ny4inDyNb9pqRL+2r9ZK23rLu6fXuhy//bF6
         aKOrbAX8/y/YhvVY/y/Rhky9aoCO/7X1pVXNeBk1FF21rZSZDyhkOB0GmInp2zLkIIZc
         uy1QrrfcVEGSiglfidGutgkvdils2GpS5GovvoojXTgbAUFoyi8XeZb+8hHH37a5WDAQ
         Gp3w==
X-Gm-Message-State: AOJu0Yz2YDxkLzXL+POj9QY7vT0liOBdp6kYcU31eUdWv/1sWg8/MXSh
	jnVDkE8IRVkc+AWpUCxtgWjzHIftPJUMcaH+3DGvJchnIHg=
X-Google-Smtp-Source: AGHT+IGfcv0H8vypMveXPzRDAavq2xXQwW8XW9oGY1wupq4fSvWEsfJX5vTVKCAfz+nyCWF5md0yKg==
X-Received: by 2002:a05:600c:8608:b0:40e:6238:e92d with SMTP id ha8-20020a05600c860800b0040e6238e92dmr494214wmb.128.1705050796719;
        Fri, 12 Jan 2024 01:13:16 -0800 (PST)
Received: from localhost ([102.140.209.237])
        by smtp.gmail.com with ESMTPSA id az8-20020a05600c600800b0040e49045e0asm4991809wmb.48.2024.01.12.01.13.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jan 2024 01:13:16 -0800 (PST)
Date: Fri, 12 Jan 2024 12:13:13 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: David Laight <David.Laight@aculab.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	'Andy Shevchenko' <andriy.shevchenko@linux.intel.com>,
	'Andrew Morton' <akpm@linux-foundation.org>,
	"'Matthew Wilcox (Oracle)'" <willy@infradead.org>,
	'Christoph Hellwig' <hch@infradead.org>,
	"'Jason A. Donenfeld'" <Jason@zx2c4.com>
Subject: Re: [PATCH next v4 0/5] minmax: Relax type checks in min() and max().
Message-ID: <918545c4-0870-4ea5-ab11-53eaed91aec7@moroto.mountain>
References: <b97faef60ad24922b530241c5d7c933c@AcuMS.aculab.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b97faef60ad24922b530241c5d7c933c@AcuMS.aculab.com>

I've often wondered why so many people use min_t(int, size, limit) when
they really do not want negative sizes...  Is there a performance reason?
git grep 'min_t(int,' says there are 872 instances of this.  Probably
some do want negatives but it's a quite small percent.

regards,
dan carpenter



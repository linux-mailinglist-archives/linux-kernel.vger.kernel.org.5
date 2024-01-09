Return-Path: <linux-kernel+bounces-20497-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 164BE827FC9
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 08:51:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9CC1288828
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 07:51:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91C5F13ACF;
	Tue,  9 Jan 2024 07:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uB91eXvQ"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67172C15B
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jan 2024 07:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-40e5280a33eso93145e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jan 2024 23:51:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704786681; x=1705391481; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ajIAvbvfoHd2Dm4Y0RFYgsc64SgXUokhIDDglANw3bU=;
        b=uB91eXvQ9DqbJDGAuLh9wKvpBQiND/qT5YV0Abd3i4snCQTfv9CjrMGGBhpSq0nuaG
         qDGzqhfOVU37BrVQXWoYOLs1IpmwOpGSn0gbDJUeqPuVSBf1j0BNOvuMh4BdMQZBK4lr
         ElG1aG5UKoNwAHH7kIeKCreLBi0goJGQYi5IMkJXQBBldo3HxmokXAyXkD73hcQgZXtK
         Xm6uhHdn+/RbWR1rO4n9U9XPshBB+MRwKZ+yIqrpjpLg0A3tFazUwn/jyhcXCT17Nhww
         5nBZyRR5oOklFd7gr6N25DO2EJmihmKaTwMwtEAp6JpsG4nUSAoROmQkeOVsbSxys9Nf
         x5NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704786681; x=1705391481;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ajIAvbvfoHd2Dm4Y0RFYgsc64SgXUokhIDDglANw3bU=;
        b=bWTaz8leBtzJa9lUKlaAcWR8l+Huwo8yyVEDNcAFG60q0LIfrVY+ZLupBRzMdLIFDa
         /h4UT52S9Yq17cOtzH/KiTjwQSparVVYx0q+6K+HPIgYDf5rPiM1+KH6hx8G8NWE+d5m
         SYUJthuwNUK/JI59cmi1I/n9RV7lcuXCEiKXIeFQ7sVEokL6JIuCkzpbdyAAnndbXQR2
         dQ2wtU9hhMv6MX+lBbyz8ylAH+wOT9JxwhBQIMygsmPgDJFAASL8O7bnUgzNaHQ9TBz8
         3uqqv3QPoYHkh4DW7NHnvILtJwKhVb1CxOzahvsb6+ii3ZNgVMVNMBcJnhi243y9Bw+7
         /LKA==
X-Gm-Message-State: AOJu0Yx+GBZ4Xun1SfqPs6G5rceDaKCSeLItj0Ou+fFfudoQxWoBB59I
	ikGd45kfoSl51Mfayrz8aehXFauaeMeGQQ==
X-Google-Smtp-Source: AGHT+IGjfcsvgCctKIWthRavB2j4sQAq5t6BFCH1lgirHrvd5/nWv+jm6ATm5mMLTYU76UWU3eiycA==
X-Received: by 2002:a05:600c:5491:b0:40e:44ad:7222 with SMTP id iv17-20020a05600c549100b0040e44ad7222mr159229wmb.8.1704786680743;
        Mon, 08 Jan 2024 23:51:20 -0800 (PST)
Received: from localhost ([102.140.209.237])
        by smtp.gmail.com with ESMTPSA id f13-20020a05600c154d00b0040e3635ca65sm13777111wmg.2.2024.01.08.23.51.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jan 2024 23:51:20 -0800 (PST)
Date: Tue, 9 Jan 2024 10:51:15 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Hidenori Kobayashi <hidenorik@chromium.org>
Cc: Sakari Ailus <sakari.ailus@linux.intel.com>,
	Bingbu Cao <bingbu.cao@intel.com>,
	Tianshu Qiu <tian.shu.qiu@intel.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Yong Zhi <yong.zhi@intel.com>, stable@vger.kernel.org,
	Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
	linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] media: staging: ipu3-imgu: Set fields before
 media_entity_pads_init()
Message-ID: <68ff6c83-b8c7-4bcb-9b94-a33ab83aaf58@moroto.mountain>
References: <20240109041500.2790754-1-hidenorik@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240109041500.2790754-1-hidenorik@chromium.org>

On Tue, Jan 09, 2024 at 01:14:59PM +0900, Hidenori Kobayashi wrote:
> The imgu driver fails to probe because it does not set the pad's flags
> before calling media_entity_pads_init(). Fix the initialization order so
> that the driver probe succeeds. The ops initialization is also moved
> together for readability.
> 

Wait, I was really hoping you would include these lines in the commit
message:

the imgu driver fails to probe with the following message:

[   14.596315] ipu3-imgu 0000:00:05.0: failed initialize subdev media entity (-22)
[   14.596322] ipu3-imgu 0000:00:05.0: failed to register subdev0 ret (-22)
[   14.596327] ipu3-imgu 0000:00:05.0: failed to register pipes (-22)
[   14.596331] ipu3-imgu 0000:00:05.0: failed to create V4L2 devices (-22)

That's what people will search for when they run intio the problem.
Could you please resend a v3?  Normally, editing a commit message is
pretty easy, right?

regards,
dan carpenter




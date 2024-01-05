Return-Path: <linux-kernel+bounces-17413-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 51D26824CD7
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 03:19:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7864F1C21C5A
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 02:19:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C1AB2100;
	Fri,  5 Jan 2024 02:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="RaESA5lq"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39A931FD1
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jan 2024 02:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-6d9b51093a0so841778b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jan 2024 18:19:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1704421167; x=1705025967; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PtFtZ+5mwnqDmafnvGk1KxVAkboQiwGd/FdiEdjKkj8=;
        b=RaESA5lqe8He9A76Egp038uKQ9DFcOnZl9prGmaAoGwFObDmcpFjGzozl3TwmsM1/s
         0724wrR9ir8/16VftOFCjUU6QrTvCTIZCz+ZQTR9MjCeKHhc1/+qDMc7IfCYywCrw3l5
         JJAq/3FzFc82TwJ/wubOReZSBTyjqedICKPj4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704421167; x=1705025967;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PtFtZ+5mwnqDmafnvGk1KxVAkboQiwGd/FdiEdjKkj8=;
        b=vjB9KZppq8aB66uHG1CtX5v0UplKOf4CD2MjLw+Clk2yelh64O9nG8Z0CawrFP8bds
         Ksd2RDWxgYYm9vWwozflxyc20BupTerLG40NKLUNjJZ1IhwvvSzDxx1BQsb1Rh25gmwx
         jC5G/+xrw/TuCTL0Ks8PAkC2YdPz3XciaOCpbwb46H08f3hdKd6JBQSLTpXinNaPmaeZ
         P0HPvCpU8PydTqeXDJNFGsARscMZVhMudwOfbjEN5xqIEZCHGZKchEXBPFeJsMg2DNL3
         Hm6srkhoOCNqItKiPPWA4gIdw/hUhCU3at5az8C7wK9J7MrFY8CUV5KEGEP85kkoVrAe
         KnhQ==
X-Gm-Message-State: AOJu0YwIR+QwFdE4uzDR69YGZdTqF5h8gO9vwt9bh+Vxt8VpY7IAY/6n
	shMLfDCZZMr7xAYACTihGxd/I3HWQNjL
X-Google-Smtp-Source: AGHT+IG10zyDX+DZdfngP0HU48q9cOHuEIi1EQDy+l3D5Dbo4SFEIG4ySgoZuZ464VPGAeOFGGum7Q==
X-Received: by 2002:aa7:8896:0:b0:6d9:c201:66f0 with SMTP id z22-20020aa78896000000b006d9c20166f0mr1472598pfe.27.1704421167568;
        Thu, 04 Jan 2024 18:19:27 -0800 (PST)
Received: from localhost ([2401:fa00:8f:203:65cf:cf74:4dbc:9e23])
        by smtp.gmail.com with ESMTPSA id w9-20020a63d749000000b005cdf9c8e922sm339313pgi.85.2024.01.04.18.19.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jan 2024 18:19:26 -0800 (PST)
Date: Fri, 5 Jan 2024 11:19:23 +0900
From: Hidenori Kobayashi <hidenorik@chromium.org>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Sakari Ailus <sakari.ailus@linux.intel.com>,
	Bingbu Cao <bingbu.cao@intel.com>,
	Tianshu Qiu <tian.shu.qiu@intel.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] media: staging: ipu3-imgu: Set fields before
 media_entity_pads_init()
Message-ID: <20240105021856.wpzmwtyzxzqfznrp@google.com>
References: <20231228093926.748001-1-hidenorik@chromium.org>
 <27f1c487-78cc-4e56-ba79-1434aba131fd@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <27f1c487-78cc-4e56-ba79-1434aba131fd@moroto.mountain>

On Thu, Jan 04, 2024 at 01:04:27PM +0300, Dan Carpenter wrote:
> On Thu, Dec 28, 2023 at 06:39:25PM +0900, Hidenori Kobayashi wrote:
> > The pad's flags is checked in media_entity_pads_init(), so it has to be
> > initialized beforehand. The ops initialization is also moved together
> > for readability.
> > 
> 
> How does this bug look like to a user?  What is the Fixes tag?  Does
> this need to be backported to stable?

I suppose I should have included those in the commit message.

1) To a user, the imgu driver fails to probe with the following message:

[   14.596315] ipu3-imgu 0000:00:05.0: failed initialize subdev media entity (-22)
[   14.596322] ipu3-imgu 0000:00:05.0: failed to register subdev0 ret (-22)
[   14.596327] ipu3-imgu 0000:00:05.0: failed to register pipes (-22)
[   14.596331] ipu3-imgu 0000:00:05.0: failed to create V4L2 devices (-22)

2) Re Fixes tag, I see that the first commit of imgu driver already
initializes the flags after media_entity_pads_init(). The documentation
of this API ( "Drivers must set the direction of every pad ... before
calling media_entity_pads_init") predates the first commit. So, I guess

Fixes: a0ca1627b450 ("media: staging/intel-ipu3: Add v4l2 driver based on media framework")

3) Re stable, I was not sure. The probe failure only appears after a
check was added by Commit deb866f9e3a45ae058b21765feeffae6aea6a193. That
check is not in linux-6.6.y branch. So I was not sure if this counts as
"a real bug that bothers people" mentioned in the document.


With the above, how does the following sounds to you?

The imgu driver fails to probe because it does not set the pad's flags
before calling media_entity_pads_init(). Fix the initialization order so
that the driver probe succeeds. The ops initialization is also moved
together for readability.

Fixes: a0ca1627b450 ("media: staging/intel-ipu3: Add v4l2 driver based on media framework")

Thanks for the guidance,
Hidenori



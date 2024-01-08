Return-Path: <linux-kernel+bounces-19628-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EE9C827001
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 14:37:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F0281C228F9
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 13:37:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2847B44C99;
	Mon,  8 Jan 2024 13:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RUqY0nPE"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E6E744C7F;
	Mon,  8 Jan 2024 13:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-78321045d1cso66798785a.1;
        Mon, 08 Jan 2024 05:37:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704721056; x=1705325856; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UKVIG+yIgX/6o/zMzpy1M13iNiwFfwfMQ9rMkqHA42w=;
        b=RUqY0nPEWjIL+2pPOLpcJjhpLfRsBUlTJFF808Y1furSjiRErkrzdcf0nKF8zKbwF6
         Rr2GNTMmHmCpeSA0xE29BwV5HPqzqD0tGPTzDiOb19gICCgPfkvuR5u7Rs74C3XFM9jf
         9w+juXFZkgJWolJ0lNJWuLDyJ+R0SJTw9Akd23So2y5vKojvDYhKfqZFBZUgA/gTAEiK
         0/WuUdpDEtUaCQKKxg0uXhs3rWX4K63LLsmlT78s7MOzvYnzL4y2IQxIQsUFQHaQ47cB
         NIL83QrVHk6gePi9MrL+1uq6qTq1WpyedVf9HlJZMUOpnAf8yHdnMINBSQ9G1NSy3fME
         5yIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704721056; x=1705325856;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UKVIG+yIgX/6o/zMzpy1M13iNiwFfwfMQ9rMkqHA42w=;
        b=BPLo4PdTMvhe1va4GOmPfUIcAjUalrwSffR3QHiyJ7Zw9DTuarKzRnBpjFRspDvFeR
         CWM1sOvn32fN/u6dp7iP7qmoFY7fgFz6Rl99RViDqFrqO8NZbD/vfMouOy8XLYoVT436
         cjf+S079FX4bFjen8RZTbEswAvHTuqj/YutRHo75FNwcBQHZ13tNfhACP/IwtEOKePqx
         II8RU2E0EYNFO4KekVD7vVQ/vVOUtJcXyzWYczBlGHEC3p5UFHC/oHp/EIxQqKBi6QLq
         vjilR5m5XSvtyCjSIZd9lpRh6oD4wnj71nEdxuOfm/L9cs1hk7rZFUyVVbOlWUNjBOCq
         hatw==
X-Gm-Message-State: AOJu0Yy8nGNsZaUGE2b2twIi0Vd4dDf1I+b+4vw3QT4n2FyOC1vWrLuz
	XRakDmTKfHgZEYrlIKGPIy0s/ZUhfNPyHu12
X-Google-Smtp-Source: AGHT+IGSQtUUJ7UuvgXVcZobBvT29jsnSs8uRLWDaZSVusujHLr+PbtItWRm0fo77mTXcLt50s8g6Q==
X-Received: by 2002:a05:6214:410f:b0:681:96d:e5b4 with SMTP id kc15-20020a056214410f00b00681096de5b4mr1471329qvb.58.1704721055968;
        Mon, 08 Jan 2024 05:37:35 -0800 (PST)
Received: from system76-pc.localdomain (pool-108-53-73-136.nwrknj.fios.verizon.net. [108.53.73.136])
        by smtp.gmail.com with ESMTPSA id i8-20020a056214030800b0067ffcfb0b51sm2860146qvu.139.2024.01.08.05.37.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jan 2024 05:37:35 -0800 (PST)
Date: Mon, 8 Jan 2024 08:37:33 -0500
From: Mohammed Billoo <mab.kernel@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Marek Vasut <marex@denx.de>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
	Biju Das <biju.das.jz@bp.renesas.com>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: adc: ti-ads1015: Use correct pga upper bound
Message-ID: <ZZv6nV+BxJFF7Nx9@system76-pc.localdomain>
References: <20240106174836.1086714-1-mab.kernel@gmail.com>
 <20240107161524.7dc72a3f@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240107161524.7dc72a3f@jic23-huawei>

> Seems correct, but I'm curious - did you see an actual problem with
> setting the value to 6?  From my reading of the ads1115 datasheet
> 6 and 7 should be functionally identical to 5.

Hi Jonathan,

No, the behavior was fine. When I was trying to adjust the voltage range via the
pga setting, I noticed that the implementation didn't match the comment in the binding
for the max value.


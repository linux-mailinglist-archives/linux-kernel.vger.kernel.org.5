Return-Path: <linux-kernel+bounces-19103-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 595EA826810
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 07:35:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C3BFBB2112F
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 06:35:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75C1C6FDC;
	Mon,  8 Jan 2024 06:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nl6cIWW3"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 450638C06;
	Mon,  8 Jan 2024 06:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2cceb5f0918so13724491fa.2;
        Sun, 07 Jan 2024 22:35:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704695719; x=1705300519; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RUHqImkDji/0W298q5CLYrFD/FU6lfeTagixCLoFStQ=;
        b=nl6cIWW36HYtDxoKwj7T8xg130WMTS0zFAgrtRzmRqLGeLZpLRIxU0eLOlRCGqnmI+
         avAbA9VOc4/HODV8bBJXJTj3NumEYFWRAkkZeNbUyck00oHwophoejbZExosU/yqthzB
         dJd9XwWtpUKu0jkcpq2IcQZU2+qs40+GyHUYFc6zqL9tqpdZigIowL4ZzZ8m6qG+lVEg
         xTH1n7JYg/ICgoZBiEsceQ+Cm0uxdn21OWjWbimUViuAEdGMw7aNcY0WR9mu8NRQ7Xd2
         IZaak0pNGPYuCwT9v8jYuDdimgE65WjGzGwqM804jTmw6tezoz40nZw9DGmvt1czZLkn
         S13w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704695719; x=1705300519;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RUHqImkDji/0W298q5CLYrFD/FU6lfeTagixCLoFStQ=;
        b=dyhtth7buYqvRO67jZdwjGAmuzNHToR19IX1uSqWjyK+kPfpUKWygTe7vCXVCvZ2fM
         0cnJscAhhZWUs+ccAhyi3ydnS3zjtI9QCj8uLjJiuVjlJqe5oH24oo58YJ7a3LXNYRDb
         hmAPqOCId+o/X8w2e96OpyhTBDIGs17lekvhoc/o/3LX8pr6PW86thYGgEyhwAVMB2Eh
         Xwg5t9fLWx/bjHSoZZ8RXYGNzl9VVv+8hC9SNtbN2XIV2Xh4hm51yM1QZt2lzzEbNaCG
         JOwAnvxNG2MNBS3aUF2UiOMx9UJzZ/XsvoPcu8s01SC/NGwJeJ+vlJUUBRF170VfEnnb
         1vMw==
X-Gm-Message-State: AOJu0Yy1t4H0pTknsJl5G7sDU9liYOeWEdTobYMFDoKZovZdNXHsk7bd
	35E8VKLW2CQH2H0SGFxf0+8=
X-Google-Smtp-Source: AGHT+IG7QnT1MqegDq6TKHm2afXir+xT1YBWCGCM0moJ5ZPk35M1BZnuzE+I1B97RV+GXtLD5R5PcQ==
X-Received: by 2002:a2e:a553:0:b0:2cd:4e51:cea6 with SMTP id e19-20020a2ea553000000b002cd4e51cea6mr449278ljn.106.1704695718962;
        Sun, 07 Jan 2024 22:35:18 -0800 (PST)
Received: from ?IPV6:2001:14ba:16f8:1500::7? (dc78bmyyyyyyyyyyyyydt-3.rev.dnainternet.fi. [2001:14ba:16f8:1500::7])
        by smtp.gmail.com with ESMTPSA id g22-20020a2eb0d6000000b002cd40121a49sm1017491ljl.36.2024.01.07.22.35.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 Jan 2024 22:35:17 -0800 (PST)
Message-ID: <fb847634-94f1-4001-bb5c-3c4c56aba9f7@gmail.com>
Date: Mon, 8 Jan 2024 08:35:17 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iio: gts-helper: Fix division loop
Content-Language: en-US, en-GB
To: Jonathan Cameron <jic23@kernel.org>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
 Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <ZZZ7pJBGkTdFFqiY@dc78bmyyyyyyyyyyyyydt-3.rev.dnainternet.fi>
 <20240107162253.66c1f0f1@jic23-huawei>
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20240107162253.66c1f0f1@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/7/24 18:22, Jonathan Cameron wrote:
> On Thu, 4 Jan 2024 11:34:28 +0200
> Matti Vaittinen <mazziesaccount@gmail.com> wrote:
> 
>> The loop based 64bit division may run for a long time when dividend is a
>> lot bigger than the divider. Replace the division loop by the
>> div64_u64() which implementation may be significantly faster.
>>
>> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
>> Fixes: 38416c28e168 ("iio: light: Add gain-time-scale helpers")
> 
> Hmm. Fix or not perf improvement?

Ha. I don't fancy calling my own doings as bugs - but when a code can 
keep kernel busy looping for several seconds... :|

>  I'm going to take the middle ground
> and leave the fixes tag, but not rush this in.

I think this is fine. It is nice to get this fix in stable if we have 
longer living stables with GTS helpers, because that's where many people 
do "real work" - and because it is likely some devices with new sensors 
are being built on products using these stable releases.

Still, the current users (ROHM light sensors) don't use that big 
dividends. Hence I don't think this needs any high speed fixup process :)

Thanks!


-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~



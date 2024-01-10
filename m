Return-Path: <linux-kernel+bounces-21959-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFEE4829724
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 11:18:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 461D0282930
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 10:18:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E0BB3FB10;
	Wed, 10 Jan 2024 10:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tp1MoaqS"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D44963EA71;
	Wed, 10 Jan 2024 10:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-50e7e55c0f6so4319652e87.0;
        Wed, 10 Jan 2024 02:18:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704881908; x=1705486708; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=s5yWLbB7pG0RwsgLCzWt79KVs24KEr1oBq1U9uQ7DFg=;
        b=Tp1MoaqSSzRPiQOjYlmFHz9zTP9lunnXhE7yFDhWJC7+1QBiKUxANNCR2ng+RVZyLS
         uVQqPniGc5zJ8aNZBpxGZ5XJ8JFxl+SclBvq7HzdqgYHV/sVZqnkYjEy+sN9WXxKoOtl
         PS8WAxNjPf/k7ZsC+LxtHceajClurPlQm0e1iWy9fnnLl7yrp7cpTGU+wZAmGvhMbOhq
         +Qb0clxtxZxOQBNHLxt5HWdfUt2xXTyQKYc9PbYt3UIZj9oeUB/CMMavMfzjoAiix7cn
         is4XjbH8/wGzSEL2E23NaWxW43k1118Q+ZIyTP5+NsPwNasKXcg4c5Ukr8ciQRE+r1qy
         GcYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704881908; x=1705486708;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s5yWLbB7pG0RwsgLCzWt79KVs24KEr1oBq1U9uQ7DFg=;
        b=FK/Xc1aag7d3BVdOwdqrcgEaQy+ZUnsMFA2FgQhm7yioiTqp77K7Iq3pu5kyetc5A6
         bfRBPaCxJm9unWHI34eMaRPeOky0yX5BcsqFnL/jR9OXC/0Us2Xs8i3KU96eDxpAa925
         fM3IbPq1bzVJ4q5z5UF5NXKXaPO+m9waCG0JvqzUxHWJkZoYjYDUpWEoC6eBZPGxcmXA
         5XzKpMKP2Qlza2QMBCHA+j++hwiOoWIYk7q6LrYHXJhJgCJ6ZYSQfyiKvcWyoMGjsG3t
         e98VP3VVUML9q3Caq1tInv2IfqTdG1N4LAkQyhnTAcKWG8/xKfCKnQnO3QctNmpfvyNi
         p2eQ==
X-Gm-Message-State: AOJu0Yy3DUbxyVcSe05bRANkQl7CpKLVkt2kBpXq9ndX26n01t20pu/r
	QXgzDuxLUstpinHPF/4tQ1zTrzChMv0=
X-Google-Smtp-Source: AGHT+IGFWDeY/BhbULd4E0HPORvz8dLKIULpmKHqwlYWsGe2qdvSwuEPhNqQK1sv/VygwybIDAT27Q==
X-Received: by 2002:a05:6512:1310:b0:50e:747e:22f4 with SMTP id x16-20020a056512131000b0050e747e22f4mr207187lfu.147.1704881907738;
        Wed, 10 Jan 2024 02:18:27 -0800 (PST)
Received: from ?IPV6:2001:14ba:7426:df00::3? (drtxq0yyyyyyyyyyyyybt-3.rev.dnainternet.fi. [2001:14ba:7426:df00::3])
        by smtp.gmail.com with ESMTPSA id a8-20020ac25208000000b0050e9e51a361sm620730lfl.25.2024.01.10.02.18.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Jan 2024 02:18:26 -0800 (PST)
Message-ID: <b2523224-972a-41eb-b28e-92d22b8d553e@gmail.com>
Date: Wed, 10 Jan 2024 12:18:25 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] KUnit tests for the IIO GTS helpers
To: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen
 <lars@metafoo.de>, linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
References: <cover.1704881096.git.mazziesaccount@gmail.com>
Content-Language: en-US, en-GB
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <cover.1704881096.git.mazziesaccount@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/10/24 12:07, Matti Vaittinen wrote:
> Add some KUnit tests for the IIO GTS helpers.

..

> Matti Vaittinen (3):
>    iio: gts-helper: Fix division loop

Please ignore the patch 1/3 above. It has been already merged. 
Unfortunately I noticed this commit being in the series only after 
sending the cover-letter. In order to not consumer reviewer's time, I 
omitted sending the 1/3 - so it's missing the series on purpose. 
Subsequent versions won't include this patch anymore.

>    iio: test: test gain-time-scale helper >    MAINTAINERS: add IIO GTS tests
> 
>   MAINTAINERS                           |   1 +
>   drivers/iio/industrialio-gts-helper.c |   5 +-

Also, this file is not changed by patches 2/3 and 3/3.

Sorry!

Yours,
	-- Matti

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~



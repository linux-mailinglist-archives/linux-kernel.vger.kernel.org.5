Return-Path: <linux-kernel+bounces-5710-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CE9C818E72
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 18:43:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A04841F28621
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 17:43:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17B77364A8;
	Tue, 19 Dec 2023 17:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iI2wwi2d"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8A973D0CB
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 17:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-40c31f18274so61210705e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 09:43:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1703007783; x=1703612583; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TRnmGv8xzBtREryt49zmigJAc9uozsvO/KimVQjMLww=;
        b=iI2wwi2d1JfuYnPtXeMDcds2VWNc+WiyASTa5IXWdT7Vu529+SnmwfoAx+ecseUoVx
         WOkhBfi8gXbtPaxg3sxHXoFG1nMp2Pj55hHxejnwxjJf76ifEsu0nJNdh4c/VhonIDaI
         js3Rg2xYSaXE8zrNesn6xruYsq5P4kNmZrQjjQLU02TFZh7XwNEjJuRBE4vR76AdgKuu
         Uh8DZJiDN/nJAnyry8291CegGcEtY7oST+qoD9Hq51VOoreHwI7sAzpxAg676/n/ghmy
         BRC6xEbwQit2K0280n6kmqVQuzN2Kayo5f+ROZq3JhOtiO0Sa4uUn78ElFRVYLmmgHt6
         2U5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703007783; x=1703612583;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TRnmGv8xzBtREryt49zmigJAc9uozsvO/KimVQjMLww=;
        b=Q4KgnXYPV1sICdcsncnzkKoKpO5vc4kfkrfkMmYnxSdHYmgnlrxX56PR+O8RJQh3wC
         W1ViZZolA8/fzbTUUzDb8j700yM6+tq+YHhsZUnykgyG6QTgg/+tKZwRhEJtmoEGqVPM
         Awfxhma//rp2wHvd8nAAOE4WolIfCX0rUu+l5FQ5NTbaih7+C2fSG2wXP3+et2PD9MRu
         /iTxB9xs4eDtzNHEoHqtIMQ5PyECDnuptiH55Sw1l5C95qrhv/RNId70FUZUmNtvBPoW
         wN1GrWUyEtgP66kSJiWLuGNeYHrYbZl3JxsiBDKpq3gckJkN9GZJQYZpeiaUcuQnjnQT
         W0ow==
X-Gm-Message-State: AOJu0YxW5zN8bDlbSfwo1F7N2k5m5H61rRPmLc70gOs9AocRgk26mSuJ
	kcdGvyp7uydUacLazJglyAznRQ==
X-Google-Smtp-Source: AGHT+IFuUu0ohM0DgqSQKkmxColi/SAtbH6YHORkgyaGUdrSffYDo7d3mbYVlsllH+lOmS2Eou5MzQ==
X-Received: by 2002:a05:600c:2051:b0:40c:6924:5f2d with SMTP id p17-20020a05600c205100b0040c69245f2dmr4379823wmg.231.1703007782984;
        Tue, 19 Dec 2023 09:43:02 -0800 (PST)
Received: from [192.168.10.46] ([37.170.14.102])
        by smtp.googlemail.com with ESMTPSA id c9-20020a05600c0a4900b0040c6d559490sm3942666wmq.3.2023.12.19.09.42.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Dec 2023 09:43:02 -0800 (PST)
Message-ID: <4ed663b6-6c1d-43ed-8417-1704b9adfbae@linaro.org>
Date: Tue, 19 Dec 2023 18:42:57 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 0/3] Add D1/T113s thermal sensor controller support
Content-Language: en-US
To: Maksim Kiselev <bigunclemax@gmail.com>
Cc: Andre Przywara <andre.przywara@arm.com>,
 Vasily Khoruzhick <anarsoul@gmail.com>, Yangtao Li <tiny.windzz@gmail.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Samuel Holland <samuel@sholland.org>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Marc Kleine-Budde <mkl@pengutronix.de>, John Watts <contact@jookia.org>,
 Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
 linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
References: <20231217210629.131486-1-bigunclemax@gmail.com>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20231217210629.131486-1-bigunclemax@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 17/12/2023 22:06, Maksim Kiselev wrote:
> This series adds support for Allwinner D1/T113s thermal sensor controller.
> THIS controller is similar to the one on H6, but with only one sensor and
> uses a different scale and offset values.
> 
> v6:
> - Rebased onto 6.7.0-rc5

Applied, patch 1 & 2

Thanks


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog



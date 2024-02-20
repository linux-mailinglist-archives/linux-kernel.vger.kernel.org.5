Return-Path: <linux-kernel+bounces-72444-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3203E85B353
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 07:59:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 248881C20F4D
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 06:59:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B194D5A103;
	Tue, 20 Feb 2024 06:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZSJq5wDz"
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60D895A0E5
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 06:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708412383; cv=none; b=EJESlVjmluOEW/9ykWM9sQ1drPeOyzvyAUX4ygfJoGQlhReovjK1e0fP4K3HH5DfiY066xkpf2x4a43gWaDIAn94e9ePNB6LmZKNp2x6DgIvhqwjQL8ifFKzRrvX2MeTMdYsU3wzobwKwW20hPcR6/hYsoFRO0NNIFRFIeLO8/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708412383; c=relaxed/simple;
	bh=rujM/o5AjDNJ9lcZkArg6d87J1BhTiGW6Fn0Na9SRI4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Lny3TU00aAOrehVLUaPTe5UQrR+kTzXFN8kT+wMl9P9/YUbrJ8CfIRmVNJJ5qHzTVWyn62aG2hMC0h1ZzzHNGeR15+w1ckD22Ud7o0u5Q5nbGC+81d/OhBj7o2wEvXLeBs+Kg/yCs9ji+lOsO2oaQzVmNgOHEoLZXXu60WvFuqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ZSJq5wDz; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-60837b7a8ddso18539957b3.3
        for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 22:59:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708412380; x=1709017180; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TMFT0tsiHgdz9iZN1EKIldjl3b45OLLNs9mRQlVJ+mo=;
        b=ZSJq5wDztcC0598GPl5gsiiGz6EXEk9rex0SPJx2eekXB7lb++ZTP6xSOjFks2QAwo
         nJ6i0V4taQiI4p1JSyl0gj1rh7x7edg1C7q20/2vUa3fscaSi73RNzq/Bkr4AOrX3GYi
         MyUnxCzfAXdj4CD0khJNIWuP4w/o4IRoOi8Iql5tTzLDinlZXuKp6rVg2tui0P2JPyXa
         RzWemsPBKOKFDnlSV+LhgIo8AU2Rhu+Hco7ECyG6hHDnP5UCZM08mu6nniaXmEIPrb/Q
         YVkpN9lCafrA1um5KFohruOAD7NS/s+NwvYl6XGi18gXPYzliZarV2qDT6wsWfzUa5oH
         prjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708412380; x=1709017180;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TMFT0tsiHgdz9iZN1EKIldjl3b45OLLNs9mRQlVJ+mo=;
        b=bvEDvJ4DFAVY3BYgGNN/V8a3hMggtCzOASr9oCOAoibMEuROIMUpoFmxnyKnGLnCaW
         ilavjOHaBOWEHrdzOlbkFGyvr4awWQt/iwpt81RWTFAdvw8ovJg7t9NAC0WrkFYSWg2j
         gDK6r7iI+UknRcVPKxq6MKWvwfR4NLCBKQDpiJ3qrGqErGUze12KE0U/+wPbzAvFXDU9
         jMCO0HuH+M0kU0zAecPkcvHkvtjZ4Ey3ZtfZkyfYaqxDFu0ltQagc1sfyqQbJPsIHGlR
         UwiOT8QGKGfj4ideptczkkX94+2jhb+dshwGc5zC7D46ULs3vAVCRZoZrMboPmizQhfJ
         92Vw==
X-Forwarded-Encrypted: i=1; AJvYcCVl1aC8c12JCUjhYkKc1G1wZo4zKv6Xw/78ebZEPf5WcuWtcl1B4t0r9/tQZpg/vcE65xsJhT6t6V5q+Zp72R6PrQmttP7OvazlMDD4
X-Gm-Message-State: AOJu0YyJo/bt+libAh36GBIO2ZtDM4b00/qlUuDaEJVy7zX6nMmsdkhj
	g5YoJ/opnxPoyscEchWOCqRybswg6rXnMC2CET/wUI1VQilL3y1dKd2vSiIKGq4=
X-Google-Smtp-Source: AGHT+IHoF+nqnIqy8Vp0maOl4q34YF7mKopu/6NelFWU12CMt2LtJkC2P4rmj2X+cDpi8B2aCRvgKw==
X-Received: by 2002:a81:ad47:0:b0:607:f679:e370 with SMTP id l7-20020a81ad47000000b00607f679e370mr10840185ywk.33.1708412380376;
        Mon, 19 Feb 2024 22:59:40 -0800 (PST)
Received: from [192.168.1.20] ([178.197.222.116])
        by smtp.gmail.com with ESMTPSA id u128-20020a818486000000b0060853d574aasm423826ywf.84.2024.02.19.22.59.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Feb 2024 22:59:40 -0800 (PST)
Message-ID: <ac4f1b66-2407-44e9-ab97-f6583a13a428@linaro.org>
Date: Tue, 20 Feb 2024 07:59:35 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] interconnect: constify of_phandle_args in xlate
Content-Language: en-US
To: Thierry Reding <thierry.reding@gmail.com>,
 Konrad Dybcio <konrad.dybcio@linaro.org>,
 Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski
 <brgl@bgdev.pl>, Georgi Djakov <djakov@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Sylwester Nawrocki <s.nawrocki@samsung.com>,
 =?UTF-8?B?QXJ0dXIgxZp3aWdvxYQ=?= <a.swigon@samsung.com>,
 Alim Akhtar <alim.akhtar@samsung.com>, Jonathan Hunter
 <jonathanh@nvidia.com>, linux-gpio@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org
References: <20240216135236.129878-1-krzysztof.kozlowski@linaro.org>
 <488cc7dc-f45a-4c9e-b572-e4a6b3202e3e@linaro.org>
 <41e371f1-96f4-45c0-9f65-81ed6924b325@linaro.org>
 <CZ973FMYMJAO.PQ0Z5YLXZPPM@gmail.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <CZ973FMYMJAO.PQ0Z5YLXZPPM@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 19/02/2024 17:27, Thierry Reding wrote:
> On Fri Feb 16, 2024 at 2:59 PM CET, Krzysztof Kozlowski wrote:
>> On 16/02/2024 14:55, Konrad Dybcio wrote:
>>> On 16.02.2024 14:52, Krzysztof Kozlowski wrote:
>>>> The xlate callbacks are supposed to translate of_phandle_args to proper
>>>> provider without modifying the of_phandle_args.  Make the argument
>>>> pointer to const for code safety and readability.
>>>>
>>>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>>> ---
>>>>  drivers/gpio/gpiolib-of.c              |  2 +-
>>>>  drivers/interconnect/core.c            |  4 ++--
>>>>  drivers/interconnect/qcom/icc-common.c |  3 ++-
>>>>  drivers/interconnect/qcom/icc-common.h |  3 ++-
>>>>  drivers/interconnect/samsung/exynos.c  |  2 +-
>>>>  drivers/memory/tegra/mc.c              |  2 +-
>>>>  drivers/memory/tegra/tegra124-emc.c    |  2 +-
>>>>  drivers/memory/tegra/tegra124.c        |  2 +-
>>>>  drivers/memory/tegra/tegra186-emc.c    |  2 +-
>>>>  drivers/memory/tegra/tegra20-emc.c     |  2 +-
>>>>  drivers/memory/tegra/tegra20.c         |  2 +-
>>>>  drivers/memory/tegra/tegra30-emc.c     |  2 +-
>>>>  drivers/memory/tegra/tegra30.c         |  2 +-
>>>>  include/linux/interconnect-provider.h  | 11 ++++++-----
>>>>  include/soc/tegra/mc.h                 |  7 ++++---
>>>
>>> Ended up being a bit wider than just icc..
>>>
>>> Looks sane apart from that
>>
>> Tegra memory controllers are also interconnect providers, so two subsystems.
>>
>> This patch should go via interconnect tree.
> 
> I think Konrad might have been referring to the GPIO hunk, which seems
> out of place. For the Tegra parts, though:

Oh, that's right. I mixed up patches.

Best regards,
Krzysztof



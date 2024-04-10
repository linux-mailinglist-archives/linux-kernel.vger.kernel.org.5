Return-Path: <linux-kernel+bounces-139114-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D70C89FEC4
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 19:39:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3318E1F22019
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 17:39:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3738017F36E;
	Wed, 10 Apr 2024 17:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FpCloBne"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB3F11779B4
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 17:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712770756; cv=none; b=T5z7I8e7AEaMN69H7HBuNyZfj4VmU7FkpgKvp1Kp3er22aSW25+zokDLLPm2YO0L3JcmzhLFkikkitoqQbE1ergfuXEdBgNGMP/fwL2SPubNWhHKhdn5zBpuNQSXToTWJE5gbCVLtcJuOHW+zum+SI3eJojSbb/IT2wqZIp6GKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712770756; c=relaxed/simple;
	bh=Ae78iTX5Gi1u5H/iJKMp5ReYCFnEnOmbK4zUk7vZlRo=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Iuw2x1glrF4G9X+8/U+RA+ox8xRGx0+S64wffbTvJsnrJM0vSseFXwWtYLiaYkK2u9Q7QBMGDizTwH9FlgnHToHv22m06+OHY/TRP/WWb3SKaBDwfCk/i2orwbc4Ra1l6wd6m2KjwVCELWTn08PCjRFru9ZYRy3qTb7cXCfNFk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FpCloBne; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-516c403cc46so13436674e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 10:39:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712770753; x=1713375553; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FOAAOfk0ZAGGudRLQ06zTrFZTJcS2I7LIhPpzIE377o=;
        b=FpCloBneh9c6e3bbs05wVjJRbXHDZdQUl574vqV6P5L893hGny1OVqmmeIeiDvtRM0
         +G6iOds0Qqo+V+NmDXuA0lxSuKWfDIn4w2sF9iP5G+sBP+u5Tsn4Sy+7cIo+yZPeDeu+
         jgSOC7s5RySrJsbnuU3Zl5Xd21TXI8Za+GpKx18Khlb2MfGNj9NMrQwYXSzBpYwMay7v
         vGDc8eSR7QrZjkQEx09DY8t+2ljHvLSg0tznXhJj89Exs9qQ/5AviUxAqS+MdpZoh1ms
         USCpmDW0RxywL/hnkir+5uCSKt3fgu3nb89NMy5OZ1WiKAPDF6jRbMWJCYEdKw5sMfpl
         VxkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712770753; x=1713375553;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FOAAOfk0ZAGGudRLQ06zTrFZTJcS2I7LIhPpzIE377o=;
        b=VXVmq7ziH8ETKJUN7cTOJfOikFyFqtvdm7nI4iWQZgRCajCAoVuEAEZnWyiwl3vGzr
         MNKYOYQzM9GEVUcW8G7xSovOdDqSn+ZIGXrPHKy4Isr2bCvZfZXLTmfjpL8TAgU1ND5R
         FdCyZpROL6eJ8AzATgWS0/D36MoUNV9ojxHKdfYCi1mqRhj7+dRqoB5kghDYFfdsC9m3
         mTlQ2hYEzCuyptwNKDXkMLJRu6M1CSNhIJb7AneHMRODYs6yfxAA94cbPZnVKy8wwKSQ
         mGbHsnXfA9GVTA2soaz+80Q+0ktjIpgcRvYS2zyqJWHehmjqOyvaGAB8L6xTGfats2vG
         jqTg==
X-Forwarded-Encrypted: i=1; AJvYcCW/ja5v1giyrYTbFeRaV+SaxjjNxPgQ2yQs5H/j2Id6rvTF4M/c/+hF7bxzJz23s+27r+eJce5vZ6b7PWvnZtwbk73EL65W8DzAgs42
X-Gm-Message-State: AOJu0YzXb5zhdFhbSQwO/1DJTlUhfBATTffeL2dAXpgxTIcNLDihrvig
	kc4GV/KKLZ+2EJBTrE1br/xnrONGlzH3VUbY+4Hxy/QUcYodhiTkQ1aYwg+9GTMsO8M9dN9ssoc
	uyyo=
X-Google-Smtp-Source: AGHT+IG7dDYe1gFQPvGL6M6ksyXaTfBAbfvpOrw2k5MazcBmNsiHemV0NeET8m68BsHQlkw2YDSGmg==
X-Received: by 2002:a05:6512:203:b0:516:d26e:ea6f with SMTP id a3-20020a056512020300b00516d26eea6fmr2650668lfo.35.1712770752736;
        Wed, 10 Apr 2024 10:39:12 -0700 (PDT)
Received: from [172.30.205.26] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id t21-20020a192d55000000b00515dcb7ed9bsm1925034lft.144.2024.04.10.10.39.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Apr 2024 10:39:12 -0700 (PDT)
Message-ID: <16faae0a-ea86-417d-8588-375ff41160d6@linaro.org>
Date: Wed, 10 Apr 2024 19:39:08 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] regulator: qcom-refgen: fix module autoloading
To: Krzysztof Kozlowski <krzk@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Robert Marko <robert.marko@sartura.hr>,
 Luka Perkov <luka.perkov@sartura.hr>, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240410172615.255424-1-krzk@kernel.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20240410172615.255424-1-krzk@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 4/10/24 19:26, Krzysztof Kozlowski wrote:
> Add MODULE_DEVICE_TABLE(), so the module could be properly autoloaded
> based on the alias from of_device_id table.
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad


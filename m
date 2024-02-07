Return-Path: <linux-kernel+bounces-56090-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A649584C5D3
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 08:53:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 425ECB25C65
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 07:52:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60B311F947;
	Wed,  7 Feb 2024 07:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lKElovff"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A0E31F932
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 07:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707292370; cv=none; b=pIO98NqTuZ/O9Q13vgrEsnz5LQJ/pDwX1ypO4mPU2PEL4y3IzDuONrGiGEiIkKySAmSTZITsw4AFkKpeA5DanBQ4M3L5XuxHPUAMZNcMUBPsVLYYfEJqna/PCjwjsP3t9Auho+AWhC0+R2mr1l/o4sfGgB+bji19rC9MVtHvnLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707292370; c=relaxed/simple;
	bh=JlVEwPHVfMeMwvk0a6YivuZGsYLF2ha+DYx2BYky9oc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mu+5oC0oJXGQMyH0gbF98ZFnjAaWSwfO1Oh2sQmFuiGQSZLLEDmvcPvGzH8BLZaPOCo7SpURo8YYngxMedkyJy5hUFEHZ0RiQ6mvWgtD9ZIVSV7Zh7mvTvy/BqaId6/0lv25mkI1C2CQqo8oD1gTyBvEL8ag2tjOOcWNse62l40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lKElovff; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-40fb3b5893eso2374635e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 06 Feb 2024 23:52:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707292367; x=1707897167; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JlVEwPHVfMeMwvk0a6YivuZGsYLF2ha+DYx2BYky9oc=;
        b=lKElovff0vgtcK9ygg4mlcEhNnu0w6mouQYeS3+n22k0+jn1SEa1snq+MCpF7553mK
         kpum02oki5hudIE/Fgsc2yFOpxO8usijizZekGhcKWR0qP4zvhc0eTssx2XGs178PuRB
         l10GAvrxCGRCKbrIrbwg07ZIB39MmggIZq0cXiT4JJsQB6MCawvQaYPhNRPq2H+iQtZy
         VBge9x05rwE2YDph8lrIGhLjnMjfpdIWGLJ3HNn24dJmtt4IhWewSwpnl7q5SXrt+YJU
         Pkw67+sBheKN5uMlAlxK3fEgm8peth1HYg1TsK3g5PzdyeqxK4xQbze+1zkkcj/ydSUe
         4HRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707292367; x=1707897167;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JlVEwPHVfMeMwvk0a6YivuZGsYLF2ha+DYx2BYky9oc=;
        b=LjqffA9NsaCoEuW//MRpOhHs77djNfdVyheTc++Go8qgN7EuK2miPnvBUMGq+a/djw
         Qf52LnG1s5nwcbebhb/E2IMVxPlkwG5Ux7THhEyIVU4Q0sZ1+oXDs9gPXuGqwbtRPwM4
         lwzLgD3NXODmKC79nQlDScrsU/oAulCO4OxuIvpiaT2J8Ytc65Cgu0YkvwIuW28IURbw
         BM6riV5XVV6yZtfTYzHSC22GUsLqDJ8divKk7KOrIxbzgjU6mOiF8tkAR1uHD0kazt/g
         E2oJ8N+GlWZ4BF2CtLn+N18lGLqyS2KxNhFHKFgIS35RAIrcK7BcC5NcDin7uSxDNLbo
         NVpA==
X-Gm-Message-State: AOJu0Yx+ZnQt/AV17UWhr5q8mTHebhnKv17r5Q6ngRute3EmEKct5mQ+
	QxA5wRU2DueeEJQC+unExdeG+DvvBSTSE+8eauAK0UI4Gggv0EmiTkyRQZwmXYs=
X-Google-Smtp-Source: AGHT+IHeSiwuGNsTeFQbBrGKw2OEON10xV5chvkbSmAO8n1HwgW5d5GXc8gOG4sH3GEYneCzi4DeVA==
X-Received: by 2002:a05:600c:12c2:b0:40e:55ca:5a48 with SMTP id v2-20020a05600c12c200b0040e55ca5a48mr3987735wmd.16.1707292367508;
        Tue, 06 Feb 2024 23:52:47 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWA8UreBGYKheyKusCdvRcTpT+JSdj5LcovOrXKohjQ1Vyql9hm9ip/dwl46vCFoUQCIszW/M3Yudtvi+PX+K684YheHnas9oqUn+7bime0DJeb0UvkK6BqAq86sgJwyKfs7yVlE9g2/+j/6fJlHWKlJZ4EEfwo/R03B3F+RXaSpSHfVQLUsGfRJyARTYXvG3reBFxVgAgkt4G9FcTxq48ZA3O6jaR5jjERUM+sDaGbcLrJWFJwhjd2S08Cwf2Y9rhdJixAcsam6dj2Trg5sn3dl9GOGZ+GU/gguj4gC/kL5KHG1oZmoMy7dCnBKesdovYH1M7UQGYl6Qgq0pfUy0r9XsYRrEWiQAYT2ojVUKdGM7fmRB8fJCH7mw8WWHySrvNTND7z45jQ8zlCmbfrJNDaHdwhxKfVNnlK1YpxzmHkCxU1oBVOPs13jhscDbjXW5fbXihBFnUkDDppgxFqEsZHB8Y=
Received: from [192.168.0.107] ([79.115.63.202])
        by smtp.gmail.com with ESMTPSA id l37-20020a05600c1d2500b0040ee8765901sm1164739wms.43.2024.02.06.23.52.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Feb 2024 23:52:47 -0800 (PST)
Message-ID: <555a3600-8669-4733-b89c-ec0b5c6a2c6e@linaro.org>
Date: Wed, 7 Feb 2024 07:52:45 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 00/16] spi: s3c64xx: straightforward cleanup
Content-Language: en-US
To: broonie@kernel.org, andi.shyti@kernel.org, semen.protsenko@linaro.org
Cc: krzysztof.kozlowski@linaro.org, alim.akhtar@samsung.com,
 linux-spi@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 andre.draszik@linaro.org, peter.griffin@linaro.org, kernel-team@android.com,
 willmcvicker@google.com
References: <20240205124513.447875-1-tudor.ambarus@linaro.org>
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <20240205124513.447875-1-tudor.ambarus@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi, Mark,

Please don't queue this yet, I'll come up with the gs101 patches first,
as Sam suggests. I'll then add this patch set on top of gs101.

ta


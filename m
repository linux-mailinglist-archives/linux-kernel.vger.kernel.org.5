Return-Path: <linux-kernel+bounces-86696-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2078686C923
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 13:24:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B68581F233F7
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 12:24:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89AE77D074;
	Thu, 29 Feb 2024 12:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="InoN4scL"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 594101FA3;
	Thu, 29 Feb 2024 12:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709209434; cv=none; b=MJzfkju6A5fRIAUDxnW0djlL09dgCdLH8l4zEqcmtbrU4xKk91+9dGLKgxywC+W90UHA6Z6D64m2j63k3BCfURy1bMqXE05ucsuHVIr9qkUHwoAA1DvjDY9+g6ag4DBnMr8Rn02DkrzLjBvoduQUMool9q4wh/y3glLNQfTnl1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709209434; c=relaxed/simple;
	bh=qumV7K2q3Ht3GNV6Af+DuzlMlVI0u3chU9RorWcne94=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A8eu4KCUjJKy32QWrzE3JFMWjgvVRotJwUwIOud74VpWtbQWbnPnHFM1XQDjI7/lxOUoniR51gq9sm8tVhlMkWPt0guTqkqKhCjFWlog/tX9bZ6KpY3KY6Zxj4asAh4GpZ60LxlTq6T7x1F0GQIEOR7dpovgiSJLUkOxxS9e68Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=InoN4scL; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a3ed9cae56fso376622866b.1;
        Thu, 29 Feb 2024 04:23:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709209432; x=1709814232; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KYHnnt19ji97iE9lSun0FiAK9bzl+tEAgjH5CGJH0iM=;
        b=InoN4scLm+T0SWSFK9zj+Rg85aR0Zi3dUX0lsKaUBqYPDgHv1VNRZ0zQPo7k3vfHyW
         /bLHGuZQ+AOEXgX0rrS1uJyTfBlt6u5BVsauSiUZKfk7g6wI8fCA6IAh2H4E8AE9EyHL
         ieKAiaJf7fwzSKTXUh6qhzIVVGpjUEgGitObgWWf1nxQFrsJTcmu3Jei3D2ICcNh5MRD
         wuvxm0Lbs/R/+u3r4ON2cJVkAgZK03+f1P7/2YM+/24fUEBBQo2Bh77rQg40saTgravr
         hfHQ0hNXWJNJtdVYndHd0UW2EzfSkIHwFMr1BK/n7WRc1/7V0NrEZNaqidpkgKmlZHel
         j9/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709209432; x=1709814232;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KYHnnt19ji97iE9lSun0FiAK9bzl+tEAgjH5CGJH0iM=;
        b=GozWeWySM3bjl5n4/ZQSOGZl0A9cnu5Rs2nsrTOs+bqjzgqexzUVUzHgFj8jXpvZ3p
         tM/gYpVYDtnmci72SXKGIFEdLZIKTlwbQZlzXFdJ9tXHlMZLSp7vm4ITnUPkUe8dMFwV
         lB60WtNj2B0dB44t6AY9NbdiARQzn/TFnQr3w0IjkMtU3/we6GK2LSxFfoz25aue4h+N
         BgDudSCMVgmRxKBhM0Ru6SFN1rX0KNdteF68A0S+kKYVkARRhLRR0YYfaM7oiRsu/ay9
         QbAavmWtTklp5TNfD6XFWdXE7/2vC5nj6w0PAMYltOWyPLzwQMPSm6CXWhqIz0+r9ZeW
         bUEw==
X-Forwarded-Encrypted: i=1; AJvYcCVFBv4sEmTEpb+adFMxQE88tPKPOZBoDhX535uwn3SOdcZCnJtC+LEI6pdIvHpRXk3obftv1LupAu6Wxarz0ZWHsl7einPljYhmA4DCbJEx3LrcSegj2bM6U6vPOJaLKa+R6KUMTUnoNg==
X-Gm-Message-State: AOJu0YzZjf77h06cxEckFJQvCWWoiExeXXS+uX6tV/jBuSZSavbO4eN7
	Zg/AQhMEaYh9OtEYDwpt06yBLXikfHhgA0qjgRvWigOQNcpifxvS
X-Google-Smtp-Source: AGHT+IF65bKyjewyB3z5lGrUVQbyU63FXXL/wCJrYoyP/ozxh/AL+gDFopd3Zusf3tWUjy1Hrl6OtA==
X-Received: by 2002:a17:906:af66:b0:a43:f352:8bcb with SMTP id os6-20020a170906af6600b00a43f3528bcbmr1051394ejb.38.1709209431455;
        Thu, 29 Feb 2024 04:23:51 -0800 (PST)
Received: from [192.168.3.110] (IN-84-15-190-167.bitemobile.lt. [84.15.190.167])
        by smtp.gmail.com with ESMTPSA id s10-20020a1709060c0a00b00a3f8f0ab293sm639177ejf.147.2024.02.29.04.23.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Feb 2024 04:23:51 -0800 (PST)
Message-ID: <15e6e45f-7398-4703-8154-35e769bac94a@gmail.com>
Date: Thu, 29 Feb 2024 14:23:47 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] gpio: 74x164: Enable output pins after registers are
 reset
Content-Language: en-US
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: linus.walleij@linaro.org, u.kleine-koenig@pengutronix.de,
 andriy.shevchenko@linux.intel.com, linux-gpio@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240229084555.43701-2-arturas.moskvinas@gmail.com>
 <CAMRc=MfTo7MnfMhRQsjeFsLv3yjEtP0C3ytqACN+nuGw0Sr-Bg@mail.gmail.com>
From: Arturas Moskvinas <arturas.moskvinas@gmail.com>
In-Reply-To: <CAMRc=MfTo7MnfMhRQsjeFsLv3yjEtP0C3ytqACN+nuGw0Sr-Bg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2/29/24 10:54, Bartosz Golaszewski wrote:
> On Thu, Feb 29, 2024 at 9:47 AM Arturas Moskvinas
> <arturas.moskvinas@gmail.com> wrote:
>> Chip outputs are enabled[1] before actual reset is performed[2] which might
>> cause pin output value to flip flop if previous pin value was set to 1 in chip.
>> Change fixes that behavior by making sure chip is fully reset before all outputs
>> are enabled.
>>
> Use imperative mood in commit messages - make it: "Fix that behavior
> by making sure ...".
Chip outputs are enabled[1] before actual reset is performed[2] which might
cause pin output value to flip flop if previous pin value was set to 1 
in chip.
Fix that behavior by making sure chip is fully reset before all outputs are
enabled.

Bartosz, does this look better?

Arturas Moskvinas


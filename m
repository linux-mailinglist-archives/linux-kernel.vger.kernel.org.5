Return-Path: <linux-kernel+bounces-129476-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0AA7896B58
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 12:02:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33B6528A81E
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 10:02:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9324B137C5F;
	Wed,  3 Apr 2024 10:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rfs9ysp1"
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 683CF137765;
	Wed,  3 Apr 2024 10:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712138517; cv=none; b=pqxrbDhHuc6UMhl0ci9psUhUM/4a7P4q8V3pQpQV+LQw5QYS97oXFKtUbMKgZogoPEF2xoEZNUUSWXiR6e4w/Xb5gQOXC2SINrAsW69Utva2//UeZ7t+qkEP/Jiap5h+tAFZAetAnD/XRD0tYtkB/FP3f8zLEuI+eb0hriJRfeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712138517; c=relaxed/simple;
	bh=4Z3wuoY/BT+v4izC2D9VXBC9jWa0y2I2fe5q/Qt1J9Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uDbGm6a2i6L0MUBwgYR0FLIdx3MqOfean2eaqDaTagobq1eqZXjrd8hpTHEqHIbXP6jpMdpAXXH0HuZGJkVoXqSkqyPw8tnLG+inSkGWly0YysCSfIJ2b20/YviNT/QjXP8AHqlHl4gU+cIUW7cmOHF72Jt8iIWlYf4Xoormz3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rfs9ysp1; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-432bd633207so24797631cf.3;
        Wed, 03 Apr 2024 03:01:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712138515; x=1712743315; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9mWG+yTBLNvbZUE1m9RW0WNaEdPkmsKTIXCTRWVXm6I=;
        b=Rfs9ysp1x3N19J+HZplWZteHBXVCkVTuPqLkYN9I+V/UiYbFNbNEtvDiW6ls8wPupd
         8iNdzLraX6MlS+X+cCLOc9OBxX212FVMPRl4LrOJoPqlX6hsOnpLlJ3fY0OlIlFPXy/0
         yw2o+ZzIvZFLikLB370sid3jp7ufJk/Q5ZNtwZRoC51CVZsOxUTycRFWHautvYBSji8T
         C9j+0YCeARGDiZkaJI2+PJbRVCTAp4P6M9ibrKfufLNg5AIiS1Ta5SnId+QncwxsU1sh
         8yLP1iqBwAowJhMVSSHR7Ryb90cYxeuADpfVVgTxnmkqHP7/iFoR69LSvOK83G4BTznM
         8njg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712138515; x=1712743315;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9mWG+yTBLNvbZUE1m9RW0WNaEdPkmsKTIXCTRWVXm6I=;
        b=r9gRnvbDfhOSPHkQpkc2nDemCkX0omDATAy6t3lCf5ryFZxVo1+V51jaQf2NVolpwn
         DMC1dYy4osx2m/nybRQJZPROZqUV+P/Ov/pAKj1Y8HfOhP5BFE3k0eXhu0GrWEB94rO3
         YXDFq4eXxYjPMm+Y6NderO+UmPT4NIPPX67+bBpieUUNxxgp75uxorJgslqs0mb7VJQL
         DhIl6Zi+3WpkeUZ69XaX7cmN3U2TwxoKfIJUlx21G4mFJ4LeY8YF5wVWLDjiOXNQ6h1z
         e4avOhGRWUGxmUwkmEC5OEys5rwxF/bdOovSZ3lP5ZxrOJfhho7Ehbf5xzapqofAtvmh
         tEqQ==
X-Forwarded-Encrypted: i=1; AJvYcCV3N7//hZfZlT1gqt4eFmirtY4nRrz3Oo7J0bSGzpYqr0T8asGmPZQ/SLu9B3TnwtcnwdRelVR5/e58Et3HImJsjgcLuGFGLtVWEv0ggsjYeKrnFqHrdU3NinWkPdcfRB5KzOItFLYOIvB3w34MJ9R4sJnlsJ7CFMPgUxCy1v2zTHdNlA==
X-Gm-Message-State: AOJu0Yw+LlUYwMrgR9GYH59rgwnGEuVbGEK0x8a5bq+foOqDzB2Hq1r6
	EeSqU8N8rZ8slbis2mkSELYOOGjzkzBIHeyRyh8UdkMvkSgJegRh
X-Google-Smtp-Source: AGHT+IGgeYdYXBwy1G6Ix9vy0866CqundiGmfyGZS9O2F4g2G6dEspu2Ft/uMK7DIrJAdx8/d5hLEA==
X-Received: by 2002:ac8:5901:0:b0:432:b6a2:897a with SMTP id 1-20020ac85901000000b00432b6a2897amr2310274qty.9.1712138515067;
        Wed, 03 Apr 2024 03:01:55 -0700 (PDT)
Received: from [10.76.84.174] ([5.2.194.157])
        by smtp.gmail.com with ESMTPSA id hd17-20020a05622a299100b0042f04e421d2sm6418527qtb.24.2024.04.03.03.01.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Apr 2024 03:01:54 -0700 (PDT)
Message-ID: <1d777161-7d86-4d45-91bc-c7653504b890@gmail.com>
Date: Wed, 3 Apr 2024 13:01:51 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/6] iio: adc: ad7173: refactor channel configuration
 parsing
To: David Lechner <dlechner@baylibre.com>, dumitru.ceclan@analog.com
Cc: Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240401-ad4111-v1-0-34618a9cc502@analog.com>
 <20240401-ad4111-v1-3-34618a9cc502@analog.com>
 <CAMknhBHo3xkkZymVfvauL7nBPn9+c1ZUoPwyk4mJO4syRJEhiQ@mail.gmail.com>
Content-Language: en-US
From: "Ceclan, Dumitru" <mitrutzceclan@gmail.com>
In-Reply-To: <CAMknhBHo3xkkZymVfvauL7nBPn9+c1ZUoPwyk4mJO4syRJEhiQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 01/04/2024 22:39, David Lechner wrote:
> On Mon, Apr 1, 2024 at 10:10 AM Dumitru Ceclan via B4 Relay
> <devnull+dumitru.ceclan.analog.com@kernel.org> wrote:
>>
>> From: Dumitru Ceclan <dumitru.ceclan@analog.com>
>>
>> Move configurations regarding number of channels from
>> *_fw_parse_device_config to *_fw_parse_channel_config.
>>
>> Signed-off-by: Dumitru Ceclan <dumitru.ceclan@analog.com>
>> ---
> 
> Commit messages need to explain _why_ the change is being made [1]. It
> is not obvious to me why this needs to be moved.
> 
> [1]: https://www.kernel.org/doc/html/latest/process/submitting-patches.html#the-canonical-patch-format


Jonathan Cameron:

"
> +	if (num_channels == 0)
> +		return dev_err_probe(dev, -ENODATA, "No channels specified\n");
> +	indio_dev->num_channels = num_channels;
> +	st->num_channels = num_channels;

I'm not seeing benefit of duplication here really and logically it feels like
a lot of this last chunk would sit better in ad7173_fw_parse_channel_config()

Perhaps that's a job for a future tidying up patch.
"
https://lore.kernel.org/all/20240303162148.3ad91aa2@jic23-huawei/



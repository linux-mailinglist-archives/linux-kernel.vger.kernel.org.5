Return-Path: <linux-kernel+bounces-41042-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B2DD183EAA6
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 04:42:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C0231C22A10
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 03:42:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6500D1173A;
	Sat, 27 Jan 2024 03:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hs+7tYIH"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11D42D51B
	for <linux-kernel@vger.kernel.org>; Sat, 27 Jan 2024 03:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706326924; cv=none; b=sqjkToNa6LrNXXI27H+QUfvEmq97pMezYnxL2WRgVYWBFCkeXwDhapt3eJZ8uxr3g9nD6VIK6o7DXh/DBkGs3nsXtjFZcNGZ+n76CFj5e9N35laBmMf9zV7qt74Ns15Yg1KiCF5b3zv9yE/Ag3gIrN3kldzssOcT9gkslVO3lQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706326924; c=relaxed/simple;
	bh=lb4hr4lMqP3scqChZNMDEfqWIZNF2leBBfvxB83oB+o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TbdGCiW/JEhbsDUoEuajHktfpv+0VENREBsKexzYL4mHeXsy1lYwKMH3+aHd3JYaFmrkEI9O/tRBxSTl+kYzpAmU77eqQ8tMI5toJajxRav7Ysct5278vxKOvdB9Az+erQN0odhPlxR9dvTwYRyPO5kX/LjTKB3INHfIGuMPc+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hs+7tYIH; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a318ccfe412so69859466b.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 19:42:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706326921; x=1706931721; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pOaGnis+Iczt522Hal+qxBb9QflnEHJoe8ZkGJ5fs+8=;
        b=hs+7tYIHl2NUGuPTxTqkHCAC4bWgoUs0kMPIodUa0juUFJAI3YnBS7WdA0yxbnIH0n
         ql/3RcGdxdvvg+Nw5V6S2R3LjrJeGncmFl9fqA7TLwh70MN+Bbj2Clj8V6Dh9qMi+GqM
         pWcD/FFVYbaUryboDWP+KizB8Stb0URtduTJCGGOtxLZ6G2R157z/gpswZkfava/WhGo
         GjDN9ICmKz6WgVYQfIy1/kzUpzWF8qOY1GuSavPlC9kIcjPi29/aeiSsmob4Z4eB8D1N
         jXigkwPiHyXgUgnlbx0ndlK6ZYA5qCpTCz682tPZKBEoZfKj7rQ7S5yy18b5pN2+Fof+
         QGrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706326921; x=1706931721;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pOaGnis+Iczt522Hal+qxBb9QflnEHJoe8ZkGJ5fs+8=;
        b=QywNkFnlUa5xG/di6bGWZpsBlzm3WzFqn7LjE0TOLOpjb8kRi2E+imgSPiHPU6Va+n
         +TNtm0fK9Bikj3wj28dFlJLwrWkBpevnL0d/K0hayfQ7PSAbuePfF25vI8z+v9ddR1Gi
         pFCgdM7kulF1p80f4g9Q5eSbs855ICPB0Vv4yyxUFfhS4RfVFk/3bCD3h4AuwXG4aw7u
         8fmZh+4sKrog7+JaZAy7tJt99vddYHASD/yM9yugzbAiz8NwO2anCsxACz1wWVCjkhmm
         cxIg+BMYBKQbsnlcmCAbfBxHz1uiwm7j7jULLih8BMeABGFB1qQVPm+CEAlpjDC2W6fk
         jvkA==
X-Gm-Message-State: AOJu0YyCPTcjmPjfsAKJslpTIDGDyVm0n2ycAl2RUqTFY7M0nyt+iuJw
	2qd/1VQqYlhklrHhOHirXn3vLYS7QOyyRi/YfS95vxHvZgb3p/5fn5cXbm6rlLE=
X-Google-Smtp-Source: AGHT+IEDPqs41iSlO3HsrWI3i1zfR5ULd1vOfwLy0lNUfcY9YPvicY9qMn4CJXQs/kBe94SL0YF9dg==
X-Received: by 2002:a17:906:acb:b0:a31:1907:2fe8 with SMTP id z11-20020a1709060acb00b00a3119072fe8mr439718ejf.48.1706326921280;
        Fri, 26 Jan 2024 19:42:01 -0800 (PST)
Received: from [192.168.2.107] ([79.115.63.202])
        by smtp.gmail.com with ESMTPSA id vg10-20020a170907d30a00b00a3522154450sm572518ejc.12.2024.01.26.19.41.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Jan 2024 19:42:00 -0800 (PST)
Message-ID: <81f3d9cd-4efd-44de-8230-3c40af10972a@linaro.org>
Date: Sat, 27 Jan 2024 03:41:58 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 06/17] spi: s3c64xx: remove unneeded (void *) casts in
 of_match_table
Content-Language: en-US
To: Sam Protsenko <semen.protsenko@linaro.org>
Cc: broonie@kernel.org, andi.shyti@kernel.org,
 krzysztof.kozlowski@linaro.org, alim.akhtar@samsung.com,
 jassi.brar@samsung.com, linux-spi@vger.kernel.org,
 linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, andre.draszik@linaro.org,
 peter.griffin@linaro.org, kernel-team@android.com, willmcvicker@google.com
References: <20240126171546.1233172-1-tudor.ambarus@linaro.org>
 <20240126171546.1233172-7-tudor.ambarus@linaro.org>
 <CAPLW+4n3U99cm0Bv5XhceXyEtp4pTh1TWjtB1ci+f2fO+i1_ag@mail.gmail.com>
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <CAPLW+4n3U99cm0Bv5XhceXyEtp4pTh1TWjtB1ci+f2fO+i1_ag@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi, Sam,

Thanks for the review feedback.

On 1/26/24 20:17, Sam Protsenko wrote:
>>  static const struct of_device_id s3c64xx_spi_dt_match[] = {
>> -       { .compatible = "samsung,s3c2443-spi",
>> -                       .data = (void *)&s3c2443_spi_port_config,
>> +       {
>> +               .compatible = "samsung,s3c2443-spi",
>> +               .data = &s3c2443_spi_port_config,
>>         },
>> -       { .compatible = "samsung,s3c6410-spi",
>> -                       .data = (void *)&s3c6410_spi_port_config,
>> +       {
> The braces style is not fixed. Yet that's a style patch, which on one
> hand fixes the issue (unnecessary void * cast), but OTOH brings
> another issue (non-canonical braces placement). Please see my comments
> for your previous submission.

I've read your email and replied there that the braces were one on top
of the other even before my patch and since I don't have a preference on
whether to choose a style or the other, I kept the style as it were.

But I learnt my lesson. Mark can ignore this path when applying and I'll
submit a new version of the patch where I'll refrain myself making
alignments or changing the style.

Cheers,
ta


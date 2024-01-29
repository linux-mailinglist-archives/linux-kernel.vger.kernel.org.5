Return-Path: <linux-kernel+bounces-42794-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E0748406DD
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 14:28:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C7EC287F4D
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 13:28:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 498CE6312A;
	Mon, 29 Jan 2024 13:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GA9qMj1z"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E44B463105
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 13:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706534875; cv=none; b=gIufcBqyzyf/4xkB9Fx4R6eeX3+ePDKdSfB5d9Drk5GeWKWEK1/cmarHwLtqjAXv9wx4RmBWfQvO4JRP4AgiqQcoqwbh32MwZDsEGnrkUEwBOkYzERxFYXy8A7PAYm+Ynd0hq9mIx2y/Sm5z9M2cvsI1TGmWaSwFYGWUbyIWKZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706534875; c=relaxed/simple;
	bh=X3kl8N2vafBkloeoPe9c+Hpl2cjCFdlalloXzGtwppE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X0awJ2J4f6KyH5KK+Yi3SeKz0zbUDXNFYnsSFgjDgPCUQeSFJw7YfR1w63EU9T7BvYvzP520NMEeMjo5L/2XaUnF4VqEFf3Hib8XOQuQ6QD9zQXS3NfMYNI2mAoxHarxenjr4Cf1qHyZCjNAtb9CdCPlKhRpdUpT1DlkIIZlOac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GA9qMj1z; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-55790581457so2961104a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 05:27:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706534872; x=1707139672; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SvkwZXsYxPu3g0WrMtrLcpdJEvY5sTv7TKTF9i+RZnU=;
        b=GA9qMj1zKWFD+F6GmflzE6D61yGfApthHosbY2qFGas3qKTSgKMqZlynD6IVkT6Chx
         MlpnJtkQ080v31cdxGiqym285B0XwLwdGUjs46Dob2NYV5zJD+13eBGwoSL7+kyhordM
         gXMvRHs2aDoIy+jButX9PvXbyKWyB35YANFg2bcvmmgHnQkKpi6liNurl6LRqEUj+jdT
         pkMTmSDDbZgpsvmlMEA7TAbXUWpLYFxzQIKMvlWOuD2Lf7U2XfKJvkp/go74PfftQnDT
         ZI65u/923k7v443tw12R7p/boODWMQ1rzSrei8kXsa+IC7cTQdPvYw7yrkQn69Sn7+zm
         V3cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706534872; x=1707139672;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SvkwZXsYxPu3g0WrMtrLcpdJEvY5sTv7TKTF9i+RZnU=;
        b=GOS8zJL7AGBUS5ZXIbrChG23UOD2ZNQftmIdl4tuCns6tzR9xLsFsnlCrUgj/DgXRC
         6wZMAvbN7h4jGClhdqVQHyYRYYSi6nni3cYqbvO/u7KdTf5lpaXMuru88hgO8VwNv/Vj
         wEW3eAPXoZ6nV2Lw4fzNt2g1u8nTn10FHTngfpOYfN7jxqmf63si6WoFGs7WQ3QSqjiH
         vIqIUsoE+9SUChSFQ8lJ7rvX5c3jYOywt/5HYKn2uVvbCejcU6sJWphGnsUDFOSVD5fo
         grkAWZU3Li+v8NpmjL5j9Wx1kkyQiM7ZBehQ8CD70ROqBUBcqR9WTo6fJpybfFOab+BX
         g4Gg==
X-Gm-Message-State: AOJu0YxT7T07PkCvq0qoKboyROS64t3WUJx0Grk2l8b2+hQCIucMxkLN
	YFbWWwwygQD6XCm8VgGNE4I06n2szaGK5PLVUc83xyAwskGSZQobY7RUtxl3IUE=
X-Google-Smtp-Source: AGHT+IFnx1q5hL4nHDdmXKFiDszwxY6FzyveSXwDW9rfgUz0h6+gSYZlzeffKj30ObxZrGj6146rIg==
X-Received: by 2002:a05:6402:1285:b0:55e:f71c:c47d with SMTP id w5-20020a056402128500b0055ef71cc47dmr1944387edv.25.1706534872147;
        Mon, 29 Jan 2024 05:27:52 -0800 (PST)
Received: from [192.168.2.107] ([79.115.63.202])
        by smtp.gmail.com with ESMTPSA id es19-20020a056402381300b0055cffd3fd32sm3773362edb.68.2024.01.29.05.27.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jan 2024 05:27:51 -0800 (PST)
Message-ID: <99babcb3-770d-487c-a297-beea2f6f8e9e@linaro.org>
Date: Mon, 29 Jan 2024 13:27:50 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] mtd: spi-nor: drop superfluous debug prints
Content-Language: en-US
To: Pratyush Yadav <pratyush@kernel.org>
Cc: michael@walle.cc, miquel.raynal@bootlin.com, richard@nod.at,
 jaimeliao@mxic.com.tw, linux-mtd@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20231215082138.16063-1-tudor.ambarus@linaro.org>
 <20231215082138.16063-5-tudor.ambarus@linaro.org>
 <120bf090-0c07-4971-a18a-a1b326f1b139@linaro.org>
 <mafs0v87cs238.fsf@kernel.org>
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <mafs0v87cs238.fsf@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 1/29/24 13:26, Pratyush Yadav wrote:
> On Fri, Dec 15 2023, Tudor Ambarus wrote:
> 
>> I missed to drop some unused variables. Will drop them if everything
>> else is fine.
>>
>> diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
>> index a708c3448809..92c992eb73d5 100644
>> --- a/drivers/mtd/spi-nor/core.c
>> +++ b/drivers/mtd/spi-nor/core.c
>> @@ -3492,9 +3492,7 @@ int spi_nor_scan(struct spi_nor *nor, const char
>> *name,
>>  {
>>         const struct flash_info *info;
>>         struct device *dev = nor->dev;
>> -       struct mtd_info *mtd = &nor->mtd;
>>         int ret;
>> -       int i;
>>
>>         ret = spi_nor_check(nor);
>>         if (ret)
> 
> 
> With these, 
> 
> Reviewed-by: Pratyush Yadav <pratyush@kernel.org>
> 
Hi, Pratyush,

All in these series were already applied, as I specified in a reply.
Please check patchwork for patches that are not yet handled.

Cheers,
ta


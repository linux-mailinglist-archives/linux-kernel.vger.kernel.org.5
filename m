Return-Path: <linux-kernel+bounces-81188-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A48698671CA
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 11:47:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C802295838
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 10:47:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E67D44F61C;
	Mon, 26 Feb 2024 10:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="N3JDcS45"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BEDD4EB43
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 10:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708944244; cv=none; b=TKOI9DkjZ9PPETGa8dpSlWuuBq8+LjgrG7NeW4se+2d+DUrmvieDmesNBlzLoChTdyquVOj6LJB+QZuJNE3rh4X5vEejTjPc+DPJBu1Aqe4MvwLV9SAQCDH/jhogCjk9wjRlBW6BaFXepQLde4IWeJpioT8vaI+ePNZQpE/7oQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708944244; c=relaxed/simple;
	bh=VtYX2AAclW+6PyEznVmEi56KktEN8DIyyWShUfMv2sQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cypFfDBvjTVB/NC2zzYRM3RR9O+TvPkTSoXAF+GlI6JuvhCB9+N8obpWDakEVEqmlfxSl3vdavezD15+/sIUbVmpLq5eIrN0TrPhvO65zi0z0XCAk4kbLE/HMozWouTcg1nus+5eQjKj15+qIIx6h7PT9phY2NyaP6/MqFPnkq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=N3JDcS45; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-564372fb762so4188179a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 02:44:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708944241; x=1709549041; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/1u96TCZGh+uaR4bi6Ag7KK+CWFlrG+NLarSYTmkM2k=;
        b=N3JDcS45ILSNv/FoRVwj2M44aSAvWOIcJbv3ZxhcaIBjYsOuha9ir8Qvqw5GAydnPD
         ta5X9+PTkqWMESjEoK1wk9E15sGEglS2dPaMcuB5OBtGrZW3BWJNnv7aS+VFMrEGi3jg
         XNH1PKfnKoxl94ZDgydGNM2n+gU9aFq9/Qq5n1TRN1xqwKKaqIw14PJVAxtPO6UfY6jx
         Gsj/Tqt9GSOFUZWFqzvYntvJY7eshIZuOydqJST3cWNIL7K2wLoQfycpBXVaxSN2nrfe
         GkLTKiPfzqTq1Hj6lsMFR4rE72nKfp/X5omdDcr09aaiQRjTj2nu9DGA0GV3KIZTCDwr
         gIiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708944241; x=1709549041;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/1u96TCZGh+uaR4bi6Ag7KK+CWFlrG+NLarSYTmkM2k=;
        b=QZr6p35f6QPYFwPY9cbLU45xvhIWyzt8DwNvSa3KitHcZdPHx8XeWxMQPi/Qng3HEs
         ZEit5i5eZRcasvfQ4VglZqjY9r/zbdiZQSpfJgcU48vKnGLiji4NnYMoN3c+rykZPckK
         XoRDMhRItKB5sRT30sOo0onZWnqJgO2Ex5xmGiZCoB/hJZqczvAvDUFGIgiyV9EFR25f
         QZVCDy0B9vMivBPcRATC/QY+xkKq0am6uXOJXBtM8geaEMc9NX6YiVsFemUORROYpSX+
         3EsUVeneKprcjBqTomrm3J9e+QDyQHud+5GtLMTy7FIDJZZT8OA38b7Rhi+7u3dvt7TM
         Hi8g==
X-Forwarded-Encrypted: i=1; AJvYcCUedFmwyWfcJHLgneuOm/iIhhbVOQftKmomAYJ4BdtHWYzvcPVCetpgj3YGJih3dYfWUKI+mLEuC8vpsGkSU2cafKiCgdElQcvV9FI0
X-Gm-Message-State: AOJu0YyvxbEIFMnd8Zwzv+XYfhM8+hPrM1Ak33L2fphe0TvEJ56EBW7o
	Z/UjvZuL8MiikUsCT0uqt4rOlCplZIEd9I3Igx1QPJEK8SNN0A55lMqHtEHluFqk080rpJIYxe0
	K
X-Google-Smtp-Source: AGHT+IFXQa+vLT3VSAjwilZdTzIVK0TdFefSAdZBFz9SZ+bVKQh5rMYDuB0XwPGEMcDzdkmxULENgA==
X-Received: by 2002:a05:6402:35ca:b0:565:ba2f:85d7 with SMTP id z10-20020a05640235ca00b00565ba2f85d7mr3967435edc.37.1708944240891;
        Mon, 26 Feb 2024 02:44:00 -0800 (PST)
Received: from [192.168.0.173] ([79.115.63.202])
        by smtp.gmail.com with ESMTPSA id z18-20020aa7c652000000b005657eefa8e9sm2192416edr.4.2024.02.26.02.43.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Feb 2024 02:44:00 -0800 (PST)
Message-ID: <33c0c516-1f5f-4cf5-bd3b-70b61372a53c@linaro.org>
Date: Mon, 26 Feb 2024 12:43:58 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mtd: spi-nor: Add Puya Semiconductor chips driver
Content-Language: en-US
To: Dmitry Dunaev <dunaev@tecon.ru>
Cc: dunaich@mail.ru, Pratyush Yadav <pratyush@kernel.org>,
 Michael Walle <mwalle@kernel.org>, Miquel Raynal
 <miquel.raynal@bootlin.com>, Richard Weinberger <richard@nod.at>,
 Vignesh Raghavendra <vigneshr@ti.com>, linux-kernel@vger.kernel.org,
 linux-mtd@lists.infradead.org
References: <9ebf9cdf-eeba-417a-8410-3f87a0973136@linaro.org>
 <20240226104101.1848855-1-dunaev@tecon.ru>
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <20240226104101.1848855-1-dunaev@tecon.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 26.02.2024 12:40, Dmitry Dunaev wrote:
> Add a SPI NOR manufacturer driver for Puya Semiconductor chips
> 
> Signed-off-by: Dmitry Dunaev <dunaev@tecon.ru>
> ---
>  drivers/mtd/spi-nor/Makefile |  1 +
>  drivers/mtd/spi-nor/core.c   |  1 +
>  drivers/mtd/spi-nor/core.h   |  1 +
>  drivers/mtd/spi-nor/puya.c   | 64 ++++++++++++++++++++++++++++++++++++
>  4 files changed, 67 insertions(+)
>  create mode 100644 drivers/mtd/spi-nor/puya.c

what changed in v2? why do you need these entries? Can you rely instead
on SFDP to initialize these flashes?

Please read: https://docs.kernel.org/driver-api/mtd/spi-nor.html


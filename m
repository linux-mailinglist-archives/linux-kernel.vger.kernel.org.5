Return-Path: <linux-kernel+bounces-146237-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FD8C8A628D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 06:47:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E7647B21D40
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 04:47:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D265374F5;
	Tue, 16 Apr 2024 04:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="p3mc4QE0"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DA253D7A
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 04:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713242840; cv=none; b=Febq5iCrx6Uet0FvSE3ODn3wZ5vM2B+pKzQk8BmWOKtTpSwTE6zTtDZggz0yk8Su8kmk34TXx51D+0046rGyAgJrmy1dPf16QExgnfOqYTz/EZafnABDUCVoaRJiPo5+9hhzpgoW0i20LWFdMBr6IDTRNEMBh/LcUT5Xq/nI6e4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713242840; c=relaxed/simple;
	bh=pq6+KxXdnZ6lULKgyQb6g97pvfmc0oQwsASqEYqlSIQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L1f5g2g4QN9FDyPeFLkqujgGeWMCvYtuezOiBwK/f2zaYsjNg6I2sGzqfIWC8IUp8oeYIFHNCh3SVq0uFWXiY3SZWtrCoB2mZGK/9f6o5ZspGTUR7vPlweVc5/iueTOJYH9t57uYO7qbHWUQaMvZWGrkd6/gWqRyZORgpxR4z4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=p3mc4QE0; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4185e80adfbso8786755e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 21:47:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713242835; x=1713847635; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0w0mf2HuAmek3bCovjiGQQ6gYiZiYEwkgAq9bMWHoBs=;
        b=p3mc4QE0AEndLsc0cRXWE0YBGwad0DA5nmWbOeytjOxcaarPdcdLSaCFbsTvvM/6+t
         BfHVaV/z8SVpE1hVLuNFaT5J1xvKFQ4W4AxewZrH9yq+YdWaSkJn32Nr+KtoQVAoWzYr
         ctDRMJ31upclrH/83rjIcSvIJlIQgs4bmz0zSSUZSVy9AW0gyXJRHeYDmyDCFFSDq5H0
         Oh1LkAi2zZcPk27KecMD+J1lSvkj+6cnU13NeSnEW/qLENNAeis1Y3baVNkIfkqBBV0M
         MDXj8yscm2puRFE7qhvYgHOrbokU+ooSOYhmixBiph6ugX/aUjegv0/MmNKCb6axd6nI
         3Ctg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713242835; x=1713847635;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0w0mf2HuAmek3bCovjiGQQ6gYiZiYEwkgAq9bMWHoBs=;
        b=rnIlrwmJdBEl9BqqMSOLQOGIK8Rz8J0wzWmAxMMNA2rVj5qaWaC0jSMXje/SArgNU2
         bUgHdbKUZzDluoKOf1/QMbAKKt68BjuCFvcg9RIxba3Ij3HQ1iI9eRg36IxcR/koTxND
         hiuH83Etv05qfNj5JDTMeDQVnuAX9IYS/MySAo64GSyGnyrE6EZMH7KVyn3lXHKpa6fU
         JsNUlatEjPNKRLdTVuEcRtkHnPVTxIM5ZpxdgkQDvG8ddxLg3bwQLkgIdNxUYJXJlhlG
         cEwnvl2OfKK1K4c2hobOmT14+xA4GIIWzoYCQfSfETUrwvzNFV4lRGesIejs9xlc7OvM
         4P5Q==
X-Gm-Message-State: AOJu0YxwTMa6PDwPcmf2p7yzGM+REbSLS8y1NOElykkPs7S/mA3Rlc+1
	A4SnLEGCyQdRtEV+1TaF1JvHsU4ebaEdgL8+nUXwZtHjE87Y+Ze81g/pK8mKr6U=
X-Google-Smtp-Source: AGHT+IFTJnCHKKst1QLHRIOiskMT6H9/QReA1U6iXuuZ7myHNQ1vA0TtGoj7popqPST4uGN8uz9oFA==
X-Received: by 2002:a05:600c:5246:b0:417:f6ce:3353 with SMTP id fc6-20020a05600c524600b00417f6ce3353mr8047829wmb.11.1713242835539;
        Mon, 15 Apr 2024 21:47:15 -0700 (PDT)
Received: from [192.168.2.107] ([79.115.63.35])
        by smtp.gmail.com with ESMTPSA id e22-20020a05600c4e5600b00418980a1ce5sm527668wmq.7.2024.04.15.21.47.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Apr 2024 21:47:15 -0700 (PDT)
Message-ID: <33e8e9c1-9b96-4b46-ac63-2827924ccf83@linaro.org>
Date: Tue, 16 Apr 2024 05:47:13 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 3/6] mtd: spi-nor: get rid of SPI_NOR_NO_FR
To: Michael Walle <mwalle@kernel.org>, Pratyush Yadav <pratyush@kernel.org>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>
Cc: linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org
References: <20240412134405.381832-1-mwalle@kernel.org>
 <20240412134405.381832-4-mwalle@kernel.org>
 <14726a74-d54a-432d-a547-3b07ac97d413@linaro.org>
 <D0I77YRZ2H9K.3P77J7WK3UTZ7@kernel.org>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <D0I77YRZ2H9K.3P77J7WK3UTZ7@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 4/12/24 15:03, Michael Walle wrote:
> On Fri Apr 12, 2024 at 4:00 PM CEST, Tudor Ambarus wrote:
>>
>>
>> On 4/12/24 14:44, Michael Walle wrote:
>>> The evervision FRAM devices are the only user of the NO_FR flag. Drop
>>> the global flag and instead use a manufacturer fixup for the evervision
>>> flashes to drop the fast read support.
>>>
>>
>> Don't we want to get rid of FRAMs from SPI NOR? Why the dance then?
> 
> Yes, but it isn't that easy. There are (three?) in-tree users of
> these chips. But we can already move all the special handling out of
> the core.
> 

Okay.


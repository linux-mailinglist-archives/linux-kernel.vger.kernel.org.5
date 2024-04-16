Return-Path: <linux-kernel+bounces-146246-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 47EBD8A62AF
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 06:57:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A5E11C21612
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 04:57:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BA9B38398;
	Tue, 16 Apr 2024 04:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IJMigXMA"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5206112E4A
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 04:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713243461; cv=none; b=Ao/Jm5mNq8Hb0NiokKylCYZILWlMOX682/8Ly3d0j+dzCIB8nu60gpKZaMJCHhKrtiJdqetQMVsFouVLjqmmrVy68T1htr6mVSlfDRso6F77yQkqmtTSo3rF7Xhq8QjmmavT8hT84Fs/705C3TXHF7q3pRKkjfJhAzZrdb4O2Lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713243461; c=relaxed/simple;
	bh=eHEubp2pM27weVDG+5tED9zmtDAbA49s8d3tETqGATc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XsdRVXUZ/7BYb21lX6AkYok210QlW868DuOoBsKIr2e8FYTxT5bD1M8VhvO1XPwwNPJStkia30ON+CJi9eil+x71mYlIAb1Rgndphe+D8Nxg+6yJkopElE6MbeTsz4xcSInHbXFUxUhSLzhacgBxVSMHaDqDEWdPQ9Pve3MbtrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IJMigXMA; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-41868bb71cfso9583115e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 21:57:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713243458; x=1713848258; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FKf7jBhUirQYlTsd+b9tpcozNIHw30ci6LPBNVRTPuE=;
        b=IJMigXMA+EoGPOYT22sKov90oBF9pIrTRSLuzWzLqdU/yqgDQwtL+u0vnNNm8K9dKi
         hZGlmtYk4wjCxZFLcTGJKEpCukRzd/podDcCgjbnYeuJONKNPs/WYrbtqClQXuH+Q3Je
         fk8Yjtqw19UPc8y/qgo8hpnicKRw1iSpIRdoj9Wwt0DQmi3US9Vv+nvAKN4650TbgOVe
         81EQzGLk8R6zv3tH28YteVp/k3KIu5byfdi6W5bRclsrMOzW3ShHKdlQ9qNPRrg7bpgE
         GUsw49Iqyg0//PB1diFIGA6m4FEf9c1p1tKQWj5Jcrx+qIBNv+HPYzeXifCYdRpynu5Q
         zwVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713243458; x=1713848258;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FKf7jBhUirQYlTsd+b9tpcozNIHw30ci6LPBNVRTPuE=;
        b=n8TvjFO8jylAoAEWwr4eS+tnXlurkhVQK7muZtXpGAd6aEIIF3c8KQvdSuCiCoSOme
         Twh9E99czXLX0HJFDgAiuVux8yqi459QA+MEU8CdbyJ9EZ2BQfBnXVNnK5WdTdqFLusj
         N/zRTV7VSMubZzd1Ve8DPK1LVQFbvPd/+P0P7UxhxAEKbAS0+9dNXJCgO+GjacfHTRRj
         BhUJafmOeWXvvAnvLgiMMw0MaECN9PDy6tn2B3P1yChgZuxhGMPYPVs7WW8OId4ydlDP
         QnvU+GaIpfId19+aD4pu4XBV9nuWwmWIJE8EwNGkhU7P/Rm4bncwwdj+PmaUeuHe1oc5
         3znA==
X-Gm-Message-State: AOJu0Yzy9F+sPEm3RnxlGFUbf4qYHGEaQUEbsGw/5Ro2lS1hnC5mgvlK
	faYjtm8zeKnu6XGZ7Juf5BF7SvwZVlcmBlEIZ0kRAUMRAvaV9kiatW6xUsbEl4k=
X-Google-Smtp-Source: AGHT+IEimEGKanlvIXAf6pC6ObVJrD2LXGIAD4NVVF1wHKiIECkDGKYQ8KGqlw77z70BQSNvGoABIA==
X-Received: by 2002:a05:600c:a44:b0:416:a8b8:a8a7 with SMTP id c4-20020a05600c0a4400b00416a8b8a8a7mr7982322wmq.40.1713243458574;
        Mon, 15 Apr 2024 21:57:38 -0700 (PDT)
Received: from [192.168.2.107] ([79.115.63.35])
        by smtp.gmail.com with ESMTPSA id bg25-20020a05600c3c9900b004162d06768bsm21961569wmb.21.2024.04.15.21.57.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Apr 2024 21:57:38 -0700 (PDT)
Message-ID: <f07afa83-1c37-49da-923f-2ea9550e7163@linaro.org>
Date: Tue, 16 Apr 2024 05:57:36 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 0/6] mtd: spi-nor: spring cleaning
To: Michael Walle <mwalle@kernel.org>, Pratyush Yadav <pratyush@kernel.org>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>
Cc: linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org
References: <20240412134405.381832-1-mwalle@kernel.org>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <20240412134405.381832-1-mwalle@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 4/12/24 14:43, Michael Walle wrote:
> It's time for some spring cleaning. Remove the oddball xilinx
> flashes with non-power-of-2 page sizes.
> Remove the .setup() callback, only the default callback is ever
> used and it is unlikely there is need for a custom setup.
> 
> Finally, the last patch is a proposal how to deprecate flashes,
> which are just detected by their id. We cannot really find out if
> there are boards out there which are using a particular flash. Thus,
> as a first step, we can print a warning during kernel startup. As a
> second step we might introduce a kernel config option to actually
> disable the flashes which has the deprecated flag.


How many FRAMs/MRAMs are in SPI NOR? Can you list them please? I don't
remember anyone bringing topics about everspin and the cypress thingy
was a mistake. I'd like to get an idea whether it's fine to remove the
FRAM/MRAM from SPI NOR without doing these preparation steps and waiting
for another year.


Return-Path: <linux-kernel+bounces-161836-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 03F268B5206
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 09:10:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4F0BBB2146C
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 07:10:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF5AF13AE2;
	Mon, 29 Apr 2024 07:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LY9EyzqS"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2759134A0;
	Mon, 29 Apr 2024 07:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714374640; cv=none; b=JaqkHwxNoWTGRHIKcyq39z5ihXz8xFBJabUV7tPuAJbW5RWUD+XgorovkGZjFd7R5kvrko/ar6VXL89LnY1RAM5vpBGtSFQgkIUaUVIIfdmUuReG9xKRXfDfY+vovd87mNNX0tzOe15DJ/D3rPRSgYKLFKwucv1eIEUwf90bHv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714374640; c=relaxed/simple;
	bh=u4RpuH47LCq8+OKqkijooorm9I+Cq42DccMjOsHgWJo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mGC3ffyF4B2LXVcPh+jK2ZGlQxyXTnpF445i2LM0ZCYl94o2hcVli/VjPCl+86icwWYbAqH6eQfyvD7aD1qd9rJZ71+XFdDQx7iv1ukexFH3cef1lj3QLsE1GwBfdIERfKNEFGPQ+I82ETGw6EiNBlcsJ/YwI+tuwb6pwi3f7BI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LY9EyzqS; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1e2b137d666so31468905ad.2;
        Mon, 29 Apr 2024 00:10:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714374638; x=1714979438; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6ezNGmgXtmN/d5QQIznl5zIrhQk/v8pmvi9ftsZ0N98=;
        b=LY9EyzqSZrOSb8FtxwnWlmDwIStHPJwII4rCneOMRmHYberz3eAHot0iYqGC8mEqh0
         dJHk3WVzzT9u9RWD9g0wjg+XiLNU2sBH5XatOtQq/jYbQ4szQ1W7NAxdGTcbhgacaB6+
         jbEkGoXwuQwvauiArgwxXHrsM84OxA8ug2vr8I1KU0CEHZWR5zlnRfli6MbXMShKNfeU
         zjFtw8JrXDvHAoJ5ftAvp13FVxc5MpcckCULpcFldg1h1BMsuK29rQyyfDUxnuPVWwCm
         Jx+vDDTBHL5dPDQK0+u8c7ygm+BFegToCr+ypjZjQtdheRIL3u7Vdj+ELjT+j7m/uupx
         hmnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714374638; x=1714979438;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6ezNGmgXtmN/d5QQIznl5zIrhQk/v8pmvi9ftsZ0N98=;
        b=rfs4xLoO0A9VjgGNlwAbV2Wq9k6s3812KwA+G0yFeYEzpupPrJOAJN5rdptbEbDoZB
         ZM6xz1l0toSChPA7xKjDdJ8cb/QBRp10RIn0ukgZAYi/MPfJHmqQEiILjrm+asjgbrDh
         t58Yy75sf9p8/RuF6TsnLzgvSuOC+3wvi9OyU/5ppG7Fq+r0rPOLJQHEGIg6TtPVLSyH
         VhjkfnKzPUWE9Eq0lFOroX+ufD1EUc5UEo++9CkRmEYAKAoackuIll68pVHXg6fKRXMu
         IBNGrYgAR/i0K5th5t+Cs9zyI9qwrayfrNsjB8qGhpV1wcmQEwCm9z6jed3PoJ0cayw4
         759A==
X-Forwarded-Encrypted: i=1; AJvYcCXVNRFAPYepb8MTBFBgBNgDac8Jt3wDpTjQedG0BxNVYOFyyUCyOzkFmhoIqoNeK17ZhWkWcDUokYaBQxUKBlV1a/4A4z22QKmVlpGvDWRJ8alxHqqSmQ63m/tmEI4Nd33/D+hQVUge69KPTVUb6ogBgXOGuL95SRgZOuy6/lUfU9+tBQ==
X-Gm-Message-State: AOJu0YySJYTutRokwUZYoiKwyYWDIP/Ni6v0yooNvy3nPHjXMKh/CGRT
	g2+XHjMO1Lw+z10JljWkfrgeDvy99xtacRb6mtaTtUGNHIpP0nHy3MS6rF40
X-Google-Smtp-Source: AGHT+IGZzv0nK/Ap+onynsI5bN80EXBIn8pYwFdVCFbTCUWgtG4x9ojg6OcZwUwaJZNiNQm8wLn4Jg==
X-Received: by 2002:a17:902:e5cd:b0:1e8:6614:51cc with SMTP id u13-20020a170902e5cd00b001e8661451ccmr11367971plf.5.1714374637938;
        Mon, 29 Apr 2024 00:10:37 -0700 (PDT)
Received: from five231003 ([2409:40f0:3004:21d1:ce46:748f:4353:8a5d])
        by smtp.gmail.com with ESMTPSA id ku13-20020a170903288d00b001e403970ec0sm19500551plb.277.2024.04.29.00.10.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 00:10:37 -0700 (PDT)
Date: Mon, 29 Apr 2024 12:40:31 +0530
From: Kousik Sanagavarapu <five231003@gmail.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Shuah Khan <skhan@linuxfoundation.org>,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>
Subject: Re: [RFC PATCH] spi: dt-bindings: ti,qspi: convert to dtschema
Message-ID: <Zi9H5371PrJtIKVy@five231003>
References: <20240428070258.4121-1-five231003@gmail.com>
 <59fe75b6-a4a4-4c90-a3c4-c8a4b539e879@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <59fe75b6-a4a4-4c90-a3c4-c8a4b539e879@kernel.org>

On Mon, Apr 29, 2024 at 07:07:38AM +0200, Krzysztof Kozlowski wrote:
> On 28/04/2024 08:58, Kousik Sanagavarapu wrote:
> > Convert txt binding of TI's qspi controller (found on their omap SoCs) to
> > dtschema to allow for validation.

[...]

> > +  spi-max-frequency:
> > +    description: Maximum SPI clocking speed of the controller in Hz.
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> 
> 
> Are you sure that's actually needed? That's not a property of controller.

[...]

> > +        num-cs = <4>;
> > +        spi-max-frequency = <48000000>;
> 
> Drop. Are you sure driver parses it?

The driver does parse it though.  Looking at
drivers/spi/spi-ti-qspi.c::ti_qspi_probe(),

	if (!of_property_read_u32(np, "spi-max-frequency", &max_freq))
		host->max_speed_hz = max_freq;

So I included it in the dtschema as well.  Please let me know if
including it in the dtschema in this case is wrong.

Thanks


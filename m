Return-Path: <linux-kernel+bounces-90455-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE96886FF64
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 11:47:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 791CB281342
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 10:47:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FC0D374C9;
	Mon,  4 Mar 2024 10:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ms94XLj3"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 364F0364C8
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 10:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709549221; cv=none; b=VFTpi14fIRehGymfWiNuHdcrUvRhJ9JJVzOFkdT6c/OGUECeeq7Ry5G+jEiWSbEb3VVcjmMHIEKJGilBUqsZNJjJaL50LE1d63u1+iqPdWSmAYj5WRvxX90c3PNVjQBE41bNeCcUKA9BuhxrEZxfdMhedQJ2CNFCzsBZ1tcmTe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709549221; c=relaxed/simple;
	bh=ztqxNc62ilEiiomZuQZyglakJvz8sfZEaKzsNmup5ao=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gijggdKOcX8zMBhx3ksT5krM9M7yTMhCsdgotyh9qZm39ZnDQ96XsHlgqxwgN/zpnhJXMzeL8J5HINWRruH/lefjRUkDGiOuwjwwwDfMVV0fKpR8s/j/5w+N8L1rBs/RpiAwWdxgnxy/3PlLbL8CAg3N+oKYEASWu4oE1pMSskE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ms94XLj3; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-412e784060cso1848775e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2024 02:46:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709549218; x=1710154018; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ztqxNc62ilEiiomZuQZyglakJvz8sfZEaKzsNmup5ao=;
        b=ms94XLj3+eNTnxnGxOFScwCjm5FoZ7WZ8qoFpr177uVUQRxIYpu9qZ9o+X8AcfpFo4
         9ERoa5PrO/PiDCWlbdT/dvUUeaw7MQau0TtVj20sULZXlrt36NIpiclxwxDQmKyJbzuc
         RVWCci+YlgkVmI8eU+nIJ5cuIVxu9l6hC/GVZMH1k0m4mbWyVtwgoCPYr44VtF8i6Xmq
         kKgNwI8+A2TOFwvHV7Q7KQ8VWK8VokS9aG7AdWVFRkxGDtSLpXSwGfqeaSQRdIHg3Ytr
         JH+xvnI86fmM/STrbrCMFn+Mnc6uSk4S8S32UdvUKQaj8JG3IcLLaW24nZveo6PJiUzZ
         wAdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709549218; x=1710154018;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ztqxNc62ilEiiomZuQZyglakJvz8sfZEaKzsNmup5ao=;
        b=L+hvbA9loL/UrEu7jWnXpf9Rjd4EEOL47V4BuY83iHlk4bIGcB53ECbTOPs84Dyt76
         SViIwP+VJ/lWYglQneIRRCAr4p811FBu7+VwMTHKHEgQewevw1TfQpr9fwa/JW/B7y0H
         iqHhBCNBgi42a0HKrF9iLlId6YenN5hdqUgl0nDSHg5QPu5mS9GBSSm424GNIJ3wgmCL
         6VKJmkBmWKH0hbhSTB3QUEYsmpOi7uhRaurncN9aOXYF+jOOHqqHpk1MClgHmai7wLzR
         hOo88BvwP0szVt7FiarrJxHRHJ4vcEMuwcANFtzxF1QhPc/t2qRFHNFSfFfVKGSf9VfK
         i1oQ==
X-Forwarded-Encrypted: i=1; AJvYcCWmDXRFfx4HBpRHt8nU5g1kF0BKxhT55wYifRpSRefojldJKeTGYEJIwFkyqY4b0/agcVNgHjz3n+ugMcS9lIpNcp11O8ZNgJAiUCG1
X-Gm-Message-State: AOJu0Yz5E73EEVavHb5vL3jtC1ZTFcMseIo7fXXHX6IzD0C7HsWANUyM
	rxS/z58EE7THb8fBCrBuE9Jgzv/Picd7EWYofz7zUmHvXJh2cLj7WGGTY9ceKEk=
X-Google-Smtp-Source: AGHT+IFeyTWKk1LmAT0UNG56sujX19bae73Htg+PyrowHL0edmjBLVd20DjVb8TWcjVE0m0Xy+Q76w==
X-Received: by 2002:a05:6000:1cce:b0:33d:d7c7:4c33 with SMTP id bf14-20020a0560001cce00b0033dd7c74c33mr7776162wrb.29.1709549218568;
        Mon, 04 Mar 2024 02:46:58 -0800 (PST)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id ch14-20020a5d5d0e000000b0033e18421618sm10161297wrb.17.2024.03.04.02.46.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 02:46:58 -0800 (PST)
Date: Mon, 4 Mar 2024 10:46:56 +0000
From: Daniel Thompson <daniel.thompson@linaro.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Lee Jones <lee@kernel.org>, Jingoo Han <jingoohan1@gmail.com>,
	Helge Deller <deller@gmx.de>, dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/7] backlight: lm3630a_bl: Simplify probe return on gpio
 request error
Message-ID: <20240304104656.GF102563@aspen.lan>
References: <20240304-backlight-probe-v1-0-e5f57d0df6e6@linaro.org>
 <20240304-backlight-probe-v1-6-e5f57d0df6e6@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240304-backlight-probe-v1-6-e5f57d0df6e6@linaro.org>

On Mon, Mar 04, 2024 at 11:11:43AM +0100, Krzysztof Kozlowski wrote:
> Code can be simpler: return directly when devm_gpiod_get_optional()
> failed.
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>


Daniel.


Return-Path: <linux-kernel+bounces-66429-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E4F48855CB3
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 09:42:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 53F23B30A17
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 08:36:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25246134CC;
	Thu, 15 Feb 2024 08:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zbCC2qYp"
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04AAE17588
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 08:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707986166; cv=none; b=InTuJRAKmXw9VHUwFud1UdPpVPT9Cqc+FnEwEoOEORkkOm89ycK8vf9aaF0UNSV2aTjxb7Xnf9GUAH7dW5sObna4nBJxAI1pdLFboVzzF+YUWCi3/Z9C1iizGFeoDcDtMcsyCw3M4DrKQWdvcy441sKCCI5VVnuowQ1CWyVmR3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707986166; c=relaxed/simple;
	bh=dVl6YlSs3JgV3u7K585QimDIjB3ji6V21PoR57kjwq8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Iwasp/yjhzHCJBbsDy94de8RF9xNyeSuddXwATuyw40S97oNb9aJBMmOlW5vHQMgJ3lCwDzCPP9HelytnOY5WjZr51p0SNr9L5SSjAZwfywmyUBmewV9Hj1c5HSHB/ZB4BfwFsne/5Bi/jKfl6hsviKqBb+KduVFTtjy8zaoihU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zbCC2qYp; arc=none smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-3c0449eaadaso650891b6e.1
        for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 00:36:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707986164; x=1708590964; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZX22jKQSQzfOIXrO+WssbUgNKrO4mtw6rLzytRgzYnM=;
        b=zbCC2qYp/cwPoToIOlcFAjPN0GEInTWc3EpgUfeEaloaSc2zbdDYslvvjrmfcI2LEB
         EwUXjAcBYAi4M0EGvH5vvyjN9xt4yxLsfvcv7Orn4CznfPmddBa4F8ezc49VYwlj1BcQ
         b0ejbZaGpLY/+fdiZS3u4oJOxValITXaWslydq0k6I3IJKmQiQ1wH4ePLjL+EIRN3fwh
         LN9RFbjrfGPUkiNV0Bu3nCVLv3iQjhQjQW9cFxF+nNtGb5HQQwrkpCIFtkAPO5FFq0fJ
         7cX5qRJobK+8IlSXkduaHr3MyaiAPipdNG4/86vKpPrcTjFpnkjtAVVrPyRq0mn8XDaq
         b5dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707986164; x=1708590964;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZX22jKQSQzfOIXrO+WssbUgNKrO4mtw6rLzytRgzYnM=;
        b=Cr7aaRyDDpXOSfbyRw7fVd9hgn4UNFzp0vQfjzkblcXMu06O76Yh+4FLYf0uX6h7wS
         Z2wajWx6oEIDTVj6VMUyL1ErVWZEgU3zpYv8PAxmEZHe22x85sv4kaEz/jNhbcOlIayN
         gJpQDbVPnCBHYjPydykMeoQLQd1npPKI7g9Un1bF1J1ivVb1Choa3vbJOG7dviP81/3P
         6n/fgOIn6/MLgMK/Rg8hONFIeRgJ48FKWp6yDwAeOU8sZue0leJe2eSRgyETM48iDpOQ
         ZEzNNP3l92xKebKosnDfRSfKBpctQjgNWeLSABijCApKuTAE96TjOXTojxZkdxPzODUH
         wgcA==
X-Forwarded-Encrypted: i=1; AJvYcCWb+LYcBo5B36WNf8+eA7ZQYb3hrdECTdwDit2jV52HCBpawkLYFitYGZOHnKoC8jdq9zDHfc2PGRLZq2d6MLpuQ0Szvwlfx5nfNv8U
X-Gm-Message-State: AOJu0Yw6JflINKrrLBZuicfZspx/DwgjBFvyiSjIZ6L0P9+C/8y4ngNw
	K1szsWIcagY58QkRc9dpXuPsBNx4PzAF84WK2fXh3d0sTOCkQzogS6/GRTKUJa0=
X-Google-Smtp-Source: AGHT+IH99T1XgqxZMbgpzj43RCDAoPlw+3GxxAJ8pFZi95dsm4JfC64veAR30dqOnsf17QHoPx2yCg==
X-Received: by 2002:a05:6870:e393:b0:214:ca3c:54fc with SMTP id x19-20020a056870e39300b00214ca3c54fcmr1026258oad.20.1707986164142;
        Thu, 15 Feb 2024 00:36:04 -0800 (PST)
Received: from localhost ([122.172.83.95])
        by smtp.gmail.com with ESMTPSA id m189-20020a633fc6000000b005bdbe9a597fsm783521pga.57.2024.02.15.00.36.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Feb 2024 00:36:03 -0800 (PST)
Date: Thu, 15 Feb 2024 14:06:01 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Markus Schneider-Pargmann <msp@baylibre.com>,
	Rob Herring <robh+dt@kernel.org>, Viresh Kumar <vireshk@kernel.org>,
	Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Tero Kristo <kristo@kernel.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>, Andrew Davis <afd@ti.com>,
	Dhruva Gole <d-gole@ti.com>, linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/3] dt-bindings: cpufreq: Add nvmem-cells for chip
 information
Message-ID: <20240215083601.33dye7nypov2cz54@vireshk-i7>
References: <20240206145721.2418893-1-msp@baylibre.com>
 <20240206145721.2418893-2-msp@baylibre.com>
 <20240215072653.lscrdrmsges3psmc@vireshk-i7>
 <46645341-1484-42d8-8540-580b586e2315@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <46645341-1484-42d8-8540-580b586e2315@linaro.org>

On 15-02-24, 09:25, Krzysztof Kozlowski wrote:
> On 15/02/2024 08:26, Viresh Kumar wrote:
> > On 06-02-24, 15:57, Markus Schneider-Pargmann wrote:
> >> Add nvmem-cells to describe chip information like chipvariant and
> >> chipspeed. If nvmem-cells are used, the syscon property is not necessary
> >> anymore.
> >>
> >> Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
> >> Acked-by: Andrew Davis <afd@ti.com>
> > 
> > Rob,
> > 
> > Can you please review / Ack this one ?
> 
> Done now, although it is not aligned with DTS in this patchset, so this
> does not look tested...

I will wait for them to be fixed then.

-- 
viresh


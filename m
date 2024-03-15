Return-Path: <linux-kernel+bounces-104777-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3018A87D37A
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 19:20:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C606C1F222DF
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 18:20:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E69164F1F8;
	Fri, 15 Mar 2024 18:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="h2d7XwGx"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87A394DA1F
	for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 18:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710526813; cv=none; b=Cccd4dDtSpJ8R3tCgxUmJ48/MokSlaEOIgh/B8tsaWmDSxs5GW/G4yUUYJPFF4WsSEUVj/E2jTQxwzqnHPSRnFJUMwXhHxdyONhGRTf2CcmVfmCWLJO0sMBdLtrK1apiMzzcyjeyIrRctgZE8NNZfnCN6k6Oj7ZPhqjjhz7s9g4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710526813; c=relaxed/simple;
	bh=L7cy8ipUkDx7KmlC8r7MwrGmXHewBTDD5LGXkBR5uVk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BpSq8HvzXZsn5PHPUNoD9ll2c1G0ezqLJxzos2zrQJwAK7sDkxvN10XqvMrjLawlA2j8RnKFl33uHvIq+TwGjXcOGoiE+FKgC7ew0Ujr7b1Gz8XRpq+rQgA8zhzr8AFUFzQUfkqZ9qyCMwhfvnMm0iaNT81UDll5iMZJe9bQN/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=h2d7XwGx; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-413fea12b07so8625895e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 11:20:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710526810; x=1711131610; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4gczFt4/ANkeuztDhpAozYDqwLiBHng72KTDamm/8x0=;
        b=h2d7XwGxLVP17Av66f1wYMFOHmNCybbuF0dSAb1YlElwf904zwc2IR4ox+UBE/41ln
         LDButNaf/pJrN4z7jWAvnytDlw0VLhj43wI32vF5j42OP4b8RGEdPc1iy6JUuG97+KFW
         l/59oeUr+IPGQdC6Cu9oz6VBKJwAeX85l4X5IhOK8RBe5YUgAEqyiAZtmHuDsKUkd6G1
         Znr3UI6+2d+LSGCO2k5eE7ggjLQihV9NMozJUUJmjYSGEJMbXSMxJmTPVyqwzFeNXuK7
         MAG3ySNh2q+qhTQ+AaXJWq/BfcDCmmJcNHJDfmrMuTsWhOKjqbgx5S2EQHe4uUMccbeq
         gdlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710526810; x=1711131610;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4gczFt4/ANkeuztDhpAozYDqwLiBHng72KTDamm/8x0=;
        b=BbCUnKEpoeCIxBKtX1Pletmvf0KUPkL1ae+/17ANSpqKJnXh7Xgw4B55OPenMd1OJT
         n2u7ibkfr6U6WbrVv2VnCxYlOIv1dSYbSqoUfc51p2lEe92cL6l1fM4UAaqazMQtalrE
         VlSluPdTAsdylyRI8rYypnPjT7GJ/O/vysbUWRPDfkd1k9/jrO3+bVDvw5eiSkNuY/fH
         8oJc/UBHzylLNG0jI0PpRUID01GpBfa8Z61IkOyVB4IC/WH0f7NW4AJoy5UgLcLVmFPE
         R8T9p4XKhBUVQH5/rWlYbIZQAM6jXpM2bWXydnJZwag77YbpxHbi1gBWEndoMdG6tJJd
         wLtg==
X-Forwarded-Encrypted: i=1; AJvYcCWhomO1V6OhHKP9COqOt8iX0m2e2EGV3OW9XTQO2V1j0+LQ5UhVKtvdmnKo4xF0w34rcv0etEOE8xBRNvaSYFM9B3VW/MwCebxDt3eh
X-Gm-Message-State: AOJu0Yzbhal9zwCSTCT3a7y/slozHhcpFJp+ELLJFRyN0sl41QZhdhyo
	6R2xreSCDG7aaEgOXih98MItYAQYLKczTxxSf0ZRe7kPjrVSIobJVJe4YmRpEok=
X-Google-Smtp-Source: AGHT+IFWS4FZMemlafQGX1s1VguV4PoMvo1YTeX7YHgn1fZGY99SKFf+IaNBBrHDW1qmgbaxF97uYQ==
X-Received: by 2002:a05:600c:3496:b0:414:2f:4ec3 with SMTP id a22-20020a05600c349600b00414002f4ec3mr2120588wmq.21.1710526809664;
        Fri, 15 Mar 2024 11:20:09 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id fb4-20020a05600c520400b00413e4ff2884sm9663205wmb.40.2024.03.15.11.20.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Mar 2024 11:20:08 -0700 (PDT)
Date: Fri, 15 Mar 2024 21:20:02 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Cristian Marussi <cristian.marussi@arm.com>
Cc: Peng Fan <peng.fan@nxp.com>, "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Oleksii Moisieiev <oleksii_moisieiev@epam.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	dl-linux-imx <linux-imx@nxp.com>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
	AKASHI Takahiro <takahiro.akashi@linaro.org>,
	Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v5 0/4] firmware: arm_scmi: Add SCMI v3.2 pincontrol
 protocol basic support
Message-ID: <e42e28ad-799d-4254-bf87-634bcd14c086@moroto.mountain>
References: <20240314-pinctrl-scmi-v5-0-b19576e557f2@nxp.com>
 <ZfMqWP-t39SCvkA2@pluto>
 <DU0PR04MB9417056FD84405898F1B007B88282@DU0PR04MB9417.eurprd04.prod.outlook.com>
 <ZfR89rdzRymY1Ovx@pluto>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZfR89rdzRymY1Ovx@pluto>

On Fri, Mar 15, 2024 at 04:53:10PM +0000, Cristian Marussi wrote:
> On Fri, Mar 15, 2024 at 12:31:51AM +0000, Peng Fan wrote:
> (and whatever you use to test on the backend server too, if you want
> to test this...)
> 

What are people using to test this, btw?

regards,
dan carpenter


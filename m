Return-Path: <linux-kernel+bounces-112636-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6237E887C54
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 11:45:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D69A1C20E38
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 10:45:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFECC17591;
	Sun, 24 Mar 2024 10:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="n887v36a"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DE7417583
	for <linux-kernel@vger.kernel.org>; Sun, 24 Mar 2024 10:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711277116; cv=none; b=KLeCj/7ohsQkiFXdfqC8BQaZAqtQ3127pabQP5BQagAa9mQUxTKSX7+q12LWb56VN7iNlE/TyIUgmsqgrzEqBXe1gddT0wFJE+9wof9G1safYsThKbeXKtDaCdPz5gf8FrKR9kARBul5i/9bNpKrry86ol3Euexd9ldozlvuZIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711277116; c=relaxed/simple;
	bh=sQckmXFITy4Xkbkc59BJtYFx0lkcS3ukS9NHkCGTGSs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JfVs245Y89DFfs5uMbLvTLk6PEWwfrOTJLNDgL0qTBwrqBNMHCxjJclDVnL3jB3H6HANwb+ifWIKVpN0MCxAGMySN9R4nJebbUaKBQYQuegRjGzCzq0XMVh4sqM4+6i+cZmW1FpuNPvOFtzdrtR4Afo48YnJlvxP5N7RxcFTbcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=n887v36a; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a46a7208eedso478941166b.0
        for <linux-kernel@vger.kernel.org>; Sun, 24 Mar 2024 03:45:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711277113; x=1711881913; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CWY24m2OMeavf9ZqUqvQSQdTD4THnN/BxwjI9GZeFo8=;
        b=n887v36aoMM9NxY2Dc4wrGGIvVnmsDggw7CQmw3wdRD1SkSXGXfww8ZhfYTdI4QCG+
         x9Rdk+FQ0hUw6ToYuJj12Gs4RKXBE596EDWdmLBBbpqnzpXTxQY6yIdm2ZDz/H1Ims2f
         BAkfmakJ0AjXCUwp4g8nhv95eZSFRNXCvpxGr9kwGl22Cj4YxmMcqYlHRXl9QePyB5j+
         HubheSDXz9hZlL37VfMe/n/5kPng8KWbiKRVSMAdbB2/eCxV9NgpyWstH3pzPGpATOMV
         8SP2WG2CSlmBXgMx4ZAjgtqGDSXw89D2JYs4JTpi9c+2FuhxffB3l1r/YaRUv37TTNZn
         X+ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711277113; x=1711881913;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CWY24m2OMeavf9ZqUqvQSQdTD4THnN/BxwjI9GZeFo8=;
        b=Egl3fmI5+ByslndkrRI0CRY5RqMKjzwVppl2sV8fTGdv2/NsRUkd+cVJrEyjz/1aTQ
         RfIlIBgYrM/LwA1ppMn1fAxzDcxwI5JqRHhBzXG76KcEGOvZMDtfHomI9++lUVxzv3KQ
         ZhulkoNIvjd95umioVgWxmRdGqgBHuVlAqLgt6FLg8XHGqctZOqj2qZjC2dUikvpapFw
         6w4o7ztpd4MXjttBt7JUC9PCB/T0jD+JBRXZllpYoAsxG5B69HHWy9vojHE1bQDwPdnS
         W8FSts2cqh/bvtqRz9EWXV+iONKiELDAQ5HjjEQYcpi1UqIEZihxwf5j2oNFl9jDZR45
         G+jg==
X-Forwarded-Encrypted: i=1; AJvYcCUm6rl9OfMTnF+l3T19EzBIRDCM2NhNNfWxQo5qrfeezV/dr+IRpEfpgdCvylKx1Bj/cELPot1QScL1BR4+OYQIitepI7+Qc8B4M42K
X-Gm-Message-State: AOJu0YyHz3An7p5J/EvZtfklt4B2GAyj6ztQQPO/G1UAW7ffsV0aq3jB
	LNlpFWU3gaZVk08jt0gqzYmA9Ve9zfhwi1qoIQgUjDuZ5hU6UHtGu3rMDMsXF0U=
X-Google-Smtp-Source: AGHT+IELgbvcq/YR2JYAdj3UMR62uFgEJo23GKSMx5QvCd5lojQP9akIksslHXLJQFzjzg27Z268bQ==
X-Received: by 2002:a17:906:a19:b0:a46:f955:3720 with SMTP id w25-20020a1709060a1900b00a46f9553720mr2593989ejf.51.1711277112766;
        Sun, 24 Mar 2024 03:45:12 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id ws9-20020a170907704900b00a46caa13e67sm1832993ejb.105.2024.03.24.03.45.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Mar 2024 03:45:12 -0700 (PDT)
Date: Sun, 24 Mar 2024 13:45:09 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>,
	Cristian Marussi <cristian.marussi@arm.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Oleksii Moisieiev <oleksii_moisieiev@epam.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	NXP Linux Team <linux-imx@nxp.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, linux-gpio@vger.kernel.org,
	AKASHI Takahiro <takahiro.akashi@linaro.org>,
	Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH v5 3/4] firmware: arm_scmi: Add SCMI v3.2 pincontrol
 protocol basic support
Message-ID: <b06ab1e3-c00a-444c-908f-0ac8ad4d95fc@moroto.mountain>
References: <20240314-pinctrl-scmi-v5-0-b19576e557f2@nxp.com>
 <20240314-pinctrl-scmi-v5-3-b19576e557f2@nxp.com>
 <7a4a8287-1f86-4ac4-acdf-c02339ba5e1e@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7a4a8287-1f86-4ac4-acdf-c02339ba5e1e@moroto.mountain>

On Thu, Mar 21, 2024 at 05:46:53PM +0300, Dan Carpenter wrote:
> On Thu, Mar 14, 2024 at 09:35:20PM +0800, Peng Fan (OSS) wrote:
> > +enum scmi_pinctrl_protocol_cmd {
> > +	PINCTRL_ATTRIBUTES = 0x3,
> > +	PINCTRL_LIST_ASSOCIATIONS = 0x4,
> > +	PINCTRL_CONFIG_GET = 0x5,
> > +	PINCTRL_CONFIG_SET = 0x6,
> > +	PINCTRL_FUNCTION_SELECT = 0x7,
> 
> PINCTRL_FUNCTION_SELECT was removed from the spec so the other cmds were
> renumbered.  I'm still going through and reviewing this file.  I'll
> hopefully be done tomorrow.
> 

I think the rest is okay.  It's just updating to the new version of the
spec.  CONFIG_GET/SET need to be updated and FUNCTION_SELECT gets
deleted.

regards,
dan carpenter



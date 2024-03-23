Return-Path: <linux-kernel+bounces-112201-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 751108876E3
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 04:28:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2FB7D282724
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 03:28:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B3774683;
	Sat, 23 Mar 2024 03:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B2TOZdTe"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B787372;
	Sat, 23 Mar 2024 03:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711164522; cv=none; b=D3PHfwHSNbX4dn1wOp2dWBLGswoaluE8M6g15hDD9r41Yy6Ht7fGpZYPaaz/rMu34hqST+kQuzH6LW5pCsFGPkE+y1w90B9GRtq8Whdi7HES7jJ/vIhE2PklIFrj0hreKhadUlD9aoudCaCnRe5Za3NljDwWC0OszINePxsQ84A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711164522; c=relaxed/simple;
	bh=zhqQACC7AJbP9u6ciXba1Z3lFT2VCFM9trdioji78Lw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GKozSJSqFB9KgWz6GtQRZWNW9Sk5eiATZLnuFtpCSzLLNVQnbdNmElHKRfeKnl98Pk6NXmdDzvHBit9GlfsKHjurs3YYnKmO8M59mLZje2OqfbC16YalvKfzgtFyoBr1zOW5byUhmrLhTwpc2vrx2wSzFmA9U02OU/AB4YfzDZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B2TOZdTe; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1def3340682so21129155ad.1;
        Fri, 22 Mar 2024 20:28:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711164521; x=1711769321; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=B2ncBvbMS4vbGFumZ6BXHmSb2tJYq6+mABDVyHl05Ts=;
        b=B2TOZdTeUbpan52K/SF6WCglf3SYelj6m/xIz//aH4nqQgwEx3COaDs3dx+h2HiDMm
         fhGOYU3XSlcAffPRAi7osyX4W20OQD4U9MrRlKyje+Q1jCL5FnoujKIDxl0lhBYuENCB
         X7bIipxv8jsdHPTW0z62igEybyvZjeu4+/Gv8Vi5iTXjIWBrzj4MHMlncXDNV2PVYvGh
         AE5p/zrGPA2nisAGnKIqPu0uFsor/1Ew6JDH2y168duOPpIGG0LPbHy0b4oplUjXVzfH
         4AlsGHG8ZrrCr9MjKen2Rw6bXaJb3qXeSaddDnlOoP5SFzKu3DGg09RoV0pELNF1UkFB
         C2aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711164521; x=1711769321;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B2ncBvbMS4vbGFumZ6BXHmSb2tJYq6+mABDVyHl05Ts=;
        b=g7s8/yRJdM+bt0i/VgPb7DwCp/8mrtgYe+XUsJ+TR2CEfWHEi8VrVB0n6W+p4YWbrE
         aaAnzce+Qym+p+htL2/LLJGKzZgnmX51EfCy9lBtj5JYIz+c+G4j6Zq5Qwmx+O9dLUXu
         dBC3/qW8dH+8K0ICo7U2gV4ImaW72d0/FU5CNglcbTtTlsU6RymNXje1bjx1RP0c2K2S
         OupLPvPFxZnGlQk011DBlJ6JfZ82O9pjlQKWcqWmLQiIikCBJibxEtPQH2UgWG9QO0Q5
         5Ts8bjJBgO3RgSB3lhzWXgnqwRTdgsUqXNT8xn0j905vk7Iclkpj7VF1YoZC3sLb2ETU
         wU8A==
X-Forwarded-Encrypted: i=1; AJvYcCXx/fc/m3XiWOJ6ELWZv5bdNXQwsCmqrcPmbLrSELfUQK/G+rgP9mXSNcNfpg5vVshCU1vZdQfpl9F+zu2HRoepzYd1ttzkR+fYXfHwlt04S+16wVsy8NNmeECTcOoYWbm9TgcJG7goeS5u9piTYhBa3xpQLI2561Nfcq4jMpKWQjQLcA==
X-Gm-Message-State: AOJu0YzwpVoMl2oUhpWj8coz6stdGRd07YSTToK9ngNzRAVRv/RiDGH5
	KWWyEF+xm1XIKqIMfN9WLmRBCtAXQHtriwUdbI6DCCNUC2Y55ICJ
X-Google-Smtp-Source: AGHT+IEcYGB9slzaB5PnOZV2/ZgAW/UUAiEIgSyXcIbatjiUP4DDt+hYx2jczTKAXD1wYJDhKZFQHQ==
X-Received: by 2002:a17:902:e746:b0:1e0:30ca:61e with SMTP id p6-20020a170902e74600b001e030ca061emr2133895plf.5.1711164520649;
        Fri, 22 Mar 2024 20:28:40 -0700 (PDT)
Received: from localhost ([2804:30c:1618:ed00:d152:440c:102b:144e])
        by smtp.gmail.com with ESMTPSA id r2-20020a170902c60200b001e02d9c05d8sm526099plr.103.2024.03.22.20.28.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Mar 2024 20:28:39 -0700 (PDT)
Date: Sat, 23 Mar 2024 00:29:10 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: Rob Herring <robh@kernel.org>
Cc: Marcelo Schmitt <marcelo.schmitt@analog.com>,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	robh+dt@kernel.org, devicetree@vger.kernel.org, lars@metafoo.de,
	linux-iio@vger.kernel.org, jic23@kernel.org,
	Michael.Hennerich@analog.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: iio: adc: Add AD4000
Message-ID: <Zf5Mhm4KRQzu9qZs@debian-BULLSEYE-live-builder-AMD64>
References: <cover.1711131830.git.marcelo.schmitt@analog.com>
 <81665b5f0d37d593e6d299528de8d68da8574077.1711131830.git.marcelo.schmitt@analog.com>
 <171115011818.1710405.2845384923597786826.robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <171115011818.1710405.2845384923597786826.robh@kernel.org>

> My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
> on your patch (DT_CHECKER_FLAGS is new in v5.13):
> 
> yamllint warnings/errors:
> 
> dtschema/dtc warnings/errors:
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/iio/adc/adi,ad4000.example.dtb: adc@0: Unevaluated properties are not allowed ('#address-cells', '#size-cells' were unexpected)
> 	from schema $id: http://devicetree.org/schemas/iio/adc/adi,ad4000.yaml#
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/iio/adc/adi,ad4000.example.dtb: adc@0: Unevaluated properties are not allowed ('#address-cells', '#size-cells' were unexpected)
> 	from schema $id: http://devicetree.org/schemas/iio/adc/adi,ad4000.yaml#
> 

ok, adding proper #address-cells and #size-cells fixes the warning.

  '#address-cells':
    const: 1

  '#size-cells':
    const: 0

I'm assuming missing those in v1 doesn't hurt review so will wait for some
feedback before sending a v2.

> doc reference errors (make refcheckdocs):
> 
> See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/81665b5f0d37d593e6d299528de8d68da8574077.1711131830.git.marcelo.schmitt@analog.com
> 
> The base for the series is generally the latest rc1. A different dependency
> should be noted in *this* patch.
> 
> If you already ran 'make dt_binding_check' and didn't see the above
> error(s), then make sure 'yamllint' is installed and dt-schema is up to
> date:
> 
> pip3 install dtschema --upgrade
> 
> Please check and re-submit after running the above command yourself. Note
> that DT_SCHEMA_FILES can be set to your schema file to speed up checking
> your schema. However, it must be unset to test all examples with your schema.
> 

